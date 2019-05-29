-- Bubble Bomber
-- Author: Vicevirtuoso
-- DateCreated: 6/14/2014 3:03:51 PM
--------------------------------------------------------------



include('PMMMGeneralFunctions.lua');

dprint("Bubble Bomber Script.")

function BubbleBomber(iPlayer, iUnit)
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnit)
	if not pUnit then return end
	for k in pairs(MapModData.gPMMMAdjacentEnemyBuffs) do
		if pUnit:IsHasPromotion(k) then
			dprint("Testing nearby enemy units for a " ..pUnit:GetName())
			local direction_types = {
				DirectionTypes.DIRECTION_NORTHEAST,	
				DirectionTypes.DIRECTION_EAST,
				DirectionTypes.DIRECTION_SOUTHEAST,
				DirectionTypes.DIRECTION_SOUTHWEST,	
				DirectionTypes.DIRECTION_WEST,
				DirectionTypes.DIRECTION_NORTHWEST
			}
			local pTeam = Teams[pPlayer:GetTeam()]
			local bIsFoundEnemy = false
			for a, direction in ipairs(direction_types) do
				local pPlot = pUnit:GetPlot()
				for b = 0, MapModData.gPMMMAdjacentEnemyBuffs[k].Radius, 1 do
					pPlot = Map.PlotDirection(pPlot:GetX(), pPlot:GetY(), direction)
					if pPlot then
						if bDebugPlots then
							dprint("Testing units on plot at " ..pPlot:GetX().. ", " ..pPlot:GetY())
						end
						if pPlot:IsUnit() then
							for c = 0, pPlot:GetNumUnits() -1 do
								local pPlotUnit = pPlot:GetUnit(c)
								if pPlotUnit then
									if pTeam:IsAtWar(pPlotUnit:GetOwner():GetTeam()) then
										dprint("Found a unit at war with the original unit's owner.")
										pUnit:SetHasPromotion(MapModData.gPMMMAdjacentEnemyBuffs[k].NewPromotionType, true)
										bIsFoundEnemy = true
										break
									end
								end
							end
						end
					end
					if bIsFoundEnemy then
						break
					end
				end
				if bIsFoundEnemy then
					break
				end
			end
			if not bIsFoundEnemy then
				pUnit:SetHasPromotion(MapModData.gPMMMAdjacentEnemyBuffs[k].NewPromotionType, false)
			end
		end
	end
end

function OnTurnBubbleBomber(iPlayer)
	if iPlayer < iMaxCivs then
		for unit in Players[iPlayer]:Units() do
			BubbleBomber(iPlayer, unit:GetID())
		end
	end
end


function OnMoveBubbleBomber(iPlayer, iUnit)
	if iPlayer < iMaxCivs then
			BubbleBomber(iPlayer, iUnit)
	end	
end
