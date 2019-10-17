-- Magiclaw
-- Author: Vicevirtuoso
-- DateCreated: 6/14/2014 2:57:34 PM
--------------------------------------------------------------




function Magiclaw(iPlayer, iUnit, bTestAllEnemies)
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnit)
	if not pUnit then return end
	dprint("Running Magiclaw function.")
	for k, v in pairs(MapModData.gPMMMAdjacentEnemyDebuffs) do
		-- Supposed to use the much faster CP methods, but they cause crashes, so let's not!
		--pUnit:SetHasPromotion(v.EnemyPromotionType, pUnit:IsWithinDistanceOfUnitPromotion(k, v.Radius, false, true))
	
		
		--Test if this unit gets a debuff.
		local bThisUnitStaysDebuffed = MagiclawLoopTest(k, v.Radius, pPlayer, pUnit:GetPlot())
		if bThisUnitStaysDebuffed then
			pUnit:SetHasPromotion(v.EnemyPromotionType, true)
			dprint("Unit debuffed")
		else
			pUnit:SetHasPromotion(v.EnemyPromotionType, false)
			if bDebugPlots then
				dprint("Unit not debuffed")
			end
		end
		--Test if any enemy unit gets a debuff, but only if the function call said to do it.
		if bTestAllEnemies then
			local pTeam = Teams[pPlayer:GetTeam()]
			for iEnemyPlayer, pEnemyPlayer in pairs(Players) do
				if iEnemyPlayer ~= iPlayer then
					if pTeam:IsAtWar(pEnemyPlayer:GetTeam()) or iEnemyPlayer == 63 then
						for pEnemyUnit in pEnemyPlayer:Units() do
							local bEnemyUnitDebuffed = MagiclawLoopTest(k, v.Radius, pEnemyPlayer, pEnemyUnit:GetPlot())
							if bEnemyUnitDebuffed then
								dprint("Unit debuffed")
								pEnemyUnit:SetHasPromotion(v.EnemyPromotionType, true)
							else
								if bDebugPlots then
									dprint("Unit not debuffed")
								end
								pEnemyUnit:SetHasPromotion(v.EnemyPromotionType, false)
							end
						end
					end
				end
			end
		end
	end
end


function MagiclawLoopTest(iBuffPromo, iRadius, pPlayer, pPlot)
	if bDebugPlots then
		dprint("New test loop")
	end
	local pTeam = Teams[pPlayer:GetTeam()]
	for pAreaPlot in PlotAreaSpiralIterator(pPlot, iRadius, 1, true, true, false) do
		if bDebugPlots then
			dprint("Testing units on plot at " ..pAreaPlot:GetX().. ", " ..pAreaPlot:GetY())
		end
		if pAreaPlot:IsUnit() then
			for c = 0, pAreaPlot:GetNumUnits() - 1 do
				local pPlotUnit = pAreaPlot:GetUnit(c)
				if pPlotUnit then
					if pTeam:IsAtWar(Players[pPlotUnit:GetOwner()]:GetTeam()) and pPlotUnit:IsHasPromotion(iBuffPromo) then
						dprint("Found a unit at war with the original unit's owner which has the debuff promotion.")
						return true
					end
				end
			end
		end
	end
	return false
end