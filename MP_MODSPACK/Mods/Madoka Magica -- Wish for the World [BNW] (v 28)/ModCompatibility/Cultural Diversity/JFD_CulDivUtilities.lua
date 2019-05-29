-- JFD_CulDivFunctionUtilities
-- Author: JFD
-- DateCreated: 9/22/2014 11:18:48 PM
--=======================================================================================================================
-- UTILITIES	
--=======================================================================================================================
--JFD_GetCultureSplashScreen
-------------------------------------------------------------------------------------------------------------------------
function JFD_GetCultureSplashScreen(era)
	local player = Players[Game.GetActivePlayer()]
	local splashScreenTag = JFD_GetSplashScreenTag(Game.GetActivePlayer())
	local splashScreen = nil
	if splashScreenTag then
		splashScreen = "Era_" .. splashScreenTag .. "_" .. era .. ".dds"
	end

	if splashScreen == nil then
		splashScreen = "ERA" .. "_" .. era .. ".dds"
	end

	return splashScreen
end
-------------------------------------------------------------------------------------------------------------------------
--JFD_GetCultureType
-------------------------------------------------------------------------------------------------------------------------
function JFD_GetCultureType(playerID)
	local cultureType = "JFD_Colonial"
	for row in GameInfo.Civilization_JFD_CultureTypes() do
		if GameInfoTypes[row.CivilizationType] == Players[playerID]:GetCivilizationType() then
			cultureType = row.CultureType
		end
	end

	return cultureType
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_GetRandom
--------------------------------------------------------------------------------------------------------------------------
function JFD_GetRandom(lower, upper)
    return Game.Rand((upper + 2) - lower, "") + lower
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_GetStartingBonusHelp
--------------------------------------------------------------------------------------------------------------------------
function JFD_GetStartingBonusHelp(playerID)
	local cultureType = JFD_GetCultureType(playerID)
	local cultureGroupIndex = {}
		cultureGroupIndex["JFD_Andean"] 		= 19
		cultureGroupIndex["JFD_Bantu"] 			= 13
		cultureGroupIndex["JFD_Bharata"] 		= 1
		cultureGroupIndex["JFD_Central"] 		= 2
		cultureGroupIndex["JFD_Colonial"] 		= 9
		cultureGroupIndex["JFD_Eastern"] 		= 3
		cultureGroupIndex["JFD_Islamic"] 		= 0
		cultureGroupIndex["JFD_Mandala"] 		= 5
		cultureGroupIndex["JFD_Mediterranean"] 	= 6
		cultureGroupIndex["JFD_Mesoamerican"] 	= 4
		cultureGroupIndex["JFD_Mesopotamic"] 	= 7
		cultureGroupIndex["JFD_Northern"] 		= 8
		cultureGroupIndex["JFD_Oceanic"] 		= 10
		cultureGroupIndex["JFD_Oriental"] 		= 11
		cultureGroupIndex["JFD_Semitic"] 		= 16
		cultureGroupIndex["JFD_Steppe"] 		= 12
		cultureGroupIndex["JFD_Totalitarian"] 	= 17
		cultureGroupIndex["JFD_TribalAmerican"] = 14
		cultureGroupIndex["JFD_Western"] 		= 15
		cultureGroupIndex["JFD_WestAfrican"] 	= 18
		--by Vice
		cultureGroupIndex["JFD_Madoka"] 		= 20
		

	local cultureGroupTitle = {}
		cultureGroupTitle["JFD_Andean"] 		= "TXT_KEY_JFD_DAWN_ANDEAN"
		cultureGroupTitle["JFD_Bantu"] 			= "TXT_KEY_JFD_DAWN_BANTU"
		cultureGroupTitle["JFD_Bharata"] 		= "TXT_KEY_JFD_DAWN_BHARATA"		
		cultureGroupTitle["JFD_Central"] 		= "TXT_KEY_JFD_DAWN_CENTRAL"	
		cultureGroupTitle["JFD_Colonial"]		= "TXT_KEY_JFD_DAWN_COLONIAL"
		cultureGroupTitle["JFD_Eastern"] 		= "TXT_KEY_JFD_DAWN_EASTERN"
		cultureGroupTitle["JFD_Islamic"] 		= "TXT_KEY_JFD_DAWN_ISLAMIC" 		
		cultureGroupTitle["JFD_Mandala"] 		= "TXT_KEY_JFD_DAWN_MANDALA"
		cultureGroupTitle["JFD_Mediterranean"] 	= "TXT_KEY_JFD_DAWN_MEDITERRANEAN"
		cultureGroupTitle["JFD_Mesoamerican"] 	= "TXT_KEY_JFD_DAWN_MESOAMERICAN"
		cultureGroupTitle["JFD_Mesopotamic"] 	= "TXT_KEY_JFD_DAWN_MESOPOTAMIC"
		cultureGroupTitle["JFD_Northern"] 		= "TXT_KEY_JFD_DAWN_NORTHERN"
		cultureGroupTitle["JFD_Oceanic"] 		= "TXT_KEY_JFD_DAWN_OCEANIC"
		cultureGroupTitle["JFD_Oriental"] 		= "TXT_KEY_JFD_DAWN_ORIENTAL"
		cultureGroupTitle["JFD_Semitic"] 		= "TXT_KEY_JFD_DAWN_SEMITIC"
		cultureGroupTitle["JFD_Steppe"] 		= "TXT_KEY_JFD_DAWN_STEPPE"
		cultureGroupTitle["JFD_Totalitarian"] 	= "TXT_KEY_JFD_DAWN_TOTALITARIAN"
		cultureGroupTitle["JFD_TribalAmerican"] = "TXT_KEY_JFD_DAWN_TRIBALAMERICAN"
		cultureGroupTitle["JFD_Western"]		= "TXT_KEY_JFD_DAWN_WESTERN"
		cultureGroupTitle["JFD_WestAfrican"] 	= "TXT_KEY_JFD_DAWN_WESTAFRICAN"
		--by Vice
		cultureGroupTitle["JFD_Madoka"] 		= "TXT_KEY_JFD_DAWN_MADOKA"

	local policy = "Liberty"
	if Players[playerID]:GetCivilizationType() == GameInfoTypes["CIVILIZATION_JFD_PAPAL_STATES"] then policy = "Piety" end

	local startingGold = 200
	local eraMod = startingGold + GameInfo.Eras[Players[playerID]:GetCurrentEra()].StartingGold
	local handicapMod = GameInfo.HandicapInfos[Game.GetHandicapType()].AdvancedStartPointsMod
	local speedMod = GameInfo.GameSpeeds[Game.GetGameSpeedType()].GoldPercent
	startingGold =  math.ceil((startingGold + eraMod) * (handicapMod / 100) * (speedMod / 100))
	
	local cultureGroupHelp = {}
		cultureGroupHelp["JFD_Andean"] 			= "TXT_KEY_JFD_DAWN_ANDEAN_BONUSES"
		cultureGroupHelp["JFD_Bantu"] 			= "TXT_KEY_JFD_DAWN_BANTU_BONUSES"
		cultureGroupHelp["JFD_Bharata"] 		= "TXT_KEY_JFD_DAWN_BHARATA_BONUSES"
		cultureGroupHelp["JFD_Central"] 		= "TXT_KEY_JFD_DAWN_CENTRAL_BONUSES"
		cultureGroupHelp["JFD_Colonial"]		= "TXT_KEY_JFD_DAWN_COLONIAL_BONUSES"
		cultureGroupHelp["JFD_Eastern"] 		= "TXT_KEY_JFD_DAWN_EASTERN_BONUSES"
		cultureGroupHelp["JFD_Islamic"] 		= "TXT_KEY_JFD_DAWN_ISLAMIC_BONUSES"
		cultureGroupHelp["JFD_Mandala"] 		= "TXT_KEY_JFD_DAWN_MANDALA_BONUSES"
		cultureGroupHelp["JFD_Mediterranean"] 	= Locale.ConvertTextKey("TXT_KEY_JFD_DAWN_MEDITERRANEAN_BONUSES", policy)
		cultureGroupHelp["JFD_Mesoamerican"] 	= "TXT_KEY_JFD_DAWN_MESOAMERICAN_BONUSES"
		cultureGroupHelp["JFD_Mesopotamic"] 	= "TXT_KEY_JFD_DAWN_MESOPOTAMIC_BONUSES"
		cultureGroupHelp["JFD_Northern"] 		= "TXT_KEY_JFD_DAWN_NORTHERN_BONUSES"
		cultureGroupHelp["JFD_Oceanic"] 		= "TXT_KEY_JFD_DAWN_OCEANIC_BONUSES"
		cultureGroupHelp["JFD_Oriental"] 		= "TXT_KEY_JFD_DAWN_ORIENTAL_BONUSES"
		cultureGroupHelp["JFD_Semitic"] 		= "TXT_KEY_JFD_DAWN_SEMITIC_BONUSES"
		cultureGroupHelp["JFD_Steppe"] 			= "TXT_KEY_JFD_DAWN_STEPPE_BONUSES"
		cultureGroupHelp["JFD_Totalitarian"] 	= "TXT_KEY_JFD_DAWN_TOTALITARIAN_BONUSES"
		cultureGroupHelp["JFD_TribalAmerican"] 	= "TXT_KEY_JFD_DAWN_TRIBALAMERICAN_BONUSES"
		cultureGroupHelp["JFD_Western"]			= Locale.ConvertTextKey("TXT_KEY_JFD_DAWN_WESTERN_BONUSES", startingGold)
		cultureGroupHelp["JFD_WestAfrican"] 	= "TXT_KEY_JFD_DAWN_WESTAFRICAN_BONUSES"
		--by Vice
		cultureGroupHelp["JFD_Madoka"] 			= "TXT_KEY_JFD_DAWN_MADOKA_BONUSES"

	return cultureGroupIndex[cultureType], cultureGroupTitle[cultureType], cultureGroupHelp[cultureType]
