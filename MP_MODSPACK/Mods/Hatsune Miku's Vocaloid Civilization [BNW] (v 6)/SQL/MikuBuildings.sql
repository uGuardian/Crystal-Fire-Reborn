--Dummies
INSERT INTO BuildingClasses
			(Type,										DefaultBuilding, 				NoLimit)
VALUES		('BUILDINGCLASS_VOCALOID_SCIENCE', 			'BUILDING_VOCALOID_SCIENCE', 	1),
			('BUILDINGCLASS_SOFARM_CIVILOPEDIA_DUMMY',	null,							0),
			('BUILDINGCLASS_MIKU_MUSICIAN_BONUS', 		'BUILDING_MIKU_MUSICIAN_BONUS', 1);


INSERT INTO Buildings
			(Type,								BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune)
VALUES		('BUILDING_VOCALOID_SCIENCE',		'BUILDINGCLASS_VOCALOID_SCIENCE',
			-1,		-1,			-1,				'NULL',		1,				1),
			('BUILDING_SOFARM_CIVILOPEDIA_DUMMY','BUILDINGCLASS_SOFARM_CIVILOPEDIA_DUMMY',
			-1,		-1,			-1,				'NULL',		1,				1),
			('BUILDING_MIKU_MUSICIAN_BONUS',	'BUILDINGCLASS_MIKU_MUSICIAN_BONUS',
			-1,		-1,			-1,				'NULL',		1,				1);

UPDATE Buildings
SET Help = 'TXT_KEY_BUILDING_SOFARM_CIVILOPEDIA_DUMMY_HELP', Description = 'TXT_KEY_BUILDING_SOFARM_CIVILOPEDIA_DUMMY', Civilopedia = 'TXT_KEY_CIV5_BUILDINGS_SOFARM_CIVILOPEDIA_DUMMY_TEXT',
Strategy = 'TXT_KEY_BUILDING_SOFARM_CIVILOPEDIA_DUMMY_STRATEGY', PortraitIndex = 3, IconAtlas = 'CIV_COLOR_ATLAS_MIKU'
WHERE Type = 'BUILDING_SOFARM_CIVILOPEDIA_DUMMY';

INSERT INTO Building_YieldChanges
			(BuildingType,					YieldType,			Yield)
VALUES		('BUILDING_VOCALOID_SCIENCE',	'YIELD_SCIENCE',	1);

INSERT INTO Building_SpecialistYieldChanges
			(BuildingType,					SpecialistType,			YieldType,		Yield)
VALUES		('BUILDING_MIKU_MUSICIAN_BONUS','SPECIALIST_MUSICIAN',	'YIELD_SCIENCE',1),
			('BUILDING_MIKU_MUSICIAN_BONUS','SPECIALIST_MUSICIAN',	'YIELD_GOLD',	1);

--*********************************************************************************
--Buildings
--*********************************************************************************

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
SELECT		('BUILDING_CIRCUS_MAXIMUS_VOCALOID'), Description, Civilopedia, Strategy, Help,
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
FROM Buildings WHERE (Type = 'BUILDING_CIRCUS_MAXIMUS');



--*********************************************************************************
--Building_AreaYieldModifiers
--*********************************************************************************
INSERT INTO Building_AreaYieldModifiers
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_CIRCUS_MAXIMUS_VOCALOID'), YieldType, Yield
FROM Building_AreaYieldModifiers WHERE (BuildingType = 'BUILDING_CIRCUS_MAXIMUS');


--*********************************************************************************
--Building_BuildingClassHappiness
--*********************************************************************************
INSERT INTO Building_BuildingClassHappiness
			(BuildingType, BuildingClassType, Happiness)
SELECT		('BUILDING_CIRCUS_MAXIMUS_VOCALOID'), BuildingClassType, Happiness
FROM Building_BuildingClassHappiness WHERE (BuildingType = 'BUILDING_CIRCUS_MAXIMUS');

--*********************************************************************************
--Building_BuildingClassYieldChanges
--*********************************************************************************
INSERT INTO Building_BuildingClassYieldChanges
			(BuildingType, BuildingClassType, YieldType, YieldChange)
SELECT		('BUILDING_CIRCUS_MAXIMUS_VOCALOID'), BuildingClassType, YieldType, YieldChange
FROM Building_BuildingClassYieldChanges WHERE (BuildingType = 'BUILDING_CIRCUS_MAXIMUS');

--*********************************************************************************
--Building_ClassesNeededInCity
--*********************************************************************************
INSERT INTO Building_ClassesNeededInCity
			(BuildingType, BuildingClassType)
SELECT		('BUILDING_CIRCUS_MAXIMUS_VOCALOID'), BuildingClassType
FROM Building_ClassesNeededInCity WHERE (BuildingType = 'BUILDING_CIRCUS_MAXIMUS');

--*********************************************************************************
--Building_FreeUnits
--*********************************************************************************
INSERT INTO Building_FreeUnits
			(BuildingType, UnitType, NumUnits)
SELECT		('BUILDING_CIRCUS_MAXIMUS_VOCALOID'), UnitType, NumUnits
FROM Building_FreeUnits WHERE (BuildingType = 'BUILDING_CIRCUS_MAXIMUS');

--*********************************************************************************
--Building_DomainFreeExperiences
--*********************************************************************************
INSERT INTO Building_DomainFreeExperiences
			(BuildingType, DomainType, Experience)
SELECT		('BUILDING_CIRCUS_MAXIMUS_VOCALOID'), DomainType, Experience
FROM Building_DomainFreeExperiences WHERE (BuildingType = 'BUILDING_CIRCUS_MAXIMUS');

--*********************************************************************************
--Building_DomainFreeExperiencePerGreatWork
--*********************************************************************************
INSERT INTO Building_DomainFreeExperiencePerGreatWork
			(BuildingType, DomainType, Experience)
SELECT		('BUILDING_CIRCUS_MAXIMUS_VOCALOID'), DomainType, Experience
FROM Building_DomainFreeExperiencePerGreatWork WHERE (BuildingType = 'BUILDING_CIRCUS_MAXIMUS');

--*********************************************************************************
--Building_DomainProductionModifiers
--*********************************************************************************
INSERT INTO Building_DomainProductionModifiers
			(BuildingType, DomainType, Modifier)
SELECT		('BUILDING_CIRCUS_MAXIMUS_VOCALOID'), DomainType, Modifier
FROM Building_DomainProductionModifiers WHERE (BuildingType = 'BUILDING_CIRCUS_MAXIMUS');

--*********************************************************************************
--Building_FreeSpecialistCounts
--*********************************************************************************
INSERT INTO Building_FreeSpecialistCounts
			(BuildingType, SpecialistType, Count)
SELECT		('BUILDING_CIRCUS_MAXIMUS_VOCALOID'), SpecialistType, Count
FROM Building_FreeSpecialistCounts WHERE (BuildingType = 'BUILDING_CIRCUS_MAXIMUS');

--*********************************************************************************
--Building_Flavors
--*********************************************************************************
INSERT INTO Building_Flavors
			(BuildingType, FlavorType, Flavor)
SELECT		('BUILDING_CIRCUS_MAXIMUS_VOCALOID'), FlavorType, Flavor+5
FROM Building_Flavors WHERE (BuildingType = 'BUILDING_CIRCUS_MAXIMUS');

INSERT INTO Building_Flavors
VALUES		('BUILDING_CIRCUS_MAXIMUS_VOCALOID', 'FLAVOR_AIRLIFT', 10);

--*********************************************************************************
--Building_GlobalYieldModifiers
--*********************************************************************************
INSERT INTO Building_GlobalYieldModifiers
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_CIRCUS_MAXIMUS_VOCALOID'), YieldType, Yield
FROM Building_GlobalYieldModifiers WHERE (BuildingType = 'BUILDING_CIRCUS_MAXIMUS');

--*********************************************************************************
--Building_HurryModifiers
--*********************************************************************************
INSERT INTO Building_HurryModifiers
			(BuildingType, HurryType, HurryCostModifier)
SELECT		('BUILDING_CIRCUS_MAXIMUS_VOCALOID'), HurryType, HurryCostModifier
FROM Building_HurryModifiers WHERE (BuildingType = 'BUILDING_CIRCUS_MAXIMUS');

--*********************************************************************************
--Building_LocalResourceAnds
--*********************************************************************************
INSERT INTO Building_LocalResourceAnds
			(BuildingType, ResourceType)
SELECT		('BUILDING_CIRCUS_MAXIMUS_VOCALOID'), ResourceType
FROM Building_LocalResourceAnds WHERE (BuildingType = 'BUILDING_CIRCUS_MAXIMUS');

--*********************************************************************************
--Building_LocalResourceOrs
--*********************************************************************************
INSERT INTO Building_LocalResourceOrs
			(BuildingType, ResourceType)
SELECT		('BUILDING_CIRCUS_MAXIMUS_VOCALOID'), ResourceType
FROM Building_LocalResourceOrs WHERE (BuildingType = 'BUILDING_CIRCUS_MAXIMUS');

--*********************************************************************************
--Building_LockedBuildingClasses
--*********************************************************************************
INSERT INTO Building_LockedBuildingClasses
			(BuildingType, BuildingClassType)
SELECT		('BUILDING_CIRCUS_MAXIMUS_VOCALOID'), BuildingClassType
FROM Building_LockedBuildingClasses WHERE (BuildingType = 'BUILDING_CIRCUS_MAXIMUS');

--*********************************************************************************
--Building_PrereqBuildingClasses
--*********************************************************************************
INSERT INTO Building_PrereqBuildingClasses
			(BuildingType, BuildingClassType, NumBuildingNeeded)
SELECT		('BUILDING_CIRCUS_MAXIMUS_VOCALOID'), BuildingClassType, NumBuildingNeeded
FROM Building_PrereqBuildingClasses WHERE (BuildingType = 'BUILDING_CIRCUS_MAXIMUS');

--*********************************************************************************
--Building_ResourceQuantity
--*********************************************************************************
INSERT INTO Building_ResourceQuantity
			(BuildingType, ResourceType, Quantity)
SELECT		('BUILDING_CIRCUS_MAXIMUS_VOCALOID'), ResourceType, Quantity
FROM Building_ResourceQuantity WHERE (BuildingType = 'BUILDING_CIRCUS_MAXIMUS');

--*********************************************************************************
--Building_ResourceQuantityRequirements
--*********************************************************************************
INSERT INTO Building_ResourceQuantityRequirements
			(BuildingType, ResourceType, Cost)
SELECT		('BUILDING_CIRCUS_MAXIMUS_VOCALOID'), ResourceType, Cost
FROM Building_ResourceQuantityRequirements WHERE (BuildingType = 'BUILDING_CIRCUS_MAXIMUS');

--*********************************************************************************
--Building_ResourceYieldModifiers
--*********************************************************************************
INSERT INTO Building_ResourceYieldModifiers
			(BuildingType, ResourceType, YieldType, Yield)
SELECT		('BUILDING_CIRCUS_MAXIMUS_VOCALOID'), ResourceType, YieldType, Yield
FROM Building_ResourceYieldModifiers WHERE (BuildingType = 'BUILDING_CIRCUS_MAXIMUS');

--*********************************************************************************
--Building_ResourceCultureChanges
--*********************************************************************************
INSERT INTO Building_ResourceCultureChanges
			(BuildingType, ResourceType, CultureChange)
SELECT		('BUILDING_CIRCUS_MAXIMUS_VOCALOID'), ResourceType, CultureChange
FROM Building_ResourceCultureChanges WHERE (BuildingType = 'BUILDING_CIRCUS_MAXIMUS');

--*********************************************************************************
--Building_ResourceFaithChanges
--*********************************************************************************
INSERT INTO Building_ResourceFaithChanges
			(BuildingType, ResourceType, FaithChange)
SELECT		('BUILDING_CIRCUS_MAXIMUS_VOCALOID'), ResourceType, FaithChange
FROM Building_ResourceFaithChanges WHERE (BuildingType = 'BUILDING_CIRCUS_MAXIMUS');

--*********************************************************************************
--Building_RiverPlotYieldChanges
--*********************************************************************************
INSERT INTO Building_RiverPlotYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_CIRCUS_MAXIMUS_VOCALOID'), YieldType, Yield
FROM Building_RiverPlotYieldChanges WHERE (BuildingType = 'BUILDING_CIRCUS_MAXIMUS');

--*********************************************************************************
--Building_SeaPlotYieldChanges
--*********************************************************************************
INSERT INTO Building_SeaPlotYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_CIRCUS_MAXIMUS_VOCALOID'), YieldType, Yield
FROM Building_SeaPlotYieldChanges WHERE (BuildingType = 'BUILDING_CIRCUS_MAXIMUS');

--*********************************************************************************
--Building_LakePlotYieldChanges
--*********************************************************************************
INSERT INTO Building_LakePlotYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_CIRCUS_MAXIMUS_VOCALOID'), YieldType, Yield
FROM Building_LakePlotYieldChanges WHERE (BuildingType = 'BUILDING_CIRCUS_MAXIMUS');

--*********************************************************************************
--Building_SeaResourceYieldChanges
--*********************************************************************************
INSERT INTO Building_SeaResourceYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_CIRCUS_MAXIMUS_VOCALOID'), YieldType, Yield
FROM Building_SeaResourceYieldChanges WHERE (BuildingType = 'BUILDING_CIRCUS_MAXIMUS');

--*********************************************************************************
--Building_ResourceYieldChanges
--*********************************************************************************
INSERT INTO Building_ResourceYieldChanges
			(BuildingType, ResourceType, YieldType, Yield)
SELECT		('BUILDING_CIRCUS_MAXIMUS_VOCALOID'), ResourceType, YieldType, Yield
FROM Building_ResourceYieldChanges WHERE (BuildingType = 'BUILDING_CIRCUS_MAXIMUS');

--*********************************************************************************
--Building_FeatureYieldChanges
--*********************************************************************************
INSERT INTO Building_FeatureYieldChanges
			(BuildingType, FeatureType, YieldType, Yield)
SELECT		('BUILDING_CIRCUS_MAXIMUS_VOCALOID'), FeatureType, YieldType, Yield
FROM Building_FeatureYieldChanges WHERE (BuildingType = 'BUILDING_CIRCUS_MAXIMUS');

--*********************************************************************************
--Building_TerrainYieldChanges
--*********************************************************************************
INSERT INTO Building_TerrainYieldChanges
			(BuildingType, TerrainType, YieldType, Yield)
SELECT		('BUILDING_CIRCUS_MAXIMUS_VOCALOID'), TerrainType, YieldType, Yield
FROM Building_TerrainYieldChanges WHERE (BuildingType = 'BUILDING_CIRCUS_MAXIMUS');

--*********************************************************************************
--Building_SpecialistYieldChanges
--*********************************************************************************
INSERT INTO Building_SpecialistYieldChanges
			(BuildingType, SpecialistType, YieldType, Yield)
SELECT		('BUILDING_CIRCUS_MAXIMUS_VOCALOID'), SpecialistType, YieldType, Yield
FROM Building_SpecialistYieldChanges WHERE (BuildingType = 'BUILDING_CIRCUS_MAXIMUS');


--*********************************************************************************
--Building_UnitCombatFreeExperiences
--*********************************************************************************
INSERT INTO Building_UnitCombatFreeExperiences
			(BuildingType, UnitCombatType, Experience)
SELECT		('BUILDING_CIRCUS_MAXIMUS_VOCALOID'), UnitCombatType, Experience
FROM Building_UnitCombatFreeExperiences WHERE (BuildingType = 'BUILDING_CIRCUS_MAXIMUS');

