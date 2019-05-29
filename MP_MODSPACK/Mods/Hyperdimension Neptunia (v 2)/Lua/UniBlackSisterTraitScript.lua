-- UniBlackSisterTraitScript
-- Author: Vice
-- DateCreated: 8/4/2015 4:27:31 PM
--------------------------------------------------------------


print("I-it's not like Uni wanted her trait script to load! It just happened to be set to VFS=true, that's all!")


local PRODUCTION_SPEED_MOD = GameInfo.GameSpeeds[PreGame.GetGameSpeed()].ConstructPercent / 100
local GROWTH_SPEED_MOD = GameInfo.GameSpeeds[PreGame.GetGameSpeed()].GrowthPercent / 100
local iMaxCivs = GameDefines.MAX_MAJOR_CIVS
local bWFTW = GameInfoTypes.UNIT_PMMM_MAGICAL_GIRL and true or false;
local iMagicalGirlClass = GameInfoTypes.UNITCLASS_PMMM_MAGICAL_GIRL
local HDD_SHARE_THRESHOLD = GameDefines.VV_HDN_HDD_SHARE_THRESHOLD



--UA Constants
local tScoreDiffLevels = {
	[0] =	{
				["MinDiff"] = 0.95,
				["MaxDiff"] = 1.00,
				["Bonus"] = 0,
				["PortraitIndex"] = 9,
				["TextKey"] = "TXT_KEY_VV_UNI_UA_TOOLTIP_0"
			},
	[1] =	{
				["MinDiff"] = 0.80,
				["MaxDiff"] = 0.94,
				["Bonus"] = 5,
				["PortraitIndex"] = 5,
				["TextKey"] = "TXT_KEY_VV_UNI_UA_TOOLTIP_1"
			},
	[2] =	{
				["MinDiff"] = 0.65,
				["MaxDiff"] = 0.79,
				["Bonus"] = 10,
				["PortraitIndex"] = 6,
				["TextKey"] = "TXT_KEY_VV_UNI_UA_TOOLTIP_2"
			},
	[3] =	{
				["MinDiff"] = 0.50,
				["MaxDiff"] = 0.64,
				["Bonus"] = 15,
				["PortraitIndex"] = 7,
				["TextKey"] = "TXT_KEY_VV_UNI_UA_TOOLTIP_3"
			},
	[4] =	{
				["MinDiff"] = 0.00,
				["MaxDiff"] = 0.49,
				["Bonus"] = 20,
				["PortraitIndex"] = 8,
				["TextKey"] = "TXT_KEY_VV_UNI_UA_TOOLTIP_4"
			}
}

local BLACK_SISTER_PRODUCTION_THRESHOLD = math.ceil(200 * PRODUCTION_SPEED_MOD) --multiplied by current Shares
local UNI_UA_DUMMY = GameInfoTypes.BUILDING_VV_LASTATION_UN_DUMMY_BUILDING_UNI_UA
local BLACK_SISTER_UA_DUMMY = GameInfoTypes.BUILDING_VV_LASTATION_UN_DUMMY_BUILDING_BLACK_SISTER_UA
local DRM_TOWER = GameInfoTypes.BUILDING_VV_DRM_TOWER
local UNI_COUNTERSPY_SHARES = 25
local UNI_FLUSTERED_THRESHOLD = 0.66  --for determining if Uni is giving annoyed looks and lines to the player if they're outpacing her by a lot
local XMB_PROMO = GameInfoTypes.PROMOTION_VV_XMB_ARTILLERY
local XMB_BUFF = GameInfoTypes.PROMOTION_VV_XMB_ARTILLERY_BONUS

HDNMod.UniGotFreeSpy = HDNMod.UniGotFreeSpy or {}

local tSetupRequiredUnits = {}
for row in GameInfo.Unit_FreePromotions() do
	if row.PromotionType == 'PROMOTION_MUST_SET_UP' then
		local unit = GameInfo.Units[row.UnitType]
		if unit then
			tSetupRequiredUnits[unit.ID] = true
		end
	end
end
local iSetupPromo = GameInfoTypes.PROMOTION_MUST_SET_UP


