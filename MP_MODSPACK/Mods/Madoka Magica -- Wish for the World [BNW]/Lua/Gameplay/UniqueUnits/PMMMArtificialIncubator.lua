-- PMMMArtificialIncubator
-- Author: Vicevirtuoso
-- DateCreated: 8/14/2014 10:36:12 AM
--------------------------------------------------------------

local iPromotionType = GameInfoTypes.PROMOTION_PMMM_ARTIFICIAL_INCUBATOR
local iMissionType = MissionTypes.MISSION_PMMM_POLISH
local iPolishAmount = GameInfo.Missions[iMissionType].PMMMPolishAmount
local iMagicalGirlClass = GameInfoTypes.UNITCLASS_PMMM_MAGICAL_GIRL

function PolishCustomMissionPossible(iPlayer, iUnit, iMission, iData1, iData2, _, _, iPlotX, iPlotY, bTestVisible)
	if iPlayer < iMaxCivs then
		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iUnit)
		if pUnit:IsHasPromotion(iPromotionType) and iMission == iMissionType then
			return true
		end
	end
	return false
end


function PolishCustomMissionStart(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	if iMission == iMissionType then
		DoPolish(iPlayer, Players[iPlayer]:GetUnitByID(iUnit), Map.GetPlot(-iData1, -iData2))
	end
	return 0
end

function PolishCustomMissionCompleted(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	if iMission == iMissionType then
		return true
	end
	return false
end


function DoPolish(iPlayer, pHeadUnit, pPlot)
	for i = 0, pPlot:GetNumUnits() - 1 do
		local pUnit = pPlot:GetUnit(i)
		if pUnit:GetUnitClassType() == iMagicalGirlClass and pUnit:GetOwner() == iPlayer then
			local iMGKey = GetMagicalGirlKey(pUnit:GetOwner(), pUnit:GetID())
			if iMGKey then
				if MagicalGirls[iMGKey].Polish then
					MagicalGirls[iMGKey].Polish = math.min(MagicalGirls[iMGKey].Polish + iPolishAmount, GameDefines.MAXIMUM_SOUL_GEM_POLISH_AMOUNT)
				else
					MagicalGirls[iMGKey].Polish = iPolishAmount
				end
				if iPlayer == Game:GetActivePlayer() then
					Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(pPlot:GetX(), pPlot:GetY()))), Locale.ConvertTextKey("TXT_KEY_PMMM_TILEPOPUP_SOUL_GEM_POLISH", iPolishAmount), 1)
				end
				pHeadUnit:SetMoves(0)
				return
			end
		end
	end
end




--When AIs move Artificial Incubators, if a valid magical girl is nearby, push the mission instantly.
function OnArtificialIncubatorSetXY(iPlayer, iUnit, iX, iY)
	if iX > 0 and iY > 0 then
		local pPlayer = Players[iPlayer]
		if not pPlayer:IsHuman() then
			local pUnit = pPlayer:GetUnitByID(iUnit)
			if pUnit:IsHasPromotion(iPromotionType) then
				for pAreaPlot in PlotAreaSpiralIterator(pUnit:GetPlot(), 1, 1, true, true, true) do
					if pAreaPlot:IsUnit() then
						for c = 0, pAreaPlot:GetNumUnits() - 1 do
							local pPlotUnit = pAreaPlot:GetUnit(c)
							if pPlotUnit then
								if pPlotUnit:GetOwner() == iPlayer and pPlotUnit:GetUnitClassType() == iMagicalGirlClass then
									DoPolish(iPlayer, pUnit, pAreaPlot)
								end
							end
						end
					end
				end
			end
		end
	end
end