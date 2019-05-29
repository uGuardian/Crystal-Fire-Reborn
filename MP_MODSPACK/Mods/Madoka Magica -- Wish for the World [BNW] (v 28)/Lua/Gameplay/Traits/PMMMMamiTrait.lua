-- Mami Trait Script
-- Author: Vicevirtuoso
-- DateCreated: 8/21/2013 12:04:47 AM
--------------------------------------------------------------


include('PMMMGeneralFunctions.lua');

--Gunpowder Combat Strength up per CS Ally
function CityStateCombatStrengthUp(iPlayer)
	if MapModData.gPMMMTraits[iPlayer].CityStateCombatStrengthModTimes100 > 0 then
		local pPlayer = Players[iPlayer]
		local iStrengthBonus = 0;
		for iLoopPlayer, pLoopPlayer in pairs(Players) do
			if pLoopPlayer:IsMinorCiv() then
				if pLoopPlayer:GetMinorCivFriendshipLevelWithMajor(iPlayer) >= 2 then
					iStrengthBonus = iStrengthBonus + 1;
				end
			end
		end
		iStrengthBonus = math.floor(iStrengthBonus * MapModData.gPMMMTraits[iPlayer].CityStateCombatStrengthModTimes100 / 100)
		for unit in pPlayer:Units() do
			if unit:GetUnitCombatType() == GameInfoTypes.UNITCOMBAT_GUN then
				unit:SetBaseCombatStrength(GameInfo.Units[unit:GetUnitType()].Combat + iStrengthBonus)
			end
		end
	end
end
