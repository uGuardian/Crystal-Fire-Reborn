-- VertGreenHeartTraitScript
-- Author: Vice
-- DateCreated: 4/2/2015 4:27:31 PM
--------------------------------------------------------------

print("Vert/Green Heart Trait Script loaded, desu wa~")

local PRODUCTION_SPEED_MOD = GameInfo.GameSpeeds[PreGame.GetGameSpeed()].ConstructPercent / 100
local iMaxCivs = GameDefines.MAX_MAJOR_CIVS
local HDD_SHARE_THRESHOLD = GameDefines.VV_HDN_HDD_SHARE_THRESHOLD
HDNMod.GreatGameDevProgress = HDNMod.GreatGameDevProgress or {}
HDNMod.GreatGameDevProgressNeeded = HDNMod.GreatGameDevProgressNeeded or {}

--UA Constants
local VERT_GA_MODIFIER = 20;
local VERT_GW_SHARES = 5;
local GREEN_HEART_DUMMY_BUILDING_THRESHOLD = math.ceil(2000 * PRODUCTION_SPEED_MOD);
local GREEN_HEART_GAME_DEV_AMOUNT = math.ceil(150 * PRODUCTION_SPEED_MOD);
local RAN_RAN_PROMO = GameInfoTypes.PROMOTION_VV_RANRAN
local RAN_RAN_BUFF = GameInfoTypes.PROMOTION_VV_RANRAN_BUFF

local iLeanboxLiveArcade = GameInfoTypes.BUILDING_VV_LEANBOX_ARCADE
local iLeanboxLiveArcadeClass = GameInfo.BuildingClasses[GameInfo.Buildings[iLeanboxLiveArcade].BuildingClass].ID
local iLLADummy = GameInfoTypes.BUILDING_VV_LEANBOX_GW_DUMMY

local iVert = GameInfoTypes.LEADER_VV_VERT or -1
local iGreenHeart = GameInfoTypes.LEADER_VV_GREEN_HEART or -1
local iVertCiv = GameInfoTypes.CIVILIZATION_VV_LEANBOX or -1
local iGreenHeartCiv = GameInfoTypes.CIVILIZATION_VV_LEANBOX_GH or -1

local iVertUltra = GameInfoTypes.LEADER_VV_VERT_ULTRA or -1
local iGreenHeartUltra = GameInfoTypes.LEADER_VV_GREEN_HEART_ULTRA or -1
local iVertCivUltra = GameInfoTypes.CIVILIZATION_VV_LEANBOX_ULTRA or -1
local iGreenHeartCivUltra = GameInfoTypes.CIVILIZATION_VV_LEANBOX_GH_ULTRA or -1

--Vert Great Works
local tGreatGames = {}

for row in GameInfo.GreatWorks() do
	if string.find(row.Type, "GREAT_WORK_VV_GAME_DEV") then
		tGreatGames[row.ID] = true
	end
end

local tVerts = {}
for i = 0, iMaxCivs - 1, 1 do
	local pPlayer = Players[i]
	if pPlayer:IsEverAlive() then
		local iLeaderType = pPlayer:GetLeaderType()
		if (iLeaderType == iVert or iLeaderType == iGreenHeart or iLeaderType == iVertUltra or iLeaderType == iGreenHeartUltra) then
			tVerts[i] = true
		end
	end
end

	
function CheckRanRanBuff(pUnit)
	if pUnit:IsCombatUnit() then
		local pPlot = pUnit:GetPlot()
		for c = 0, pPlot:GetNumUnits() - 1 do
			local pPlotUnit = pPlot:GetUnit(c)
			if pPlotUnit and pPlotUnit ~= pUnit then
				if pPlotUnit:GetOwner() == pUnit:GetOwner() and pPlotUnit:IsHasPromotion(RAN_RAN_PROMO) then
					pUnit:SetHasPromotion(RAN_RAN_BUFF, true)
					return
				end
			end
		end
	end
	pUnit:SetHasPromotion(RAN_RAN_BUFF, false)
end

function RefreshGameDevDisplay()
	local iPlayer = Game:GetActivePlayer()
	local pPlayer = Players[iPlayer]
	if not tVerts[iPlayer] then
		Controls.HDNGameDevString:SetText("");
		return
	end
	local sText = GetGreatGameDevProgressString(iPlayer)
	Controls.HDNGameDevString:SetText(sText);
end
Events.SerialEventCityInfoDirty.Add(RefreshGameDevDisplay)


function GetGreatGameDevProgressString(iPlayer)
	local sString = ""
	if tVerts[iPlayer] then
		if not HDNMod.GreatGameDevProgress[iPlayer] then HDNMod.GreatGameDevProgress[iPlayer] = 0 end
		if not HDNMod.GreatGameDevProgressNeeded[iPlayer] then HDNMod.GreatGameDevProgressNeeded[iPlayer] = GREEN_HEART_GAME_DEV_AMOUNT end
		sString = "[ICON_GREAT_PEOPLE] [COLOR_PLAYER_VV_LEANBOX_ICON]"..HDNMod.GreatGameDevProgress[iPlayer].."/"..HDNMod.GreatGameDevProgressNeeded[iPlayer]

		local pPlayer = Players[iPlayer]
		if IsPlayerHDDMode(pPlayer) then
			local iChange = math.floor(pPlayer:GetTotalJONSCulturePerTurn() * HDNMod.Shares[iPlayer] / (10000 * PRODUCTION_SPEED_MOD))
			sString = sString.."(+"..tostring(iChange)..")"
		else
			sString = sString.."(+0)"
		end
		sString = sString.."[ENDCOLOR]"
	end
	return sString
