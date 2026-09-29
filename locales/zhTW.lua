local _, ns = ...

if GetLocale() ~= "zhTW" then
    return
end

-- Machine translation. Corrections are welcome.
--
-- One word for each glossary term (CONTEXT.md), used in every string below:
--   Smelt (Verdict): 熔鍊
--   Sell Raw: 直接出售
--   Toss-up: 持平
--   Verdict: 建議
--   Raw Value: 原料價值
--   Smelted Value: 錠價值
--   Smelt Profit: 熔鍊利潤
--   Smelt Table: 熔鍊表
--   Smelt Recipe: 熔鍊配方
--   Reagent: 材料
--   Bar: 錠
--   Stale: 過期
--   No Data: 無資料
--   AH Cut: 拍賣場手續費
--   Address: 你

local L = ns.L

L["Bar"] = "錠"
L["Reagents"] = "材料"
L["Raw Value"] = "原料價值"
L["Smelted Value"] = "錠價值"
L["Difference"] = "差額"
L["Verdict"] = "建議"
L["Smelt Profit"] = "熔鍊利潤"
L["Smelt"] = "熔鍊"
L["Sell Raw"] = "直接出售"
L["Toss-up"] = "持平"
L["No data"] = "無資料"
L["%s x%d"] = "%s x%d"
L["The bar that one smelt makes, and how many."] = "一次熔鍊得到的錠及數量。"
L["What one smelt uses up."] = "一次熔鍊消耗的材料。"
L["What you keep if you sell the reagents as they are, after the 5% auction house cut."] = "直接出售材料時，扣除5%拍賣場手續費後能保留的錢。"
L["What you get for the bars, after the 5% auction house cut."] = "扣除5%拍賣場手續費後，錠能賣到的錢。"
L["Smelted Value minus Raw Value."] = "錠價值減去原料價值。"
L["Smelt or Sell Raw, or Toss-up when the difference is too small to be worth the time."] = "熔鍊或直接出售；差額太小、不值得花時間時為持平。"
L["What you make if you buy the reagents at these prices, smelt them, and sell the bars."] = "按這些價格買入材料、熔鍊並賣出錠所賺的錢。"
L["%s each, %s"] = "每個 %s，%s"
L["no price"] = "無價格"
L["vendor price"] = "商人價格"
L["age unknown"] = "時間未知"
L["seen just now"] = "剛剛見過"
L["seen %d min ago"] = "%d分鐘前見過"
L["seen %d h ago"] = "%d小時前見過"
L["seen today"] = "今天見過"
L["seen yesterday"] = "昨天見過"
L["seen %d days ago"] = "%d天前見過"
L["Known by: %s"] = "已學會：%s"
L["None of the characters you can mail to knows this smelt."] = "你能寄信的角色都沒有學會這個熔鍊配方。"
L["Smelt only at the Black Forge."] = "只能在黑色熔爐熔鍊。"
L["Smelt It/Dealt It needs a price addon. Install or enable one of: %s"] = "Smelt It/Dealt It 需要一個價格插件。請安裝或啟用以下之一：%s"
L["Scan the auction house with %s to see prices."] = "用 %s 掃描拍賣場來查看價格。"
L["Every Smelt Recipe is hidden. Show some in the options."] = "所有熔鍊配方都已隱藏。請在選項中顯示一些。"
L["Open your Mining window once so the table knows what you can smelt."] = "開啟一次你的採礦視窗，讓表格知道你能熔鍊什麼。"
L["Options"] = "選項"
L["/smelt opens the Smelt Table, and /smelt options opens the options."] = "/smelt 開啟熔鍊表，/smelt options 開啟選項。"
L["Smelt It/Dealt It: possible new smelts detected:"] = "Smelt It/Dealt It：發現可能新增的熔鍊配方："
L["- %s"] = "- %s"
L["Open the Smelt Table."] = "開啟熔鍊表。"
L["Prices"] = "價格"
L["A difference at or below the larger of these two is a Toss-up: too small to be worth the time to smelt."] = "差額不超過這兩個值中較大者即為持平：太小，不值得花時間熔鍊。"
L["Toss-up percent"] = "持平百分比"
L["Toss-up minimum"] = "持平最低金額"
L["Any gain"] = "任何收益"
L["Big gains only"] = "僅限大額收益"
L["%d%%"] = "%d%%"
L["An auction price not seen for this long gets a warning icon in the Smelt Table."] = "超過這段時間未見的拍賣價格會在熔鍊表中顯示警告圖示。"
L["Stale after"] = "過期時間"
L["Only fresh scans"] = "僅限最新掃描"
L["Two weeks"] = "兩週"
L["1 hour"] = "1小時"
L["%d hours"] = "%d小時"
L["1 day"] = "1天"
L["%d days"] = "%d天"
L["Access"] = "入口"
L["Show a button on the auction house"] = "在拍賣場顯示按鈕"
L["Show in the addon compartment"] = "在小地圖插件選單中顯示"
L["Smelt Recipes"] = "熔鍊配方"
L["Version %s | Locale: %s"] = "版本 %s | 語言：%s"
L["Reset to defaults"] = "恢復預設"
