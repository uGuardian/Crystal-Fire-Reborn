-- NepgearPurpleSisterTraitScript
-- Author: Vice
-- DateCreated: 4/2/2015 4:27:31 PM
--------------------------------------------------------------

print("Nepgear obtained the ''Trait Script Loaded'' Affinity!")

HDNMod.NepgearCitiesTurn = HDNMod.NepgearCitiesTurn or {}
local PRODUCTION_SPEED_MOD = GameInfo.GameSpeeds[PreGame.GetGameSpeed()].ConstructPercent / 100
local GROWTH_SPEED_MOD = GameInfo.GameSpeeds[PreGame.GetGameSpeed()].GrowthPercent / 100
local iMaxCivs = GameDefines.MAX_MAJOR_CIVS
local bWFTW = GameInfoTypes.UNIT_PMMM_MAGICAL_GIRL and true or false;
local iMagicalGirlClass = GameInfoTypes.UNITCLASS_PMMM_MAGICAL_GIRL

--UA Constants
local HDD_SHARE_THRESHOLD = GameDefines.VV_HDN_HDD_SHARE_THRESHOLD
local NEPGEAR_TECH_EXPO_INFLUENCE = 3;
local NEPGEAR_TECH_EXPO_SCIENCE_MODIFIER = math.ceil(3 * PRODUCTION_SPEED_MOD);
local NEPGEAR_TECH_EXPO_CULTURE_MODIFIER = math.ceil(3 * PRODUCTION_SPEED_MOD);
local NEPGEAR_TECH_EXPO_COOLDOWN = math.ceil(10 * PRODUCTION_SPEED_MOD);
local PURPLE_SISTER_SHARICITE_SHARE_COST_STRENGTH_MOD = math.ceil(10 * PRODUCTION_SPEED_MOD); -- 1% shares is 100 shares internally
local PURPLE_SISTER_SHARICITE_UPGRADE_MOD = 0.33
local PURPLE_SISTER_DUMMY_BUILDING = GameInfoTypes.BUILDING_VV_PLANEPTUNE_NG_DUMMY_BUILDING_PURPLE_SISTER_2
local HARDWARE_STORE_SCIENTIST_POINT_MODIFIER = 1  --since this uses ChangeSpecialistGreatPersonProgressTimes100, divide this value by 100 for how much it will actually add
local HARDWARE_STORE = GameInfoTypes.BUILDING_VV_HARDWARE_STORE
local TECH_EXPO_GROUNDS = GameInfoTypes.FEATURE_VV_TECH_EXPO
local TECH_EXPO = GameInfoTypes.BUILD_VV_TECH_EXPO

local tShariciteUnits = {}
	
for row in GameInfo.Units() do
	if string.find(row.Type, "_SHARICITE") then
		local iCombat = row.Combat
		if (not iCombat) or (iCombat <= 0) then
			iCombat = row.RangedCombat
		end
		--the Value of the Key in the table is the Shares cost of the Unit
		tShariciteUnits[row.ID] = math.ceil(iCombat * PURPLE_SISTER_SHARICITE_SHARE_COST_STRENGTH_MOD)
	end
end


--Civ Identifiers
local iNepgear = GameInfoTypes.LEADER_VV_NEPGEAR or -1
local iPurpleSister = GameInfoTypes.LEADER_VV_PURPLE_SISTER or -1
local iNepgearCiv = GameInfoTypes.CIVILIZATION_VV_PLANEPTUNE_NG or -1
local iPurpleSisterCiv = GameInfoTypes.CIVILIZATION_VV_PLANEPTUNE_PS or -1
local tNepgears = {}
for i = 0, iMaxCivs - 1, 1 do
	local pPlayer = Players[i]
	if pPlayer:IsEverAlive() then
		local iLeaderType = pPlayer:GetLeaderType()
		if (iLeaderType == iNepgear or iLeaderType == iPurpleSister) then
			tNepgears[i] = true
		end
	end
end


--Taken from sukritact's Events & Decisions
function CompileCityID(pCity)
	local iOriginalOwner = pCity:GetOriginalOwner()
	local iTurnFounded = pCity:GetGameTurnFounded ()	--Used to Compile Unique City ID
	local iCityID = ("X" .. pCity:GetX() .. "Y" .. pCity:GetY() .. "P" .. iOriginalOwner .. "T" .. iTurnFounded)
	return iCityID
end

--With a given plot, see if it should be given the Tech Expo feature.
function UpdateCityPlotTechExpoFeature(pPlot)
	local iSet = -1
	if tNepgears[pPlot:GetOwner()] then
		local pCity = pPlot:GetPlotCity()
		if pCity and not pCity:IsRazing() and not pCity:IsResistance() then
			local iTurn = HDNMod.NepgearCitiesTurn[CompileCityID(pCity)]
			if (not iTurn) or (Game:GetGameTurn() - iTurn >= NEPGEAR_TECH_EXPO_COOLDOWN) then
				iSet = TECH_EXPO_GROUNDS
				if pCity:GetOwner() == Game:GetActivePlayer() and pPlot:GetFeatureType() ~= TECH_EXPO_GROUNDS then
					Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_ALERT_HDN_NEPGEAR_READY_FOR_TECH_EXPO", pCity:GetName()))
				end
			end
		end
	end
	pPlot:SetFeatureType(iSet)
