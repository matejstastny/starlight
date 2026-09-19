#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

AZALEA="$ROOT/azalea.json"
CHANGELOG="$ROOT/CHANGELOG.md"

MC_VERSION=$(jq -r '.minecraft_version' "$AZALEA")
CURRENT_VERSION=$(jq -r '.version' "$AZALEA" | sed 's/^v//')

echo "Minecraft version : $MC_VERSION"
echo "Current version   : $CURRENT_VERSION"
echo ""
read -rp "New version: " NEW_VERSION

if [[ -z "$NEW_VERSION" ]]; then
	echo "Aborted: no version entered."
	exit 1
fi

TAG="v${NEW_VERSION}+${MC_VERSION}"

CHANGELOG_CONTENT=$(awk '
    /^## \[Current\]/ { flag=1; next }
    /^## \[/          { if (flag) exit }
    flag              { print }
' "$CHANGELOG")

if [[ -z "$(echo "$CHANGELOG_CONTENT" | tr -d '[:space:]')" ]]; then
	echo ""
	echo "## [Current] section is empty. Add your changelog entries first."
	exit 1
fi

echo ""
echo "Changelog for $TAG:"
echo "---"
echo "$CHANGELOG_CONTENT"
echo "---"
echo ""
echo "Will create tag: $TAG"
read -rp "Confirm? [y/N] " CONFIRM
[[ "$CONFIRM" =~ ^[Yy]$ ]] || {
	echo "Aborted."
	exit 1
}

TODAY=$(date +%Y-%m-%d)

sed -i "s/^## \[Current\]/## [Current]\n\n## [${NEW_VERSION}] - ${TODAY}/" "$CHANGELOG"
sed -i "s/\"version\": \"v${CURRENT_VERSION}\"/\"version\": \"v${NEW_VERSION}\"/" "$AZALEA"

echo ""
echo "Updated CHANGELOG.md and azalea.json"

cd "$ROOT"
git add "$CHANGELOG" "$AZALEA"
git commit -m "chore: bump version to ${NEW_VERSION}"
git tag "$TAG"
git push origin HEAD
git push origin "$TAG"

echo ""
echo "Pushed tag $TAG - release CI is now running."
