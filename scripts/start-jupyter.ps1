$ErrorActionPreference = "Stop"
Set-Location (Join-Path $PSScriptRoot "..")
uv venv --python 3.12
uv pip install --python .venv -r requirements.txt
& .\.venv\Scripts\jupyter.exe notebook bua_1
