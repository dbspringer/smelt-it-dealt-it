std = "lua51"
max_line_length = 120
self = false

exclude_files = { ".release/", "libs/" }

globals = {
  "SLASH_SMELTITDEALTIT1",
  "SLASH_SMELTITDEALTIT2",
  "SlashCmdList",
  "SmeltItDealtItDB",
}

read_globals = {
  "Auctionator",
  "ButtonFrameTemplate_HideButtonBar",
  "ButtonFrameTemplate_HidePortrait",
  "C_AddOns",
  "C_Item",
  "CreateFrame",
  "GameTooltip",
  "GameTooltip_SetTitle",
  "GetMoneyString",
  "GRAY_FONT_COLOR",
  "GREEN_FONT_COLOR",
  "HIGHLIGHT_FONT_COLOR",
  "Item",
  "LIST_DELIMITER",
  "RED_FONT_COLOR",
  "RETRIEVING_ITEM_INFO",
  "UIParent",
  "UISpecialFrames",
}

files["spec"] = { std = "+busted" }
-- A translated sentence can't wrap.
files["locales"] = { max_line_length = false }
