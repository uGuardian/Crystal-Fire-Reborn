--*********************************************************************************
--BuildingClasses (dummies)
--*********************************************************************************
INSERT INTO BuildingClasses
			(Type,											DefaultBuilding,							NoLimit)
VALUES		('BUILDINGCLASS_PMMM_CUTLASS_CONDUCTOR_DUMMY',	'BUILDING_PMMM_CUTLASS_CONDUCTOR_DUMMY',	1);

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
SELECT		('BUILDING_PMMM_STAGE_OF_OKTAVIA'), ('TXT_KEY_BUILDING_PMMM_STAGE_OF_OKTAVIA'), ('TXT_KEY_BUILDING_PMMM_STAGE_OF_OKTAVIA_TEXT'), ('TXT_KEY_BUILDING_PMMM_STAGE_OF_OKTAVIA_STRATEGY'),
			('TXT_KEY_BUILDING_PMMM_STAGE_OF_OKTAVIA_HELP'), ThemingBonusHelp, Quote, GoldMaintenance, MutuallyExclusiveGroup, TeamShare, Water, River, 
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
			WonderSplashAudio, ('CIV_COLOR_ATLAS_SAYAKA'), ArtInfoCulturalVariation, ArtInfoEraVariation, ArtInfoRandomVariation
FROM Buildings WHERE (Type = 'BUILDING_OPERA_HOUSE');

--Enhanced Tourism/Culture upon Combined Arms
UPDATE Buildings
SET EnhancedYieldTech	= 'TECH_COMBINED_ARMS', TechEnhancedTourism = 2
WHERE Type = 'BUILDING_PMMM_STAGE_OF_OKTAVIA';


--Dummies
INSERT INTO Buildings
			(Type,										BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune, GreatWorksTourismModifier)
VALUES		('BUILDING_PMMM_CUTLASS_CONDUCTOR_DUMMY',	'BUILDINGCLASS_PMMM_CUTLASS_CONDUCTOR_DUMMY',
			-1,		-1,			-1,				null,		1,				1,	100);

--*********************************************************************************
--Building_AreaYieldModifiers
--*********************************************************************************
INSERT INTO Building_AreaYieldModifiers
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_PMMM_STAGE_OF_OKTAVIA'), YieldType, Yield
FROM Building_AreaYieldModifiers WHERE (BuildingType = 'BUILDING_OPERA_HOUSE');


--*********************************************************************************
--Building_BuildingClassHappiness
--*********************************************************************************
INSERT INTO Building_BuildingClassHappiness
			(BuildingType, BuildingClassType, Happiness)
SELECT		('BUILDING_PMMM_STAGE_OF_OKTAVIA'), BuildingClassType, Happiness
FROM Building_BuildingClassHappiness WHERE (BuildingType = 'BUILDING_OPERA_HOUSE');

--*********************************************************************************
--Building_BuildingClassYieldChanges
--*********************************************************************************
INSERT INTO Building_BuildingClassYieldChanges
			(BuildingType, BuildingClassType, YieldType, YieldChange)
SELECT		('BUILDING_PMMM_STAGE_OF_OKTAVIA'), BuildingClassType, YieldType, YieldChange
FROM Building_BuildingClassYieldChanges WHERE (BuildingType = 'BUILDING_OPERA_HOUSE');

--*********************************************************************************
--Building_ClassesNeededInCity
--*********************************************************************************
INSERT INTO Building_ClassesNeededInCity
			(BuildingType, BuildingClassType)
SELECT		('BUILDING_PMMM_STAGE_OF_OKTAVIA'), BuildingClassType
FROM Building_ClassesNeededInCity WHERE (BuildingType = 'BUILDING_OPERA_HOUSE');

--*********************************************************************************
--Building_FreeUnits
--*********************************************************************************
INSERT INTO Building_FreeUnits
			(BuildingType, UnitType, NumUnits)
SELECT		('BUILDING_PMMM_STAGE_OF_OKTAVIA'), UnitType, NumUnits
FROM Building_FreeUnits WHERE (BuildingType = 'BUILDING_OPERA_HOUSE');

--*********************************************************************************
--Building_DomainFreeExperiences
--*********************************************************************************
INSERT INTO Building_DomainFreeExperiences
			(BuildingType, DomainType, Experience)
SELECT		('BUILDING_PMMM_STAGE_OF_OKTAVIA'), DomainType, Experience
FROM Building_DomainFreeExperiences WHERE (BuildingType = 'BUILDING_OPERA_HOUSE');

