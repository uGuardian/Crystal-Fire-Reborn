-- JFD_CulDivFunctions
-- Author: JFD
-- DateCreated: 9/23/2014 11:58:14 AM
--==========================================================================================================================
-- Includes
--==========================================================================================================================
include("JFD_CulDivSettings")
include("JFD_CulDivUtilities")
include("NewSaveUtils.lua"); MY_MOD_NAME = "CulDivAddon";
include("PlotIterators")
--=======================================================================================================================
-- STARTING BONUSES FUNCTIONS	
--=======================================================================================================================
-- Globals
-------------------------------------------------------------------------------------------------------------------------
local civilisationArmeniaID = GameInfoTypes["CIVILIZATION_JFD_ARMENIA"]
local civilisationByzantiumID = GameInfoTypes["CIVILIZATION_BYZANTIUM"]
local civilisationPapalStatesID = GameInfoTypes["CIVILIZATION_JFD_PAPAL_STATES"]
local eraAncientID = GameInfoTypes["ERA_ANCIENT"]
local eraIndustrialID = GameInfoTypes["ERA_INDUSTRIAL"]
local eraMedievalID = GameInfoTypes["ERA_MEDIEVAL"]
local mathCeil = math.ceil
local policyBranchHonourID = GameInfoTypes["POLICY_BRANCH_HONOR"]
local policyBranchLibertyID = GameInfoTypes["POLICY_BRANCH_LIBERTY"]
local policyBranchPatronageID = GameInfoTypes["POLICY_BRANCH_PATRONAGE"]
local policyBranchPietyID = GameInfoTypes["POLICY_BRANCH_PIETY"]
local policyHonourID = GameInfoTypes["POLICY_HONOR"]
local policyLibertyID = GameInfoTypes["POLICY_LIBERTY"]
local policyPatronageID = GameInfoTypes["POLICY_PATRONAGE"]
local policyPietyID = GameInfoTypes["POLICY_PIETY"]
local resourceFursID = GameInfoTypes["RESOURCE_FUR"]
local resourceHorsesID = GameInfoTypes["RESOURCE_HORSE"]
local techAnimalHusbandryID = GameInfoTypes["TECH_ANIMAL_HUSBANDRY"]
local techArcheryID = GameInfoTypes["TECH_ARCHERY"]
local techMiningID = GameInfoTypes["TECH_MINING"]
local techPotteryID = GameInfoTypes["TECH_POTTERY"]
local techTrappingID = GameInfoTypes["TECH_TRAPPING"]
local unitAIAttackID = GameInfoTypes["UNITAI_ATTACK"]
local unitAICounterID = GameInfoTypes["UNITAI_COUNTER"]
local unitAIExploreID = GameInfoTypes["UNITAI_EXPLORE"]
local unitAIRangedID = GameInfoTypes["UNITAI_RANGED"]
local unitAIWorkerID = GameInfoTypes["UNITAI_WORKER"]
local unitPromotionEmbarkAllWaterID = GameInfoTypes["PROMOTION_ALLWATER_EMBARKATION"]
local unitPromotionExtraMoves2ID = GameInfoTypes["PROMOTION_JFD_EXTRA_MOVES_II"]
-------------------------------------------------------------------------------------------------------------------------
--JFD_CulturalEmbarkGraphics
-------------------------------------------------------------------------------------------------------------------------
local cultureEmbarkGraphics = {}
	cultureEmbarkGraphics["JFD_Andean"] 		= "ART_DEF_UNIT_JFD_MESO_RAFT"
	cultureEmbarkGraphics["JFD_Bantu"] 			= "ART_DEF_UNIT_JFD_DHOW"
	cultureEmbarkGraphics["JFD_Bharata"] 		= "ART_DEF_UNIT_JFD_DHOW"
	cultureEmbarkGraphics["JFD_Eastern"] 		= "ART_DEF_UNIT_U_DANISH_LONGBOAT"
	cultureEmbarkGraphics["JFD_Islamic"] 		= "ART_DEF_UNIT_JFD_DHOW"
	cultureEmbarkGraphics["JFD_Mesoamerican"]	= "ART_DEF_UNIT_JFD_MESO_RAFT"
	cultureEmbarkGraphics["JFD_Mandala"] 		= "ART_DEF_UNIT_JFD_WAR_JUNK"
	cultureEmbarkGraphics["JFD_Northern"] 		= "ART_DEF_UNIT_U_DANISH_LONGBOAT"
	cultureEmbarkGraphics["JFD_Oceanic"] 		= "ART_DEF_UNIT_U_POLYNESIAN_WAR_CANOE"
	cultureEmbarkGraphics["JFD_Oriental"] 		= "ART_DEF_UNIT_JFD_WAR_JUNK"
	cultureEmbarkGraphics["JFD_TribalAmerican"] = "ART_DEF_UNIT_U_POLYNESIAN_WAR_CANOE"
	cultureEmbarkGraphics["JFD_Steppe"] 		= "ART_DEF_UNIT_JFD_WAR_JUNK"
	cultureEmbarkGraphics["JFD_WestAfrican"] 	= "ART_DEF_UNIT_JFD_DHOW"
	
