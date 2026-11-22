#!/usr/bin/env bash

set -u

notebook="${1:-}"
script_dir=$(cd "$(dirname "$0")" && pwd)
repo_dir=$(cd "$script_dir/.." && pwd)
cd "$repo_dir"

if [[ -z "$notebook" || ! -f "$notebook" ]]; then
  echo "ERROR: Notebook not found: ${notebook:-<missing>}" >&2
  exit 1
fi

export PATH="${HOME}/.local/bin:${PATH}"

if [[ "${CODESPACES:-}" == "true" ]]; then
  timeout 90 bash "$script_dir/backup.sh" --once || echo "WARNING: Initial backup failed. The notebook will still open; saved files remain in this Codespace."
  bash "$script_dir/backup.sh" --watch >/tmp/student-backup-launcher.log 2>&1 &
fi

python -m jupyter notebook \
  --allow-root \
  --no-browser \
  --ServerApp.ip=0.0.0.0 \
  --ServerApp.port=8888 \
  --ServerApp.open_browser=False \
  --IdentityProvider.token='' \
  --ServerApp.token='' \
  --ServerApp.password='' \
  --ServerApp.allow_origin='*' \
  --ServerApp.allow_remote_access=True \
  --ServerApp.disable_check_xsrf=True \
  --ServerApp.use_redirect_file=False \
  --ServerApp.root_dir="$repo_dir" \
  --ServerApp.default_url="/notebooks/${notebook}" \
  --JupyterNotebookApp.default_url="/notebooks/${notebook}" \
  > /tmp/jupyter.log 2>&1 &

for _ in $(seq 1 60); do
  if python -c 'import urllib.request; urllib.request.urlopen("http://127.0.0.1:8888/", timeout=2)' >/dev/null 2>&1; then
    echo "Jupyter is ready: ${notebook}"
    exit 0
  fi
  sleep 1
done

echo "ERROR: Jupyter did not start. The last log lines follow:" >&2
tail -n 40 /tmp/jupyter.log >&2 || true
exit 1