end

function LeanboxLiveArcade(pPlayer, pCity)
	local iPlayer = pPlayer:GetID()
	if pCity:IsHasBuilding(iLeanboxLiveArcade) then
		local iCurrentWorks = pCity:GetNumGreatWorksInBuilding(iLeanboxLiveArcadeClass)
		if iCurrentWorks > 0 then
			for i = 0, iCurrentWorks - 1, 1 do
				local iWorkType = pCity:GetBuildingGreatWork(iLeanboxLiveArcadeClass, i)
				if tGreatGames[Game.GetGreatWorkType(iWorkType, iPlayer)] == true then
					pCity:SetNumRealBuilding(iLLADummy, 1, true)
					return
				end
			end
		end
	end
	pCity:SetNumRealBuilding(iLLADummy, 0)
end

function OnCityInfoDirtyLeanboxLiveArcade()
	local iActivePlayer = Game:GetActivePlayer()
	if tVerts[iActivePlayer] then
		local pPlayer = Players[iActivePlayer]
		for pCity in pPlayer:Cities() do
			LeanboxLiveArcade(pPlayer, pCity)
		end
	end
end
Events.SerialEventCityInfoDirty.Add(OnCityInfoDirtyLeanboxLiveArcade)

function OnPlayerDoTurn(iPlayer)
	local pPlayer = Players[iPlayer]
	if tVerts[iPlayer] then
		local iLeaderType = pPlayer:GetLeaderType()
		if iLeaderType == iVert or iLeaderType == iVertUltra then
			local pPlayer = Players[iPlayer]
			local pTeam = Teams[pPlayer:GetTeam()]
			--DOFs between Same-Sex Leaders
			local iNumDoFs = 0
			local tMLLookup = {} --prevent one DOF from counting twice
			for i = 0, iMaxCivs - 1, 1 do
				if i ~= iPlayer then
					local pLoop = Players[i]
					if pTeam:IsHasMet(pLoop:GetTeam()) then
						local sLeaderKey = GameInfo.Leaders[pLoop:GetLeaderType()].Description
						local bFemale = (Locale.ConvertTextKey("{@1: gender feminine?yes; other?no}", sLeaderKey) == "yes" and pLoop:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_BRITAIN_FSN)
						for i2 = 0, iMaxCivs - 1, 1 do
							if i2 ~= i and i2 ~= iPlayer then
								local pLoop2 = Players[i2]
								if pTeam:IsHasMet(pLoop2:GetTeam()) then
									local sLeaderKey2 = GameInfo.Leaders[pLoop2:GetLeaderType()].Description
									local bFemale2 = (Locale.ConvertTextKey("{@1: gender feminine?yes; other?no}", sLeaderKey2) == "yes" and pLoop2:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_BRITAIN_FSN)
									if bFemale == bFemale2 then
										if tMLLookup[i2] ~= i and pLoop:IsDoF(i2) then
											tMLLookup[i] = i2
											iNumDoFs = iNumDoFs + 1
										end
									end
								end
							end
						end	
					end
				end
			end

			local iGAPoints = iNumDoFs * VERT_GA_MODIFIER
			pPlayer:ChangeGoldenAgeProgressMeter(iGAPoints)
			if iGAPoints > 0 and iPlayer == Game:GetActivePlayer() then
				Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_ALERT_HDN_VERT_GOLDEN_AGE", iGAPoints))
			end

			--Should not have any of GH's dummy buildings, and also check dummy buildings for Leanbox Live Arcade
			for pCity in pPlayer:Cities() do
				pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_VV_LEANBOX_DUMMY_BUILDING_TRAIT, 0)
				LeanboxLiveArcade(pPlayer, pCity)
			end
		else
			if pPlayer:GetLeaderType() == iGreenHeart then
				--Extra city Hit Points if over share threshold
				--Also dummy building for Leanbox Live Arcade
				local pPlayer = Players[iPlayer]
				local iSet = 0
				if (not bWFTW) and (HDNMod.Shares[iPlayer] >= GREEN_HEART_DUMMY_BUILDING_THRESHOLD) then
					iSet = math.floor(pPlayer:GetTourism() / 2)
				end
				for pCity in pPlayer:Cities() do
					pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_VV_LEANBOX_DUMMY_BUILDING_TRAIT, iSet, true)
					LeanboxLiveArcade(pPlayer, pCity)
				end
			elseif pPlayer:GetLeaderType() == iGreenHeartUltra then
				local tSpearmen = {
					[GameInfoTypes.UNITCLASS_SPEARMAN] = true,
					[GameInfoTypes.UNITCLASS_PIKEMAN] = true,
					[GameInfoTypes.UNITCLASS_LANCER] = true
				}
				for pUnit in pPlayer:Units() do
					if tSpearmen[pUnit:GetUnitClassType()] and pUnit:GetDamage() > 0 then
						pUnit:ChangeDamage(-math.min(math.floor(HDNMod.Shares[iPlayer] / 100), pUnit:GetDamage()))
					end	
				end	
				for pCity in pPlayer:Cities() do
					LeanboxLiveArcade(pPlayer, pCity)
				end
			end

			--Progress towards Great Game Dev
			if not HDNMod.GreatGameDevProgress[iPlayer] then HDNMod.GreatGameDevProgress[iPlayer] = 0 end
			if not HDNMod.GreatGameDevProgressNeeded[iPlayer] then HDNMod.GreatGameDevProgressNeeded[iPlayer] = GREEN_HEART_GAME_DEV_AMOUNT end

			local iChange = math.floor(pPlayer:GetTotalJONSCulturePerTurn() * HDNMod.Shares[iPlayer] / (10000 * PRODUCTION_SPEED_MOD))
			HDNMod.GreatGameDevProgress[iPlayer] = HDNMod.GreatGameDevProgress[iPlayer] + iChange
			local pCapital = pPlayer:GetCapitalCity()
			if HDNMod.GreatGameDevProgress[iPlayer] > HDNMod.GreatGameDevProgressNeeded[iPlayer] and pCapital then
				HDNMod.GreatGameDevProgress[iPlayer] = 0  --no spillover
				HDNMod.GreatGameDevProgressNeeded[iPlayer] = HDNMod.GreatGameDevProgressNeeded[iPlayer] * 2
				pPlayer:InitUnit(GameInfoTypes.UNIT_VV_GREAT_GAME_DEV, pCapital:GetX(), pCapital:GetY(), UNITAI_ARTIST)
				local sText = Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_HDN_GREAT_GAME_DEV")
				local sTitle = Locale.ConvertTextKey("TXT_KEY_POP_GREAT_PERSON_BORN")
				pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GREAT_PERSON_ACTIVE_PLAYER, sText, sTitle, pCapital:GetX(), pCapital:GetY(), GameInfoTypes.UNIT_VV_GREAT_GAME_DEV)
			end
		end
	end
	
	for pUnit in pPlayer:Units() do
		CheckRanRanBuff(pUnit)
	end
