-- "Unique" Pyramids replacement to prevent crashes

CREATE TABLE IF NOT EXISTS COMMUNITY(Type, Value);


INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 				BuildingClassType, 			BuildingType)
SELECT		('CIVILIZATION_VV_PLANEPTUNE'), ('BUILDINGCLASS_PYRAMID'), 	('BUILDING_PYRAMID_VV_NEPTUNE')
WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );


--*********************************************************************************
--Buildings
--*********************************************************************************

INSERT INTO Buildings
			(Type,								Description, Civilopedia, Strategy, Help, ThemingBonusHelp, Quote, GoldMaintenance, MutuallyExclusiveGroup, TeamShare, Water, River, 
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
SELECT		('BUILDING_PYRAMID_VV_NEPTUNE'),	Description, Civilopedia, Strategy, Help, ThemingBonusHelp, Quote, GoldMaintenance, MutuallyExclusiveGroup, TeamShare, Water, River, 
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
FROM Buildings WHERE (Type = 'BUILDING_PYRAMID') AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );


--*********************************************************************************
--Building_AreaYieldModifiers
--*********************************************************************************
INSERT INTO Building_AreaYieldModifiers
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), YieldType, Yield
FROM Building_AreaYieldModifiers WHERE (BuildingType = 'BUILDING_PYRAMID') AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );


--*********************************************************************************
--Building_BuildingClassHappiness
--*********************************************************************************
INSERT INTO Building_BuildingClassHappiness
			(BuildingType, BuildingClassType, Happiness)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), BuildingClassType, Happiness
FROM Building_BuildingClassHappiness WHERE (BuildingType = 'BUILDING_PYRAMID') AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

--*********************************************************************************
--Building_BuildingClassYieldChanges
--*********************************************************************************
INSERT INTO Building_BuildingClassYieldChanges
			(BuildingType, BuildingClassType, YieldType, YieldChange)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), BuildingClassType, YieldType, YieldChange
FROM Building_BuildingClassYieldChanges WHERE (BuildingType = 'BUILDING_PYRAMID') AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

--*********************************************************************************
--Building_ClassesNeededInCity
--*********************************************************************************
INSERT INTO Building_ClassesNeededInCity
			(BuildingType, BuildingClassType)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), BuildingClassType
FROM Building_ClassesNeededInCity WHERE (BuildingType = 'BUILDING_PYRAMID') AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

--*********************************************************************************
--Building_FreeUnits
--*********************************************************************************
INSERT INTO Building_FreeUnits
			(BuildingType, UnitType, NumUnits)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), UnitType, NumUnits
FROM Building_FreeUnits WHERE (BuildingType = 'BUILDING_PYRAMID') AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 ) AND UnitType NOT LIKE ('UNIT_SETTLER');

--*********************************************************************************
--Building_DomainFreeExperiences
--*********************************************************************************
INSERT INTO Building_DomainFreeExperiences
			(BuildingType, DomainType, Experience)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), DomainType, Experience
FROM Building_DomainFreeExperiences WHERE (BuildingType = 'BUILDING_PYRAMID') AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

--*********************************************************************************
--Building_DomainFreeExperiencePerGreatWork
--*********************************************************************************
INSERT INTO Building_DomainFreeExperiencePerGreatWork
			(BuildingType, DomainType, Experience)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), DomainType, Experience
FROM Building_DomainFreeExperiencePerGreatWork WHERE (BuildingType = 'BUILDING_PYRAMID') AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

--*********************************************************************************
--Building_DomainProductionModifiers
--*********************************************************************************
INSERT INTO Building_DomainProductionModifiers
			(BuildingType, DomainType, Modifier)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), DomainType, Modifier
FROM Building_DomainProductionModifiers WHERE (BuildingType = 'BUILDING_PYRAMID') AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

--*********************************************************************************
--Building_FreeSpecialistCounts
--*********************************************************************************
INSERT INTO Building_FreeSpecialistCounts
			(BuildingType, SpecialistType, Count)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), SpecialistType, Count
FROM Building_FreeSpecialistCounts WHERE (BuildingType = 'BUILDING_PYRAMID') AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

--*********************************************************************************
--Building_Flavors
--*********************************************************************************
INSERT INTO Building_Flavors
			(BuildingType, FlavorType, Flavor)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), FlavorType, Flavor
