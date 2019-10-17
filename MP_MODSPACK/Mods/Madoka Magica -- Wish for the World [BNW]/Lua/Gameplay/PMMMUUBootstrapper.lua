-- PMMMUUBootstrapper
-- Author: Vicevirtuoso
-- DateCreated: 6/17/2014 11:34:05 AM
--------------------------------------------------------------


--Currently, we will load all UUs regardless of whether or not a Civ which uses them is present (or even a Militaristic CS).
--It's rather easy for a mod Civ to get UUs from other Civs using Lua, so we don't want our UUs ending up useless in that case.



include("PMMMBubbleBomber.lua")
include("PMMMClockstopper.lua")
include("PMMMCutlassConductor.lua")
include("PMMMMagiclaw.lua")
include("PMMMRosebowInfantry.lua")
include("PMMMTiroMusketeer.lua")
include("PMMMClaraDoll.lua")
include("PMMMHeraldOfMadoka.lua")
include("PMMMArtificialIncubator.lua")

function OnSetXYUUFunctions(iPlayer, iUnit, iX, iY)
		GrantNewPromotionOnImprovement(iPlayer, iUnit)
		GrantNewPromotionInCity(iPlayer, iUnit)
		Magiclaw(iPlayer, iUnit, true)
		BubbleBomber(iPlayer, iUnit)
		ClaraDoll(iPlayer, iUnit, true)
		OnArtificialIncubatorSetXY(iPlayer, iUnit, iX, iY)
end

function OnDoTurnUUFunctions(iPlayer)
		local bFirstLoop = true
		for unit in Players[iPlayer]:Units() do
			local id = unit:GetID()
			GrantNewPromotionOnImprovement(iPlayer, id)
			GrantNewPromotionInCity(iPlayer, id)
			Magiclaw(iPlayer, id, bFirstLoop)
			BubbleBomber(iPlayer, id)
			ClaraDoll(iPlayer, id, false)
			bNotFirstLoop = false
		end
	if iPlayer < iMaxCivs then
		ExpendHarmony(iPlayer)
	end
	RemoveDefenseDebuff(iPlayer)
end


function OnCaptureCompleteUUFunctions(iCapturedPlayer, bCapital, iX, iY, iCapturingPlayer, bConquest)
	if bConquest and iCapturingPlayer < iMaxCivs then
		Clockstopper(iCapturedPlayer, bCapital, iX, iY, iCapturingPlayer, bConquest)
	end
end


function OnUnitPromotedUUFunctions(iPlayer, iUnit)
	if iPlayer < iMaxCivs then
		AddHarmonyOnLevel(iPlayer, iUnit)
	end
end

function OnCustomMissionPossibleUUFunctions(iPlayer, iUnit, iMission, iData1, iData2, _, _, iPlotX, iPlotY, bTestVisible)
	local bReturn = TiroFinaleCustomMissionPossible(iPlayer, iUnit, iMission, iData1, iData2, _, _, iPlotX, iPlotY, bTestVisible)
	if not bReturn then
		bReturn = HeraldCustomMissionPossible(iPlayer, iUnit, iMission, iData1, iData2, _, _, iPlotX, iPlotY, bTestVisible)
	end
	if not bReturn then
		bReturn = PolishCustomMissionPossible(iPlayer, iUnit, iMission, iData1, iData2, _, _, iPlotX, iPlotY, bTestVisible)
	end
	return bReturn
end

function OnCustomMissionStartUUFunctions(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	local bReturn = TiroFinaleCustomMissionStart(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	if bReturn == 0 then
		bReturn = HeraldCustomMissionStart(iPlayer, iUnit, iMission, iData1, iData2, _, _, iPlotX, iPlotY, bTestVisible)
	end
	if bReturn == 0 then
		bReturn = PolishCustomMissionStart(iPlayer, iUnit, iMission, iData1, iData2, _, _, iPlotX, iPlotY, bTestVisible)
	end
	return bReturn
end

function OnCustomMissionCompletedUUFunctions(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	local bReturn = TiroFinaleCustomMissionCompleted(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	if not bReturn then
		bReturn = HeraldCustomMissionCompleted(iPlayer, iUnit, iMission, iData1, iData2, _, _, iPlotX, iPlotY, bTestVisible)
	end
	if not bReturn then
		bReturn = PolishCustomMissionCompleted(iPlayer, iUnit, iMission, iData1, iData2, _, _, iPlotX, iPlotY, bTestVisible)
	end
	return bReturn
end