end
GameEvents.PlayerDoTurn.Add(OnPlayerDoTurn)

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- UnitSetXY
--------------------------------------------------------------------------------------------------------------------------------------------------------

function OnUnitSetXYHDN(iPlayer, iUnit, iX, iY)
	if iX > 0 and iY > 0 and GameInfoTypes.PROMOTION_VV_RANRAN then
		local pUnit = Players[iPlayer]:GetUnitByID(iUnit)
		for pAreaPlot in PlotAreaSpiralIterator(pUnit:GetPlot(), 1, false, false, false, true) do
			for c = 0, pAreaPlot:GetNumUnits() - 1 do
				local pPlotUnit = pAreaPlot:GetUnit(c)
				if pPlotUnit then
					if pPlotUnit:GetOwner() == iPlayer and pPlotUnit:IsCombatUnit() then
						CheckRanRanBuff(pUnit)
					end
				end
			end
		end
	end
end
GameEvents.UnitSetXY.Add(OnUnitSetXYHDN)


function VertTransformationAILogic(iPlayer)
	local bShouldTransform = false
	if HDNMod.Shares[iPlayer] >= HDD_SHARE_THRESHOLD * 1.5 then
		local pPlayer = Players[iPlayer]
		if pPlayer:IsGoldenAge() then
			bShouldTransform = true
		end
		--Transform if there are enemies near one of our cities and we have at least 20%.
		if not bShouldTransform and (HDNMod.Shares[iPlayer] >= HDD_SHARE_THRESHOLD * 2) then
			for pCity in pPlayer:Cities() do
				if pCity:CanRangeStrikeNow() then
					bShouldTransform = true
					break
				end
			end
		end
	end
	return bShouldTransform
end

function GreenHeartTransformationAILogic(iPlayer)
	local bShouldRevert = false
	local pPlayer = Players[iPlayer]
	if not pPlayer:IsGoldenAge() and (HDNMod.Shares[iPlayer] < HDD_SHARE_THRESHOLD * 2) then
		bShouldRevert = true
	end
	return bShouldRevert
end
LuaEvents.VV_AddToTransformLogicTable(iVert, VertTransformationAILogic)
LuaEvents.VV_AddToTransformLogicTable(iGreenHeart, GreenHeartTransformationAILogic)
LuaEvents.VV_AddToTransformLogicTable(iVertUltra, VertTransformationAILogic)
LuaEvents.VV_AddToTransformLogicTable(iGreenHeartUltra, GreenHeartTransformationAILogic)


--Unique Dialog Text for specific leaders.
--The leaders with unique text are:
--Neptune, Nepgear, Blanc, Noire (for obvious reasons)
--Mami Tomoe
--Kyouko Sakura
--Nagisa Momoe
--Nanoha Takamachi
--The City of Heroes Civilizations
--Civilizations of Warcraft
--Colonialist Legacies Vietnam

local tNeptuneCivs = {
	["CIVILIZATION_PLANEPTUNE"] = true,
	["CIVILIZATION_VV_PLANEPTUNE"] = true,
	["CIVILIZATION_VV_PLANEPTUNE_PH"] = true
}

local tNepgearCivs = {
	["CIVILIZATION_VV_PLANEPTUNE_NG"] = true,
	["CIVILIZATION_VV_PLANEPTUNE_PS"] = true
}

