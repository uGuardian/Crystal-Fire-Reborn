-- BlancWhiteHeartTraitScript
-- Author: Vice
-- DateCreated: 4/2/2015 4:27:31 PM
--------------------------------------------------------------

print("Blanc/White Heart Trait Script loaded, you little shit!")

local PRODUCTION_SPEED_MOD = GameInfo.GameSpeeds[PreGame.GetGameSpeed()].ConstructPercent / 100
local GROWTH_SPEED_MOD = GameInfo.GameSpeeds[PreGame.GetGameSpeed()].GrowthPercent / 100
local HDD_SHARE_THRESHOLD = GameDefines.VV_HDN_HDD_SHARE_THRESHOLD
local iMaxCivs = GameDefines.MAX_MAJOR_CIVS
local bWFTW = GameInfoTypes.UNIT_PMMM_MAGICAL_GIRL and true or false;
local iMagicalGirlClass = GameInfoTypes.UNITCLASS_PMMM_MAGICAL_GIRL
local iTundra = GameInfoTypes.TERRAIN_TUNDRA
local iSnow = GameInfoTypes.TERRAIN_SNOW

--UA Constants
local BLANC_WLKTD_POP_MODIFIER = 0.75;
local BLANC_U_WLKTD_POP_MODIFER = 0.25;
local WHITE_HEART_STRENGTH_THRESHOLD = 250;
local WHITE_HEART_U_STRENGTH_THRESHOLD = 200;
local WHITE_HEART_WLKTD_LENGTH = math.floor(4 * GROWTH_SPEED_MOD);
local WHITE_HEART_U_WLKTD_LENGTH = math.floor(5 * GROWTH_SPEED_MOD);
local WHITE_HEART_DENOUNCE_PROMO = GameInfoTypes.PROMOTION_VV_WHITE_HEART_DENOUNCE_BONUS
local LS_XP_PER_GREAT_WORK = 2
local GW_POINTS_FROM_FIEFDOM_X100 = 25
local WRITERS_GUILD = GameInfoTypes.BUILDING_WRITERS_GUILD
local WRITER = GameInfoTypes.SPECIALIST_WRITER
local MS_PROMO = GameInfoTypes.PROMOTION_VV_LOWEE_SOLDIER
local MS_BUFF = GameInfoTypes.PROMOTION_VV_LOWEE_SOLDIER_BUFF

local tMushroomFiefdoms = {
	[GameInfoTypes.IMPROVEMENT_VV_LOWEE_MUSHROOM] = true,
	[GameInfoTypes.IMPROVEMENT_VV_LOWEE_MUSHROOM_WH] = true,
	[GameInfoTypes.IMPROVEMENT_VV_LOWEE_MUSHROOM_ULTRA] = true,
	[GameInfoTypes.IMPROVEMENT_VV_LOWEE_MUSHROOM_WH_ULTRA] = true
}

--Civ Identifiers
local iBlanc = GameInfoTypes.LEADER_VV_BLANC or -1
local iWhiteHeart = GameInfoTypes.LEADER_VV_WHITE_HEART or -1
local iBlancCiv = GameInfoTypes.CIVILIZATION_VV_LOWEE or -1
local iWhiteHeartCiv = GameInfoTypes.CIVILIZATION_VV_LOWEE_WH or -1
local iBlancUD = GameInfoTypes.LEADER_VV_BLANC_ULTRA or -1
local iWhiteHeartUD = GameInfoTypes.LEADER_VV_WHITE_HEART_ULTRA or -1
local iBlancCivUD = GameInfoTypes.CIVILIZATION_VV_LOWEE_ULTRA or -1
local iWhiteHeartCivUD = GameInfoTypes.CIVILIZATION_VV_LOWEE_WH_ULTRA or -1
local tBlancs = {}
for i = 0, iMaxCivs - 1, 1 do
	local pPlayer = Players[i]
	if pPlayer:IsEverAlive() then
		local iLeaderType = pPlayer:GetLeaderType()
		if (iLeaderType == iBlanc or iLeaderType == iWhiteHeart or iLeaderType == iBlancUD or iLeaderType == iWhiteHeartUD) then
			tBlancs[i] = true
		end
	end
end


function GetTundraSnowTilesWorked(iPlayer)
	local pPlayer = Players[iPlayer]
	local iPlots = 0
	for pCity in pPlayer:Cities() do
		local cityArea = pCity:GetNumCityPlots() - 1
		for cityPlotIndex = 0, cityArea do
			local plot = pCity:GetCityIndexPlot( cityPlotIndex )
			if plot and plot:GetOwner() == iPlayer and pCity:IsWorkingPlot( plot ) and (plot:GetTerrainType() == iTundra or plot:GetTerrainType() == iSnow) then
				iPlots = iPlots + 1
			end
		end
	end
	return iPlots
end

