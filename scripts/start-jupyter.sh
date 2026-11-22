#!/bin/sh
set -eu
cd "$(dirname "$0")/.."
uv venv --python 3.12
uv pip install --python .venv -r requirements.txt
exec .venv/bin/jupyter notebook bua_1