local tNoireCivs = {
	["CIVILIZATION_LASTATION"] = true,
	["CIVILIZATION_VV_LASTATION"] = true,
	["CIVILIZATION_VV_LASTATION_BH"] = true,
	["CIVILIZATION_VV_LASTATION_ULTRA"] = true,
	["CIVILIZATION_VV_LASTATION_BH_ULTRA"] = true
}

local tUniCivs = {
	["CIVILIZATION_VV_LASTATION_UN"] = true,
	["CIVILIZATION_VV_LASTATION_BS"] = true
}


local tBlancCivs = {
	["CIVILIZATION_LOWEE"] = true,
	["CIVILIZATION_VV_LOWEE"] = true,
	["CIVILIZATION_VV_LOWEE_WH"] = true,
	["CIVILIZATION_VV_LOWEE_ULTRA"] = true,
	["CIVILIZATION_VV_LOWEE_WH_ULTRA"] = true,
}

local sMami = "CIVILIZATION_MAMI"
local sKyouko = "CIVILIZATON_KYOUKO"
local sNagisa = "CIVILIZATON_KYOUKO"
local sNanoha = "CIVILIZATON_NAGISA"
local sVietnam = "CIVILIZATON_VIETNAM"

local tCOHCivs = {
	["CIVILIZATION_PARAGON"] = true,
	["CIVILIZATION_ARACHNOS"] = true,
	["CIVILIZATION_PRAETORIA"] = true,
	["CIVILIZATION_RIKTI"] = true,
	["CIVILIZATION_NEMESIS"] = true
}

local tWarcraftCivs = {
	["CIVILIZATION_DARKSPEAR"] = true,
	["CIVILIZATION_STORMWIND"] = true,
	["CIVILIZATION_NIGHT_ELVES"] = true,
	["CIVILIZATION_ORGRIMMAR"] = true,
	["CIVILIZATION_ARGENT_CRUSADE"] = true,
	["CIVILIZATION_BLOOD_ELVES"] = true,
	["CIVILIZATION_SCOURGE"] = true,
	["CIVILIZATION_TAUREN"] = true
}

