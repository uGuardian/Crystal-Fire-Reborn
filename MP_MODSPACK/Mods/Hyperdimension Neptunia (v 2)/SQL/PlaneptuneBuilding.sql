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
SELECT		('BUILDING_VV_PUDDING_PARLOR'), ('TXT_KEY_BUILDING_VV_PUDDING_PARLOR'), ('TXT_KEY_BUILDING_VV_PUDDING_PARLOR_TEXT'), ('TXT_KEY_BUILDING_VV_PUDDING_PARLOR_STRATEGY'),
			('TXT_KEY_BUILDING_VV_PUDDING_PARLOR_HELP'), ThemingBonusHelp, Quote, GoldMaintenance, MutuallyExclusiveGroup, TeamShare, Water, River, 
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
			FreePromotionRemoved, ReplacementBuildingClass, ('TECH_ANIMAL_HUSBANDRY'), PolicyBranchType, SpecialistType, SpecialistCount, GreatWorkSlotType, FreeGreatWork, GreatWorkCount,
			SpecialistExtraCulture, GreatPeopleRateChange, ExtraLeagueVotes, CityWall, DisplayPosition, 5, WonderSplashImage, WonderSplashAnchor,
			WonderSplashAudio, ('CIV_COLOR_ATLAS_VV_PLANEPTUNE'), ArtInfoCulturalVariation, ArtInfoEraVariation, ArtInfoRandomVariation
FROM Buildings WHERE (Type = 'BUILDING_STABLE');


--*********************************************************************************
--Building_AreaYieldModifiers
--*********************************************************************************
INSERT INTO Building_AreaYieldModifiers
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), YieldType, Yield
FROM Building_AreaYieldModifiers WHERE (BuildingType = 'BUILDING_STABLE');


--*********************************************************************************
--Building_BuildingClassHappiness
--*********************************************************************************
INSERT INTO Building_BuildingClassHappiness
			(BuildingType, BuildingClassType, Happiness)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), BuildingClassType, Happiness
FROM Building_BuildingClassHappiness WHERE (BuildingType = 'BUILDING_STABLE');

--*********************************************************************************
--Building_BuildingClassYieldChanges
--*********************************************************************************
INSERT INTO Building_BuildingClassYieldChanges
			(BuildingType, BuildingClassType, YieldType, YieldChange)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), BuildingClassType, YieldType, YieldChange
FROM Building_BuildingClassYieldChanges WHERE (BuildingType = 'BUILDING_STABLE');

--*********************************************************************************
--Building_ClassesNeededInCity
--*********************************************************************************
INSERT INTO Building_ClassesNeededInCity
			(BuildingType, BuildingClassType)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), BuildingClassType
FROM Building_ClassesNeededInCity WHERE (BuildingType = 'BUILDING_STABLE');

--*********************************************************************************
--Building_FreeUnits
--*********************************************************************************
INSERT INTO Building_FreeUnits
			(BuildingType, UnitType, NumUnits)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), UnitType, NumUnits
FROM Building_FreeUnits WHERE (BuildingType = 'BUILDING_STABLE');

--*********************************************************************************
--Building_DomainFreeExperiences
--*********************************************************************************
INSERT INTO Building_DomainFreeExperiences
			(BuildingType, DomainType, Experience)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), DomainType, Experience
FROM Building_DomainFreeExperiences WHERE (BuildingType = 'BUILDING_STABLE');

--*********************************************************************************
--Building_DomainFreeExperiencePerGreatWork
--*********************************************************************************
INSERT INTO Building_DomainFreeExperiencePerGreatWork
			(BuildingType, DomainType, Experience)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), DomainType, Experience
FROM Building_DomainFreeExperiencePerGreatWork WHERE (BuildingType = 'BUILDING_STABLE');

--*********************************************************************************
--Building_DomainProductionModifiers
--*********************************************************************************
INSERT INTO Building_DomainProductionModifiers
			(BuildingType, DomainType, Modifier)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), DomainType, Modifier
FROM Building_DomainProductionModifiers WHERE (BuildingType = 'BUILDING_STABLE');

--*********************************************************************************
--Building_FreeSpecialistCounts
--*********************************************************************************
INSERT INTO Building_FreeSpecialistCounts
			(BuildingType, SpecialistType, Count)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), SpecialistType, Count
