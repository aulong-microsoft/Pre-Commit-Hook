#!/bin/bash
set -euo pipefail

parent_path=$(
    cd "$(dirname "${BASH_SOURCE[0]}")"
    pwd -P
)
cd "$parent_path"

echo 'Installing repo dependencies...'
pip install -r ../requirements.txt

echo 'Installing pre-commit hooks for first time setup...'
pre-commit install
pre-commit run --all-files