--Thanks to Typhlomence for this and the ChangeDiplomacyReference/ChangeDiplomacyText function!
function VertCharacterSpecificDialogText()
	local locale = "Language_" ..Locale.GetCurrentLanguage().Type;
	local pActivePlayer = Players[Game:GetActivePlayer()]
	local sCivilizationType = GameInfo.Civilizations[pActivePlayer:GetCivilizationType()].Type

	
	if tNeptuneCivs[sCivilizationType] then
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_DEFEATED%", "TXT_KEY_UD_VS_NEPTUNE_VERT_DEFEATED%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_FIRSTGREETING%", "TXT_KEY_UD_VS_NEPTUNE_VERT_FIRSTGREETING%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_GREETING_POLITE_HELLO%", "TXT_KEY_UD_VS_NEPTUNE_VERT_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_GREETING_NEUTRAL_HELLO%", "TXT_KEY_UD_VS_NEPTUNE_VERT_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_GREETING_HOSTILE_HELLO%", "TXT_KEY_UD_VS_NEPTUNE_VERT_GREETING_HOSTILE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_ATTACKED_HOSTILE%", "TXT_KEY_UD_VS_NEPTUNE_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_ATTACKED_WEAK_HOSTILE%", "TXT_KEY_UD_VS_NEPTUNE_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_ATTACKED_STRONG_HOSTILE%", "TXT_KEY_UD_VS_NEPTUNE_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_ATTACKED_EXCITED%", "TXT_KEY_UD_VS_NEPTUNE_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_ATTACKED_WEAK_EXCITED%", "TXT_KEY_UD_VS_NEPTUNE_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_ATTACKED_STRONG_EXCITED%", "TXT_KEY_UD_VS_NEPTUNE_VERT_WAR_DECLARATION%")

		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_DEFEATED%", "TXT_KEY_UD_VS_NEPTUNE_VERT_DEFEATED%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_FIRSTGREETING%", "TXT_KEY_UD_VS_NEPTUNE_VERT_FIRSTGREETING%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_GREETING_POLITE_HELLO%", "TXT_KEY_UD_VS_NEPTUNE_VERT_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_GREETING_NEUTRAL_HELLO%", "TXT_KEY_UD_VS_NEPTUNE_VERT_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_GREETING_HOSTILE_HELLO%", "TXT_KEY_UD_VS_NEPTUNE_VERT_GREETING_HOSTILE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_ATTACKED_HOSTILE%", "TXT_KEY_UD_VS_NEPTUNE_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_ATTACKED_WEAK_HOSTILE%", "TXT_KEY_UD_VS_NEPTUNE_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_ATTACKED_STRONG_HOSTILE%", "TXT_KEY_UD_VS_NEPTUNE_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_ATTACKED_EXCITED%", "TXT_KEY_UD_VS_NEPTUNE_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_ATTACKED_WEAK_EXCITED%", "TXT_KEY_UD_VS_NEPTUNE_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_ATTACKED_STRONG_EXCITED%", "TXT_KEY_UD_VS_NEPTUNE_VERT_WAR_DECLARATION%")
	elseif tNoireCivs[sCivilizationType] then
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_DEFEATED%", "TXT_KEY_UD_VS_NOIRE_VERT_DEFEATED%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_FIRSTGREETING%", "TXT_KEY_UD_VS_NOIRE_VERT_FIRSTGREETING%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_GREETING_POLITE_HELLO%", "TXT_KEY_UD_VS_NOIRE_VERT_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_GREETING_NEUTRAL_HELLO%", "TXT_KEY_UD_VS_NOIRE_VERT_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_GREETING_HOSTILE_HELLO%", "TXT_KEY_UD_VS_NOIRE_VERT_GREETING_HOSTILE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_ATTACKED_HOSTILE%", "TXT_KEY_UD_VS_NOIRE_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_ATTACKED_WEAK_HOSTILE%", "TXT_KEY_UD_VS_NOIRE_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_ATTACKED_STRONG_HOSTILE%", "TXT_KEY_UD_VS_NOIRE_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_ATTACKED_EXCITED%", "TXT_KEY_UD_VS_NOIRE_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_ATTACKED_WEAK_EXCITED%", "TXT_KEY_UD_VS_NOIRE_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_ATTACKED_STRONG_EXCITED%", "TXT_KEY_UD_VS_NOIRE_VERT_WAR_DECLARATION%")

		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_DEFEATED%", "TXT_KEY_UD_VS_NOIRE_VERT_DEFEATED%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_FIRSTGREETING%", "TXT_KEY_UD_VS_NOIRE_VERT_FIRSTGREETING%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_GREETING_POLITE_HELLO%", "TXT_KEY_UD_VS_NOIRE_VERT_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_GREETING_NEUTRAL_HELLO%", "TXT_KEY_UD_VS_NOIRE_VERT_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_GREETING_HOSTILE_HELLO%", "TXT_KEY_UD_VS_NOIRE_VERT_GREETING_HOSTILE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_ATTACKED_HOSTILE%", "TXT_KEY_UD_VS_NOIRE_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_ATTACKED_WEAK_HOSTILE%", "TXT_KEY_UD_VS_NOIRE_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_ATTACKED_STRONG_HOSTILE%", "TXT_KEY_UD_VS_NOIRE_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_ATTACKED_EXCITED%", "TXT_KEY_UD_VS_NOIRE_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_ATTACKED_WEAK_EXCITED%", "TXT_KEY_UD_VS_NOIRE_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_ATTACKED_STRONG_EXCITED%", "TXT_KEY_UD_VS_NOIRE_VERT_WAR_DECLARATION%")
	elseif tNepgearCivs[sCivilizationType] then
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_DEFEATED%", "TXT_KEY_UD_VS_NEPGEAR_VERT_DEFEATED%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_FIRSTGREETING%", "TXT_KEY_UD_VS_NEPGEAR_VERT_FIRSTGREETING%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_GREETING_POLITE_HELLO%", "TXT_KEY_UD_VS_NEPGEAR_VERT_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_GREETING_NEUTRAL_HELLO%", "TXT_KEY_UD_VS_NEPGEAR_VERT_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_GREETING_HOSTILE_HELLO%", "TXT_KEY_UD_VS_NEPGEAR_VERT_GREETING_HOSTILE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_ATTACKED_HOSTILE%", "TXT_KEY_UD_VS_NEPGEAR_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_ATTACKED_WEAK_HOSTILE%", "TXT_KEY_UD_VS_NEPGEAR_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_ATTACKED_STRONG_HOSTILE%", "TXT_KEY_UD_VS_NEPGEAR_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_ATTACKED_EXCITED%", "TXT_KEY_UD_VS_NEPGEAR_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_ATTACKED_WEAK_EXCITED%", "TXT_KEY_UD_VS_NEPGEAR_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_ATTACKED_STRONG_EXCITED%", "TXT_KEY_UD_VS_NEPGEAR_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_DEC_FRIENDSHIP%", "TXT_KEY_UD_VS_NEPGEAR_VERT_FRIENDSHIP%")

		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_DEFEATED%", "TXT_KEY_UD_VS_NEPGEAR_VERT_DEFEATED%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_FIRSTGREETING%", "TXT_KEY_UD_VS_NEPGEAR_VERT_FIRSTGREETING%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_GREETING_POLITE_HELLO%", "TXT_KEY_UD_VS_NEPGEAR_VERT_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_GREETING_NEUTRAL_HELLO%", "TXT_KEY_UD_VS_NEPGEAR_VERT_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_GREETING_HOSTILE_HELLO%", "TXT_KEY_UD_VS_NEPGEAR_VERT_GREETING_HOSTILE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_ATTACKED_HOSTILE%", "TXT_KEY_UD_VS_NEPGEAR_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_ATTACKED_WEAK_HOSTILE%", "TXT_KEY_UD_VS_NEPGEAR_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_ATTACKED_STRONG_HOSTILE%", "TXT_KEY_UD_VS_NEPGEAR_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_ATTACKED_EXCITED%", "TXT_KEY_UD_VS_NEPGEAR_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_ATTACKED_WEAK_EXCITED%", "TXT_KEY_UD_VS_NEPGEAR_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_ATTACKED_STRONG_EXCITED%", "TXT_KEY_UD_VS_NEPGEAR_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_DEC_FRIENDSHIP%", "TXT_KEY_UD_VS_NEPGEAR_VERT_FRIENDSHIP%")
	elseif tUniCivs[sCivilizationType] then
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_DEFEATED%", "TXT_KEY_UD_VS_UNI_VERT_DEFEATED%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_FIRSTGREETING%", "TXT_KEY_UD_VS_UNI_VERT_FIRSTGREETING%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_GREETING_POLITE_HELLO%", "TXT_KEY_UD_VS_UNI_VERT_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_GREETING_NEUTRAL_HELLO%", "TXT_KEY_UD_VS_UNI_VERT_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_GREETING_HOSTILE_HELLO%", "TXT_KEY_UD_VS_UNI_VERT_GREETING_HOSTILE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_ATTACKED_HOSTILE%", "TXT_KEY_UD_VS_UNI_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_ATTACKED_WEAK_HOSTILE%", "TXT_KEY_UD_VS_UNI_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_ATTACKED_STRONG_HOSTILE%", "TXT_KEY_UD_VS_UNI_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_ATTACKED_EXCITED%", "TXT_KEY_UD_VS_UNI_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_ATTACKED_WEAK_EXCITED%", "TXT_KEY_UD_VS_UNI_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_ATTACKED_STRONG_EXCITED%", "TXT_KEY_UD_VS_UNI_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_DEC_FRIENDSHIP%", "TXT_KEY_UD_VS_UNI_VERT_FRIENDSHIP%")

		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_DEFEATED%", "TXT_KEY_UD_VS_NEPGEAR_VERT_DEFEATED%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_FIRSTGREETING%", "TXT_KEY_UD_VS_NEPGEAR_VERT_FIRSTGREETING%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_GREETING_POLITE_HELLO%", "TXT_KEY_UD_VS_NEPGEAR_VERT_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_GREETING_NEUTRAL_HELLO%", "TXT_KEY_UD_VS_NEPGEAR_VERT_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_GREETING_HOSTILE_HELLO%", "TXT_KEY_UD_VS_NEPGEAR_VERT_GREETING_HOSTILE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_ATTACKED_HOSTILE%", "TXT_KEY_UD_VS_NEPGEAR_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_ATTACKED_WEAK_HOSTILE%", "TXT_KEY_UD_VS_NEPGEAR_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_ATTACKED_STRONG_HOSTILE%", "TXT_KEY_UD_VS_NEPGEAR_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_ATTACKED_EXCITED%", "TXT_KEY_UD_VS_NEPGEAR_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_ATTACKED_WEAK_EXCITED%", "TXT_KEY_UD_VS_NEPGEAR_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_ATTACKED_STRONG_EXCITED%", "TXT_KEY_UD_VS_NEPGEAR_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_DEC_FRIENDSHIP%", "TXT_KEY_UD_VS_NEPGEAR_VERT_FRIENDSHIP%")
	elseif tBlancCivs[sCivilizationType] then
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_DEFEATED%", "TXT_KEY_UD_VS_BLANC_VERT_DEFEATED%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_FIRSTGREETING%", "TXT_KEY_UD_VS_BLANC_VERT_FIRSTGREETING%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_GREETING_POLITE_HELLO%", "TXT_KEY_UD_VS_BLANC_VERT_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_GREETING_NEUTRAL_HELLO%", "TXT_KEY_UD_VS_BLANC_VERT_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_GREETING_HOSTILE_HELLO%", "TXT_KEY_UD_VS_BLANC_VERT_GREETING_HOSTILE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_ATTACKED_HOSTILE%", "TXT_KEY_UD_VS_BLANC_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_ATTACKED_WEAK_HOSTILE%", "TXT_KEY_UD_VS_BLANC_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_ATTACKED_STRONG_HOSTILE%", "TXT_KEY_UD_VS_BLANC_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_ATTACKED_EXCITED%", "TXT_KEY_UD_VS_BLANC_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_ATTACKED_WEAK_EXCITED%", "TXT_KEY_UD_VS_BLANC_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_ATTACKED_STRONG_EXCITED%", "TXT_KEY_UD_VS_BLANC_VERT_WAR_DECLARATION%")

		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_DEFEATED%", "TXT_KEY_UD_VS_BLANC_VERT_DEFEATED%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_FIRSTGREETING%", "TXT_KEY_UD_VS_BLANC_VERT_FIRSTGREETING%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_GREETING_POLITE_HELLO%", "TXT_KEY_UD_VS_BLANC_VERT_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_GREETING_NEUTRAL_HELLO%", "TXT_KEY_UD_VS_BLANC_VERT_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_GREETING_HOSTILE_HELLO%", "TXT_KEY_UD_VS_BLANC_VERT_GREETING_HOSTILE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_ATTACKED_HOSTILE%", "TXT_KEY_UD_VS_BLANC_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_ATTACKED_WEAK_HOSTILE%", "TXT_KEY_UD_VS_BLANC_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_ATTACKED_STRONG_HOSTILE%", "TXT_KEY_UD_VS_BLANC_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_ATTACKED_EXCITED%", "TXT_KEY_UD_VS_BLANC_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_ATTACKED_WEAK_EXCITED%", "TXT_KEY_UD_VS_BLANC_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_ATTACKED_STRONG_EXCITED%", "TXT_KEY_UD_VS_BLANC_VERT_WAR_DECLARATION%")
	elseif tCOHCivs[sCivilizationType] then
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_DEFEATED%", "TXT_KEY_UD_VS_COH_VERT_DEFEATED%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_FIRSTGREETING%", "TXT_KEY_UD_VS_COH_VERT_FIRSTGREETING%")

		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_DEFEATED%", "TXT_KEY_UD_VS_COH_VERT_DEFEATED%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_FIRSTGREETING%", "TXT_KEY_UD_VS_COH_VERT_FIRSTGREETING%")
	elseif tWarcraftCivs[sCivilizationType] then
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_FIRSTGREETING%", "TXT_KEY_UD_VS_WARCRAFT_VERT_FIRSTGREETING%")

		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_FIRSTGREETING%", "TXT_KEY_UD_VS_WARCRAFT_VERT_FIRSTGREETING%")
	elseif sCivilizationType == sMami then
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_ATTACKED_HOSTILE%", "TXT_KEY_UD_VS_MAMI_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_ATTACKED_WEAK_HOSTILE%", "TXT_KEY_UD_VS_MAMI_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_ATTACKED_STRONG_HOSTILE%", "TXT_KEY_UD_VS_MAMI_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_ATTACKED_EXCITED%", "TXT_KEY_UD_VS_MAMI_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_ATTACKED_WEAK_EXCITED%", "TXT_KEY_UD_VS_MAMI_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_ATTACKED_STRONG_EXCITED%", "TXT_KEY_UD_VS_MAMI_VERT_WAR_DECLARATION%")

		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_ATTACKED_HOSTILE%", "TXT_KEY_UD_VS_MAMI_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_ATTACKED_WEAK_HOSTILE%", "TXT_KEY_UD_VS_MAMI_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_ATTACKED_STRONG_HOSTILE%", "TXT_KEY_UD_VS_MAMI_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_ATTACKED_EXCITED%", "TXT_KEY_UD_VS_MAMI_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_ATTACKED_WEAK_EXCITED%", "TXT_KEY_UD_VS_MAMI_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_ATTACKED_STRONG_EXCITED%", "TXT_KEY_UD_VS_MAMI_VERT_WAR_DECLARATION%")
	elseif sCivilizationType == sKyouko then
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_ATTACKED_HOSTILE%", "TXT_KEY_UD_VS_KYOUKO_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_ATTACKED_WEAK_HOSTILE%", "TXT_KEY_UD_VS_KYOUKO_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_ATTACKED_STRONG_HOSTILE%", "TXT_KEY_UD_VS_KYOUKO_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_ATTACKED_EXCITED%", "TXT_KEY_UD_VS_KYOUKO_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_ATTACKED_WEAK_EXCITED%", "TXT_KEY_UD_VS_KYOUKO_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_ATTACKED_STRONG_EXCITED%", "TXT_KEY_UD_VS_KYOUKO_VERT_WAR_DECLARATION%")

		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_ATTACKED_HOSTILE%", "TXT_KEY_UD_VS_KYOUKO_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_ATTACKED_WEAK_HOSTILE%", "TXT_KEY_UD_VS_KYOUKO_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_ATTACKED_STRONG_HOSTILE%", "TXT_KEY_UD_VS_KYOUKO_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_ATTACKED_EXCITED%", "TXT_KEY_UD_VS_KYOUKO_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_ATTACKED_WEAK_EXCITED%", "TXT_KEY_UD_VS_KYOUKO_VERT_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_ATTACKED_STRONG_EXCITED%", "TXT_KEY_UD_VS_KYOUKO_VERT_WAR_DECLARATION%")
	elseif sCivilizationType == sNagisa then
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_FIRSTGREETING%", "TXT_KEY_UD_VS_NAGISA_VERT_FIRSTGREETING%")

		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_FIRSTGREETING%", "TXT_KEY_UD_VS_NAGISA_VERT_FIRSTGREETING%")
	elseif sCivilizationType == sNanoha then
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_GREETING_POLITE_HELLO%", "TXT_KEY_UD_VS_NANOHA_VERT_GREETING_POLITE%")

		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_GREETING_POLITE_HELLO%", "TXT_KEY_UD_VS_NANOHA_VERT_GREETING_POLITE%")
	elseif sCivilizationType == sVietnam then
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_VERT_FIRSTGREETING%", "TXT_KEY_UD_VS_VIETNAM_VERT_FIRSTGREETING%")

		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_GREEN_HEART_FIRSTGREETING%", "TXT_KEY_UD_VS_VIETNAM_VERT_FIRSTGREETING%")
	end
