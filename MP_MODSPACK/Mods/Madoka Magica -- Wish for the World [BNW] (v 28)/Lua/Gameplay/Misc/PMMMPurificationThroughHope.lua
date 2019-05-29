-- PMMMPurificationThroughHope
-- Author: Vicevirtuoso
-- DateCreated: 11/22/2014 1:05:48 PM
--------------------------------------------------------------

--------------------------------------------------------
-- "Missionaries clean Soul Gems" Reformation Belief
--------------------------------------------------------

local iBelief = GameInfoTypes.BELIEF_HEATHEN_CONVERSION  --co-opted base game belief
local iMissionType = GameInfoTypes.MISSION_PMMM_PURIFICATION_THROUGH_HOPE
local iMissionaryClass = GameInfoTypes.UNITCLASS_MISSIONARY

function PurificationThroughHopeCustomMissionPossible(iPlayer, iUnit, iMission, iData1, iData2, _, _, iPlotX, iPlotY, bTestVisible)
	if iPlayer < iMaxCivs then
		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iUnit)
		if pUnit:GetUnitClassType() == iMissionaryClass and iMission == iMissionType then
			local iReligion = pUnit:GetReligion()
			local bCanPurify;
			for i,v in ipairs(Game.GetBeliefsInReligion(iReligion)) do
				local belief = GameInfo.Beliefs[v];
				if belief.AllowMissionarySGPurification == 1 then
					bCanPurify = true
					break
				end
			end
			if bCanPurify then
				if pUnit:GetSpreadsLeft() >= 2 then
					local pPlot = pUnit:GetPlot()
					if pPlot then
						local iNumUnits = pPlot:GetNumUnits()
						for c = 0, iNumUnits - 1, 1 do
							local pPlotUnit = pPlot:GetUnit(c)
							if pPlotUnit ~= pUnit and pPlotUnit:GetUnitClassType() == GameInfoTypes.UNITCLASS_PMMM_MAGICAL_GIRL and pPlotUnit:GetOwner() == iPlayer then
								local iKey = GetMagicalGirlKey(iPlayer, pPlotUnit:GetID())
								if iKey then
									if MagicalGirls[iKey].SoulGem < 100 then
										return true
									else
										return bTestVisible
									end
								else
									return bTestVisible
								end
							else
								return bTestVisible
							end
						end
					else
						return bTestVisible
					end
				else
					return bTestVisible
				end
			end
		end
	end
	return false
end


function PurificationThroughHopeCustomMissionStart(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	if iMission == iMissionType then
		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iUnit)
		local pPlot = pUnit:GetPlot()
		local iNumUnits = pPlot:GetNumUnits()

		for c = 0, iNumUnits - 1, 1 do
			local pPlotUnit = pPlot:GetUnit(c)
			if pPlotUnit ~= pUnit and pPlotUnit:GetUnitClassType() == GameInfoTypes.UNITCLASS_PMMM_MAGICAL_GIRL and pPlotUnit:GetOwner() == iPlayer then
				local iKey = GetMagicalGirlKey(iPlayer, pPlotUnit:GetID())
				if iKey then
					local iRecover = math.floor(MapModData.gPMMMGriefSeedRecoverAmount / 2) * -1
					DoChangeCorruption(iRecover, iKey)
					pUnit:Kill(true)
					break
				end
			end
		end

	end
	return 0
end

function PurificationThroughHopeCustomMissionCompleted(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	if iMission == iMissionType then
		return true
	end
	return false
end