function UpdateWhiteHeartUnits(iPlayer)
	if not bWFTW then
		local pPlayer = Players[iPlayer]
		local iStrengthBonus = math.floor(HDNMod.Shares[iPlayer] / WHITE_HEART_STRENGTH_THRESHOLD)
		local iEra = pPlayer:GetCurrentEra()
		local pTeam = Teams[pPlayer:GetTeam()]
		local bIsHDD = IsPlayerHDDMode(pPlayer)
		for pUnit in pPlayer:Units() do
			if pUnit:IsCombatUnit() then
				if not bIsHDD then
					if bWFTW and pUnit:GetUnitClassType() == iMagicalGirlClass then
						pUnit:SetBaseCombatStrength(MapModData.gPMMMMagicalGirlEraStrengths[iEra])
					elseif pUnit:GetUnitCombatType() == GameInfoTypes.UNITCOMBAT_GUN or pUnit:GetUnitCombatType() == GameInfoTypes.UNITCOMBAT_MELEE then
						pUnit:SetBaseCombatStrength(GameInfo.Units[pUnit:GetUnitType()].Combat)
					end
				else
					if bWFTW and pUnit:GetUnitClassType() == iMagicalGirlClass then
						pUnit:SetBaseCombatStrength(MapModData.gPMMMMagicalGirlEraStrengths[iEra] + iStrengthBonus)
					elseif pUnit:GetUnitCombatType() == GameInfoTypes.UNITCOMBAT_GUN or pUnit:GetUnitCombatType() == GameInfoTypes.UNITCOMBAT_MELEE then
						pUnit:SetBaseCombatStrength(GameInfo.Units[pUnit:GetUnitType()].Combat + iStrengthBonus)
					end
				end

				local bSet = false
				if bIsHDD then
					local iOwner = pUnit:GetPlot():GetOwner()
					if iOwner and iOwner > -1 and iOwner ~= iPlayer then
						local pOwner = Players[iOwner]
						if pOwner:IsAlive() and pTeam:IsAtWar(pOwner:GetTeam()) and (pOwner:IsDenouncedPlayer(iPlayer) or pOwner:IsDenouncingPlayer(iPlayer)) then
							bSet = true
						end
					end
				end

				pUnit:SetHasPromotion(WHITE_HEART_DENOUNCE_PROMO, bSet)
			end
		end
	end
end

function OnCityCaptureCompleteWhiteHeart(iOldOwner, bCapital, iX, iY, iNewOwner, iPop, bConquest)
	if bConquest == true and tBlancs[iNewOwner] then
		local pPlayer = Players[iNewOwner]
		if IsPlayerHDDMode(pPlayer) then
			for pCity in pPlayer:Cities() do
				pCity:ChangeWeLoveTheKingDayCounter(WHITE_HEART_WLKTD_LENGTH)
			end
		end
	end
end

GameEvents.CityCaptureComplete.Add(OnCityCaptureCompleteWhiteHeart)

function OnCityTrainedCheckMagicalSoldier(iPlayer, iCity, iUnit, bGold, bFaithOrCulture)
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnit)
	if pUnit:GetUnitType() == GameInfoTypes.UNIT_VV_LOWEE_SOLDIER then
		local iNumWritings = #pPlayer:GetGreatWorks(GameInfoTypes.GREAT_WORK_LITERATURE)
		pUnit:ChangeExperience(iNumWritings * LS_XP_PER_GREAT_WORK)
	end
end
GameEvents.CityTrained.Add(OnCityTrainedCheckMagicalSoldier)

function OnGreatPersonExpended(iPlayer, iUnitTypeNormal, iUnitTypeDVMC)	
	if tBlancs[iPlayer] == true then
		local iUnitType = iUnitTypeNormal
		if bIsDVMC then
			iUnitType = iUnitTypeDVMC
		end
		--Prophets
		if GameInfo.Units[iUnitType] and GameInfo.Units[iUnitType].Class == "UNITCLASS_WRITER" then
			local pPlayer = Players[iPlayer]
			for pUnit in pPlayer:Units() do
				if pUnit:IsHasPromotion(MS_PROMO) then
					pUnit:SetHasPromotion(MS_BUFF, true)
					pUnit:SetDamage(0)
				end
			end
		end
	end
end


function OnPlayerDoTurn(iPlayer)
	local pPlayer = Players[iPlayer]
	if tBlancs[iPlayer] then
		if IsPlayerHDDMode(pPlayer) == true then
			local pTeam = Teams[pPlayer:GetTeam()]
			--Great Writer points from WLKTD
			local pWritersGuildCity;
			local iChange = 0
			local iMultiplier = BLANC_WLKTD_POP_MODIFIER
			if pPlayer:GetLeaderType() == iBlancUD then
				iMultiplier = BLANC_U_WLKTD_POP_MODIFER
			end
			for pCity in pPlayer:Cities() do
				if not pWritersGuildCity and pCity:IsHasBuilding(WRITERS_GUILD) then
					pWritersGuildCity = pCity
				end
				if pCity:GetWeLoveTheKingDayCounter() > 0 then
					iChange = iChange + math.floor(pCity:GetPopulation() * iMultiplier)
				end
			end
			if iChange > 0 then
				pWritersGuildCity:ChangeSpecialistGreatPersonProgressTimes100(WRITER, iChange * 100)
				if iPlayer == Game:GetActivePlayer() then
					Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_ALERT_HDN_BLANC_GW_WLTKD", iChange))
				end
			end
		end
		UpdateWhiteHeartUnits(iPlayer)
	end

	for pUnit in pPlayer:Units() do
		pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_VV_LOWEE_SOLDIER_BUFF, false)
	end

	local iPlots = 0
	local pWritersGuildCity;
	for pCity in pPlayer:Cities() do
		if pCity:IsHasBuilding(WRITERS_GUILD) then
			pWritersGuildCity = pCity
		end
		local cityArea = pCity:GetNumCityPlots() - 1
		for cityPlotIndex = 0, cityArea do
			local plot = pCity:GetCityIndexPlot( cityPlotIndex )
			if plot and plot:GetOwner() == iPlayer and pCity:IsWorkingPlot( plot ) and tMushroomFiefdoms[plot:GetImprovementType()] and not plot:IsImprovementPillaged() then
				iPlots = iPlots + 1
			end
		end
	end
	if pWritersGuildCity and iPlots > 0 then
		local iBonus = GW_POINTS_FROM_FIEFDOM_X100 * iPlots
		pWritersGuildCity:ChangeSpecialistGreatPersonProgressTimes100(WRITER, iBonus)
		if iPlayer == Game:GetActivePlayer() then
			Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_ALERT_HDN_BLANC_GW_FIEFDOMS", iBonus / 100))
		end
	end
