#!/usr/bin/env bash
set -euo pipefail

REPO_NAME="${1:-project-gantt}"
PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"

cd "$PROJECT_DIR"
gh auth status
OWNER="$(gh api user --jq .login)"

if [ ! -d .git ]; then
  git init -b main
fi

if ! git config user.name >/dev/null 2>&1; then
  git config user.name "$OWNER"
fi
if ! git config user.email >/dev/null 2>&1; then
  git config user.email "$OWNER@users.noreply.github.com"
fi

git add .
git commit -m "Deploy online project gantt"

if gh repo view "$OWNER/$REPO_NAME" >/dev/null 2>&1; then
  if ! git remote get-url origin >/dev/null 2>&1; then
    git remote add origin "https://github.com/$OWNER/$REPO_NAME.git"
  fi
  git push -u origin main
else
  gh repo create "$REPO_NAME" --public --source=. --remote=origin --push
fi

gh api "repos/$OWNER/$REPO_NAME/pages" -X POST -f build_type=workflow >/dev/null 2>&1 || true

echo "GitHub repository: https://github.com/$OWNER/$REPO_NAME"
echo "GitHub Pages URL: https://$OWNER.github.io/$REPO_NAME/"
