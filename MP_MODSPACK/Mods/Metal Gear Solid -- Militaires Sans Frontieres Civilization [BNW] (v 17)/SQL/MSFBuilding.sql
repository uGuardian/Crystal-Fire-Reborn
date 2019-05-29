INSERT INTO BuildingClasses
			(Type,										DefaultBuilding, 						NoLimit)
VALUES		('BUILDINGCLASS_BIGBOSS_MERC_GOLD_BUILDING','BUILDING_BIGBOSS_MERC_GOLD_BUILDING', 	1),
			('BUILDINGCLASS_METAL_GEAR_HANGAR',			'BUILDING_METAL_GEAR_HANGAR', 			0);



INSERT INTO Buildings
			(Type,								BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune)
VALUES		('BUILDING_BIGBOSS_MERC_GOLD_BUILDING',		'BUILDINGCLASS_BIGBOSS_MERC_GOLD_BUILDING',
			-1,		-1,			-1,				null,		1,				1);

INSERT INTO Building_YieldChanges
			(BuildingType,							YieldType,		Yield)
VALUES		('BUILDING_BIGBOSS_MERC_GOLD_BUILDING',	'YIELD_GOLD',	1);

INSERT INTO Buildings
			(Type,								BuildingClass,	
			Cost,	NeverCapture,	NukeImmune,
			Help,										Description,							Civilopedia,										Strategy)
VALUES		('BUILDING_METAL_GEAR_HANGAR',		'BUILDINGCLASS_METAL_GEAR_HANGAR',
			-1,		1,				1,
			'TXT_KEY_BUILDING_METAL_GEAR_HANGAR_HELP',	'TXT_KEY_BUILDING_METAL_GEAR_HANGAR',	'TXT_KEY_CIV5_BUILDINGS_METAL_GEAR_HANGAR_TEXT',	'TXT_KEY_BUILDING_METAL_GEAR_HANGAR_STRATEGY');



INSERT INTO Buildings
			(Type, Description, Civilopedia, Strategy, Help,
			ThemingBonusHelp, Quote, GoldMaintenance, MutuallyExclusiveGroup, TeamShare, Water, River, 
			FreshWater, Mountain, NearbyMountainRequired, Hill, Flat, FoundsReligion, IsReligious, BorderObstacle, PlayerBorderObstacle, Capital, GoldenAge, 
			MapCentering, NeverCapture, NukeImmune, AllowsWaterRoutes, ExtraLuxuries, DiplomaticVoting, AffectSpiesNow, NullifyInfluenceModifier, Cost, FaithCost, 
			LeagueCost, UnlockedByBelief, UnlockedByLeague, HolyCity, NumCityCostMod, HurryCostModifier, MinAreaSize, ConquestProb, CitiesPrereq, LevelPrereq, 
			CultureRateModifier, GlobalCultureRateModifier, GreatPeopleRateModifier, GlobalGreatPeopleRateModifier, GreatGeneralRateModifier, GreatPersonExpendGold,
			GoldenAgeModifier, UnitUpgradeCostMod, Experience, GlobalExperience, FoodKept, Airlift, AirModifier, NukeModifier, NukeExplosionRand, HealRateChange, 
			Happiness, UnmoddedHappiness, UnhappinessModifier, HappinessPerCity, HappinessPerXPolicies, CityCountUnhappinessMod, NoOccupiedUnhappiness, 
			WorkerSpeedModifier, MilitaryProductionModifier, SpaceProductionModifier, GlobalSpaceProductionModifier, BuildingProductionModifier, WonderProductionModifier,
			CityConnectionTradeRouteModifier, CapturePlunderModifier, PolicyCostModifier, PlotCultureCostModifier, GlobalPlotCultureCostModifier, PlotBuyCostModifier,
			GlobalPlotBuyCostModifier, GlobalPopulationChange, TechShare, FreeTechs, FreePolicies, FreeGreatPeople, MedianTechPercentChange, Gold, AllowsRangeStrike,
			Espionage, AllowsFoodTradeRoutes, AllowsProductionTradeRoutes, Defense, ExtraCityHitPoints, GlobalDefenseMod, MinorFriendshipChange, VictoryPoints,
			ExtraMissionarySpreads, ReligiousPressureModifier, EspionageModifier, GlobalEspionageModifier, ExtraSpies, SpyRankChange, InstantSpyRankChange,
			TradeRouteRecipientBonus, TradeRouteTargetBonus, NumTradeRouteBonus, LandmarksTourismPercent, InstantMilitaryIncrease, GreatWorksTourismModifier,
			XBuiltTriggersIdeologyChoice, TradeRouteSeaDistanceModifier, TradeRouteSeaGoldBonus, TradeRouteLandDistanceModifier, TradeRouteLandGoldBonus,
			CityStateTradeRouteProductionModifier, GreatScientistBeakerModifier, BuildingClass, ArtDefineTag, NearbyTerrainRequired, ProhibitedCityTerrain, VictoryPrereq,
			FreeStartEra, MaxStartEra, ObsoleteTech, EnhancedYieldTech, TechEnhancedTourism, FreeBuilding, FreeBuildingThisCity, FreePromotion, TrainedFreePromotion,
			FreePromotionRemoved, ReplacementBuildingClass, PrereqTech, PolicyBranchType, SpecialistType, SpecialistCount, GreatWorkSlotType, FreeGreatWork, GreatWorkCount,
			SpecialistExtraCulture, GreatPeopleRateChange, ExtraLeagueVotes, CityWall, DisplayPosition, PortraitIndex, WonderSplashImage, WonderSplashAnchor,
			WonderSplashAudio, IconAtlas, ArtInfoCulturalVariation, ArtInfoEraVariation, ArtInfoRandomVariation)
