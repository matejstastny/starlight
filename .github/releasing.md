# Publishing Releases via Git Tags

This repository uses **Git tags** to trigger the automated publish workflow. Creating a properly formatted tag will start the release pipeline.

## `Creating a Publish Tag`

Use the format:

```
vX.Y.Z+MC
```

#### `Example:`

```bash
git tag v2.1.0+1.21.1
git push --tags
```

## `Reverting a Broken Release Tag`

If the workflow fails or you tagged the wrong version, delete the tag locally and remotely.

#### `Delete local tag`

```bash
git tag -d vX.Y.Z+MC
```

#### `Delete remote tag`

```bash
git push origin --delete vX.Y.Z+MC
```

After removing the tag, you can fix the issue and create a new one.