end


--If both Verts are in the game, UD Vert's description and capital are changed to differentiate.
function UpdateVertCivDescriptions()
	local bIsHDVert
	local bIsUDVert
	for i = 0, iMaxCivs - 1, 1 do
		local pPlayer = Players[i]
		if pPlayer:IsEverAlive() then
			local iUDVertPlayer;
			local sCivilizationType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			if sCivilizationType == "CIVILIZATION_VV_LEANBOX" or sCivilizationType == "CIVILIZATION_VV_LEANBOX_GH" then
				bIsHDVert = true
			elseif sCivilizationType == "CIVILIZATION_VV_LEANBOX_ULTRA" or sCivilizationType == "CIVILIZATION_VV_LEANBOX_GH_ULTRA" then
				bIsUDVert = true
				iUDVertPlayer = i
			end
			if bIsHDVert and bIsUDVert then
				if iUDVertPlayer then
					local pUD = Players[iUDVertPlayer]
					if pUD:GetCivilizationShortDescription() == Locale.ConvertTextKey("TXT_KEY_CIV_VV_LEANBOX_SHORT_DESC") then
						PreGame.SetCivilizationShortDescription(iUDVertPlayer, "TXT_KEY_CIV_VV_LEANBOX_ULTRA_SHORT_DESC_ALT")
					end
					if pUD:GetCivilizationDescription() == Locale.ConvertTextKey("TXT_KEY_CIV_VV_LEANBOX_DESC") then
						PreGame.SetCivilizationDescription(iUDVertPlayer, "TXT_KEY_CIV_VV_LEANBOX_ULTRA_DESC_ALT")
					end
					if pUD:GetCivilizationAdjective() == Locale.ConvertTextKey("TXT_KEY_CIV_VV_LEANBOX_ADJECTIVE") then
						PreGame.SetCivilizationAdjective(iUDVertPlayer, "TXT_KEY_CIV_VV_LEANBOX_ULTRA_ADJECTIVE_ALT")
					end
				end
				ChangeDiplomacyGameText("TXT_KEY_CIV_VV_LEANBOX_ULTRA_DESC", "TXT_KEY_CIV_VV_LEANBOX_ULTRA_DESC_ALT")
				ChangeDiplomacyGameText("TXT_KEY_CIV_VV_LEANBOX_ULTRA_SHORT_DESC", "TXT_KEY_CIV_VV_LEANBOX_ULTRA_SHORT_DESC_ALT")
				ChangeDiplomacyGameText("TXT_KEY_CIV_VV_LEANBOX_ULTRA_ADJECTIVE", "TXT_KEY_CIV_VV_LEANBOX_ULTRA_ADJECTIVE_ALT")
				ChangeDiplomacyGameText("TXT_KEY_CITY_NAME_VV_HDNCAPITAL_LEANBOX_ULTRA", "TXT_KEY_CITY_NAME_VV_HDNCAPITAL_LEANBOX_ULTRA_ALT")
				Locale.SetCurrentLanguage(Locale.GetCurrentLanguage().Type)
				break
			end
		end
	end