end


--When city ownership changes, we need to make sure that Tech Expo Grounds are removed or added accordingly.
function OnCityCaptureCompletePurpleSister(iOldOwner, bCapital, iX, iY, iNewOwner, iPop, bConquest)
	local pPlot = Map.GetPlot(iX, iY)
	if pPlot then
		local pCity = pPlot:GetPlotCity()
		if pCity then
			UpdateCityPlotTechExpoFeature(pPlot)
		end
	end
end

GameEvents.CityCaptureComplete.Add(OnCityCaptureCompletePurpleSister)


--Tech Expos in newly founded Nepgear Cities
function OnPlayerCityFoundedNepgearTechExpo(iPlayer, iX, iY)
	if tNepgears[iPlayer] then
		local pPlot = Map.GetPlot(iX, iY)
		pPlot:SetFeatureType(TECH_EXPO_GROUNDS)
	end
end

GameEvents.PlayerCityFounded.Add(OnPlayerCityFoundedNepgearTechExpo)


function RunTechExpo(pPlayer, pCity, iStrength)
	local pTeam = Teams[pPlayer:GetTeam()]
	local iCulture = math.floor(iStrength * NEPGEAR_TECH_EXPO_CULTURE_MODIFIER)
	pPlayer:ChangeJONSCulture(iCulture)
	
	local iScience = math.floor(iStrength * NEPGEAR_TECH_EXPO_SCIENCE_MODIFIER)
	local iResearchTech = pPlayer:GetCurrentResearch()
	if iResearchTech and iResearchTech > -1 then
		local pTeamTechs = pTeam:GetTeamTechs()
		pTeamTechs:ChangeResearchProgress(iResearchTech, iScience, iPlayer)
	end
	
	
	for i = iMaxCivs, GameDefines.MAX_CIV_PLAYERS - 1, 1 do
		local pCS = Players[i]
		if pCS:IsAlive() and pTeam:IsHasMet(i) then
			pCS:ChangeMinorCivFriendshipWithMajor(iPlayer, NEPGEAR_TECH_EXPO_INFLUENCE)
		end
	end
	
	if pPlayer:GetID() == Game:GetActivePlayer() then
		Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_ALERT_HDN_NEPGEAR_TECH_EXPO", iScience, iCulture, NEPGEAR_TECH_EXPO_INFLUENCE))
	end
	
	HDNMod.NepgearCitiesTurn[CompileCityID(pCity)] = Game:GetGameTurn()
end


--Upon the construction of the Build to remove a Tech Expo, do this.
--Since BuildFinished will return -1 here, we will determine that it was a Tech Expo by it being on a tile with a City,
--the presence of an Armor or Naval Unit, and, of course, the player being Nepgear.
function OnBuildFinishedNepgearTechExpo(iPlayer, iX, iY, iImprovement)
	print(iPlayer, iX, iY, iImprovement)
	if tNepgears[iPlayer] and iImprovement == -1 then
		local pPlayer = Players[iPlayer]
		local pPlot = Map.GetPlot(iX, iY)
		local pCity = pPlot:GetPlotCity()
		if pCity then
			local sCityID = CompileCityID(pCity)
			if pCity and (not HDNMod.NepgearCitiesTurn[sCityID] or Game:GetGameTurn() - NEPGEAR_TECH_EXPO_COOLDOWN >= HDNMod.NepgearCitiesTurn[sCityID])  then
				for c = 0, pPlot:GetNumUnits() - 1, 1 do
					local pUnit = pPlot:GetUnit(c)
					if pUnit and pUnit:GetUnitCombatType() == GameInfoTypes.UNITCOMBAT_ARMOR then
						local iStrength = pUnit:GetBaseCombatStrength()
						if iStrength then
							RunTechExpo(pPlayer, pCity, iStrength)
							break
						end
					end
				end
			end
		end
	end
end

GameEvents.BuildFinished.Add(OnBuildFinishedNepgearTechExpo)


--When a City finishes building a Unit or Building with Production, if it has a Hardware Store, grant it some Great Scientist points.
function HardwareStoreGSPoints(pCity, iProduction)
	local iChange = iProduction * HARDWARE_STORE_SCIENTIST_POINT_MODIFIER
	pCity:ChangeSpecialistGreatPersonProgressTimes100(GameInfoTypes.SPECIALIST_SCIENTIST, iChange)
end

function OnCityConstructedHardwareStore(iPlayer, iCity, iBuildingType, bGold, bFaithOrCulture)
	print(iPlayer, iCity, iBuildingType, bGold, bFaithOrCulture)
	if not bGold and not bFaithOrCulture then
		local pPlayer = Players[iPlayer]
		local pCity = pPlayer:GetCityByID(iCity)
		if pCity:IsHasBuilding(HARDWARE_STORE) then
			local iProduction = pPlayer:GetBuildingProductionNeeded(iBuildingType)
			if iProduction > 0 then
				HardwareStoreGSPoints(pCity, iProduction)
			end
		end
	end
