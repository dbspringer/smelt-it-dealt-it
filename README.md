# smelt-it-dealt-it
A WoW Forever addon to check more valuable to smelt ore or sell it.

## Develop

Symlink the repo into the Forever AddOns folder as `SmeltItDealtIt`
(`_classic_beta_/Interface/AddOns`). Lint with `luacheck .` and package with
the BigWigs packager. Releases are plain numbers that go up by one each time
(`1`, `2`, `3`), and pushing that number as a tag cuts the release.

Until the release workflow has CurseForge and Wago keys, `./export.sh <version> [destination]`
builds the same zip by hand, for example `./export.sh 1 ~/Desktop`. It ships
exactly the files the TOC loads, plus the license.
