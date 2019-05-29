-- Planeptune Pyramids CBP Workaround
-- Author: Vice
--------------------------------------------------------------

print("Neptune's CBP fix loaded, because without it, she thinks the Pyramids are granaries and it crashes the game!")

local iPyramids = GameInfoTypes.BUILDING_PYRAMID_VV_NEPTUNE
function OnCityConstructedPyramids(iPlayer, iCity, iBuildingType, bGold, bFaithOrCulture)
	if iBuildingType == iPyramids then
		local pPlayer = Players[iPlayer]
		pPlayer:AddFreeUnit(GameInfoTypes.UNIT_SETTLER, UNITAI_SETTLE)
	end
end
GameEvents.CityConstructed.Add(OnCityConstructedPyramids)