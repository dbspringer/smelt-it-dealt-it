local _, ns = ...

if GetLocale() ~= "deDE" then
    return
end

-- Machine translation. Corrections are welcome.
--
-- One word for each glossary term (CONTEXT.md), used in every string below:
--   Smelt (Verdict): Verhütten
--   Sell Raw: Roh verkaufen
--   Toss-up: Egal
--   Verdict: Urteil
--   Raw Value: Rohwert
--   Smelted Value: Barrenwert
--   Smelt Profit: Gewinn
--   Smelt Table: Verhüttungstabelle
--   Smelt Recipe: Verhüttungsrezept
--   Reagent: Reagenz
--   Bar: Barren
--   Stale: Veraltet
--   No Data: Keine Daten
--   AH Cut: Auktionshausgebühr
--   Address: Ihr/Euer, as the game client

local L = ns.L

L["Bar"] = "Barren"
L["Reagents"] = "Reagenzien"
L["Raw Value"] = "Rohwert"
L["Smelted Value"] = "Barrenwert"
L["Difference"] = "Differenz"
L["Verdict"] = "Urteil"
L["Smelt Profit"] = "Gewinn"
L["Smelt"] = "Verhütten"
L["Sell Raw"] = "Roh verkaufen"
L["Toss-up"] = "Egal"
L["No data"] = "Keine Daten"
L["%s x%d"] = "%s x%d"
L["The bar that one smelt makes, and how many."] = "Der Barren, den eine Verhüttung ergibt, und wie viele."
L["What one smelt uses up."] = "Was eine Verhüttung verbraucht."
L["What you keep if you sell the reagents as they are, after the 5% auction house cut."] = "Was Ihr behaltet, wenn Ihr die Reagenzien unverarbeitet verkauft, nach Abzug von 5 % Auktionshausgebühr."
L["What you get for the bars, after the 5% auction house cut."] = "Was Ihr für die Barren bekommt, nach Abzug von 5 % Auktionshausgebühr."
L["Smelted Value minus Raw Value."] = "Barrenwert minus Rohwert."
L["Smelt or Sell Raw, or Toss-up when the difference is too small to be worth the time."] = "Verhütten oder Roh verkaufen, oder Egal, wenn die Differenz zu klein ist, um die Zeit wert zu sein."
L["What you make if you buy the reagents at these prices, smelt them, and sell the bars."] = "Was Ihr verdient, wenn Ihr die Reagenzien zu diesen Preisen kauft, verhüttet und die Barren verkauft."
L["%s each, %s"] = "%s pro Stück, %s"
L["no price"] = "kein Preis"
L["vendor price"] = "Händlerpreis"
L["age unknown"] = "Alter unbekannt"
L["seen just now"] = "gerade eben gesehen"
L["seen %d min ago"] = "vor %d Min. gesehen"
L["seen %d h ago"] = "vor %d Std. gesehen"
L["seen today"] = "heute gesehen"
L["seen yesterday"] = "gestern gesehen"
L["seen %d days ago"] = "vor %d Tagen gesehen"
L["Known by: %s"] = "Bekannt bei: %s"
L["None of the characters you can mail to knows this smelt."] = "Keiner der Charaktere, denen Ihr Post schicken könnt, kennt dieses Verhüttungsrezept."
L["Smelt only at the Black Forge."] = "Verhütten nur an der Schwarzen Schmiede."
L["Smelt It/Dealt It needs a price addon. Install or enable one of: %s"] = "Smelt It/Dealt It braucht ein Preis-Addon. Installiert oder aktiviert eines davon: %s"
L["Scan the auction house with %s to see prices."] = "Scannt das Auktionshaus mit %s, um Preise zu sehen."
L["Every Smelt Recipe is hidden. Show some in the options."] = "Alle Verhüttungsrezepte sind ausgeblendet. Blendet in den Optionen einige ein."
L["Open your Mining window once so the table knows what you can smelt."] = "Öffnet einmal Euer Bergbaufenster, damit die Tabelle weiß, was Ihr verhütten könnt."
L["Options"] = "Optionen"
L["/smelt opens the Smelt Table, and /smelt options opens the options."] = "/smelt öffnet die Verhüttungstabelle, /smelt options öffnet die Optionen."
L["Smelt It/Dealt It: possible new smelts detected:"] = "Smelt It/Dealt It: mögliche neue Verhüttungsrezepte gefunden:"
L["- %s"] = "- %s"
L["Open the Smelt Table."] = "Öffnet die Verhüttungstabelle."
L["Prices"] = "Preise"
L["A difference at or below the larger of these two is a Toss-up: too small to be worth the time to smelt."] = "Eine Differenz bis zum größeren dieser beiden Werte ist Egal: zu klein, um die Zeit zum Verhütten wert zu sein."
L["Toss-up percent"] = "Egal-Grenze in Prozent"
L["Toss-up minimum"] = "Egal-Grenze als Betrag"
L["Any gain"] = "Jeder Vorteil"
L["Big gains only"] = "Nur große Vorteile"
L["%d%%"] = "%d%%"
L["An auction price not seen for this long gets a warning icon in the Smelt Table."] = "Ein Auktionspreis, der so lange nicht gesehen wurde, erhält in der Verhüttungstabelle ein Warnsymbol."
L["Stale after"] = "Veraltet nach"
L["Only fresh scans"] = "Nur frische Scans"
L["Two weeks"] = "Zwei Wochen"
L["1 hour"] = "1 Stunde"
L["%d hours"] = "%d Stunden"
L["1 day"] = "1 Tag"
L["%d days"] = "%d Tage"
L["Access"] = "Zugang"
L["/smelt always opens the Smelt Table. These add two more ways in."] = "/smelt öffnet immer die Verhüttungstabelle. Diese Optionen bieten zwei weitere Wege."
L["Show a button on the auction house"] = "Knopf im Auktionshaus anzeigen"
L["Show in the addon compartment"] = "Im Addon-Fach anzeigen"
L["Smelt Recipes"] = "Verhüttungsrezepte"
L["Unchecked recipes leave the Smelt Table."] = "Abgewählte Rezepte verschwinden aus der Verhüttungstabelle."
L["Reset to defaults"] = "Auf Standard zurücksetzen"
