--*********************************************************************************
--BuildingClasses
--*********************************************************************************
INSERT INTO BuildingClasses
			(Type,							DefaultBuilding,		MaxPlayerInstances)
VALUES		('BUILDINGCLASS_PMMM_FREEZER', 'BUILDING_PMMM_FREEZER',	1);


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
SELECT		('BUILDING_PMMM_ANGELICA_BEARS'), ('TXT_KEY_BUILDING_PMMM_ANGELICA_BEARS'), ('TXT_KEY_BUILDING_PMMM_ANGELICA_BEARS_TEXT'), ('TXT_KEY_BUILDING_PMMM_ANGELICA_BEARS_STRATEGY'),
			('TXT_KEY_BUILDING_PMMM_ANGELICA_BEARS_HELP'), ThemingBonusHelp, Quote, GoldMaintenance, MutuallyExclusiveGroup, TeamShare, Water, River, 
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
			SpecialistExtraCulture, GreatPeopleRateChange, ExtraLeagueVotes, CityWall, DisplayPosition, 3, WonderSplashImage, WonderSplashAnchor,
			WonderSplashAudio, ('CIV_COLOR_ATLAS_KAORU_UMIKA'), ArtInfoCulturalVariation, ArtInfoEraVariation, ArtInfoRandomVariation
FROM Buildings WHERE (Type = 'BUILDING_PMMM_AMUSEMENT_PARK');

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
SELECT		('BUILDING_PMMM_FREEZER'), ('TXT_KEY_BUILDING_PMMM_FREEZER'), ('TXT_KEY_BUILDING_PMMM_FREEZER_TEXT'), ('TXT_KEY_BUILDING_PMMM_FREEZER_STRATEGY'),
			('TXT_KEY_BUILDING_PMMM_FREEZER_HELP'), ThemingBonusHelp, Quote, 0, MutuallyExclusiveGroup, TeamShare, Water, River, 
			FreshWater, Mountain, NearbyMountainRequired, Hill, Flat, FoundsReligion, IsReligious, BorderObstacle, PlayerBorderObstacle, 1, GoldenAge, 
			MapCentering, 1, 1, AllowsWaterRoutes, ExtraLuxuries, DiplomaticVoting, AffectSpiesNow, NullifyInfluenceModifier, -1, FaithCost, 
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
			WonderSplashAudio, ('CIV_COLOR_ATLAS_KAORU_UMIKA'), ArtInfoCulturalVariation, ArtInfoEraVariation, ArtInfoRandomVariation
FROM Buildings WHERE (Type = 'BUILDING_MONUMENT');


UPDATE Buildings
SET PMMMEntertainment = PMMMEntertainment + 1
WHERE Type = 'BUILDING_PMMM_ANGELICA_BEARS';


--*********************************************************************************
--Building_AreaYieldModifiers
--*********************************************************************************
INSERT INTO Building_AreaYieldModifiers
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_PMMM_ANGELICA_BEARS'), YieldType, Yield
FROM Building_AreaYieldModifiers WHERE (BuildingType = 'BUILDING_PMMM_AMUSEMENT_PARK');


--*********************************************************************************
--Building_BuildingClassHappiness
--*********************************************************************************
INSERT INTO Building_BuildingClassHappiness
			(BuildingType, BuildingClassType, Happiness)
SELECT		('BUILDING_PMMM_ANGELICA_BEARS'), BuildingClassType, Happiness
FROM Building_BuildingClassHappiness WHERE (BuildingType = 'BUILDING_PMMM_AMUSEMENT_PARK');

--*********************************************************************************
--Building_BuildingClassYieldChanges
--*********************************************************************************
INSERT INTO Building_BuildingClassYieldChanges
			(BuildingType, BuildingClassType, YieldType, YieldChange)