--Civ Identifiers
local iUni = GameInfoTypes.LEADER_VV_UNI or -1
local iBlackSister = GameInfoTypes.LEADER_VV_BLACK_SISTER or -1
local iUniCiv = GameInfoTypes.CIVILIZATION_VV_LASTATION_UN or -1
local iBlackSisterCiv = GameInfoTypes.CIVILIZATION_VV_LASTATION_BS or -1
local tUnis = {}
for i = 0, iMaxCivs - 1, 1 do
	local pPlayer = Players[i]
	if pPlayer:IsEverAlive() then
		local iLeaderType = pPlayer:GetLeaderType()
		if (iLeaderType == iUni or iLeaderType == iBlackSister) then
			tUnis[i] = true
		end
	end
end

function GetNumCounterspies(iPlayer)
	local pPlayer = Players[iPlayer]
	local agents = pPlayer:GetEspionageSpies();
	local iValue = 0
	for k, v in pairs(agents) do
		local pPlot = Map.GetPlot(v.CityX, v.CityY)
		if pPlot then
			local pCity = pPlot:GetPlotCity()
			if pCity and pCity:GetOwner() == iPlayer then
				iValue = iValue + 1
			end
		end
	end
	return iValue
end

--Find the top-scoring player that Uni has met, and return their score and player ID.
function CheckUniTopScoringPlayerMet(iPlayer)
	local pPlayer = Players[iPlayer]
	local iOurScore = pPlayer:GetScore()
	local iHighestScore = iOurScore
	local iHighestScorePlayer = iPlayer
	local pTeam = Teams[pPlayer:GetTeam()]
	for i = 0, iMaxCivs - 1, 1 do
		if i ~= iPlayer then
			local pLoop = Players[i]
			if pLoop:IsAlive() and pTeam:IsHasMet(pLoop:GetTeam()) and pLoop:GetScore() > iHighestScore then 
				iHighestScore = pLoop:GetScore()
				iHighestScorePlayer = i
			end
		end
	end
	return iHighestScore, iHighestScorePlayer
end

--Get the difference between Uni's score and another score, as a percent represented by decimals.
function GetUniScoreDifference(iPlayer, iScore)
	local pPlayer = Players[iPlayer]
	local iOurScore = pPlayer:GetScore()
	local iPercentOfTheirScore = math.floor(iOurScore / iScore * 100) * 0.01  --rounds to two decimal places
	return iPercentOfTheirScore
end

--Get the Level of UA bonus from the score difference.
function GetUniScoreDifferenceLevel(iPlayer, iScoreDifference)
	for k, v in pairs(tScoreDiffLevels) do
		if v.MinDiff <= iScoreDifference and v.MaxDiff >= iScoreDifference then
			return k
		end
	end
	return 0
end

--Set Uni's dummy buildings; both for Uni's UA and Black Sister's UA.
--Can pass a City ID to only do this to one city, otherwise, it loops over them all.
function SetUniDummyBuildings(iPlayer, iCity)
	local pPlayer = Players[iPlayer]
	local iNumUniBuildings = 0
	local iNumBSBuildings = 0
	if IsPlayerHDDMode(pPlayer) then
		iNumBSBuildings = math.floor(HDNMod.Shares[iPlayer] / BLACK_SISTER_PRODUCTION_THRESHOLD)
	else
		local iHighScore, iHighScorePlayer = CheckUniTopScoringPlayerMet(iPlayer)
		local iScoreDiff = 1
		if iHighScorePlayer ~= iPlayer then
			iScoreDiff = GetUniScoreDifference(iPlayer, iHighScore)
		end
		local iLevel = GetUniScoreDifferenceLevel(iPlayer, iScoreDiff)
		iNumUniBuildings = tScoreDiffLevels[iLevel].Bonus
	end
	if iCity then
		pCity:SetNumRealBuilding(UNI_UA_DUMMY, iNumUniBuildings, true)
		pCity:SetNumRealBuilding(BLACK_SISTER_UA_DUMMY, iNumBSBuildings, true)
	else
		for pCity in pPlayer:Cities() do
			pCity:SetNumRealBuilding(UNI_UA_DUMMY, iNumUniBuildings, true)
			pCity:SetNumRealBuilding(BLACK_SISTER_UA_DUMMY, iNumBSBuildings, true)
		end
	end
end

--Function to call the above function with SerialEventScoreDirty. This way, the effects of mid-turn score changes can be seen immediately.
function OnSerialEventScoreDirty()
	for k, v in pairs(tUnis) do
		if v == true and Players[k]:IsAlive() then
			SetUniDummyBuildings(k)
		end
	end
end
Events.SerialEventScoreDirty.Add(OnSerialEventScoreDirty)


