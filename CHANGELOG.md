# Changelog

## [Current]

## [2.3.0] - 2026-09-19

- Updated to Minecraft 26.2 and Fabric loader 0.19.5, bumping all mods for compatibility
- Added Better Carpet Bots & Servermatica (my mods) from Modrinth as they are now published
- Replaced zoom mod to Zoomify
- Removed Limitless Banners, Fancy Entity Renderer, Fast Quit, GDP, Refined Advancements cause of no 26.2 version
- Replaced Greater Wolfs with my own mod Dog Commands because former not maintained
- Overhauled the release process: `release.sh` now bumps the version and tags from the `[Current]` changelog section, and release notes are extracted per-version instead of posting the whole changelog
- Added `update-configs.sh` and `update-local-mods.sh` helper scripts for syncing configs from the Prism Launcher instance and pulling in locally-built mods
- Updated and cleaned up shared configs (Jade, Tweakeroo, MiniHUD, Sodium, Xaero's, FancyMenu title/pause screens, and others)

## [2.2.0] - 2026-07-10

- Switched modpack optimization target from macOS to Linux
- Updated mods and cleaned up configs
- Copied some configs from the Fabulously Optimized modpack

## [2.1.8] - 2026-06-14

- Reverted most UI and sound changes from 2.1.7
- Added some minor details

## [2.1.7] - 2026-06-13

- Revamped mods, added a different music mod and ambient sounds
- Changed UI

## [2.1.6] - 2026-06-04

- Updated to Fabric 0.19.3

## [2.1.5] - 2026-06-03

- Added server mods: pronouns, day counter, and similar
- Switched from JourneyMap back to Xaero's
- Added back missing resource packs

## [2.1.4] - 2026-06-01

- Removed phantom-lucidity, allowing connections from any client (vanilla, Fabric, or otherwise)
- Added BlueMap for server-side maps, with config

## [2.1.3] - 2026-05-03

- Migrated some mods to datapacks
- Added client preset export files (new Glowberry feature)

## [2.1.2] - 2026-04-27

- Migrated from Xaero's minimap/worldmap to JourneyMap

## [2.1.1] - 2026-04-27

- Restructured overrides for the new Azalea version

## [2.1.0] - 2026-02-18

- Migrated modpack management from Packwiz to Azalea
- Rewrote the README
- Added a GitHub release action

## [1.6.3] - 2026-02-13

- Updated all mods to Minecraft 1.21.11 (no mods added or removed)

## [1.6.2] - 2026-01-28

- Replaced the LAN mod with a better alternative
- Added an armor HUD indicator
- Restored the player model on the menu screen (fixed upstream in Fancy Menu)
- Replaced the no-phantom mod with one that doesn't nag on join
- Added a better skin manager (web and `/skin` command)
- Added Cherished Worlds mod

## [1.6.1] - 2026-01-18

- Updated mods to latest versions
- Added skin-related mods (3D Skin Layers, Hide Armor)

## [1.6.0] - 2025-12-05

- Updated modpack to Minecraft 1.21.10

## [1.5.0] - 2025-08-16

- Updated modpack to Minecraft 1.21.4
- Removed Redstone Chunkloaders and No Silk Touch Enderchest
- Added FortuneWarning

## [1.4.2] - 2025-08-13

- Removed unused libraries and NotEnoughRecipeBooks (incompatible with the latest Architectury)
- Fixed option files and removed old config files

## [1.4.1] - 2025-08-13

- Removed buggy sound mods
- Added voice chat

## [1.4.0] - 2025-08-13

- Updated outdated mods
- Added sound mods: Sounds, Sound Physics Remastered, MRU, YACL

## [1.3.1] - 2025-08-12

- Removed Noisium and CanLightningDoFire (caused frame drops and other performance issues)

## [1.3.0] - 2025-08-12

- Fixed a Packwiz bug that excluded server-side Modrinth content from exports
- Restored missing mods: WorldEdit, Carpet, Limitless Banners, Teleport Commands, Can Lightning Do Fire

## [1.2.0] - 2025-07-31

- Finished the modlist generation script
- Added a Vanilla Tweaks Sakura menu screen resource pack
- Renamed Vanilla Tweaks resource packs to their official names
- Prefixed Vanilla Tweaks resource packs with `VT`
- Added the NightUI resource pack to the Packwiz-managed Modrinth packs
- Added a content list with access links

## [1.1.0] - 2025-07-13

- Added game screenshots and a new logo to the README
- Added Blockbench source files for the logo
- Fixed a broken GitHub badge
- Added a GitHub Action to sync the README to Modrinth

## [1.0.0] - 2025-07-10

- Initial release
- Performance mods: Sodium, Lithium, FerriteCore, C2ME, Dynamic FPS
- Builder/technical mods: Carpet, MiniHUD, Litematica, WorldEdit, Tweakeroo
- Map, tooltip, HUD, and UI quality-of-life improvements
- Built with Packwiz for reproducible development, ships as a `.mrpack`