end
GameEvents.CityConstructed.Add(OnCityConstructedHardwareStore)

--This function will handle both the Hardware Store and Sharicite Units
function OnCityTrained(iPlayer, iCity, iUnitID, bGold, bFaithOrCulture)
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnitID)
	local iUnitType = pUnit:GetUnitType()
	if not bGold and not bFaithOrCulture then
		local pCity = pPlayer:GetCityByID(iCity)
		if pCity:IsHasBuilding(HARDWARE_STORE) then
			local iProduction = pPlayer:GetUnitProductionNeeded(iUnitType)
			if iProduction > 0 then
				HardwareStoreGSPoints(pCity, iProduction)
			end
		end
	end
	if tShariciteUnits[iUnitType] then
		local pPlayer = Players[iPlayer]
		ChangeShares(iPlayer, -tShariciteUnits[iUnitType])
		if iPlayer == Game:GetActivePlayer() then
			local iPercent = tShariciteUnits[iUnitType] / (100 * PRODUCTION_SPEED_MOD)
			local sPercent = string.format("%.2f%%", iPercent)
			local sUnitType = Locale.ConvertTextKey(GameInfo.Units[iUnitType].Description)
			Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_ALERT_HDN_NEPGEAR_SHARICITE_UNIT_BUILT", sUnitType, sPercent))
		end
		local iTotalSharesNeededForCurrentProduction = 0
		for pCity in pPlayer:Cities() do
			if pCity:GetID() ~= iCity then
				local iProducingUnit = pCity:GetProductionUnit()
				if iProducingUnit and tShariciteUnits[iProducingUnit] then
					iTotalSharesNeededForCurrentProduction = iTotalSharesNeededForCurrentProduction + tShariciteUnits[iProducingUnit]
					if HDNMod.Shares[iPlayer] < iTotalSharesNeededForCurrentProduction then
						Game.CityPushOrder(pCity, OrderTypes.OrderTypes.ORDER_TRAIN, -1, false, not g_append, true);
					end
				end
			end
		end
		if HDNMod.Shares[iPlayer] < HDD_SHARE_THRESHOLD then
			ConvertHDNLeader(pPlayer, false)
			SendHDDNotifications(pPlayer, 2)
		end
	end
end
GameEvents.CityTrained.Add(OnCityTrained)



--Handle the ability to construct Sharicite units.
function OnCityCanTrain(iPlayer, iCity, iUnitType)
	if tShariciteUnits[iUnitType] then
		if tNepgears[iPlayer] then
			local pPlayer = Players[iPlayer]
			if IsPlayerHDDMode(pPlayer) == false then return false end
			local iTotalSharesNeededForCurrentProduction = 0
			for pCity in pPlayer:Cities() do
				if pCity:GetID() ~= iCity then
					local iProducingUnit = pCity:GetProductionUnit()
					if iProducingUnit and tShariciteUnits[iProducingUnit] then
						iTotalSharesNeededForCurrentProduction = iTotalSharesNeededForCurrentProduction + tShariciteUnits[iProducingUnit]
					end
				end
			end
			if HDNMod.Shares[iPlayer] < iTotalSharesNeededForCurrentProduction + tShariciteUnits[iUnitType] then
				return false
			else
				return true
			end
		end
		return false
	end
	return true
end

GameEvents.CityCanTrain.Add(OnCityCanTrain)

--Handle the ability to upgrade Sharicite units.
function OnCanHaveUpgrade(iPlayer, iUnitID, iUpgradeUnitClass, iUpgradeUnitType)
	if tShariciteUnits[iUpgradeUnitType] then
		if tNepgears[iPlayer] then
			local pPlayer = Players[iPlayer]
			if IsPlayerHDDMode(pPlayer) == true then
				if HDNMod.Shares[iPlayer] >= math.ceil(tShariciteUnits[iUpgradeUnitType] * PURPLE_SISTER_SHARICITE_UPGRADE_MOD) then
					return true
				end
			end
		end
		return false
	end
	return true
end

GameEvents.CanHaveUpgrade.Add(OnCanHaveUpgrade)


--Consume Shares upon upgrading a Sharicite unit
function OnUnitUpgraded(iPlayer, iOldUnitID, iNewUnitID, bGoodyHut)
	if tNepgears[iPlayer] and not bGoodyHut then
		local pPlayer = Players[iPlayer]
		local pNewUnit = pPlayer:GetUnitByID(iNewUnitID)
		local iUnitType = pNewUnit:GetUnitType()
		if tShariciteUnits[iUnitType] then
			ChangeShares(iPlayer, -math.ceil(tShariciteUnits[iUnitType] * PURPLE_SISTER_SHARICITE_UPGRADE_MOD))
		end
	end
end

GameEvents.UnitUpgraded.Add(OnUnitUpgraded)


