-- Gustavus Trait Replacement
-- Author: Vicevirtuoso
-- DateCreated: 6/14/2014 3:05:06 PM
--------------------------------------------------------------



include('PMMMGeneralFunctions.lua');

function GustavusTrait(iPlayer, iUnit, bDontTestNextUnit)
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnit)
	local pThisPlot = pUnit:GetPlot()
	dprint("Running Gustavus trait on " ..pUnit:GetName())
	local CombatTypes = {}
	table.insert(CombatTypes, pUnit:GetUnitCombatType())
	local direction_types = {
				DirectionTypes.DIRECTION_NORTHEAST,	
				DirectionTypes.DIRECTION_EAST,
				DirectionTypes.DIRECTION_SOUTHEAST,
				DirectionTypes.DIRECTION_SOUTHWEST,	
				DirectionTypes.DIRECTION_WEST,
				DirectionTypes.DIRECTION_NORTHWEST
	}
	for k, v in pairs(MapModData.gPMMMAdjacentUnitCombats[iPlayer]) do
		for a, direction in ipairs(direction_types) do
			local pPlot = Map.PlotDirection(pThisPlot:GetX(), pThisPlot:GetY(), direction)
			if pPlot then
				if pPlot:IsUnit() then
					dprint("Unit found on plot")
					for c = 0, pPlot:GetNumUnits() -1 do
						local pPlotUnit = pPlot:GetUnit(c)
						if pPlotUnit then
							if pPlotUnit:GetOwner() == iPlayer and pPlotUnit:IsCombatUnit() then
								dprint("Owner is same as unit")
								local bAddToTable = true
								local iThisCombatType = pPlotUnit:GetUnitCombatType()
								if iThisCombatType > -1 then
									for k2, v2 in pairs(CombatTypes) do
										if iThisCombatType == v2 then
											dprint("Same combat type.")
											bAddToTable = false
										end
									end
								end
								if bAddToTable then
									dprint("Different combat type, add to table.")
									table.insert(CombatTypes, iThisCombatType)
									if #CombatTypes >= v.AdjacentDifferentUnitCombatsRequired + 1 then
										dprint("Enough different combat types are found.")
										break
									end
								end
							end
						end
						if not bDontTestNextUnit then
							GustavusTrait(iPlayer, pPlotUnit:GetID(), true)
						end
					end
				end
			end
			if #CombatTypes >= v.AdjacentDifferentUnitCombatsRequired + 1 then
				dprint("Enough different combat types are found.")
				break
			end
		end
		if #CombatTypes >= v.AdjacentDifferentUnitCombatsRequired + 1 then
			dprint("Grant promotion")
			pUnit:SetHasPromotion(v.PromotionType, true)
		else
			dprint("Remove promotion")
			pUnit:SetHasPromotion(v.PromotionType, false)
		end
	end
end

function OnTurnGustavusTrait(iPlayer)
	if iPlayer < iMaxCivs then
		if MapModData.gPMMMAdjacentUnitCombats[iPlayer] then
			for k, v in pairs(MapModData.gPMMMAdjacentUnitCombats[iPlayer]) do
				if v.AdjacentDifferentUnitCombatsRequired > 0 then
					for unit in Players[iPlayer]:Units() do
						if unit:IsCombatUnit() then
							GustavusTrait(iPlayer, unit:GetID(), true)
						end
					end
				end
			end
		end
	end
end


function OnMoveGustavusTrait(iPlayer, iUnit)
	if iPlayer < iMaxCivs then
		if MapModData.gPMMMAdjacentUnitCombats[iPlayer] then
			for k, v in pairs(MapModData.gPMMMAdjacentUnitCombats[iPlayer]) do
				if v.AdjacentDifferentUnitCombatsRequired > 0 then
					local pPlayer = Players[iPlayer]
					local pUnit = pPlayer:GetUnitByID(iUnit)
					if pUnit:IsCombatUnit() then
						GustavusTrait(iPlayer, iUnit)
					end
				end
			end
		end
	end	
end