SELECT		('BUILDING_MSF_MAIN_HALL'), Description, Civilopedia, Strategy, Help,
			ThemingBonusHelp, Quote, GoldMaintenance, MutuallyExclusiveGroup, TeamShare, Water, River, 
			FreshWater, Mountain, NearbyMountainRequired, Hill, Flat, FoundsReligion, IsReligious, BorderObstacle, PlayerBorderObstacle, Capital, GoldenAge, 
			MapCentering, NeverCapture, NukeImmune, AllowsWaterRoutes, ExtraLuxuries, DiplomaticVoting, AffectSpiesNow, NullifyInfluenceModifier, Cost, FaithCost, 
			LeagueCost, UnlockedByBelief, UnlockedByLeague, HolyCity, NumCityCostMod, HurryCostModifier, MinAreaSize, ConquestProb, CitiesPrereq, LevelPrereq, 
			CultureRateModifier, GlobalCultureRateModifier, GreatPeopleRateModifier, GlobalGreatPeopleRateModifier, GreatGeneralRateModifier, GreatPersonExpendGold,
			GoldenAgeModifier, UnitUpgradeCostMod, Experience, GlobalExperience, FoodKept, Airlift, AirModifier, NukeModifier, NukeExplosionRand, HealRateChange, 
			Happiness, UnmoddedHappiness, UnhappinessModifier, HappinessPerCity, HappinessPerXPolicies, CityCountUnhappinessMod, NoOccupiedUnhappiness, 
			WorkerSpeedModifier, MilitaryProductionModifier, SpaceProductionModifier, GlobalSpaceProductionModifier, BuildingProductionModifier, WonderProductionModifier,
			CityConnectionTradeRouteModifier, CapturePlunderModifier, PolicyCostModifier, PlotCultureCostModifier, GlobalPlotCultureCostModifier, PlotBuyCostModifier,
			GlobalPlotBuyCostModifier, GlobalPopulationChange, TechShare, FreeTechs, FreePolicies, FreeGreatPeople, MedianTechPercentChange, Gold, AllowsRangeStrike,
			Espionage, AllowsFoodTradeRoutes, AllowsProductionTradeRoutes, Defense, ExtraCityHitPoints, GlobalDefenseMod, MinorFriendshipChange, VictoryPoints,
			ExtraMissionarySpreads, ReligiousPressureModifier, EspionageModifier, GlobalEspionageModifier, ExtraSpies, SpyRankChange, InstantSpyRankChange,
			TradeRouteRecipientBonus, TradeRouteTargetBonus, NumTradeRouteBonus, LandmarksTourismPercent, InstantMilitaryIncrease, GreatWorksTourismModifier,
			XBuiltTriggersIdeologyChoice, TradeRouteSeaDistanceModifier, TradeRouteSeaGoldBonus, TradeRouteLandDistanceModifier, TradeRouteLandGoldBonus,
			CityStateTradeRouteProductionModifier, GreatScientistBeakerModifier, BuildingClass, ArtDefineTag, NearbyTerrainRequired, ProhibitedCityTerrain, VictoryPrereq,
			FreeStartEra, MaxStartEra, ObsoleteTech, EnhancedYieldTech, TechEnhancedTourism, FreeBuilding, FreeBuildingThisCity, FreePromotion, TrainedFreePromotion,
			FreePromotionRemoved, ReplacementBuildingClass, PrereqTech, PolicyBranchType, SpecialistType, SpecialistCount, GreatWorkSlotType, FreeGreatWork, GreatWorkCount,
			SpecialistExtraCulture, GreatPeopleRateChange, ExtraLeagueVotes, CityWall, DisplayPosition, PortraitIndex, WonderSplashImage, WonderSplashAnchor,
			WonderSplashAudio, IconAtlas, ArtInfoCulturalVariation, ArtInfoEraVariation, ArtInfoRandomVariation
FROM Buildings WHERE (Type = 'BUILDING_PALACE');


UPDATE Buildings
SET Description = 'TXT_KEY_' || Type, Civilopedia = 'TXT_KEY_' || Type || '_TEXT', Strategy = 'TXT_KEY_' || Type || '_STRATEGY', Help = 'TXT_KEY_' || Type || '_HELP'
WHERE Type = 'BUILDING_MSF_MAIN_HALL';