--*********************************************************************************
--Building_UnitCombatProductionModifiers
--*********************************************************************************
INSERT INTO Building_UnitCombatProductionModifiers
			(BuildingType, UnitCombatType, Modifier)
SELECT		('BUILDING_CIRCUS_MAXIMUS_VOCALOID'), UnitCombatType, Modifier
FROM Building_UnitCombatProductionModifiers WHERE (BuildingType = 'BUILDING_CIRCUS_MAXIMUS');

--*********************************************************************************
--Building_TechAndPrereqs
--*********************************************************************************
INSERT INTO Building_TechAndPrereqs
			(BuildingType, TechType)
SELECT		('BUILDING_CIRCUS_MAXIMUS_VOCALOID'), TechType
FROM Building_TechAndPrereqs WHERE (BuildingType = 'BUILDING_CIRCUS_MAXIMUS');

--*********************************************************************************
--Building_YieldChanges
--*********************************************************************************
INSERT INTO Building_YieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_CIRCUS_MAXIMUS_VOCALOID'), YieldType, Yield
FROM Building_YieldChanges WHERE (BuildingType = 'BUILDING_CIRCUS_MAXIMUS');

--*********************************************************************************
--Building_YieldChangesPerPop
--*********************************************************************************
INSERT INTO Building_YieldChangesPerPop
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_CIRCUS_MAXIMUS_VOCALOID'), YieldType, Yield
FROM Building_YieldChangesPerPop WHERE (BuildingType = 'BUILDING_CIRCUS_MAXIMUS');

--*********************************************************************************
--Building_YieldChangesPerReligion
--*********************************************************************************
INSERT INTO Building_YieldChangesPerReligion
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_CIRCUS_MAXIMUS_VOCALOID'), YieldType, Yield
FROM Building_YieldChangesPerReligion WHERE (BuildingType = 'BUILDING_CIRCUS_MAXIMUS');

--*********************************************************************************
--Building_TechEnhancedYieldChanges
--*********************************************************************************
INSERT INTO Building_TechEnhancedYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_CIRCUS_MAXIMUS_VOCALOID'), YieldType, Yield
FROM Building_TechEnhancedYieldChanges WHERE (BuildingType = 'BUILDING_CIRCUS_MAXIMUS');


--*********************************************************************************
--Building_YieldModifiers
--*********************************************************************************
INSERT INTO Building_YieldModifiers
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_CIRCUS_MAXIMUS_VOCALOID'), YieldType, Yield
FROM Building_YieldModifiers WHERE (BuildingType = 'BUILDING_CIRCUS_MAXIMUS');




--*********************************************************************************
--Buildings
--*********************************************************************************

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
SELECT		('BUILDING_NATIONAL_TREASURY_VOCALOID'), Description, Civilopedia, Strategy, Help,
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
FROM Buildings WHERE (Type = 'BUILDING_NATIONAL_TREASURY');



--*********************************************************************************
--Building_AreaYieldModifiers
--*********************************************************************************
INSERT INTO Building_AreaYieldModifiers
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_NATIONAL_TREASURY_VOCALOID'), YieldType, Yield
FROM Building_AreaYieldModifiers WHERE (BuildingType = 'BUILDING_NATIONAL_TREASURY');


--*********************************************************************************
--Building_BuildingClassHappiness
--*********************************************************************************
INSERT INTO Building_BuildingClassHappiness
			(BuildingType, BuildingClassType, Happiness)
SELECT		('BUILDING_NATIONAL_TREASURY_VOCALOID'), BuildingClassType, Happiness
FROM Building_BuildingClassHappiness WHERE (BuildingType = 'BUILDING_NATIONAL_TREASURY');

--*********************************************************************************
--Building_BuildingClassYieldChanges
--*********************************************************************************
INSERT INTO Building_BuildingClassYieldChanges
			(BuildingType, BuildingClassType, YieldType, YieldChange)
SELECT		('BUILDING_NATIONAL_TREASURY_VOCALOID'), BuildingClassType, YieldType, YieldChange
FROM Building_BuildingClassYieldChanges WHERE (BuildingType = 'BUILDING_NATIONAL_TREASURY');

--*********************************************************************************
--Building_ClassesNeededInCity
--*********************************************************************************
INSERT INTO Building_ClassesNeededInCity
			(BuildingType, BuildingClassType)
SELECT		('BUILDING_NATIONAL_TREASURY_VOCALOID'), BuildingClassType
FROM Building_ClassesNeededInCity WHERE (BuildingType = 'BUILDING_NATIONAL_TREASURY');

--*********************************************************************************
--Building_FreeUnits
--*********************************************************************************
INSERT INTO Building_FreeUnits
			(BuildingType, UnitType, NumUnits)
SELECT		('BUILDING_NATIONAL_TREASURY_VOCALOID'), UnitType, NumUnits
FROM Building_FreeUnits WHERE (BuildingType = 'BUILDING_NATIONAL_TREASURY');

--*********************************************************************************
--Building_DomainFreeExperiences
--*********************************************************************************
INSERT INTO Building_DomainFreeExperiences
			(BuildingType, DomainType, Experience)
SELECT		('BUILDING_NATIONAL_TREASURY_VOCALOID'), DomainType, Experience
FROM Building_DomainFreeExperiences WHERE (BuildingType = 'BUILDING_NATIONAL_TREASURY');

--*********************************************************************************
--Building_DomainFreeExperiencePerGreatWork
--*********************************************************************************
INSERT INTO Building_DomainFreeExperiencePerGreatWork
			(BuildingType, DomainType, Experience)
SELECT		('BUILDING_NATIONAL_TREASURY_VOCALOID'), DomainType, Experience
FROM Building_DomainFreeExperiencePerGreatWork WHERE (BuildingType = 'BUILDING_NATIONAL_TREASURY');

--*********************************************************************************
--Building_DomainProductionModifiers
--*********************************************************************************
INSERT INTO Building_DomainProductionModifiers
			(BuildingType, DomainType, Modifier)
SELECT		('BUILDING_NATIONAL_TREASURY_VOCALOID'), DomainType, Modifier
FROM Building_DomainProductionModifiers WHERE (BuildingType = 'BUILDING_NATIONAL_TREASURY');

--*********************************************************************************
--Building_FreeSpecialistCounts
--*********************************************************************************
INSERT INTO Building_FreeSpecialistCounts
			(BuildingType, SpecialistType, Count)
SELECT		('BUILDING_NATIONAL_TREASURY_VOCALOID'), SpecialistType, Count
FROM Building_FreeSpecialistCounts WHERE (BuildingType = 'BUILDING_NATIONAL_TREASURY');

--*********************************************************************************
--Building_Flavors
--*********************************************************************************
INSERT INTO Building_Flavors
			(BuildingType, FlavorType, Flavor)
SELECT		('BUILDING_NATIONAL_TREASURY_VOCALOID'), FlavorType, Flavor+5
FROM Building_Flavors WHERE (BuildingType = 'BUILDING_NATIONAL_TREASURY');

INSERT INTO Building_Flavors
VALUES		('BUILDING_NATIONAL_TREASURY_VOCALOID', 'FLAVOR_AIRLIFT', 10);

--*********************************************************************************
--Building_GlobalYieldModifiers
--*********************************************************************************
INSERT INTO Building_GlobalYieldModifiers
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_NATIONAL_TREASURY_VOCALOID'), YieldType, Yield
FROM Building_GlobalYieldModifiers WHERE (BuildingType = 'BUILDING_NATIONAL_TREASURY');

--*********************************************************************************
--Building_HurryModifiers
--*********************************************************************************
INSERT INTO Building_HurryModifiers
			(BuildingType, HurryType, HurryCostModifier)
SELECT		('BUILDING_NATIONAL_TREASURY_VOCALOID'), HurryType, HurryCostModifier
FROM Building_HurryModifiers WHERE (BuildingType = 'BUILDING_NATIONAL_TREASURY');

--*********************************************************************************
--Building_LocalResourceAnds
--*********************************************************************************
INSERT INTO Building_LocalResourceAnds
			(BuildingType, ResourceType)
SELECT		('BUILDING_NATIONAL_TREASURY_VOCALOID'), ResourceType
FROM Building_LocalResourceAnds WHERE (BuildingType = 'BUILDING_NATIONAL_TREASURY');

--*********************************************************************************
--Building_LocalResourceOrs
--*********************************************************************************
INSERT INTO Building_LocalResourceOrs
			(BuildingType, ResourceType)
SELECT		('BUILDING_NATIONAL_TREASURY_VOCALOID'), ResourceType
FROM Building_LocalResourceOrs WHERE (BuildingType = 'BUILDING_NATIONAL_TREASURY');

--*********************************************************************************
--Building_LockedBuildingClasses
--*********************************************************************************
INSERT INTO Building_LockedBuildingClasses
			(BuildingType, BuildingClassType)
SELECT		('BUILDING_NATIONAL_TREASURY_VOCALOID'), BuildingClassType
FROM Building_LockedBuildingClasses WHERE (BuildingType = 'BUILDING_NATIONAL_TREASURY');

--*********************************************************************************
--Building_PrereqBuildingClasses
--*********************************************************************************
INSERT INTO Building_PrereqBuildingClasses
			(BuildingType, BuildingClassType, NumBuildingNeeded)
SELECT		('BUILDING_NATIONAL_TREASURY_VOCALOID'), BuildingClassType, NumBuildingNeeded
FROM Building_PrereqBuildingClasses WHERE (BuildingType = 'BUILDING_NATIONAL_TREASURY');

--*********************************************************************************
--Building_ResourceQuantity
--*********************************************************************************
INSERT INTO Building_ResourceQuantity
			(BuildingType, ResourceType, Quantity)
SELECT		('BUILDING_NATIONAL_TREASURY_VOCALOID'), ResourceType, Quantity
FROM Building_ResourceQuantity WHERE (BuildingType = 'BUILDING_NATIONAL_TREASURY');

--*********************************************************************************
--Building_ResourceQuantityRequirements
--*********************************************************************************
INSERT INTO Building_ResourceQuantityRequirements
			(BuildingType, ResourceType, Cost)
SELECT		('BUILDING_NATIONAL_TREASURY_VOCALOID'), ResourceType, Cost
FROM Building_ResourceQuantityRequirements WHERE (BuildingType = 'BUILDING_NATIONAL_TREASURY');

--*********************************************************************************
--Building_ResourceYieldModifiers
--*********************************************************************************
INSERT INTO Building_ResourceYieldModifiers
			(BuildingType, ResourceType, YieldType, Yield)
SELECT		('BUILDING_NATIONAL_TREASURY_VOCALOID'), ResourceType, YieldType, Yield
FROM Building_ResourceYieldModifiers WHERE (BuildingType = 'BUILDING_NATIONAL_TREASURY');

--*********************************************************************************
--Building_ResourceCultureChanges
--*********************************************************************************
INSERT INTO Building_ResourceCultureChanges
			(BuildingType, ResourceType, CultureChange)
SELECT		('BUILDING_NATIONAL_TREASURY_VOCALOID'), ResourceType, CultureChange
FROM Building_ResourceCultureChanges WHERE (BuildingType = 'BUILDING_NATIONAL_TREASURY');

--*********************************************************************************
--Building_ResourceFaithChanges
--*********************************************************************************
INSERT INTO Building_ResourceFaithChanges
			(BuildingType, ResourceType, FaithChange)
SELECT		('BUILDING_NATIONAL_TREASURY_VOCALOID'), ResourceType, FaithChange
FROM Building_ResourceFaithChanges WHERE (BuildingType = 'BUILDING_NATIONAL_TREASURY');

--*********************************************************************************
--Building_RiverPlotYieldChanges
--*********************************************************************************
INSERT INTO Building_RiverPlotYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_NATIONAL_TREASURY_VOCALOID'), YieldType, Yield
FROM Building_RiverPlotYieldChanges WHERE (BuildingType = 'BUILDING_NATIONAL_TREASURY');

--*********************************************************************************
--Building_SeaPlotYieldChanges
--*********************************************************************************
INSERT INTO Building_SeaPlotYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_NATIONAL_TREASURY_VOCALOID'), YieldType, Yield
FROM Building_SeaPlotYieldChanges WHERE (BuildingType = 'BUILDING_NATIONAL_TREASURY');

--*********************************************************************************
--Building_LakePlotYieldChanges
--*********************************************************************************
INSERT INTO Building_LakePlotYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_NATIONAL_TREASURY_VOCALOID'), YieldType, Yield
FROM Building_LakePlotYieldChanges WHERE (BuildingType = 'BUILDING_NATIONAL_TREASURY');

--*********************************************************************************
--Building_SeaResourceYieldChanges
--*********************************************************************************
INSERT INTO Building_SeaResourceYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_NATIONAL_TREASURY_VOCALOID'), YieldType, Yield
FROM Building_SeaResourceYieldChanges WHERE (BuildingType = 'BUILDING_NATIONAL_TREASURY');

--*********************************************************************************
--Building_ResourceYieldChanges
--*********************************************************************************
INSERT INTO Building_ResourceYieldChanges
			(BuildingType, ResourceType, YieldType, Yield)
SELECT		('BUILDING_NATIONAL_TREASURY_VOCALOID'), ResourceType, YieldType, Yield
FROM Building_ResourceYieldChanges WHERE (BuildingType = 'BUILDING_NATIONAL_TREASURY');

--*********************************************************************************
--Building_FeatureYieldChanges
--*********************************************************************************
INSERT INTO Building_FeatureYieldChanges
			(BuildingType, FeatureType, YieldType, Yield)
SELECT		('BUILDING_NATIONAL_TREASURY_VOCALOID'), FeatureType, YieldType, Yield
FROM Building_FeatureYieldChanges WHERE (BuildingType = 'BUILDING_NATIONAL_TREASURY');

--*********************************************************************************
--Building_TerrainYieldChanges
--*********************************************************************************
INSERT INTO Building_TerrainYieldChanges
			(BuildingType, TerrainType, YieldType, Yield)
SELECT		('BUILDING_NATIONAL_TREASURY_VOCALOID'), TerrainType, YieldType, Yield
FROM Building_TerrainYieldChanges WHERE (BuildingType = 'BUILDING_NATIONAL_TREASURY');

--*********************************************************************************
--Building_SpecialistYieldChanges
--*********************************************************************************
INSERT INTO Building_SpecialistYieldChanges
			(BuildingType, SpecialistType, YieldType, Yield)
SELECT		('BUILDING_NATIONAL_TREASURY_VOCALOID'), SpecialistType, YieldType, Yield
FROM Building_SpecialistYieldChanges WHERE (BuildingType = 'BUILDING_NATIONAL_TREASURY');


--*********************************************************************************
--Building_UnitCombatFreeExperiences
--*********************************************************************************
INSERT INTO Building_UnitCombatFreeExperiences
			(BuildingType, UnitCombatType, Experience)
SELECT		('BUILDING_NATIONAL_TREASURY_VOCALOID'), UnitCombatType, Experience
FROM Building_UnitCombatFreeExperiences WHERE (BuildingType = 'BUILDING_NATIONAL_TREASURY');

--*********************************************************************************
--Building_UnitCombatProductionModifiers
--*********************************************************************************
INSERT INTO Building_UnitCombatProductionModifiers
			(BuildingType, UnitCombatType, Modifier)
SELECT		('BUILDING_NATIONAL_TREASURY_VOCALOID'), UnitCombatType, Modifier
FROM Building_UnitCombatProductionModifiers WHERE (BuildingType = 'BUILDING_NATIONAL_TREASURY');

