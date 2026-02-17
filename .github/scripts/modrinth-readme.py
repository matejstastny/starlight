"""
modrinth-readme.py

Small helper script used in GitHub Actions.

What it does:
- Reads the repository README.md
- Removes sections wrapped in
  <!-- MODRINTH_REMOVE_START --> ... <!-- MODRINTH_REMOVE_END -->
- Writes the cleaned result to public/README-modrinth.md

This allows keeping extra info in the main README while
publishing a trimmed version for Modrinth.
"""

import re

with open("README.md", "r", encoding="utf-8") as readme_file:
    original_content = readme_file.read()

cleaned_content = re.sub(
    r"<!--\s*MODRINTH_REMOVE_START\s*-->.*?<!--\s*MODRINTH_REMOVE_END\s*-->",
    "",
    original_content,
    flags=re.DOTALL,
)

output_path = "public/README-modrinth.md"
with open(output_path, "w", encoding="utf-8") as modrinth_file:
    modrinth_file.write(cleaned_content)

print(f"Cleaned README saved to {output_path}")
