local _, ns = ...

if GetLocale() ~= "ruRU" then
    return
end

-- Machine translation. Corrections are welcome.
--
-- One word for each glossary term (CONTEXT.md), used in every string below:
--   Smelt (Verdict): Переплавить
--   Sell Raw: Продать сырьём
--   Toss-up: Без разницы
--   Verdict: Вердикт
--   Raw Value: Стоимость сырья
--   Smelted Value: Стоимость слитков
--   Smelt Profit: Прибыль
--   Smelt Table: таблица выплавки
--   Smelt Recipe: рецепт выплавки
--   Reagent: реагент
--   Bar: слиток
--   Stale: устаревший
--   No Data: Нет данных
--   AH Cut: сбор аукциона
--   Raw Value, column header: Сырьё
--   Smelted Value, column header: Слитки
--   Address: вы/ваш

local L = ns.L

L["Bar"] = "Слиток"
L["Reagents"] = "Реагенты"
L["Raw Value"] = "Сырьё"
L["Smelted Value"] = "Слитки"
L["Difference"] = "Разница"
L["Verdict"] = "Вердикт"
L["Smelt Profit"] = "Прибыль"
L["Smelt"] = "Переплавить"
L["Sell Raw"] = "Продать сырьём"
L["Toss-up"] = "Без разницы"
L["No data"] = "Нет данных"
L["%s x%d"] = "%s x%d"
L["The bar that one smelt makes, and how many."] = "Слиток, который даёт одна выплавка, и сколько."
L["What one smelt uses up."] = "Что расходует одна выплавка."
L["What you keep if you sell the reagents as they are, after the 5% auction house cut."] = "Сколько вы сохраните, если продадите реагенты как есть, после сбора аукциона в 5 %."
L["What you get for the bars, after the 5% auction house cut."] = "Сколько вы получите за слитки после сбора аукциона в 5 %."
L["Smelted Value minus Raw Value."] = "Стоимость слитков минус стоимость сырья."
L["Smelt or Sell Raw, or Toss-up when the difference is too small to be worth the time."] = "Переплавить или Продать сырьём, либо Без разницы, когда разница слишком мала, чтобы тратить на неё время."
L["What you make if you buy the reagents at these prices, smelt them, and sell the bars."] = "Сколько вы заработаете, если купите реагенты по этим ценам, выплавите их и продадите слитки."
L["%s each, %s"] = "%s за шт., %s"
L["no price"] = "нет цены"
L["vendor price"] = "цена торговца"
L["age unknown"] = "возраст неизвестен"
L["seen just now"] = "видели только что"
L["seen %d min ago"] = "видели %d мин. назад"
L["seen %d h ago"] = "видели %d ч. назад"
L["seen today"] = "видели сегодня"
L["seen yesterday"] = "видели вчера"
L["seen %d days ago"] = "видели %d дн. назад"
L["Known by: %s"] = "Знают: %s"
L["None of the characters you can mail to knows this smelt."] = "Никто из персонажей, которым вы можете отправить почту, не знает этот рецепт выплавки."
L["Smelt only at the Black Forge."] = "Выплавка только в Чёрной кузне."
L["Smelt only at a Molten Foundry."] = "Выплавка только в Расплавленной литейной."
L["Smelt It/Dealt It needs a price addon. Install or enable one of: %s"] = "Для работы Smelt It/Dealt It нужен аддон с ценами. Установите или включите один из: %s"
L["Scan the auction house with %s to see prices."] = "Просканируйте аукцион с помощью %s, чтобы увидеть цены."
L["Every Smelt Recipe is hidden. Show some in the options."] = "Все рецепты выплавки скрыты. Покажите некоторые в настройках."
L["Open your Mining window once so the table knows what you can smelt."] = "Откройте окно горного дела один раз, чтобы таблица знала, что вы можете выплавить."
L["Options"] = "Настройки"
L["/smelt opens the Smelt Table, and /smelt options opens the options."] = "/smelt открывает таблицу выплавки, а /smelt options — настройки."
L["Smelt It/Dealt It: possible new smelts detected:"] = "Smelt It/Dealt It: найдены возможные новые рецепты выплавки:"
L["- %s"] = "- %s"
L["Open the Smelt Table."] = "Открывает таблицу выплавки."
L["Prices"] = "Цены"
L["A difference at or below the larger of these two is a Toss-up: too small to be worth the time to smelt."] = "Если разница не превышает больший из этих двух порогов, это «Без разницы»: она слишком мала, чтобы тратить время на выплавку."
L["Toss-up percent"] = "Порог в процентах"
L["Toss-up minimum"] = "Минимальный порог"
L["Any gain"] = "Любая выгода"
L["Big gains only"] = "Только большая выгода"
L["%d%%"] = "%d%%"
L["An auction price not seen for this long gets a warning icon in the Smelt Table."] = "Цена аукциона, не виденная столько времени, получает значок предупреждения в таблице выплавки."
L["Stale after"] = "Устаревает через"
L["Only fresh scans"] = "Только свежие сканы"
L["Two weeks"] = "Две недели"
L["1 hour"] = "1 час"
L["%d hours"] = "%d ч."
L["1 day"] = "1 день"
L["%d days"] = "%d дн."
L["Access"] = "Доступ"
L["Show a button on the auction house"] = "Показывать кнопку на аукционе"
L["Show in the addon compartment"] = "Показывать в отсеке аддонов"
L["Smelt Recipes"] = "Рецепты выплавки"
L["Version %s | Locale: %s"] = "Версия %s | Язык: %s"
L["Reset to defaults"] = "Сбросить настройки"