--*********************************************************************************
--Building_TechAndPrereqs
--*********************************************************************************
INSERT INTO Building_TechAndPrereqs
			(BuildingType, TechType)
SELECT		('BUILDING_NATIONAL_TREASURY_VOCALOID'), TechType
FROM Building_TechAndPrereqs WHERE (BuildingType = 'BUILDING_NATIONAL_TREASURY');

--*********************************************************************************
--Building_YieldChanges
--*********************************************************************************
INSERT INTO Building_YieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_NATIONAL_TREASURY_VOCALOID'), YieldType, Yield
FROM Building_YieldChanges WHERE (BuildingType = 'BUILDING_NATIONAL_TREASURY');

--*********************************************************************************
--Building_YieldChangesPerPop
--*********************************************************************************
INSERT INTO Building_YieldChangesPerPop
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_NATIONAL_TREASURY_VOCALOID'), YieldType, Yield
FROM Building_YieldChangesPerPop WHERE (BuildingType = 'BUILDING_NATIONAL_TREASURY');

--*********************************************************************************
--Building_YieldChangesPerReligion
--*********************************************************************************
INSERT INTO Building_YieldChangesPerReligion
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_NATIONAL_TREASURY_VOCALOID'), YieldType, Yield
FROM Building_YieldChangesPerReligion WHERE (BuildingType = 'BUILDING_NATIONAL_TREASURY');

--*********************************************************************************
--Building_TechEnhancedYieldChanges
--*********************************************************************************
INSERT INTO Building_TechEnhancedYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_NATIONAL_TREASURY_VOCALOID'), YieldType, Yield
FROM Building_TechEnhancedYieldChanges WHERE (BuildingType = 'BUILDING_NATIONAL_TREASURY');


--*********************************************************************************
--Building_YieldModifiers
--*********************************************************************************
INSERT INTO Building_YieldModifiers
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_NATIONAL_TREASURY_VOCALOID'), YieldType, Yield
FROM Building_YieldModifiers WHERE (BuildingType = 'BUILDING_NATIONAL_TREASURY');




--*********************************************************************************
--Buildings
--*********************************************************************************

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
SELECT		('BUILDING_IRONWORKS_VOCALOID'), Description, Civilopedia, Strategy, Help,
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
FROM Buildings WHERE (Type = 'BUILDING_IRONWORKS');



--*********************************************************************************
--Building_AreaYieldModifiers
--*********************************************************************************
INSERT INTO Building_AreaYieldModifiers
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_IRONWORKS_VOCALOID'), YieldType, Yield
FROM Building_AreaYieldModifiers WHERE (BuildingType = 'BUILDING_IRONWORKS');


--*********************************************************************************
--Building_BuildingClassHappiness
--*********************************************************************************
INSERT INTO Building_BuildingClassHappiness
			(BuildingType, BuildingClassType, Happiness)
SELECT		('BUILDING_IRONWORKS_VOCALOID'), BuildingClassType, Happiness
FROM Building_BuildingClassHappiness WHERE (BuildingType = 'BUILDING_IRONWORKS');

--*********************************************************************************
--Building_BuildingClassYieldChanges
--*********************************************************************************
INSERT INTO Building_BuildingClassYieldChanges
			(BuildingType, BuildingClassType, YieldType, YieldChange)
SELECT		('BUILDING_IRONWORKS_VOCALOID'), BuildingClassType, YieldType, YieldChange
FROM Building_BuildingClassYieldChanges WHERE (BuildingType = 'BUILDING_IRONWORKS');

--*********************************************************************************
--Building_ClassesNeededInCity
--*********************************************************************************
INSERT INTO Building_ClassesNeededInCity
			(BuildingType, BuildingClassType)
SELECT		('BUILDING_IRONWORKS_VOCALOID'), BuildingClassType
FROM Building_ClassesNeededInCity WHERE (BuildingType = 'BUILDING_IRONWORKS');

--*********************************************************************************
--Building_FreeUnits
--*********************************************************************************
INSERT INTO Building_FreeUnits
			(BuildingType, UnitType, NumUnits)
SELECT		('BUILDING_IRONWORKS_VOCALOID'), UnitType, NumUnits
FROM Building_FreeUnits WHERE (BuildingType = 'BUILDING_IRONWORKS');

--*********************************************************************************
--Building_DomainFreeExperiences
--*********************************************************************************
INSERT INTO Building_DomainFreeExperiences
			(BuildingType, DomainType, Experience)
SELECT		('BUILDING_IRONWORKS_VOCALOID'), DomainType, Experience
FROM Building_DomainFreeExperiences WHERE (BuildingType = 'BUILDING_IRONWORKS');

--*********************************************************************************
--Building_DomainFreeExperiencePerGreatWork
--*********************************************************************************
INSERT INTO Building_DomainFreeExperiencePerGreatWork
			(BuildingType, DomainType, Experience)
SELECT		('BUILDING_IRONWORKS_VOCALOID'), DomainType, Experience
FROM Building_DomainFreeExperiencePerGreatWork WHERE (BuildingType = 'BUILDING_IRONWORKS');

--*********************************************************************************
--Building_DomainProductionModifiers
--*********************************************************************************
INSERT INTO Building_DomainProductionModifiers
			(BuildingType, DomainType, Modifier)
SELECT		('BUILDING_IRONWORKS_VOCALOID'), DomainType, Modifier
FROM Building_DomainProductionModifiers WHERE (BuildingType = 'BUILDING_IRONWORKS');

--*********************************************************************************
--Building_FreeSpecialistCounts
--*********************************************************************************
INSERT INTO Building_FreeSpecialistCounts
			(BuildingType, SpecialistType, Count)
SELECT		('BUILDING_IRONWORKS_VOCALOID'), SpecialistType, Count
FROM Building_FreeSpecialistCounts WHERE (BuildingType = 'BUILDING_IRONWORKS');

--*********************************************************************************
--Building_Flavors
--*********************************************************************************
INSERT INTO Building_Flavors
			(BuildingType, FlavorType, Flavor)
SELECT		('BUILDING_IRONWORKS_VOCALOID'), FlavorType, Flavor+5
FROM Building_Flavors WHERE (BuildingType = 'BUILDING_IRONWORKS');

INSERT INTO Building_Flavors
VALUES		('BUILDING_IRONWORKS_VOCALOID', 'FLAVOR_AIRLIFT', 10);

--*********************************************************************************
--Building_GlobalYieldModifiers
--*********************************************************************************
INSERT INTO Building_GlobalYieldModifiers
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_IRONWORKS_VOCALOID'), YieldType, Yield
FROM Building_GlobalYieldModifiers WHERE (BuildingType = 'BUILDING_IRONWORKS');

--*********************************************************************************
--Building_HurryModifiers
--*********************************************************************************
INSERT INTO Building_HurryModifiers
			(BuildingType, HurryType, HurryCostModifier)
SELECT		('BUILDING_IRONWORKS_VOCALOID'), HurryType, HurryCostModifier
FROM Building_HurryModifiers WHERE (BuildingType = 'BUILDING_IRONWORKS');

--*********************************************************************************
--Building_LocalResourceAnds
--*********************************************************************************
INSERT INTO Building_LocalResourceAnds
			(BuildingType, ResourceType)
SELECT		('BUILDING_IRONWORKS_VOCALOID'), ResourceType
FROM Building_LocalResourceAnds WHERE (BuildingType = 'BUILDING_IRONWORKS');

--*********************************************************************************
--Building_LocalResourceOrs
--*********************************************************************************
INSERT INTO Building_LocalResourceOrs
			(BuildingType, ResourceType)
SELECT		('BUILDING_IRONWORKS_VOCALOID'), ResourceType
FROM Building_LocalResourceOrs WHERE (BuildingType = 'BUILDING_IRONWORKS');

--*********************************************************************************
--Building_LockedBuildingClasses
--*********************************************************************************
INSERT INTO Building_LockedBuildingClasses
			(BuildingType, BuildingClassType)
SELECT		('BUILDING_IRONWORKS_VOCALOID'), BuildingClassType
FROM Building_LockedBuildingClasses WHERE (BuildingType = 'BUILDING_IRONWORKS');

--*********************************************************************************
--Building_PrereqBuildingClasses
--*********************************************************************************
INSERT INTO Building_PrereqBuildingClasses
			(BuildingType, BuildingClassType, NumBuildingNeeded)
SELECT		('BUILDING_IRONWORKS_VOCALOID'), BuildingClassType, NumBuildingNeeded
FROM Building_PrereqBuildingClasses WHERE (BuildingType = 'BUILDING_IRONWORKS');

--*********************************************************************************
--Building_ResourceQuantity
--*********************************************************************************
INSERT INTO Building_ResourceQuantity
			(BuildingType, ResourceType, Quantity)
SELECT		('BUILDING_IRONWORKS_VOCALOID'), ResourceType, Quantity
FROM Building_ResourceQuantity WHERE (BuildingType = 'BUILDING_IRONWORKS');

--*********************************************************************************
--Building_ResourceQuantityRequirements
--*********************************************************************************
INSERT INTO Building_ResourceQuantityRequirements
			(BuildingType, ResourceType, Cost)
SELECT		('BUILDING_IRONWORKS_VOCALOID'), ResourceType, Cost
FROM Building_ResourceQuantityRequirements WHERE (BuildingType = 'BUILDING_IRONWORKS');

--*********************************************************************************
--Building_ResourceYieldModifiers
--*********************************************************************************
INSERT INTO Building_ResourceYieldModifiers
			(BuildingType, ResourceType, YieldType, Yield)
SELECT		('BUILDING_IRONWORKS_VOCALOID'), ResourceType, YieldType, Yield
FROM Building_ResourceYieldModifiers WHERE (BuildingType = 'BUILDING_IRONWORKS');

--*********************************************************************************
--Building_ResourceCultureChanges
--*********************************************************************************
INSERT INTO Building_ResourceCultureChanges
			(BuildingType, ResourceType, CultureChange)
SELECT		('BUILDING_IRONWORKS_VOCALOID'), ResourceType, CultureChange
FROM Building_ResourceCultureChanges WHERE (BuildingType = 'BUILDING_IRONWORKS');

--*********************************************************************************
--Building_ResourceFaithChanges
--*********************************************************************************
INSERT INTO Building_ResourceFaithChanges
			(BuildingType, ResourceType, FaithChange)
SELECT		('BUILDING_IRONWORKS_VOCALOID'), ResourceType, FaithChange
FROM Building_ResourceFaithChanges WHERE (BuildingType = 'BUILDING_IRONWORKS');

--*********************************************************************************
--Building_RiverPlotYieldChanges
--*********************************************************************************
INSERT INTO Building_RiverPlotYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_IRONWORKS_VOCALOID'), YieldType, Yield
FROM Building_RiverPlotYieldChanges WHERE (BuildingType = 'BUILDING_IRONWORKS');

--*********************************************************************************
--Building_SeaPlotYieldChanges
--*********************************************************************************
INSERT INTO Building_SeaPlotYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_IRONWORKS_VOCALOID'), YieldType, Yield
FROM Building_SeaPlotYieldChanges WHERE (BuildingType = 'BUILDING_IRONWORKS');

--*********************************************************************************
--Building_LakePlotYieldChanges
--*********************************************************************************
INSERT INTO Building_LakePlotYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_IRONWORKS_VOCALOID'), YieldType, Yield
FROM Building_LakePlotYieldChanges WHERE (BuildingType = 'BUILDING_IRONWORKS');

--*********************************************************************************
--Building_SeaResourceYieldChanges
--*********************************************************************************
INSERT INTO Building_SeaResourceYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_IRONWORKS_VOCALOID'), YieldType, Yield
FROM Building_SeaResourceYieldChanges WHERE (BuildingType = 'BUILDING_IRONWORKS');

--*********************************************************************************
--Building_ResourceYieldChanges
--*********************************************************************************
INSERT INTO Building_ResourceYieldChanges
			(BuildingType, ResourceType, YieldType, Yield)
SELECT		('BUILDING_IRONWORKS_VOCALOID'), ResourceType, YieldType, Yield
FROM Building_ResourceYieldChanges WHERE (BuildingType = 'BUILDING_IRONWORKS');

--*********************************************************************************
--Building_FeatureYieldChanges
--*********************************************************************************
INSERT INTO Building_FeatureYieldChanges
			(BuildingType, FeatureType, YieldType, Yield)
SELECT		('BUILDING_IRONWORKS_VOCALOID'), FeatureType, YieldType, Yield
FROM Building_FeatureYieldChanges WHERE (BuildingType = 'BUILDING_IRONWORKS');

--*********************************************************************************
--Building_TerrainYieldChanges
--*********************************************************************************
INSERT INTO Building_TerrainYieldChanges
			(BuildingType, TerrainType, YieldType, Yield)
SELECT		('BUILDING_IRONWORKS_VOCALOID'), TerrainType, YieldType, Yield
FROM Building_TerrainYieldChanges WHERE (BuildingType = 'BUILDING_IRONWORKS');

--*********************************************************************************
--Building_SpecialistYieldChanges
--*********************************************************************************
INSERT INTO Building_SpecialistYieldChanges
			(BuildingType, SpecialistType, YieldType, Yield)
SELECT		('BUILDING_IRONWORKS_VOCALOID'), SpecialistType, YieldType, Yield
FROM Building_SpecialistYieldChanges WHERE (BuildingType = 'BUILDING_IRONWORKS');


--*********************************************************************************
--Building_UnitCombatFreeExperiences
--*********************************************************************************
INSERT INTO Building_UnitCombatFreeExperiences
			(BuildingType, UnitCombatType, Experience)
SELECT		('BUILDING_IRONWORKS_VOCALOID'), UnitCombatType, Experience
FROM Building_UnitCombatFreeExperiences WHERE (BuildingType = 'BUILDING_IRONWORKS');

--*********************************************************************************
--Building_UnitCombatProductionModifiers
--*********************************************************************************
INSERT INTO Building_UnitCombatProductionModifiers
			(BuildingType, UnitCombatType, Modifier)
SELECT		('BUILDING_IRONWORKS_VOCALOID'), UnitCombatType, Modifier
FROM Building_UnitCombatProductionModifiers WHERE (BuildingType = 'BUILDING_IRONWORKS');

--*********************************************************************************
--Building_TechAndPrereqs
--*********************************************************************************
INSERT INTO Building_TechAndPrereqs
			(BuildingType, TechType)
SELECT		('BUILDING_IRONWORKS_VOCALOID'), TechType
FROM Building_TechAndPrereqs WHERE (BuildingType = 'BUILDING_IRONWORKS');

--*********************************************************************************
--Building_YieldChanges
--*********************************************************************************
INSERT INTO Building_YieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_IRONWORKS_VOCALOID'), YieldType, Yield
FROM Building_YieldChanges WHERE (BuildingType = 'BUILDING_IRONWORKS');

--*********************************************************************************
--Building_YieldChangesPerPop
--*********************************************************************************
INSERT INTO Building_YieldChangesPerPop
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_IRONWORKS_VOCALOID'), YieldType, Yield
FROM Building_YieldChangesPerPop WHERE (BuildingType = 'BUILDING_IRONWORKS');

--*********************************************************************************
--Building_YieldChangesPerReligion
--*********************************************************************************
INSERT INTO Building_YieldChangesPerReligion
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_IRONWORKS_VOCALOID'), YieldType, Yield
FROM Building_YieldChangesPerReligion WHERE (BuildingType = 'BUILDING_IRONWORKS');

--*********************************************************************************
--Building_TechEnhancedYieldChanges
--*********************************************************************************
INSERT INTO Building_TechEnhancedYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_IRONWORKS_VOCALOID'), YieldType, Yield
FROM Building_TechEnhancedYieldChanges WHERE (BuildingType = 'BUILDING_IRONWORKS');