--*********************************************************************************
--Building_DomainFreeExperiencePerGreatWork
--*********************************************************************************
INSERT INTO Building_DomainFreeExperiencePerGreatWork
			(BuildingType, DomainType, Experience)
SELECT		('BUILDING_PMMM_STAGE_OF_OKTAVIA'), DomainType, Experience
FROM Building_DomainFreeExperiencePerGreatWork WHERE (BuildingType = 'BUILDING_OPERA_HOUSE');

--*********************************************************************************
--Building_DomainProductionModifiers
--*********************************************************************************
INSERT INTO Building_DomainProductionModifiers
			(BuildingType, DomainType, Modifier)
SELECT		('BUILDING_PMMM_STAGE_OF_OKTAVIA'), DomainType, Modifier
FROM Building_DomainProductionModifiers WHERE (BuildingType = 'BUILDING_OPERA_HOUSE');

--*********************************************************************************
--Building_FreeSpecialistCounts
--*********************************************************************************
INSERT INTO Building_FreeSpecialistCounts
			(BuildingType, SpecialistType, Count)
SELECT		('BUILDING_PMMM_STAGE_OF_OKTAVIA'), SpecialistType, Count
FROM Building_FreeSpecialistCounts WHERE (BuildingType = 'BUILDING_OPERA_HOUSE');

--*********************************************************************************
--Building_Flavors
--*********************************************************************************
INSERT INTO Building_Flavors
			(BuildingType, FlavorType, Flavor)
SELECT		('BUILDING_PMMM_STAGE_OF_OKTAVIA'), FlavorType, Flavor+5
FROM Building_Flavors WHERE (BuildingType = 'BUILDING_OPERA_HOUSE');

INSERT INTO Building_Flavors
VALUES		('BUILDING_PMMM_STAGE_OF_OKTAVIA', 'FLAVOR_AIRLIFT', 10);

--*********************************************************************************
--Building_GlobalYieldModifiers
--*********************************************************************************
INSERT INTO Building_GlobalYieldModifiers
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_PMMM_STAGE_OF_OKTAVIA'), YieldType, Yield
FROM Building_GlobalYieldModifiers WHERE (BuildingType = 'BUILDING_OPERA_HOUSE');

--*********************************************************************************
--Building_HurryModifiers
--*********************************************************************************
INSERT INTO Building_HurryModifiers
			(BuildingType, HurryType, HurryCostModifier)
SELECT		('BUILDING_PMMM_STAGE_OF_OKTAVIA'), HurryType, HurryCostModifier
FROM Building_HurryModifiers WHERE (BuildingType = 'BUILDING_OPERA_HOUSE');

--*********************************************************************************
--Building_LocalResourceAnds
--*********************************************************************************
INSERT INTO Building_LocalResourceAnds
			(BuildingType, ResourceType)
SELECT		('BUILDING_PMMM_STAGE_OF_OKTAVIA'), ResourceType
FROM Building_LocalResourceAnds WHERE (BuildingType = 'BUILDING_OPERA_HOUSE');

--*********************************************************************************
--Building_LocalResourceOrs
--*********************************************************************************
INSERT INTO Building_LocalResourceOrs
			(BuildingType, ResourceType)
SELECT		('BUILDING_PMMM_STAGE_OF_OKTAVIA'), ResourceType
FROM Building_LocalResourceOrs WHERE (BuildingType = 'BUILDING_OPERA_HOUSE');

--*********************************************************************************
--Building_LockedBuildingClasses
--*********************************************************************************
INSERT INTO Building_LockedBuildingClasses
			(BuildingType, BuildingClassType)
SELECT		('BUILDING_PMMM_STAGE_OF_OKTAVIA'), BuildingClassType
FROM Building_LockedBuildingClasses WHERE (BuildingType = 'BUILDING_OPERA_HOUSE');

--*********************************************************************************
--Building_PrereqBuildingClasses
--*********************************************************************************
INSERT INTO Building_PrereqBuildingClasses
			(BuildingType, BuildingClassType, NumBuildingNeeded)
SELECT		('BUILDING_PMMM_STAGE_OF_OKTAVIA'), BuildingClassType, NumBuildingNeeded
FROM Building_PrereqBuildingClasses WHERE (BuildingType = 'BUILDING_OPERA_HOUSE');

--*********************************************************************************
--Building_ResourceQuantity
--*********************************************************************************
INSERT INTO Building_ResourceQuantity
			(BuildingType, ResourceType, Quantity)
