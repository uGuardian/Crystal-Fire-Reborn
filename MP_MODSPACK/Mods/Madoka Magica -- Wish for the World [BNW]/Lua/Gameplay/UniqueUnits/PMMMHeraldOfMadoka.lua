-- PMMMHeraldOfMadoka
-- Author: Vicevirtuoso
-- DateCreated: 7/15/2014 11:39:02 AM
--------------------------------------------------------------



local iPromotion = GameInfoTypes.PROMOTION_PMMM_HERALD_OF_MADOKA
local iMissionType = MissionTypes.MISSION_PMMM_LEAD_AWAY

function HeraldCustomMissionPossible(iPlayer, iUnit, iMission, iData1, iData2, _, _, iPlotX, iPlotY, bTestVisible)
	if iPlayer < iMaxCivs then
		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iUnit)
		--lazy and specifying one promotion for now
		if pUnit:IsHasPromotion(iPromotion) and iMission == iMissionType then
			if pUnit:GetSpreadsLeft() >= 2 then
				return true
			else
				return bTestVisible
			end
		end
	end
	return false
end


function HeraldCustomMissionStart(iPlayer, iUnit, iMission, iData1, iData2, _, _, iPlotX, iPlotY, bTestVisible)
	if iMission == iMissionType and iPlayer == Game:GetActivePlayer() then
		if not tMissionInfo.MissionID or (tMissionInfo.MissionID and tMissionInfo.MissionID ~= iMission) then
			SetCustomMissionInfo(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
			SetTargetHexHighlights()
		else
			CleanMissionInfo()
			ClearAllHighlights()
		end
	end
	return 0
end


function HeraldCustomMissionCompleted(iPlayer, iUnit, iMission, iData1, iData2, _, _, iPlotX, iPlotY, bTestVisible)
	if iMission == iMissionType and iPlayer == Game:GetActivePlayer() then
		return true
	end
	return false
end

function DoLawOfCyclesMission(iPlayer, pUnit, pPlot)
	local pPlayer = Players[iPlayer]
	local iNumUnits = pPlot:GetNumUnits();
	for i = 0, iNumUnits do
		pEnemyUnit = pPlot:GetUnit(i);
		if pEnemyUnit:GetUnitType() == GameInfoTypes.UNIT_PMMM_MAGICAL_GIRL then
			local iMGKey = GetMagicalGirlKey(pEnemyUnit:GetOwner(), pEnemyUnit:GetID())
			if iMGKey and MagicalGirls[iMGKey].IsLeader == false then
				if MagicalGirls[iMGKey].SoulGemState == GameInfoTypes.PMMM_SGSTATE_CRITICAL then
					--Time to leave this world! (for 10 turns)
					DoLawOfCyclesTakeaway(iMGKey, iPlayer)
					pUnit:Kill(true)
					return
				end
			end
		end
	end
end