FROM Building_Flavors WHERE (BuildingType = 'BUILDING_PYRAMID') AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

--*********************************************************************************
--Building_GlobalYieldModifiers
--*********************************************************************************
INSERT INTO Building_GlobalYieldModifiers
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), YieldType, Yield
FROM Building_GlobalYieldModifiers WHERE (BuildingType = 'BUILDING_PYRAMID') AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

--*********************************************************************************
--Building_HurryModifiers
--*********************************************************************************
INSERT INTO Building_HurryModifiers
			(BuildingType,				HurryType, HurryCostModifier)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), HurryType, HurryCostModifier
FROM Building_HurryModifiers WHERE (BuildingType = 'BUILDING_PYRAMID') AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

--*********************************************************************************
--Building_LocalResourceAnds
--*********************************************************************************
INSERT INTO Building_LocalResourceAnds
			(BuildingType, ResourceType)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), ResourceType
FROM Building_LocalResourceAnds WHERE (BuildingType = 'BUILDING_PYRAMID') AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

--*********************************************************************************
--Building_LocalResourceOrs
--*********************************************************************************
INSERT INTO Building_LocalResourceOrs
			(BuildingType, ResourceType)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), ResourceType
FROM Building_LocalResourceOrs WHERE (BuildingType = 'BUILDING_PYRAMID') AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

--*********************************************************************************
--Building_LockedBuildingClasses
--*********************************************************************************
INSERT INTO Building_LockedBuildingClasses
			(BuildingType, BuildingClassType)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), BuildingClassType
FROM Building_LockedBuildingClasses WHERE (BuildingType = 'BUILDING_PYRAMID') AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

--*********************************************************************************
--Building_PrereqBuildingClasses
--*********************************************************************************
INSERT INTO Building_PrereqBuildingClasses
			(BuildingType, BuildingClassType, NumBuildingNeeded)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), BuildingClassType, NumBuildingNeeded
FROM Building_PrereqBuildingClasses WHERE (BuildingType = 'BUILDING_PYRAMID') AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

--*********************************************************************************
--Building_ResourceQuantity
--*********************************************************************************
INSERT INTO Building_ResourceQuantity
			(BuildingType, ResourceType, Quantity)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), ResourceType, Quantity
FROM Building_ResourceQuantity WHERE (BuildingType = 'BUILDING_PYRAMID') AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

--*********************************************************************************
--Building_ResourceQuantityRequirements
--*********************************************************************************
INSERT INTO Building_ResourceQuantityRequirements
			(BuildingType, ResourceType, Cost)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), ResourceType, Cost
FROM Building_ResourceQuantityRequirements WHERE (BuildingType = 'BUILDING_PYRAMID') AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

--*********************************************************************************
--Building_ResourceYieldModifiers
--*********************************************************************************
INSERT INTO Building_ResourceYieldModifiers
			(BuildingType, ResourceType, YieldType, Yield)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), ResourceType, YieldType, Yield
FROM Building_ResourceYieldModifiers WHERE (BuildingType = 'BUILDING_PYRAMID') AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

--*********************************************************************************
--Building_ResourceCultureChanges
--*********************************************************************************
INSERT INTO Building_ResourceCultureChanges
			(BuildingType, ResourceType, CultureChange)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), ResourceType, CultureChange
FROM Building_ResourceCultureChanges WHERE (BuildingType = 'BUILDING_PYRAMID') AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

--*********************************************************************************
--Building_ResourceFaithChanges
--*********************************************************************************
INSERT INTO Building_ResourceFaithChanges
			(BuildingType, ResourceType, FaithChange)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), ResourceType, FaithChange
FROM Building_ResourceFaithChanges WHERE (BuildingType = 'BUILDING_PYRAMID') AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

--*********************************************************************************
--Building_RiverPlotYieldChanges
--*********************************************************************************
INSERT INTO Building_RiverPlotYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), YieldType, Yield
FROM Building_RiverPlotYieldChanges WHERE (BuildingType = 'BUILDING_PYRAMID') AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

--*********************************************************************************
--Building_SeaPlotYieldChanges
--*********************************************************************************
INSERT INTO Building_SeaPlotYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), YieldType, Yield
FROM Building_SeaPlotYieldChanges WHERE (BuildingType = 'BUILDING_PYRAMID') AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

