#!/usr/bin/env python3

"""
Upload the built mrpack from dist/ to Modrinth.

Requires environment variables:
    MODRINTH_TOKEN
    MODRINTH_PROJECT_ID
    GITHUB_REF_NAME
"""

from __future__ import annotations
import json
import os
import pathlib
import sys

try:
    import requests
except ImportError:
    print(
        "[ERROR] requests not installed. Add it to your workflow before running this script."
    )
    sys.exit(1)


def fail(msg: str) -> None:
    print(f"[ERROR] {msg}")
    sys.exit(1)


token = os.getenv("MODRINTH_TOKEN")
project_id = os.getenv("MODRINTH_PROJECT_ID")
tag = os.getenv("GITHUB_REF_NAME")

if not token:
    fail("[ERROR] MODRINTH_TOKEN missing")
if not project_id:
    fail("[ERROR] MODRINTH_PROJECT_ID missing")
if not tag:
    fail("[ERROR] GITHUB_REF_NAME missing")

# -----------------------------
# Load azalea.json
# -----------------------------
try:
    with open("azalea.json") as f:
        data = json.load(f)
except FileNotFoundError:
    fail("[ERROR] azalea.json not found")

version = str(data.get("version", "")).strip()
mc = str(data.get("minecraft_version", "")).strip()
loader = str(data.get("loader", "")).strip()

if not version or not mc or not loader:
    fail("[ERROR] azalea.json missing version/minecraft_version/loader")

# -----------------------------
# Locate mrpack
# -----------------------------
dist = pathlib.Path("dist")
packs = list(dist.glob("*.mrpack"))

if not packs:
    fail("[ERROR] No mrpack found in dist/")

mrpack = packs[0]
print(f"[INFO] Found pack: {mrpack}")

# -----------------------------
# Read changelog if present
# -----------------------------

changelog = ""
if os.path.exists("CHANGELOG.md"):
    with open("CHANGELOG.md", encoding="utf-8") as f:
        changelog = f.read()

# -----------------------------
# Build Modrinth request
# -----------------------------

headers = {
    "Authorization": f"Bearer {token}",
    "User-Agent": "starlight-release-bot",
}

payload = {
    "name": f"Starlight {version} for MC {mc}",
    "version_number": tag,
    "changelog": changelog,
    "dependencies": [],
    "game_versions": [mc],
    "version_type": "release",
    "loaders": [loader],
    "featured": True,
    "project_id": project_id,
    "file_parts": ["file"],
}

with open(mrpack, "rb") as fp:
    files = {
        "data": (None, json.dumps(payload), "application/json"),
        "file": (mrpack.name, fp, "application/octet-stream"),
    }

    print("[INFO] Uploading to Modrinth…")
    r = requests.post(
        "https://api.modrinth.com/v2/version",
        headers=headers,
        files=files,
    )

if r.status_code not in (200, 201):
    print(r.text)
    fail("[ERROR] Modrinth upload failed")

print("[SUCCESS] Modrinth upload successful")