--*********************************************************************************
--Building_YieldModifiers
--*********************************************************************************
INSERT INTO Building_YieldModifiers
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_IRONWORKS_VOCALOID'), YieldType, Yield
FROM Building_YieldModifiers WHERE (BuildingType = 'BUILDING_IRONWORKS');





--*********************************************************************************
--Buildings
--*********************************************************************************

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
SELECT		('BUILDING_GRAND_TEMPLE_VOCALOID'), Description, Civilopedia, Strategy, Help,
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
FROM Buildings WHERE (Type = 'BUILDING_GRAND_TEMPLE');



--*********************************************************************************
--Building_AreaYieldModifiers
--*********************************************************************************
INSERT INTO Building_AreaYieldModifiers
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_GRAND_TEMPLE_VOCALOID'), YieldType, Yield
FROM Building_AreaYieldModifiers WHERE (BuildingType = 'BUILDING_GRAND_TEMPLE');


--*********************************************************************************
--Building_BuildingClassHappiness
--*********************************************************************************
INSERT INTO Building_BuildingClassHappiness
			(BuildingType, BuildingClassType, Happiness)
SELECT		('BUILDING_GRAND_TEMPLE_VOCALOID'), BuildingClassType, Happiness
FROM Building_BuildingClassHappiness WHERE (BuildingType = 'BUILDING_GRAND_TEMPLE');

--*********************************************************************************
--Building_BuildingClassYieldChanges
--*********************************************************************************
INSERT INTO Building_BuildingClassYieldChanges
			(BuildingType, BuildingClassType, YieldType, YieldChange)
SELECT		('BUILDING_GRAND_TEMPLE_VOCALOID'), BuildingClassType, YieldType, YieldChange
FROM Building_BuildingClassYieldChanges WHERE (BuildingType = 'BUILDING_GRAND_TEMPLE');

--*********************************************************************************
--Building_ClassesNeededInCity
--*********************************************************************************
INSERT INTO Building_ClassesNeededInCity
			(BuildingType, BuildingClassType)
SELECT		('BUILDING_GRAND_TEMPLE_VOCALOID'), BuildingClassType
FROM Building_ClassesNeededInCity WHERE (BuildingType = 'BUILDING_GRAND_TEMPLE');

--*********************************************************************************
--Building_FreeUnits
--*********************************************************************************
INSERT INTO Building_FreeUnits
			(BuildingType, UnitType, NumUnits)
SELECT		('BUILDING_GRAND_TEMPLE_VOCALOID'), UnitType, NumUnits
FROM Building_FreeUnits WHERE (BuildingType = 'BUILDING_GRAND_TEMPLE');

--*********************************************************************************
--Building_DomainFreeExperiences
--*********************************************************************************
INSERT INTO Building_DomainFreeExperiences
			(BuildingType, DomainType, Experience)
SELECT		('BUILDING_GRAND_TEMPLE_VOCALOID'), DomainType, Experience
FROM Building_DomainFreeExperiences WHERE (BuildingType = 'BUILDING_GRAND_TEMPLE');

--*********************************************************************************
--Building_DomainFreeExperiencePerGreatWork
--*********************************************************************************
INSERT INTO Building_DomainFreeExperiencePerGreatWork
			(BuildingType, DomainType, Experience)
SELECT		('BUILDING_GRAND_TEMPLE_VOCALOID'), DomainType, Experience
FROM Building_DomainFreeExperiencePerGreatWork WHERE (BuildingType = 'BUILDING_GRAND_TEMPLE');

--*********************************************************************************
--Building_DomainProductionModifiers
--*********************************************************************************
INSERT INTO Building_DomainProductionModifiers
			(BuildingType, DomainType, Modifier)
SELECT		('BUILDING_GRAND_TEMPLE_VOCALOID'), DomainType, Modifier
FROM Building_DomainProductionModifiers WHERE (BuildingType = 'BUILDING_GRAND_TEMPLE');

--*********************************************************************************
--Building_FreeSpecialistCounts
--*********************************************************************************
INSERT INTO Building_FreeSpecialistCounts
			(BuildingType, SpecialistType, Count)
SELECT		('BUILDING_GRAND_TEMPLE_VOCALOID'), SpecialistType, Count
FROM Building_FreeSpecialistCounts WHERE (BuildingType = 'BUILDING_GRAND_TEMPLE');

--*********************************************************************************
--Building_Flavors
--*********************************************************************************
INSERT INTO Building_Flavors
			(BuildingType, FlavorType, Flavor)
SELECT		('BUILDING_GRAND_TEMPLE_VOCALOID'), FlavorType, Flavor+5
FROM Building_Flavors WHERE (BuildingType = 'BUILDING_GRAND_TEMPLE');

INSERT INTO Building_Flavors
VALUES		('BUILDING_GRAND_TEMPLE_VOCALOID', 'FLAVOR_AIRLIFT', 10);

--*********************************************************************************
--Building_GlobalYieldModifiers
--*********************************************************************************
INSERT INTO Building_GlobalYieldModifiers
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_GRAND_TEMPLE_VOCALOID'), YieldType, Yield
FROM Building_GlobalYieldModifiers WHERE (BuildingType = 'BUILDING_GRAND_TEMPLE');

--*********************************************************************************
--Building_HurryModifiers
--*********************************************************************************
INSERT INTO Building_HurryModifiers
			(BuildingType, HurryType, HurryCostModifier)
SELECT		('BUILDING_GRAND_TEMPLE_VOCALOID'), HurryType, HurryCostModifier
FROM Building_HurryModifiers WHERE (BuildingType = 'BUILDING_GRAND_TEMPLE');

--*********************************************************************************
--Building_LocalResourceAnds
--*********************************************************************************
INSERT INTO Building_LocalResourceAnds
			(BuildingType, ResourceType)
SELECT		('BUILDING_GRAND_TEMPLE_VOCALOID'), ResourceType
FROM Building_LocalResourceAnds WHERE (BuildingType = 'BUILDING_GRAND_TEMPLE');

--*********************************************************************************
--Building_LocalResourceOrs
--*********************************************************************************
INSERT INTO Building_LocalResourceOrs
			(BuildingType, ResourceType)
SELECT		('BUILDING_GRAND_TEMPLE_VOCALOID'), ResourceType
FROM Building_LocalResourceOrs WHERE (BuildingType = 'BUILDING_GRAND_TEMPLE');

--*********************************************************************************
--Building_LockedBuildingClasses
--*********************************************************************************
INSERT INTO Building_LockedBuildingClasses
			(BuildingType, BuildingClassType)
SELECT		('BUILDING_GRAND_TEMPLE_VOCALOID'), BuildingClassType
FROM Building_LockedBuildingClasses WHERE (BuildingType = 'BUILDING_GRAND_TEMPLE');

--*********************************************************************************
--Building_PrereqBuildingClasses
--*********************************************************************************
INSERT INTO Building_PrereqBuildingClasses
			(BuildingType, BuildingClassType, NumBuildingNeeded)
SELECT		('BUILDING_GRAND_TEMPLE_VOCALOID'), BuildingClassType, NumBuildingNeeded
FROM Building_PrereqBuildingClasses WHERE (BuildingType = 'BUILDING_GRAND_TEMPLE');

--*********************************************************************************
--Building_ResourceQuantity
--*********************************************************************************
INSERT INTO Building_ResourceQuantity
			(BuildingType, ResourceType, Quantity)
SELECT		('BUILDING_GRAND_TEMPLE_VOCALOID'), ResourceType, Quantity
FROM Building_ResourceQuantity WHERE (BuildingType = 'BUILDING_GRAND_TEMPLE');

--*********************************************************************************
--Building_ResourceQuantityRequirements
--*********************************************************************************
INSERT INTO Building_ResourceQuantityRequirements
			(BuildingType, ResourceType, Cost)
SELECT		('BUILDING_GRAND_TEMPLE_VOCALOID'), ResourceType, Cost
FROM Building_ResourceQuantityRequirements WHERE (BuildingType = 'BUILDING_GRAND_TEMPLE');

--*********************************************************************************
--Building_ResourceYieldModifiers
--*********************************************************************************
INSERT INTO Building_ResourceYieldModifiers
			(BuildingType, ResourceType, YieldType, Yield)
SELECT		('BUILDING_GRAND_TEMPLE_VOCALOID'), ResourceType, YieldType, Yield
FROM Building_ResourceYieldModifiers WHERE (BuildingType = 'BUILDING_GRAND_TEMPLE');

--*********************************************************************************
--Building_ResourceCultureChanges
--*********************************************************************************
INSERT INTO Building_ResourceCultureChanges
			(BuildingType, ResourceType, CultureChange)
SELECT		('BUILDING_GRAND_TEMPLE_VOCALOID'), ResourceType, CultureChange
FROM Building_ResourceCultureChanges WHERE (BuildingType = 'BUILDING_GRAND_TEMPLE');

--*********************************************************************************
--Building_ResourceFaithChanges
--*********************************************************************************
INSERT INTO Building_ResourceFaithChanges
			(BuildingType, ResourceType, FaithChange)
SELECT		('BUILDING_GRAND_TEMPLE_VOCALOID'), ResourceType, FaithChange
FROM Building_ResourceFaithChanges WHERE (BuildingType = 'BUILDING_GRAND_TEMPLE');

--*********************************************************************************
--Building_RiverPlotYieldChanges
--*********************************************************************************
INSERT INTO Building_RiverPlotYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_GRAND_TEMPLE_VOCALOID'), YieldType, Yield
FROM Building_RiverPlotYieldChanges WHERE (BuildingType = 'BUILDING_GRAND_TEMPLE');

--*********************************************************************************
--Building_SeaPlotYieldChanges
--*********************************************************************************
INSERT INTO Building_SeaPlotYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_GRAND_TEMPLE_VOCALOID'), YieldType, Yield
FROM Building_SeaPlotYieldChanges WHERE (BuildingType = 'BUILDING_GRAND_TEMPLE');

--*********************************************************************************
--Building_LakePlotYieldChanges
--*********************************************************************************
INSERT INTO Building_LakePlotYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_GRAND_TEMPLE_VOCALOID'), YieldType, Yield
FROM Building_LakePlotYieldChanges WHERE (BuildingType = 'BUILDING_GRAND_TEMPLE');

--*********************************************************************************
--Building_SeaResourceYieldChanges
--*********************************************************************************
INSERT INTO Building_SeaResourceYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_GRAND_TEMPLE_VOCALOID'), YieldType, Yield
FROM Building_SeaResourceYieldChanges WHERE (BuildingType = 'BUILDING_GRAND_TEMPLE');

--*********************************************************************************
--Building_ResourceYieldChanges
--*********************************************************************************
INSERT INTO Building_ResourceYieldChanges
			(BuildingType, ResourceType, YieldType, Yield)
SELECT		('BUILDING_GRAND_TEMPLE_VOCALOID'), ResourceType, YieldType, Yield
FROM Building_ResourceYieldChanges WHERE (BuildingType = 'BUILDING_GRAND_TEMPLE');

--*********************************************************************************
--Building_FeatureYieldChanges
--*********************************************************************************
INSERT INTO Building_FeatureYieldChanges
			(BuildingType, FeatureType, YieldType, Yield)
SELECT		('BUILDING_GRAND_TEMPLE_VOCALOID'), FeatureType, YieldType, Yield
FROM Building_FeatureYieldChanges WHERE (BuildingType = 'BUILDING_GRAND_TEMPLE');

--*********************************************************************************
--Building_TerrainYieldChanges
--*********************************************************************************
INSERT INTO Building_TerrainYieldChanges
			(BuildingType, TerrainType, YieldType, Yield)
SELECT		('BUILDING_GRAND_TEMPLE_VOCALOID'), TerrainType, YieldType, Yield
FROM Building_TerrainYieldChanges WHERE (BuildingType = 'BUILDING_GRAND_TEMPLE');

--*********************************************************************************
--Building_SpecialistYieldChanges
--*********************************************************************************
INSERT INTO Building_SpecialistYieldChanges
			(BuildingType, SpecialistType, YieldType, Yield)
SELECT		('BUILDING_GRAND_TEMPLE_VOCALOID'), SpecialistType, YieldType, Yield
FROM Building_SpecialistYieldChanges WHERE (BuildingType = 'BUILDING_GRAND_TEMPLE');


--*********************************************************************************
--Building_UnitCombatFreeExperiences
--*********************************************************************************
INSERT INTO Building_UnitCombatFreeExperiences
			(BuildingType, UnitCombatType, Experience)
SELECT		('BUILDING_GRAND_TEMPLE_VOCALOID'), UnitCombatType, Experience
FROM Building_UnitCombatFreeExperiences WHERE (BuildingType = 'BUILDING_GRAND_TEMPLE');

--*********************************************************************************
--Building_UnitCombatProductionModifiers
--*********************************************************************************
INSERT INTO Building_UnitCombatProductionModifiers
			(BuildingType, UnitCombatType, Modifier)
SELECT		('BUILDING_GRAND_TEMPLE_VOCALOID'), UnitCombatType, Modifier
FROM Building_UnitCombatProductionModifiers WHERE (BuildingType = 'BUILDING_GRAND_TEMPLE');

--*********************************************************************************
--Building_TechAndPrereqs
--*********************************************************************************
INSERT INTO Building_TechAndPrereqs
			(BuildingType, TechType)
SELECT		('BUILDING_GRAND_TEMPLE_VOCALOID'), TechType
FROM Building_TechAndPrereqs WHERE (BuildingType = 'BUILDING_GRAND_TEMPLE');

--*********************************************************************************
--Building_YieldChanges
--*********************************************************************************
INSERT INTO Building_YieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_GRAND_TEMPLE_VOCALOID'), YieldType, Yield
FROM Building_YieldChanges WHERE (BuildingType = 'BUILDING_GRAND_TEMPLE');

--*********************************************************************************
--Building_YieldChangesPerPop
--*********************************************************************************
INSERT INTO Building_YieldChangesPerPop
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_GRAND_TEMPLE_VOCALOID'), YieldType, Yield
FROM Building_YieldChangesPerPop WHERE (BuildingType = 'BUILDING_GRAND_TEMPLE');

--*********************************************************************************
--Building_YieldChangesPerReligion
--*********************************************************************************
INSERT INTO Building_YieldChangesPerReligion
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_GRAND_TEMPLE_VOCALOID'), YieldType, Yield
FROM Building_YieldChangesPerReligion WHERE (BuildingType = 'BUILDING_GRAND_TEMPLE');

--*********************************************************************************
--Building_TechEnhancedYieldChanges
--*********************************************************************************
INSERT INTO Building_TechEnhancedYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_GRAND_TEMPLE_VOCALOID'), YieldType, Yield
FROM Building_TechEnhancedYieldChanges WHERE (BuildingType = 'BUILDING_GRAND_TEMPLE');


--*********************************************************************************
--Building_YieldModifiers
--*********************************************************************************
INSERT INTO Building_YieldModifiers
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_GRAND_TEMPLE_VOCALOID'), YieldType, Yield
FROM Building_YieldModifiers WHERE (BuildingType = 'BUILDING_GRAND_TEMPLE');




--*********************************************************************************
--Buildings
--*********************************************************************************

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
SELECT		('BUILDING_LIBRARY_VOCALOID'), Description, Civilopedia, Strategy, Help,
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
FROM Buildings WHERE (Type = 'BUILDING_LIBRARY');