SELECT		('BUILDING_PMMM_ANGELICA_BEARS'), BuildingClassType, YieldType, YieldChange
FROM Building_BuildingClassYieldChanges WHERE (BuildingType = 'BUILDING_PMMM_AMUSEMENT_PARK');

--*********************************************************************************
--Building_ClassesNeededInCity
--*********************************************************************************
INSERT INTO Building_ClassesNeededInCity
			(BuildingType, BuildingClassType)
SELECT		('BUILDING_PMMM_ANGELICA_BEARS'), BuildingClassType
FROM Building_ClassesNeededInCity WHERE (BuildingType = 'BUILDING_PMMM_AMUSEMENT_PARK');

--*********************************************************************************
--Building_FreeUnits
--*********************************************************************************
INSERT INTO Building_FreeUnits
			(BuildingType, UnitType, NumUnits)
SELECT		('BUILDING_PMMM_ANGELICA_BEARS'), UnitType, NumUnits
FROM Building_FreeUnits WHERE (BuildingType = 'BUILDING_PMMM_AMUSEMENT_PARK');

--*********************************************************************************
--Building_DomainFreeExperiences
--*********************************************************************************
INSERT INTO Building_DomainFreeExperiences
			(BuildingType, DomainType, Experience)
SELECT		('BUILDING_PMMM_ANGELICA_BEARS'), DomainType, Experience
FROM Building_DomainFreeExperiences WHERE (BuildingType = 'BUILDING_PMMM_AMUSEMENT_PARK');

--*********************************************************************************
--Building_DomainFreeExperiencePerGreatWork
--*********************************************************************************
INSERT INTO Building_DomainFreeExperiencePerGreatWork
			(BuildingType, DomainType, Experience)
SELECT		('BUILDING_PMMM_ANGELICA_BEARS'), DomainType, Experience
FROM Building_DomainFreeExperiencePerGreatWork WHERE (BuildingType = 'BUILDING_PMMM_AMUSEMENT_PARK');

--*********************************************************************************
--Building_DomainProductionModifiers
--*********************************************************************************
INSERT INTO Building_DomainProductionModifiers
			(BuildingType, DomainType, Modifier)
SELECT		('BUILDING_PMMM_ANGELICA_BEARS'), DomainType, Modifier
FROM Building_DomainProductionModifiers WHERE (BuildingType = 'BUILDING_PMMM_AMUSEMENT_PARK');

--*********************************************************************************
--Building_FreeSpecialistCounts
--*********************************************************************************
INSERT INTO Building_FreeSpecialistCounts
			(BuildingType, SpecialistType, Count)
SELECT		('BUILDING_PMMM_ANGELICA_BEARS'), SpecialistType, Count
FROM Building_FreeSpecialistCounts WHERE (BuildingType = 'BUILDING_PMMM_AMUSEMENT_PARK');

--*********************************************************************************
--Building_Flavors
--*********************************************************************************
INSERT INTO Building_Flavors
			(BuildingType, FlavorType, Flavor)
SELECT		('BUILDING_PMMM_ANGELICA_BEARS'), FlavorType, Flavor+5
FROM Building_Flavors WHERE (BuildingType = 'BUILDING_PMMM_AMUSEMENT_PARK');

INSERT INTO Building_Flavors
VALUES		('BUILDING_PMMM_ANGELICA_BEARS', 'FLAVOR_AIRLIFT', 10);

--*********************************************************************************
--Building_GlobalYieldModifiers
--*********************************************************************************
INSERT INTO Building_GlobalYieldModifiers
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_PMMM_ANGELICA_BEARS'), YieldType, Yield
FROM Building_GlobalYieldModifiers WHERE (BuildingType = 'BUILDING_PMMM_AMUSEMENT_PARK');

--*********************************************************************************
--Building_HurryModifiers
--*********************************************************************************
INSERT INTO Building_HurryModifiers
			(BuildingType, HurryType, HurryCostModifier)