end

function OnLoadScreenCloseVertText()
	VertCharacterSpecificDialogText()
	-- if not HDNMod.VertTextInit then
		UpdateVertCivDescriptions()
		-- HDNMod.VertTextInit = true
	-- end
end

Events.LoadScreenClose.Add(OnLoadScreenCloseVertText)



function ChangeDiplomacyReference(targetReference, newReference)
	--print("Currently changing " .. targetReference .. " to " .. newReference .. "...");
	-- We can't always assume that the references exist, so therefore we need to check if they do first
	
	-- Vice: Commented this part out for speed, since the references will always exist when iterating over GameInfo.Diplomacy_Responses.
	-- local reference;
	-- for _ in DB.Query("SELECT Response FROM Diplomacy_Responses WHERE Response= '" .. targetReference .. "'") do reference = _.Response end
	
	if targetReference then
		--print(targetReference .. " exists; now changing it to the new reference...");
		local locale = "Language_" ..Locale.GetCurrentLanguage().Type;
		--print("Current locale is " .. locale .. ".");
		local text;
		--print("Querying with: SELECT Text FROM " ..locale .." WHERE Tag LIKE '" ..newReference.."'");
		for _ in DB.Query("SELECT Text FROM " ..locale .." WHERE Tag LIKE '" ..newReference.."'") do text = _.Text end
		if text then
			for _ in DB.Query("UPDATE Diplomacy_Responses SET Response = '" .. newReference .. "' WHERE Response='" .. targetReference .. "'") do end
			--print("Reference change complete!");
		else
			--print(newReference .. " does not refer to any new lines in this locale, therefore we won't replace it.");		
		end
	else
		--print(targetReference .. " doesn't exist therefore we cannot replace it with a new reference.");
	end