function OnPlayerDoTurn(iPlayer)
	if tNepgears[iPlayer] then
		local pPlayer = Players[iPlayer]
		local iLeaderType = pPlayer:GetLeaderType()
		if iLeaderType == iNepgear then
			--Update Tech Expos in Cities
			for pCity in pPlayer:Cities() do
				UpdateCityPlotTechExpoFeature(pCity:Plot())
				pCity:SetNumRealBuilding(PURPLE_SISTER_DUMMY_BUILDING, 0)
			end
			--AI Logic for doing Tech Expos
			--For simplicity and speed's sake, AI Nepgear will be able to teleport Armor units within 2 tiles in to do her Tech Expos.
			if not pPlayer:IsHuman() then
				--Don't do Tech Expos at war, and don't do them if we are militarily behind!
				local pTeam = Teams[pPlayer:GetTeam()]
				local iAverageWorldStrength = 0
				local iNumCivsAlive = 1
				for i = 0, iMaxCivs - 1, 1 do
					if i ~= iPlayer then
						local pLoop = Players[i]
						if pLoop:IsAlive() and pTeam:IsAtWar(pLoop:GetTeam()) then
							return
						end
						iAverageWorldStrength = iAverageWorldStrength + pLoop:GetMilitaryMight()
						iNumCivsAlive = iNumCivsAlive + 1
					end
				end
				iAverageWorldStrength = iAverageWorldStrength / iNumCivsAlive
				if iAverageWorldStrength > pPlayer:GetMilitaryMight() then return end
				for pCity in pPlayer:Cities() do
					if pCity:Plot():GetFeatureType() == TECH_EXPO_GROUNDS then
						for pAreaPlot in PlotAreaSpiralIterator(pCity:Plot(), 2, false, false, false, true) do
							for c = 1, pAreaPlot:GetNumUnits() - 1, 1 do
								local pUnit = pAreaPlot:GetUnit(c)
								if pUnit and pUnit:GetUnitCombatType() == GameInfoTypes.UNITCOMBAT_ARMOR and pUnit:GetUnitType() ~= GameInfoTypes.UNIT_VV_GEARNAUGHT_SPECIAL then
									local iStrength = pUnit:GetBaseCombatStrength()
									if iStrength then
										RunTechExpo(pPlayer, pCity, iStrength)
										UpdateCityPlotTechExpoFeature(pCity:Plot())
										pUnit:Kill(true)
									end
								end
							end
						end
					end
				end
			end
		else
			for pCity in pPlayer:Cities() do
				pCity:SetNumRealBuilding(PURPLE_SISTER_DUMMY_BUILDING, 1, true)
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(OnPlayerDoTurn)

function OnTransformed(iPlayer, bHDDOn)
	if tNepgears[iPlayer] then
		local pPlayer = Players[iPlayer]
		local iLeaderType = pPlayer:GetLeaderType()
		if iLeaderType == iPurpleSister then
			for pCity in pPlayer:Cities() do
				pCity:Plot():SetFeatureType(-1)
			end
		elseif iLeaderType == iNepgear then
			local iThisTurn = Game:GetGameTurn()
			for pCity in pPlayer:Cities() do
				UpdateCityPlotTechExpoFeature(pCity:Plot())
			end
		end
	end
end
LuaEvents.VV_ConvertHDNLeader.Add(OnTransformed)

function NepgearTransformationAILogic(iPlayer)
	local bShouldTransform = false
	if HDNMod.Shares[iPlayer] >= HDD_SHARE_THRESHOLD * 1.5 then
		local pPlayer = Players[iPlayer]
		local pTeam = Teams[pPlayer:GetTeam()]
		local iOurMight = pPlayer:GetMilitaryMight()
		local iAverageMightOthers = 0
		local iNumMetCivsAlive = 0
		for i = 0, iMaxCivs - 1, 1 do
			if i ~= iPlayer then
				local pLoop = Players[i]
				if pLoop:IsAlive() and pTeam:IsHasMet(pLoop:GetTeam()) then
					iAverageMightOthers = iAverageMightOthers + pLoop:GetMilitaryMight()
					iNumMetCivsAlive = iNumMetCivsAlive + 1
				end
			end
		end
		iAverageMightOthers = math.floor(iAverageMightOthers / iNumMetCivsAlive)
		if iOurMight < iAverageMightOthers then
			bShouldTransform = true
		end
	end
	return bShouldTransform
end

function PurpleSisterTransformationAILogic(iPlayer)
	local bShouldRevert = false
	local pPlayer = Players[iPlayer]
	local pTeam = Teams[pPlayer:GetTeam()]
	local iOurMight = pPlayer:GetMilitaryMight()
	local iAverageMightOthers = 0
	local iNumMetCivsAlive = 0
	for i = 0, iMaxCivs - 1, 1 do
		if i ~= iPlayer then
			local pLoop = Players[i]
			if pLoop:IsAlive() and pTeam:IsHasMet(pLoop:GetTeam()) then
				iAverageMightOthers = iAverageMightOthers + pLoop:GetMilitaryMight()
				iNumMetCivsAlive = iNumMetCivsAlive + 1
			end
		end
	end
	iAverageMightOthers = math.floor(iAverageMightOthers / iNumMetCivsAlive)
	if iOurMight > math.ceil(iAverageMightOthers * 1.2) then
		bShouldRevert = true
	end
	return bShouldRevert
