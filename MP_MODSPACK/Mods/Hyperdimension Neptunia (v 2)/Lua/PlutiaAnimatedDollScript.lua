-- Plutia's Animated Doll script
-- Author: Vice
-- DateCreated: 11/1/2015 9:29:37 AM
--------------------------------------------------------------

local TECH_SWORDSMAN		=	-1;
local TECH_LONGSWORDSMAN	=	-1;
for row in GameInfo.Units("Type = 'UNIT_SWORDSMAN'") do
	if row.PrereqTech and GameInfo.Technologies[row.PrereqTech] then
		TECH_SWORDSMAN = GameInfo.Technologies[row.PrereqTech].ID
	end
end
for row in GameInfo.Units("Type = 'UNIT_LONGSWORDSMAN'") do
	if row.PrereqTech and GameInfo.Technologies[row.PrereqTech] then
		TECH_LONGSWORDSMAN = GameInfo.Technologies[row.PrereqTech].ID
	end
end


function OnTrainedAnimatedDoll(iPlayer, iCity, iUnit)
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnit)
	local iUnitType = pUnit:GetUnitType()
	local sUnitType = GameInfo.Units[iUnitType].Type
	
	if string.find(sUnitType, "UNIT_VV_ANIMATED_DOLL") then
		local pCity = pPlayer:GetCityByID(iCity)
		local pTeamTechs = Teams[pPlayer:GetTeam()]:GetTeamTechs()
		local iNumUnits = 1
		if pTeamTechs:HasTech(TECH_SWORDSMAN) then iNumUnits = iNumUnits + 1 end
		if pTeamTechs:HasTech(TECH_LONGSWORDSMAN) then iNumUnits = iNumUnits + 1 end
		for i = 1, iNumUnits, 1 do
			local pNewUnit = pPlayer:InitUnit(iUnitType, pCity:GetX(), pCity:GetY())
			if pNewUnit then
				pNewUnit:SetExperience(pCity:GetDomainFreeExperience(pUnit:GetDomainType()))
				pNewUnit:JumpToNearestValidPlot()
				for promotion in GameInfo.UnitPromotions() do
					iPromotion = promotion.ID
						if (pCity:GetFreePromotionCount(iPromotion) > 0 and pNewUnit:IsPromotionValid(iPromotion)) then
						pNewUnit:SetHasPromotion(iPromotion, true)
					end
				end
			end
		end
	end
end
GameEvents.CityTrained.Add(OnTrainedAnimatedDoll)