function JFD_CulturalEmbarkGraphics(player)
	for playerID = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
		local player = Players[playerID]
		local cultureGroup = JFD_GetCultureType(playerID)
		if (cultureGroup and player:GetCivilizationType() ~= civilisationByzantiumID and player:GetCivilizationType() ~= civilisationArmeniaID) then
			local cultureEmbarkGraphic = cultureEmbarkGraphics[cultureGroup]
			if cultureEmbarkGraphic then
				player:SetEmbarkedGraphicOverride(cultureEmbarkGraphic)
			end
		end
	end 
end
Events.LoadScreenClose.Add(JFD_CulturalEmbarkGraphics)

function JFD_OnModernEra(teamID, eraID)
	local playerID = Teams[teamID]:GetLeaderID()
	local player = Players[playerID]
	if (player:IsEverAlive() and not (player:IsMinorCiv()) and not (player:IsBarbarian())) then
		local cultureGroup = JFD_GetCultureType(playerID)
		if (eraID == eraMedievalID and (cultureGroup == "JFD_Eastern" or cultureGroup == "JFD_Northern")) then
			player:SetEmbarkedGraphicOverride("ART_DEF_UNIT_GALLEON")
		elseif (eraID == eraMedievalID and cultureGroup == "JFD_Mesopotamic") then
			player:SetEmbarkedGraphicOverride("ART_DEF_UNIT_JFD_DHOW")
		elseif eraID == eraIndustrialID then
			player:SetEmbarkedGraphicOverride("ART_DEF_UNIT_TRANSPORT")
		end
	end
end
GameEvents.TeamSetEra.Add(JFD_OnModernEra)
-------------------------------------------------------------------------------------------------------------------------
--JFD_CultureStartingBonuses
-------------------------------------------------------------------------------------------------------------------------
function JFD_CultureStartingBonuses()
	if (g_JFDStartingBonuses == 1 and not (GetPersistentProperty("JFD_CulDivStartingBonuses"))) then 
		for playerID = 0, GameDefines.MAX_MAJOR_CIVS - 1 do
			local player = Players[playerID]
			local cultureGroup = JFD_GetCultureType(playerID)
			if cultureGroup then
				if cultureGroup == "JFD_Andean" 			then JFD_AndeanStartingBonuses(playerID)
				elseif cultureGroup == "JFD_Bantu" 			then JFD_BantuStartingBonuses(playerID)
				elseif cultureGroup == "JFD_Islamic" 		then JFD_IslamicStartingBonuses(playerID)
				elseif cultureGroup == "JFD_Mandala" 		then JFD_MandalaStartingBonuses(playerID)
				elseif cultureGroup == "JFD_Mediterranean" 	then JFD_MediterraneanStartingBonuses(playerID)
				elseif cultureGroup == "JFD_Mesoamerican" 	then JFD_MesoamericanStartingBonuses(playerID)
				elseif cultureGroup == "JFD_Northern" 		then JFD_NorthernStartingBonuses(playerID)
				elseif cultureGroup == "JFD_Oceanic" 		then JFD_OceanicStartingBonuses(playerID)
				elseif cultureGroup == "JFD_Oriental" 		then JFD_OrientalStartingBonuses(playerID)
				elseif cultureGroup == "JFD_Semitic" 		then JFD_SemiticStartingBonuses(playerID)
				elseif cultureGroup == "JFD_TribalAmerican" then JFD_TribalAmericanStartingBonuses(playerID)
				elseif cultureGroup == "JFD_Totalitarian" 	then JFD_TotalitarianStartingBonuses(playerID)
				elseif cultureGroup == "JFD_WestAfrican" 	then JFD_WestAfricanStartingBonuses(playerID)
				elseif cultureGroup == "JFD_Western" 		then JFD_WesternStartingBonuses(playerID)
				--by Vice
				elseif cultureGroup == "JFD_Madoka" 		then JFDbutactuallyVice_MadokaStartingBonuses(playerID)

				end

				SetPersistentProperty("JFD_CulDivStartingBonuses", true)
			end
		end 
	end