UPDATE Buildings
SET IconAtlas = 'CIV_COLOR_ATLAS_MSF', PortraitIndex = 4, Defense = 0
WHERE Type = 'BUILDING_MSF_MAIN_HALL';


--*********************************************************************************
--Building_AreaYieldModifiers
--*********************************************************************************
INSERT INTO Building_AreaYieldModifiers
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_MSF_MAIN_HALL'), YieldType, Yield
FROM Building_AreaYieldModifiers WHERE (BuildingType = 'BUILDING_PALACE');


--*********************************************************************************
--Building_BuildingClassHappiness
--*********************************************************************************
INSERT INTO Building_BuildingClassHappiness
			(BuildingType, BuildingClassType, Happiness)
SELECT		('BUILDING_MSF_MAIN_HALL'), BuildingClassType, Happiness
FROM Building_BuildingClassHappiness WHERE (BuildingType = 'BUILDING_PALACE');

--*********************************************************************************
--Building_BuildingClassYieldChanges
--*********************************************************************************
INSERT INTO Building_BuildingClassYieldChanges
			(BuildingType, BuildingClassType, YieldType, YieldChange)
SELECT		('BUILDING_MSF_MAIN_HALL'), BuildingClassType, YieldType, YieldChange
FROM Building_BuildingClassYieldChanges WHERE (BuildingType = 'BUILDING_PALACE');

--*********************************************************************************
--Building_ClassesNeededInCity
--*********************************************************************************
INSERT INTO Building_ClassesNeededInCity
			(BuildingType, BuildingClassType)
SELECT		('BUILDING_MSF_MAIN_HALL'), BuildingClassType
FROM Building_ClassesNeededInCity WHERE (BuildingType = 'BUILDING_PALACE');

--*********************************************************************************
--Building_FreeUnits
--*********************************************************************************
INSERT INTO Building_FreeUnits
			(BuildingType, UnitType, NumUnits)
SELECT		('BUILDING_MSF_MAIN_HALL'), UnitType, NumUnits
FROM Building_FreeUnits WHERE (BuildingType = 'BUILDING_PALACE');

--*********************************************************************************
--Building_DomainFreeExperiences
--*********************************************************************************
INSERT INTO Building_DomainFreeExperiences
			(BuildingType, DomainType, Experience)
SELECT		('BUILDING_MSF_MAIN_HALL'), DomainType, Experience
FROM Building_DomainFreeExperiences WHERE (BuildingType = 'BUILDING_PALACE');

--*********************************************************************************
--Building_DomainFreeExperiencePerGreatWork
--*********************************************************************************
INSERT INTO Building_DomainFreeExperiencePerGreatWork
			(BuildingType, DomainType, Experience)
SELECT		('BUILDING_MSF_MAIN_HALL'), DomainType, Experience
FROM Building_DomainFreeExperiencePerGreatWork WHERE (BuildingType = 'BUILDING_PALACE');

--*********************************************************************************
--Building_DomainProductionModifiers
--*********************************************************************************
INSERT INTO Building_DomainProductionModifiers
			(BuildingType, DomainType, Modifier)
SELECT		('BUILDING_MSF_MAIN_HALL'), DomainType, Modifier
FROM Building_DomainProductionModifiers WHERE (BuildingType = 'BUILDING_PALACE');

--*********************************************************************************
--Building_FreeSpecialistCounts
--*********************************************************************************
INSERT INTO Building_FreeSpecialistCounts
			(BuildingType, SpecialistType, Count)
SELECT		('BUILDING_MSF_MAIN_HALL'), SpecialistType, Count
FROM Building_FreeSpecialistCounts WHERE (BuildingType = 'BUILDING_PALACE');

--*********************************************************************************
--Building_Flavors
--*********************************************************************************
INSERT INTO Building_Flavors
			(BuildingType, FlavorType, Flavor)
SELECT		('BUILDING_MSF_MAIN_HALL'), FlavorType, Flavor+5
FROM Building_Flavors WHERE (BuildingType = 'BUILDING_PALACE');

--*********************************************************************************
--Building_GlobalYieldModifiers
--*********************************************************************************
INSERT INTO Building_GlobalYieldModifiers
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_MSF_MAIN_HALL'), YieldType, Yield
FROM Building_GlobalYieldModifiers WHERE (BuildingType = 'BUILDING_PALACE');

--*********************************************************************************
--Building_HurryModifiers
--*********************************************************************************
INSERT INTO Building_HurryModifiers
			(BuildingType,				HurryType, HurryCostModifier)
SELECT		('BUILDING_MSF_MAIN_HALL'), HurryType, HurryCostModifier
FROM Building_HurryModifiers WHERE (BuildingType = 'BUILDING_PALACE');

--*********************************************************************************
--Building_LocalResourceAnds
--*********************************************************************************
INSERT INTO Building_LocalResourceAnds
			(BuildingType, ResourceType)
SELECT		('BUILDING_MSF_MAIN_HALL'), ResourceType
FROM Building_LocalResourceAnds WHERE (BuildingType = 'BUILDING_PALACE');

