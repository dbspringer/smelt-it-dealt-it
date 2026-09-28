# Price lookups go through one price-source module

All auction and vendor price lookups go through a single price-source module with one adapter per price addon, following CraftSim's model; nothing else calls a price addon directly. Auctionator is the only adapter for now. We keep the seam even with one adapter because a second price addon then costs one file, not a rewrite, while a direct Auctionator dependency would spread `Auctionator.API.v1` calls through the Smelt Table and the shopping list.

## Choosing an adapter

Amended during slice 2, which first planned Auctionator as a hard dependency.

- Every supported price addon is an `OptionalDeps`, not a `Dependencies`. With a hard dependency, WoW skips loading this addon when Auctionator is missing, and `/smelt` fails with no hint why. Instead, with no price addon available, the Smelt Table and one chat line at login name the supported addons.
- Adapters register in TOC order, which is their priority order. At `PLAYER_LOGIN` the module uses the first adapter whose addon is loaded.
- When a second adapter exists, a setting saves the player's choice: the module uses it when its addon is loaded, else falls back to priority order. A fallback never overwrites the saved choice. CraftSim saves the fallback, so one session with the preferred addon off loses the choice for good.

## Consequences

- An adapter returns a price in copper, or nil for no data (never 0), so the Smelt Table can tell a missing price from a free item.
- The Buy to Smelt shopping list needs Auctionator's shopping-list API whatever the price source is, because no other price addon has one. It checks for Auctionator on its own.
- Only Auctionator signals price changes (`RegisterForDBUpdate`); other adapters would need the Smelt Table to refresh on open.
