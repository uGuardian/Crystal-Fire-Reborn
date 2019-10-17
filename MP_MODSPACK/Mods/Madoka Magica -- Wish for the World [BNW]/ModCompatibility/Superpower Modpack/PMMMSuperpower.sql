--These must be based from a different type of promotion since Drill 1 is deleted
INSERT INTO UnitPromotions
			(Type,								Description,							Help,
			Sound,	PortraitIndex,	IconAtlas,									PediaType,				PediaEntry,
			MGLikeDislikeSpreadBonus,	MGSocializeBonus)
SELECT		('PROMOTION_PMMM_CHARISMA_I'),		('TXT_KEY_PROMOTION_PMMM_CHARISMA_I'),	('TXT_KEY_PROMOTION_PMMM_CHARISMA_I_HELP'),
			Sound,	2,				('PROMOTION_ATLAS_PMMM_V25_PROMOTIONS'),	('PEDIA_MAGICALGIRL'),	('TXT_KEY_PROMOTION_PMMM_CHARISMA_I'),
			3,							1
FROM UnitPromotions	WHERE (Type = 'PROMOTION_SHOCK_1');

INSERT INTO UnitPromotions
			(Type,								Description,							Help,
			Sound,	PortraitIndex,	IconAtlas,									PediaType,				PediaEntry,
			MGLikeDislikeSpreadBonus,	MGSocializeBonus,	PromotionPrereqOr1)
SELECT		('PROMOTION_PMMM_CHARISMA_II'),		('TXT_KEY_PROMOTION_PMMM_CHARISMA_II'),	('TXT_KEY_PROMOTION_PMMM_CHARISMA_II_HELP'),
			Sound,	2,				('PROMOTION_ATLAS_PMMM_V25_PROMOTIONS'),	('PEDIA_MAGICALGIRL'),	('TXT_KEY_PROMOTION_PMMM_CHARISMA_II'),
			3,							1,					('PROMOTION_PMMM_CHARISMA_I')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_SHOCK_1');

INSERT INTO UnitPromotions
			(Type,								Description,							Help,
			Sound,	PortraitIndex,	IconAtlas,									PediaType,				PediaEntry,
			MGSocializingLoyaltyGrantedToPartner,	PromotionPrereqOr1)
SELECT		('PROMOTION_PMMM_PATRIOTISM'),		('TXT_KEY_PROMOTION_PMMM_PATRIOTISM'),	('TXT_KEY_PROMOTION_PMMM_PATRIOTISM_HELP'),
			Sound,	5,				('PROMOTION_ATLAS_PMMM_V25_PROMOTIONS'),	('PEDIA_MAGICALGIRL'),	('TXT_KEY_PROMOTION_PMMM_PATRIOTISM'),
			10,										('PROMOTION_PMMM_CHARISMA_II')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_SHOCK_1');


INSERT INTO UnitPromotions
			(Type,								Description,							Help,
			Sound,	PortraitIndex,	IconAtlas,									PediaType,				PediaEntry,
			MGSparringPartnerBonus,	MGSparringCooldownReduction)
SELECT		('PROMOTION_PMMM_TRAINER_I'),		('TXT_KEY_PROMOTION_PMMM_TRAINER_I'),	('TXT_KEY_PROMOTION_PMMM_TRAINER_I_HELP'),
			Sound,	1,				('PROMOTION_ATLAS_PMMM_V25_PROMOTIONS'),	('PEDIA_MAGICALGIRL'),	('TXT_KEY_PROMOTION_PMMM_TRAINER_I'),
			5,						2
FROM UnitPromotions	WHERE (Type = 'PROMOTION_SHOCK_1');

INSERT INTO UnitPromotions
			(Type,								Description,							Help,
			Sound,	PortraitIndex,	IconAtlas,									PediaType,				PediaEntry,
			MGSparringPartnerBonus,	MGSparringCooldownReduction,	PromotionPrereqOr1)
