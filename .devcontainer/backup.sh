#!/usr/bin/env bash

set -u
export GIT_TERMINAL_PROMPT=0

log() {
  printf '%s\n' "$*"
}

course_repo_url() {
  local url="${1,,}"
  url="${url%.git}"
  url="${url%/}"
  [[ "$url" == *"/bmabsout/bua-intro-python" || "$url" == *":bmabsout/bua-intro-python" ]]
}

remote_owner() {
  local url="${1,,}"
  url="${url%.git}"
  url="${url%/}"
  case "$url" in
    https://github.com/*/*|http://github.com/*/*)
      url="${url#*://github.com/}"
      printf '%s\n' "${url%%/*}"
      ;;
    git@github.com:*/*)
      url="${url#git@github.com:}"
      printf '%s\n' "${url%%/*}"
      ;;
    ssh://git@github.com/*/*)
      url="${url#ssh://git@github.com/}"
      printf '%s\n' "${url%%/*}"
      ;;
    *)
      return 1
      ;;
  esac
}

ensure_identity() {
  if ! git config --get user.email >/dev/null; then
    git config user.email "${GITHUB_USER}@users.noreply.github.com"
  fi
  if ! git config --get user.name >/dev/null; then
    git config user.name "${GITHUB_USER}"
  fi
}

ensure_student_remote() {
  local remote owner repo_name
  if ! remote=$(git remote get-url --push --all origin); then
    log "ERROR: Could not find the origin repository."
    return 1
  fi
  if [[ "$remote" == *$'\n'* ]]; then
    log "ERROR: Origin has multiple push URLs; automatic backup is disabled."
    return 1
  fi
  if ! owner=$(remote_owner "$remote"); then
    log "ERROR: Origin is not a GitHub repository."
    return 1
  fi
  if [[ "${owner,,}" == "${GITHUB_USER,,}" ]]; then
    if course_repo_url "$remote"; then
      log "ERROR: Refusing to back up into the course repository. Your files remain saved in this Codespace."
      return 1
    fi
    return 0
  fi

  if ! command -v gh >/dev/null 2>&1; then
    log "ERROR: Could not link your GitHub fork because GitHub CLI is unavailable."
    return 1
  fi
  log "Linking a fork on ${GITHUB_USER}'s GitHub account."
  if ! timeout 60 env GH_PROMPT_DISABLED=1 gh repo fork --clone=false --remote; then
    log "ERROR: Could not create or link your fork. Fork the course repository, then reopen this Codespace."
    return 1
  fi
  if ! remote=$(git remote get-url --push --all origin); then
    log "ERROR: Could not find the fork remote after linking."
    return 1
  fi
  if [[ "$remote" == *$'\n'* ]]; then
    log "ERROR: Origin has multiple push URLs after linking the fork."
    return 1
  fi
  if ! owner=$(remote_owner "$remote"); then
    log "ERROR: The fork remote is not a GitHub repository."
    return 1
  fi
  if [[ "${owner,,}" != "${GITHUB_USER,,}" ]] || course_repo_url "$remote"; then
    log "ERROR: Origin is not your fork. Automatic backup will not push."
    return 1
  fi
  repo_name="${remote##*/}"
  repo_name="${repo_name%.git}"
  log "Backup remote is ${owner}/${repo_name}."
}

sync_fork() {
  local branch="$1"
  if ! git fetch origin "$branch"; then
    log "WARNING: Could not fetch your fork. Continuing with the files already in this Codespace."
    return 0
  fi
  if [[ -n "$(git status --porcelain)" ]]; then
    return 0
  fi
  if ! git rev-parse --verify --quiet "origin/$branch" >/dev/null; then
    return 0
  fi
  if git merge-base --is-ancestor HEAD "origin/$branch"; then
    git reset --hard "origin/$branch"
  fi
}

backup() (
  local branch path diff_status lock

  lock=$(git rev-parse --git-path codespaces-autobackup.lock) || return 1
  exec 9>"$lock" || return 1
  if ! flock -n 9; then
    log "ERROR: Another backup is already in progress."
    return 1
  fi

  if [[ "${CODESPACES:-}" != "true" || -z "${GITHUB_USER:-}" ]]; then
    log "ERROR: Automatic backup only runs in a GitHub Codespace."
    return 1
  fi

  ensure_student_remote || return 1
  ensure_identity || return 1

  if ! branch=$(git symbolic-ref --quiet --short HEAD); then
    log "ERROR: No branch is checked out. Select a branch before backing up."
    return 1
  fi
  for path in MERGE_HEAD CHERRY_PICK_HEAD REVERT_HEAD rebase-merge rebase-apply; do
    if [[ -e "$(git rev-parse --git-path "$path")" ]]; then
      log "ERROR: A Git operation is in progress. Finish it before backing up."
      return 1
    fi
  done

  sync_fork "$branch"

  if ! git add -A; then
    log "ERROR: Could not stage changes for backup."
    return 1
  fi
  if git diff --cached --quiet; then
    :
  else
    diff_status=$?
    if [[ "$diff_status" != 1 ]]; then
      log "ERROR: Could not inspect staged changes."
      return 1
    fi
    if ! printf 'y\n' | git commit -m "Save student work"; then
      log "ERROR: Could not commit changes. Check the Git error above."
      return 1
    fi
  fi
  if ! git push origin "HEAD:refs/heads/$branch"; then
    log "ERROR: Backup could not push to your fork. Your saved work is still in this Codespace; check the Git error above."
    return 1
  fi
  log "Backup complete: $(date)"
)

follow_log() {
  touch /tmp/student-backup.log
  tail -n +1 -f /tmp/student-backup.log
}

if [[ "${1:-}" == "--once" ]]; then
  backup
elif [[ "${1:-}" == "--watch" ]]; then
  if [[ "${CODESPACES:-}" != "true" ]]; then
    log "Automatic backup is only available in GitHub Codespaces."
    exit 0
  fi
  lock=$(git rev-parse --git-path codespaces-autobackup-watch.lock) || exit 1
  exec 8>"$lock" || exit 1
  if ! flock -n 8; then
    if [[ "${2:-}" == "--follow" ]]; then
      log "Automatic backup is already running. Showing its log."
      follow_log
    fi
    log "Automatic backup is already running."
    exit 0
  fi
  exec > >(tee -a /tmp/student-backup.log) 2>&1
  log "Automatic backup is running. Keep this terminal open; errors will appear here."
  while true; do
    if ! backup; then
      log "Automatic backup will retry in five minutes."
    fi
    sleep 300
  done
else
  log "Usage: bash .devcontainer/backup.sh --once|--watch [--follow]" >&2
  exit 2
fi