end
-------------------------------------------------------------------------------------------------------------------------
--JFD_GetSplashScreenTag
-------------------------------------------------------------------------------------------------------------------------
function JFD_GetSplashScreenTag(playerID)
	local splashScreenTag = "JFD_Colonial"
	for row in GameInfo.Civilization_JFD_CultureTypes() do
		if GameInfoTypes[row.CivilizationType] == Players[playerID]:GetCivilizationType() then
			splashScreenTag = row.SplashScreenTag
		end
	end
	return splashScreenTag
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_GetUniqueBuilding
--------------------------------------------------------------------------------------------------------------------------
function JFD_GetUniqueBuilding(player, buldingClass)
  local buldingType = nil
  local civType = GameInfo.Civilizations[player:GetCivilizationType()].Type

  for uniqueBuilding in GameInfo.Civilization_BuildingClassOverrides{CivilizationType = civType, BuildingClassType = buldingClass} do
    buldingType = uniqueBuilding.BuildingType
    break
  end

  if (buldingType == nil) then
    buldingType = GameInfo.BuildingClasses[buldingClass].DefaultBuilding
  end

  return buldingType
end
--------------------------------------------------------------------------------------------------------------------------
-- JFD_GetUniqueUnit
--------------------------------------------------------------------------------------------------------------------------
function JFD_GetUniqueUnit(player, unitClass)
  local unitType = nil
  local civType = GameInfo.Civilizations[player:GetCivilizationType()].Type
 
  for uniqueUnit in GameInfo.Civilization_UnitClassOverrides{CivilizationType = civType, UnitClassType = unitClass} do
    unitType = uniqueUnit.UnitType
    break
  end
 
  if (unitType == nil) then
    unitType = GameInfo.UnitClasses[unitClass].DefaultUnit
  end
 
  return unitType
