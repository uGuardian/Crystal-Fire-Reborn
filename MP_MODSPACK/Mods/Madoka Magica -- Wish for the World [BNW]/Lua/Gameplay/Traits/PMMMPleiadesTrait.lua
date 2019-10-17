-- PMMMPleiadesTrait
-- Author: Vicevirtuoso
-- DateCreated: 8/13/2014 6:56:59 PM
--------------------------------------------------------------

--Most of the Pleiades stuff is going to be coded straight into Lua since separating all of this stuff for a very specific trait would be a waste of resources.
--The prediction calculation values will be put in the Defines, but nothing is going into the Traits table and there won't be a new table for the Result types.

local iMagicalGirlType = GameInfoTypes.UNIT_PMMM_MAGICAL_GIRL
local iFreezerState = GameInfoTypes.MGACTIONSTATE_FREEZER


local iPredictions = {}

iPredictions[1] = {
	["Title"] = "TXT_KEY_PMMM_UI_FREEZER_RESULT_VERYBAD_TITLE",
	["Description"] = "TXT_KEY_PMMM_UI_FREEZER_RESULT_VERYBAD_TEXT"
}

iPredictions[2] = {
	["Title"] = "TXT_KEY_PMMM_UI_FREEZER_RESULT_BAD_TITLE",
	["Description"] = "TXT_KEY_PMMM_UI_FREEZER_RESULT_BAD_TEXT"
}

iPredictions[3] = {
	["Title"] = "TXT_KEY_PMMM_UI_FREEZER_RESULT_NEUTRAL_TITLE",
	["Description"] = "TXT_KEY_PMMM_UI_FREEZER_RESULT_NEUTRAL_TEXT"
}

iPredictions[4] = {
	["Title"] = "TXT_KEY_PMMM_UI_FREEZER_RESULT_GOOD_TITLE",
	["Description"] = "TXT_KEY_PMMM_UI_FREEZER_RESULT_GOOD_TEXT"
}

iPredictions[5] = {
	["Title"] = "TXT_KEY_PMMM_UI_FREEZER_RESULT_VERYGOOD_TITLE",
	["Description"] = "TXT_KEY_PMMM_UI_FREEZER_RESULT_VERYGOOD_TEXT"
}


local iAcademy = GameInfoTypes.IMPROVEMENT_ACADEMY

function GetFreezerStorageMax(iPlayer, ttable)
	if MapModData.gPMMMTraits[iPlayer].EnableFreezerSystem == true or MapModData.gPMMMTraits[iPlayer].EnableFreezerSystem == 1 then
		local iAmount = GameDefines.INITIAL_FREEZER_STORAGE
		local pCapital = Players[iPlayer]:GetCapitalCity()
		if pCapital then
			local iPop = pCapital:GetPopulation()
			local iExtra = math.floor(iPop / GameDefines.POP_NEEDED_FOR_NEXT_FREEZER_STORAGE)
			iAmount = iAmount + iExtra
		end
		if ttable then
			ttable[0] = iAmount
		end
		return iAmount
	end
	if ttable then
		ttable[0] = -1
	end
	return -1
end

LuaEvents.PMMMGetFreezerStorageMax.Add(GetFreezerStorageMax)

function GetFreezerCurrentStorage(iPlayer, ttable)
	if MapModData.gPMMMTraits[iPlayer].EnableFreezerSystem == true or MapModData.gPMMMTraits[iPlayer].EnableFreezerSystem == 1 then
		local iNum = 0;
		for k, v in pairs(MagicalGirls) do
			if v.FreezerPlayer and v.FreezerPlayer == iPlayer then
				iNum = iNum + 1;
			end
		end
		if ttable then
			ttable[0] = iNum
		end
		return iNum
	end
	if ttable then
		ttable[0] = -1
	end
	return -1
end

LuaEvents.PMMMGetFreezerCurrentStorage.Add(GetFreezerCurrentStorage)

