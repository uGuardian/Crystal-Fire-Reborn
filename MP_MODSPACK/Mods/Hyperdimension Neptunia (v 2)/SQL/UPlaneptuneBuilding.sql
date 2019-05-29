--*********************************************************************************
--Buildings
--*********************************************************************************

INSERT INTO Buildings
			(Type, Description, Civilopedia, Strategy, Help, ThemingBonusHelp, Quote, GoldMaintenance, MutuallyExclusiveGroup, TeamShare, Water, River, 
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
SELECT		('BUILDING_VV_DAYCARE'), ('TXT_KEY_BUILDING_VV_DAYCARE'), ('TXT_KEY_BUILDING_VV_DAYCARE_TEXT'), ('TXT_KEY_BUILDING_VV_DAYCARE_STRATEGY'),
			('TXT_KEY_BUILDING_VV_DAYCARE_HELP'), ThemingBonusHelp, Quote, GoldMaintenance, MutuallyExclusiveGroup, TeamShare, Water, River, 
			FreshWater, Mountain, NearbyMountainRequired, Hill, Flat, FoundsReligion, IsReligious, BorderObstacle, PlayerBorderObstacle, Capital, GoldenAge, 
			MapCentering, NeverCapture, NukeImmune, AllowsWaterRoutes, ExtraLuxuries, DiplomaticVoting, AffectSpiesNow, NullifyInfluenceModifier, (SELECT Cost FROM Buildings WHERE Type = 'BUILDING_SHRINE'), (SELECT FaithCost FROM Buildings WHERE Type = 'BUILDING_SHRINE'), 
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
			SpecialistExtraCulture, GreatPeopleRateChange, ExtraLeagueVotes, CityWall, DisplayPosition, 4, WonderSplashImage, WonderSplashAnchor,
			WonderSplashAudio, ('CIV_COLOR_ATLAS_VV_PLANEPTUNE_PL'), ArtInfoCulturalVariation, ArtInfoEraVariation, ArtInfoRandomVariation
FROM Buildings WHERE (Type = 'BUILDING_GRANARY');


--*********************************************************************************
--Building_AreaYieldModifiers
--*********************************************************************************
INSERT INTO Building_AreaYieldModifiers
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_VV_DAYCARE'), YieldType, Yield
FROM Building_AreaYieldModifiers WHERE (BuildingType = 'BUILDING_GRANARY');


--*********************************************************************************
--Building_BuildingClassHappiness
--*********************************************************************************
INSERT INTO Building_BuildingClassHappiness
			(BuildingType, BuildingClassType, Happiness)
SELECT		('BUILDING_VV_DAYCARE'), BuildingClassType, Happiness
FROM Building_BuildingClassHappiness WHERE (BuildingType = 'BUILDING_GRANARY');

--*********************************************************************************
--Building_BuildingClassYieldChanges
--*********************************************************************************
INSERT INTO Building_BuildingClassYieldChanges
			(BuildingType, BuildingClassType, YieldType, YieldChange)
SELECT		('BUILDING_VV_DAYCARE'), BuildingClassType, YieldType, YieldChange
FROM Building_BuildingClassYieldChanges WHERE (BuildingType = 'BUILDING_GRANARY');

--*********************************************************************************
--Building_ClassesNeededInCity
--*********************************************************************************
INSERT INTO Building_ClassesNeededInCity
			(BuildingType, BuildingClassType)
SELECT		('BUILDING_VV_DAYCARE'), BuildingClassType
FROM Building_ClassesNeededInCity WHERE (BuildingType = 'BUILDING_GRANARY');

--*********************************************************************************
--Building_FreeUnits
--*********************************************************************************
INSERT INTO Building_FreeUnits
			(BuildingType, UnitType, NumUnits)
SELECT		('BUILDING_VV_DAYCARE'), UnitType, NumUnits
FROM Building_FreeUnits WHERE (BuildingType = 'BUILDING_GRANARY');

--*********************************************************************************
--Building_DomainFreeExperiences
--*********************************************************************************
INSERT INTO Building_DomainFreeExperiences
			(BuildingType, DomainType, Experience)
SELECT		('BUILDING_VV_DAYCARE'), DomainType, Experience
FROM Building_DomainFreeExperiences WHERE (BuildingType = 'BUILDING_GRANARY');

--*********************************************************************************
--Building_DomainFreeExperiencePerGreatWork
--*********************************************************************************
INSERT INTO Building_DomainFreeExperiencePerGreatWork
			(BuildingType, DomainType, Experience)
SELECT		('BUILDING_VV_DAYCARE'), DomainType, Experience
FROM Building_DomainFreeExperiencePerGreatWork WHERE (BuildingType = 'BUILDING_GRANARY');

--*********************************************************************************
--Building_DomainProductionModifiers
--*********************************************************************************
INSERT INTO Building_DomainProductionModifiers
			(BuildingType, DomainType, Modifier)
SELECT		('BUILDING_VV_DAYCARE'), DomainType, Modifier
FROM Building_DomainProductionModifiers WHERE (BuildingType = 'BUILDING_GRANARY');

--*********************************************************************************
--Building_FreeSpecialistCounts
--*********************************************************************************
INSERT INTO Building_FreeSpecialistCounts
			(BuildingType, SpecialistType, Count)
SELECT		('BUILDING_VV_DAYCARE'), SpecialistType, Count
FROM Building_FreeSpecialistCounts WHERE (BuildingType = 'BUILDING_GRANARY');

--*********************************************************************************
--Building_Flavors
--*********************************************************************************
INSERT INTO Building_Flavors
			(BuildingType, FlavorType, Flavor)
SELECT		('BUILDING_VV_DAYCARE'), FlavorType, Flavor+5
FROM Building_Flavors WHERE (BuildingType = 'BUILDING_GRANARY');

--*********************************************************************************
--Building_GlobalYieldModifiers
--*********************************************************************************
INSERT INTO Building_GlobalYieldModifiers
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_VV_DAYCARE'), YieldType, Yield
FROM Building_GlobalYieldModifiers WHERE (BuildingType = 'BUILDING_GRANARY');

--*********************************************************************************
--Building_HurryModifiers
--*********************************************************************************
INSERT INTO Building_HurryModifiers
			(BuildingType,				HurryType, HurryCostModifier)
SELECT		('BUILDING_VV_DAYCARE'), HurryType, HurryCostModifier
FROM Building_HurryModifiers WHERE (BuildingType = 'BUILDING_GRANARY');

--*********************************************************************************
--Building_LocalResourceAnds
--*********************************************************************************
-- none

--*********************************************************************************
--Building_LocalResourceOrs
--*********************************************************************************
--none

--*********************************************************************************
--Building_LockedBuildingClasses
--*********************************************************************************
INSERT INTO Building_LockedBuildingClasses
			(BuildingType, BuildingClassType)
SELECT		('BUILDING_VV_DAYCARE'), BuildingClassType
FROM Building_LockedBuildingClasses WHERE (BuildingType = 'BUILDING_GRANARY');

--*********************************************************************************
--Building_PrereqBuildingClasses
--*********************************************************************************
INSERT INTO Building_PrereqBuildingClasses
			(BuildingType, BuildingClassType, NumBuildingNeeded)
SELECT		('BUILDING_VV_DAYCARE'), BuildingClassType, NumBuildingNeeded
FROM Building_PrereqBuildingClasses WHERE (BuildingType = 'BUILDING_GRANARY');

--*********************************************************************************
--Building_ResourceQuantity
--*********************************************************************************
INSERT INTO Building_ResourceQuantity
			(BuildingType, ResourceType, Quantity)
SELECT		('BUILDING_VV_DAYCARE'), ResourceType, Quantity
FROM Building_ResourceQuantity WHERE (BuildingType = 'BUILDING_GRANARY');

--*********************************************************************************
--Building_ResourceQuantityRequirements
--*********************************************************************************
INSERT INTO Building_ResourceQuantityRequirements
			(BuildingType, ResourceType, Cost)
SELECT		('BUILDING_VV_DAYCARE'), ResourceType, Cost
FROM Building_ResourceQuantityRequirements WHERE (BuildingType = 'BUILDING_GRANARY');

--*********************************************************************************
--Building_ResourceYieldModifiers
--*********************************************************************************
--none

--*********************************************************************************
--Building_ResourceCultureChanges
--*********************************************************************************
INSERT INTO Building_ResourceCultureChanges
			(BuildingType, ResourceType, CultureChange)
SELECT		('BUILDING_VV_DAYCARE'), ResourceType, CultureChange
FROM Building_ResourceCultureChanges WHERE (BuildingType = 'BUILDING_GRANARY');

--*********************************************************************************
--Building_ResourceFaithChanges
--*********************************************************************************
INSERT INTO Building_ResourceFaithChanges
			(BuildingType, ResourceType, FaithChange)
SELECT		('BUILDING_VV_DAYCARE'), ResourceType, FaithChange
FROM Building_ResourceFaithChanges WHERE (BuildingType = 'BUILDING_GRANARY');

--*********************************************************************************
--Building_RiverPlotYieldChanges
--*********************************************************************************
INSERT INTO Building_RiverPlotYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_VV_DAYCARE'), YieldType, Yield
FROM Building_RiverPlotYieldChanges WHERE (BuildingType = 'BUILDING_GRANARY');

--*********************************************************************************
--Building_SeaPlotYieldChanges
--*********************************************************************************
INSERT INTO Building_SeaPlotYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_VV_DAYCARE'), YieldType, Yield
FROM Building_SeaPlotYieldChanges WHERE (BuildingType = 'BUILDING_GRANARY');

--*********************************************************************************
--Building_LakePlotYieldChanges
--*********************************************************************************
INSERT INTO Building_LakePlotYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_VV_DAYCARE'), YieldType, Yield
FROM Building_LakePlotYieldChanges WHERE (BuildingType = 'BUILDING_GRANARY');

--*********************************************************************************
--Building_SeaResourceYieldChanges
--*********************************************************************************
INSERT INTO Building_SeaResourceYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_VV_DAYCARE'), YieldType, Yield
FROM Building_SeaResourceYieldChanges WHERE (BuildingType = 'BUILDING_GRANARY');

--*********************************************************************************
--Building_ResourceYieldChanges
--*********************************************************************************
--none

--*********************************************************************************
--Building_FeatureYieldChanges
--*********************************************************************************
INSERT INTO Building_FeatureYieldChanges
			(BuildingType, FeatureType, YieldType, Yield)
SELECT		('BUILDING_VV_DAYCARE'), FeatureType, YieldType, Yield
FROM Building_FeatureYieldChanges WHERE (BuildingType = 'BUILDING_GRANARY');

--*********************************************************************************
--Building_TerrainYieldChanges
--*********************************************************************************
INSERT INTO Building_TerrainYieldChanges
			(BuildingType, TerrainType, YieldType, Yield)
SELECT		('BUILDING_VV_DAYCARE'), TerrainType, YieldType, Yield
FROM Building_TerrainYieldChanges WHERE (BuildingType = 'BUILDING_GRANARY');

--*********************************************************************************
--Building_SpecialistYieldChanges
--*********************************************************************************
INSERT INTO Building_SpecialistYieldChanges
			(BuildingType, SpecialistType, YieldType, Yield)
SELECT		('BUILDING_VV_DAYCARE'), SpecialistType, YieldType, Yield
FROM Building_SpecialistYieldChanges WHERE (BuildingType = 'BUILDING_GRANARY');


--*********************************************************************************
--Building_UnitCombatFreeExperiences
--*********************************************************************************
INSERT INTO Building_UnitCombatFreeExperiences
			(BuildingType, UnitCombatType, Experience)
SELECT		('BUILDING_VV_DAYCARE'), UnitCombatType, Experience
FROM Building_UnitCombatFreeExperiences WHERE (BuildingType = 'BUILDING_GRANARY');

--*********************************************************************************
--Building_UnitCombatProductionModifiers
--*********************************************************************************
--none

--*********************************************************************************
--Building_TechAndPrereqs
--*********************************************************************************
INSERT INTO Building_TechAndPrereqs
			(BuildingType, TechType)
SELECT		('BUILDING_VV_DAYCARE'), TechType
FROM Building_TechAndPrereqs WHERE (BuildingType = 'BUILDING_GRANARY');

--*********************************************************************************
--Building_YieldChanges
--*********************************************************************************
INSERT INTO Building_YieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_VV_DAYCARE'), YieldType, Yield
FROM Building_YieldChanges WHERE (BuildingType = 'BUILDING_GRANARY');

--*********************************************************************************
--Building_YieldChangesPerPop
--*********************************************************************************
INSERT INTO Building_YieldChangesPerPop
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_VV_DAYCARE'), YieldType, Yield
FROM Building_YieldChangesPerPop WHERE (BuildingType = 'BUILDING_GRANARY');

--*********************************************************************************
--Building_YieldChangesPerReligion
--*********************************************************************************
INSERT INTO Building_YieldChangesPerReligion
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_VV_DAYCARE'), YieldType, Yield
FROM Building_YieldChangesPerReligion WHERE (BuildingType = 'BUILDING_GRANARY');

--*********************************************************************************
--Building_TechEnhancedYieldChanges
--*********************************************************************************
INSERT INTO Building_TechEnhancedYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_VV_DAYCARE'), YieldType, Yield
FROM Building_TechEnhancedYieldChanges WHERE (BuildingType = 'BUILDING_GRANARY');


--*********************************************************************************
--Building_YieldModifiers
--*********************************************************************************
INSERT INTO Building_YieldModifiers
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_VV_DAYCARE'), YieldType, Yield
FROM Building_YieldModifiers WHERE (BuildingType = 'BUILDING_GRANARY');



------------------------------------------------DAYCARE DOLL BUILDINGS-----------------------------------------------------------------
INSERT INTO BuildingClasses
			(Type,								DefaultBuilding)
VALUES		('BUILDINGCLASS_VV_DCD_SCIENCE',	'BUILDING_VV_DCD_SCIENCE'),
			('BUILDINGCLASS_VV_DCD_FOOD',		'BUILDING_VV_DCD_FOOD'),
			('BUILDINGCLASS_VV_DCD_PRODUCTION',	'BUILDING_VV_DCD_PRODUCTION'),
			('BUILDINGCLASS_VV_DCD_GOLD',		'BUILDING_VV_DCD_GOLD'),
			('BUILDINGCLASS_VV_DCD_CULTURE',	'BUILDING_VV_DCD_CULTURE'),
			('BUILDINGCLASS_VV_DCD_FAITH',		'BUILDING_VV_DCD_FAITH'),
			('BUILDINGCLASS_VV_DCD_DEFENSE',	'BUILDING_VV_DCD_DEFENSE'),
			('BUILDINGCLASS_VV_DCD_SHARES',		'BUILDING_VV_DCD_SHARES');


INSERT INTO Buildings
			(Type,								BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune,
			Description,							Help)
VALUES		('BUILDING_VV_DCD_SCIENCE',		'BUILDINGCLASS_VV_DCD_SCIENCE',
			-1,		-1,			-1,				null,		1,				1,
			'TXT_KEY_BUILDING_VV_DCD_SCIENCE',		'TXT_KEY_BUILDING_VV_DCD_SCIENCE');

INSERT INTO Buildings
			(Type,								BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune,
			Description,							Help)
VALUES		('BUILDING_VV_DCD_FOOD',		'BUILDINGCLASS_VV_DCD_FOOD',
			-1,		-1,			-1,				null,		1,				1,
			'TXT_KEY_BUILDING_VV_DCD_FOOD',		'TXT_KEY_BUILDING_VV_DCD_FOOD');

INSERT INTO Buildings
			(Type,								BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune,
			Description,							Help)
VALUES		('BUILDING_VV_DCD_PRODUCTION',		'BUILDINGCLASS_VV_DCD_PRODUCTION',
			-1,		-1,			-1,				null,		1,				1,
			'TXT_KEY_BUILDING_VV_DCD_PRODUCTION',		'TXT_KEY_BUILDING_VV_DCD_PRODUCTION');

INSERT INTO Buildings
			(Type,								BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune,
			Description,							Help)
VALUES		('BUILDING_VV_DCD_GOLD',		'BUILDINGCLASS_VV_DCD_GOLD',
			-1,		-1,			-1,				null,		1,				1,
			'TXT_KEY_BUILDING_VV_DCD_GOLD',		'TXT_KEY_BUILDING_VV_DCD_GOLD');


INSERT INTO Buildings
			(Type,								BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune,
			Description,							Help)
VALUES		('BUILDING_VV_DCD_CULTURE',		'BUILDINGCLASS_VV_DCD_CULTURE',
			-1,		-1,			-1,				null,		1,				1,
			'TXT_KEY_BUILDING_VV_DCD_CULTURE',		'TXT_KEY_BUILDING_VV_DCD_CULTURE');


INSERT INTO Buildings
			(Type,								BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune,
			Description,							Help)
VALUES		('BUILDING_VV_DCD_FAITH',		'BUILDINGCLASS_VV_DCD_FAITH',
			-1,		-1,			-1,				null,		1,				1,
			'TXT_KEY_BUILDING_VV_DCD_FAITH',		'TXT_KEY_BUILDING_VV_DCD_FAITH');


INSERT INTO Buildings
			(Type,								BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune,
			Description,							Help,
			Defense,	ExtraCityHitPoints)
VALUES		('BUILDING_VV_DCD_DEFENSE',		'BUILDINGCLASS_VV_DCD_DEFENSE',
			-1,		-1,			-1,				null,		1,				1,
			'TXT_KEY_BUILDING_VV_DCD_DEFENSE',		'TXT_KEY_BUILDING_VV_DCD_DEFENSE',
			10,			1);


INSERT INTO Buildings
			(Type,								BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune,
			Description,							Help,
			VV_SharesChange)
VALUES		('BUILDING_VV_DCD_SHARES',		'BUILDINGCLASS_VV_DCD_SHARES',
			-1,		-1,			-1,				null,		1,				1,
			'TXT_KEY_BUILDING_VV_DCD_SHARES',		'TXT_KEY_BUILDING_VV_DCD_SHARES',
			1);


INSERT INTO Building_YieldChanges
			(BuildingType,					YieldType,			Yield)
VALUES		('BUILDING_VV_DCD_SCIENCE',		'YIELD_SCIENCE',	1),
			('BUILDING_VV_DCD_FOOD',		'YIELD_FOOD',		1),
			('BUILDING_VV_DCD_PRODUCTION',	'YIELD_PRODUCTION',	1),
			('BUILDING_VV_DCD_CULTURE',		'YIELD_CULTURE',	1),
			('BUILDING_VV_DCD_FAITH',		'YIELD_FAITH',		1);



------------------------------------------------STRESS DUMMY BUILDINGS-----------------------------------------------------------------
INSERT INTO BuildingClasses
			(Type,								DefaultBuilding)
VALUES		('BUILDINGCLASS_PLUTIA_SD_HAPPINESS',	'BUILDING_PLUTIA_SD_HAPPINESS'),
			('BUILDINGCLASS_PLUTIA_SD_MILITARY',		'BUILDING_PLUTIA_SD_MILITARY');

INSERT INTO Buildings
			(Type,								BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune,
			Description,							Help,
			MilitaryProductionModifier)
VALUES		('BUILDING_PLUTIA_SD_MILITARY',		'BUILDINGCLASS_PLUTIA_SD_MILITARY',
			-1,		-1,			-1,				null,		1,				1,
			'TXT_KEY_BUILDING_PLUTIA_SD_MILITARY',		'TXT_KEY_BUILDING_PLUTIA_SD_MILITARY',
			25);


INSERT INTO Buildings
			(Type,								BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune,
			Description,							Help,
			UnhappinessModifier)
VALUES		('BUILDING_PLUTIA_SD_HAPPINESS',		'BUILDINGCLASS_PLUTIA_SD_HAPPINESS',
			-1,		-1,			-1,				null,		1,				1,
			'TXT_KEY_BUILDING_PLUTIA_SD_HAPPINESS',		'TXT_KEY_BUILDING_PLUTIA_SD_HAPPINESS',
			10);


------------------------------------------------OTHER DUMMY BUILDINGS-----------------------------------------------------------------

INSERT INTO BuildingClasses
			(Type,									DefaultBuilding)
VALUES		('BUILDINGCLASS_VV_PLUTIA_DUMMY',		'BUILDING_VV_PLUTIA_DUMMY'),
			('BUILDINGCLASS_VV_IRIS_HEART_DUMMY',	'BUILDING_VV_IRIS_HEART_DUMMY'),
			('BUILDINGCLASS_VV_DAYCARE_FOOD_DUMMY',	'BUILDING_VV_DAYCARE_FOOD_DUMMY'),
			('BUILDINGCLASS_VV_IRIS_HAPPINESS',		'BUILDING_VV_IRIS_HAPPINESS');

INSERT INTO Buildings
			(Type,								BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune)
VALUES		('BUILDING_VV_PLUTIA_DUMMY',		'BUILDINGCLASS_VV_PLUTIA_DUMMY',
			-1,		-1,			-1,				null,		1,				1);

INSERT INTO Buildings
			(Type,								BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune)
VALUES		('BUILDING_VV_IRIS_HEART_DUMMY',	'BUILDINGCLASS_VV_IRIS_HEART_DUMMY',
			-1,		-1,			-1,				null,		1,				1);

INSERT INTO Buildings
			(Type,								BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune)
VALUES		('BUILDING_VV_DAYCARE_FOOD_DUMMY',	'BUILDINGCLASS_VV_DAYCARE_FOOD_DUMMY',
			-1,		-1,			-1,				null,		1,				1);
			
INSERT INTO Buildings
			(Type,								BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune,
			UnmoddedHappiness)
VALUES		('BUILDING_VV_IRIS_HAPPINESS',		'BUILDINGCLASS_VV_IRIS_HAPPINESS',
			-1,		-1,			-1,				null,		1,				1,
			1);
			

INSERT INTO Building_BuildingClassYieldChanges
			(BuildingType,						BuildingClassType,			YieldType,			YieldChange)
VALUES		('BUILDING_VV_PLUTIA_DUMMY',		'BUILDINGCLASS_GRANARY',	'YIELD_FAITH',		1),
			('BUILDING_VV_IRIS_HEART_DUMMY',	'BUILDINGCLASS_GRANARY',	'YIELD_PRODUCTION',	2);

INSERT INTO Building_YieldChanges
			(BuildingType,						YieldType,		Yield)
VALUES		('BUILDING_VV_DAYCARE_FOOD_DUMMY',	'YIELD_FOOD',	1);