SELECT		('PROMOTION_PMMM_TRAINER_II'),		('TXT_KEY_PROMOTION_PMMM_TRAINER_II'),	('TXT_KEY_PROMOTION_PMMM_TRAINER_II_HELP'),
			Sound,	1,				('PROMOTION_ATLAS_PMMM_V25_PROMOTIONS'),	('PEDIA_MAGICALGIRL'),	('TXT_KEY_PROMOTION_PMMM_TRAINER_II'),
			5,						2,					('PROMOTION_PMMM_TRAINER_I')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_SHOCK_1');

INSERT INTO UnitPromotions
			(Type,								Description,							Help,
			Sound,	PortraitIndex,	IconAtlas,									PediaType,				PediaEntry,
			MGSocializingXPGrantedToPartner,	PromotionPrereqOr1)
SELECT		('PROMOTION_PMMM_TEACHER'),		('TXT_KEY_PROMOTION_PMMM_TEACHER'),	('TXT_KEY_PROMOTION_PMMM_TEACHER_HELP'),
			Sound,	3,				('PROMOTION_ATLAS_PMMM_V25_PROMOTIONS'),	('PEDIA_MAGICALGIRL'),	('TXT_KEY_PROMOTION_PMMM_TEACHER'),
			1,								('PROMOTION_PMMM_TRAINER_II')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_SHOCK_1');





--This one also must be based on something else
INSERT INTO UnitPromotions
			(Type,											Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry,
			AttackMod, MovesChange)
SELECT		('PROMOTION_PMMM_DULL_PAIN'),					('TXT_KEY_PROMOTION_PMMM_DULL_PAIN'),		('TXT_KEY_PROMOTION_PMMM_DULL_PAIN_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_PMMM_DULL_PAIN'),
			-20,		-1
FROM UnitPromotions	WHERE (Type = 'PROMOTION_UNWELCOME_EVANGELIST');



-- Magical Girls and Witches never cause casualties
INSERT INTO Unit_FreePromotions
			(UnitType,					PromotionType)
VALUES		('UNIT_PMMM_MAGICAL_GIRL',	'PROMOTION_NO_CASUALTIES'),
			('UNIT_PMMM_WITCH',			'PROMOTION_NO_CASUALTIES'),
			('UNIT_PMMM_FAMILIAR',		'PROMOTION_NO_CASUALTIES'),
			('UNIT_PMMM_SEA_WITCH',		'PROMOTION_NO_CASUALTIES'),
			('UNIT_PMMM_SEA_FAMILIAR',	'PROMOTION_NO_CASUALTIES');



--Foundations for Entertainer Specialists
INSERT INTO BuildingClasses
			(Type,											DefaultBuilding,						MaxPlayerInstances)
VALUES		('BUILDINGCLASS_SPECIALISTS_ENTERTAINER_LV1',	'BUILDING_SPECIALISTS_ENTERTAINER_LV1',	1),
			('BUILDINGCLASS_SPECIALISTS_ENTERTAINER_LV2',	'BUILDING_SPECIALISTS_ENTERTAINER_LV2', 1);


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
			WonderSplashAudio, IconAtlas, ArtInfoCulturalVariation, ArtInfoEraVariation, ArtInfoRandomVariation,
			PMMMEntertainmentSpecialistModifier)
SELECT		('BUILDING_SPECIALISTS_ENTERTAINER_LV1'), ('TXT_KEY_BUILDING_SPECIALISTS_ENTERTAINER_LV1'), null, null,
			('TXT_KEY_BUILDING_SPECIALISTS_ENTERTAINER_HELP'), ThemingBonusHelp, Quote, GoldMaintenance, MutuallyExclusiveGroup, TeamShare, Water, River, 
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
			CityStateTradeRouteProductionModifier, GreatScientistBeakerModifier, ('BUILDINGCLASS_SPECIALISTS_ENTERTAINER_LV1'), ArtDefineTag, NearbyTerrainRequired, ProhibitedCityTerrain, VictoryPrereq,
			FreeStartEra, MaxStartEra, ObsoleteTech, EnhancedYieldTech, TechEnhancedTourism, FreeBuilding, FreeBuildingThisCity, FreePromotion, TrainedFreePromotion,
			FreePromotionRemoved, ReplacementBuildingClass, PrereqTech, PolicyBranchType, SpecialistType, SpecialistCount, GreatWorkSlotType, FreeGreatWork, GreatWorkCount,
			SpecialistExtraCulture, GreatPeopleRateChange, ExtraLeagueVotes, CityWall, DisplayPosition, PortraitIndex, WonderSplashImage, WonderSplashAnchor,
			WonderSplashAudio, IconAtlas, ArtInfoCulturalVariation, ArtInfoEraVariation, ArtInfoRandomVariation,
			2