end
Events.LoadScreenClose.Add(JFD_CultureStartingBonuses)
-------------------------------------------------------------------------------------------------------------------------
--JFD_AndeanStartingBonuses
-------------------------------------------------------------------------------------------------------------------------
function JFD_AndeanStartingBonuses(playerID)
	local player = Players[playerID]
	local playerTeam = Teams[player:GetTeam()]
	local teamTechs = playerTeam:GetTeamTechs()
	teamTechs:SetHasTech(techPotteryID, true)
end
-------------------------------------------------------------------------------------------------------------------------
--JFD_BantuStartingBonuses
-------------------------------------------------------------------------------------------------------------------------
function JFD_BantuStartingBonuses(playerID)
	local player = Players[playerID]
	local uniqueUnitSpearmanID = GameInfoTypes[JFD_GetUniqueUnit(player, "UNITCLASS_SPEARMAN")]
	player:AddFreeUnit(uniqueUnitSpearmanID, unitAICounterID)
	for unit in player:Units() do
		unit:ChangeExperience(10)
	end
end
-------------------------------------------------------------------------------------------------------------------------
--JFD_BharataStartingBonuses
-------------------------------------------------------------------------------------------------------------------------
function JFD_BharataStartingBonuses(playerID, cityX, cityY)
	local player = Players[playerID]
	if (g_JFDStartingBonuses == 1 and player:GetCurrentEra() == eraAncientID) then 
		local plot = Map.GetPlot(cityX, cityY)
		local city = plot:GetPlotCity()
		if city == player:GetCapitalCity() then
			local cultureGroup = JFD_GetCultureType(playerID)
			if cultureGroup == "JFD_Bharata" then
				local uniqueBuildingShrineID = GameInfoTypes[JFD_GetUniqueBuilding(player, "BUILDINGCLASS_SHRINE")]
				city:SetNumRealBuilding(uniqueBuildingShrineID, 1)
			end
		end
	end
end
GameEvents.PlayerCityFounded.Add(JFD_BharataStartingBonuses)
-------------------------------------------------------------------------------------------------------------------------
--JFD_CentralStartingBonuses
-------------------------------------------------------------------------------------------------------------------------
function JFD_CentralStartingBonuses(playerID, cityX, cityY)
	local player = Players[playerID]
	if (g_JFDStartingBonuses == 1 and player:GetCurrentEra() == eraAncientID) then 
		local plot = Map.GetPlot(cityX, cityY)
		local city = plot:GetPlotCity()
		if city == player:GetCapitalCity() then
			local cultureGroup = JFD_GetCultureType(playerID)
			if cultureGroup == "JFD_Central" then
				local uniqueBuildingGranaryID = GameInfoTypes[JFD_GetUniqueBuilding(player, "BUILDINGCLASS_GRANARY")]
				city:SetNumRealBuilding(uniqueBuildingGranaryID, 1)
			end
		end
	end
end
GameEvents.PlayerCityFounded.Add(JFD_CentralStartingBonuses)
-------------------------------------------------------------------------------------------------------------------------
--JFD_ColonialStartingBonuses
-------------------------------------------------------------------------------------------------------------------------
function JFD_ColonialStartingBonuses(playerID, cityX, cityY)
	local player = Players[playerID]
	if (g_JFDStartingBonuses == 1 and player:GetCurrentEra() == eraAncientID) then 
		local plot = Map.GetPlot(cityX, cityY)
		local city = plot:GetPlotCity()
		if city == player:GetCapitalCity() then
			local cultureGroup = JFD_GetCultureType(playerID)
			if cultureGroup == "JFD_Colonial" then
				player:ChangeGoldenAgeTurns(12)
			end
		end
	end