--*********************************************************************************
--Building_LakePlotYieldChanges
--*********************************************************************************
INSERT INTO Building_LakePlotYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), YieldType, Yield
FROM Building_LakePlotYieldChanges WHERE (BuildingType = 'BUILDING_PYRAMID') AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

--*********************************************************************************
--Building_SeaResourceYieldChanges
--*********************************************************************************
INSERT INTO Building_SeaResourceYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), YieldType, Yield
FROM Building_SeaResourceYieldChanges WHERE (BuildingType = 'BUILDING_PYRAMID') AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

--*********************************************************************************
--Building_ResourceYieldChanges
--*********************************************************************************
INSERT INTO Building_ResourceYieldChanges
			(BuildingType, ResourceType, YieldType, Yield)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), ResourceType, YieldType, Yield
FROM Building_ResourceYieldChanges WHERE (BuildingType = 'BUILDING_PYRAMID') AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

--*********************************************************************************
--Building_FeatureYieldChanges
--*********************************************************************************
INSERT INTO Building_FeatureYieldChanges
			(BuildingType, FeatureType, YieldType, Yield)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), FeatureType, YieldType, Yield
FROM Building_FeatureYieldChanges WHERE (BuildingType = 'BUILDING_PYRAMID') AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

--*********************************************************************************
--Building_TerrainYieldChanges
--*********************************************************************************
INSERT INTO Building_TerrainYieldChanges
			(BuildingType, TerrainType, YieldType, Yield)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), TerrainType, YieldType, Yield
FROM Building_TerrainYieldChanges WHERE (BuildingType = 'BUILDING_PYRAMID') AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

--*********************************************************************************
--Building_SpecialistYieldChanges
--*********************************************************************************
INSERT INTO Building_SpecialistYieldChanges
			(BuildingType, SpecialistType, YieldType, Yield)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), SpecialistType, YieldType, Yield
FROM Building_SpecialistYieldChanges WHERE (BuildingType = 'BUILDING_PYRAMID') AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );


--*********************************************************************************
--Building_UnitCombatFreeExperiences
--*********************************************************************************
INSERT INTO Building_UnitCombatFreeExperiences
			(BuildingType, UnitCombatType, Experience)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), UnitCombatType, Experience
FROM Building_UnitCombatFreeExperiences WHERE (BuildingType = 'BUILDING_PYRAMID') AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

--*********************************************************************************
--Building_UnitCombatProductionModifiers
--*********************************************************************************
INSERT INTO Building_UnitCombatProductionModifiers
			(BuildingType, UnitCombatType, Modifier)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), UnitCombatType, Modifier
FROM Building_UnitCombatProductionModifiers WHERE (BuildingType = 'BUILDING_PYRAMID') AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

--*********************************************************************************
--Building_TechAndPrereqs
--*********************************************************************************
INSERT INTO Building_TechAndPrereqs
			(BuildingType, TechType)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), TechType
FROM Building_TechAndPrereqs WHERE (BuildingType = 'BUILDING_PYRAMID') AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

--*********************************************************************************
--Building_YieldChanges
--*********************************************************************************
INSERT INTO Building_YieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), YieldType, Yield
FROM Building_YieldChanges WHERE (BuildingType = 'BUILDING_PYRAMID') AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

--*********************************************************************************
--Building_YieldChangesPerPop
--*********************************************************************************
INSERT INTO Building_YieldChangesPerPop
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), YieldType, Yield
FROM Building_YieldChangesPerPop WHERE (BuildingType = 'BUILDING_PYRAMID') AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

--*********************************************************************************
--Building_YieldChangesPerReligion
--*********************************************************************************
INSERT INTO Building_YieldChangesPerReligion
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), YieldType, Yield
FROM Building_YieldChangesPerReligion WHERE (BuildingType = 'BUILDING_PYRAMID') AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

--*********************************************************************************
--Building_TechEnhancedYieldChanges
--*********************************************************************************
INSERT INTO Building_TechEnhancedYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), YieldType, Yield
FROM Building_TechEnhancedYieldChanges WHERE (BuildingType = 'BUILDING_PYRAMID') AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );


--*********************************************************************************
--Building_YieldModifiers
--*********************************************************************************
INSERT INTO Building_YieldModifiers
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_VV_PUDDING_PARLOR'), YieldType, Yield
FROM Building_YieldModifiers WHERE (BuildingType = 'BUILDING_PYRAMID') AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );


