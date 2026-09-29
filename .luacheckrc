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
  "AddonCompartmentFrame",
  "Auctionator",
  "AuctionHouseFrame",
  "ButtonFrameTemplate_HideButtonBar",
  "ButtonFrameTemplate_HidePortrait",
  "C_AddOns",
  "C_Item",
  "C_Timer",
  "C_TradeSkillUI",
  "CreateFrame",
  "CreateMinimalSliderFormatter",
  "ERR_NOT_IN_COMBAT",
  "GameTooltip",
  "GameTooltip_SetTitle",
  "GetAutoCompleteRealms",
  "GetMoneyString",
  "GetNormalizedRealmName",
  "GetProfessionInfo",
  "GetProfessions",
  "GRAY_FONT_COLOR",
  "GREEN_FONT_COLOR",
  "HIGHLIGHT_FONT_COLOR",
  "InCombatLockdown",
  "Item",
  "LIST_DELIMITER",
  "MinimalSliderWithSteppersMixin",
  "RED_FONT_COLOR",
  "RETRIEVING_ITEM_INFO",
  "Settings",
  "SettingsPanel",
  "UIErrorsFrame",
  "UIParent",
  "UISpecialFrames",
  "UnitFactionGroup",
  "UnitName",
}

files["spec"] = { std = "+busted" }
-- A translated sentence can't wrap.
files["locales"] = { max_line_length = false }