end
GameEvents.PlayerCityFounded.Add(JFD_ColonialStartingBonuses)
-------------------------------------------------------------------------------------------------------------------------
--JFD_EasternStartingBonuses
-------------------------------------------------------------------------------------------------------------------------
function JFD_EasternStartingBonuses(playerID, cityX, cityY)
	local player = Players[playerID]
	if (g_JFDStartingBonuses == 1 and player:GetCurrentEra() == eraAncientID) then 
		local plot = Map.GetPlot(cityX, cityY)
		local city = plot:GetPlotCity()
		if city == player:GetCapitalCity() then
			local cultureGroup = JFD_GetCultureType(playerID)
			if cultureGroup == "JFD_Eastern" then
				local uniqueBuildingWallsID = GameInfoTypes[JFD_GetUniqueBuilding(player, "BUILDINGCLASS_WALLS")]
				local uniqueBuildingBarracksID = GameInfoTypes[JFD_GetUniqueBuilding(player, "BUILDINGCLASS_BARRACKS")]
				city:SetNumRealBuilding(uniqueBuildingWallsID, 1)
				city:SetNumRealBuilding(uniqueBuildingBarracksID, 1)
			end
		end
	end
end
GameEvents.PlayerCityFounded.Add(JFD_EasternStartingBonuses)
-------------------------------------------------------------------------------------------------------------------------
--JFD_IslamicStartingBonuses
-------------------------------------------------------------------------------------------------------------------------
function JFD_IslamicStartingBonuses(playerID)
	local player = Players[playerID]
	local playerTeam = Teams[player:GetTeam()]
	local teamTechs = playerTeam:GetTeamTechs()
	teamTechs:SetHasTech(techAnimalHusbandryID, true)
end
-------------------------------------------------------------------------------------------------------------------------
--JFD_MandalaStartingBonuses
-------------------------------------------------------------------------------------------------------------------------
function JFD_MandalaStartingBonuses(playerID)
	local player = Players[playerID]
	if not (player:HasPolicy(policyPatronageID)) then
		player:SetPolicyBranchUnlocked(policyBranchPatronageID, true)
		player:SetNumFreePolicies(1)
		player:SetNumFreePolicies(0)
		player:SetHasPolicy(policyPatronageID, true)
	end
end
-------------------------------------------------------------------------------------------------------------------------
--JFD_MediterraneanStartingBonuses
-------------------------------------------------------------------------------------------------------------------------
function JFD_MediterraneanStartingBonuses(playerID)
	local player = Players[playerID]
	if (player:GetCivilizationType() ~= civilisationPapalStatesID and not (player:HasPolicy(policyLibertyID))) then
		player:SetPolicyBranchUnlocked(policyBranchLibertyID, true)
		player:SetNumFreePolicies(1)
		player:SetNumFreePolicies(0)
		player:SetHasPolicy(policyLibertyID, true)
	end
	
	if (player:GetCivilizationType() == civilisationPapalStatesID and not (player:HasPolicy(policyPietyID))) then
		player:SetPolicyBranchUnlocked(policyBranchPietyID, true)
		player:SetNumFreePolicies(1)
		player:SetNumFreePolicies(0)
		player:SetHasPolicy(policyPietyID, true)
	end
end
-------------------------------------------------------------------------------------------------------------------------
--JFD_MesoamericanStartingBonuses
-------------------------------------------------------------------------------------------------------------------------
function JFD_MesoamericanStartingBonuses(playerID)
	local player = Players[playerID]
	local playerTeam = Teams[player:GetTeam()]
	local teamTechs = playerTeam:GetTeamTechs()
	local uniqueUnitArcherID = GameInfoTypes[JFD_GetUniqueUnit(player, "UNITCLASS_ARCHER")]
	teamTechs:SetHasTech(techArcheryID, true)
	player:AddFreeUnit(uniqueUnitArcherID, unitAIRangedID)
