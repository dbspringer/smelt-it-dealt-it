# Smelt It/Dealt It

A WoW: Forever addon that compares auction house prices of ore and the bars smelted from it, so a player knows whether smelting pays.

## Language

### Recipes

**Smelt Recipe**:
One Mining smelt: a set of Reagents that makes a number of one bar. Each Smelt Recipe stands alone; a recipe whose Reagents are bars (Bronze, Steel) is not chained back to the ore.
_Avoid_: Recipe chain, conversion

**Known Recipe**:
A Smelt Recipe that a given character of the player has learned, as seen the last time that character opened the Mining window. The Smelt Table greys out a recipe that no Mailable Character knows; the Verdict does not depend on it.
_Avoid_: Learned recipe, available recipe

**Mailable Character**:
One of the player's characters that the current character can mail items to: same faction, on the same realm or a connected realm. The current character is one too.
_Avoid_: Alt, reachable character

**Hidden Recipe**:
A Smelt Recipe the player has chosen not to see, for every character on the account. It leaves the Smelt Table and never goes on the Shopping List.
_Avoid_: Disabled recipe, ignored ore, filtered

**Reagent**:
An item a Smelt Recipe uses up: ore, a bar, or another material.
_Avoid_: Input, material

**Vendor Reagent**:
A Reagent for which the Price Source knows a vendor price, because a vendor sells it in unlimited supply and the player has visited that vendor. Its price is the vendor price, not an auction price. Until then, it counts as an auction Reagent.
_Avoid_: Vendor item

### Prices

**Price Source**:
The installed addon that supplies auction prices, such as Auctionator. The addon reads every price from exactly one Price Source.
_Avoid_: Price addon, price provider, pricing API

**Auction Price**:
The lowest unit price at which the Price Source last saw an item listed. It is true for one unit, not for a full stack.
_Avoid_: Market price, AH value, min buyout

**Price Age**:
The number of whole days since the Price Source last saw an item on the auction house. A price seen today has age 0.
_Avoid_: Scan age, freshness

**Stale Price**:
A price whose Price Age is at or above the stale limit (default 1 day, so anything not seen today). A Stale Price still gives a Verdict, with a warning.
_Avoid_: Old data, outdated price

**No Data**:
The state of a Smelt Recipe when a Reagent or its bar has no price at all. A Smelt Recipe with No Data has no Verdict and no Smelt Profit.
_Avoid_: Missing, unknown, zero price

### Questions the addon answers

**Sell or Smelt**:
The question for Reagents the player already holds: are they worth more sold as they are, or smelted and sold as bars?
_Avoid_: Smelt check, hold check

**Buy to Smelt**:
The question for Reagents on the auction house: does buying them, smelting them, and selling the bars make a profit?
_Avoid_: Flip, arbitrage

### Values

**AH Cut**:
The 5% of a sale price that the auction house keeps. It applies to what the player sells, never to what the player buys.
_Avoid_: Fee, tax

**Raw Value**:
What the player keeps by not casting a Smelt Recipe once: the Auction Price of its Reagents less the AH Cut, plus the price of any Vendor Reagents they need not buy.
_Avoid_: Ore value

**Smelted Value**:
What the player receives for selling the bars from one cast of a Smelt Recipe: bar price times bars made, less the AH Cut.
_Avoid_: Bar value

**Smelt Profit**:
The Buy to Smelt result for one cast: Smelted Value less the full price paid for all Reagents.
_Avoid_: Margin, crafting profit

**Break-even Price**:
The highest unit price for one auction Reagent at which Smelt Profit is zero, with every other Reagent at its Auction Price or vendor price.
_Avoid_: Cost basis, par

**Max Buy Price**:
The highest unit price the player should pay for an auction Reagent under Buy to Smelt: its Break-even Price less its share of the Toss-up Threshold, so each purchase pays more than a Toss-up.
_Avoid_: Snipe price, buy limit

**Buyable Quantity**:
How many units of an auction Reagent are listed at or below its Max Buy Price right now.
_Avoid_: Stock, depth, supply

### Verdict

**Verdict**:
The Sell or Smelt answer for one Smelt Recipe. It is always one of Smelt, Sell Raw, or Toss-up.
_Avoid_: Recommendation, result

**Smelt**:
The Verdict when Smelted Value is higher than Raw Value by more than the Toss-up Threshold.

**Sell Raw**:
The Verdict when Raw Value is higher than Smelted Value by more than the Toss-up Threshold.
_Avoid_: Hold, sell ore

**Toss-up**:
The Verdict when the difference between Raw Value and Smelted Value is too small to pay for the time to smelt.
_Avoid_: Neutral, even, no clear winner

**Toss-up Threshold**:
The difference at or below which the Verdict is Toss-up: a percent of the higher value, or a minimum amount for one cast, whichever is larger. The player sets both (default 5% and 1 silver).
_Avoid_: Margin, tolerance

### Views

**Smelt Table**:
The window that lists every Smelt Recipe that is not a Hidden Recipe as one row, in Mining skill order, with its prices, Raw Value, Smelted Value, Verdict, and Smelt Profit.
_Avoid_: Chart, popup, grid

**Shopping List**:
The Buy to Smelt purchase list: one entry for each auction Reagent with a Buyable Quantity, carrying its Max Buy Price and that quantity. It covers only Smelt Recipes that are a Known Recipe of at least one Mailable Character and are not a Hidden Recipe.
_Avoid_: Buy list, snipe list