--*********************************************************************************
--Building_AreaYieldModifiers
--*********************************************************************************
INSERT INTO Building_AreaYieldModifiers
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_LIBRARY_VOCALOID'), YieldType, Yield
FROM Building_AreaYieldModifiers WHERE (BuildingType = 'BUILDING_LIBRARY');


--*********************************************************************************
--Building_BuildingClassHappiness
--*********************************************************************************
INSERT INTO Building_BuildingClassHappiness
			(BuildingType, BuildingClassType, Happiness)
SELECT		('BUILDING_LIBRARY_VOCALOID'), BuildingClassType, Happiness
FROM Building_BuildingClassHappiness WHERE (BuildingType = 'BUILDING_LIBRARY');

--*********************************************************************************
--Building_BuildingClassYieldChanges
--*********************************************************************************
INSERT INTO Building_BuildingClassYieldChanges
			(BuildingType, BuildingClassType, YieldType, YieldChange)
SELECT		('BUILDING_LIBRARY_VOCALOID'), BuildingClassType, YieldType, YieldChange
FROM Building_BuildingClassYieldChanges WHERE (BuildingType = 'BUILDING_LIBRARY');

--*********************************************************************************
--Building_ClassesNeededInCity
--*********************************************************************************
INSERT INTO Building_ClassesNeededInCity
			(BuildingType, BuildingClassType)
SELECT		('BUILDING_LIBRARY_VOCALOID'), BuildingClassType
FROM Building_ClassesNeededInCity WHERE (BuildingType = 'BUILDING_LIBRARY');

--*********************************************************************************
--Building_FreeUnits
--*********************************************************************************
INSERT INTO Building_FreeUnits
			(BuildingType, UnitType, NumUnits)
SELECT		('BUILDING_LIBRARY_VOCALOID'), UnitType, NumUnits
FROM Building_FreeUnits WHERE (BuildingType = 'BUILDING_LIBRARY');

--*********************************************************************************
--Building_DomainFreeExperiences
--*********************************************************************************
INSERT INTO Building_DomainFreeExperiences
			(BuildingType, DomainType, Experience)
SELECT		('BUILDING_LIBRARY_VOCALOID'), DomainType, Experience
FROM Building_DomainFreeExperiences WHERE (BuildingType = 'BUILDING_LIBRARY');

--*********************************************************************************
--Building_DomainFreeExperiencePerGreatWork
--*********************************************************************************
INSERT INTO Building_DomainFreeExperiencePerGreatWork
			(BuildingType, DomainType, Experience)
SELECT		('BUILDING_LIBRARY_VOCALOID'), DomainType, Experience
FROM Building_DomainFreeExperiencePerGreatWork WHERE (BuildingType = 'BUILDING_LIBRARY');

--*********************************************************************************
--Building_DomainProductionModifiers
--*********************************************************************************
INSERT INTO Building_DomainProductionModifiers
			(BuildingType, DomainType, Modifier)
SELECT		('BUILDING_LIBRARY_VOCALOID'), DomainType, Modifier
FROM Building_DomainProductionModifiers WHERE (BuildingType = 'BUILDING_LIBRARY');

--*********************************************************************************
--Building_FreeSpecialistCounts
--*********************************************************************************
INSERT INTO Building_FreeSpecialistCounts
			(BuildingType, SpecialistType, Count)
SELECT		('BUILDING_LIBRARY_VOCALOID'), SpecialistType, Count
FROM Building_FreeSpecialistCounts WHERE (BuildingType = 'BUILDING_LIBRARY');

--*********************************************************************************
--Building_Flavors
--*********************************************************************************
INSERT INTO Building_Flavors
			(BuildingType, FlavorType, Flavor)
SELECT		('BUILDING_LIBRARY_VOCALOID'), FlavorType, Flavor+5
FROM Building_Flavors WHERE (BuildingType = 'BUILDING_LIBRARY');

INSERT INTO Building_Flavors
VALUES		('BUILDING_LIBRARY_VOCALOID', 'FLAVOR_AIRLIFT', 10);

--*********************************************************************************
--Building_GlobalYieldModifiers
--*********************************************************************************
INSERT INTO Building_GlobalYieldModifiers
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_LIBRARY_VOCALOID'), YieldType, Yield
FROM Building_GlobalYieldModifiers WHERE (BuildingType = 'BUILDING_LIBRARY');

--*********************************************************************************
--Building_HurryModifiers
--*********************************************************************************
INSERT INTO Building_HurryModifiers
			(BuildingType, HurryType, HurryCostModifier)
SELECT		('BUILDING_LIBRARY_VOCALOID'), HurryType, HurryCostModifier
FROM Building_HurryModifiers WHERE (BuildingType = 'BUILDING_LIBRARY');

--*********************************************************************************
--Building_LocalResourceAnds
--*********************************************************************************
INSERT INTO Building_LocalResourceAnds
			(BuildingType, ResourceType)
SELECT		('BUILDING_LIBRARY_VOCALOID'), ResourceType
FROM Building_LocalResourceAnds WHERE (BuildingType = 'BUILDING_LIBRARY');

--*********************************************************************************
--Building_LocalResourceOrs
--*********************************************************************************
INSERT INTO Building_LocalResourceOrs
			(BuildingType, ResourceType)
SELECT		('BUILDING_LIBRARY_VOCALOID'), ResourceType
FROM Building_LocalResourceOrs WHERE (BuildingType = 'BUILDING_LIBRARY');

--*********************************************************************************
--Building_LockedBuildingClasses
--*********************************************************************************
INSERT INTO Building_LockedBuildingClasses
			(BuildingType, BuildingClassType)
SELECT		('BUILDING_LIBRARY_VOCALOID'), BuildingClassType
FROM Building_LockedBuildingClasses WHERE (BuildingType = 'BUILDING_LIBRARY');

--*********************************************************************************
--Building_PrereqBuildingClasses
--*********************************************************************************
INSERT INTO Building_PrereqBuildingClasses
			(BuildingType, BuildingClassType, NumBuildingNeeded)
SELECT		('BUILDING_LIBRARY_VOCALOID'), BuildingClassType, NumBuildingNeeded
FROM Building_PrereqBuildingClasses WHERE (BuildingType = 'BUILDING_LIBRARY');

--*********************************************************************************
--Building_ResourceQuantity
--*********************************************************************************
INSERT INTO Building_ResourceQuantity
			(BuildingType, ResourceType, Quantity)
SELECT		('BUILDING_LIBRARY_VOCALOID'), ResourceType, Quantity
FROM Building_ResourceQuantity WHERE (BuildingType = 'BUILDING_LIBRARY');

--*********************************************************************************
--Building_ResourceQuantityRequirements
--*********************************************************************************
INSERT INTO Building_ResourceQuantityRequirements
			(BuildingType, ResourceType, Cost)
SELECT		('BUILDING_LIBRARY_VOCALOID'), ResourceType, Cost
FROM Building_ResourceQuantityRequirements WHERE (BuildingType = 'BUILDING_LIBRARY');

--*********************************************************************************
--Building_ResourceYieldModifiers
--*********************************************************************************
INSERT INTO Building_ResourceYieldModifiers
			(BuildingType, ResourceType, YieldType, Yield)
SELECT		('BUILDING_LIBRARY_VOCALOID'), ResourceType, YieldType, Yield
FROM Building_ResourceYieldModifiers WHERE (BuildingType = 'BUILDING_LIBRARY');

--*********************************************************************************
--Building_ResourceCultureChanges
--*********************************************************************************
INSERT INTO Building_ResourceCultureChanges
			(BuildingType, ResourceType, CultureChange)
SELECT		('BUILDING_LIBRARY_VOCALOID'), ResourceType, CultureChange
FROM Building_ResourceCultureChanges WHERE (BuildingType = 'BUILDING_LIBRARY');

--*********************************************************************************
--Building_ResourceFaithChanges
--*********************************************************************************
INSERT INTO Building_ResourceFaithChanges
			(BuildingType, ResourceType, FaithChange)
SELECT		('BUILDING_LIBRARY_VOCALOID'), ResourceType, FaithChange
FROM Building_ResourceFaithChanges WHERE (BuildingType = 'BUILDING_LIBRARY');

--*********************************************************************************
--Building_RiverPlotYieldChanges
--*********************************************************************************
INSERT INTO Building_RiverPlotYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_LIBRARY_VOCALOID'), YieldType, Yield
FROM Building_RiverPlotYieldChanges WHERE (BuildingType = 'BUILDING_LIBRARY');

--*********************************************************************************
--Building_SeaPlotYieldChanges
--*********************************************************************************
INSERT INTO Building_SeaPlotYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_LIBRARY_VOCALOID'), YieldType, Yield
FROM Building_SeaPlotYieldChanges WHERE (BuildingType = 'BUILDING_LIBRARY');

--*********************************************************************************
--Building_LakePlotYieldChanges
--*********************************************************************************
INSERT INTO Building_LakePlotYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_LIBRARY_VOCALOID'), YieldType, Yield
FROM Building_LakePlotYieldChanges WHERE (BuildingType = 'BUILDING_LIBRARY');

--*********************************************************************************
--Building_SeaResourceYieldChanges
--*********************************************************************************
INSERT INTO Building_SeaResourceYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_LIBRARY_VOCALOID'), YieldType, Yield
FROM Building_SeaResourceYieldChanges WHERE (BuildingType = 'BUILDING_LIBRARY');

--*********************************************************************************
--Building_ResourceYieldChanges
--*********************************************************************************
INSERT INTO Building_ResourceYieldChanges
			(BuildingType, ResourceType, YieldType, Yield)
SELECT		('BUILDING_LIBRARY_VOCALOID'), ResourceType, YieldType, Yield
FROM Building_ResourceYieldChanges WHERE (BuildingType = 'BUILDING_LIBRARY');

--*********************************************************************************
--Building_FeatureYieldChanges
--*********************************************************************************
INSERT INTO Building_FeatureYieldChanges
			(BuildingType, FeatureType, YieldType, Yield)
SELECT		('BUILDING_LIBRARY_VOCALOID'), FeatureType, YieldType, Yield
FROM Building_FeatureYieldChanges WHERE (BuildingType = 'BUILDING_LIBRARY');

--*********************************************************************************
--Building_TerrainYieldChanges
--*********************************************************************************
INSERT INTO Building_TerrainYieldChanges
			(BuildingType, TerrainType, YieldType, Yield)
SELECT		('BUILDING_LIBRARY_VOCALOID'), TerrainType, YieldType, Yield
FROM Building_TerrainYieldChanges WHERE (BuildingType = 'BUILDING_LIBRARY');

--*********************************************************************************
--Building_SpecialistYieldChanges
--*********************************************************************************
INSERT INTO Building_SpecialistYieldChanges
			(BuildingType, SpecialistType, YieldType, Yield)
SELECT		('BUILDING_LIBRARY_VOCALOID'), SpecialistType, YieldType, Yield
FROM Building_SpecialistYieldChanges WHERE (BuildingType = 'BUILDING_LIBRARY');


--*********************************************************************************
--Building_UnitCombatFreeExperiences
--*********************************************************************************
INSERT INTO Building_UnitCombatFreeExperiences
			(BuildingType, UnitCombatType, Experience)
SELECT		('BUILDING_LIBRARY_VOCALOID'), UnitCombatType, Experience
FROM Building_UnitCombatFreeExperiences WHERE (BuildingType = 'BUILDING_LIBRARY');

--*********************************************************************************
--Building_UnitCombatProductionModifiers
--*********************************************************************************
INSERT INTO Building_UnitCombatProductionModifiers
			(BuildingType, UnitCombatType, Modifier)
SELECT		('BUILDING_LIBRARY_VOCALOID'), UnitCombatType, Modifier
FROM Building_UnitCombatProductionModifiers WHERE (BuildingType = 'BUILDING_LIBRARY');

--*********************************************************************************
--Building_TechAndPrereqs
--*********************************************************************************
INSERT INTO Building_TechAndPrereqs
			(BuildingType, TechType)
SELECT		('BUILDING_LIBRARY_VOCALOID'), TechType
FROM Building_TechAndPrereqs WHERE (BuildingType = 'BUILDING_LIBRARY');

--*********************************************************************************
--Building_YieldChanges
--*********************************************************************************
INSERT INTO Building_YieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_LIBRARY_VOCALOID'), YieldType, Yield
FROM Building_YieldChanges WHERE (BuildingType = 'BUILDING_LIBRARY');

--*********************************************************************************
--Building_YieldChangesPerPop
--*********************************************************************************
INSERT INTO Building_YieldChangesPerPop
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_LIBRARY_VOCALOID'), YieldType, Yield
FROM Building_YieldChangesPerPop WHERE (BuildingType = 'BUILDING_LIBRARY');

--*********************************************************************************
--Building_YieldChangesPerReligion
--*********************************************************************************
INSERT INTO Building_YieldChangesPerReligion
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_LIBRARY_VOCALOID'), YieldType, Yield
FROM Building_YieldChangesPerReligion WHERE (BuildingType = 'BUILDING_LIBRARY');

--*********************************************************************************
--Building_TechEnhancedYieldChanges
--*********************************************************************************
INSERT INTO Building_TechEnhancedYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_LIBRARY_VOCALOID'), YieldType, Yield
FROM Building_TechEnhancedYieldChanges WHERE (BuildingType = 'BUILDING_LIBRARY');


--*********************************************************************************
--Building_YieldModifiers
--*********************************************************************************
INSERT INTO Building_YieldModifiers
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_LIBRARY_VOCALOID'), YieldType, Yield
FROM Building_YieldModifiers WHERE (BuildingType = 'BUILDING_LIBRARY');

--*********************************************************************************
--Building_ThemingBonuses
--*********************************************************************************
INSERT INTO Building_ThemingBonuses
			(BuildingType, Description, Bonus, SameEra, UniqueEras, MustBeArt, MustBeArtifact, MustBeEqualArtArtifact, RequiresOwner, RequiresAnyButOwner, RequiresSamePlayer, RequiresUniquePlayers, AIPriority)
SELECT		('BUILDING_LIBRARY_VOCALOID'), Description, Bonus, SameEra, UniqueEras, MustBeArt, MustBeArtifact, MustBeEqualArtArtifact, RequiresOwner, RequiresAnyButOwner, RequiresSamePlayer, RequiresUniquePlayers, AIPriority
FROM Building_ThemingBonuses WHERE (BuildingType = 'BUILDING_LIBRARY');





--*********************************************************************************
--Buildings
--*********************************************************************************

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
SELECT		('BUILDING_UNIVERSITY_VOCALOID'), Description, Civilopedia, Strategy, Help,
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
FROM Buildings WHERE (Type = 'BUILDING_UNIVERSITY');



--*********************************************************************************
--Building_AreaYieldModifiers
--*********************************************************************************
INSERT INTO Building_AreaYieldModifiers
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_UNIVERSITY_VOCALOID'), YieldType, Yield
FROM Building_AreaYieldModifiers WHERE (BuildingType = 'BUILDING_UNIVERSITY');


--*********************************************************************************
--Building_BuildingClassHappiness
--*********************************************************************************
INSERT INTO Building_BuildingClassHappiness
			(BuildingType, BuildingClassType, Happiness)
SELECT		('BUILDING_UNIVERSITY_VOCALOID'), BuildingClassType, Happiness
FROM Building_BuildingClassHappiness WHERE (BuildingType = 'BUILDING_UNIVERSITY');

--*********************************************************************************
--Building_BuildingClassYieldChanges
--*********************************************************************************
INSERT INTO Building_BuildingClassYieldChanges
			(BuildingType, BuildingClassType, YieldType, YieldChange)