--*********************************************************************************
--Building_LocalResourceOrs
--*********************************************************************************
INSERT INTO Building_LocalResourceOrs
			(BuildingType, ResourceType)
SELECT		('BUILDING_MSF_MAIN_HALL'), ResourceType
FROM Building_LocalResourceOrs WHERE (BuildingType = 'BUILDING_PALACE');

--*********************************************************************************
--Building_LockedBuildingClasses
--*********************************************************************************
INSERT INTO Building_LockedBuildingClasses
			(BuildingType, BuildingClassType)
SELECT		('BUILDING_MSF_MAIN_HALL'), BuildingClassType
FROM Building_LockedBuildingClasses WHERE (BuildingType = 'BUILDING_PALACE');

--*********************************************************************************
--Building_PrereqBuildingClasses
--*********************************************************************************
INSERT INTO Building_PrereqBuildingClasses
			(BuildingType, BuildingClassType, NumBuildingNeeded)
SELECT		('BUILDING_MSF_MAIN_HALL'), BuildingClassType, NumBuildingNeeded
FROM Building_PrereqBuildingClasses WHERE (BuildingType = 'BUILDING_PALACE');

--*********************************************************************************
--Building_ResourceQuantity
--*********************************************************************************
INSERT INTO Building_ResourceQuantity
			(BuildingType, ResourceType, Quantity)
SELECT		('BUILDING_MSF_MAIN_HALL'), ResourceType, Quantity
FROM Building_ResourceQuantity WHERE (BuildingType = 'BUILDING_PALACE');

--*********************************************************************************
--Building_ResourceQuantityRequirements
--*********************************************************************************
INSERT INTO Building_ResourceQuantityRequirements
			(BuildingType, ResourceType, Cost)
SELECT		('BUILDING_MSF_MAIN_HALL'), ResourceType, Cost
FROM Building_ResourceQuantityRequirements WHERE (BuildingType = 'BUILDING_PALACE');

--*********************************************************************************
--Building_ResourceYieldModifiers
--*********************************************************************************
INSERT INTO Building_ResourceYieldModifiers
			(BuildingType, ResourceType, YieldType, Yield)
SELECT		('BUILDING_MSF_MAIN_HALL'), ResourceType, YieldType, Yield
FROM Building_ResourceYieldModifiers WHERE (BuildingType = 'BUILDING_PALACE');

--*********************************************************************************
--Building_ResourceCultureChanges
--*********************************************************************************
INSERT INTO Building_ResourceCultureChanges
			(BuildingType, ResourceType, CultureChange)
SELECT		('BUILDING_MSF_MAIN_HALL'), ResourceType, CultureChange
FROM Building_ResourceCultureChanges WHERE (BuildingType = 'BUILDING_PALACE');

--*********************************************************************************
--Building_ResourceFaithChanges
--*********************************************************************************
INSERT INTO Building_ResourceFaithChanges
			(BuildingType, ResourceType, FaithChange)
SELECT		('BUILDING_MSF_MAIN_HALL'), ResourceType, FaithChange
FROM Building_ResourceFaithChanges WHERE (BuildingType = 'BUILDING_PALACE');

--*********************************************************************************
--Building_RiverPlotYieldChanges
--*********************************************************************************
INSERT INTO Building_RiverPlotYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_MSF_MAIN_HALL'), YieldType, Yield
FROM Building_RiverPlotYieldChanges WHERE (BuildingType = 'BUILDING_PALACE');

--*********************************************************************************
--Building_SeaPlotYieldChanges
--*********************************************************************************
INSERT INTO Building_SeaPlotYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_MSF_MAIN_HALL'), YieldType, Yield
FROM Building_SeaPlotYieldChanges WHERE (BuildingType = 'BUILDING_PALACE');

--*********************************************************************************
--Building_LakePlotYieldChanges
--*********************************************************************************
INSERT INTO Building_LakePlotYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_MSF_MAIN_HALL'), YieldType, Yield
FROM Building_LakePlotYieldChanges WHERE (BuildingType = 'BUILDING_PALACE');

--*********************************************************************************
--Building_SeaResourceYieldChanges
--*********************************************************************************
INSERT INTO Building_SeaResourceYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_MSF_MAIN_HALL'), YieldType, Yield
FROM Building_SeaResourceYieldChanges WHERE (BuildingType = 'BUILDING_PALACE');

--*********************************************************************************
--Building_ResourceYieldChanges
--*********************************************************************************
INSERT INTO Building_ResourceYieldChanges
			(BuildingType, ResourceType, YieldType, Yield)
SELECT		('BUILDING_MSF_MAIN_HALL'), ResourceType, YieldType, Yield
FROM Building_ResourceYieldChanges WHERE (BuildingType = 'BUILDING_PALACE');

--*********************************************************************************
--Building_FeatureYieldChanges
--*********************************************************************************
INSERT INTO Building_FeatureYieldChanges
			(BuildingType, FeatureType, YieldType, Yield)
