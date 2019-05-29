-- NemesisTraitScript
-- Author: Vicevirtuoso
-- DateCreated: 10/4/2014 2:40:10 PM
--------------------------------------------------------------

local iNemesisDummy = GameInfoTypes.BUILDING_NEMESIS_DUMMY

function NemesisIntrigueBonus(iPlayer)
	if tNemesisPlayers[iPlayer] then
		local pPlayer = Players[iPlayer]
		if pPlayer:IsAlive() then
			local intrigueMessages = pPlayer:GetIntrigueMessages();
			local pCapital = pPlayer:GetCapitalCity()
			if pCapital then
				pCapital:SetNumRealBuilding(iNemesisDummy, #intrigueMessages)
			end
		end
	end
end

local pNemesisHealPlot;

function OnNemesisCanSaveUnit(iPlayer, iUnitID)
	if tNemesisPlayers[iPlayer] then
		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iUnitID)
		if (pUnit:IsCombatUnit()) and (pUnit:GetDomainType() == DomainTypes.DOMAIN_LAND or pUnit:GetDomainType() == DomainTypes.DOMAIN_SEA) then
			pNemesisHealPlot = pUnit:GetPlot()
		end
	end
end


function OnNemesisUnitKilledInCombat(iKiller, iPlayer, iUnitType)
	if tNemesisPlayers[iPlayer] and pNemesisHealPlot then
		for pPlot in PlotAreaSpiralIterator(pNemesisHealPlot, 1) do
			if pPlot:IsUnit() then
				for c = 0, pPlot:GetNumUnits() -1 do
					local pPlotUnit = pPlot:GetUnit(c)
					if pPlotUnit and pPlotUnit:GetOwner() == iPlayer and pPlotUnit:GetDamage() > 0 then
						pPlotUnit:ChangeDamage(math.max(-10, pPlotUnit:GetDamage() * -1))
					end
				end
			end
		end
	end
	pNemesisHealPlot = nil
end