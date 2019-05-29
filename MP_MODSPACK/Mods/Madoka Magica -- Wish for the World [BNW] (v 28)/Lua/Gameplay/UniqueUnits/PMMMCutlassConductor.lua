-- PMMMCutlassConductor
-- Author: Vicevirtuoso
-- DateCreated: 6/13/2014 1:32:50 AM
--------------------------------------------------------------



include('PMMMGeneralFunctions.lua');

local iDummy = GameInfoTypes.BUILDING_PMMM_CUTLASS_CONDUCTOR_DUMMY



--When a CC gets a level-up, grant it more Harmony. Currently, it is the level multiplied by the harmony from all promotions.
function AddHarmonyOnLevel(iPlayer, iUnit)
	if iPlayer < iMaxCivs then
		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iUnit)
		local iHarmonyPerLevel = 0;
		for k, v in pairs(MapModData.gPMMMHarmonyPromotions) do
			if pUnit:IsHasPromotion(k) then
				iHarmonyPerLevel = iHarmonyPerLevel + v
			end
		end
		if iHarmonyPerLevel > 0 then
			local iLevel = pUnit:GetLevel()
			local iTotalHarmonyGained = iHarmonyPerLevel * iLevel
			local iSpecialID = GetUnitSpecialID(iPlayer, iUnit)
			if not PMMM.Harmony[iSpecialID] then
				PMMM.Harmony[iSpecialID] = iTotalHarmonyGained
			else
				PMMM.Harmony[iSpecialID] = PMMM.Harmony[iSpecialID] + iTotalHarmonyGained
			end
		end
	end
end


--Grant a dummy building in each city which has a unit with Harmony garrisoned in it.
function ExpendHarmony(iPlayer)
	if iPlayer < iMaxCivs then
		local pPlayer = Players[iPlayer]
		for pCity in pPlayer:Cities() do
			if pCity:GetGarrisonedUnit() then
				local pUnit = pCity:GetGarrisonedUnit()
				local iUnit = pUnit:GetID()
				local iSpecialID = GetUnitSpecialID(iPlayer, iUnit)
				if PMMM.Harmony[iSpecialID] then
					if PMMM.Harmony[iSpecialID] > 0 then
						PMMM.Harmony[iSpecialID] = PMMM.Harmony[iSpecialID] - 1
						pCity:SetNumRealBuilding(iDummy, 1)
					else
						pCity:SetNumRealBuilding(iDummy, 0)
					end
				else
					pCity:SetNumRealBuilding(iDummy, 0)
				end
			else
				pCity:SetNumRealBuilding(iDummy, 0)
			end
		end
	end
end