SELECT		('BUILDING_PMMM_ANGELICA_BEARS'), HurryType, HurryCostModifier
FROM Building_HurryModifiers WHERE (BuildingType = 'BUILDING_PMMM_AMUSEMENT_PARK');

--*********************************************************************************
--Building_LocalResourceAnds
--*********************************************************************************
INSERT INTO Building_LocalResourceAnds
			(BuildingType, ResourceType)
SELECT		('BUILDING_PMMM_ANGELICA_BEARS'), ResourceType
FROM Building_LocalResourceAnds WHERE (BuildingType = 'BUILDING_PMMM_AMUSEMENT_PARK');

--*********************************************************************************
--Building_LocalResourceOrs
--*********************************************************************************
INSERT INTO Building_LocalResourceOrs
			(BuildingType, ResourceType)
SELECT		('BUILDING_PMMM_ANGELICA_BEARS'), ResourceType
FROM Building_LocalResourceOrs WHERE (BuildingType = 'BUILDING_PMMM_AMUSEMENT_PARK');

--*********************************************************************************
--Building_LockedBuildingClasses
--*********************************************************************************
INSERT INTO Building_LockedBuildingClasses
			(BuildingType, BuildingClassType)
SELECT		('BUILDING_PMMM_ANGELICA_BEARS'), BuildingClassType
FROM Building_LockedBuildingClasses WHERE (BuildingType = 'BUILDING_PMMM_AMUSEMENT_PARK');

--*********************************************************************************
--Building_PrereqBuildingClasses
--*********************************************************************************
INSERT INTO Building_PrereqBuildingClasses
			(BuildingType, BuildingClassType, NumBuildingNeeded)
SELECT		('BUILDING_PMMM_ANGELICA_BEARS'), BuildingClassType, NumBuildingNeeded
FROM Building_PrereqBuildingClasses WHERE (BuildingType = 'BUILDING_PMMM_AMUSEMENT_PARK');

--*********************************************************************************
--Building_ResourceQuantity
--*********************************************************************************
INSERT INTO Building_ResourceQuantity
			(BuildingType, ResourceType, Quantity)
SELECT		('BUILDING_PMMM_ANGELICA_BEARS'), ResourceType, Quantity
FROM Building_ResourceQuantity WHERE (BuildingType = 'BUILDING_PMMM_AMUSEMENT_PARK');

INSERT INTO Building_ResourceQuantity
			(BuildingType, ResourceType, Quantity)
VALUES		('BUILDING_PMMM_ANGELICA_BEARS', 'RESOURCE_PMMM_TEDDY_BEAR', 1);

--*********************************************************************************
--Building_ResourceQuantityRequirements
--*********************************************************************************
INSERT INTO Building_ResourceQuantityRequirements
			(BuildingType, ResourceType, Cost)
SELECT		('BUILDING_PMMM_ANGELICA_BEARS'), ResourceType, Cost
FROM Building_ResourceQuantityRequirements WHERE (BuildingType = 'BUILDING_PMMM_AMUSEMENT_PARK');

--*********************************************************************************
--Building_ResourceYieldModifiers
--*********************************************************************************
INSERT INTO Building_ResourceYieldModifiers
			(BuildingType, ResourceType, YieldType, Yield)
SELECT		('BUILDING_PMMM_ANGELICA_BEARS'), ResourceType, YieldType, Yield
FROM Building_ResourceYieldModifiers WHERE (BuildingType = 'BUILDING_PMMM_AMUSEMENT_PARK');

--*********************************************************************************
--Building_ResourceCultureChanges
--*********************************************************************************
INSERT INTO Building_ResourceCultureChanges
			(BuildingType, ResourceType, CultureChange)
SELECT		('BUILDING_PMMM_ANGELICA_BEARS'), ResourceType, CultureChange
FROM Building_ResourceCultureChanges WHERE (BuildingType = 'BUILDING_PMMM_AMUSEMENT_PARK');