SELECT		('BUILDING_MSF_MAIN_HALL'), FeatureType, YieldType, Yield
FROM Building_FeatureYieldChanges WHERE (BuildingType = 'BUILDING_PALACE');

--*********************************************************************************
--Building_TerrainYieldChanges
--*********************************************************************************
INSERT INTO Building_TerrainYieldChanges
			(BuildingType, TerrainType, YieldType, Yield)
SELECT		('BUILDING_MSF_MAIN_HALL'), TerrainType, YieldType, Yield
FROM Building_TerrainYieldChanges WHERE (BuildingType = 'BUILDING_PALACE');

--*********************************************************************************
--Building_SpecialistYieldChanges
--*********************************************************************************
INSERT INTO Building_SpecialistYieldChanges
			(BuildingType, SpecialistType, YieldType, Yield)
SELECT		('BUILDING_MSF_MAIN_HALL'), SpecialistType, YieldType, Yield
FROM Building_SpecialistYieldChanges WHERE (BuildingType = 'BUILDING_PALACE');


--*********************************************************************************
--Building_UnitCombatFreeExperiences
--*********************************************************************************
INSERT INTO Building_UnitCombatFreeExperiences
			(BuildingType, UnitCombatType, Experience)
SELECT		('BUILDING_MSF_MAIN_HALL'), UnitCombatType, Experience
FROM Building_UnitCombatFreeExperiences WHERE (BuildingType = 'BUILDING_PALACE');

--*********************************************************************************
--Building_UnitCombatProductionModifiers
--*********************************************************************************
INSERT INTO Building_UnitCombatProductionModifiers
			(BuildingType, UnitCombatType, Modifier)
SELECT		('BUILDING_MSF_MAIN_HALL'), UnitCombatType, Modifier
FROM Building_UnitCombatProductionModifiers WHERE (BuildingType = 'BUILDING_PALACE');

--*********************************************************************************
--Building_TechAndPrereqs
--*********************************************************************************
INSERT INTO Building_TechAndPrereqs
			(BuildingType, TechType)
SELECT		('BUILDING_MSF_MAIN_HALL'), TechType
FROM Building_TechAndPrereqs WHERE (BuildingType = 'BUILDING_PALACE');

--*********************************************************************************
--Building_YieldChanges
--*********************************************************************************


--*********************************************************************************
--Building_YieldChangesPerPop
--*********************************************************************************
INSERT INTO Building_YieldChangesPerPop
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_MSF_MAIN_HALL'), YieldType, Yield
FROM Building_YieldChangesPerPop WHERE (BuildingType = 'BUILDING_PALACE');

--*********************************************************************************
--Building_YieldChangesPerReligion
--*********************************************************************************
INSERT INTO Building_YieldChangesPerReligion
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_MSF_MAIN_HALL'), YieldType, Yield
FROM Building_YieldChangesPerReligion WHERE (BuildingType = 'BUILDING_PALACE');

--*********************************************************************************
--Building_TechEnhancedYieldChanges
--*********************************************************************************
INSERT INTO Building_TechEnhancedYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_MSF_MAIN_HALL'), YieldType, Yield
FROM Building_TechEnhancedYieldChanges WHERE (BuildingType = 'BUILDING_PALACE');


--*********************************************************************************
--Building_YieldModifiers
--*********************************************************************************
INSERT INTO Building_YieldModifiers
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_MSF_MAIN_HALL'), YieldType, Yield
FROM Building_YieldModifiers WHERE (BuildingType = 'BUILDING_PALACE');



--Mother Base Level buildings
--Create a temporary table containing integers up to 21 and use triggers to init the buildings

CREATE TABLE IF NOT EXISTS MSFIntegersTemp(ID integer PRIMARY KEY, val integer);

CREATE TRIGGER MotherBaseInitTrigger1
AFTER INSERT ON MSFIntegersTemp
BEGIN
	 INSERT INTO BuildingClasses
				(Type,										DefaultBuilding)
	VALUES		('BUILDINGCLASS_MOTHER_BASE_L' || NEW.val, 'BUILDING_MOTHER_BASE_L' || NEW.val);	
END;