end
GameEvents.PlayerDoTurn.Add(OnPlayerDoTurn)


function OnTransformed(iPlayer, bHDDOn)
	if tBlancs[iPlayer] then
		UpdateWhiteHeartUnits(iPlayer)
	end
end
LuaEvents.VV_ConvertHDNLeader.Add(OnTransformed)


function BlancTransformationAILogic(iPlayer)
	local bShouldTransform = false
	if HDNMod.Shares[iPlayer] >= HDD_SHARE_THRESHOLD * 1.5 then
		local pPlayer = Players[iPlayer]
		local pTeam = Teams[pPlayer:GetTeam()]
		for i = 0, iMaxCivs - 1, 1 do
			if i ~= iPlayer then
				local pLoop = Players[i]
				if pLoop:IsAlive() and pTeam:IsAtWar(pLoop:GetTeam()) then
					bShouldTransform = true
					break
				end
			end
		end
	end
	return bShouldTransform
end

function WhiteHeartTransformationAILogic(iPlayer)
	local bShouldRevert = false
	local pPlayer = Players[iPlayer]
	local pTeam = Teams[pPlayer:GetTeam()]
	local bAnyWars = false
	for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
		if i ~= iPlayer then
			local pLoop = Players[i]
			if pLoop:IsAlive() and pTeam:IsAtWar(pLoop:GetTeam()) then
				bAnyWars = true
				break
			end
		end
	end
	bShouldRevert = not bAnyWars
	return bShouldRevert
end
LuaEvents.VV_AddToTransformLogicTable(iBlanc, BlancTransformationAILogic)
LuaEvents.VV_AddToTransformLogicTable(iWhiteHeart, WhiteHeartTransformationAILogic)
LuaEvents.VV_AddToTransformLogicTable(iBlancUD, BlancTransformationAILogic)
LuaEvents.VV_AddToTransformLogicTable(iWhiteHeartUD, WhiteHeartTransformationAILogic)


local tAngryBlancResponses = {}
local tAngryWhiteHeartResponses = {}  --currently the "angry" response set is identical for Blanc and WH, but this helps with lookup
for row in GameInfo.Diplomacy_Responses() do
	if row.LeaderType == "LEADER_VV_BLANC" then
		local sNewString = string.gsub(row.Response, "LEADER_VV_BLANC", "LEADER_VV_ANGRY_BLANC")
		tAngryBlancResponses[row.Response] = sNewString
	elseif row.LeaderType == "LEADER_VV_WHITE_HEART" then
		local sNewString = string.gsub(row.Response, "LEADER_VV_WHITE_HEART", "LEADER_VV_ANGRY_BLANC")
		tAngryWhiteHeartResponses[row.Response] = sNewString
	end
end

local tPreviousApproaches = {}
local tPreviouslyAtWar = {}


