# Smelt It/Dealt It

A WoW: Forever addon that tells you whether your ore is worth more smelted into bars or sold raw.

## What it does

**The Smelt Table** lists every smelt on one screen, from Copper to Forever's new Azerothium and Heavy Thorium:

- What the ore sells for, and what the bars sell for, both after the 5% auction house cut
- A verdict for each one: **Smelt**, **Sell Raw**, or **Toss-up** when the difference isn't worth the time it takes to smelt
- What you'd make if you bought the ore at today's prices, smelted it, and sold the bars
- Alloys like Bronze and Steel get their own row, with the bars and Coal they use

**Prices you can trust**

- Hover a row to see each price and how long ago it was seen
- A warning icon shows when a price is older than you'd like (1 hour by default)
- A smelt with no price shows "No data" instead of a guess

**Your characters**

- Once a miner opens their Mining window, the smelts none of your characters can do are greyed out
- The tooltip says which of your characters can do the rest, counting any you can mail ore to

## How to use it

1. Scan the auction house with Auctionator, so there are prices to compare
2. Open your Mining window once on each miner
3. Type `/smelt`, click the ingot on the auction house, or pick Smelt It/Dealt It from the addon compartment next to the minimap

`/smelt options` (or the gear on the table) lets you hide the smelts you don't care about, set how big a difference has to be before smelting is worth it, and choose when a price counts as old.

## Good to know

- You'll need [Auctionator](https://www.curseforge.com/wow/addons/auctionator) for prices
- Built for WoW: Forever (the 1.60 client). Other versions of WoW aren't supported
- The auction house deposit isn't counted, since you get it back when the item sells
- A price is only as fresh as your last scan. A search for a single ore freshens just that ore
- If a smelt in the game ever differs from what the addon knows, it uses the game's version and asks you to report it
- Azerothium and Heavy Thorium are new in Forever, and their details are still being worked out. The addon assumes 1 ore makes 1 bar for now, and corrects itself once a character who knows them opens their Mining window

## Languages

English, plus machine translations for German, French, Spanish, Brazilian Portuguese, Russian, Korean, and Simplified and Traditional Chinese. If a line reads wrong in your language, a fix to the file in `locales/` is very welcome.

## Bugs and ideas

Open an issue at [github.com/dbspringer/smelt-it-dealt-it](https://github.com/dbspringer/smelt-it-dealt-it/issues). The version and locale at the bottom of the options panel help a lot in a bug report.

## Develop

Symlink the repo into the Forever AddOns folder as `SmeltItDealtIt`
(`_classic_beta_/Interface/AddOns`). Lint with `luacheck .`, run the specs with
`busted` (on Lua 5.1 or LuaJIT, since that's what WoW runs), and package with
the BigWigs packager. Releases are plain numbers that go up by one each time
(`1`, `2`, `3`), and pushing that number as a tag cuts the release.

Until the release workflow has CurseForge and Wago keys, `./export.sh <version> [destination]`
builds the same zip by hand, for example `./export.sh 1 ~/Desktop`. It ships
exactly the files the TOC loads, plus the license.