CREATE TRIGGER MotherBaseInitTrigger2
AFTER INSERT ON MSFIntegersTemp
BEGIN
	  INSERT INTO Buildings
  				(Type, Description, Civilopedia, Strategy, Help,
				ThemingBonusHelp, Quote, GoldMaintenance, MutuallyExclusiveGroup, TeamShare, Water, River, 
				FreshWater, Mountain, NearbyMountainRequired, Hill, Flat, FoundsReligion, IsReligious, BorderObstacle, PlayerBorderObstacle, Capital, GoldenAge, 
				MapCentering, NeverCapture, NukeImmune, AllowsWaterRoutes, ExtraLuxuries, DiplomaticVoting, AffectSpiesNow, NullifyInfluenceModifier, Cost, FaithCost, 
				LeagueCost, UnlockedByBelief, UnlockedByLeague, HolyCity, NumCityCostMod, HurryCostModifier, MinAreaSize, ConquestProb, CitiesPrereq, LevelPrereq, 
				CultureRateModifier, GlobalCultureRateModifier, GreatPeopleRateModifier, GlobalGreatPeopleRateModifier, GreatGeneralRateModifier, GreatPersonExpendGold,
				GoldenAgeModifier, UnitUpgradeCostMod, Experience, GlobalExperience, FoodKept, Airlift, AirModifier, NukeModifier, NukeExplosionRand, HealRateChange, 
				Happiness, UnmoddedHappiness, UnhappinessModifier, HappinessPerCity, HappinessPerXPolicies, CityCountUnhappinessMod, NoOccupiedUnhappiness, 
				WorkerSpeedModifier, MilitaryProductionModifier, SpaceProductionModifier, GlobalSpaceProductionModifier, BuildingProductionModifier, WonderProductionModifier,
				CityConnectionTradeRouteModifier, CapturePlunderModifier, PolicyCostModifier, PlotCultureCostModifier, GlobalPlotCultureCostModifier, PlotBuyCostModifier,
				GlobalPlotBuyCostModifier, GlobalPopulationChange, TechShare, FreeTechs, FreePolicies, FreeGreatPeople, MedianTechPercentChange, Gold, AllowsRangeStrike,
				Espionage, AllowsFoodTradeRoutes, AllowsProductionTradeRoutes, Defense, ExtraCityHitPoints, GlobalDefenseMod, MinorFriendshipChange, VictoryPoints,
				ExtraMissionarySpreads, ReligiousPressureModifier, EspionageModifier, GlobalEspionageModifier, ExtraSpies, SpyRankChange, InstantSpyRankChange,
				TradeRouteRecipientBonus, TradeRouteTargetBonus, NumTradeRouteBonus, LandmarksTourismPercent, InstantMilitaryIncrease, GreatWorksTourismModifier,
				XBuiltTriggersIdeologyChoice, TradeRouteSeaDistanceModifier, TradeRouteSeaGoldBonus, TradeRouteLandDistanceModifier, TradeRouteLandGoldBonus,
				CityStateTradeRouteProductionModifier, GreatScientistBeakerModifier, BuildingClass, ArtDefineTag, NearbyTerrainRequired, ProhibitedCityTerrain, VictoryPrereq,
				FreeStartEra, MaxStartEra, ObsoleteTech, EnhancedYieldTech, TechEnhancedTourism, FreeBuilding, FreeBuildingThisCity, FreePromotion, TrainedFreePromotion,
				FreePromotionRemoved, ReplacementBuildingClass, PrereqTech, PolicyBranchType, SpecialistType, SpecialistCount, GreatWorkSlotType, FreeGreatWork, GreatWorkCount,
				SpecialistExtraCulture, GreatPeopleRateChange, ExtraLeagueVotes, CityWall, DisplayPosition, PortraitIndex, WonderSplashImage, WonderSplashAnchor,
				WonderSplashAudio, IconAtlas, ArtInfoCulturalVariation, ArtInfoEraVariation, ArtInfoRandomVariation,
				MotherBaseLevel)
		SELECT	('BUILDING_MOTHER_BASE_L' || NEW.val), Description, Civilopedia, Strategy, Help,
				ThemingBonusHelp, Quote, GoldMaintenance, MutuallyExclusiveGroup, TeamShare, Water, River, 
				FreshWater, Mountain, NearbyMountainRequired, Hill, Flat, FoundsReligion, IsReligious, BorderObstacle, PlayerBorderObstacle, Capital, GoldenAge, 
				MapCentering, NeverCapture, NukeImmune, AllowsWaterRoutes, ExtraLuxuries, DiplomaticVoting, AffectSpiesNow, NullifyInfluenceModifier, Cost, FaithCost, 
				LeagueCost, UnlockedByBelief, UnlockedByLeague, HolyCity, NumCityCostMod, HurryCostModifier, MinAreaSize, ConquestProb, CitiesPrereq, LevelPrereq, 
				CultureRateModifier, GlobalCultureRateModifier, GreatPeopleRateModifier, GlobalGreatPeopleRateModifier, GreatGeneralRateModifier, GreatPersonExpendGold,
				GoldenAgeModifier, UnitUpgradeCostMod, Experience, GlobalExperience, FoodKept, Airlift, AirModifier, NukeModifier, NukeExplosionRand, HealRateChange, 
				Happiness, UnmoddedHappiness, UnhappinessModifier, HappinessPerCity, HappinessPerXPolicies, CityCountUnhappinessMod, NoOccupiedUnhappiness, 
				WorkerSpeedModifier, MilitaryProductionModifier, SpaceProductionModifier, GlobalSpaceProductionModifier, BuildingProductionModifier, WonderProductionModifier,
				CityConnectionTradeRouteModifier, CapturePlunderModifier, PolicyCostModifier, PlotCultureCostModifier, GlobalPlotCultureCostModifier, PlotBuyCostModifier,
				GlobalPlotBuyCostModifier, GlobalPopulationChange, TechShare, FreeTechs, FreePolicies, FreeGreatPeople, MedianTechPercentChange, Gold, AllowsRangeStrike,
				Espionage, AllowsFoodTradeRoutes, AllowsProductionTradeRoutes, Defense, ExtraCityHitPoints, GlobalDefenseMod, MinorFriendshipChange, VictoryPoints,
				ExtraMissionarySpreads, ReligiousPressureModifier, EspionageModifier, GlobalEspionageModifier, ExtraSpies, SpyRankChange, InstantSpyRankChange,
				TradeRouteRecipientBonus, TradeRouteTargetBonus, NumTradeRouteBonus, LandmarksTourismPercent, InstantMilitaryIncrease, GreatWorksTourismModifier,
				XBuiltTriggersIdeologyChoice, TradeRouteSeaDistanceModifier, TradeRouteSeaGoldBonus, TradeRouteLandDistanceModifier, TradeRouteLandGoldBonus,
				CityStateTradeRouteProductionModifier, GreatScientistBeakerModifier, ('BUILDINGCLASS_MOTHER_BASE_L' || NEW.val), ArtDefineTag, NearbyTerrainRequired, ProhibitedCityTerrain, VictoryPrereq,
				FreeStartEra, MaxStartEra, ObsoleteTech, EnhancedYieldTech, TechEnhancedTourism, FreeBuilding, FreeBuildingThisCity, FreePromotion, TrainedFreePromotion,
				FreePromotionRemoved, ReplacementBuildingClass, PrereqTech, PolicyBranchType, SpecialistType, SpecialistCount, GreatWorkSlotType, FreeGreatWork, GreatWorkCount,
				SpecialistExtraCulture, GreatPeopleRateChange, ExtraLeagueVotes, CityWall, DisplayPosition, PortraitIndex, WonderSplashImage, WonderSplashAnchor,
				WonderSplashAudio, IconAtlas, ArtInfoCulturalVariation, ArtInfoEraVariation, ArtInfoRandomVariation,
				NEW.val
	FROM Buildings WHERE (Type = 'BUILDING_PALACE');		