SELECT		('BUILDING_UNIVERSITY_VOCALOID'), BuildingClassType, YieldType, YieldChange
FROM Building_BuildingClassYieldChanges WHERE (BuildingType = 'BUILDING_UNIVERSITY');

--*********************************************************************************
--Building_ClassesNeededInCity
--*********************************************************************************
INSERT INTO Building_ClassesNeededInCity
			(BuildingType, BuildingClassType)
SELECT		('BUILDING_UNIVERSITY_VOCALOID'), BuildingClassType
FROM Building_ClassesNeededInCity WHERE (BuildingType = 'BUILDING_UNIVERSITY');

--*********************************************************************************
--Building_FreeUnits
--*********************************************************************************
INSERT INTO Building_FreeUnits
			(BuildingType, UnitType, NumUnits)
SELECT		('BUILDING_UNIVERSITY_VOCALOID'), UnitType, NumUnits
FROM Building_FreeUnits WHERE (BuildingType = 'BUILDING_UNIVERSITY');

--*********************************************************************************
--Building_DomainFreeExperiences
--*********************************************************************************
INSERT INTO Building_DomainFreeExperiences
			(BuildingType, DomainType, Experience)
SELECT		('BUILDING_UNIVERSITY_VOCALOID'), DomainType, Experience
FROM Building_DomainFreeExperiences WHERE (BuildingType = 'BUILDING_UNIVERSITY');

--*********************************************************************************
--Building_DomainFreeExperiencePerGreatWork
--*********************************************************************************
INSERT INTO Building_DomainFreeExperiencePerGreatWork
			(BuildingType, DomainType, Experience)
SELECT		('BUILDING_UNIVERSITY_VOCALOID'), DomainType, Experience
FROM Building_DomainFreeExperiencePerGreatWork WHERE (BuildingType = 'BUILDING_UNIVERSITY');

--*********************************************************************************
--Building_DomainProductionModifiers
--*********************************************************************************
INSERT INTO Building_DomainProductionModifiers
			(BuildingType, DomainType, Modifier)
SELECT		('BUILDING_UNIVERSITY_VOCALOID'), DomainType, Modifier
FROM Building_DomainProductionModifiers WHERE (BuildingType = 'BUILDING_UNIVERSITY');

--*********************************************************************************
--Building_FreeSpecialistCounts
--*********************************************************************************
INSERT INTO Building_FreeSpecialistCounts
			(BuildingType, SpecialistType, Count)
SELECT		('BUILDING_UNIVERSITY_VOCALOID'), SpecialistType, Count
FROM Building_FreeSpecialistCounts WHERE (BuildingType = 'BUILDING_UNIVERSITY');

--*********************************************************************************
--Building_Flavors
--*********************************************************************************
INSERT INTO Building_Flavors
			(BuildingType, FlavorType, Flavor)
SELECT		('BUILDING_UNIVERSITY_VOCALOID'), FlavorType, Flavor+5
FROM Building_Flavors WHERE (BuildingType = 'BUILDING_UNIVERSITY');

INSERT INTO Building_Flavors
VALUES		('BUILDING_UNIVERSITY_VOCALOID', 'FLAVOR_AIRLIFT', 10);

--*********************************************************************************
--Building_GlobalYieldModifiers
--*********************************************************************************
INSERT INTO Building_GlobalYieldModifiers
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_UNIVERSITY_VOCALOID'), YieldType, Yield
FROM Building_GlobalYieldModifiers WHERE (BuildingType = 'BUILDING_UNIVERSITY');

--*********************************************************************************
--Building_HurryModifiers
--*********************************************************************************
INSERT INTO Building_HurryModifiers
			(BuildingType, HurryType, HurryCostModifier)
SELECT		('BUILDING_UNIVERSITY_VOCALOID'), HurryType, HurryCostModifier
FROM Building_HurryModifiers WHERE (BuildingType = 'BUILDING_UNIVERSITY');

--*********************************************************************************
--Building_LocalResourceAnds
--*********************************************************************************
INSERT INTO Building_LocalResourceAnds
			(BuildingType, ResourceType)
SELECT		('BUILDING_UNIVERSITY_VOCALOID'), ResourceType
FROM Building_LocalResourceAnds WHERE (BuildingType = 'BUILDING_UNIVERSITY');

--*********************************************************************************
--Building_LocalResourceOrs
--*********************************************************************************
INSERT INTO Building_LocalResourceOrs
			(BuildingType, ResourceType)
SELECT		('BUILDING_UNIVERSITY_VOCALOID'), ResourceType
FROM Building_LocalResourceOrs WHERE (BuildingType = 'BUILDING_UNIVERSITY');

--*********************************************************************************
--Building_LockedBuildingClasses
--*********************************************************************************
INSERT INTO Building_LockedBuildingClasses
			(BuildingType, BuildingClassType)
SELECT		('BUILDING_UNIVERSITY_VOCALOID'), BuildingClassType
FROM Building_LockedBuildingClasses WHERE (BuildingType = 'BUILDING_UNIVERSITY');

--*********************************************************************************
--Building_PrereqBuildingClasses
--*********************************************************************************
INSERT INTO Building_PrereqBuildingClasses
			(BuildingType, BuildingClassType, NumBuildingNeeded)
SELECT		('BUILDING_UNIVERSITY_VOCALOID'), BuildingClassType, NumBuildingNeeded
FROM Building_PrereqBuildingClasses WHERE (BuildingType = 'BUILDING_UNIVERSITY');

--*********************************************************************************
--Building_ResourceQuantity
--*********************************************************************************
INSERT INTO Building_ResourceQuantity
			(BuildingType, ResourceType, Quantity)
SELECT		('BUILDING_UNIVERSITY_VOCALOID'), ResourceType, Quantity
FROM Building_ResourceQuantity WHERE (BuildingType = 'BUILDING_UNIVERSITY');

--*********************************************************************************
--Building_ResourceQuantityRequirements
--*********************************************************************************
INSERT INTO Building_ResourceQuantityRequirements
			(BuildingType, ResourceType, Cost)
SELECT		('BUILDING_UNIVERSITY_VOCALOID'), ResourceType, Cost
FROM Building_ResourceQuantityRequirements WHERE (BuildingType = 'BUILDING_UNIVERSITY');

--*********************************************************************************
--Building_ResourceYieldModifiers
--*********************************************************************************
INSERT INTO Building_ResourceYieldModifiers
			(BuildingType, ResourceType, YieldType, Yield)
SELECT		('BUILDING_UNIVERSITY_VOCALOID'), ResourceType, YieldType, Yield
FROM Building_ResourceYieldModifiers WHERE (BuildingType = 'BUILDING_UNIVERSITY');

--*********************************************************************************
--Building_ResourceCultureChanges
--*********************************************************************************
INSERT INTO Building_ResourceCultureChanges
			(BuildingType, ResourceType, CultureChange)
SELECT		('BUILDING_UNIVERSITY_VOCALOID'), ResourceType, CultureChange
FROM Building_ResourceCultureChanges WHERE (BuildingType = 'BUILDING_UNIVERSITY');

--*********************************************************************************
--Building_ResourceFaithChanges
--*********************************************************************************
INSERT INTO Building_ResourceFaithChanges
			(BuildingType, ResourceType, FaithChange)
SELECT		('BUILDING_UNIVERSITY_VOCALOID'), ResourceType, FaithChange
FROM Building_ResourceFaithChanges WHERE (BuildingType = 'BUILDING_UNIVERSITY');

--*********************************************************************************
--Building_RiverPlotYieldChanges
--*********************************************************************************
INSERT INTO Building_RiverPlotYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_UNIVERSITY_VOCALOID'), YieldType, Yield
FROM Building_RiverPlotYieldChanges WHERE (BuildingType = 'BUILDING_UNIVERSITY');

--*********************************************************************************
--Building_SeaPlotYieldChanges
--*********************************************************************************
INSERT INTO Building_SeaPlotYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_UNIVERSITY_VOCALOID'), YieldType, Yield
FROM Building_SeaPlotYieldChanges WHERE (BuildingType = 'BUILDING_UNIVERSITY');

--*********************************************************************************
--Building_LakePlotYieldChanges
--*********************************************************************************
INSERT INTO Building_LakePlotYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_UNIVERSITY_VOCALOID'), YieldType, Yield
FROM Building_LakePlotYieldChanges WHERE (BuildingType = 'BUILDING_UNIVERSITY');

--*********************************************************************************
--Building_SeaResourceYieldChanges
--*********************************************************************************
INSERT INTO Building_SeaResourceYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_UNIVERSITY_VOCALOID'), YieldType, Yield
FROM Building_SeaResourceYieldChanges WHERE (BuildingType = 'BUILDING_UNIVERSITY');

--*********************************************************************************
--Building_ResourceYieldChanges
--*********************************************************************************
INSERT INTO Building_ResourceYieldChanges
			(BuildingType, ResourceType, YieldType, Yield)
SELECT		('BUILDING_UNIVERSITY_VOCALOID'), ResourceType, YieldType, Yield
FROM Building_ResourceYieldChanges WHERE (BuildingType = 'BUILDING_UNIVERSITY');

--*********************************************************************************
--Building_FeatureYieldChanges
--*********************************************************************************
INSERT INTO Building_FeatureYieldChanges
			(BuildingType, FeatureType, YieldType, Yield)
SELECT		('BUILDING_UNIVERSITY_VOCALOID'), FeatureType, YieldType, Yield
FROM Building_FeatureYieldChanges WHERE (BuildingType = 'BUILDING_UNIVERSITY');

--*********************************************************************************
--Building_TerrainYieldChanges
--*********************************************************************************
INSERT INTO Building_TerrainYieldChanges
			(BuildingType, TerrainType, YieldType, Yield)
SELECT		('BUILDING_UNIVERSITY_VOCALOID'), TerrainType, YieldType, Yield
FROM Building_TerrainYieldChanges WHERE (BuildingType = 'BUILDING_UNIVERSITY');

--*********************************************************************************
--Building_SpecialistYieldChanges
--*********************************************************************************
INSERT INTO Building_SpecialistYieldChanges
			(BuildingType, SpecialistType, YieldType, Yield)
SELECT		('BUILDING_UNIVERSITY_VOCALOID'), SpecialistType, YieldType, Yield
FROM Building_SpecialistYieldChanges WHERE (BuildingType = 'BUILDING_UNIVERSITY');


--*********************************************************************************
--Building_UnitCombatFreeExperiences
--*********************************************************************************
INSERT INTO Building_UnitCombatFreeExperiences
			(BuildingType, UnitCombatType, Experience)
SELECT		('BUILDING_UNIVERSITY_VOCALOID'), UnitCombatType, Experience
FROM Building_UnitCombatFreeExperiences WHERE (BuildingType = 'BUILDING_UNIVERSITY');

--*********************************************************************************
--Building_UnitCombatProductionModifiers
--*********************************************************************************
INSERT INTO Building_UnitCombatProductionModifiers
			(BuildingType, UnitCombatType, Modifier)
SELECT		('BUILDING_UNIVERSITY_VOCALOID'), UnitCombatType, Modifier
FROM Building_UnitCombatProductionModifiers WHERE (BuildingType = 'BUILDING_UNIVERSITY');

--*********************************************************************************
--Building_TechAndPrereqs
--*********************************************************************************
INSERT INTO Building_TechAndPrereqs
			(BuildingType, TechType)
SELECT		('BUILDING_UNIVERSITY_VOCALOID'), TechType
FROM Building_TechAndPrereqs WHERE (BuildingType = 'BUILDING_UNIVERSITY');

--*********************************************************************************
--Building_YieldChanges
--*********************************************************************************
INSERT INTO Building_YieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_UNIVERSITY_VOCALOID'), YieldType, Yield
FROM Building_YieldChanges WHERE (BuildingType = 'BUILDING_UNIVERSITY');

--*********************************************************************************
--Building_YieldChangesPerPop
--*********************************************************************************
INSERT INTO Building_YieldChangesPerPop
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_UNIVERSITY_VOCALOID'), YieldType, Yield
FROM Building_YieldChangesPerPop WHERE (BuildingType = 'BUILDING_UNIVERSITY');

--*********************************************************************************
--Building_YieldChangesPerReligion
--*********************************************************************************
INSERT INTO Building_YieldChangesPerReligion
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_UNIVERSITY_VOCALOID'), YieldType, Yield
FROM Building_YieldChangesPerReligion WHERE (BuildingType = 'BUILDING_UNIVERSITY');

--*********************************************************************************
--Building_TechEnhancedYieldChanges
--*********************************************************************************
INSERT INTO Building_TechEnhancedYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_UNIVERSITY_VOCALOID'), YieldType, Yield
FROM Building_TechEnhancedYieldChanges WHERE (BuildingType = 'BUILDING_UNIVERSITY');


--*********************************************************************************
--Building_YieldModifiers
--*********************************************************************************
INSERT INTO Building_YieldModifiers
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_UNIVERSITY_VOCALOID'), YieldType, Yield
FROM Building_YieldModifiers WHERE (BuildingType = 'BUILDING_UNIVERSITY');

--*********************************************************************************
--Building_ThemingBonuses
--*********************************************************************************
INSERT INTO Building_ThemingBonuses
			(BuildingType, Description, Bonus, SameEra, UniqueEras, MustBeArt, MustBeArtifact, MustBeEqualArtArtifact, RequiresOwner, RequiresAnyButOwner, RequiresSamePlayer, RequiresUniquePlayers, AIPriority)
SELECT		('BUILDING_UNIVERSITY_VOCALOID'), Description, Bonus, SameEra, UniqueEras, MustBeArt, MustBeArtifact, MustBeEqualArtArtifact, RequiresOwner, RequiresAnyButOwner, RequiresSamePlayer, RequiresUniquePlayers, AIPriority
FROM Building_ThemingBonuses WHERE (BuildingType = 'BUILDING_UNIVERSITY');





--*********************************************************************************
--Buildings
--*********************************************************************************

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
SELECT		('BUILDING_PUBLIC_SCHOOL_VOCALOID'), Description, Civilopedia, Strategy, Help,
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
FROM Buildings WHERE (Type = 'BUILDING_PUBLIC_SCHOOL');



--*********************************************************************************
--Building_AreaYieldModifiers
--*********************************************************************************
INSERT INTO Building_AreaYieldModifiers
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_PUBLIC_SCHOOL_VOCALOID'), YieldType, Yield
FROM Building_AreaYieldModifiers WHERE (BuildingType = 'BUILDING_PUBLIC_SCHOOL');


--*********************************************************************************
--Building_BuildingClassHappiness
--*********************************************************************************
INSERT INTO Building_BuildingClassHappiness
			(BuildingType, BuildingClassType, Happiness)
SELECT		('BUILDING_PUBLIC_SCHOOL_VOCALOID'), BuildingClassType, Happiness
FROM Building_BuildingClassHappiness WHERE (BuildingType = 'BUILDING_PUBLIC_SCHOOL');

--*********************************************************************************
--Building_BuildingClassYieldChanges
--*********************************************************************************
INSERT INTO Building_BuildingClassYieldChanges
			(BuildingType, BuildingClassType, YieldType, YieldChange)
SELECT		('BUILDING_PUBLIC_SCHOOL_VOCALOID'), BuildingClassType, YieldType, YieldChange
FROM Building_BuildingClassYieldChanges WHERE (BuildingType = 'BUILDING_PUBLIC_SCHOOL');

--*********************************************************************************
--Building_ClassesNeededInCity
--*********************************************************************************
INSERT INTO Building_ClassesNeededInCity
			(BuildingType, BuildingClassType)
