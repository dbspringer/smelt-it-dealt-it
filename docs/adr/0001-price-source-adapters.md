# Price lookups go through one price-source module

All auction and vendor price lookups go through a single price-source module with one adapter per price addon, following CraftSim's model; nothing else calls a price addon directly. Auctionator is the only adapter for now, and the TOC lists it as a hard dependency until a second adapter (for example TSM) exists. We keep the seam even with one adapter because a second price addon then costs one file, not a rewrite, while a direct Auctionator dependency would spread `Auctionator.API.v1` calls through the Smelt Table and the shopping list.

## Consequences

- An adapter returns a price in copper, or nil for no data (never 0), so the Smelt Table can tell a missing price from a free item.
- The Buy to Smelt shopping list needs Auctionator's shopping-list API whatever the price source is, because no other price addon has one.
- Only Auctionator signals price changes (`RegisterForDBUpdate`); other adapters would need the Smelt Table to refresh on open.
