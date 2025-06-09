#!/bin/bash
if [ -n "${CODESPACES}" ]; then
    echo "Updating submodules..."
    git config --global url.https://x-access-token:${GITHUB_TOKEN}@github.com/.insteadOf ssh://git@github.com/
    git config --global url.https://x-access-token:${GITHUB_TOKEN}@github.com/.insteadOf git@github.com/
    git config --global url.https://x-access-token:${GITHUB_TOKEN}@github.com/.insteadOf git@github.com:
    git submodule update --init --recursive
fi