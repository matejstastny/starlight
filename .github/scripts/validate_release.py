#!/usr/bin/env python3

"""
Validate that the pushed git tag matches azalea.json

Expected tag formats:
    vX.Y.Z+MC
    vX.Y.Z+MC.X

Examples:
    v1.2.3+1.21
    v1.2.3+1.21.4
"""

from __future__ import annotations
import json
import os
import re
import sys
from pathlib import Path


TAG = os.getenv("GITHUB_REF_NAME")

if not TAG:
    print("[ERROR] GITHUB_REF_NAME not set.")
    sys.exit(1)

print(f"[INFO] Validating tag: {TAG}")

# -----------------------------
# Validate tag format
# -----------------------------

pattern = r"^v(\d+\.\d+\.\d+)\+(\d+\.\d+(?:\.\d+)?)$"
match = re.match(pattern, TAG)

if not match:
    print("[ERROR] Invalid tag format. Expected: vX.Y.Z+MC or vX.Y.Z+MC.X")
    sys.exit(1)

tag_version = f"v{match.group(1)}"
tag_mc = match.group(2)

print(f"[INFO] Tag version: {tag_version}")
print(f"[INFO] Tag MC: {tag_mc}")

# -----------------------------
# Load azalea.json
# -----------------------------

config_path = Path("azalea.json")

if not config_path.exists():
    print("[ERROR] azalea.json not found in repo root.")
    sys.exit(1)

with config_path.open() as f:
    data = json.load(f)

json_version = data.get("version")
json_mc = data.get("minecraft_version")
fabric_version = data.get("loader_version")

print(f"[INFO] JSON version: {json_version}")
print(f"[INFO] JSON MC: {json_mc}")

# -----------------------------
# Compare versions
# -----------------------------

failed = False

if json_version != tag_version:
    print("[ERROR] Version mismatch!")
    print(f"   Tag:  {tag_version}")
    print(f"   JSON: {json_version}")
    failed = True

if json_mc != tag_mc:
    print("[ERROR] Minecraft version mismatch!")
    print(f"   Tag MC:  {tag_mc}")
    print(f"   JSON MC: {json_mc}")
    failed = True

if failed:
    sys.exit(1)

print("[SUCCESS] Version validation passed")

# -----------------------------
# Export outputs for Actions
# -----------------------------

output_file = os.getenv("GITHUB_OUTPUT")
if output_file:
    with open(output_file, "a") as f:
        f.write(f"version={tag_version}\n")
        f.write(f"minecraft={tag_mc}\n")
        f.write(f"fabric={fabric_version}\n")

print("[INFO] Done")