end
LuaEvents.VV_AddToTransformLogicTable(iNepgear, NepgearTransformationAILogic)
LuaEvents.VV_AddToTransformLogicTable(iPurpleSister, PurpleSisterTransformationAILogic)


local tDenounceResponses = {}

function RefreshDenounceResponses()
	local locale = "Language_" ..Locale.GetCurrentLanguage().Type;
	for row in DB.Query("SELECT Text FROM " ..locale .." WHERE Tag LIKE '%_RESPONSE_TO_BEING_DENOUNCED_%' OR Tag LIKE '%_RESPONSE_TO_DENOUNCEMENT_%'") do
		tDenounceResponses[row.Text] = true
	end
end
RefreshDenounceResponses()



--Special Leaderscene logic just for Nepgear:
--If the player denounces her, a certain special face comes up.
function NepgearSpecialLeaderscene( iPlayer, iDiploUIState, szLeaderMessage, iAnimationAction, iData1 )
	local pPlayer = Players[iPlayer]
	if pPlayer:GetLeaderType() == iNepgear then
		if tDenounceResponses[szLeaderMessage] then
			return "VVNepgearLeaderSceneDynamicNepgyaah.dds"
		end
	end

	return nil
end
Events.LoadScreenClose.Add(function () LuaEvents.AddFunctionToLeaderSceneTable(NepgearSpecialLeaderscene) end)



--Unique Dialog Text for specific leaders.
--The leaders with unique text are:
--Neptune, Vert, Blanc, Noire (for obvious reasons)
--Demon Homura (reference to Conquest ending)
--Sayaka Miki (voice actress reference to Uni)
--Any Sega IP civilizations. The list currently includes:
---Eggman Empire by Dr. Costa
---Gallia (Valkyria Chronicles) by Majur Tum
---Sol Kingdom by Sotaku93

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

local tBlancCivs = {
	["CIVILIZATION_LOWEE"] = true,
	["CIVILIZATION_VV_LOWEE"] = true,
	["CIVILIZATION_VV_LOWEE_WH"] = true,
	["CIVILIZATION_VV_LOWEE_ULTRA"] = true,
	["CIVILIZATION_VV_LOWEE_WH_ULTRA"] = true
}

local sDemonHomura = "CIVILIZATION_DEMON_HOMURA"
local sSayaka = "CIVILIZATON_SAYAKA"

local tSegaCivs = {
	["CIVILIZATION_EGGMANEMPIRE"] = true,
	["CIVILIZATION_PARAMOBIUS"] = true,
	["CIVILIZATION_GALLIA"] = true,  --this is pretty likely to conflict with a historical Gallia mod, but whatever
}

