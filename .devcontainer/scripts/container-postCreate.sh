#!/bin/bash
set -euo pipefail

parent_path=$(
    cd "$(dirname "${BASH_SOURCE[0]}")"
    pwd -P
)

current_path=$(pwd -P)

cd "$parent_path"

echo "Changing owner on .git/hooks directory..."
sudo chown codespace -R ../../.git/hooks

# Create & activate python virtual environment
. ./python-virtualenv.sh

# Initialize Git pre-commit hooks
. ./init-repo.sh

# Detect and run oryx build from universal dev container
oryx build -p virtualenv_name=.venv --log-file /tmp/oryx-build.log --manifest-dir /tmp || echo 'Could not auto-build. Skipping.'

cd "$current_path"