--*********************************************************************************
--Building_ResourceFaithChanges
--*********************************************************************************
INSERT INTO Building_ResourceFaithChanges
			(BuildingType, ResourceType, FaithChange)
SELECT		('BUILDING_PMMM_ANGELICA_BEARS'), ResourceType, FaithChange
FROM Building_ResourceFaithChanges WHERE (BuildingType = 'BUILDING_PMMM_AMUSEMENT_PARK');

--*********************************************************************************
--Building_RiverPlotYieldChanges
--*********************************************************************************
INSERT INTO Building_RiverPlotYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_PMMM_ANGELICA_BEARS'), YieldType, Yield
FROM Building_RiverPlotYieldChanges WHERE (BuildingType = 'BUILDING_PMMM_AMUSEMENT_PARK');

--*********************************************************************************
--Building_SeaPlotYieldChanges
--*********************************************************************************
INSERT INTO Building_SeaPlotYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_PMMM_ANGELICA_BEARS'), YieldType, Yield
FROM Building_SeaPlotYieldChanges WHERE (BuildingType = 'BUILDING_PMMM_AMUSEMENT_PARK');

--*********************************************************************************
--Building_LakePlotYieldChanges
--*********************************************************************************
INSERT INTO Building_LakePlotYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_PMMM_ANGELICA_BEARS'), YieldType, Yield
FROM Building_LakePlotYieldChanges WHERE (BuildingType = 'BUILDING_PMMM_AMUSEMENT_PARK');

--*********************************************************************************
--Building_SeaResourceYieldChanges
--*********************************************************************************
INSERT INTO Building_SeaResourceYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_PMMM_ANGELICA_BEARS'), YieldType, Yield
FROM Building_SeaResourceYieldChanges WHERE (BuildingType = 'BUILDING_PMMM_AMUSEMENT_PARK');

--*********************************************************************************
--Building_ResourceYieldChanges
--*********************************************************************************
INSERT INTO Building_ResourceYieldChanges
			(BuildingType, ResourceType, YieldType, Yield)
SELECT		('BUILDING_PMMM_ANGELICA_BEARS'), ResourceType, YieldType, Yield
FROM Building_ResourceYieldChanges WHERE (BuildingType = 'BUILDING_PMMM_AMUSEMENT_PARK');

--*********************************************************************************
--Building_FeatureYieldChanges
--*********************************************************************************
INSERT INTO Building_FeatureYieldChanges
			(BuildingType, FeatureType, YieldType, Yield)
SELECT		('BUILDING_PMMM_ANGELICA_BEARS'), FeatureType, YieldType, Yield
FROM Building_FeatureYieldChanges WHERE (BuildingType = 'BUILDING_PMMM_AMUSEMENT_PARK');

--*********************************************************************************
--Building_TerrainYieldChanges
--*********************************************************************************
INSERT INTO Building_TerrainYieldChanges
			(BuildingType, TerrainType, YieldType, Yield)
SELECT		('BUILDING_PMMM_ANGELICA_BEARS'), TerrainType, YieldType, Yield
FROM Building_TerrainYieldChanges WHERE (BuildingType = 'BUILDING_PMMM_AMUSEMENT_PARK');

--*********************************************************************************
--Building_SpecialistYieldChanges
--*********************************************************************************
INSERT INTO Building_SpecialistYieldChanges
			(BuildingType, SpecialistType, YieldType, Yield)
SELECT		('BUILDING_PMMM_ANGELICA_BEARS'), SpecialistType, YieldType, Yield
FROM Building_SpecialistYieldChanges WHERE (BuildingType = 'BUILDING_PMMM_AMUSEMENT_PARK');


--*********************************************************************************
--Building_UnitCombatFreeExperiences
--*********************************************************************************
INSERT INTO Building_UnitCombatFreeExperiences
			(BuildingType, UnitCombatType, Experience)