end
-------------------------------------------------------------------------------------------------------------------------
--JFD_MesopotamicStartingBonuses
-------------------------------------------------------------------------------------------------------------------------
function JFD_MesopotamicStartingBonuses(playerID, cityX, cityY)
	local player = Players[playerID]
	if (g_JFDStartingBonuses == 1 and player:GetCurrentEra() == eraAncientID) then 
		local plot = Map.GetPlot(cityX, cityY)
		local city = plot:GetPlotCity()
		if city == player:GetCapitalCity() then
			local cultureGroup = JFD_GetCultureType(playerID)
			if cultureGroup == "JFD_Mesopotamic" then
				city:ChangePopulation(2, true)
			end
		end
	end
end
GameEvents.PlayerCityFounded.Add(JFD_MesopotamicStartingBonuses)
-------------------------------------------------------------------------------------------------------------------------
--JFD_NorthernStartingBonuses
-------------------------------------------------------------------------------------------------------------------------
function JFD_NorthernStartingBonuses(playerID)
	local player = Players[playerID]
	if not (player:HasPolicy(policyHonourID)) then
		player:SetPolicyBranchUnlocked(policyBranchHonourID, true)
		player:SetNumFreePolicies(1)
		player:SetNumFreePolicies(0)
		player:SetHasPolicy(policyHonourID, true)
		
		local uniqueUnitWarriorID = GameInfoTypes[JFD_GetUniqueUnit(player, "UNITCLASS_WARRIOR")]
		player:AddFreeUnit(uniqueUnitWarriorID, unitAIAttackID)
	end
end
-------------------------------------------------------------------------------------------------------------------------
--JFD_OceanicStartingBonuses
-------------------------------------------------------------------------------------------------------------------------
function JFD_OceanicStartingBonuses(playerID)
	local player = Players[playerID]
	local uniqueUnitScoutID = GameInfoTypes[JFD_GetUniqueUnit(player, "UNITCLASS_SCOUT")]
	player:AddFreeUnit(uniqueUnitScoutID, unitAIExploreID)
	for unit in player:Units() do
		unit:SetHasPromotion(unitPromotionEmbarkAllWaterID, true) 
	end
end
-------------------------------------------------------------------------------------------------------------------------
--JFD_OrientalStartingBonuses
-------------------------------------------------------------------------------------------------------------------------
function JFD_OrientalStartingBonuses(playerID)
	local player = Players[playerID]
	local uniqueUnitWorkerID = GameInfoTypes[JFD_GetUniqueUnit(player, "UNITCLASS_WORKER")]
	player:AddFreeUnit(uniqueUnitWorkerID, unitAIWorkerID)
end
-------------------------------------------------------------------------------------------------------------------------
--JFD_SemiticStartingBonuses
-------------------------------------------------------------------------------------------------------------------------
function JFD_SemiticStartingBonuses(playerID)
	local player = Players[playerID]
	local uniqueUnitScoutID = GameInfoTypes[JFD_GetUniqueUnit(player, "UNITCLASS_SCOUT")]
	player:AddFreeUnit(uniqueUnitScoutID, unitAIExploreID)
	for unit in player:Units() do
		unit:ChangeMoves(unit:GetMoves() + 1)
		unit:SetHasPromotion(unitPromotionExtraMoves2ID, true) 
	end
end
-------------------------------------------------------------------------------------------------------------------------
--JFD_TribalAmericanStartingBonuses
-------------------------------------------------------------------------------------------------------------------------
function JFD_TribalAmericanStartingBonuses(playerID)
	local player = Players[playerID]
	local playerTeam = Teams[player:GetTeam()]
	local teamTechs = playerTeam:GetTeamTechs()
	teamTechs:SetHasTech(techTrappingID, true)
end

function JFD_TribalAmericanStartingBonusesCity(playerID, cityX, cityY)
	local player = Players[playerID]
	if (g_JFDStartingBonuses == 1 and player:GetCurrentEra() == eraAncientID) then 
		local plot = Map.GetPlot(cityX, cityY)
		local city = plot:GetPlotCity()
		if city == player:GetCapitalCity() then
			local cultureGroup = JFD_GetCultureType(playerID)
			if cultureGroup == "JFD_TribalAmerican" then
				Sukritact_PlaceResource(city, resourceFursID)
			end
		end
	end