--Check Units to see if they need their "Setup to Fire" promo removed or added.
--You can pass a Unit ID to check only one unit. If no Unit ID passed, it checks all units.
function CheckUniSiegeUnits(iPlayer, iUnit)
	local pPlayer = Players[iPlayer]
	local bSet = not IsPlayerHDDMode(pPlayer)  --If HDD mode is true, then possessing the promotion should be false, so hence the "not"
	if bWFTW == true then bSet = true end --In WFTW, this part of BS's UA is removed
	if iUnit then
		local pUnit = pPlayer:GetUnitByID(iUnit)
		if tSetupRequiredUnits[pUnit:GetUnitType()] then
			pUnit:SetHasPromotion(iSetupPromo, bSet)
		end
	else
		for pUnit in pPlayer:Units() do
			if tSetupRequiredUnits[pUnit:GetUnitType()] then
				pUnit:SetHasPromotion(iSetupPromo, bSet)
			end
		end
	end
end

--Should XMBs get their dual-attack buff?
function CheckXMBArtilleryBuff(pUnit, tAlreadyUsedGenerals)
	for pAreaPlot in PlotAreaSpiralIterator(pUnit:GetPlot(), 1, 1, false, false, true) do
		if pAreaPlot:IsUnit() then
			for c = 0, pAreaPlot:GetNumUnits() - 1 do
				local pPlotUnit = pAreaPlot:GetUnit(c)
				if pPlotUnit and pPlotUnit ~= pUnit then
					if not tAlreadyUsedGenerals[pPlotUnit:GetID()] and pPlotUnit:GetOwner() == pUnit:GetOwner() and pPlotUnit:IsHasPromotion(GameInfoTypes.PROMOTION_GREAT_GENERAL) then
						pUnit:SetHasPromotion(XMB_BUFF, true)
						tAlreadyUsedGenerals[pPlotUnit:GetID()] = true
						return tAlreadyUsedGenerals
					end
				end
			end
		end
	end
end


--When Uni trains a new unit, check its setup to fire promotion.
function OnCityTrained(iPlayer, iCity, iUnitID, bGold, bFaithOrCulture)
	if tUnis[iPlayer] then
		CheckUniSiegeUnits(iPlayer, iUnitID)
	end
end
GameEvents.CityTrained.Add(OnCityTrained)