FROM Building_FreeSpecialistCounts WHERE (BuildingType = 'BUILDING_STABLE');

--*********************************************************************************
--Building_Flavors
--*********************************************************************************
INSERT INTO Building_Flavors
			(BuildingType, FlavorType, Flavor)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), FlavorType, Flavor+15
FROM Building_Flavors WHERE (BuildingType = 'BUILDING_STABLE');

INSERT INTO Building_Flavors
			(BuildingType,					FlavorType,			Flavor)
VALUES		('BUILDING_VV_PUDDING_PARLOR', 'FLAVOR_SCIENCE',	25);

--*********************************************************************************
--Building_GlobalYieldModifiers
--*********************************************************************************
INSERT INTO Building_GlobalYieldModifiers
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), YieldType, Yield
FROM Building_GlobalYieldModifiers WHERE (BuildingType = 'BUILDING_STABLE');

--*********************************************************************************
--Building_HurryModifiers
--*********************************************************************************
INSERT INTO Building_HurryModifiers
			(BuildingType,				HurryType, HurryCostModifier)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), HurryType, HurryCostModifier
FROM Building_HurryModifiers WHERE (BuildingType = 'BUILDING_STABLE');

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
SELECT		('BUILDING_VV_PUDDING_PARLOR'), BuildingClassType
FROM Building_LockedBuildingClasses WHERE (BuildingType = 'BUILDING_STABLE');

--*********************************************************************************
--Building_PrereqBuildingClasses
--*********************************************************************************
INSERT INTO Building_PrereqBuildingClasses
			(BuildingType, BuildingClassType, NumBuildingNeeded)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), BuildingClassType, NumBuildingNeeded
FROM Building_PrereqBuildingClasses WHERE (BuildingType = 'BUILDING_STABLE');

--*********************************************************************************
--Building_ResourceQuantity
--*********************************************************************************
INSERT INTO Building_ResourceQuantity
			(BuildingType, ResourceType, Quantity)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), ResourceType, Quantity
FROM Building_ResourceQuantity WHERE (BuildingType = 'BUILDING_STABLE');

--*********************************************************************************
--Building_ResourceQuantityRequirements
--*********************************************************************************
INSERT INTO Building_ResourceQuantityRequirements
			(BuildingType, ResourceType, Cost)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), ResourceType, Cost
FROM Building_ResourceQuantityRequirements WHERE (BuildingType = 'BUILDING_STABLE');

--*********************************************************************************
--Building_ResourceYieldModifiers
--*********************************************************************************
--none

--*********************************************************************************
--Building_ResourceCultureChanges
--*********************************************************************************
INSERT INTO Building_ResourceCultureChanges
			(BuildingType, ResourceType, CultureChange)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), ResourceType, CultureChange
FROM Building_ResourceCultureChanges WHERE (BuildingType = 'BUILDING_STABLE');

--*********************************************************************************
--Building_ResourceFaithChanges
--*********************************************************************************
INSERT INTO Building_ResourceFaithChanges
			(BuildingType, ResourceType, FaithChange)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), ResourceType, FaithChange
FROM Building_ResourceFaithChanges WHERE (BuildingType = 'BUILDING_STABLE');

--*********************************************************************************
--Building_RiverPlotYieldChanges
--*********************************************************************************
INSERT INTO Building_RiverPlotYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), YieldType, Yield
FROM Building_RiverPlotYieldChanges WHERE (BuildingType = 'BUILDING_STABLE');

--*********************************************************************************
--Building_SeaPlotYieldChanges
--*********************************************************************************
INSERT INTO Building_SeaPlotYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), YieldType, Yield
FROM Building_SeaPlotYieldChanges WHERE (BuildingType = 'BUILDING_STABLE');

--*********************************************************************************
--Building_LakePlotYieldChanges
--*********************************************************************************
INSERT INTO Building_LakePlotYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), YieldType, Yield
FROM Building_LakePlotYieldChanges WHERE (BuildingType = 'BUILDING_STABLE');

--*********************************************************************************
--Building_SeaResourceYieldChanges
--*********************************************************************************
INSERT INTO Building_SeaResourceYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), YieldType, Yield
FROM Building_SeaResourceYieldChanges WHERE (BuildingType = 'BUILDING_STABLE');

--*********************************************************************************
--Building_ResourceYieldChanges
--*********************************************************************************
--none

