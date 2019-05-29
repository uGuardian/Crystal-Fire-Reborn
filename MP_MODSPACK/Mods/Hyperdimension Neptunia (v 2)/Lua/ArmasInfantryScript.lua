-- ArmasInfantryScript
-- Author: Vice
-- DateCreated: 11/1/2015 9:29:37 AM
--------------------------------------------------------------

local MAX_CIVS = GameDefines.MAX_MAJOR_CIVS
local ARMAS = GameInfoTypes.UNIT_VV_ARMAS
local PROMOS = {
	GameInfoTypes.PROMOTION_VV_ARMAS_L1,
	GameInfoTypes.PROMOTION_VV_ARMAS_L2,
	GameInfoTypes.PROMOTION_VV_ARMAS_L3,
	GameInfoTypes.PROMOTION_VV_ARMAS_L4,
	GameInfoTypes.PROMOTION_VV_ARMAS_L5
}

local tArmasLevelsByPlayer = {}

function UpdateArmasInfantry(iPlayer, pUnit)
	local pPlayer = Players[iPlayer]
	local iLevel = tArmasLevelsByPlayer[iPlayer] - 1
	if iLevel > #PROMOS then iLevel = #PROMOS end
	if pUnit then
		if pUnit:GetUnitType() == ARMAS then
			for iThisLevel, iPromotion in pairs(PROMOS) do
				pUnit:SetHasPromotion(iPromotion, iLevel == iThisLevel)
			end
		end
	else
		for pUnit in pPlayer:Units() do
			if pUnit:GetUnitType() == ARMAS then
				for iThisLevel, iPromotion in pairs(PROMOS) do
					pUnit:SetHasPromotion(iPromotion, iLevel == iThisLevel)
				end
			end
		end
	end
end

function OnLoadScreenClose()
	for iPlayer = 0, MAX_CIVS - 1, 1 do
		local pPlayer = Players[iPlayer]
		if pPlayer:IsEverAlive() then
			tArmasLevelsByPlayer[iPlayer] = 1
			for pUnit in pPlayer:Units() do
				if pUnit:GetUnitType() == ARMAS and pUnit:GetLevel() > tArmasLevelsByPlayer[iPlayer] then
					tArmasLevelsByPlayer[iPlayer] = pUnit:GetLevel()
				end
			end
		end
	end
end
Events.LoadScreenClose.Add(OnLoadScreenClose)

function OnArmasInfantryPromoted(iPlayer, iUnitID, iPromotion)
	if iPlayer < MAX_CIVS then
		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iUnitID)
		if pUnit:GetUnitType() == ARMAS and pUnit:GetLevel() > tArmasLevelsByPlayer[iPlayer] then
			tArmasLevelsByPlayer[iPlayer] = pUnit:GetLevel()
			UpdateArmasInfantry(iPlayer)
		end
	end
end
GameEvents.UnitPromoted.Add(OnArmasInfantryPromoted)

function OnArmasSetXY(iPlayer, iUnit, iX, iY)
	if iX > 0 and iY > 0 and iPlayer < MAX_CIVS then
		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iUnit)
		if pUnit:GetUnitType() == ARMAS then
			UpdateArmasInfantry(iPlayer, pUnit)
		end
	end
end
GameEvents.UnitSetXY.Add(OnArmasSetXY)