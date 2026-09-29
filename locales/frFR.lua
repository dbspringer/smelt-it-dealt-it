local _, ns = ...

if GetLocale() ~= "frFR" then
    return
end

-- Machine translation. Corrections are welcome.
--
-- One word for each glossary term (CONTEXT.md), used in every string below:
--   Smelt (Verdict): Fondre
--   Sell Raw: Vendre en l'état
--   Toss-up: Égalité
--   Verdict: Verdict
--   Raw Value: Valeur en l'état
--   Smelted Value: Valeur des lingots
--   Smelt Profit: Profit
--   Smelt Table: tableau de fonte
--   Smelt Recipe: recette de fonte
--   Reagent: composant
--   Bar: lingot
--   Stale: obsolète
--   No Data: Aucune donnée
--   AH Cut: taxe de l'hôtel des ventes
--   Raw Value, column header: En l'état
--   Smelted Value, column header: Lingots
--   Address: vous

local L = ns.L

L["Bar"] = "Lingot"
L["Reagents"] = "Composants"
L["Raw Value"] = "En l'état"
L["Smelted Value"] = "Lingots"
L["Difference"] = "Écart"
L["Verdict"] = "Verdict"
L["Smelt Profit"] = "Profit"
L["Smelt"] = "Fondre"
L["Sell Raw"] = "Vendre en l'état"
L["Toss-up"] = "Égalité"
L["No data"] = "Aucune donnée"
L["%s x%d"] = "%s x%d"
L["The bar that one smelt makes, and how many."] = "Le lingot que produit une fonte, et combien."
L["What one smelt uses up."] = "Ce qu'une fonte consomme."
L["What you keep if you sell the reagents as they are, after the 5% auction house cut."] = "Ce que vous gardez si vous vendez les composants tels quels, après la taxe de 5 % de l'hôtel des ventes."
L["What you get for the bars, after the 5% auction house cut."] = "Ce que vous obtenez pour les lingots, après la taxe de 5 % de l'hôtel des ventes."
L["Smelted Value minus Raw Value."] = "Valeur des lingots moins valeur en l'état."
L["Smelt or Sell Raw, or Toss-up when the difference is too small to be worth the time."] = "Fondre ou Vendre en l'état, ou Égalité quand l'écart est trop faible pour valoir le temps."
L["What you make if you buy the reagents at these prices, smelt them, and sell the bars."] = "Ce que vous gagnez si vous achetez les composants à ces prix, les fondez et vendez les lingots."
L["%s each, %s"] = "%s l'unité, %s"
L["no price"] = "aucun prix"
L["vendor price"] = "prix du marchand"
L["age unknown"] = "âge inconnu"
L["seen just now"] = "vu à l'instant"
L["seen %d min ago"] = "vu il y a %d min"
L["seen %d h ago"] = "vu il y a %d h"
L["seen today"] = "vu aujourd'hui"
L["seen yesterday"] = "vu hier"
L["seen %d days ago"] = "vu il y a %d jours"
L["Known by: %s"] = "Connue de : %s"
L["None of the characters you can mail to knows this smelt."] = "Aucun des personnages à qui vous pouvez envoyer du courrier ne connaît cette recette de fonte."
L["Smelt only at the Black Forge."] = "Fonte uniquement à la Forge noire."
L["Smelt only at a Molten Foundry."] = "Fonte uniquement dans une Fonderie en fusion."
L["Smelt It/Dealt It needs a price addon. Install or enable one of: %s"] = "Smelt It/Dealt It a besoin d'un addon de prix. Installez ou activez l'un de ceux-ci : %s"
L["Scan the auction house with %s to see prices."] = "Scannez l'hôtel des ventes avec %s pour voir les prix."
L["Every Smelt Recipe is hidden. Show some in the options."] = "Toutes les recettes de fonte sont masquées. Affichez-en dans les options."
L["Open your Mining window once so the table knows what you can smelt."] = "Ouvrez une fois votre fenêtre de minage pour que le tableau sache ce que vous pouvez fondre."
L["Options"] = "Options"
L["/smelt opens the Smelt Table, and /smelt options opens the options."] = "/smelt ouvre le tableau de fonte, et /smelt options ouvre les options."
L["Smelt It/Dealt It: possible new smelts detected:"] = "Smelt It/Dealt It : nouvelles recettes de fonte possibles détectées :"
L["- %s"] = "- %s"
L["Open the Smelt Table."] = "Ouvre le tableau de fonte."
L["Prices"] = "Prix"
L["A difference at or below the larger of these two is a Toss-up: too small to be worth the time to smelt."] = "Un écart inférieur ou égal au plus grand de ces deux seuils est une Égalité : trop faible pour valoir le temps de fondre."
L["Toss-up percent"] = "Pourcentage d'égalité"
L["Toss-up minimum"] = "Minimum d'égalité"
L["Any gain"] = "Tout gain"
L["Big gains only"] = "Gros gains seulement"
L["%d%%"] = "%d%%"
L["An auction price not seen for this long gets a warning icon in the Smelt Table."] = "Un prix d'enchère non vu depuis cette durée reçoit une icône d'alerte dans le tableau de fonte."
L["Stale after"] = "Obsolète après"
L["Only fresh scans"] = "Scans récents seulement"
L["Two weeks"] = "Deux semaines"
L["1 hour"] = "1 heure"
L["%d hours"] = "%d heures"
L["1 day"] = "1 jour"
L["%d days"] = "%d jours"
L["Access"] = "Accès"
L["Show a button on the auction house"] = "Afficher un bouton à l'hôtel des ventes"
L["Show in the addon compartment"] = "Afficher dans le compartiment d'addons"
L["Smelt Recipes"] = "Recettes de fonte"
L["Version %s | Locale: %s"] = "Version %s | Langue : %s"
L["Reset to defaults"] = "Rétablir les valeurs par défaut"
