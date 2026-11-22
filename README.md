# Intro to Python

## Start today's class

Sign in to GitHub, click the button for the class, then click **Create codespace**
or **Resume codespace**. The first start takes a few minutes while the notebook
tools install.

The class notebook then opens in a browser tab, ready to edit. Click a cell and
press Shift+Enter to run it. If the notebook tab does not open, select the
**Ports** panel and open **Jupyter notebook**.

| Class | Start |
| --- | --- |
| 1. Notebooks | [![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/bmabsout/BUA-Intro-Python?quickstart=1&devcontainer_path=.devcontainer%2Fclass-1%2Fdevcontainer.json) |
| 2. Statements | [![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/bmabsout/BUA-Intro-Python?quickstart=1&devcontainer_path=.devcontainer%2Fclass-2%2Fdevcontainer.json) |
| 3. Composite Types | [![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/bmabsout/BUA-Intro-Python?quickstart=1&devcontainer_path=.devcontainer%2Fclass-3%2Fdevcontainer.json) |
| 4. Control Structures | [![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/bmabsout/BUA-Intro-Python?quickstart=1&devcontainer_path=.devcontainer%2Fclass-4%2Fdevcontainer.json) |
| 5. Loops | [![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/bmabsout/BUA-Intro-Python?quickstart=1&devcontainer_path=.devcontainer%2Fclass-5%2Fdevcontainer.json) |
| 6. Libraries and Graphics | [![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/bmabsout/BUA-Intro-Python?quickstart=1&devcontainer_path=.devcontainer%2Fclass-6%2Fdevcontainer.json) |
| 7. Functions | [![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/bmabsout/BUA-Intro-Python?quickstart=1&devcontainer_path=.devcontainer%2Fclass-7%2Fdevcontainer.json) |
| 8. Bringing it all Together | [![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/bmabsout/BUA-Intro-Python?quickstart=1&devcontainer_path=.devcontainer%2Fclass-8%2Fdevcontainer.json) |

Use the same button next time to resume that class. You do not need to edit
these links. The first backup creates a fork on your GitHub account if you do
not already have one. If your teacher asked you to fork first, that is fine
too. If the backup terminal says it could not link your fork, fork this
repository and tell your teacher.

Notebook edits are saved automatically. Every five minutes, while the Codespace
is open, those saved files are committed and pushed to your fork. Keep the
backup terminal open so you can see errors. Use only one class Codespace at a
time, and stop it when you finish so you do not use up your free hours. Changes
made in the last few minutes may not have been pushed yet. A stopped Codespace
keeps its files, but an inactive Codespace can be deleted after 30 days and
takes unpushed work with it.

Do not put passwords or other secrets in the repository. The `student_work/`
directory is ignored and is not backed up. Turtle graphics need a desktop and
do not work in this browser setup.

GitHub accounts include a limited amount of free Codespaces use. See
[GitHub's usage guide](https://docs.github.com/en/codespaces/troubleshooting/troubleshooting-included-usage).

## Run Jupyter on your own computer

This works the same way on Windows, macOS, and Linux. It does not back up to
GitHub automatically.

1. Install [Git](https://git-scm.com/install/) and
   [uv](https://docs.astral.sh/uv/getting-started/installation/).
   On macOS or Linux:

   ```sh
   curl -LsSf https://astral.sh/uv/install.sh | sh
   ```

   On Windows PowerShell:

   ```powershell
   powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
   ```

   Close and reopen the terminal if `uv` is not found.

2. Clone the repository and start Jupyter. On macOS or Linux:

   ```sh
   git clone https://github.com/bmabsout/BUA-Intro-Python.git
   cd BUA-Intro-Python
   sh scripts/start-jupyter.sh
   ```

   On Windows PowerShell:

   ```powershell
   git clone https://github.com/bmabsout/BUA-Intro-Python.git
   cd BUA-Intro-Python
   powershell -ExecutionPolicy Bypass -File .\scripts\start-jupyter.ps1
   ```

uv installs Python 3.12 if needed, then opens Jupyter in your browser. Choose a
notebook in `bua_1`. Stop it with Ctrl+C in the terminal.