--*********************************************************************************
--Building_FeatureYieldChanges
--*********************************************************************************
INSERT INTO Building_FeatureYieldChanges
			(BuildingType, FeatureType, YieldType, Yield)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), FeatureType, YieldType, Yield
FROM Building_FeatureYieldChanges WHERE (BuildingType = 'BUILDING_STABLE');

--*********************************************************************************
--Building_TerrainYieldChanges
--*********************************************************************************
INSERT INTO Building_TerrainYieldChanges
			(BuildingType, TerrainType, YieldType, Yield)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), TerrainType, YieldType, Yield
FROM Building_TerrainYieldChanges WHERE (BuildingType = 'BUILDING_STABLE');

--*********************************************************************************
--Building_SpecialistYieldChanges
--*********************************************************************************
INSERT INTO Building_SpecialistYieldChanges
			(BuildingType, SpecialistType, YieldType, Yield)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), SpecialistType, YieldType, Yield
FROM Building_SpecialistYieldChanges WHERE (BuildingType = 'BUILDING_STABLE');


--*********************************************************************************
--Building_UnitCombatFreeExperiences
--*********************************************************************************
INSERT INTO Building_UnitCombatFreeExperiences
			(BuildingType, UnitCombatType, Experience)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), UnitCombatType, Experience
FROM Building_UnitCombatFreeExperiences WHERE (BuildingType = 'BUILDING_STABLE');

--*********************************************************************************
--Building_UnitCombatProductionModifiers
--*********************************************************************************
--none

--*********************************************************************************
--Building_TechAndPrereqs
--*********************************************************************************
INSERT INTO Building_TechAndPrereqs
			(BuildingType, TechType)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), TechType
FROM Building_TechAndPrereqs WHERE (BuildingType = 'BUILDING_STABLE');

--*********************************************************************************
--Building_YieldChanges
--*********************************************************************************
INSERT INTO Building_YieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), YieldType, Yield
FROM Building_YieldChanges WHERE (BuildingType = 'BUILDING_STABLE');

--*********************************************************************************
--Building_YieldChangesPerPop
--*********************************************************************************
INSERT INTO Building_YieldChangesPerPop
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), YieldType, Yield
FROM Building_YieldChangesPerPop WHERE (BuildingType = 'BUILDING_STABLE');

--*********************************************************************************
--Building_YieldChangesPerReligion
--*********************************************************************************
INSERT INTO Building_YieldChangesPerReligion
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), YieldType, Yield
FROM Building_YieldChangesPerReligion WHERE (BuildingType = 'BUILDING_STABLE');

--*********************************************************************************
--Building_TechEnhancedYieldChanges
--*********************************************************************************
INSERT INTO Building_TechEnhancedYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), YieldType, Yield
FROM Building_TechEnhancedYieldChanges WHERE (BuildingType = 'BUILDING_STABLE');


--*********************************************************************************
--Building_YieldModifiers
--*********************************************************************************
INSERT INTO Building_YieldModifiers
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), YieldType, Yield
FROM Building_YieldModifiers WHERE (BuildingType = 'BUILDING_STABLE');



------------------------------------------------DUMMY BUILDINGS-----------------------------------------------------------------

INSERT INTO BuildingClasses
			(Type,																DefaultBuilding)
VALUES		('BUILDINGCLASS_VV_PLANEPTUNE_DUMMY_BUILDING_NEPTUNE',			'BUILDING_VV_PLANEPTUNE_DUMMY_BUILDING_NEPTUNE'),
			('BUILDINGCLASS_VV_PLANEPTUNE_DUMMY_BUILDING_PURPLE_HEART',		'BUILDING_VV_PLANEPTUNE_DUMMY_BUILDING_PURPLE_HEART'),
			('BUILDINGCLASS_VV_PLANEPTUNE_DUMMY_BUILDING_PURPLE_HEART_UA',	'BUILDING_VV_PLANEPTUNE_DUMMY_BUILDING_PURPLE_HEART_UA'),
			('BUILDINGCLASS_VV_PLANEPTUNE_DUMMY_BUILDING_HISTOIRE',			'BUILDING_VV_PLANEPTUNE_DUMMY_BUILDING_HISTOIRE'),
			('BUILDINGCLASS_VV_PLANEPTUNE_DUMMY_PUDDING_PUPPET_SCIENCE',	'BUILDING_VV_PLANEPTUNE_DUMMY_PUDDING_PUPPET_SCIENCE'),
			('BUILDINGCLASS_VV_PLANEPTUNE_DUMMY_PUDDING_PUPPET_GOLD',		'BUILDING_VV_PLANEPTUNE_DUMMY_PUDDING_PUPPET_GOLD'),
			('BUILDINGCLASS_VV_PLANEPTUNE_DUMMY_PUDDING_PUPPET_CULTURE',	'BUILDING_VV_PLANEPTUNE_DUMMY_PUDDING_PUPPET_CULTURE'),
			('BUILDINGCLASS_VV_PLANEPTUNE_DUMMY_PUDDING_QUEST_COMPLETE',	'BUILDING_VV_PLANEPTUNE_DUMMY_PUDDING_QUEST_COMPLETE');