SELECT		('BUILDING_PMMM_STAGE_OF_OKTAVIA'), ResourceType, Quantity
FROM Building_ResourceQuantity WHERE (BuildingType = 'BUILDING_OPERA_HOUSE');

--*********************************************************************************
--Building_ResourceQuantityRequirements
--*********************************************************************************
INSERT INTO Building_ResourceQuantityRequirements
			(BuildingType, ResourceType, Cost)
SELECT		('BUILDING_PMMM_STAGE_OF_OKTAVIA'), ResourceType, Cost
FROM Building_ResourceQuantityRequirements WHERE (BuildingType = 'BUILDING_OPERA_HOUSE');

--*********************************************************************************
--Building_ResourceYieldModifiers
--*********************************************************************************
INSERT INTO Building_ResourceYieldModifiers
			(BuildingType, ResourceType, YieldType, Yield)
SELECT		('BUILDING_PMMM_STAGE_OF_OKTAVIA'), ResourceType, YieldType, Yield
FROM Building_ResourceYieldModifiers WHERE (BuildingType = 'BUILDING_OPERA_HOUSE');

--*********************************************************************************
--Building_ResourceCultureChanges
--*********************************************************************************
INSERT INTO Building_ResourceCultureChanges
			(BuildingType, ResourceType, CultureChange)
SELECT		('BUILDING_PMMM_STAGE_OF_OKTAVIA'), ResourceType, CultureChange
FROM Building_ResourceCultureChanges WHERE (BuildingType = 'BUILDING_OPERA_HOUSE');

--*********************************************************************************
--Building_ResourceFaithChanges
--*********************************************************************************
INSERT INTO Building_ResourceFaithChanges
			(BuildingType, ResourceType, FaithChange)
SELECT		('BUILDING_PMMM_STAGE_OF_OKTAVIA'), ResourceType, FaithChange
FROM Building_ResourceFaithChanges WHERE (BuildingType = 'BUILDING_OPERA_HOUSE');

--*********************************************************************************
--Building_RiverPlotYieldChanges
--*********************************************************************************
INSERT INTO Building_RiverPlotYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_PMMM_STAGE_OF_OKTAVIA'), YieldType, Yield
FROM Building_RiverPlotYieldChanges WHERE (BuildingType = 'BUILDING_OPERA_HOUSE');

--*********************************************************************************
--Building_SeaPlotYieldChanges
--*********************************************************************************
INSERT INTO Building_SeaPlotYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_PMMM_STAGE_OF_OKTAVIA'), YieldType, Yield
FROM Building_SeaPlotYieldChanges WHERE (BuildingType = 'BUILDING_OPERA_HOUSE');

--*********************************************************************************
--Building_LakePlotYieldChanges
--*********************************************************************************
INSERT INTO Building_LakePlotYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_PMMM_STAGE_OF_OKTAVIA'), YieldType, Yield
FROM Building_LakePlotYieldChanges WHERE (BuildingType = 'BUILDING_OPERA_HOUSE');

--*********************************************************************************
--Building_SeaResourceYieldChanges
--*********************************************************************************
INSERT INTO Building_SeaResourceYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_PMMM_STAGE_OF_OKTAVIA'), YieldType, Yield
FROM Building_SeaResourceYieldChanges WHERE (BuildingType = 'BUILDING_OPERA_HOUSE');

--*********************************************************************************
--Building_ResourceYieldChanges
--*********************************************************************************
INSERT INTO Building_ResourceYieldChanges
			(BuildingType, ResourceType, YieldType, Yield)
SELECT		('BUILDING_PMMM_STAGE_OF_OKTAVIA'), ResourceType, YieldType, Yield
FROM Building_ResourceYieldChanges WHERE (BuildingType = 'BUILDING_OPERA_HOUSE');

--*********************************************************************************
--Building_FeatureYieldChanges
--*********************************************************************************
INSERT INTO Building_FeatureYieldChanges
			(BuildingType, FeatureType, YieldType, Yield)
SELECT		('BUILDING_PMMM_STAGE_OF_OKTAVIA'), FeatureType, YieldType, Yield
FROM Building_FeatureYieldChanges WHERE (BuildingType = 'BUILDING_OPERA_HOUSE');

--*********************************************************************************
--Building_TerrainYieldChanges
--*********************************************************************************
INSERT INTO Building_TerrainYieldChanges
			(BuildingType, TerrainType, YieldType, Yield)
SELECT		('BUILDING_PMMM_STAGE_OF_OKTAVIA'), TerrainType, YieldType, Yield
FROM Building_TerrainYieldChanges WHERE (BuildingType = 'BUILDING_OPERA_HOUSE');