SELECT		('BUILDING_PUBLIC_SCHOOL_VOCALOID'), BuildingClassType
FROM Building_ClassesNeededInCity WHERE (BuildingType = 'BUILDING_PUBLIC_SCHOOL');

--*********************************************************************************
--Building_FreeUnits
--*********************************************************************************
INSERT INTO Building_FreeUnits
			(BuildingType, UnitType, NumUnits)
SELECT		('BUILDING_PUBLIC_SCHOOL_VOCALOID'), UnitType, NumUnits
FROM Building_FreeUnits WHERE (BuildingType = 'BUILDING_PUBLIC_SCHOOL');

--*********************************************************************************
--Building_DomainFreeExperiences
--*********************************************************************************
INSERT INTO Building_DomainFreeExperiences
			(BuildingType, DomainType, Experience)
SELECT		('BUILDING_PUBLIC_SCHOOL_VOCALOID'), DomainType, Experience
FROM Building_DomainFreeExperiences WHERE (BuildingType = 'BUILDING_PUBLIC_SCHOOL');

--*********************************************************************************
--Building_DomainFreeExperiencePerGreatWork
--*********************************************************************************
INSERT INTO Building_DomainFreeExperiencePerGreatWork
			(BuildingType, DomainType, Experience)
SELECT		('BUILDING_PUBLIC_SCHOOL_VOCALOID'), DomainType, Experience
FROM Building_DomainFreeExperiencePerGreatWork WHERE (BuildingType = 'BUILDING_PUBLIC_SCHOOL');

--*********************************************************************************
--Building_DomainProductionModifiers
--*********************************************************************************
INSERT INTO Building_DomainProductionModifiers
			(BuildingType, DomainType, Modifier)
SELECT		('BUILDING_PUBLIC_SCHOOL_VOCALOID'), DomainType, Modifier
FROM Building_DomainProductionModifiers WHERE (BuildingType = 'BUILDING_PUBLIC_SCHOOL');

--*********************************************************************************
--Building_FreeSpecialistCounts
--*********************************************************************************
INSERT INTO Building_FreeSpecialistCounts
			(BuildingType, SpecialistType, Count)
SELECT		('BUILDING_PUBLIC_SCHOOL_VOCALOID'), SpecialistType, Count
FROM Building_FreeSpecialistCounts WHERE (BuildingType = 'BUILDING_PUBLIC_SCHOOL');

--*********************************************************************************
--Building_Flavors
--*********************************************************************************
INSERT INTO Building_Flavors
			(BuildingType, FlavorType, Flavor)
SELECT		('BUILDING_PUBLIC_SCHOOL_VOCALOID'), FlavorType, Flavor+5
FROM Building_Flavors WHERE (BuildingType = 'BUILDING_PUBLIC_SCHOOL');

INSERT INTO Building_Flavors
VALUES		('BUILDING_PUBLIC_SCHOOL_VOCALOID', 'FLAVOR_AIRLIFT', 10);

--*********************************************************************************
--Building_GlobalYieldModifiers
--*********************************************************************************
INSERT INTO Building_GlobalYieldModifiers
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_PUBLIC_SCHOOL_VOCALOID'), YieldType, Yield
FROM Building_GlobalYieldModifiers WHERE (BuildingType = 'BUILDING_PUBLIC_SCHOOL');

--*********************************************************************************
--Building_HurryModifiers
--*********************************************************************************
INSERT INTO Building_HurryModifiers
			(BuildingType, HurryType, HurryCostModifier)
SELECT		('BUILDING_PUBLIC_SCHOOL_VOCALOID'), HurryType, HurryCostModifier
FROM Building_HurryModifiers WHERE (BuildingType = 'BUILDING_PUBLIC_SCHOOL');

--*********************************************************************************
--Building_LocalResourceAnds
--*********************************************************************************
INSERT INTO Building_LocalResourceAnds
			(BuildingType, ResourceType)
SELECT		('BUILDING_PUBLIC_SCHOOL_VOCALOID'), ResourceType
FROM Building_LocalResourceAnds WHERE (BuildingType = 'BUILDING_PUBLIC_SCHOOL');

--*********************************************************************************
--Building_LocalResourceOrs
--*********************************************************************************
INSERT INTO Building_LocalResourceOrs
			(BuildingType, ResourceType)
SELECT		('BUILDING_PUBLIC_SCHOOL_VOCALOID'), ResourceType
FROM Building_LocalResourceOrs WHERE (BuildingType = 'BUILDING_PUBLIC_SCHOOL');

--*********************************************************************************
--Building_LockedBuildingClasses
--*********************************************************************************
INSERT INTO Building_LockedBuildingClasses
			(BuildingType, BuildingClassType)
SELECT		('BUILDING_PUBLIC_SCHOOL_VOCALOID'), BuildingClassType
FROM Building_LockedBuildingClasses WHERE (BuildingType = 'BUILDING_PUBLIC_SCHOOL');

--*********************************************************************************
--Building_PrereqBuildingClasses
--*********************************************************************************
INSERT INTO Building_PrereqBuildingClasses
			(BuildingType, BuildingClassType, NumBuildingNeeded)
SELECT		('BUILDING_PUBLIC_SCHOOL_VOCALOID'), BuildingClassType, NumBuildingNeeded
FROM Building_PrereqBuildingClasses WHERE (BuildingType = 'BUILDING_PUBLIC_SCHOOL');

--*********************************************************************************
--Building_ResourceQuantity
--*********************************************************************************
INSERT INTO Building_ResourceQuantity
			(BuildingType, ResourceType, Quantity)
SELECT		('BUILDING_PUBLIC_SCHOOL_VOCALOID'), ResourceType, Quantity
FROM Building_ResourceQuantity WHERE (BuildingType = 'BUILDING_PUBLIC_SCHOOL');

--*********************************************************************************
--Building_ResourceQuantityRequirements
--*********************************************************************************
INSERT INTO Building_ResourceQuantityRequirements
			(BuildingType, ResourceType, Cost)
SELECT		('BUILDING_PUBLIC_SCHOOL_VOCALOID'), ResourceType, Cost
FROM Building_ResourceQuantityRequirements WHERE (BuildingType = 'BUILDING_PUBLIC_SCHOOL');

--*********************************************************************************
--Building_ResourceYieldModifiers
--*********************************************************************************
INSERT INTO Building_ResourceYieldModifiers
			(BuildingType, ResourceType, YieldType, Yield)
SELECT		('BUILDING_PUBLIC_SCHOOL_VOCALOID'), ResourceType, YieldType, Yield
FROM Building_ResourceYieldModifiers WHERE (BuildingType = 'BUILDING_PUBLIC_SCHOOL');

--*********************************************************************************
--Building_ResourceCultureChanges
--*********************************************************************************
INSERT INTO Building_ResourceCultureChanges
			(BuildingType, ResourceType, CultureChange)
SELECT		('BUILDING_PUBLIC_SCHOOL_VOCALOID'), ResourceType, CultureChange
FROM Building_ResourceCultureChanges WHERE (BuildingType = 'BUILDING_PUBLIC_SCHOOL');

--*********************************************************************************
--Building_ResourceFaithChanges
--*********************************************************************************
INSERT INTO Building_ResourceFaithChanges
			(BuildingType, ResourceType, FaithChange)
SELECT		('BUILDING_PUBLIC_SCHOOL_VOCALOID'), ResourceType, FaithChange
FROM Building_ResourceFaithChanges WHERE (BuildingType = 'BUILDING_PUBLIC_SCHOOL');

--*********************************************************************************
--Building_RiverPlotYieldChanges
--*********************************************************************************
INSERT INTO Building_RiverPlotYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_PUBLIC_SCHOOL_VOCALOID'), YieldType, Yield
FROM Building_RiverPlotYieldChanges WHERE (BuildingType = 'BUILDING_PUBLIC_SCHOOL');

--*********************************************************************************
--Building_SeaPlotYieldChanges
--*********************************************************************************
INSERT INTO Building_SeaPlotYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_PUBLIC_SCHOOL_VOCALOID'), YieldType, Yield
FROM Building_SeaPlotYieldChanges WHERE (BuildingType = 'BUILDING_PUBLIC_SCHOOL');

--*********************************************************************************
--Building_LakePlotYieldChanges
--*********************************************************************************
INSERT INTO Building_LakePlotYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_PUBLIC_SCHOOL_VOCALOID'), YieldType, Yield
FROM Building_LakePlotYieldChanges WHERE (BuildingType = 'BUILDING_PUBLIC_SCHOOL');

--*********************************************************************************
--Building_SeaResourceYieldChanges
--*********************************************************************************
INSERT INTO Building_SeaResourceYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_PUBLIC_SCHOOL_VOCALOID'), YieldType, Yield
FROM Building_SeaResourceYieldChanges WHERE (BuildingType = 'BUILDING_PUBLIC_SCHOOL');

--*********************************************************************************
--Building_ResourceYieldChanges
--*********************************************************************************
INSERT INTO Building_ResourceYieldChanges
			(BuildingType, ResourceType, YieldType, Yield)
SELECT		('BUILDING_PUBLIC_SCHOOL_VOCALOID'), ResourceType, YieldType, Yield
FROM Building_ResourceYieldChanges WHERE (BuildingType = 'BUILDING_PUBLIC_SCHOOL');

--*********************************************************************************
--Building_FeatureYieldChanges
--*********************************************************************************
INSERT INTO Building_FeatureYieldChanges
			(BuildingType, FeatureType, YieldType, Yield)
SELECT		('BUILDING_PUBLIC_SCHOOL_VOCALOID'), FeatureType, YieldType, Yield
FROM Building_FeatureYieldChanges WHERE (BuildingType = 'BUILDING_PUBLIC_SCHOOL');

--*********************************************************************************
--Building_TerrainYieldChanges
--*********************************************************************************
INSERT INTO Building_TerrainYieldChanges
			(BuildingType, TerrainType, YieldType, Yield)
SELECT		('BUILDING_PUBLIC_SCHOOL_VOCALOID'), TerrainType, YieldType, Yield
FROM Building_TerrainYieldChanges WHERE (BuildingType = 'BUILDING_PUBLIC_SCHOOL');

--*********************************************************************************
--Building_SpecialistYieldChanges
--*********************************************************************************
INSERT INTO Building_SpecialistYieldChanges
			(BuildingType, SpecialistType, YieldType, Yield)
SELECT		('BUILDING_PUBLIC_SCHOOL_VOCALOID'), SpecialistType, YieldType, Yield
FROM Building_SpecialistYieldChanges WHERE (BuildingType = 'BUILDING_PUBLIC_SCHOOL');


--*********************************************************************************
--Building_UnitCombatFreeExperiences
--*********************************************************************************
INSERT INTO Building_UnitCombatFreeExperiences
			(BuildingType, UnitCombatType, Experience)
SELECT		('BUILDING_PUBLIC_SCHOOL_VOCALOID'), UnitCombatType, Experience
FROM Building_UnitCombatFreeExperiences WHERE (BuildingType = 'BUILDING_PUBLIC_SCHOOL');

--*********************************************************************************
--Building_UnitCombatProductionModifiers
--*********************************************************************************
INSERT INTO Building_UnitCombatProductionModifiers
			(BuildingType, UnitCombatType, Modifier)
SELECT		('BUILDING_PUBLIC_SCHOOL_VOCALOID'), UnitCombatType, Modifier
FROM Building_UnitCombatProductionModifiers WHERE (BuildingType = 'BUILDING_PUBLIC_SCHOOL');

--*********************************************************************************
--Building_TechAndPrereqs
--*********************************************************************************
INSERT INTO Building_TechAndPrereqs
			(BuildingType, TechType)
SELECT		('BUILDING_PUBLIC_SCHOOL_VOCALOID'), TechType
FROM Building_TechAndPrereqs WHERE (BuildingType = 'BUILDING_PUBLIC_SCHOOL');

--*********************************************************************************
--Building_YieldChanges
--*********************************************************************************
INSERT INTO Building_YieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_PUBLIC_SCHOOL_VOCALOID'), YieldType, Yield
FROM Building_YieldChanges WHERE (BuildingType = 'BUILDING_PUBLIC_SCHOOL');

--*********************************************************************************
--Building_YieldChangesPerPop
--*********************************************************************************
INSERT INTO Building_YieldChangesPerPop
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_PUBLIC_SCHOOL_VOCALOID'), YieldType, Yield
FROM Building_YieldChangesPerPop WHERE (BuildingType = 'BUILDING_PUBLIC_SCHOOL');

--*********************************************************************************
--Building_YieldChangesPerReligion
--*********************************************************************************
INSERT INTO Building_YieldChangesPerReligion
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_PUBLIC_SCHOOL_VOCALOID'), YieldType, Yield
FROM Building_YieldChangesPerReligion WHERE (BuildingType = 'BUILDING_PUBLIC_SCHOOL');

--*********************************************************************************
--Building_TechEnhancedYieldChanges
--*********************************************************************************
INSERT INTO Building_TechEnhancedYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_PUBLIC_SCHOOL_VOCALOID'), YieldType, Yield
FROM Building_TechEnhancedYieldChanges WHERE (BuildingType = 'BUILDING_PUBLIC_SCHOOL');


--*********************************************************************************
--Building_YieldModifiers
--*********************************************************************************
INSERT INTO Building_YieldModifiers
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_PUBLIC_SCHOOL_VOCALOID'), YieldType, Yield
FROM Building_YieldModifiers WHERE (BuildingType = 'BUILDING_PUBLIC_SCHOOL');

--*********************************************************************************
--Building_ThemingBonuses
--*********************************************************************************
INSERT INTO Building_ThemingBonuses
			(BuildingType, Description, Bonus, SameEra, UniqueEras, MustBeArt, MustBeArtifact, MustBeEqualArtArtifact, RequiresOwner, RequiresAnyButOwner, RequiresSamePlayer, RequiresUniquePlayers, AIPriority)
SELECT		('BUILDING_PUBLIC_SCHOOL_VOCALOID'), Description, Bonus, SameEra, UniqueEras, MustBeArt, MustBeArtifact, MustBeEqualArtArtifact, RequiresOwner, RequiresAnyButOwner, RequiresSamePlayer, RequiresUniquePlayers, AIPriority
FROM Building_ThemingBonuses WHERE (BuildingType = 'BUILDING_PUBLIC_SCHOOL');




--*********************************************************************************
--Buildings
--*********************************************************************************

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
SELECT		('BUILDING_LABORATORY_VOCALOID'), Description, Civilopedia, Strategy, Help,
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
FROM Buildings WHERE (Type = 'BUILDING_LABORATORY');



--*********************************************************************************
--Building_AreaYieldModifiers
--*********************************************************************************
INSERT INTO Building_AreaYieldModifiers
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_LABORATORY_VOCALOID'), YieldType, Yield
FROM Building_AreaYieldModifiers WHERE (BuildingType = 'BUILDING_LABORATORY');


--*********************************************************************************
--Building_BuildingClassHappiness
--*********************************************************************************
INSERT INTO Building_BuildingClassHappiness
			(BuildingType, BuildingClassType, Happiness)
SELECT		('BUILDING_LABORATORY_VOCALOID'), BuildingClassType, Happiness
FROM Building_BuildingClassHappiness WHERE (BuildingType = 'BUILDING_LABORATORY');

--*********************************************************************************
--Building_BuildingClassYieldChanges
--*********************************************************************************
INSERT INTO Building_BuildingClassYieldChanges
			(BuildingType, BuildingClassType, YieldType, YieldChange)
SELECT		('BUILDING_LABORATORY_VOCALOID'), BuildingClassType, YieldType, YieldChange
FROM Building_BuildingClassYieldChanges WHERE (BuildingType = 'BUILDING_LABORATORY');