function DoPleiadesRevival(iPlayer, iMGKey, iEffectValue, iScience)
	local pPlayer = Players[iPlayer]
	local pTeamTechs = Teams[pPlayer:GetTeam()]:GetTeamTechs()
	pTeamTechs:ChangeResearchProgress(pPlayer:GetCurrentResearch(), -1 * iScience, iPlayer)
	local sText = ""
	local sName = Locale.ConvertTextKey(MagicalGirls[iMGKey].Name)
	if iEffectValue == 1 then
		--Witch Out
		local pCapital = pPlayer:GetCapitalCity()
		local pSpawnPlot;
		for pAreaPlot in PlotAreaSpiralIterator(pCapital:Plot(), 1, 1, false, false, false) do
			if pAreaPlot and not pAreaPlot:IsCity() then
				pSpawnPlot = pAreaPlot
			end
		end
		TurnIntoWitch(iMGKey, pSpawnPlot)
		sText = Locale.ConvertTextKey("TXT_KEY_PMMM_ALERT_FREEZER_VERYBAD", sName)

	elseif iEffectValue == 2 then
		--Simple Kill + 1 success increment
		MagicalGirls[iMGKey].Status = GameInfoTypes.MGACTIONSTATE_DEAD
		sText = Locale.ConvertTextKey("TXT_KEY_PMMM_ALERT_FREEZER_BAD", sName)
		if not PMMM.FreezerSuccesses[iPlayer] then
			PMMM.FreezerSuccesses[iPlayer] = 0
		end
		PMMM.FreezerSuccesses[iPlayer] = PMMM.FreezerSuccesses[iPlayer] + 1
	elseif iEffectValue == 3 then
		--Kill + 1 turn Science + 1 turn Culture + success increment
		MagicalGirls[iMGKey].Status = GameInfoTypes.MGACTIONSTATE_DEAD
		if not PMMM.FreezerSuccesses[iPlayer] then
			PMMM.FreezerSuccesses[iPlayer] = 0
		end
		PMMM.FreezerSuccesses[iPlayer] = PMMM.FreezerSuccesses[iPlayer] + 2
		sText = Locale.ConvertTextKey("TXT_KEY_PMMM_ALERT_FREEZER_NEUTRAL", sName)
		pTeamTechs:ChangeResearchProgress(pPlayer:GetCurrentResearch(), pPlayer:GetScience(), iPlayer)
		pPlayer:ChangeJONSCulture(pPlayer:GetTotalJONSCulturePerTurn())
	elseif iEffectValue == 4 then
		--Revive as MG
		sText = Locale.ConvertTextKey("TXT_KEY_PMMM_ALERT_FREEZER_GOOD", sName)
		tMagicalGirlSpawnTable["ID"] = iMGKey -- this is the shared table used by OnCreatedMagicalGirl
		local pCapital = pPlayer:GetCapitalCity()
		local pPlot = pCapital:Plot()
		local eRevivedGirl = pPlayer:InitUnit(iMagicalGirlType, pPlot:GetX(), pPlot:GetY(), UNITAI_ATTACK)
		SetMagicalGirlStrength(iPlayer, eRevivedGirl:GetID())
		eRevivedGirl:SetMoves(0)
		if not PMMM.FreezerSuccesses[iPlayer] then
			PMMM.FreezerSuccesses[iPlayer] = 0
		end
		PMMM.FreezerSuccesses[iPlayer] = PMMM.FreezerSuccesses[iPlayer] + 2

	elseif iEffectValue == 5 then
		--8 turns of Science + half GA + WLKTD all cities
		pTeamTechs:ChangeResearchProgress(pPlayer:GetCurrentResearch(), pPlayer:GetScience() * 8, iPlayer)
		local iTurns = math.floor(pPlayer:GetGoldenAgeLength() / 2) --half the regular length
		pPlayer:ChangeGoldenAgeTurns(iTurns)
		for pCity in pPlayer:Cities() do
			pCity:ChangeWeLoveTheKingDayCounter(iTurns)
		end
		sText = Locale.ConvertTextKey("TXT_KEY_PMMM_ALERT_FREEZER_VERYGOOD", sName)
		if not PMMM.FreezerSuccesses[iPlayer] then
			PMMM.FreezerSuccesses[iPlayer] = 0
		end
		PMMM.FreezerSuccesses[iPlayer] = PMMM.FreezerSuccesses[iPlayer] + 2
	end
	MagicalGirls[iMGKey].FreezerPlayer = nil
	if iPlayer == Game:GetActivePlayer() then
		Events.GameplayAlertMessage(sText)
	end
	Events.SerialEventCityInfoDirty()
	Events.SerialEventUnitInfoDirty()