INSERT INTO Buildings
			(Type,											BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune,
			Description,							Help)
VALUES		('BUILDING_VV_PLANEPTUNE_DUMMY_BUILDING_NEPTUNE',		'BUILDINGCLASS_VV_PLANEPTUNE_DUMMY_BUILDING_NEPTUNE',
			-1,		-1,			-1,				'TECH_VV_NEPTUNE_DUMMY_ON',		1,				1,
			'TXT_KEY_TRAIT_VV_NEPTUNE_SHORT',		'TXT_KEY_VV_NEPTUNE_DUMMY_EXPLAIN');

INSERT INTO Buildings
			(Type,													BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune,
			Description,							Help)
VALUES		('BUILDING_VV_PLANEPTUNE_DUMMY_BUILDING_PURPLE_HEART',		'BUILDINGCLASS_VV_PLANEPTUNE_DUMMY_BUILDING_PURPLE_HEART',
			-1,		-1,			-1,				'TECH_VV_NEPTUNE_DUMMY_OFF',		1,				1,
			'TXT_KEY_TRAIT_VV_PURPLE_HEART_SHORT',	'TXT_KEY_VV_NEPTUNE_DUMMY_EXPLAIN');
			
INSERT INTO Buildings
			(Type,													BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune,
			CultureRateModifier)
VALUES		('BUILDING_VV_PLANEPTUNE_DUMMY_BUILDING_PURPLE_HEART_UA',	'BUILDINGCLASS_VV_PLANEPTUNE_DUMMY_BUILDING_PURPLE_HEART_UA',
			-1,		-1,			-1,				null,		1,				1,
			1);
			
INSERT INTO Buildings
			(Type,													BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune)
VALUES		('BUILDING_VV_PLANEPTUNE_DUMMY_PUDDING_PUPPET_SCIENCE',	'BUILDINGCLASS_VV_PLANEPTUNE_DUMMY_PUDDING_PUPPET_SCIENCE',
			-1,		-1,			-1,				null,		1,				1);
			
INSERT INTO Buildings
			(Type,													BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune)
VALUES		('BUILDING_VV_PLANEPTUNE_DUMMY_PUDDING_PUPPET_GOLD',	'BUILDINGCLASS_VV_PLANEPTUNE_DUMMY_PUDDING_PUPPET_GOLD',
			-1,		-1,			-1,				null,		1,				1);

INSERT INTO Buildings
			(Type,													BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune,
			CultureRateModifier)
VALUES		('BUILDING_VV_PLANEPTUNE_DUMMY_PUDDING_PUPPET_CULTURE',	'BUILDINGCLASS_VV_PLANEPTUNE_DUMMY_PUDDING_PUPPET_CULTURE',
			-1,		-1,			-1,				null,		1,				1,
			1);

INSERT INTO Buildings
			(Type,												BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune)
VALUES		('BUILDING_VV_PLANEPTUNE_DUMMY_BUILDING_HISTOIRE',	'BUILDINGCLASS_VV_PLANEPTUNE_DUMMY_BUILDING_HISTOIRE',
			-1,		-1,			-1,				null,		1,				1);

INSERT INTO Buildings
			(Type,												BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune)
VALUES		('BUILDING_VV_PLANEPTUNE_DUMMY_PUDDING_QUEST_COMPLETE',	'BUILDINGCLASS_VV_PLANEPTUNE_DUMMY_PUDDING_QUEST_COMPLETE',
			-1,		-1,			-1,				null,		1,				1);


