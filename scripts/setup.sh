#!/bin/sh
set -e

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
REPO_ROOT=$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)

cd "$REPO_ROOT"

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
	echo '[setup] ❌ Not a valid Git repository.'
	echo '[setup] Ensure this project is cloned from Git or run: git init'
	exit 1
fi

echo '[setup] Configuring shared Git hooks path...'
git config core.hooksPath scripts/git-hooks

echo '[setup] Making hook scripts executable...'
chmod +x scripts/git-hooks/*
chmod +x scripts/setup.sh

echo '[setup] ✅ Shared Git hooks configured successfully.'
echo '[setup] Commits will now run formatting and flutter analyze automatically.'