end
GameEvents.PlayerCityFounded.Add(JFD_TribalAmericanStartingBonusesCity)
-------------------------------------------------------------------------------------------------------------------------
--JFD_TotalitarianStartingBonuses
-------------------------------------------------------------------------------------------------------------------------
function JFD_TotalitarianStartingBonuses(playerID)
	local player = Players[playerID]
	player:AddFreeUnit(GameInfoTypes[JFD_GetUniqueUnit(player, "UNITCLASS_GREAT_GENERAL")], GameInfoTypes["UNITAI_GREAT_GENERAL"])
end
-------------------------------------------------------------------------------------------------------------------------
--JFD_SteppeStartingBonuses
-------------------------------------------------------------------------------------------------------------------------
function JFD_SteppeStartingBonuses(playerID, cityX, cityY)
	local player = Players[playerID]
	if (g_JFDStartingBonuses == 1 and player:GetCurrentEra() == eraAncientID) then 
		local plot = Map.GetPlot(cityX, cityY)
		local city = plot:GetPlotCity()
		if city == player:GetCapitalCity() then
			local cultureGroup = JFD_GetCultureType(playerID)
			if cultureGroup == "JFD_Steppe" then
				Sukritact_PlaceResource(city, resourceHorsesID)
			end
		end
	end
end
GameEvents.PlayerCityFounded.Add(JFD_SteppeStartingBonuses)
--------------------------------------------------------------