end

LuaEvents.PMMMDoPleiadesRevival.Add(DoPleiadesRevival)


--v21: Multiplayer-only Custom Missions to prevent desyncs
local iFreezerMission = MissionTypes.MISSION_PMMM_PLEIADES_FREEZER
local iFreezerGriefSeedMission = MissionTypes.MISSION_PMMM_PLEIADES_FREEZER_GRIEF_SEED

function FreezerCustomMissionStart(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	if iMission == iFreezerMission then
		DoPleiadesRevival(iPlayer, iData1, iData2, iFlags)
	end
	return 0
end

function FreezerGriefSeedCustomMissionStart(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	if iMission == iFreezerGriefSeedMission then
		print(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
		LuaEvents.PMMMUseGriefSeed(iData1, iPlayer, true)
	end
	return 0
end


function GetNumAcademies(iPlayer, ttable)
	local pPlayer = Players[iPlayer]
	local iNum = 0;
	for pCity in pPlayer:Cities() do
		local iNumPlots = pCity:GetNumCityPlots();
		for iPlot = 0, iNumPlots - 1 do
			local pPlot = pCity:GetCityIndexPlot(iPlot)
			if pPlot then
				if pPlot:GetImprovementType() == iAcademy then
					iNum = iNum + 1
				end
			end
		end
	end
	if ttable then
		ttable[0] = iNum
	end
	return iNum
end

LuaEvents.PMMMGetNumAcademies.Add(GetNumAcademies)

function GetPleiadesPrediction(iPlayer, iMGKey, iDivertResearch, ttable)
	local pPlayer = Players[iPlayer]
	local iEraValue = pPlayer:GetCurrentEra() * GameDefines.FREEZER_PER_ERA_VALUE

	local iAcademiesValue = GetNumAcademies(iPlayer) * GameDefines.FREEZER_PER_ACADEMY_VALUE

	local iSoulGemValue = math.floor(MagicalGirls[iMGKey].SoulGem * GameDefines.FREEZER_PER_SOUL_GEM_VALUE_X100 / 100)

	-- It was originally going to be based off of Science Per Turn, but then I realized that was too gameable. Lines are still here in case I change my mind.
	-- local iSciencePerPoint = math.floor(pPlayer:GetScience() / GameDefines.FREEZER_PER_SCIENCE_PER_TURN_VALUE)
	-- local iScienceDivertValue = math.floor(iDivertResearch / iSciencePerPoint)
	
	local iTotalBeakersAllResearched = 0;
	
	for tech in GameInfo.Technologies() do
		if pPlayer:HasTech(tech.ID) then
			iTotalBeakersAllResearched = iTotalBeakersAllResearched + pPlayer:GetResearchCost(tech.ID)
		end
	end
	
	local iScienceDivertValue = math.floor(iDivertResearch / (iTotalBeakersAllResearched * (GameDefines.FREEZER_TOTAL_SCIENCE_PERCENT / 100)))

	if not PMMM.FreezerSuccesses[iPlayer] then
		PMMM.FreezerSuccesses[iPlayer] = 0
	end
	local iPreviousSuccessValue = PMMM.FreezerSuccesses[iPlayer] * GameDefines.FREEZER_PREVIOUS_SUCCESS_VALUE

	local iTotalValue = iEraValue + iAcademiesValue + iSoulGemValue + iScienceDivertValue + iPreviousSuccessValue

	--Very Bad: 0-30
	--Bad: 31-50
	--Neutral: 51-70
	--Good: 71-90
	--Very Good: 91-100+

	if iTotalValue <= 30 then
		ttable[0] = 1
		ttable[1] = iPredictions[1].Title
		ttable[2] = iPredictions[1].Description
		return 1
	elseif iTotalValue >= 31 and iTotalValue <= 50 then
		ttable[0] = 2
		ttable[1] = iPredictions[2].Title
		ttable[2] = iPredictions[2].Description
		return 2
	elseif iTotalValue >= 51 and iTotalValue <= 70 then
		ttable[0] = 3
		ttable[1] = iPredictions[3].Title
		ttable[2] = iPredictions[3].Description
		return 3
	elseif iTotalValue >= 71 and iTotalValue <= 90 then
		ttable[0] = 4
		ttable[1] = iPredictions[4].Title
		ttable[2] = iPredictions[4].Description
		return 4
	else
		ttable[0] = 5
		ttable[1] = iPredictions[5].Title
		ttable[2] = iPredictions[5].Description
		return 5
	end
end

LuaEvents.PMMMGetPleiadesPrediction.Add(GetPleiadesPrediction)




function PleiadesOnCombatEnded(iAttackingPlayer, iAttackingUnit, attackerDamage, attackerFinalDamage, attackerMaxHP, iDefendingPlayer, iDefendingUnit, defenderDamage, defenderFinalDamage, defenderMaxHP, iInterceptingPlayer, iInterceptingUnit, interceptorDamage, plotX, plotY)
	local pEnemyUnit;
	local pPlayer;
	local pEnemyPlayer;

	--Determines which player's unit died, if any, and bases the rest of the code off of that. In case that two Pleiades players are attacking each other.
	if MapModData.gPMMMTraits[iAttackingPlayer] and (MapModData.gPMMMTraits[iAttackingPlayer].EnableFreezerSystem ~= false or MapModData.gPMMMTraits[iAttackingPlayer].EnableFreezerSystem == 1) then
		pEnemyPlayer = Players[iDefendingPlayer]
		if pEnemyPlayer then
			pEnemyUnit = pEnemyPlayer:GetUnitByID(iDefendingUnit)
			if pEnemyUnit:GetCurrHitPoints() == 0 then
				pPlayer = Players[iAttackingPlayer]
			else
				pEnemyUnit = nil
				pEnemyPlayer = nil
			end
		end
	end
	if not pEnemyUnit then
		if MapModData.gPMMMTraits[iDefendingPlayer] and (MapModData.gPMMMTraits[iDefendingPlayer].EnableFreezerSystem == true or MapModData.gPMMMTraits[iDefendingPlayer].EnableFreezerSystem == 1) then
			pEnemyPlayer = Players[iAttackingPlayer]
			if pEnemyPlayer then
				pEnemyUnit = pEnemyPlayer:GetUnitByID(iAttackingUnit)
				if pEnemyUnit:GetCurrHitPoints() == 0 then
					pPlayer = Players[iDefendingPlayer]
				else
					pEnemyUnit = nil
					pEnemyPlayer = nil
				end
			end
		end
	end
	if pEnemyUnit then
		--If we've gotten this far, we can ascertain that there's a dead unit detected and the killer was a Pleiades player.
		local iPlayer = pPlayer:GetID()
		if pEnemyUnit:GetUnitType() == iMagicalGirlType then
			local iMaxFreezer = GetFreezerStorageMax(iPlayer)
			local iCurFreezer = GetFreezerCurrentStorage(iPlayer)
			if iCurFreezer < iMaxFreezer then
				local iMGKey = GetMagicalGirlKey(pEnemyPlayer:GetID(), pEnemyUnit:GetID())
				if iMGKey and not MagicalGirls[iMGKey].IsLeader then
					MagicalGirls[iMGKey].Promotions = {}
					for row in GameInfo.UnitPromotions() do
						if pEnemyUnit:IsHasPromotion(row.ID) then
							MagicalGirls[iMGKey].Promotions[#MagicalGirls[iMGKey].Promotions + 1] = row.ID
						end
					end
					MagicalGirls[iMGKey].XP = pEnemyUnit:GetExperience()
					MagicalGirls[iMGKey].Level = pEnemyUnit:GetLevel()
					MagicalGirls[iMGKey].Status = iFreezerState
					MagicalGirls[iMGKey].FreezerPlayer = iPlayer
					local sText = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_CAPTURED_MG_TO_FREEZER_TEXT", Locale.ConvertTextKey(MagicalGirls[iMGKey].Name))
					local sTitle = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_CAPTURED_MG_TO_FREEZER_TITLE")
					pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, sText, sTitle, plotX, plotY)
				end
			end
		end
	end
end


--Reduce SG of Frozen girls and do AI logic

local iTurnsBetween = GameDefines.FREEZER_TURNS_BETWEEN_SG_DECAY

function OnPleiadesDoTurn(iPlayer)
	if MapModData.gPMMMTraits[iPlayer].EnableFreezerSystem == true or MapModData.gPMMMTraits[iPlayer].EnableFreezerSystem == 1 then
		if Game:GetGameTurn() % iTurnsBetween == 0 then
			for k, v in pairs(MagicalGirls) do
				if v.FreezerPlayer == iPlayer then
					v.SoulGem =	v.SoulGem - 1
					if v.SoulGem <= 0 then
						local sName = Locale.ConvertTextKey(MagicalGirls[iMGKey].Name)
						local pCapital = pPlayer:GetCapitalCity()
						local pSpawnPlot;
						for pAreaPlot in PlotAreaSpiralIterator(pCapital:Plot(), 1, 1, false, false, false) do
							if pAreaPlot and not pAreaPlot:IsCity() then
								pSpawnPlot = pAreaPlot
							end
						end
						TurnIntoWitch(iMGKey, pSpawnPlot)
						if iPlayer == Game:GetActivePlayer() then
							Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_PMMM_ALERT_FREEZER_SG_ZERO", sName))
						end
					end
				end
			end
		end
		local pPlayer = Players[iPlayer]
		if not pPlayer:IsHuman() then
			--AI Logic.
			--In the interest of not crippling the AI, we won't make it spend any science or grief seeds. Therefore, we're really just going to make it pop as soon as possible.
			for k, v in pairs(MagicalGirls) do
				if v.FreezerPlayer == iPlayer then
					local iEffectValue = GetPleiadesPrediction(iPlayer, k, 0, {})
					DoPleiadesRevival(iPlayer, k, iEffectValue, 0)
				end
			end
		end
	end
end


--Pleiades capital gets captured
--For each girl:
--25% chance the girl respawns on the capturer's side.
--50% chance the girl dies.
--25% chance the girl Witches out.

function OnPleiadesCityCapture(iCapturedPlayer, bCapital, iX, iY, iCapturingPlayer, bConquest)
	if iCapturingPlayer < iMaxCivs and iCapturedPlayer < iMaxCivs then
		if (MapModData.gPMMMTraits[iCapturedPlayer].EnableFreezerSystem == true or MapModData.gPMMMTraits[iCapturedPlayer].EnableFreezerSystem == 1) and bCapital and bConquest then
			for k, v in pairs(MagicalGirls) do
				if v.FreezerPlayer == iCapturedPlayer then
					local iChance = Game.Rand(100, "Pleiades Capital Capture Event") + 1
					if iChance <= 25 then
						--Revive as MG
						local sName = Locale.ConvertTextKey(MagicalGirls[iMGKey].Name)
						v.Owner = iCapturingPlayer
						tMagicalGirlSpawnTable["ID"] = iMGKey -- this is the shared table used by OnCreatedMagicalGirl
						local pPlot = Map.GetPlot(iX, iY)
						local eRevivedGirl = pPlayer:InitUnit(iMagicalGirlType, pPlot:GetX(), pPlot:GetY(), UNITAI_ATTACK)
						SetMagicalGirlStrength(iCapturingPlayer, eRevivedGirl:GetID())
						eRevivedGirl:JumpToNearestValidPlot()
						eRevivedGirl:SetMoves(0)
						if iCapturingPlayer == Game:GetActivePlayer() then
							Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_PMMM_ALERT_FREEZER_CAPTURE_GOOD", sName))
						end
					elseif iChance >= 26 and iChance <=50 then
						--Kill the girl
						v.Status = GameInfoTypes.MGACTIONSTATE_DEAD
						v.FreezerPlayer = nil
					else
						--Witch!
						local sName = Locale.ConvertTextKey(MagicalGirls[iMGKey].Name)
						local pPlot = Map.GetPlot(iX, iY)
						local pSpawnPlot;
						for pAreaPlot in PlotAreaSpiralIterator(pPlot, 1, 1, false, false, false) do
							if pAreaPlot and not pAreaPlot:IsCity() then
								pSpawnPlot = pAreaPlot
							end
						end
						TurnIntoWitch(k, pSpawnPlot)
						if iCapturingPlayer == Game:GetActivePlayer() then
							Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_PMMM_ALERT_FREEZER_CAPTURE_BAD", sName))
						end
					end
				end
			end
		end
	end
end