END;

INSERT INTO MSFIntegersTemp
			(val)
VALUES		(1), (2), (3), (4), (5), (6), (7), (8), (9), (10), (11), (12), (13), (14), (15), (16), (17), (18), (19), (20), (21);

DROP TABLE MSFIntegersTemp;






--Everything will now be inserted based on the new MotherBaseLevel value, so that every individual building will not have to have explicitly defined bonuses (with the exceptions of the Free Policies and Free Great People, since then those would trigger on every subsequent level up!)

UPDATE Buildings
SET Description = 'TXT_KEY_' || Type, Civilopedia = 'TXT_KEY_CIV5_BUILDINGS_MOTHER_BASE_TEXT', Strategy = 'TXT_KEY_BUILDING_MOTHER_BASE_STRATEGY', Help = 'TXT_KEY_' || Type || '_HELP'
WHERE instr(Type, 'BUILDING_MOTHER_BASE_L') > 0;


UPDATE Buildings
SET IconAtlas = 'CIV_COLOR_ATLAS_MSF', PortraitIndex = 4, GreatWorkSlotType = null, GreatWorkCount = 0, Cost = -1
WHERE instr(Type, 'BUILDING_MOTHER_BASE_L') > 0;


UPDATE Buildings
SET MilitaryProductionModifier = 25
WHERE MotherBaseLevel >= 2;

UPDATE Buildings
SET Experience = 15
WHERE MotherBaseLevel >= 4;

UPDATE Buildings
SET FoodKept = 15
WHERE MotherBaseLevel >= 6;

UPDATE Buildings
SET MilitaryProductionModifier = 50
WHERE MotherBaseLevel >= 7;

UPDATE Buildings
SET Defense = 1250, ExtraCityHitPoints = 50
WHERE MotherBaseLevel >= 9;

UPDATE Buildings
SET FreePolicies = 1
WHERE MotherBaseLevel = 10;

UPDATE Buildings
SET TrainedFreePromotion = 'PROMOTION_EXPERIENCE_BOOST_MSF'
WHERE MotherBaseLevel >= 11;

UPDATE Buildings
SET MilitaryProductionModifier = 75
WHERE MotherBaseLevel >= 12;

UPDATE Buildings
SET FreePromotion = 'PROMOTION_FULTON_RECOVERY_SYSTEM'
WHERE MotherBaseLevel >= 12;

UPDATE Buildings
SET FoodKept = 25
WHERE MotherBaseLevel >= 16;

UPDATE Buildings
SET FreeGreatPeople = 1
WHERE MotherBaseLevel = 20;

UPDATE Buildings
SET FreeBuildingThisCity = 'BUILDINGCLASS_METAL_GEAR_HANGAR'
WHERE MotherBaseLevel = 21;



INSERT INTO Building_ResourceQuantity
			(BuildingType,		ResourceType,		Quantity)