--*********************************************************************************
--Building_SpecialistYieldChanges
--*********************************************************************************
INSERT INTO Building_SpecialistYieldChanges
			(BuildingType, SpecialistType, YieldType, Yield)
SELECT		('BUILDING_PMMM_STAGE_OF_OKTAVIA'), SpecialistType, YieldType, Yield
FROM Building_SpecialistYieldChanges WHERE (BuildingType = 'BUILDING_OPERA_HOUSE');


--*********************************************************************************
--Building_UnitCombatFreeExperiences
--*********************************************************************************
INSERT INTO Building_UnitCombatFreeExperiences
			(BuildingType, UnitCombatType, Experience)
SELECT		('BUILDING_PMMM_STAGE_OF_OKTAVIA'), UnitCombatType, Experience
FROM Building_UnitCombatFreeExperiences WHERE (BuildingType = 'BUILDING_OPERA_HOUSE');

--*********************************************************************************
--Building_UnitCombatProductionModifiers
--*********************************************************************************
INSERT INTO Building_UnitCombatProductionModifiers
			(BuildingType, UnitCombatType, Modifier)
SELECT		('BUILDING_PMMM_STAGE_OF_OKTAVIA'), UnitCombatType, Modifier
FROM Building_UnitCombatProductionModifiers WHERE (BuildingType = 'BUILDING_OPERA_HOUSE');

--*********************************************************************************
--Building_TechAndPrereqs
--*********************************************************************************
INSERT INTO Building_TechAndPrereqs
			(BuildingType, TechType)
SELECT		('BUILDING_PMMM_STAGE_OF_OKTAVIA'), TechType
FROM Building_TechAndPrereqs WHERE (BuildingType = 'BUILDING_OPERA_HOUSE');

--*********************************************************************************
--Building_YieldChanges
--*********************************************************************************
INSERT INTO Building_YieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_PMMM_STAGE_OF_OKTAVIA'), YieldType, Yield
FROM Building_YieldChanges WHERE (BuildingType = 'BUILDING_OPERA_HOUSE');

--*********************************************************************************
--Building_YieldChangesPerPop
--*********************************************************************************
INSERT INTO Building_YieldChangesPerPop
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_PMMM_STAGE_OF_OKTAVIA'), YieldType, Yield
FROM Building_YieldChangesPerPop WHERE (BuildingType = 'BUILDING_OPERA_HOUSE');

--*********************************************************************************
--Building_YieldChangesPerReligion
--*********************************************************************************
INSERT INTO Building_YieldChangesPerReligion
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_PMMM_STAGE_OF_OKTAVIA'), YieldType, Yield
FROM Building_YieldChangesPerReligion WHERE (BuildingType = 'BUILDING_OPERA_HOUSE');

--*********************************************************************************
--Building_TechEnhancedYieldChanges
--*********************************************************************************
INSERT INTO Building_TechEnhancedYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_PMMM_STAGE_OF_OKTAVIA'), YieldType, Yield
FROM Building_TechEnhancedYieldChanges WHERE (BuildingType = 'BUILDING_OPERA_HOUSE');

--Culture from Combined Arms
INSERT INTO Building_TechEnhancedYieldChanges
			(BuildingType, YieldType, Yield)
VALUES		('BUILDING_PMMM_STAGE_OF_OKTAVIA',	'YIELD_CULTURE',	2);


--*********************************************************************************
--Building_YieldModifiers
--*********************************************************************************
INSERT INTO Building_YieldModifiers
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_PMMM_STAGE_OF_OKTAVIA'), YieldType, Yield
FROM Building_YieldModifiers WHERE (BuildingType = 'BUILDING_OPERA_HOUSE');

--*********************************************************************************
--Building_ThemingBonuses
--*********************************************************************************
INSERT INTO Building_ThemingBonuses
			(BuildingType, Description, Bonus, SameEra, UniqueEras, MustBeArt, MustBeArtifact, MustBeEqualArtArtifact, RequiresOwner, RequiresAnyButOwner, RequiresSamePlayer, RequiresUniquePlayers, AIPriority)
SELECT		('BUILDING_PMMM_STAGE_OF_OKTAVIA'), Description, Bonus, SameEra, UniqueEras, MustBeArt, MustBeArtifact, MustBeEqualArtArtifact, RequiresOwner, RequiresAnyButOwner, RequiresSamePlayer, RequiresUniquePlayers, AIPriority
FROM Building_ThemingBonuses WHERE (BuildingType = 'BUILDING_OPERA_HOUSE');