--When Uni constructs a building, check and see if it was a DRM tower, and if so, if she has one in every city she owns.
--If she does, grant her a free spy (unless of course she's already gotten the bonus)
function OnCityConstructed(iPlayer, iCity, iBuildingType)
	if tUnis[iPlayer] and iBuildingType == DRM_TOWER and not HDNMod.UniGotFreeSpy[iPlayer] then
		local pPlayer = Players[iPlayer]
		for pCity in pPlayer:Cities() do
			if not pCity:IsHasBuilding(DRM_TOWER) then
				return
			end
		end
		pPlayer:GetCapitalCity():SetNumRealBuilding(GameInfoTypes.BUILDING_VV_LASTATION_UN_DUMMY_BUILDING_UNI_SPY, 1, true)
		HDNMod.UniGotFreeSpy[iPlayer] = true
	end
end
GameEvents.CityConstructed.Add(OnCityConstructed)

function OnPlayerDoTurn(iPlayer)
	local pPlayer = Players[iPlayer]
	if tUnis[iPlayer] then
		--Update Dummy Buildings
		SetUniDummyBuildings(iPlayer)
		--Update Siege Units
		CheckUniSiegeUnits(iPlayer)
	end
	local tAlreadyUsedGenerals = {} 
	for pUnit in pPlayer:Units() do
		if pUnit:IsHasPromotion(XMB_PROMO) then
			tAlreadyUsedGenerals = CheckXMBArtilleryBuff(pUnit, tAlreadyUsedGenerals)
		end
	end
end
GameEvents.PlayerDoTurn.Add(OnPlayerDoTurn)

function OnTransformed(iPlayer, bHDDOn)
	if tUnis[iPlayer] then
		CheckUniSiegeUnits(iPlayer)
	end
end
LuaEvents.VV_ConvertHDNLeader.Add(OnTransformed)

function UniTransformationAILogic(iPlayer)
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

function BlackSisterTransformationAILogic(iPlayer)
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
LuaEvents.VV_AddToTransformLogicTable(iUni, UniTransformationAILogic)
LuaEvents.VV_AddToTransformLogicTable(iBlackSister, BlackSisterTransformationAILogic)



--Special Leaderscene logic just for Uni:
--If she is Friendly towards the player, but is only at 66% or less of the player's score, she gets a little flustered.
function UniSpecialLeaderscene( iPlayer, iDiploUIState, szLeaderMessage, iAnimationAction, iData1 )
	local pPlayer = Players[iPlayer]
	if pPlayer:GetCivilizationType() == iUniCiv then
		local pActivePlayer = Players[Game:GetActivePlayer()]
		local iApproach = pActivePlayer:GetApproachTowardsUsGuess(iPlayer);
		local bWar = Teams[pActivePlayer:GetTeam()]:IsAtWar(pPlayer:GetTeam())

		if not bWar and iApproach == MajorCivApproachTypes.MAJOR_CIV_APPROACH_FRIENDLY then
			local iPercent = GetUniScoreDifference(iPlayer, pActivePlayer:GetScore())
			if iPercent <= UNI_FLUSTERED_THRESHOLD then
				return "VVUniLeaderSceneDynamicFriendlyLowScore.dds"
			end
		end
	end

	return nil
end

LuaEvents.AddFunctionToLeaderSceneTable(UniSpecialLeaderscene)


--Unique Dialog Text for specific leaders.
--The leaders with unique text are:
--Neptune, Vert, Blanc, Noire, Nepgear (for obvious reasons)
--Sayaka Miki (voice actress reference to Uni)
--Any Sony IP civilizations. The list currently includes:
---...none so far.

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

local tVertCivs = {
	["CIVILIZATION_LEANBOX"] = true,
	["CIVILIZATION_VV_LEANBOX"] = true,
	["CIVILIZATION_VV_LEANBOX_GH"] = true,
	["CIVILIZATION_VV_LEANBOX_ULTRA"] = true,
	["CIVILIZATION_VV_LEANBOX_GH_ULTRA"] = true
}

local tBlancCivs = {
	["CIVILIZATION_LOWEE"] = true,
	["CIVILIZATION_VV_LOWEE"] = true,
	["CIVILIZATION_VV_LOWEE_WH"] = true,
	["CIVILIZATION_VV_LOWEE_ULTRA"] = true,
	["CIVILIZATION_VV_LOWEE_WH_ULTRA"] = true
}

local sSayaka = "CIVILIZATON_SAYAKA"

local tPlaystationCivs = {
	--I don't think there are any Civs based off of PS-exclusive titles...
}

--Thanks to Typhlomence for this and the ChangeDiplomacyReference/ChangeDiplomacyText function!
function UniCharacterSpecificDialogText()
	local locale = "Language_" ..Locale.GetCurrentLanguage().Type;
	local pActivePlayer = Players[Game:GetActivePlayer()]
	local sCivilizationType = GameInfo.Civilizations[pActivePlayer:GetCivilizationType()].Type

	
	if tNeptuneCivs[sCivilizationType] then
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_DEFEATED%", "TXT_KEY_UD_VS_NEPTUNE_UNI_DEFEATED%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_FIRSTGREETING%", "TXT_KEY_UD_VS_NEPTUNE_UNI_FIRSTGREETING%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_GREETING_POLITE_HELLO%", "TXT_KEY_UD_VS_NEPTUNE_UNI_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_GREETING_NEUTRAL_HELLO%", "TXT_KEY_UD_VS_NEPTUNE_UNI_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_GREETING_HOSTILE_HELLO%", "TXT_KEY_UD_VS_NEPTUNE_UNI_GREETING_HOSTILE%")

		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_DEFEATED%", "TXT_KEY_UD_VS_NEPTUNE_UNI_DEFEATED%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_FIRSTGREETING%", "TXT_KEY_UD_VS_NEPTUNE_UNI_FIRSTGREETING%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_GREETING_POLITE_HELLO%", "TXT_KEY_UD_VS_NEPTUNE_UNI_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_GREETING_NEUTRAL_HELLO%", "TXT_KEY_UD_VS_NEPTUNE_UNI_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_GREETING_HOSTILE_HELLO%", "TXT_KEY_UD_VS_NEPTUNE_UNI_GREETING_HOSTILE%")
	elseif tNepgearCivs[sCivilizationType] then
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_DEFEATED%", "TXT_KEY_UD_VS_NEPGEAR_UNI_DEFEATED%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_FIRSTGREETING%", "TXT_KEY_UD_VS_NEPGEAR_UNI_FIRSTGREETING%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_GREETING_POLITE_HELLO%", "TXT_KEY_UD_VS_NEPGEAR_UNI_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_GREETING_NEUTRAL_HELLO%", "TXT_KEY_UD_VS_NEPGEAR_UNI_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_GREETING_HOSTILE_HELLO%", "TXT_KEY_UD_VS_NEPGEAR_UNI_GREETING_HOSTILE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_ATTACKED_HOSTILE%", "TXT_KEY_UD_VS_NEPGEAR_UNI_WAR_DECLARED_ON%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_ATTACKED_WEAK_HOSTILE%", "TXT_KEY_UD_VS_NEPGEAR_UNI_WAR_DECLARED_ON%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_ATTACKED_STRONG_HOSTILE%", "TXT_KEY_UD_VS_NEPGEAR_UNI_WAR_DECLARED_ON%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_ATTACKED_EXCITED%", "TXT_KEY_UD_VS_NEPGEAR_UNI_WAR_DECLARED_ON%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_ATTACKED_WEAK_EXCITED%", "TXT_KEY_UD_VS_NEPGEAR_UNI_WAR_DECLARED_ON%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_ATTACKED_STRONG_EXCITED%", "TXT_KEY_UD_VS_NEPGEAR_UNI_WAR_DECLARED_ON%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_DOW_LAND%", "TXT_KEY_UD_VS_NEPGEAR_UNI_DECLARES_WAR%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_DOW_GENERIC%", "TXT_KEY_UD_VS_NEPGEAR_UNI_DECLARES_WAR%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_DOW_WORLD_CONQUEST%", "TXT_KEY_UD_VS_NEPGEAR_UNI_DECLARES_WAR%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_DOW_BETRAYAL%", "TXT_KEY_UD_VS_NEPGEAR_UNI_DECLARES_WAR%")	
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_DOW_OPPORTUNITY%", "TXT_KEY_UD_VS_NEPGEAR_UNI_DECLARES_WAR%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_LETS_HEAR_IT%", "TXT_KEY_UD_VS_NEPGEAR_UNI_LETS_HEAR_IT%")	
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_RESPONSE_TO_BEING_DENOUNCED%", "TXT_KEY_UD_VS_NEPGEAR_UNI_RESPONSE_TO_DENOUNCEMENT%")	
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_DENOUNCE%", "TXT_KEY_UD_VS_NEPGEAR_UNI_DENOUNCE%")	
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_EMBASSY_EXCHANGE%", "TXT_KEY_UD_VS_NEPGEAR_UNI_EMBASSY_OFFER%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_EMBASSY_OFFER%", "TXT_KEY_UD_VS_NEPGEAR_UNI_EMBASSY_OFFER%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_OPEN_BORDERS_EXCHANGE%", "TXT_KEY_UD_VS_NEPGEAR_UNI_OPEN_BORDERS%")	
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_OPEN_BORDERS_OFFER%", "TXT_KEY_UD_VS_NEPGEAR_UNI_OPEN_BORDERS%")	
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_DEC_FRIENDSHIP%", "TXT_KEY_UD_VS_NEPGEAR_UNI_FRIENDSHIP%")

		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_DEFEATED%", "TXT_KEY_UD_VS_NEPGEAR_UNI_DEFEATED%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_FIRSTGREETING%", "TXT_KEY_UD_VS_NEPGEAR_UNI_FIRSTGREETING%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_GREETING_POLITE_HELLO%", "TXT_KEY_UD_VS_NEPGEAR_UNI_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_GREETING_NEUTRAL_HELLO%", "TXT_KEY_UD_VS_NEPGEAR_UNI_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_GREETING_HOSTILE_HELLO%", "TXT_KEY_UD_VS_NEPGEAR_UNI_GREETING_HOSTILE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_ATTACKED_HOSTILE%", "TXT_KEY_UD_VS_NEPGEAR_UNI_WAR_DECLARED_ON%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_ATTACKED_WEAK_HOSTILE%", "TXT_KEY_UD_VS_NEPGEAR_UNI_WAR_DECLARED_ON%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_ATTACKED_STRONG_HOSTILE%", "TXT_KEY_UD_VS_NEPGEAR_UNI_WAR_DECLARED_ON%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_ATTACKED_EXCITED%", "TXT_KEY_UD_VS_NEPGEAR_UNI_WAR_DECLARED_ON%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_ATTACKED_WEAK_EXCITED%", "TXT_KEY_UD_VS_NEPGEAR_UNI_WAR_DECLARED_ON%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_ATTACKED_STRONG_EXCITED%", "TXT_KEY_UD_VS_NEPGEAR_UNI_WAR_DECLARED_ON%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_DOW_LAND%", "TXT_KEY_UD_VS_NEPGEAR_UNI_DECLARES_WAR%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_DOW_GENERIC%", "TXT_KEY_UD_VS_NEPGEAR_UNI_DECLARES_WAR%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_DOW_WORLD_CONQUEST%", "TXT_KEY_UD_VS_NEPGEAR_UNI_DECLARES_WAR%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_DOW_BETRAYAL%", "TXT_KEY_UD_VS_NEPGEAR_UNI_DECLARES_WAR%")	
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_DOW_OPPORTUNITY%", "TXT_KEY_UD_VS_NEPGEAR_UNI_DECLARES_WAR%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_LETS_HEAR_IT%", "TXT_KEY_UD_VS_NEPGEAR_UNI_LETS_HEAR_IT%")	
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_RESPONSE_TO_BEING_DENOUNCED%", "TXT_KEY_UD_VS_NEPGEAR_UNI_RESPONSE_TO_DENOUNCEMENT%")	
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_DENOUNCE%", "TXT_KEY_UD_VS_NEPGEAR_UNI_DENOUNCE%")	
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_EMBASSY_EXCHANGE%", "TXT_KEY_UD_VS_NEPGEAR_UNI_EMBASSY_OFFER%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_EMBASSY_OFFER%", "TXT_KEY_UD_VS_NEPGEAR_UNI_EMBASSY_OFFER%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_OPEN_BORDERS_EXCHANGE%", "TXT_KEY_UD_VS_NEPGEAR_UNI_OPEN_BORDERS%")	
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_OPEN_BORDERS_OFFER%", "TXT_KEY_UD_VS_NEPGEAR_UNI_OPEN_BORDERS%")	
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_DEC_FRIENDSHIP%", "TXT_KEY_UD_VS_NEPGEAR_UNI_FRIENDSHIP%")
	elseif tNoireCivs[sCivilizationType] then
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_DEFEATED%", "TXT_KEY_UD_VS_NOIRE_UNI_DEFEATED%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_FIRSTGREETING%", "TXT_KEY_UD_VS_NOIRE_UNI_FIRSTGREETING%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_GREETING_POLITE_HELLO%", "TXT_KEY_UD_VS_NOIRE_UNI_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_GREETING_NEUTRAL_HELLO%", "TXT_KEY_UD_VS_NOIRE_UNI_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_GREETING_HOSTILE_HELLO%", "TXT_KEY_UD_VS_NOIRE_UNI_GREETING_HOSTILE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_ATTACKED_HOSTILE%", "TXT_KEY_UD_VS_NOIRE_UNI_WAR_DECLARED_ON%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_ATTACKED_WEAK_HOSTILE%", "TXT_KEY_UD_VS_NOIRE_UNI_WAR_DECLARED_ON%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_ATTACKED_STRONG_HOSTILE%", "TXT_KEY_UD_VS_NOIRE_UNI_WAR_DECLARED_ON%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_ATTACKED_EXCITED%", "TXT_KEY_UD_VS_NOIRE_UNI_WAR_DECLARED_ON%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_ATTACKED_WEAK_EXCITED%", "TXT_KEY_UD_VS_NOIRE_UNI_WAR_DECLARED_ON%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_ATTACKED_STRONG_EXCITED%", "TXT_KEY_UD_VS_NOIRE_UNI_WAR_DECLARED_ON%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_DOW_LAND%", "TXT_KEY_UD_VS_NOIRE_UNI_DECLARES_WAR%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_DOW_GENERIC%", "TXT_KEY_UD_VS_NOIRE_UNI_DECLARES_WAR%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_DOW_WORLD_CONQUEST%", "TXT_KEY_UD_VS_NOIRE_UNI_DECLARES_WAR%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_DOW_BETRAYAL%", "TXT_KEY_UD_VS_NOIRE_UNI_DECLARES_WAR%")	
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_DOW_OPPORTUNITY%", "TXT_KEY_UD_VS_NOIRE_UNI_DECLARES_WAR%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_LETS_HEAR_IT%", "TXT_KEY_UD_VS_NOIRE_UNI_LETS_HEAR_IT%")	
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_RESPONSE_TO_BEING_DENOUNCED%", "TXT_KEY_UD_VS_NOIRE_UNI_RESPONSE_TO_DENOUNCEMENT%")	
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_DENOUNCE%", "TXT_KEY_UD_VS_NOIRE_UNI_DENOUNCE%")	
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_EMBASSY_EXCHANGE%", "TXT_KEY_UD_VS_NOIRE_UNI_EMBASSY_OFFER%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_EMBASSY_OFFER%", "TXT_KEY_UD_VS_NOIRE_UNI_EMBASSY_OFFER%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_OPEN_BORDERS_EXCHANGE%", "TXT_KEY_UD_VS_NOIRE_UNI_OPEN_BORDERS%")	
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_OPEN_BORDERS_OFFER%", "TXT_KEY_UD_VS_NOIRE_UNI_OPEN_BORDERS%")	
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_DEC_FRIENDSHIP%", "TXT_KEY_UD_VS_NOIRE_UNI_FRIENDSHIP%")

		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_DEFEATED%", "TXT_KEY_UD_VS_NOIRE_UNI_DEFEATED%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_FIRSTGREETING%", "TXT_KEY_UD_VS_NOIRE_UNI_FIRSTGREETING%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_GREETING_POLITE_HELLO%", "TXT_KEY_UD_VS_NOIRE_UNI_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_GREETING_NEUTRAL_HELLO%", "TXT_KEY_UD_VS_NOIRE_UNI_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_GREETING_HOSTILE_HELLO%", "TXT_KEY_UD_VS_NOIRE_UNI_GREETING_HOSTILE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_ATTACKED_HOSTILE%", "TXT_KEY_UD_VS_NOIRE_UNI_WAR_DECLARED_ON%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_ATTACKED_WEAK_HOSTILE%", "TXT_KEY_UD_VS_NOIRE_UNI_WAR_DECLARED_ON%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_ATTACKED_STRONG_HOSTILE%", "TXT_KEY_UD_VS_NOIRE_UNI_WAR_DECLARED_ON%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_ATTACKED_EXCITED%", "TXT_KEY_UD_VS_NOIRE_UNI_WAR_DECLARED_ON%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_ATTACKED_WEAK_EXCITED%", "TXT_KEY_UD_VS_NOIRE_UNI_WAR_DECLARED_ON%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_ATTACKED_STRONG_EXCITED%", "TXT_KEY_UD_VS_NOIRE_UNI_WAR_DECLARED_ON%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_DOW_LAND%", "TXT_KEY_UD_VS_NOIRE_UNI_DECLARES_WAR%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_DOW_GENERIC%", "TXT_KEY_UD_VS_NOIRE_UNI_DECLARES_WAR%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_DOW_WORLD_CONQUEST%", "TXT_KEY_UD_VS_NOIRE_UNI_DECLARES_WAR%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_DOW_BETRAYAL%", "TXT_KEY_UD_VS_NOIRE_UNI_DECLARES_WAR%")	
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_DOW_OPPORTUNITY%", "TXT_KEY_UD_VS_NOIRE_UNI_DECLARES_WAR%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_LETS_HEAR_IT%", "TXT_KEY_UD_VS_NOIRE_UNI_LETS_HEAR_IT%")	
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_RESPONSE_TO_BEING_DENOUNCED%", "TXT_KEY_UD_VS_NOIRE_UNI_RESPONSE_TO_DENOUNCEMENT%")	
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_DENOUNCE%", "TXT_KEY_UD_VS_NOIRE_UNI_DENOUNCE%")	
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_EMBASSY_EXCHANGE%", "TXT_KEY_UD_VS_NOIRE_UNI_EMBASSY_OFFER%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_EMBASSY_OFFER%", "TXT_KEY_UD_VS_NOIRE_UNI_EMBASSY_OFFER%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_OPEN_BORDERS_EXCHANGE%", "TXT_KEY_UD_VS_NOIRE_UNI_OPEN_BORDERS%")	
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_OPEN_BORDERS_OFFER%", "TXT_KEY_UD_VS_NOIRE_UNI_OPEN_BORDERS%")	
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_DEC_FRIENDSHIP%", "TXT_KEY_UD_VS_NOIRE_UNI_FRIENDSHIP%")
	elseif tVertCivs[sCivilizationType] then
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_DEFEATED%", "TXT_KEY_UD_VS_VERT_UNI_DEFEATED%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_FIRSTGREETING%", "TXT_KEY_UD_VS_VERT_UNI_FIRSTGREETING%")

		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_DEFEATED%", "TXT_KEY_UD_VS_VERT_UNI_DEFEATED%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_FIRSTGREETING%", "TXT_KEY_UD_VS_VERT_UNI_FIRSTGREETING%")
	elseif tBlancCivs[sCivilizationType] then
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_DEFEATED%", "TXT_KEY_UD_VS_BLANC_UNI_DEFEATED%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_FIRSTGREETING%", "TXT_KEY_UD_VS_BLANC_UNI_FIRSTGREETING%")

		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_DEFEATED%", "TXT_KEY_UD_VS_BLANC_UNI_DEFEATED%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_FIRSTGREETING%", "TXT_KEY_UD_VS_BLANC_UNI_FIRSTGREETING%")
	elseif sCivilizationType == sSayaka then
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_FIRSTGREETING%", "TXT_KEY_UD_VS_SAYAKA_UNI_FIRSTGREETING%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_UNI_GREETING_POLITE_HELLO%", "TXT_KEY_UD_VS_SAYAKA_UNI_GREETING_POLITE%")

		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_FIRSTGREETING%", "TXT_KEY_UD_VS_SAYAKA_UNI_FIRSTGREETING%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_BLACK_SISTER_GREETING_POLITE_HELLO%", "TXT_KEY_UD_VS_SAYAKA_UNI_GREETING_POLITE%")
	end
	
end


--If Noire is in the game, Uni's Civ description and capital are changed to differentiate.
function UpdateUniCivDescriptions()
	local bIsNoire;
	local iUniPlayer;  --note: only one copy of Uni will get renamed to mk2 if there are multiples
	for i = 0, iMaxCivs - 1, 1 do
		local pPlayer = Players[i]
		if pPlayer:IsEverAlive() then
			local sCivilizationType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			if tNeptuneCivs[sCivilizationType] then
				bIsNoire = true
			elseif tUnis[i] then
				iUniPlayer = i
			end
		end
	end
	if bIsNoire and iUniPlayer then
		local pUni = Players[iUniPlayer]
		if pUni:GetCivilizationShortDescription() == Locale.ConvertTextKey("TXT_KEY_CIV_VV_LASTATION_UN_SHORT_DESC") then
			PreGame.SetCivilizationShortDescription(iUniPlayer, "TXT_KEY_CIV_VV_LASTATION_UN_SHORT_DESC_ALT")
		end
		if pUni:GetCivilizationDescription() == Locale.ConvertTextKey("TXT_KEY_CIV_VV_LASTATION_UN_DESC") then
			PreGame.SetCivilizationDescription(iUniPlayer, "TXT_KEY_CIV_VV_LASTATION_UN_DESC_ALT")
		end
		if pUni:GetCivilizationAdjective() == Locale.ConvertTextKey("TXT_KEY_CIV_VV_LASTATION_UN_ADJECTIVE") then
			PreGame.SetCivilizationAdjective(iUniPlayer, "TXT_KEY_CIV_VV_LASTATION_UN_ADJECTIVE_ALT")
		end

		ChangeDiplomacyGameText("TXT_KEY_CIV_VV_LASTATION_UN_DESC", "TXT_KEY_CIV_VV_LASTATION_UN_DESC_ALT")
		ChangeDiplomacyGameText("TXT_KEY_CIV_VV_LASTATION_UN_SHORT_DESC", "TXT_KEY_CIV_VV_LASTATION_UN_SHORT_DESC_ALT")
		ChangeDiplomacyGameText("TXT_KEY_CIV_VV_LASTATION_UN_ADJECTIVE", "TXT_KEY_CIV_VV_LASTATION_UN_ADJECTIVE_ALT")
		ChangeDiplomacyGameText("TXT_KEY_CITY_NAME_VV_HDNCAPITAL_LASTATION_UN", "TXT_KEY_CITY_NAME_VV_HDNCAPITAL_LASTATION_UN_ALT")
		Locale.SetCurrentLanguage(Locale.GetCurrentLanguage().Type)
	end
end


function OnLoadScreenCloseUniText()
	UniCharacterSpecificDialogText()
	-- if not HDNMod.UniTextInit then
		UpdateUniCivDescriptions()
		-- HDNMod.UniTextInit = true
	-- end
end

Events.LoadScreenClose.Add(OnLoadScreenCloseUniText)


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
			print(targetText .. " changed to " .. newText .. " in " .. locale .. "!");
		else
			print(newText .. " doesn't exist in " .. locale .. ". No changes made.");
		end
	else
		print(targetText .. " doesn't exist in " .. locale .. ". No changes made.");
	end
end