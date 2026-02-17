"""
update-project-tag.py

Small helper script used in GitHub Actions.

What it does:
- Opens azalea.json from the repository root
- Replaces version with AZALEA_VERSION
- Writes the file back with pretty JSON formatting

Intended to be run from CI, not manually.
"""

from pathlib import Path
import json
import os

ROOT = Path(__file__).resolve().parents[2]
FILE = ROOT / "azalea.json"

VER = os.getenv("AZALEA_VERSION")
if VER and VER.lower().startswith("v"):
    VER = VER[1:]

if not VER:
    raise SystemExit("No AZALEA_VERSION env var provided")

with FILE.open("r", encoding="utf-8") as f:
    data = json.load(f)

if VER:
    data["version"] = VER

with FILE.open("w", encoding="utf-8") as f:
    json.dump(data, f, indent=2)
    f.write("\n")

print("azalea.json updated")
