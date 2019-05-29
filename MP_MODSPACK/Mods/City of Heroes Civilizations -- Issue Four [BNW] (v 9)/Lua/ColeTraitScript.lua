-- ColeTraitScript
-- Author: Vicevirtuoso
-- DateCreated: 4/20/2014 8:40:39 PM
--------------------------------------------------------------

local iPraetoria = GameInfoTypes.CIVILIZATION_PRAETORIA



function StrengthFromVictoryPoints(iPlayer)
	if iPlayer < GameDefines.MAX_MAJOR_CIVS and tTraits[iPlayer].VictoryPointsPerStrengthPoint > 0 then
		local pPlayer = Players[iPlayer]
		local iScore = pPlayer:GetScore()
		local iStrengthBonus = math.floor(iScore / tTraits[iPlayer].VictoryPointsPerStrengthPoint)
		for pUnit in pPlayer:Units() do
			if pUnit:IsCombatUnit() then
				pUnit:SetBaseCombatStrength(GameInfo.Units[pUnit:GetUnitType()].Combat + iStrengthBonus)
			end
		end
	end
end