INSERT INTO Building_ResourceYieldChanges
			(BuildingType,											ResourceType,		YieldType,	  Yield)
VALUES		('BUILDING_VV_PLANEPTUNE_DUMMY_BUILDING_PURPLE_HEART',	'RESOURCE_SHEEP',	'YIELD_FOOD', 1),
			('BUILDING_VV_PLANEPTUNE_DUMMY_BUILDING_PURPLE_HEART',	'RESOURCE_COW',		'YIELD_FOOD', 1),
			('BUILDING_VV_PLANEPTUNE_DUMMY_BUILDING_PURPLE_HEART',	'RESOURCE_HORSE',	'YIELD_FOOD', 1),
			('BUILDING_VV_PLANEPTUNE_DUMMY_BUILDING_NEPTUNE',		'RESOURCE_SHEEP',	'YIELD_FAITH', 1),
			('BUILDING_VV_PLANEPTUNE_DUMMY_BUILDING_NEPTUNE',		'RESOURCE_COW',		'YIELD_FAITH', 1),
			('BUILDING_VV_PLANEPTUNE_DUMMY_BUILDING_NEPTUNE',		'RESOURCE_HORSE',	'YIELD_FAITH', 1); 


-- I'm pretty sure this doesn't even work.
/*INSERT INTO Building_ResourceFaithChanges
			(BuildingType,										ResourceType,		FaithChange)
VALUES		('BUILDING_VV_PLANEPTUNE_DUMMY_BUILDING_NEPTUNE',	'RESOURCE_SHEEP',	1),
			('BUILDING_VV_PLANEPTUNE_DUMMY_BUILDING_NEPTUNE',	'RESOURCE_COW',		1),
			('BUILDING_VV_PLANEPTUNE_DUMMY_BUILDING_NEPTUNE',	'RESOURCE_HORSE',	1); */
			 

INSERT INTO Building_YieldModifiers
			(BuildingType,												YieldType,			Yield)
VALUES		('BUILDING_VV_PLANEPTUNE_DUMMY_BUILDING_PURPLE_HEART_UA',	'YIELD_SCIENCE',	1),
			('BUILDING_VV_PLANEPTUNE_DUMMY_BUILDING_PURPLE_HEART_UA',	'YIELD_FOOD',		1),
			('BUILDING_VV_PLANEPTUNE_DUMMY_BUILDING_PURPLE_HEART_UA',	'YIELD_PRODUCTION',	1),
			('BUILDING_VV_PLANEPTUNE_DUMMY_BUILDING_PURPLE_HEART_UA',	'YIELD_GOLD',		1),
			('BUILDING_VV_PLANEPTUNE_DUMMY_PUDDING_PUPPET_SCIENCE',		'YIELD_SCIENCE',	1),
			('BUILDING_VV_PLANEPTUNE_DUMMY_PUDDING_PUPPET_GOLD',		'YIELD_GOLD',		1),
			('BUILDING_VV_PLANEPTUNE_DUMMY_BUILDING_HISTOIRE',			'YIELD_PRODUCTION',	100);

INSERT INTO Building_BuildingClassYieldChanges
			(BuildingType,											BuildingClassType,		YieldType,			YieldChange)
VALUES		('BUILDING_VV_PLANEPTUNE_DUMMY_PUDDING_QUEST_COMPLETE',	'BUILDINGCLASS_STABLE',	'YIELD_FOOD',		1),
			('BUILDING_VV_PLANEPTUNE_DUMMY_PUDDING_QUEST_COMPLETE',	'BUILDINGCLASS_STABLE',	'YIELD_GOLD',		1),
			('BUILDING_VV_PLANEPTUNE_DUMMY_PUDDING_QUEST_COMPLETE',	'BUILDINGCLASS_STABLE',	'YIELD_SCIENCE',	1),
			('BUILDING_VV_PLANEPTUNE_DUMMY_PUDDING_QUEST_COMPLETE',	'BUILDINGCLASS_STABLE',	'YIELD_PRODUCTION',	1),
			('BUILDING_VV_PLANEPTUNE_DUMMY_PUDDING_QUEST_COMPLETE',	'BUILDINGCLASS_STABLE',	'YIELD_CULTURE',	1),
			('BUILDING_VV_PLANEPTUNE_DUMMY_PUDDING_QUEST_COMPLETE',	'BUILDINGCLASS_STABLE',	'YIELD_FAITH',		1);


