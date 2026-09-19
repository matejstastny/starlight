#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

PRISM_CANDIDATES=(
	"$HOME/.local/share/PrismLauncher/instances"
	"$HOME/.var/app/org.prismlauncher.PrismLauncher/data/PrismLauncher/instances"
)

INSTANCES_DIR=""
for CANDIDATE in "${PRISM_CANDIDATES[@]}"; do
	if [[ -d "$CANDIDATE" ]]; then
		INSTANCES_DIR="$CANDIDATE"
		break
	fi
done

if [[ -z "$INSTANCES_DIR" ]]; then
	echo "Could not find a Prism Launcher instances directory."
	exit 1
fi

INSTANCES=()
for DIR in "$INSTANCES_DIR"/*/; do
	if [[ -f "$DIR/instance.cfg" ]]; then
		INSTANCES+=("$(basename "$DIR")")
	fi
done

if [[ ${#INSTANCES[@]} -eq 0 ]]; then
	echo "No Prism Launcher instances found in $INSTANCES_DIR"
	exit 1
fi

PS3="Pick an instance: "
select INSTANCE in "${INSTANCES[@]}"; do
	[[ -n "$INSTANCE" ]] && break
	echo "Invalid choice."
done

INSTANCE_MC_DIR="$INSTANCES_DIR/$INSTANCE/minecraft"

if [[ ! -f "$INSTANCE_MC_DIR/options.txt" ]]; then
	echo "options.txt not found at $INSTANCE_MC_DIR/options.txt"
	exit 1
fi

if [[ ! -d "$INSTANCE_MC_DIR/config" ]]; then
	echo "config directory not found at $INSTANCE_MC_DIR/config"
	exit 1
fi

OPTIONS_DEST="$ROOT/overrides/client/options.txt"
CONFIG_DEST="$ROOT/overrides/shared/config"

echo ""
echo "Updating configs from instance: $INSTANCE"

rm -f "$OPTIONS_DEST"
cp "$INSTANCE_MC_DIR/options.txt" "$OPTIONS_DEST"
echo "Copied options.txt"

rm -rf "$CONFIG_DEST"
cp -r "$INSTANCE_MC_DIR/config" "$CONFIG_DEST"
echo "Copied config/"

echo ""
echo "Done"
