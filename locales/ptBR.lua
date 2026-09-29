local _, ns = ...

if GetLocale() ~= "ptBR" then
    return
end

-- Machine translation. Corrections are welcome.
--
-- One word for each glossary term (CONTEXT.md), used in every string below:
--   Smelt (Verdict): Fundir
--   Sell Raw: Vender sem fundir
--   Toss-up: Empate
--   Verdict: Veredito
--   Raw Value: Valor sem fundir
--   Smelted Value: Valor em barras
--   Smelt Profit: Lucro
--   Smelt Table: tabela de fundição
--   Smelt Recipe: receita de fundição
--   Reagent: reagente
--   Bar: barra
--   Stale: desatualizado
--   No Data: Sem dados
--   AH Cut: taxa da casa de leilões
--   Address: você

local L = ns.L

L["Bar"] = "Barra"
L["Reagents"] = "Reagentes"
L["Raw Value"] = "Valor sem fundir"
L["Smelted Value"] = "Valor em barras"
L["Difference"] = "Diferença"
L["Verdict"] = "Veredito"
L["Smelt Profit"] = "Lucro"
L["Smelt"] = "Fundir"
L["Sell Raw"] = "Vender sem fundir"
L["Toss-up"] = "Empate"
L["No data"] = "Sem dados"
L["%s x%d"] = "%s x%d"
L["The bar that one smelt makes, and how many."] = "A barra que uma fundição produz, e quantas."
L["What one smelt uses up."] = "O que uma fundição consome."
L["What you keep if you sell the reagents as they are, after the 5% auction house cut."] = "Com quanto você fica se vender os reagentes como estão, após a taxa de 5% da casa de leilões."
L["What you get for the bars, after the 5% auction house cut."] = "O que você recebe pelas barras, após a taxa de 5% da casa de leilões."
L["Smelted Value minus Raw Value."] = "Valor em barras menos valor sem fundir."
L["Smelt or Sell Raw, or Toss-up when the difference is too small to be worth the time."] = "Fundir ou Vender sem fundir, ou Empate quando a diferença é pequena demais para valer o tempo."
L["What you make if you buy the reagents at these prices, smelt them, and sell the bars."] = "O que você ganha se comprar os reagentes a estes preços, fundi-los e vender as barras."
L["%s each, %s"] = "%s cada, %s"
L["no price"] = "sem preço"
L["vendor price"] = "preço do mercador"
L["age unknown"] = "idade desconhecida"
L["seen just now"] = "visto agora mesmo"
L["seen %d min ago"] = "visto há %d min"
L["seen %d h ago"] = "visto há %d h"
L["seen today"] = "visto hoje"
L["seen yesterday"] = "visto ontem"
L["seen %d days ago"] = "visto há %d dias"
L["Known by: %s"] = "Conhecida por: %s"
L["None of the characters you can mail to knows this smelt."] = "Nenhum dos personagens para quem você pode enviar correio conhece esta receita de fundição."
L["Smelt only at the Black Forge."] = "Fundição só na Forja Negra."
L["Smelt It/Dealt It needs a price addon. Install or enable one of: %s"] = "Smelt It/Dealt It precisa de um addon de preços. Instale ou ative um destes: %s"
L["Scan the auction house with %s to see prices."] = "Faça uma varredura na casa de leilões com %s para ver os preços."
L["Every Smelt Recipe is hidden. Show some in the options."] = "Todas as receitas de fundição estão ocultas. Mostre algumas nas opções."
L["Open your Mining window once so the table knows what you can smelt."] = "Abra sua janela de Mineração uma vez para que a tabela saiba o que você pode fundir."
L["Options"] = "Opções"
L["/smelt opens the Smelt Table, and /smelt options opens the options."] = "/smelt abre a tabela de fundição, e /smelt options abre as opções."
L["Smelt It/Dealt It: possible new smelts detected:"] = "Smelt It/Dealt It: possíveis novas receitas de fundição detectadas:"
L["- %s"] = "- %s"
L["Open the Smelt Table."] = "Abre a tabela de fundição."
L["Prices"] = "Preços"
L["A difference at or below the larger of these two is a Toss-up: too small to be worth the time to smelt."] = "Uma diferença igual ou menor que o maior destes dois valores é um Empate: pequena demais para valer o tempo de fundir."
L["Toss-up percent"] = "Percentual de empate"
L["Toss-up minimum"] = "Mínimo de empate"
L["Any gain"] = "Qualquer ganho"
L["Big gains only"] = "Só grandes ganhos"
L["%d%%"] = "%d%%"
L["An auction price not seen for this long gets a warning icon in the Smelt Table."] = "Um preço de leilão não visto há esse tempo recebe um ícone de alerta na tabela de fundição."
L["Stale after"] = "Desatualizado após"
L["Only fresh scans"] = "Só varreduras recentes"
L["Two weeks"] = "Duas semanas"
L["1 hour"] = "1 hora"
L["%d hours"] = "%d horas"
L["1 day"] = "1 dia"
L["%d days"] = "%d dias"
L["Access"] = "Acesso"
L["/smelt always opens the Smelt Table. These add two more ways in."] = "/smelt sempre abre a tabela de fundição. Estas opções adicionam mais duas formas de abri-la."
L["Show a button on the auction house"] = "Mostrar um botão na casa de leilões"
L["Show in the addon compartment"] = "Mostrar no compartimento de addons"
L["Smelt Recipes"] = "Receitas de fundição"
L["Unchecked recipes leave the Smelt Table."] = "Receitas desmarcadas somem da tabela de fundição."
L["Version %s | Locale: %s"] = "Versão %s | Idioma: %s"
L["Reset to defaults"] = "Restaurar padrões"