SELECT		Type,				('RESOURCE_IRON'),	3
FROM Buildings WHERE MotherBaseLevel >= 5;

INSERT INTO Building_ResourceQuantity
			(BuildingType,		ResourceType,		Quantity)
SELECT		Type,				('RESOURCE_ALUMINUM'),	3
FROM Buildings WHERE MotherBaseLevel >= 18;

INSERT INTO Building_ResourceQuantity
			(BuildingType,		ResourceType,		Quantity)
SELECT		Type,				('RESOURCE_URANIUM'),	1
FROM Buildings WHERE MotherBaseLevel >= 18;



INSERT INTO Building_YieldChanges
			(BuildingType,		YieldType,		Yield)
SELECT		Type,				('YIELD_GOLD'),	3
FROM Buildings WHERE MotherBaseLevel >= 1;

INSERT INTO Building_YieldChanges
			(BuildingType,		YieldType,		Yield)
SELECT		Type,				('YIELD_PRODUCTION'),	3
FROM Buildings WHERE MotherBaseLevel >= 1;

INSERT INTO Building_YieldChanges
			(BuildingType,		YieldType,		Yield)
SELECT		Type,				('YIELD_SCIENCE'),	3
FROM Buildings WHERE MotherBaseLevel >= 1;

INSERT INTO Building_YieldChanges
			(BuildingType,		YieldType,		Yield)
SELECT		Type,				('YIELD_CULTURE'),	1
FROM Buildings WHERE MotherBaseLevel >= 1;


INSERT INTO Building_YieldChanges
			(BuildingType,		YieldType,		Yield)
SELECT		Type,				('YIELD_GOLD'),	6
FROM Buildings WHERE MotherBaseLevel >= 3;

INSERT INTO Building_YieldChanges
			(BuildingType,		YieldType,		Yield)
SELECT		Type,				('YIELD_PRODUCTION'),	6
FROM Buildings WHERE MotherBaseLevel >= 3;

INSERT INTO Building_YieldChanges
			(BuildingType,		YieldType,		Yield)
SELECT		Type,				('YIELD_SCIENCE'),	6
FROM Buildings WHERE MotherBaseLevel >= 3;

INSERT INTO Building_YieldChanges
			(BuildingType,		YieldType,		Yield)
SELECT		Type,				('YIELD_CULTURE'),	4
FROM Buildings WHERE MotherBaseLevel >= 3;


INSERT INTO Building_YieldChanges
			(BuildingType,		YieldType,		Yield)
SELECT		Type,				('YIELD_GOLD'),	9
FROM Buildings WHERE MotherBaseLevel >= 14;

INSERT INTO Building_YieldChanges
			(BuildingType,		YieldType,		Yield)
SELECT		Type,				('YIELD_PRODUCTION'),	9
FROM Buildings WHERE MotherBaseLevel >= 14;

INSERT INTO Building_YieldChanges
			(BuildingType,		YieldType,		Yield)
SELECT		Type,				('YIELD_SCIENCE'),	9
FROM Buildings WHERE MotherBaseLevel >= 14;

INSERT INTO Building_YieldChanges
			(BuildingType,		YieldType,		Yield)
SELECT		Type,				('YIELD_CULTURE'),	7
FROM Buildings WHERE MotherBaseLevel >= 14;


INSERT INTO Building_YieldChanges
			(BuildingType,		YieldType,		Yield)
SELECT		Type,				('YIELD_GOLD'),	12
FROM Buildings WHERE MotherBaseLevel >= 19;

INSERT INTO Building_YieldChanges
			(BuildingType,		YieldType,		Yield)
SELECT		Type,				('YIELD_PRODUCTION'),	12
FROM Buildings WHERE MotherBaseLevel >= 19;

INSERT INTO Building_YieldChanges
			(BuildingType,		YieldType,		Yield)
SELECT		Type,				('YIELD_SCIENCE'),	12
FROM Buildings WHERE MotherBaseLevel >= 19;

INSERT INTO Building_YieldChanges
			(BuildingType,		YieldType,		Yield)
SELECT		Type,				('YIELD_CULTURE'),	10
FROM Buildings WHERE MotherBaseLevel >= 19;


INSERT INTO Building_YieldChanges
			(BuildingType,		YieldType,		Yield)
SELECT		Type,				('YIELD_FOOD'),	2
FROM Buildings WHERE MotherBaseLevel >= 6;

INSERT INTO Building_YieldChanges
			(BuildingType,		YieldType,		Yield)
SELECT		Type,				('YIELD_FOOD'),	8
FROM Buildings WHERE MotherBaseLevel >= 16;


INSERT INTO Building_YieldChangesPerPop
			(BuildingType,		YieldType,		Yield)
SELECT		Type,				('YIELD_SCIENCE'),	50
FROM Buildings WHERE MotherBaseLevel >= 13;

INSERT INTO Building_YieldChangesPerPop
			(BuildingType,		YieldType,		Yield)
SELECT		Type,				('YIELD_PRODUCTION'),	25
FROM Buildings WHERE MotherBaseLevel >= 17;