function UpdateBlancDiploText(iPlayer)
	if not iPlayer then iPlayer = Game:GetActivePlayer() end
	if iPlayer == Game:GetActivePlayer() then
		local pPlayer = Players[iPlayer]
		local pBlanc;
		local pBlancUD;
		--If there are multiple Blancs on the map and it is active player's turn, the one with the lowest Player ID will determine dialog.
		for k, v in pairs(tBlancs) do
			if k ~= iPlayer and v and v == true then
				if Players[k]:GetLeaderType() == iBlanc or Players[k]:GetLeaderType() == iWhiteHeart then
					pBlanc = Players[k]
				else
					pBlancUD = Players[k]
				end
				if pBlanc and pBlancUD then	break end
			end
		end
		if pBlanc and pBlanc:IsAlive() then
			local iBlanc = pBlanc:GetID()
			local iApproach = pPlayer:GetApproachTowardsUsGuess(iBlanc);
			local bAtWarNow = Teams[pPlayer:GetTeam()]:IsAtWar(pBlanc:GetTeam())
			if (not tPreviousApproaches[iBlanc] or (tPreviousApproaches[iBlanc] and iApproach ~= tPreviousApproaches[iBlanc]))
				or (not tPreviouslyAtWar[iBlanc] or (tPreviouslyAtWar[iBlanc] and bAtWarNow ~= tPreviouslyAtWar[iBlanc])) then
				tPreviousApproaches[iBlanc] = iApproach
				tPreviouslyAtWar[iBlanc] = bAtWarNow
			end
			local iLeaderType = pBlanc:GetLeaderType()
			if iLeaderType == iBlanc then
				if (iApproach == MajorCivApproachTypes.MAJOR_CIV_APPROACH_HOSTILE or bAtWarNow == true) then
					for row in GameInfo.Diplomacy_Responses() do
						if row.LeaderType == "LEADER_VV_BLANC" then
							ChangeDiplomacyReference(row.Response, string.gsub(row.Response, "LEADER_VV_BLANC", "LEADER_VV_ANGRY_BLANC"))
						end
					end
				else
					for row in GameInfo.Diplomacy_Responses() do
						if row.LeaderType == "LEADER_VV_BLANC" then
							ChangeDiplomacyReference(row.Response, string.gsub(row.Response, "LEADER_VV_ANGRY_BLANC", "LEADER_VV_BLANC"))
						end
					end
				end
			elseif iLeaderType == iWhiteHeart then
				if (iApproach == MajorCivApproachTypes.MAJOR_CIV_APPROACH_HOSTILE or bAtWarNow == true) then
					for row in GameInfo.Diplomacy_Responses() do
						if row.LeaderType == "LEADER_VV_WHITE_HEART" then
							ChangeDiplomacyReference(row.Response, string.gsub(row.Response, "LEADER_VV_WHITE_HEART", "LEADER_VV_ANGRY_BLANC"))
						end
					end
				else
					for row in GameInfo.Diplomacy_Responses() do
						if row.LeaderType == "LEADER_VV_WHITE_HEART" then
							ChangeDiplomacyReference(row.Response, string.gsub(row.Response, "LEADER_VV_ANGRY_BLANC", "LEADER_VV_WHITE_HEART"))
						end
					end
				end
			end
		end
		if pBlancUD and pBlancUD:IsAlive() then
			local iBlanc = pBlanc:GetID()
			local iApproach = pPlayer:GetApproachTowardsUsGuess(iBlanc);
			local bAtWarNow = Teams[pPlayer:GetTeam()]:IsAtWar(pBlanc:GetTeam())
			if (not tPreviousApproaches[iBlanc] or (tPreviousApproaches[iBlanc] and iApproach ~= tPreviousApproaches[iBlanc]))
				or (not tPreviouslyAtWar[iBlanc] or (tPreviouslyAtWar[iBlanc] and bAtWarNow ~= tPreviouslyAtWar[iBlanc])) then
				tPreviousApproaches[iBlanc] = iApproach
				tPreviouslyAtWar[iBlanc] = bAtWarNow
			end
			local iLeaderType = pBlanc:GetLeaderType()
			if iLeaderType == iBlancUD then
				if (iApproach == MajorCivApproachTypes.MAJOR_CIV_APPROACH_HOSTILE or bAtWarNow == true) then
					for row in GameInfo.Diplomacy_Responses() do
						if row.LeaderType == "LEADER_VV_BLANC_ULTRA" then
							ChangeDiplomacyReference(row.Response, string.gsub(row.Response, "LEADER_VV_BLANC_ULTRA", "LEADER_VV_ANGRY_BLANC"))
						end
					end
				else
					for row in GameInfo.Diplomacy_Responses() do
						if row.LeaderType == "LEADER_VV_BLANC_ULTRA" then
							ChangeDiplomacyReference(row.Response, string.gsub(row.Response, "LEADER_VV_ANGRY_BLANC", "LEADER_VV_BLANC_ULTRA"))
						end
					end
				end
			elseif iLeaderType == iWhiteHeartUD then
				if (iApproach == MajorCivApproachTypes.MAJOR_CIV_APPROACH_HOSTILE or bAtWarNow == true) then
					for row in GameInfo.Diplomacy_Responses() do
						if row.LeaderType == "LEADER_VV_WHITE_HEART_ULTRA" then
							ChangeDiplomacyReference(row.Response, string.gsub(row.Response, "LEADER_VV_WHITE_HEART_ULTRA", "LEADER_VV_ANGRY_BLANC"))
						end
					end
				else
					for row in GameInfo.Diplomacy_Responses() do
						if row.LeaderType == "LEADER_VV_WHITE_HEART_ULTRA" then
							ChangeDiplomacyReference(row.Response, string.gsub(row.Response, "LEADER_VV_ANGRY_BLANC", "LEADER_VV_WHITE_HEART_ULTRA"))
						end
					end
				end
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(UpdateBlancDiploText)
Events.LoadScreenClose.Add(UpdateBlancDiploText)


--Unique Dialog Text for specific leaders.
--The leaders with unique text are:
--Neptune, Vert, Blanc, Nepgear (for obvious reasons)
--Demon Homura, Funny Valentine, Nanoha (various little jokes)
--Any Nintendo IP civilizations. The list currently includes:
---Fire Emblem Civs by Kiang, CodeFreak, and PaperMarioFan
---Bowser and Rosalina by Typhlomence
---Princess Peach by Nucleotyde
---Smithy Gang by Stephen Reiken