end

-- "(technically, you could use these to alter Game Text entries not related to diplomacy. I won't stop you if you want to repurpose the code for that!)"
-- Don't mind if I do!

function ChangeDiplomacyGameText(targetText, newText)
	--print("Currently changing " .. targetText .. " to " .. newText .. "...");
	local locale = "Language_" ..Locale.GetCurrentLanguage().Type;
	--print("Current locale is " .. locale .. ".");
	local targetTextTest;
	for _ in DB.Query("SELECT Text FROM " ..locale .." WHERE Tag='" .. targetText .. "'") do targetTextTest = _.Text end
	if targetTextTest then
		--print(targetText .. " exists in " .. locale .. "...");
		local newTextTest;
		for _ in DB.Query("SELECT Text FROM " ..locale .." WHERE Tag='" .. newText .. "'") do newTextTest = _.Text end
		if newTextTest then
			--print(newText .. " exists in " .. locale .. ". Now replacing " .. targetText .. "...");
			-- gsub escapes the apostrophes so that we don't get an error
			for _ in DB.Query("UPDATE " .. locale .. " SET Text = '" .. string.gsub(newTextTest, "'", "''") .."' WHERE Tag='" ..targetText .."'") do end
			Locale.SetCurrentLanguage( Locale.GetCurrentLanguage().Type );
			--print(targetText .. " changed to " .. newText .. " in " .. locale .. "!");
		else
			--print(newText .. " doesn't exist in " .. locale .. ". No changes made.");
		end
	else
		--print(targetText .. " doesn't exist in " .. locale .. ". No changes made.");
	end
end