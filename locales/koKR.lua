local _, ns = ...

if GetLocale() ~= "koKR" then
    return
end

-- Machine translation. Corrections are welcome.
--
-- One word for each glossary term (CONTEXT.md), used in every string below:
--   Smelt (Verdict): 제련
--   Sell Raw: 그대로 판매
--   Toss-up: 차이 없음
--   Verdict: 판정
--   Raw Value: 원재료 가치
--   Smelted Value: 주괴 가치
--   Smelt Profit: 제련 수익
--   Smelt Table: 제련 표
--   Smelt Recipe: 제련 제조법
--   Reagent: 재료
--   Bar: 주괴
--   Stale: 오래된 가격
--   No Data: 데이터 없음
--   AH Cut: 경매장 수수료
--   Address: no pronoun

local L = ns.L

L["Bar"] = "주괴"
L["Reagents"] = "재료"
L["Raw Value"] = "원재료 가치"
L["Smelted Value"] = "주괴 가치"
L["Difference"] = "차이"
L["Verdict"] = "판정"
L["Smelt Profit"] = "제련 수익"
L["Smelt"] = "제련"
L["Sell Raw"] = "그대로 판매"
L["Toss-up"] = "차이 없음"
L["No data"] = "데이터 없음"
L["%s x%d"] = "%s x%d"
L["The bar that one smelt makes, and how many."] = "제련 한 번으로 만드는 주괴와 그 개수."
L["What one smelt uses up."] = "제련 한 번에 드는 재료."
L["What you keep if you sell the reagents as they are, after the 5% auction house cut."] = "재료를 그대로 팔 때 경매장 수수료 5%를 뺀 뒤 남는 금액."
L["What you get for the bars, after the 5% auction house cut."] = "경매장 수수료 5%를 뺀 뒤 주괴로 받는 금액."
L["Smelted Value minus Raw Value."] = "주괴 가치에서 원재료 가치를 뺀 값."
L["Smelt or Sell Raw, or Toss-up when the difference is too small to be worth the time."] = "제련 또는 그대로 판매. 차이가 시간을 들일 만큼 크지 않으면 차이 없음."
L["What you make if you buy the reagents at these prices, smelt them, and sell the bars."] = "이 가격으로 재료를 사서 제련한 뒤 주괴를 팔 때 버는 금액."
L["%s each, %s"] = "개당 %s, %s"
L["no price"] = "가격 없음"
L["vendor price"] = "상인 가격"
L["age unknown"] = "확인 시점 불명"
L["seen just now"] = "방금 확인"
L["seen %d min ago"] = "%d분 전 확인"
L["seen %d h ago"] = "%d시간 전 확인"
L["seen today"] = "오늘 확인"
L["seen yesterday"] = "어제 확인"
L["seen %d days ago"] = "%d일 전 확인"
L["Known by: %s"] = "아는 캐릭터: %s"
L["None of the characters you can mail to knows this smelt."] = "우편을 보낼 수 있는 캐릭터 중 이 제련법을 아는 캐릭터가 없습니다."
L["Smelt only at the Black Forge."] = "검은 용광로에서만 제련할 수 있습니다."
L["Smelt only at a Molten Foundry."] = "용융 제련소에서만 제련할 수 있습니다."
L["Smelt It/Dealt It needs a price addon. Install or enable one of: %s"] = "Smelt It/Dealt It에는 가격 애드온이 필요합니다. 다음 중 하나를 설치하거나 활성화하세요: %s"
L["Scan the auction house with %s to see prices."] = "%s(으)로 경매장을 검색하여 가격을 확인하세요."
L["Every Smelt Recipe is hidden. Show some in the options."] = "모든 제련 제조법이 숨겨져 있습니다. 설정에서 일부를 표시하세요."
L["Open your Mining window once so the table knows what you can smelt."] = "채광 창을 한 번 열어 주세요. 그러면 표에서 제련할 수 있는 항목을 알 수 있습니다."
L["Options"] = "설정"
L["/smelt opens the Smelt Table, and /smelt options opens the options."] = "/smelt는 제련 표를, /smelt options는 설정을 엽니다."
L["Smelt It/Dealt It: possible new smelts detected:"] = "Smelt It/Dealt It: 새로운 제련법이 발견되었을 수 있습니다:"
L["- %s"] = "- %s"
L["Open the Smelt Table."] = "제련 표를 엽니다."
L["Prices"] = "가격"
L["A difference at or below the larger of these two is a Toss-up: too small to be worth the time to smelt."] = "차이가 이 두 값 중 큰 값 이하이면 차이 없음입니다. 제련할 시간이 아까울 만큼 작습니다."
L["Toss-up percent"] = "차이 없음 기준(%)"
L["Toss-up minimum"] = "차이 없음 최소 금액"
L["Any gain"] = "작은 이득도"
L["Big gains only"] = "큰 이득만"
L["%d%%"] = "%d%%"
L["An auction price not seen for this long gets a warning icon in the Smelt Table."] = "이 기간 동안 보이지 않은 경매 가격에는 제련 표에 경고 아이콘이 표시됩니다."
L["Stale after"] = "오래된 가격 기준"
L["Only fresh scans"] = "최신 검색만"
L["Two weeks"] = "2주"
L["1 hour"] = "1시간"
L["%d hours"] = "%d시간"
L["1 day"] = "1일"
L["%d days"] = "%d일"
L["Access"] = "접근"
L["Show a button on the auction house"] = "경매장에 버튼 표시"
L["Show in the addon compartment"] = "애드온 모음에 표시"
L["Smelt Recipes"] = "제련 제조법"
L["Version %s | Locale: %s"] = "버전 %s | 언어: %s"
L["Reset to defaults"] = "기본값으로 초기화"