end
------------------------------------------------------------------------------------------------------------------------
-- JFD_IsUsingPietyPrestige
--------------------------------------------------------------------------------------------------------------------------
function JFD_IsUsingPietyPrestige()
	local pietyPrestigeModID = "eea66053-7579-481a-bb8d-2f3959b59974"
	local isUsingPiety = false
	
	for _, mod in pairs(Modding.GetActivatedMods()) do
	  if (mod.ID == pietyPrestigeModID) then
	    isUsingPiety = true
	    break
	  end
	end

	return isUsingPiety
end
--------------------------------------------------------------
-- JFD_IsWhowardsDLLActive
--------------------------------------------------------------
function JFD_IsWhowardsDLLActive()
	local whowardsDLLModID = "d1b6328c-ff44-4b0d-aad7-c657f83610cd"
	local isUsingWhowardsDLL = false
	
	for _, mod in pairs(Modding.GetActivatedMods()) do
	  if (mod.ID == whowardsDLLModID) then
	    isUsingWhowardsDLL = true
	    break
	  end
	end

	return isUsingWhowardsDLL
end
------------------------------------------------------------------------------------------------------------------------
-- JFD_SendWorldEvent
------------------------------------------------------------------------------------------------------------------------
function JFD_SendWorldEvent(playerID, description)
	local player = Players[playerID]
	local playerTeam = Teams[player:GetTeam()]
	local activePlayer = Players[Game.GetActivePlayer()]
	if not (player:IsHuman()) and playerTeam:IsHasMet(activePlayer:GetTeam()) then
		Players[Game.GetActivePlayer()]:AddNotification(NotificationTypes["NOTIFICATION_DIPLOMACY_DECLARATION"], description, "[COLOR_POSITIVE_TEXT]World Events[ENDCOLOR]", -1, -1)
	end
end 
--=======================================================================================================================
--=======================================================================================================================