local tNeptuneCivs = {
	["CIVILIZATION_PLANEPTUNE"] = true,
	["CIVILIZATION_VV_PLANEPTUNE"] = true,
	["CIVILIZATION_VV_PLANEPTUNE_PH"] = true
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

local tVertCivs = {
	["CIVILIZATION_LEANBOX"] = true,
	["CIVILIZATION_VV_LEANBOX"] = true,
	["CIVILIZATION_VV_LEANBOX_GH"] = true,
	["CIVILIZATION_VV_LEANBOX_ULTRA"] = true,
	["CIVILIZATION_VV_LEANBOX_GH_ULTRA"] = true
}

local tNepgearCivs = {
	["CIVILIZATION_VV_PLANEPTUNE_NG"] = true,
	["CIVILIZATION_VV_PLANEPTUNE_PS"] = true
}

local sDemonHomura = "CIVILIZATION_DEMON_HOMURA"
local sFunnyValentine = "CIVILIZATION_JJBA_AMERICA"
local sNanoha = "CIVILIZATION_TSAB"

local tNintendoCivs = {
	["CIVILIZATION_DAEIN"] = true,
	["CIVILIZATION_CRIMEA"] = true,
	["CIVILIZATION_BEGNION"] = true,
	["CIVILIZATION_FECORDELIA"] = true,
	["CIVILIZATION_TAGUEL"] = true,
	["CIVILIZATION_YLISSE"] = true,
	["CIVILIZATION_PLEGIA"] = true,
	["CIVILIZATION_KOOPA_TROOP"] = true,
	["CIVILIZATION_TYPH_LUMAS"] = true,
	["CIVILIZATION_MUSHROOM"] = true,
	["CIVILIZATION_SMITHY"] = true
}

--Thanks to Typhlomence for this and the ChangeDiplomacyReference function!
function BlancCharacterSpecificDialogText()
	local locale = "Language_" ..Locale.GetCurrentLanguage().Type;
	local pActivePlayer = Players[Game:GetActivePlayer()]
	local sCivilizationType = GameInfo.Civilizations[pActivePlayer:GetCivilizationType()].Type

	
	if tNeptuneCivs[sCivilizationType] then
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_DEFEATED%", "TXT_KEY_UD_VS_NEPTUNE_BLANC_DEFEATED%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_FIRSTGREETING%", "TXT_KEY_UD_VS_NEPTUNE_BLANC_FIRSTGREETING%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_GREETING_POLITE_HELLO%", "TXT_KEY_UD_VS_NEPTUNE_BLANC_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_GREETING_NEUTRAL_HELLO%", "TXT_KEY_UD_VS_NEPTUNE_BLANC_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_GREETING_HOSTILE_HELLO%", "TXT_KEY_UD_VS_NEPTUNE_BLANC_GREETING_HOSTILE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_ATTACKED_HOSTILE%", "TXT_KEY_UD_VS_NEPTUNE_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_ATTACKED_WEAK_HOSTILE%", "TXT_KEY_UD_VS_NEPTUNE_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_ATTACKED_STRONG_HOSTILE%", "TXT_KEY_UD_VS_NEPTUNE_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_ATTACKED_EXCITED%", "TXT_KEY_UD_VS_NEPTUNE_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_ATTACKED_WEAK_EXCITED%", "TXT_KEY_UD_VS_NEPTUNE_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_ATTACKED_STRONG_EXCITED%", "TXT_KEY_UD_VS_NEPTUNE_BLANC_WAR_DECLARATION%")

		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_DEFEATED%", "TXT_KEY_UD_VS_NEPTUNE_BLANC_DEFEATED%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_FIRSTGREETING%", "TXT_KEY_UD_VS_NEPTUNE_BLANC_FIRSTGREETING%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_GREETING_POLITE_HELLO%", "TXT_KEY_UD_VS_NEPTUNE_BLANC_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_GREETING_NEUTRAL_HELLO%", "TXT_KEY_UD_VS_NEPTUNE_BLANC_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_GREETING_HOSTILE_HELLO%", "TXT_KEY_UD_VS_NEPTUNE_BLANC_GREETING_HOSTILE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_ATTACKED_HOSTILE%", "TXT_KEY_UD_VS_NEPTUNE_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_ATTACKED_WEAK_HOSTILE%", "TXT_KEY_UD_VS_NEPTUNE_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_ATTACKED_STRONG_HOSTILE%", "TXT_KEY_UD_VS_NEPTUNE_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_ATTACKED_EXCITED%", "TXT_KEY_UD_VS_NEPTUNE_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_ATTACKED_WEAK_EXCITED%", "TXT_KEY_UD_VS_NEPTUNE_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_ATTACKED_STRONG_EXCITED%", "TXT_KEY_UD_VS_NEPTUNE_BLANC_WAR_DECLARATION%")
	elseif tNoireCivs[sCivilizationType] then
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_DEFEATED%", "TXT_KEY_UD_VS_NOIRE_BLANC_DEFEATED%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_FIRSTGREETING%", "TXT_KEY_UD_VS_NOIRE_BLANC_FIRSTGREETING%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_GREETING_POLITE_HELLO%", "TXT_KEY_UD_VS_NOIRE_BLANC_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_GREETING_NEUTRAL_HELLO%", "TXT_KEY_UD_VS_NOIRE_BLANC_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_GREETING_HOSTILE_HELLO%", "TXT_KEY_UD_VS_NOIRE_BLANC_GREETING_HOSTILE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_ATTACKED_HOSTILE%", "TXT_KEY_UD_VS_NOIRE_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_ATTACKED_WEAK_HOSTILE%", "TXT_KEY_UD_VS_NOIRE_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_ATTACKED_STRONG_HOSTILE%", "TXT_KEY_UD_VS_NOIRE_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_ATTACKED_EXCITED%", "TXT_KEY_UD_VS_NOIRE_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_ATTACKED_WEAK_EXCITED%", "TXT_KEY_UD_VS_NOIRE_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_ATTACKED_STRONG_EXCITED%", "TXT_KEY_UD_VS_NOIRE_BLANC_WAR_DECLARATION%")

		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_DEFEATED%", "TXT_KEY_UD_VS_NOIRE_BLANC_DEFEATED%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_FIRSTGREETING%", "TXT_KEY_UD_VS_NOIRE_BLANC_FIRSTGREETING%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_GREETING_POLITE_HELLO%", "TXT_KEY_UD_VS_NOIRE_BLANC_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_GREETING_NEUTRAL_HELLO%", "TXT_KEY_UD_VS_NOIRE_BLANC_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_GREETING_HOSTILE_HELLO%", "TXT_KEY_UD_VS_NOIRE_BLANC_GREETING_HOSTILE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_ATTACKED_HOSTILE%", "TXT_KEY_UD_VS_NOIRE_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_ATTACKED_WEAK_HOSTILE%", "TXT_KEY_UD_VS_NOIRE_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_ATTACKED_STRONG_HOSTILE%", "TXT_KEY_UD_VS_NOIRE_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_ATTACKED_EXCITED%", "TXT_KEY_UD_VS_NOIRE_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_ATTACKED_WEAK_EXCITED%", "TXT_KEY_UD_VS_NOIRE_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_ATTACKED_STRONG_EXCITED%", "TXT_KEY_UD_VS_NOIRE_BLANC_WAR_DECLARATION%")
	elseif tVertCivs[sCivilizationType] then
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_DEFEATED%", "TXT_KEY_UD_VS_VERT_BLANC_DEFEATED%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_FIRSTGREETING%", "TXT_KEY_UD_VS_VERT_BLANC_FIRSTGREETING%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_GREETING_POLITE_HELLO%", "TXT_KEY_UD_VS_VERT_BLANC_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_GREETING_NEUTRAL_HELLO%", "TXT_KEY_UD_VS_VERT_BLANC_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_GREETING_HOSTILE_HELLO%", "TXT_KEY_UD_VS_VERT_BLANC_GREETING_HOSTILE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_ATTACKED_HOSTILE%", "TXT_KEY_UD_VS_VERT_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_ATTACKED_WEAK_HOSTILE%", "TXT_KEY_UD_VS_VERT_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_ATTACKED_STRONG_HOSTILE%", "TXT_KEY_UD_VS_VERT_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_ATTACKED_EXCITED%", "TXT_KEY_UD_VS_VERT_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_ATTACKED_WEAK_EXCITED%", "TXT_KEY_UD_VS_VERT_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_ATTACKED_STRONG_EXCITED%", "TXT_KEY_UD_VS_VERT_BLANC_WAR_DECLARATION%")

		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_DEFEATED%", "TXT_KEY_UD_VS_VERT_BLANC_DEFEATED%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_FIRSTGREETING%", "TXT_KEY_UD_VS_VERT_BLANC_FIRSTGREETING%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_GREETING_POLITE_HELLO%", "TXT_KEY_UD_VS_VERT_BLANC_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_GREETING_NEUTRAL_HELLO%", "TXT_KEY_UD_VS_VERT_BLANC_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_GREETING_HOSTILE_HELLO%", "TXT_KEY_UD_VS_VERT_BLANC_GREETING_HOSTILE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_ATTACKED_HOSTILE%", "TXT_KEY_UD_VS_VERT_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_ATTACKED_WEAK_HOSTILE%", "TXT_KEY_UD_VS_VERT_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_ATTACKED_STRONG_HOSTILE%", "TXT_KEY_UD_VS_VERT_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_ATTACKED_EXCITED%", "TXT_KEY_UD_VS_VERT_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_ATTACKED_WEAK_EXCITED%", "TXT_KEY_UD_VS_VERT_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_ATTACKED_STRONG_EXCITED%", "TXT_KEY_UD_VS_VERT_BLANC_WAR_DECLARATION%")
	elseif tNepgearCivs[sCivilizationType] then
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_DEFEATED%", "TXT_KEY_UD_VS_NEPGEAR_BLANC_DEFEATED%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_FIRSTGREETING%", "TXT_KEY_UD_VS_NEPGEAR_BLANC_FIRSTGREETING%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_GREETING_POLITE_HELLO%", "TXT_KEY_UD_VS_NEPGEAR_BLANC_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_GREETING_NEUTRAL_HELLO%", "TXT_KEY_UD_VS_NEPGEAR_BLANC_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_GREETING_HOSTILE_HELLO%", "TXT_KEY_UD_VS_NEPGEAR_BLANC_GREETING_HOSTILE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_ATTACKED_HOSTILE%", "TXT_KEY_UD_VS_NEPGEAR_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_ATTACKED_WEAK_HOSTILE%", "TXT_KEY_UD_VS_NEPGEAR_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_ATTACKED_STRONG_HOSTILE%", "TXT_KEY_UD_VS_NEPGEAR_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_ATTACKED_EXCITED%", "TXT_KEY_UD_VS_NEPGEAR_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_ATTACKED_WEAK_EXCITED%", "TXT_KEY_UD_VS_NEPGEAR_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_ATTACKED_STRONG_EXCITED%", "TXT_KEY_UD_VS_NEPGEAR_BLANC_WAR_DECLARATION%")

		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_DEFEATED%", "TXT_KEY_UD_VS_NEPGEAR_BLANC_DEFEATED%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_FIRSTGREETING%", "TXT_KEY_UD_VS_NEPGEAR_BLANC_FIRSTGREETING%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_GREETING_POLITE_HELLO%", "TXT_KEY_UD_VS_NEPGEAR_BLANC_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_GREETING_NEUTRAL_HELLO%", "TXT_KEY_UD_VS_NEPGEAR_BLANC_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_GREETING_HOSTILE_HELLO%", "TXT_KEY_UD_VS_NEPGEAR_BLANC_GREETING_HOSTILE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_ATTACKED_HOSTILE%", "TXT_KEY_UD_VS_NEPGEAR_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_ATTACKED_WEAK_HOSTILE%", "TXT_KEY_UD_VS_NEPGEAR_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_ATTACKED_STRONG_HOSTILE%", "TXT_KEY_UD_VS_NEPGEAR_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_ATTACKED_EXCITED%", "TXT_KEY_UD_VS_NEPGEAR_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_ATTACKED_WEAK_EXCITED%", "TXT_KEY_UD_VS_NEPGEAR_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_ATTACKED_STRONG_EXCITED%", "TXT_KEY_UD_VS_NEPGEAR_BLANC_WAR_DECLARATION%")
	elseif tUniCivs[sCivilizationType] then
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_DEFEATED%", "TXT_KEY_UD_VS_UNI_BLANC_DEFEATED%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_FIRSTGREETING%", "TXT_KEY_UD_VS_UNI_BLANC_FIRSTGREETING%")

		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_DEFEATED%", "TXT_KEY_UD_VS_UNI_BLANC_DEFEATED%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_FIRSTGREETING%", "TXT_KEY_UD_VS_UNI_BLANC_FIRSTGREETING%")
	elseif tNintendoCivs[sCivilizationType] then
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_DEFEATED%", "TXT_KEY_UD_VS_NINTENDO_BLANC_DEFEATED%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_FIRSTGREETING%", "TXT_KEY_UD_VS_NINTENDO_BLANC_FIRSTGREETING%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_GREETING_POLITE_HELLO%", "TXT_KEY_UD_VS_NINTENDO_BLANC_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_GREETING_NEUTRAL_HELLO%", "TXT_KEY_UD_VS_NINTENDO_BLANC_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_GREETING_HOSTILE_HELLO%", "TXT_KEY_UD_VS_NINTENDO_BLANC_GREETING_HOSTILE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_ATTACKED_HOSTILE%", "TXT_KEY_UD_VS_NINTENDO_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_ATTACKED_WEAK_HOSTILE%", "TXT_KEY_UD_VS_NINTENDO_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_ATTACKED_STRONG_HOSTILE%", "TXT_KEY_UD_VS_NINTENDO_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_ATTACKED_EXCITED%", "TXT_KEY_UD_VS_NINTENDO_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_ATTACKED_WEAK_EXCITED%", "TXT_KEY_UD_VS_NINTENDO_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_ATTACKED_STRONG_EXCITED%", "TXT_KEY_UD_VS_NINTENDO_BLANC_WAR_DECLARATION%")

		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_DEFEATED%", "TXT_KEY_UD_VS_NINTENDO_BLANC_DEFEATED%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_FIRSTGREETING%", "TXT_KEY_UD_VS_NINTENDO_BLANC_FIRSTGREETING%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_GREETING_POLITE_HELLO%", "TXT_KEY_UD_VS_NINTENDO_BLANC_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_GREETING_NEUTRAL_HELLO%", "TXT_KEY_UD_VS_NINTENDO_BLANC_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_GREETING_HOSTILE_HELLO%", "TXT_KEY_UD_VS_NINTENDO_BLANC_GREETING_HOSTILE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_ATTACKED_HOSTILE%", "TXT_KEY_UD_VS_NINTENDO_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_ATTACKED_WEAK_HOSTILE%", "TXT_KEY_UD_VS_NINTENDO_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_ATTACKED_STRONG_HOSTILE%", "TXT_KEY_UD_VS_NINTENDO_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_ATTACKED_EXCITED%", "TXT_KEY_UD_VS_NINTENDO_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_ATTACKED_WEAK_EXCITED%", "TXT_KEY_UD_VS_NINTENDO_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_ATTACKED_STRONG_EXCITED%", "TXT_KEY_UD_VS_NINTENDO_BLANC_WAR_DECLARATION%")
	elseif sCivilizationType == sDemonHomura then
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_ATTACKED_HOSTILE%", "TXT_KEY_UD_VS_DEMON_HOMURA_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_ATTACKED_WEAK_HOSTILE%", "TXT_KEY_UD_VS_DEMON_HOMURA_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_ATTACKED_STRONG_HOSTILE%", "TXT_KEY_UD_VS_DEMON_HOMURA_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_ATTACKED_EXCITED%", "TXT_KEY_UD_VS_DEMON_HOMURA_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_ATTACKED_WEAK_EXCITED%", "TXT_KEY_UD_VS_DEMON_HOMURA_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_ATTACKED_STRONG_EXCITED%", "TXT_KEY_UD_VS_DEMON_HOMURA_BLANC_WAR_DECLARATION%")

		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_ATTACKED_HOSTILE%", "TXT_KEY_UD_VS_DEMON_HOMURA_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_ATTACKED_WEAK_HOSTILE%", "TXT_KEY_UD_VS_DEMON_HOMURA_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_ATTACKED_STRONG_HOSTILE%", "TXT_KEY_UD_VS_DEMON_HOMURA_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_ATTACKED_EXCITED%", "TXT_KEY_UD_VS_DEMON_HOMURA_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_ATTACKED_WEAK_EXCITED%", "TXT_KEY_UD_VS_DEMON_HOMURA_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_ATTACKED_STRONG_EXCITED%", "TXT_KEY_UD_VS_DEMON_HOMURA_BLANC_WAR_DECLARATION%")
	elseif sCivilizationType == sFunnyValentine then
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_ATTACKED_HOSTILE%", "TXT_KEY_UD_VS_FUNNY_VALENTINE_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_ATTACKED_WEAK_HOSTILE%", "TXT_KEY_UD_VS_FUNNY_VALENTINE_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_ATTACKED_STRONG_HOSTILE%", "TXT_KEY_UD_VS_FUNNY_VALENTINE_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_ATTACKED_EXCITED%", "TXT_KEY_UD_VS_FUNNY_VALENTINE_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_ATTACKED_WEAK_EXCITED%", "TXT_KEY_UD_VS_FUNNY_VALENTINE_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_ATTACKED_STRONG_EXCITED%", "TXT_KEY_UD_VS_FUNNY_VALENTINE_BLANC_WAR_DECLARATION%")

		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_ATTACKED_HOSTILE%", "TXT_KEY_UD_VS_FUNNY_VALENTINE_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_ATTACKED_WEAK_HOSTILE%", "TXT_KEY_UD_VS_FUNNY_VALENTINE_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_ATTACKED_STRONG_HOSTILE%", "TXT_KEY_UD_VS_FUNNY_VALENTINE_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_ATTACKED_EXCITED%", "TXT_KEY_UD_VS_FUNNY_VALENTINE_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_ATTACKED_WEAK_EXCITED%", "TXT_KEY_UD_VS_FUNNY_VALENTINE_BLANC_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_ATTACKED_STRONG_EXCITED%", "TXT_KEY_UD_VS_FUNNY_VALENTINE_BLANC_WAR_DECLARATION%")
	elseif sCivilizationType == sNanoha then
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_FIRSTGREETING%", "TXT_KEY_UD_VS_NANOHA_BLANC_FIRSTGREETING%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLANC_GREETING_POLITE_HELLO%", "TXT_KEY_UD_VS_NANOHA_BLANC_GREETING_POLITE%")

		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_FIRSTGREETING%", "TXT_KEY_UD_VS_NANOHA_BLANC_FIRSTGREETING%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_WHITE_HEART_GREETING_POLITE_HELLO%", "TXT_KEY_UD_VS_NANOHA_BLANC_GREETING_POLITE%")
	end
	
end


--If both Verts are in the game, UD Vert's description and capital are changed to differentiate.
function UpdateBlancCivDescriptions()
	local bIsHDBlanc
	local bIsUDBlanc
	for i = 0, iMaxCivs - 1, 1 do
		local pPlayer = Players[i]
		if pPlayer:IsEverAlive() then
			local sCivilizationType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			if sCivilizationType == "CIVILIZATION_VV_LOWEE" or sCivilizationType == "CIVILIZATION_VV_LOWEE_GH" then
				bIsHDBlanc = true
			elseif sCivilizationType == "CIVILIZATION_VV_LOWEE_ULTRA" or sCivilizationType == "CIVILIZATION_VV_LOWEE_GH_ULTRA" then
				bIsUDBlanc = true
			end
			if bIsHDBlanc and bIsUDBlanc then
				ChangeDiplomacyGameText("TXT_KEY_CIV_VV_LOWEE_ULTRA_DESC", "TXT_KEY_CIV_VV_LOWEE_ULTRA_DESC_ALT")
				ChangeDiplomacyGameText("TXT_KEY_CIV_VV_LOWEE_ULTRA_SHORT_DESC", "TXT_KEY_CIV_VV_LOWEE_ULTRA_SHORT_DESC_ALT")
				ChangeDiplomacyGameText("TXT_KEY_CIV_VV_LOWEE_ULTRA_ADJECTIVE", "TXT_KEY_CIV_VV_LOWEE_ULTRA_ADJECTIVE_ALT")
				ChangeDiplomacyGameText("TXT_KEY_CITY_NAME_VV_HDNCAPITAL_LOWEE_ULTRA", "TXT_KEY_CITY_NAME_VV_HDNCAPITAL_LOWEE_ULTRA_ALT")
				Locale.SetCurrentLanguage(Locale.GetCurrentLanguage().Type)
				break
			end
		end
	end
end

function OnLoadScreenCloseBlancText()
	if not HDNMod.BlancTextInit then
		BlancCharacterSpecificDialogText()
		UpdateBlancCivDescriptions()
		HDNMod.BlancTextInit = true
	end
end

Events.LoadScreenClose.Add(OnLoadScreenCloseBlancText)


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


--Put shrooms in Blanc's cities
function OnPlayerCityFoundedBlancMushrooms(iPlayer)
	if tBlancs[iPlayer] then
		local pPlayer = Players[iPlayer]
		for pCity in pPlayer:Cities() do
			pCity:Plot():SetImprovementType(GameInfoTypes.IMPROVEMENT_VV_LOWEE_CITY_DUMMY)
		end
	end
end

GameEvents.PlayerCityFounded.Add(OnPlayerCityFoundedBlancMushrooms)