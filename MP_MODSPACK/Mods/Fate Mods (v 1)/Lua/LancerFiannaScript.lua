-- LancerFiannaScript
-- Author: Vicevirtuoso
-- DateCreated: 9/27/2014 1:23:32 AM
--------------------------------------------------------------



local iHuntsman = GameInfoTypes.PROMOTION_LANCER_HUNTSMAN
local iHuntsmanBonus = GameInfoTypes.PROMOTION_LANCER_HUNTSMAN_BONUS
local iMaxCivs = GameDefines.MAX_MAJOR_CIVS

--Fianna unit: Check for resource healing bonus
function FiannaHealingBonus(iPlayer, iUnitID, iX, iY)
	if iX > 0 and iY > 0 and iPlayer < iMaxCivs then
		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iUnitID)
		if pUnit and pUnit:IsHasPromotion(iHuntsman) then
			local pPlot = pUnit:GetPlot()
			if pPlot:GetResourceType(Game.GetActiveTeam()) == GameInfoTypes.RESOURCE_DEER or pPlot:GetResourceType(Game.GetActiveTeam()) == GameInfoTypes.RESOURCE_COW or pPlot:GetResourceType(Game.GetActiveTeam()) == GameInfoTypes.RESOURCE_SHEEP or pPlot:GetResourceType(Game.GetActiveTeam()) == GameInfoTypes.RESOURCE_FUR then
				pUnit:SetHasPromotion(iHuntsmanBonus, true)
			else
				pUnit:SetHasPromotion(iHuntsmanBonus, false)
			end
		else
			pUnit:SetHasPromotion(iHuntsmanBonus, false)
		end
	end
end

GameEvents.UnitSetXY.Add(FiannaHealingBonus)