--------------------------------------------------------------------------------------------------------------------------------------------------------
-------RESOURCES
--------------------------------------------------------------------------------------------------------------------------------------------------------


INSERT INTO Resources 
			(Type,							Description,								Civilopedia, 									ResourceClassType,
			Happiness,  AITradeModifier, 	ResourceUsage,	AIObjective,	'Unique', 	IconString, 				PortraitIndex, 		IconAtlas)
VALUES		('RESOURCE_VV_VANILLA_PUDDING',	'TXT_KEY_RESOURCE_VV_VANILLA_PUDDING',		'TXT_KEY_RESOURCE_VV_VANILLA_PUDDING_TEXT',		'RESOURCECLASS_LUXURY',
			4,			10,					2, 				0, 				2, 			'[ICON_RES_VV_VANILLA]',	8, 					'CIV_COLOR_ATLAS_VV_PLANEPTUNE'),
			('RESOURCE_VV_CHOCOLATE_PUDDING','TXT_KEY_RESOURCE_VV_CHOCOLATE_PUDDING',	'TXT_KEY_RESOURCE_VV_CHOCOLATE_PUDDING_TEXT',	'RESOURCECLASS_LUXURY',
			4,			10,					2, 				0, 				2, 			'[ICON_RES_VV_CHOCOLATE]',	9, 					'CIV_COLOR_ATLAS_VV_PLANEPTUNE'),
			('RESOURCE_VV_STRAWBERRY_PUDDING','TXT_KEY_RESOURCE_VV_STRAWBERRY_PUDDING',	'TXT_KEY_RESOURCE_VV_STRAWBERRY_PUDDING_TEXT',	'RESOURCECLASS_LUXURY',
			4,			10,					2, 				0, 				2, 			'[ICON_RES_VV_STRAWBERRY]',	10, 				'CIV_COLOR_ATLAS_VV_PLANEPTUNE'),
			('RESOURCE_VV_BANANA_PUDDING',	'TXT_KEY_RESOURCE_VV_BANANA_PUDDING',		'TXT_KEY_RESOURCE_VV_BANANA_PUDDING_TEXT',		'RESOURCECLASS_LUXURY',
			4,			10,					2, 				0, 				2, 			'[ICON_RES_VV_BANANA]',		11, 				'CIV_COLOR_ATLAS_VV_PLANEPTUNE'),
			('RESOURCE_VV_CARAMEL_PUDDING',	'TXT_KEY_RESOURCE_VV_CARAMEL_PUDDING',		'TXT_KEY_RESOURCE_VV_CARAMEL_PUDDING_TEXT',		'RESOURCECLASS_LUXURY',
			4,			10,					2, 				0, 				2, 			'[ICON_RES_VV_CARAMEL]',	12, 				'CIV_COLOR_ATLAS_VV_PLANEPTUNE'),
			('RESOURCE_VV_BERRY_PUDDING',	'TXT_KEY_RESOURCE_VV_BERRY_PUDDING',		'TXT_KEY_RESOURCE_VV_BERRY_PUDDING_TEXT',		'RESOURCECLASS_LUXURY',
			4,			10,					2, 				0, 				2, 			'[ICON_RES_VV_BERRY]',		13, 				'CIV_COLOR_ATLAS_VV_PLANEPTUNE'),
			('RESOURCE_VV_MINT_PUDDING',	'TXT_KEY_RESOURCE_VV_MINT_PUDDING',			'TXT_KEY_RESOURCE_VV_MINT_PUDDING_TEXT',		'RESOURCECLASS_LUXURY',
			4,			10,					2, 				0, 				2, 			'[ICON_RES_VV_MINT]',		14, 				'CIV_COLOR_ATLAS_VV_PLANEPTUNE'),
			('RESOURCE_VV_CAKE_PUDDING',	'TXT_KEY_RESOURCE_VV_CAKE_PUDDING',			'TXT_KEY_RESOURCE_VV_CAKE_PUDDING_TEXT',		'RESOURCECLASS_LUXURY',
			4,			10,					2, 				0, 				2, 			'[ICON_RES_VV_CAKE]',		15, 				'CIV_COLOR_ATLAS_VV_PLANEPTUNE');