--*********************************************************************************
--Building_ClassesNeededInCity
--*********************************************************************************
INSERT INTO Building_ClassesNeededInCity
			(BuildingType, BuildingClassType)
SELECT		('BUILDING_LABORATORY_VOCALOID'), BuildingClassType
FROM Building_ClassesNeededInCity WHERE (BuildingType = 'BUILDING_LABORATORY');

--*********************************************************************************
--Building_FreeUnits
--*********************************************************************************
INSERT INTO Building_FreeUnits
			(BuildingType, UnitType, NumUnits)
SELECT		('BUILDING_LABORATORY_VOCALOID'), UnitType, NumUnits
FROM Building_FreeUnits WHERE (BuildingType = 'BUILDING_LABORATORY');

--*********************************************************************************
--Building_DomainFreeExperiences
--*********************************************************************************
INSERT INTO Building_DomainFreeExperiences
			(BuildingType, DomainType, Experience)
SELECT		('BUILDING_LABORATORY_VOCALOID'), DomainType, Experience
FROM Building_DomainFreeExperiences WHERE (BuildingType = 'BUILDING_LABORATORY');

--*********************************************************************************
--Building_DomainFreeExperiencePerGreatWork
--*********************************************************************************
INSERT INTO Building_DomainFreeExperiencePerGreatWork
			(BuildingType, DomainType, Experience)
SELECT		('BUILDING_LABORATORY_VOCALOID'), DomainType, Experience
FROM Building_DomainFreeExperiencePerGreatWork WHERE (BuildingType = 'BUILDING_LABORATORY');

--*********************************************************************************
--Building_DomainProductionModifiers
--*********************************************************************************
INSERT INTO Building_DomainProductionModifiers
			(BuildingType, DomainType, Modifier)
SELECT		('BUILDING_LABORATORY_VOCALOID'), DomainType, Modifier
FROM Building_DomainProductionModifiers WHERE (BuildingType = 'BUILDING_LABORATORY');

--*********************************************************************************
--Building_FreeSpecialistCounts
--*********************************************************************************
INSERT INTO Building_FreeSpecialistCounts
			(BuildingType, SpecialistType, Count)
SELECT		('BUILDING_LABORATORY_VOCALOID'), SpecialistType, Count
FROM Building_FreeSpecialistCounts WHERE (BuildingType = 'BUILDING_LABORATORY');

--*********************************************************************************
--Building_Flavors
--*********************************************************************************
INSERT INTO Building_Flavors
			(BuildingType, FlavorType, Flavor)
SELECT		('BUILDING_LABORATORY_VOCALOID'), FlavorType, Flavor+5
FROM Building_Flavors WHERE (BuildingType = 'BUILDING_LABORATORY');

INSERT INTO Building_Flavors
VALUES		('BUILDING_LABORATORY_VOCALOID', 'FLAVOR_AIRLIFT', 10);

--*********************************************************************************
--Building_GlobalYieldModifiers
--*********************************************************************************
INSERT INTO Building_GlobalYieldModifiers
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_LABORATORY_VOCALOID'), YieldType, Yield
FROM Building_GlobalYieldModifiers WHERE (BuildingType = 'BUILDING_LABORATORY');

--*********************************************************************************
--Building_HurryModifiers
--*********************************************************************************
INSERT INTO Building_HurryModifiers
			(BuildingType, HurryType, HurryCostModifier)
SELECT		('BUILDING_LABORATORY_VOCALOID'), HurryType, HurryCostModifier
FROM Building_HurryModifiers WHERE (BuildingType = 'BUILDING_LABORATORY');

--*********************************************************************************
--Building_LocalResourceAnds
--*********************************************************************************
INSERT INTO Building_LocalResourceAnds
			(BuildingType, ResourceType)
SELECT		('BUILDING_LABORATORY_VOCALOID'), ResourceType
FROM Building_LocalResourceAnds WHERE (BuildingType = 'BUILDING_LABORATORY');

--*********************************************************************************
--Building_LocalResourceOrs
--*********************************************************************************
INSERT INTO Building_LocalResourceOrs
			(BuildingType, ResourceType)
SELECT		('BUILDING_LABORATORY_VOCALOID'), ResourceType
FROM Building_LocalResourceOrs WHERE (BuildingType = 'BUILDING_LABORATORY');

--*********************************************************************************
--Building_LockedBuildingClasses
--*********************************************************************************
INSERT INTO Building_LockedBuildingClasses
			(BuildingType, BuildingClassType)
SELECT		('BUILDING_LABORATORY_VOCALOID'), BuildingClassType
FROM Building_LockedBuildingClasses WHERE (BuildingType = 'BUILDING_LABORATORY');

--*********************************************************************************
--Building_PrereqBuildingClasses
--*********************************************************************************
INSERT INTO Building_PrereqBuildingClasses
			(BuildingType, BuildingClassType, NumBuildingNeeded)
SELECT		('BUILDING_LABORATORY_VOCALOID'), BuildingClassType, NumBuildingNeeded
FROM Building_PrereqBuildingClasses WHERE (BuildingType = 'BUILDING_LABORATORY');

--*********************************************************************************
--Building_ResourceQuantity
--*********************************************************************************
INSERT INTO Building_ResourceQuantity
			(BuildingType, ResourceType, Quantity)
SELECT		('BUILDING_LABORATORY_VOCALOID'), ResourceType, Quantity
FROM Building_ResourceQuantity WHERE (BuildingType = 'BUILDING_LABORATORY');

--*********************************************************************************
--Building_ResourceQuantityRequirements
--*********************************************************************************
INSERT INTO Building_ResourceQuantityRequirements
			(BuildingType, ResourceType, Cost)
SELECT		('BUILDING_LABORATORY_VOCALOID'), ResourceType, Cost
FROM Building_ResourceQuantityRequirements WHERE (BuildingType = 'BUILDING_LABORATORY');

--*********************************************************************************
--Building_ResourceYieldModifiers
--*********************************************************************************
INSERT INTO Building_ResourceYieldModifiers
			(BuildingType, ResourceType, YieldType, Yield)
SELECT		('BUILDING_LABORATORY_VOCALOID'), ResourceType, YieldType, Yield
FROM Building_ResourceYieldModifiers WHERE (BuildingType = 'BUILDING_LABORATORY');

--*********************************************************************************
--Building_ResourceCultureChanges
--*********************************************************************************
INSERT INTO Building_ResourceCultureChanges
			(BuildingType, ResourceType, CultureChange)
SELECT		('BUILDING_LABORATORY_VOCALOID'), ResourceType, CultureChange
FROM Building_ResourceCultureChanges WHERE (BuildingType = 'BUILDING_LABORATORY');

--*********************************************************************************
--Building_ResourceFaithChanges
--*********************************************************************************
INSERT INTO Building_ResourceFaithChanges
			(BuildingType, ResourceType, FaithChange)
SELECT		('BUILDING_LABORATORY_VOCALOID'), ResourceType, FaithChange
FROM Building_ResourceFaithChanges WHERE (BuildingType = 'BUILDING_LABORATORY');

--*********************************************************************************
--Building_RiverPlotYieldChanges
--*********************************************************************************
INSERT INTO Building_RiverPlotYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_LABORATORY_VOCALOID'), YieldType, Yield
FROM Building_RiverPlotYieldChanges WHERE (BuildingType = 'BUILDING_LABORATORY');

--*********************************************************************************
--Building_SeaPlotYieldChanges
--*********************************************************************************
INSERT INTO Building_SeaPlotYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_LABORATORY_VOCALOID'), YieldType, Yield
FROM Building_SeaPlotYieldChanges WHERE (BuildingType = 'BUILDING_LABORATORY');

--*********************************************************************************
--Building_LakePlotYieldChanges
--*********************************************************************************
INSERT INTO Building_LakePlotYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_LABORATORY_VOCALOID'), YieldType, Yield
FROM Building_LakePlotYieldChanges WHERE (BuildingType = 'BUILDING_LABORATORY');

--*********************************************************************************
--Building_SeaResourceYieldChanges
--*********************************************************************************
INSERT INTO Building_SeaResourceYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_LABORATORY_VOCALOID'), YieldType, Yield
FROM Building_SeaResourceYieldChanges WHERE (BuildingType = 'BUILDING_LABORATORY');

--*********************************************************************************
--Building_ResourceYieldChanges
--*********************************************************************************
INSERT INTO Building_ResourceYieldChanges
			(BuildingType, ResourceType, YieldType, Yield)
SELECT		('BUILDING_LABORATORY_VOCALOID'), ResourceType, YieldType, Yield
FROM Building_ResourceYieldChanges WHERE (BuildingType = 'BUILDING_LABORATORY');

--*********************************************************************************
--Building_FeatureYieldChanges
--*********************************************************************************
INSERT INTO Building_FeatureYieldChanges
			(BuildingType, FeatureType, YieldType, Yield)
SELECT		('BUILDING_LABORATORY_VOCALOID'), FeatureType, YieldType, Yield
FROM Building_FeatureYieldChanges WHERE (BuildingType = 'BUILDING_LABORATORY');

--*********************************************************************************
--Building_TerrainYieldChanges
--*********************************************************************************
INSERT INTO Building_TerrainYieldChanges
			(BuildingType, TerrainType, YieldType, Yield)
SELECT		('BUILDING_LABORATORY_VOCALOID'), TerrainType, YieldType, Yield
FROM Building_TerrainYieldChanges WHERE (BuildingType = 'BUILDING_LABORATORY');

--*********************************************************************************
--Building_SpecialistYieldChanges
--*********************************************************************************
INSERT INTO Building_SpecialistYieldChanges
			(BuildingType, SpecialistType, YieldType, Yield)
SELECT		('BUILDING_LABORATORY_VOCALOID'), SpecialistType, YieldType, Yield
FROM Building_SpecialistYieldChanges WHERE (BuildingType = 'BUILDING_LABORATORY');


--*********************************************************************************
--Building_UnitCombatFreeExperiences
--*********************************************************************************
INSERT INTO Building_UnitCombatFreeExperiences
			(BuildingType, UnitCombatType, Experience)
SELECT		('BUILDING_LABORATORY_VOCALOID'), UnitCombatType, Experience
FROM Building_UnitCombatFreeExperiences WHERE (BuildingType = 'BUILDING_LABORATORY');

--*********************************************************************************
--Building_UnitCombatProductionModifiers
--*********************************************************************************
INSERT INTO Building_UnitCombatProductionModifiers
			(BuildingType, UnitCombatType, Modifier)
SELECT		('BUILDING_LABORATORY_VOCALOID'), UnitCombatType, Modifier
FROM Building_UnitCombatProductionModifiers WHERE (BuildingType = 'BUILDING_LABORATORY');

--*********************************************************************************
--Building_TechAndPrereqs
--*********************************************************************************
INSERT INTO Building_TechAndPrereqs
			(BuildingType, TechType)
SELECT		('BUILDING_LABORATORY_VOCALOID'), TechType
FROM Building_TechAndPrereqs WHERE (BuildingType = 'BUILDING_LABORATORY');

--*********************************************************************************
--Building_YieldChanges
--*********************************************************************************
INSERT INTO Building_YieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_LABORATORY_VOCALOID'), YieldType, Yield
FROM Building_YieldChanges WHERE (BuildingType = 'BUILDING_LABORATORY');

--*********************************************************************************
--Building_YieldChangesPerPop
--*********************************************************************************
INSERT INTO Building_YieldChangesPerPop
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_LABORATORY_VOCALOID'), YieldType, Yield
FROM Building_YieldChangesPerPop WHERE (BuildingType = 'BUILDING_LABORATORY');

--*********************************************************************************
--Building_YieldChangesPerReligion
--*********************************************************************************
INSERT INTO Building_YieldChangesPerReligion
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_LABORATORY_VOCALOID'), YieldType, Yield
FROM Building_YieldChangesPerReligion WHERE (BuildingType = 'BUILDING_LABORATORY');

--*********************************************************************************
--Building_TechEnhancedYieldChanges
--*********************************************************************************
INSERT INTO Building_TechEnhancedYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_LABORATORY_VOCALOID'), YieldType, Yield
FROM Building_TechEnhancedYieldChanges WHERE (BuildingType = 'BUILDING_LABORATORY');


--*********************************************************************************
--Building_YieldModifiers
--*********************************************************************************
INSERT INTO Building_YieldModifiers
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_LABORATORY_VOCALOID'), YieldType, Yield
FROM Building_YieldModifiers WHERE (BuildingType = 'BUILDING_LABORATORY');

--*********************************************************************************
--Building_ThemingBonuses
--*********************************************************************************
INSERT INTO Building_ThemingBonuses
			(BuildingType, Description, Bonus, SameEra, UniqueEras, MustBeArt, MustBeArtifact, MustBeEqualArtArtifact, RequiresOwner, RequiresAnyButOwner, RequiresSamePlayer, RequiresUniquePlayers, AIPriority)
SELECT		('BUILDING_LABORATORY_VOCALOID'), Description, Bonus, SameEra, UniqueEras, MustBeArt, MustBeArtifact, MustBeEqualArtArtifact, RequiresOwner, RequiresAnyButOwner, RequiresSamePlayer, RequiresUniquePlayers, AIPriority
FROM Building_ThemingBonuses WHERE (BuildingType = 'BUILDING_LABORATORY');




UPDATE Buildings
SET SpecialistType = 'SPECIALIST_MUSICIAN'
WHERE Type = 'BUILDING_LIBRARY_VOCALOID' OR Type = 'BUILDING_UNIVERSITY_VOCALOID' OR Type = 'BUILDING_PUBLIC_SCHOOL_VOCALOID' OR Type = 'BUILDING_LABORATORY_VOCALOID';

UPDATE Buildings
SET SpecialistCount = 1
WHERE Type = 'BUILDING_LIBRARY_VOCALOID';

UPDATE Buildings
SET SpecialistCount = 1
WHERE Type = 'BUILDING_UNIVERSITY_VOCALOID';


UPDATE Buildings
SET GreatWorkSlotType = 'GREAT_WORK_SLOT_MUSIC', GreatWorkCount = 2, ThemingBonusHelp = 'TXT_KEY_VOCALOID_THEMING_BONUS_HELP'
WHERE Type = 'BUILDING_CIRCUS_MAXIMUS_VOCALOID' OR Type = 'BUILDING_NATIONAL_TREASURY_VOCALOID' OR Type = 'BUILDING_IRONWORKS_VOCALOID' OR Type = 'BUILDING_GRAND_TEMPLE_VOCALOID';


INSERT INTO Building_ThemingBonuses
			(BuildingType, 							Description)
VALUES		('BUILDING_CIRCUS_MAXIMUS_VOCALOID',	'TXT_KEY_THEMING_BONUS_CIRCUS_MAXIMUS_VOCALOID'),
			('BUILDING_NATIONAL_TREASURY_VOCALOID',	'TXT_KEY_THEMING_BONUS_NATIONAL_TREASURY_VOCALOID'),
			('BUILDING_IRONWORKS_VOCALOID',			'TXT_KEY_THEMING_BONUS_IRONWORKS_VOCALOID'),
			('BUILDING_GRAND_TEMPLE_VOCALOID',		'TXT_KEY_THEMING_BONUS_GRAND_TEMPLE_VOCALOID');
			
			
UPDATE Building_ThemingBonuses
SET Bonus = 2, SameEra = 1,	RequiresSamePlayer = 1,	AIPriority = 5
WHERE (instr(BuildingType, '_VOCALOID') > 0);