-- Sukritact_PlaceResource
--------------------------------------------------------------
function Sukritact_PlaceResource(pCity, iResource)
    local pPlot = pCity:Plot()
    local tPlots = {}
    local iNumtoPlace = 2
	local count = 1
    for pLoopPlot in PlotAreaSpiralIterator(pPlot, 3, SECTOR_NORTH, DIRECTION_CLOCKWISE, DIRECTION_OUTWARDS, CENTRE_EXCLUDE) do
		tPlots[count] = pLoopPlot
		count=count+1
    end
	
    for iVal = 1, iNumtoPlace do
		local bPlaced = false
		while (not(bPlaced)) and #tPlots > 0 do
			local iRandom = JFD_GetRandom(1, #tPlots)
			local pPlot = tPlots[iRandom]
			if pPlot then
				if (pPlot:GetTerrainType() == GameInfoTypes["TERRAIN_GRASS"] or pPlot:GetTerrainType() == GameInfoTypes["TERRAIN_PLAINS"]) and (pPlot:GetFeatureType() == -1 or pPlot:GetFeatureType() == GameInfoTypes["FEATURE_FOREST"]) and not pPlot:IsHills() and not pPlot:IsMountain() and pPlot:GetResourceType() == -1 then
					pPlot:SetResourceType(iResource, 2)
					bPlaced = true
				end
			end
			
			table.remove(tPlots, iRandom)
		end
	end
end
-------------------------------------------------------------------------------------------------------------------------
--JFD_WestAfricanStartingBonuses
-------------------------------------------------------------------------------------------------------------------------
function JFD_WestAfricanStartingBonuses(playerID)
	local player = Players[playerID]
	local playerTeam = Teams[player:GetTeam()]
	local teamTechs = playerTeam:GetTeamTechs()
	teamTechs:SetHasTech(techMiningID, true)
end
-------------------------------------------------------------------------------------------------------------------------
--JFD_WesternStartingBonuses
-------------------------------------------------------------------------------------------------------------------------
function JFD_WesternStartingBonuses(playerID)
	local player = Players[playerID]
	local startingGold = 200
	local eraMod = startingGold + GameInfo.Eras[player:GetCurrentEra()].StartingGold
	local handicapMod = GameInfo.HandicapInfos[Game.GetHandicapType()].AdvancedStartPointsMod
	local speedMod = GameInfo.GameSpeeds[Game.GetGameSpeedType()].GoldPercent
	startingGold =  mathCeil((startingGold + eraMod) * (handicapMod / 100) * (speedMod / 100))

	player:ChangeGold(startingGold)
end

-------------------------------------------------------------------------------------------------------------------------
--JFDbutactuallyVice_MadokaStartingBonuses
-------------------------------------------------------------------------------------------------------------------------
function JFDbutactuallyVice_MadokaStartingBonuses(playerID)
	if not MapModData.PMMM.GriefSeeds then MapModData.PMMM.GriefSeeds = {} end
	if not MapModData.PMMM.GriefSeeds[playerID] then MapModData.PMMM.GriefSeeds[playerID] = 2
	else MapModData.PMMM.GriefSeeds[playerID] = MapModData.PMMM.GriefSeeds[playerID] + 2 end
end


--=======================================================================================================================
-- GOLDEN AGE BONUSES FUNCTIONS	
--=======================================================================================================================
-- Globals
--------------------------------------------------------------------------------------------------------------------------
--local isUsingWhowardsDLL = JFD_IsWhowardsDLLActive()
--local policyBantuID = GameInfoTypes["POLICY_JFD_BANTU"]
----------------------------------------------------------------------------------------------------------------------------
-- JFD_CulDivGoldenAgeBonuses
----------------------------------------------------------------------------------------------------------------------------
--[[function JFD_CulDivGoldenAgeBonuses(playerID, start)
	local player = Players[playerID]
    if player:IsEverAlive() then 
		local cultureGroup = JFD_GetCultureType(playerID)
		local policyType = {}
			policyType["JFD_Bantu"] = policyBantuID

		local policyID = policyType[cultureGroup]
		if start then
			if not player:HasPolicy(policyID) then
				player:SetNumFreePolicies(1)
				player:SetNumFreePolicies(0)
				player:SetHasPolicy(policyID, true)
			end
		else
			if player:HasPolicy(policyID) then
				player:SetHasPolicy(policyID, false)
			end
		end
	end
end

if isUsingWhowardsDLL then
	GameEvents.PlayerGoldenAge.Add(JFD_CulDivGoldenAgeBonuses)
end]]
--=======================================================================================================================
-- SHARED TRAITS FUNCTIONS	
--=======================================================================================================================
-- JFD_BlockNativeNavalAndSiegeUnits
--------------------------------------------------------------------------------------------------------------------------
--[[function JFD_BlockNativeNavalAndSiegeUnits(playerID, unitID)
	local player = Players[playerID]
	if g_JFDSharedTraits == 1 then
		local nativeGroups = {"JFD_Andean", "JFD_Bantu", "JFD_Mesoamerican", "JFD_TribalAmerican"}
		for _, cultureGroup in pairs(nativeGroups) do
			if JFD_GetCultureType(Game.GetActivePlayer()) == cultureGroup then
				local combatClass = GameInfo.Units[unitID].CombatClass
				if combatClass == "UNITCOMBAT_SIEGE" or combatClass == "UNITCOMBAT_NAVALRANGED" or combatClass == "UNITCOMBAT_NAVALMELEE" then
					return
				end
			end
		end
	end

	return true
end
GameEvents.PlayerCanTrain.Add(JFD_BlockNativeNavalAndSiegeUnits)]]
--------------------------------------------------------------------------------------------------------------------------
-- JFD_NativeDoubleMeleeAndRanged
--------------------------------------------------------------------------------------------------------------------------
--[[function JFD_NativeDoubleMeleeAndRanged(playerID, cityID, unitID)
    local player = Players[playerID];
    if g_JFDSharedTraits == 1 then
		if player:IsEverAlive() and not player:IsMinorCiv() then 
			local nativeGroups = {"JFD_Andean", "JFD_Bantu", "JFD_Mesoamerican", "JFD_TribalAmerican"}
			for _, cultureGroup in pairs(nativeGroups) do
				if JFD_GetCultureType(Game.GetActivePlayer()) == cultureGroup then
					local combatClass = GameInfo.Units[unitID].CombatClass
					if combatClass == "UNITCOMBAT_MELEE" or combatClass == "UNITCOMBAT_RANGED" or combatClass == "UNITCOMBAT_GUN" then	
						player:InitUnit(unitID, player:GetUnitByID(unitID):GetX(), player:GetUnitByID(unitID):GetY())
					end
				end
			end
		end
    end
end
GameEvents.CityTrained.Add(JFD_NativeDoubleMeleeAndRanged)]]
--=======================================================================================================================
--=======================================================================================================================