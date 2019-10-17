-- PMMMClaraDoll
-- Author: Vicevirtuoso
-- DateCreated: 7/2/2014 2:04:52 PM
--------------------------------------------------------------





function ClaraDoll(iPlayer, iUnit, bTestAllAllies)
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnit)
	if not pUnit then return end
	dprint("Running ClaraDoll function.")
	-- Supposed to use the much faster CP methods, but they cause crashes, so let's not!
	-- for k, v in pairs(MapModData.gPMMMAdjacentAllyBuffs) do
		-- pUnit:SetHasPromotion(v.NewPromotionType, pUnit:IsWithinDistanceOfUnitPromotion(k, v.Radius, true, false))
	-- end
	if bTestAllAllies then
		for pAllyUnit in pPlayer:Units() do
			for k, v in pairs(MapModData.gPMMMAdjacentAllyBuffs) do
				local bThisUnitStaysBuffed = ClaraDollLoopTest(k, v.Radius, pPlayer, pAllyUnit, pAllyUnit:GetPlot())
				if bThisUnitStaysBuffed then
					pAllyUnit:SetHasPromotion(v.NewPromotionType, true)
					dprint("Unit buffed")
				else
					pAllyUnit:SetHasPromotion(v.NewPromotionType, false)
					if bDebugPlots then
						dprint("Unit not buffed")
					end
				end
			end
		end
	else
		for k, v in pairs(MapModData.gPMMMAdjacentAllyBuffs) do
			local bThisUnitStaysBuffed = ClaraDollLoopTest(k, v.Radius, pPlayer, pUnit, pUnit:GetPlot())
			if bThisUnitStaysBuffed then
				pUnit:SetHasPromotion(v.NewPromotionType, true)
				dprint("Unit buffed")
			else
				pUnit:SetHasPromotion(v.NewPromotionType, false)
				if bDebugPlots then
					dprint("Unit not buffed")
				end
			end
		end
	end
end


function ClaraDollLoopTest(iBuffPromo, iRadius, pPlayer, pUnit, pPlot)
	if bDebugPlots then
		dprint("New test loop")
	end
	if pPlot then
		for c = 0, pPlot:GetNumUnits() - 1 do
			local pPlotUnit = pPlot:GetUnit(c)
			if pPlotUnit and pPlotUnit ~= pUnit then
				if pPlotUnit:GetOwner() == pPlayer:GetID() and pPlotUnit:IsHasPromotion(iBuffPromo) then
					dprint("Found an allied unit with the buff promotion.")
					return true
				end
			end
		end
		if iRadius > 0 then
			for pAreaPlot in PlotAreaSpiralIterator(pPlot, iRadius, 1, true, true, false) do
				if bDebugPlots then
					dprint("Testing units on plot at " ..pAreaPlot:GetX().. ", " ..pAreaPlot:GetY())
				end
				if pAreaPlot:IsUnit() then
					for c = 0, pAreaPlot:GetNumUnits() - 1 do
						local pPlotUnit = pAreaPlot:GetUnit(c)
						if pPlotUnit then
							if pPlotUnit:GetOwner() == pPlayer:GetID() and pPlotUnit:IsHasPromotion(iBuffPromo) then
								dprint("Found an allied unit with the buff promotion.")
								return true
							end
						end
					end
				end
			end
		end
	end
	return false
end