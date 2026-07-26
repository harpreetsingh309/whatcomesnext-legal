#!/usr/bin/env bash
# Publishes docs/ as a public GitHub Pages site.
# Prerequisites: `gh auth login` (valid token with repo scope)
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
USER_LOGIN="$(gh api user --jq .login)"
REPO_NAME="whatcomesnext-legal"
TMP="$(mktemp -d)"

echo "Publishing as ${USER_LOGIN}/${REPO_NAME}…"
cp -R "$ROOT"/* "$TMP/"
cd "$TMP"
git init -b main
git add .
git -c user.email="noreply@users.noreply.github.com" -c user.name="What Comes Next" commit -m "Add Privacy Policy and Support pages"

if gh repo view "${USER_LOGIN}/${REPO_NAME}" >/dev/null 2>&1; then
  git remote add origin "https://github.com/${USER_LOGIN}/${REPO_NAME}.git"
  git push -u origin main --force
else
  gh repo create "${REPO_NAME}" --public --source=. --remote=origin --push
fi

# Enable GitHub Pages from main branch root
gh api "repos/${USER_LOGIN}/${REPO_NAME}/pages" -X POST \
  -f build_type=legacy \
  -f source[branch]=main \
  -f source[path]=/ 2>/dev/null \
  || gh api "repos/${USER_LOGIN}/${REPO_NAME}/pages" -X PUT \
  -f build_type=legacy \
  -f source[branch]=main \
  -f source[path]=/ 2>/dev/null \
  || true

echo ""
echo "Done. After Pages builds (usually < 1 min):"
echo "  Privacy: https://${USER_LOGIN}.github.io/${REPO_NAME}/privacy.html"
echo "  Support: https://${USER_LOGIN}.github.io/${REPO_NAME}/support.html"