--Thanks to Typhlomence for this and the ChangeDiplomacyReference/ChangeDiplomacyText function!
function NepgearCharacterSpecificDialogText()
	local locale = "Language_" ..Locale.GetCurrentLanguage().Type;
	local pActivePlayer = Players[Game:GetActivePlayer()]
	local sCivilizationType = GameInfo.Civilizations[pActivePlayer:GetCivilizationType()].Type

	
	if tNeptuneCivs[sCivilizationType] then
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_DEFEATED%", "TXT_KEY_UD_VS_NEPTUNE_NEPGEAR_DEFEATED%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_FIRSTGREETING%", "TXT_KEY_UD_VS_NEPTUNE_NEPGEAR_FIRSTGREETING%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_GREETING_POLITE_HELLO%", "TXT_KEY_UD_VS_NEPTUNE_NEPGEAR_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_GREETING_NEUTRAL_HELLO%", "TXT_KEY_UD_VS_NEPTUNE_NEPGEAR_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_GREETING_HOSTILE_HELLO%", "TXT_KEY_UD_VS_NEPTUNE_NEPGEAR_GREETING_HOSTILE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_ATTACKED_HOSTILE%", "TXT_KEY_UD_VS_NEPTUNE_NEPGEAR_WAR_DECLARED_ON%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_ATTACKED_WEAK_HOSTILE%", "TXT_KEY_UD_VS_NEPTUNE_NEPGEAR_WAR_DECLARED_ON%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_ATTACKED_STRONG_HOSTILE%", "TXT_KEY_UD_VS_NEPTUNE_NEPGEAR_WAR_DECLARED_ON%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_ATTACKED_EXCITED%", "TXT_KEY_UD_VS_NEPTUNE_NEPGEAR_WAR_DECLARED_ON%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_ATTACKED_WEAK_EXCITED%", "TXT_KEY_UD_VS_NEPTUNE_NEPGEAR_WAR_DECLARED_ON%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_ATTACKED_STRONG_EXCITED%", "TXT_KEY_UD_VS_NEPTUNE_NEPGEAR_WAR_DECLARED_ON%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_DOW_LAND%", "TXT_KEY_UD_VS_NEPTUNE_NEPGEAR_DECLARES_WAR%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_DOW_GENERIC%", "TXT_KEY_UD_VS_NEPTUNE_NEPGEAR_DECLARES_WAR%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_DOW_WORLD_CONQUEST%", "TXT_KEY_UD_VS_NEPTUNE_NEPGEAR_DECLARES_WAR%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_DOW_BETRAYAL%", "TXT_KEY_UD_VS_NEPTUNE_NEPGEAR_DECLARES_WAR%")	
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_DOW_OPPORTUNITY%", "TXT_KEY_UD_VS_NEPTUNE_NEPGEAR_DECLARES_WAR%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_LETS_HEAR_IT%", "TXT_KEY_UD_VS_NEPTUNE_NEPGEAR_LETS_HEAR_IT%")	
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_RESPONSE_TO_BEING_DENOUNCED%", "TXT_KEY_UD_VS_NEPTUNE_NEPGEAR_RESPONSE_TO_DENOUNCEMENT%")	
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_DENOUNCE%", "TXT_KEY_UD_VS_NEPTUNE_NEPGEAR_DENOUNCE%")	
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_EMBASSY_EXCHANGE%", "TXT_KEY_UD_VS_NEPTUNE_NEPGEAR_EMBASSY_OFFER%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_EMBASSY_OFFER%", "TXT_KEY_UD_VS_NEPTUNE_NEPGEAR_EMBASSY_OFFER%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_OPEN_BORDERS_EXCHANGE%", "TXT_KEY_UD_VS_NEPTUNE_NEPGEAR_OPEN_BORDERS%")	
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_OPEN_BORDERS_OFFER%", "TXT_KEY_UD_VS_NEPTUNE_NEPGEAR_OPEN_BORDERS%")	
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_DEC_FRIENDSHIP%", "TXT_KEY_UD_VS_NEPTUNE_NEPGEAR_FRIENDSHIP%")
	elseif tNoireCivs[sCivilizationType] then
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_DEFEATED%", "TXT_KEY_UD_VS_NOIRE_NEPGEAR_DEFEATED%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_FIRSTGREETING%", "TXT_KEY_UD_VS_NOIRE_NEPGEAR_FIRSTGREETING%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_GREETING_POLITE_HELLO%", "TXT_KEY_UD_VS_NOIRE_NEPGEAR_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_GREETING_NEUTRAL_HELLO%", "TXT_KEY_UD_VS_NOIRE_NEPGEAR_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_GREETING_HOSTILE_HELLO%", "TXT_KEY_UD_VS_NOIRE_NEPGEAR_GREETING_HOSTILE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_ATTACKED_HOSTILE%", "TXT_KEY_UD_VS_NOIRE_NEPGEAR_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_ATTACKED_WEAK_HOSTILE%", "TXT_KEY_UD_VS_NOIRE_NEPGEAR_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_ATTACKED_STRONG_HOSTILE%", "TXT_KEY_UD_VS_NOIRE_NEPGEAR_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_ATTACKED_EXCITED%", "TXT_KEY_UD_VS_NOIRE_NEPGEAR_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_ATTACKED_WEAK_EXCITED%", "TXT_KEY_UD_VS_NOIRE_NEPGEAR_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_ATTACKED_STRONG_EXCITED%", "TXT_KEY_UD_VS_NOIRE_NEPGEAR_WAR_DECLARATION%")
	elseif tUniCivs[sCivilizationType] then
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_DEFEATED%", "TXT_KEY_UD_VS_UNI_NEPGEAR_DEFEATED%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_FIRSTGREETING%", "TXT_KEY_UD_VS_UNI_NEPGEAR_FIRSTGREETING%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_GREETING_POLITE_HELLO%", "TXT_KEY_UD_VS_UNI_NEPGEAR_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_GREETING_NEUTRAL_HELLO%", "TXT_KEY_UD_VS_UNI_NEPGEAR_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_GREETING_HOSTILE_HELLO%", "TXT_KEY_UD_VS_UNI_NEPGEAR_GREETING_HOSTILE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_ATTACKED_HOSTILE%", "TXT_KEY_UD_VS_UNI_NEPGEAR_WAR_DECLARED_ON%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_ATTACKED_WEAK_HOSTILE%", "TXT_KEY_UD_VS_UNI_NEPGEAR_WAR_DECLARED_ON%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_ATTACKED_STRONG_HOSTILE%", "TXT_KEY_UD_VS_UNI_NEPGEAR_WAR_DECLARED_ON%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_ATTACKED_EXCITED%", "TXT_KEY_UD_VS_UNI_NEPGEAR_WAR_DECLARED_ON%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_ATTACKED_WEAK_EXCITED%", "TXT_KEY_UD_VS_UNI_NEPGEAR_WAR_DECLARED_ON%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_ATTACKED_STRONG_EXCITED%", "TXT_KEY_UD_VS_UNI_NEPGEAR_WAR_DECLARED_ON%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_DOW_LAND%", "TXT_KEY_UD_VS_UNI_NEPGEAR_DECLARES_WAR%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_DOW_GENERIC%", "TXT_KEY_UD_VS_UNI_NEPGEAR_DECLARES_WAR%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_DOW_WORLD_CONQUEST%", "TXT_KEY_UD_VS_UNI_NEPGEAR_DECLARES_WAR%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_DOW_BETRAYAL%", "TXT_KEY_UD_VS_UNI_NEPGEAR_DECLARES_WAR%")	
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_DOW_OPPORTUNITY%", "TXT_KEY_UD_VS_UNI_NEPGEAR_DECLARES_WAR%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_LETS_HEAR_IT%", "TXT_KEY_UD_VS_UNI_NEPGEAR_LETS_HEAR_IT%")	
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_RESPONSE_TO_BEING_DENOUNCED%", "TXT_KEY_UD_VS_UNI_NEPGEAR_RESPONSE_TO_DENOUNCEMENT%")	
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_DENOUNCE%", "TXT_KEY_UD_VS_UNI_NEPGEAR_DENOUNCE%")	
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_EMBASSY_EXCHANGE%", "TXT_KEY_UD_VS_UNI_NEPGEAR_EMBASSY_OFFER%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_EMBASSY_OFFER%", "TXT_KEY_UD_VS_UNI_NEPGEAR_EMBASSY_OFFER%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_OPEN_BORDERS_EXCHANGE%", "TXT_KEY_UD_VS_UNI_NEPGEAR_OPEN_BORDERS%")	
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_OPEN_BORDERS_OFFER%", "TXT_KEY_UD_VS_UNI_NEPGEAR_OPEN_BORDERS%")	
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_DEC_FRIENDSHIP%", "TXT_KEY_UD_VS_UNI_NEPGEAR_FRIENDSHIP%")
	elseif tVertCivs[sCivilizationType] then
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_DEFEATED%", "TXT_KEY_UD_VS_VERT_NEPGEAR_DEFEATED%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_FIRSTGREETING%", "TXT_KEY_UD_VS_VERT_NEPGEAR_FIRSTGREETING%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_GREETING_POLITE_HELLO%", "TXT_KEY_UD_VS_VERT_NEPGEAR_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_GREETING_NEUTRAL_HELLO%", "TXT_KEY_UD_VS_VERT_NEPGEAR_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_GREETING_HOSTILE_HELLO%", "TXT_KEY_UD_VS_VERT_NEPGEAR_GREETING_HOSTILE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_ATTACKED_HOSTILE%", "TXT_KEY_UD_VS_VERT_NEPGEAR_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_ATTACKED_WEAK_HOSTILE%", "TXT_KEY_UD_VS_VERT_NEPGEAR_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_ATTACKED_STRONG_HOSTILE%", "TXT_KEY_UD_VS_VERT_NEPGEAR_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_ATTACKED_EXCITED%", "TXT_KEY_UD_VS_VERT_NEPGEAR_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_ATTACKED_WEAK_EXCITED%", "TXT_KEY_UD_VS_VERT_NEPGEAR_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_ATTACKED_STRONG_EXCITED%", "TXT_KEY_UD_VS_VERT_NEPGEAR_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_DEC_FRIENDSHIP%", "TXT_KEY_UD_VS_VERT_NEPGEAR_FRIENDSHIP%")
	elseif tBlancCivs[sCivilizationType] then
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_DEFEATED%", "TXT_KEY_UD_VS_BLANC_NEPGEAR_DEFEATED%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_FIRSTGREETING%", "TXT_KEY_UD_VS_BLANC_NEPGEAR_FIRSTGREETING%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_GREETING_POLITE_HELLO%", "TXT_KEY_UD_VS_BLANC_NEPGEAR_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_GREETING_NEUTRAL_HELLO%", "TXT_KEY_UD_VS_BLANC_NEPGEAR_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_GREETING_HOSTILE_HELLO%", "TXT_KEY_UD_VS_BLANC_NEPGEAR_GREETING_HOSTILE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_ATTACKED_HOSTILE%", "TXT_KEY_UD_VS_BLANC_NEPGEAR_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_ATTACKED_WEAK_HOSTILE%", "TXT_KEY_UD_VS_BLANC_NEPGEAR_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_ATTACKED_STRONG_HOSTILE%", "TXT_KEY_UD_VS_BLANC_NEPGEAR_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_ATTACKED_EXCITED%", "TXT_KEY_UD_VS_BLANC_NEPGEAR_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_ATTACKED_WEAK_EXCITED%", "TXT_KEY_UD_VS_BLANC_NEPGEAR_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_ATTACKED_STRONG_EXCITED%", "TXT_KEY_UD_VS_BLANC_NEPGEAR_WAR_DECLARATION%")
	elseif tSegaCivs[sCivilizationType] then
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_DEFEATED%", "TXT_KEY_UD_VS_NINTENDO_NEPGEAR_DEFEATED%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_FIRSTGREETING%", "TXT_KEY_UD_VS_NINTENDO_NEPGEAR_FIRSTGREETING%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_GREETING_POLITE_HELLO%", "TXT_KEY_UD_VS_NINTENDO_NEPGEAR_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_GREETING_NEUTRAL_HELLO%", "TXT_KEY_UD_VS_NINTENDO_NEPGEAR_GREETING_POLITE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_GREETING_HOSTILE_HELLO%", "TXT_KEY_UD_VS_NINTENDO_NEPGEAR_GREETING_HOSTILE%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_ATTACKED_HOSTILE%", "TXT_KEY_UD_VS_NINTENDO_NEPGEAR_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_ATTACKED_WEAK_HOSTILE%", "TXT_KEY_UD_VS_NINTENDO_NEPGEAR_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_ATTACKED_STRONG_HOSTILE%", "TXT_KEY_UD_VS_NINTENDO_NEPGEAR_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_ATTACKED_EXCITED%", "TXT_KEY_UD_VS_NINTENDO_NEPGEAR_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_ATTACKED_WEAK_EXCITED%", "TXT_KEY_UD_VS_NINTENDO_NEPGEAR_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_ATTACKED_STRONG_EXCITED%", "TXT_KEY_UD_VS_NINTENDO_NEPGEAR_WAR_DECLARATION%")
	elseif sCivilizationType == sDemonHomura then
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_ATTACKED_HOSTILE%", "TXT_KEY_UD_VS_DEMON_HOMURA_NEPGEAR_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_ATTACKED_WEAK_HOSTILE%", "TXT_KEY_UD_VS_DEMON_HOMURA_NEPGEAR_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_ATTACKED_STRONG_HOSTILE%", "TXT_KEY_UD_VS_DEMON_HOMURA_NEPGEAR_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_ATTACKED_EXCITED%", "TXT_KEY_UD_VS_DEMON_HOMURA_NEPGEAR_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_ATTACKED_WEAK_EXCITED%", "TXT_KEY_UD_VS_DEMON_HOMURA_NEPGEAR_WAR_DECLARATION%")
		ChangeDiplomacyReference("TXT_KEY_LEADER_VV_NEPGEAR_ATTACKED_STRONG_EXCITED%", "TXT_KEY_UD_VS_DEMON_HOMURA_NEPGEAR_WAR_DECLARATION%")
	elseif sCivilizationType == sDemonHomura then

	end
	
