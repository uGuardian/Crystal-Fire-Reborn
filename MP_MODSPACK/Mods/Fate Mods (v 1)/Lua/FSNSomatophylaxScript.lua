-- FSNSomatophylaxScript
-- Author: Vicevirtuoso
-- DateCreated: 9/25/2014 4:18:18 PM
--------------------------------------------------------------

include("PlotIterators.lua")

local iMaxCivs = GameDefines.MAX_MAJOR_CIVS
local iBuffPromo = GameInfoTypes.PROMOTION_SOMATOPHYLAX_BUFF
local iGABuff = GameInfoTypes.PROMOTION_SOMATOPHYLAX_GOLDEN_AGE_BONUS
local iNotGABuff = GameInfoTypes.PROMOTION_SOMATOPHYLAX_NOT_GOLDEN_AGE_BONUS
local iRadius = 1

print("Rider Somatophylax Script")

function OnTurnSomatophylax(iPlayer)
	local pPlayer = Players[iPlayer]
	if iPlayer < iMaxCivs and pPlayer:IsAlive() then
		for pUnit in pPlayer:Units() do
			Somatophylax(iPlayer, pUnit:GetID(), false)
		end
	end
end

GameEvents.PlayerDoTurn.Add(OnTurnSomatophylax)

function OnSetXYSomatophylax(iPlayer, iUnit, iX, iY)
	if iX > 0 and iY > 0 and iPlayer < iMaxCivs then
		local pPlayer = Players[iPlayer]
		Somatophylax(iPlayer, iUnit, true)
	end
end

GameEvents.UnitSetXY.Add(OnSetXYSomatophylax)

function Somatophylax(iPlayer, iUnit, bTestAllAllies)
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnit)
	local bIsGoldenAge = pPlayer:IsGoldenAge()
	if not pUnit then return end
	if bTestAllAllies then
		for pAllyUnit in pPlayer:Units() do
			local bThisUnitStaysBuffed = SomatophylaxLoopTest(pPlayer, pAllyUnit, pAllyUnit:GetPlot())
			if bThisUnitStaysBuffed then
				pAllyUnit:SetHasPromotion(iGABuff, bIsGoldenAge)
				pAllyUnit:SetHasPromotion(iNotGABuff, not bIsGoldenAge)
			else
				pAllyUnit:SetHasPromotion(iGABuff, false)
				pAllyUnit:SetHasPromotion(iNotGABuff, false)
			end
		end
	else
		local bThisUnitStaysBuffed = SomatophylaxLoopTest(pPlayer, pUnit, pUnit:GetPlot())
		if bThisUnitStaysBuffed then
			pUnit:SetHasPromotion(iGABuff, bIsGoldenAge)
			pUnit:SetHasPromotion(iNotGABuff, not bIsGoldenAge)
		else
			pUnit:SetHasPromotion(iGABuff, false)
			pUnit:SetHasPromotion(iNotGABuff, false)
		end
	end
end


function SomatophylaxLoopTest(pPlayer, pUnit, pPlot)
	if pPlot then
		for c = 0, pPlot:GetNumUnits() - 1 do
			local pPlotUnit = pPlot:GetUnit(c)
			if pPlotUnit and pPlotUnit ~= pUnit then
				if pPlotUnit:GetOwner() == pPlayer:GetID() and pPlotUnit:IsHasPromotion(iBuffPromo) then
					return true
				end
			end
		end
		if iRadius > 0 then
			for pAreaPlot in PlotAreaSpiralIterator(pPlot, iRadius, 1, true, true, false) do
				if pAreaPlot:IsUnit() then
					for c = 0, pAreaPlot:GetNumUnits() - 1 do
						local pPlotUnit = pAreaPlot:GetUnit(c)
						if pPlotUnit then
							if pPlotUnit:GetOwner() == pPlayer:GetID() and pPlotUnit:IsHasPromotion(iBuffPromo) then
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