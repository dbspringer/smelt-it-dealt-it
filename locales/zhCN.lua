local _, ns = ...

if GetLocale() ~= "zhCN" then
    return
end

-- Machine translation. Corrections are welcome.
--
-- One word for each glossary term (CONTEXT.md), used in every string below:
--   Smelt (Verdict): 熔炼
--   Sell Raw: 直接出售
--   Toss-up: 持平
--   Verdict: 建议
--   Raw Value: 原料价值
--   Smelted Value: 锭价值
--   Smelt Profit: 熔炼利润
--   Smelt Table: 熔炼表
--   Smelt Recipe: 熔炼配方
--   Reagent: 材料
--   Bar: 锭
--   Stale: 过期
--   No Data: 无数据
--   AH Cut: 拍卖行手续费
--   Address: 你

local L = ns.L

L["Bar"] = "锭"
L["Reagents"] = "材料"
L["Raw Value"] = "原料价值"
L["Smelted Value"] = "锭价值"
L["Difference"] = "差额"
L["Verdict"] = "建议"
L["Smelt Profit"] = "熔炼利润"
L["Smelt"] = "熔炼"
L["Sell Raw"] = "直接出售"
L["Toss-up"] = "持平"
L["No data"] = "无数据"
L["%s x%d"] = "%s x%d"
L["The bar that one smelt makes, and how many."] = "一次熔炼得到的锭及数量。"
L["What one smelt uses up."] = "一次熔炼消耗的材料。"
L["What you keep if you sell the reagents as they are, after the 5% auction house cut."] = "直接出售材料时，扣除5%拍卖行手续费后能保留的钱。"
L["What you get for the bars, after the 5% auction house cut."] = "扣除5%拍卖行手续费后，锭能卖到的钱。"
L["Smelted Value minus Raw Value."] = "锭价值减去原料价值。"
L["Smelt or Sell Raw, or Toss-up when the difference is too small to be worth the time."] = "熔炼或直接出售；差额太小、不值得花时间时为持平。"
L["What you make if you buy the reagents at these prices, smelt them, and sell the bars."] = "按这些价格买入材料、熔炼并卖出锭所赚的钱。"
L["%s each, %s"] = "每个 %s，%s"
L["no price"] = "无价格"
L["vendor price"] = "商人价格"
L["age unknown"] = "时间未知"
L["seen just now"] = "刚刚见过"
L["seen %d min ago"] = "%d分钟前见过"
L["seen %d h ago"] = "%d小时前见过"
L["seen today"] = "今天见过"
L["seen yesterday"] = "昨天见过"
L["seen %d days ago"] = "%d天前见过"
L["Known by: %s"] = "已学会：%s"
L["None of the characters you can mail to knows this smelt."] = "你能寄信的角色都没有学会这个熔炼配方。"
L["Smelt only at the Black Forge."] = "只能在黑熔炉熔炼。"
L["Smelt It/Dealt It needs a price addon. Install or enable one of: %s"] = "Smelt It/Dealt It 需要一个价格插件。请安装或启用以下之一：%s"
L["Scan the auction house with %s to see prices."] = "用 %s 扫描拍卖行来查看价格。"
L["Every Smelt Recipe is hidden. Show some in the options."] = "所有熔炼配方都已隐藏。请在选项中显示一些。"
L["Open your Mining window once so the table knows what you can smelt."] = "打开一次你的采矿窗口，让表格知道你能熔炼什么。"
L["Options"] = "选项"
L["/smelt opens the Smelt Table, and /smelt options opens the options."] = "/smelt 打开熔炼表，/smelt options 打开选项。"
L["Smelt It/Dealt It: possible new smelts detected:"] = "Smelt It/Dealt It：发现可能新增的熔炼配方："
L["- %s"] = "- %s"
L["Open the Smelt Table."] = "打开熔炼表。"
L["Prices"] = "价格"
L["A difference at or below the larger of these two is a Toss-up: too small to be worth the time to smelt."] = "差额不超过这两个值中较大者即为持平：太小，不值得花时间熔炼。"
L["Toss-up percent"] = "持平百分比"
L["Toss-up minimum"] = "持平最低金额"
L["Any gain"] = "任何收益"
L["Big gains only"] = "仅限大额收益"
L["%d%%"] = "%d%%"
L["An auction price not seen for this long gets a warning icon in the Smelt Table."] = "超过这段时间未见的拍卖价格会在熔炼表中显示警告图标。"
L["Stale after"] = "过期时间"
L["Only fresh scans"] = "仅限最新扫描"
L["Two weeks"] = "两周"
L["1 hour"] = "1小时"
L["%d hours"] = "%d小时"
L["1 day"] = "1天"
L["%d days"] = "%d天"
L["Access"] = "入口"
L["/smelt always opens the Smelt Table. These add two more ways in."] = "/smelt 总是打开熔炼表。以下选项再增加两种打开方式。"
L["Show a button on the auction house"] = "在拍卖行显示按钮"
L["Show in the addon compartment"] = "在小地图插件菜单中显示"
L["Smelt Recipes"] = "熔炼配方"
L["Unchecked recipes leave the Smelt Table."] = "取消勾选的配方会从熔炼表中移除。"
L["Reset to defaults"] = "恢复默认"
