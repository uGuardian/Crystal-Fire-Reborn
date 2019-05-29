-- Farsight Oracle
-- Author: Vicevirtuoso
-- DateCreated: 6/14/2014 2:40:23 PM
--------------------------------------------------------------

local iImprovement = GameInfoTypes.IMPROVEMENT_PMMM_FARSIGHT_ORACLE
local iPromotion = GameInfoTypes.PROMOTION_PMMM_FARSIGHT_ORACLE

local iLand = DomainTypes.DOMAIN_LAND

function FarsightOracle(iPlayer, iUnit)
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnit)
	if not pUnit then return end
	local pPlot = pUnit:GetPlot()
	if pPlot then
		if pPlot:GetImprovementType() == iImprovement then
			if pPlot:GetOwner() == iPlayer then
				pUnit:SetHasPromotion(iPromotion, true)
			else
				pUnit:SetHasPromotion(iPromotion, false)
			end
		else
			pUnit:SetHasPromotion(iPromotion, false)
		end
	end
end


function OnTurnFarsightOracle(iPlayer)
	if iPlayer < GameDefines.MAX_MAJOR_CIVS then
		for unit in Players[iPlayer]:Units() do
			if unit:IsCombatUnit() and unit:GetDomainType() == iLand then
				FarsightOracle(iPlayer, unit:GetID())
			end
		end
	end
end



function OnMoveFarsightOracle(iPlayer, iUnit)
	if iPlayer < GameDefines.MAX_MAJOR_CIVS then
		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iUnit)
		if pUnit:IsCombatUnit() and pUnit:GetDomainType() == iLand then
			FarsightOracle(iPlayer, iUnit)
		end
	end	
end