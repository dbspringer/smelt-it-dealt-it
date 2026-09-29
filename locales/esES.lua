local _, ns = ...

local locale = GetLocale()
if locale ~= "esES" and locale ~= "esMX" then
    return
end

-- Machine translation. Corrections are welcome.
--
-- One word for each glossary term (CONTEXT.md), used in every string below:
--   Smelt (Verdict): Fundir
--   Sell Raw: Vender sin fundir
--   Toss-up: Empate
--   Verdict: Veredicto
--   Raw Value: Valor sin fundir
--   Smelted Value: Valor en lingotes
--   Smelt Profit: Beneficio
--   Smelt Table: tabla de fundición
--   Smelt Recipe: receta de fundición
--   Reagent: componente
--   Bar: lingote
--   Stale: obsoleto
--   No Data: Sin datos
--   AH Cut: comisión de la casa de subastas
--   Raw Value, column header: Sin fundir
--   Smelted Value, column header: Lingotes
--   Address: tú

local L = ns.L

L["Bar"] = "Lingote"
L["Reagents"] = "Componentes"
L["Raw Value"] = "Sin fundir"
L["Smelted Value"] = "Lingotes"
L["Difference"] = "Diferencia"
L["Verdict"] = "Veredicto"
L["Smelt Profit"] = "Beneficio"
L["Smelt"] = "Fundir"
L["Sell Raw"] = "Vender sin fundir"
L["Toss-up"] = "Empate"
L["No data"] = "Sin datos"
L["%s x%d"] = "%s x%d"
L["The bar that one smelt makes, and how many."] = "El lingote que da una fundición, y cuántos."
L["What one smelt uses up."] = "Lo que consume una fundición."
L["What you keep if you sell the reagents as they are, after the 5% auction house cut."] = "Lo que conservas si vendes los componentes tal cual, tras la comisión del 5 % de la casa de subastas."
L["What you get for the bars, after the 5% auction house cut."] = "Lo que obtienes por los lingotes, tras la comisión del 5 % de la casa de subastas."
L["Smelted Value minus Raw Value."] = "Valor en lingotes menos valor sin fundir."
L["Smelt or Sell Raw, or Toss-up when the difference is too small to be worth the time."] = "Fundir o Vender sin fundir, o Empate cuando la diferencia es demasiado pequeña para que valga la pena."
L["What you make if you buy the reagents at these prices, smelt them, and sell the bars."] = "Lo que ganas si compras los componentes a estos precios, los fundes y vendes los lingotes."
L["%s each, %s"] = "%s cada uno, %s"
L["no price"] = "sin precio"
L["vendor price"] = "precio del mercader"
L["age unknown"] = "antigüedad desconocida"
L["seen just now"] = "visto ahora mismo"
L["seen %d min ago"] = "visto hace %d min"
L["seen %d h ago"] = "visto hace %d h"
L["seen today"] = "visto hoy"
L["seen yesterday"] = "visto ayer"
L["seen %d days ago"] = "visto hace %d días"
L["Known by: %s"] = "Conocida por: %s"
L["None of the characters you can mail to knows this smelt."] = "Ninguno de los personajes a los que puedes enviar correo conoce esta receta de fundición."
L["Smelt only at the Black Forge."] = "Solo se funde en la Forja Negra."
L["Smelt It/Dealt It needs a price addon. Install or enable one of: %s"] = "Smelt It/Dealt It necesita un addon de precios. Instala o activa uno de estos: %s"
L["Scan the auction house with %s to see prices."] = "Escanea la casa de subastas con %s para ver los precios."
L["Every Smelt Recipe is hidden. Show some in the options."] = "Todas las recetas de fundición están ocultas. Muestra alguna en las opciones."
L["Open your Mining window once so the table knows what you can smelt."] = "Abre una vez tu ventana de Minería para que la tabla sepa qué puedes fundir."
L["Options"] = "Opciones"
L["/smelt opens the Smelt Table, and /smelt options opens the options."] = "/smelt abre la tabla de fundición y /smelt options abre las opciones."
L["Smelt It/Dealt It: possible new smelts detected:"] = "Smelt It/Dealt It: posibles recetas de fundición nuevas detectadas:"
L["- %s"] = "- %s"
L["Open the Smelt Table."] = "Abre la tabla de fundición."
L["Prices"] = "Precios"
L["A difference at or below the larger of these two is a Toss-up: too small to be worth the time to smelt."] = "Una diferencia igual o menor que el mayor de estos dos valores es un Empate: demasiado pequeña para que valga la pena fundir."
L["Toss-up percent"] = "Porcentaje de empate"
L["Toss-up minimum"] = "Mínimo de empate"
L["Any gain"] = "Cualquier ganancia"
L["Big gains only"] = "Solo grandes ganancias"
L["%d%%"] = "%d%%"
L["An auction price not seen for this long gets a warning icon in the Smelt Table."] = "Un precio de subasta que no se ha visto en este tiempo muestra un icono de aviso en la tabla de fundición."
L["Stale after"] = "Obsoleto tras"
L["Only fresh scans"] = "Solo escaneos recientes"
L["Two weeks"] = "Dos semanas"
L["1 hour"] = "1 hora"
L["%d hours"] = "%d horas"
L["1 day"] = "1 día"
L["%d days"] = "%d días"
L["Access"] = "Acceso"
L["Show a button on the auction house"] = "Mostrar un botón en la casa de subastas"
L["Show in the addon compartment"] = "Mostrar en el compartimento de addons"
L["Smelt Recipes"] = "Recetas de fundición"
L["Version %s | Locale: %s"] = "Versión %s | Idioma: %s"
L["Reset to defaults"] = "Restablecer predeterminados"