FROM Buildings WHERE (Type = 'BUILDING_SPECIALISTS_ARTISTIC_LV1');


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
			WonderSplashAudio, IconAtlas, ArtInfoCulturalVariation, ArtInfoEraVariation, ArtInfoRandomVariation,
			PMMMEntertainmentSpecialistModifier)
SELECT		('BUILDING_SPECIALISTS_ENTERTAINER_LV2'), ('TXT_KEY_BUILDING_SPECIALISTS_ENTERTAINER_LV2'), null, null,
			('TXT_KEY_BUILDING_SPECIALISTS_ENTERTAINER_HELP'), ThemingBonusHelp, Quote, GoldMaintenance, MutuallyExclusiveGroup, TeamShare, Water, River, 
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
			CityStateTradeRouteProductionModifier, GreatScientistBeakerModifier, ('BUILDINGCLASS_SPECIALISTS_ENTERTAINER_LV2'), ArtDefineTag, NearbyTerrainRequired, ProhibitedCityTerrain, VictoryPrereq,
			FreeStartEra, MaxStartEra, ObsoleteTech, EnhancedYieldTech, TechEnhancedTourism, FreeBuilding, FreeBuildingThisCity, FreePromotion, TrainedFreePromotion,
			FreePromotionRemoved, ReplacementBuildingClass, PrereqTech, PolicyBranchType, SpecialistType, SpecialistCount, GreatWorkSlotType, FreeGreatWork, GreatWorkCount,
			SpecialistExtraCulture, GreatPeopleRateChange, ExtraLeagueVotes, CityWall, DisplayPosition, PortraitIndex, WonderSplashImage, WonderSplashAnchor,
			WonderSplashAudio, IconAtlas, ArtInfoCulturalVariation, ArtInfoEraVariation, ArtInfoRandomVariation,
			2
FROM Buildings WHERE (Type = 'BUILDING_SPECIALISTS_ARTISTIC_LV2');



INSERT INTO Building_ClassesNeededInCity
			(BuildingType,								BuildingClassType)
VALUES		('BUILDING_SPECIALISTS_ENTERTAINER_LV2',	'BUILDINGCLASS_SPECIALISTS_ENTERTAINER_LV1');


INSERT INTO Building_SpecialistClassYieldChanges
			(BuildingType,								SpecialistType,					YieldType,			Yield)
VALUES		('BUILDING_SPECIALISTS_ENTERTAINER_LV1',	'SPECIALIST_PMMM_ENTERTAINER',	'YIELD_TOURISM',	1),
			('BUILDING_SPECIALISTS_ENTERTAINER_LV2',	'SPECIALIST_PMMM_ENTERTAINER',	'YIELD_TOURISM',	1);


INSERT INTO Building_Flavors
			(BuildingType,							 FlavorType,	Flavor)
SELECT		('BUILDING_SPECIALISTS_ENTERTAINER_LV1'),FlavorType,	Flavor
FROM Buildings WHERE (Type = 'BUILDING_SPECIALISTS_ARTISTIC_LV1');

INSERT INTO Building_Flavors
			(BuildingType,							 FlavorType,	Flavor)
SELECT		('BUILDING_SPECIALISTS_ENTERTAINER_LV2'),FlavorType,	Flavor
FROM Buildings WHERE (Type = 'BUILDING_SPECIALISTS_ARTISTIC_LV2');