SELECT		('BUILDING_PMMM_ANGELICA_BEARS'), UnitCombatType, Experience
FROM Building_UnitCombatFreeExperiences WHERE (BuildingType = 'BUILDING_PMMM_AMUSEMENT_PARK');

--*********************************************************************************
--Building_UnitCombatProductionModifiers
--*********************************************************************************
INSERT INTO Building_UnitCombatProductionModifiers
			(BuildingType, UnitCombatType, Modifier)
SELECT		('BUILDING_PMMM_ANGELICA_BEARS'), UnitCombatType, Modifier
FROM Building_UnitCombatProductionModifiers WHERE (BuildingType = 'BUILDING_PMMM_AMUSEMENT_PARK');

--*********************************************************************************
--Building_TechAndPrereqs
--*********************************************************************************
INSERT INTO Building_TechAndPrereqs
			(BuildingType, TechType)
SELECT		('BUILDING_PMMM_ANGELICA_BEARS'), TechType
FROM Building_TechAndPrereqs WHERE (BuildingType = 'BUILDING_PMMM_AMUSEMENT_PARK');

--*********************************************************************************
--Building_YieldChanges
--*********************************************************************************
INSERT INTO Building_YieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_PMMM_ANGELICA_BEARS'), YieldType, Yield
FROM Building_YieldChanges WHERE (BuildingType = 'BUILDING_PMMM_AMUSEMENT_PARK');

INSERT INTO Building_YieldChanges
			(BuildingType,						YieldType,			Yield)
VALUES		('BUILDING_PMMM_ANGELICA_BEARS',	'YIELD_CULTURE',	2),
			('BUILDING_PMMM_ANGELICA_BEARS',	'YIELD_TOURISM',	1);

--*********************************************************************************
--Building_YieldChangesPerPop
--*********************************************************************************
INSERT INTO Building_YieldChangesPerPop
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_PMMM_ANGELICA_BEARS'), YieldType, Yield
FROM Building_YieldChangesPerPop WHERE (BuildingType = 'BUILDING_PMMM_AMUSEMENT_PARK');

--*********************************************************************************
--Building_YieldChangesPerReligion
--*********************************************************************************
INSERT INTO Building_YieldChangesPerReligion
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_PMMM_ANGELICA_BEARS'), YieldType, Yield
FROM Building_YieldChangesPerReligion WHERE (BuildingType = 'BUILDING_PMMM_AMUSEMENT_PARK');

--*********************************************************************************
--Building_TechEnhancedYieldChanges
--*********************************************************************************
INSERT INTO Building_TechEnhancedYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_PMMM_ANGELICA_BEARS'), YieldType, Yield
FROM Building_TechEnhancedYieldChanges WHERE (BuildingType = 'BUILDING_PMMM_AMUSEMENT_PARK');


--*********************************************************************************
--Building_YieldModifiers
--*********************************************************************************
INSERT INTO Building_YieldModifiers
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_PMMM_ANGELICA_BEARS'), YieldType, Yield
FROM Building_YieldModifiers WHERE (BuildingType = 'BUILDING_PMMM_AMUSEMENT_PARK');

--*********************************************************************************
--Building_ThemingBonuses
--*********************************************************************************
INSERT INTO Building_ThemingBonuses
			(BuildingType, Description, Bonus, SameEra, UniqueEras, MustBeArt, MustBeArtifact, MustBeEqualArtArtifact, RequiresOwner, RequiresAnyButOwner, RequiresSamePlayer, RequiresUniquePlayers, AIPriority)
SELECT		('BUILDING_PMMM_ANGELICA_BEARS'), Description, Bonus, SameEra, UniqueEras, MustBeArt, MustBeArtifact, MustBeEqualArtArtifact, RequiresOwner, RequiresAnyButOwner, RequiresSamePlayer, RequiresUniquePlayers, AIPriority
FROM Building_ThemingBonuses WHERE (BuildingType = 'BUILDING_PMMM_AMUSEMENT_PARK');





