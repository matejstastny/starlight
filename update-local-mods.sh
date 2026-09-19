#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="$ROOT/overrides/shared/mods"

MOD_DIRS=(
	"$ROOT/../your-reputation"
	"$ROOT/../global-villager-discounts"
	"$ROOT/../dog-commands"
)

TARGET_MC_VERSION=$(jq -r '.minecraft_version' "$ROOT/azalea.json")

echo "Modpack Minecraft version: $TARGET_MC_VERSION"
echo ""

FAILED=0

for MOD_DIR in "${MOD_DIRS[@]}"; do
	MOD_NAME="$(basename "$MOD_DIR")"

	if [[ ! -d "$MOD_DIR" ]]; then
		echo "[$MOD_NAME] skipped: directory not found at $MOD_DIR"
		continue
	fi

	PROPS="$MOD_DIR/gradle.properties"
	MOD_MC_VERSION=$(grep -E '^[[:space:]]*minecraft_version=' "$PROPS" | cut -d= -f2 | tr -d '[:space:]')
	ARCHIVES_NAME=$(grep -E '^[[:space:]]*archives_base_name=' "$PROPS" | cut -d= -f2 | tr -d '[:space:]')

	if [[ "$MOD_MC_VERSION" != "$TARGET_MC_VERSION" ]]; then
		echo "[$MOD_NAME] skipped: on Minecraft $MOD_MC_VERSION, modpack is on $TARGET_MC_VERSION"
		continue
	fi

	echo "[$MOD_NAME] building for Minecraft $MOD_MC_VERSION..."
	if ! (cd "$MOD_DIR" && ./gradlew build); then
		echo "[$MOD_NAME] build failed"
		FAILED=1
		continue
	fi

	NEW_JAR=$(find "$MOD_DIR/build/libs" -maxdepth 1 -name "${ARCHIVES_NAME}-*.jar" ! -name "*-sources.jar" -printf '%T@ %p\n' | sort -rn | head -n1 | cut -d' ' -f2-)

	if [[ -z "$NEW_JAR" ]]; then
		echo "[$MOD_NAME] build succeeded but no jar found in build/libs"
		FAILED=1
		continue
	fi

	rm -f "$DEST/${ARCHIVES_NAME}"-*.jar
	cp "$NEW_JAR" "$DEST/"

	echo "[$MOD_NAME] copied $(basename "$NEW_JAR") to overrides/shared/mods"
	echo ""
done

if [[ "$FAILED" -eq 1 ]]; then
	echo "Done, with errors."
	exit 1
fi

echo "Done."