end


--If Neptune is in the game, Nepgear's Civ description and capital are changed to differentiate.
function UpdateNepgearCivDescriptions()
	local bIsNeptune;
	local iNepgearPlayer;  --note: only one copy of Nepgear will get renamed to mk2 if there are multiples
	for i = 0, iMaxCivs - 1, 1 do
		local pPlayer = Players[i]
		if pPlayer:IsEverAlive() then
			local sCivilizationType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			if tNeptuneCivs[sCivilizationType] then
				bIsNeptune = true
			elseif tNepgears[i] then
				iNepgearPlayer = i
			end
		end
	end
	if bIsNeptune and iNepgearPlayer then
		local pNepgear = Players[iNepgearPlayer]
		if pNepgear:GetCivilizationShortDescription() == Locale.ConvertTextKey("TXT_KEY_CIV_VV_PLANEPTUNE_NG_SHORT_DESC") then
			PreGame.SetCivilizationShortDescription(iNepgearPlayer, "TXT_KEY_CIV_VV_PLANEPTUNE_NG_SHORT_DESC_ALT")
		end
		if pNepgear:GetCivilizationDescription() == Locale.ConvertTextKey("TXT_KEY_CIV_VV_PLANEPTUNE_NG_DESC") then
			PreGame.SetCivilizationDescription(iNepgearPlayer, "TXT_KEY_CIV_VV_PLANEPTUNE_NG_DESC_ALT")
		end
		if pNepgear:GetCivilizationAdjective() == Locale.ConvertTextKey("TXT_KEY_CIV_VV_PLANEPTUNE_NG_ADJECTIVE") then
			PreGame.SetCivilizationAdjective(iNepgearPlayer, "TXT_KEY_CIV_VV_PLANEPTUNE_NG_ADJECTIVE_ALT")
		end

		ChangeDiplomacyGameText("TXT_KEY_CIV_VV_PLANEPTUNE_NG_DESC", "TXT_KEY_CIV_VV_PLANEPTUNE_NG_DESC_ALT")
		ChangeDiplomacyGameText("TXT_KEY_CIV_VV_PLANEPTUNE_NG_SHORT_DESC", "TXT_KEY_CIV_VV_PLANEPTUNE_NG_SHORT_DESC_ALT")
		ChangeDiplomacyGameText("TXT_KEY_CIV_VV_PLANEPTUNE_NG_ADJECTIVE", "TXT_KEY_CIV_VV_PLANEPTUNE_NG_ADJECTIVE_ALT")
		ChangeDiplomacyGameText("TXT_KEY_CITY_NAME_VV_HDNCAPITAL_PLANEPTUNE_NG", "TXT_KEY_CITY_NAME_VV_HDNCAPITAL_PLANEPTUNE_NG_ALT")
		Locale.SetCurrentLanguage(Locale.GetCurrentLanguage().Type)
	end
end


function OnLoadScreenCloseNepgearText()
	-- if not HDNMod.NepgearTextInit then
		NepgearCharacterSpecificDialogText()
		UpdateNepgearCivDescriptions()
		-- HDNMod.NepgearTextInit = true
	-- end
end

Events.LoadScreenClose.Add(OnLoadScreenCloseNepgearText)



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