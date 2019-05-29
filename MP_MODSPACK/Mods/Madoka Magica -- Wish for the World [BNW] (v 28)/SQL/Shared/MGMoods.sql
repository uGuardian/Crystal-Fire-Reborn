INSERT INTO MG_Moods
			(Type,				Description,				MinValue,	MaxValue,	Promotion,							SoulGemCorruptionMod,	SoulGemAbilityCostMod,
			RelationshipPointsMod,	LoyaltyChange)
VALUES		('MGMOOD_DESPAIR',	'TXT_KEY_MGMOOD_DESPAIR',	0,			-500,		'PROMOTION_PMMM_MGMOOD_DESPAIR',	5,						100,
			-100,					-5),
			('MGMOOD_DEPRESSED','TXT_KEY_MGMOOD_DEPRESSED',	-499,		-400,		'PROMOTION_PMMM_MGMOOD_DEPRESSED',	4,						75,	
			-75,					-3),
			('MGMOOD_SAD',		'TXT_KEY_MGMOOD_SAD',		-399,		-300,		'PROMOTION_PMMM_MGMOOD_SAD',		3,						50,	
			-50,					-1),
			('MGMOOD_UPSET',	'TXT_KEY_MGMOOD_UPSET',		-299,		-200,		'PROMOTION_PMMM_MGMOOD_UPSET',		2,						25,	
			-25,					0),
			('MGMOOD_GRUMPY',	'TXT_KEY_MGMOOD_GRUMPY',	-199,		-100,		'PROMOTION_PMMM_MGMOOD_GRUMPY',		1,						0,	
			0,						0),
			('MGMOOD_NEUTRAL',	'TXT_KEY_MGMOOD_NEUTRAL',	-99,		99,			null,								0,						0,	
			0,						0),
			('MGMOOD_GOOD',		'TXT_KEY_MGMOOD_GOOD',		100,		199,		'PROMOTION_PMMM_MGMOOD_GOOD',		-1,						0,	
			0,						0),
			('MGMOOD_HAPPY',	'TXT_KEY_MGMOOD_HAPPY',		200,		299,		'PROMOTION_PMMM_MGMOOD_HAPPY',		-2,						-15,
			25,						0),
			('MGMOOD_ELATED',	'TXT_KEY_MGMOOD_ELATED',	300,		399,		'PROMOTION_PMMM_MGMOOD_ELATED',		-3,						-30,	
			50,						1),
			('MGMOOD_BLISSFUL',	'TXT_KEY_MGMOOD_BLISSFUL',	400,		499,		'PROMOTION_PMMM_MGMOOD_BLISSFUL',	-4,						-45,
			75,						3),
			('MGMOOD_ECSTATIC',	'TXT_KEY_MGMOOD_ECSTATIC',	500,		0,			'PROMOTION_PMMM_MGMOOD_ECSTATIC',	-5,						-70,	
			100,					5);

UPDATE MG_Moods
SET FacialExpression = 'ANGRY'
WHERE Type IN ('MGMOOD_UPSET', 'MGMOOD_SAD');

UPDATE MG_Moods
SET FacialExpression = 'DEPRESSED'
WHERE Type IN ('MGMOOD_DEPRESSED', 'MGMOOD_DESPAIR');

UPDATE MG_Moods
SET FacialExpression = 'HAPPY'
WHERE Type IN ('MGMOOD_HAPPY', 'MGMOOD_ELATED');

UPDATE MG_Moods
SET FacialExpression = 'JOYOUS'
WHERE Type IN ('MGMOOD_BLISSFUL', 'MGMOOD_ECSTATIC');



UPDATE MG_Moods
SET MinValue = (SELECT Value FROM Defines WHERE Name = "MG_MOOD_MINIMUM")
WHERE Type = 'MGMOOD_DESPAIR';

UPDATE MG_Moods
SET MaxValue = (SELECT Value FROM Defines WHERE Name = "MG_MOOD_MAXIMUM")
WHERE Type = 'MGMOOD_ECSTATIC';


INSERT INTO UnitPromotions
			(Type,											Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry, CombatPercent)
SELECT		('PROMOTION_PMMM_MGMOOD_DESPAIR'),					('TXT_KEY_MGMOOD_DESPAIR'),		('TXT_KEY_PROMOTION_PMMM_MGMOOD_DESPAIR_HELP'),
			CannotBeChosen,		Sound,	0,	('PROMOTION_ATLAS_PMMM_MOODS'),	PediaType,	('TXT_KEY_MGMOOD_DESPAIR'), -100
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');

INSERT INTO UnitPromotions
			(Type,											Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry, CombatPercent)
SELECT		('PROMOTION_PMMM_MGMOOD_DEPRESSED'),					('TXT_KEY_MGMOOD_DEPRESSED'),		('TXT_KEY_PROMOTION_PMMM_MGMOOD_DEPRESSED_HELP'),
			CannotBeChosen,		Sound,	1,	('PROMOTION_ATLAS_PMMM_MOODS'),	PediaType,	('TXT_KEY_MGMOOD_DEPRESSED'), -75
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');

INSERT INTO UnitPromotions
			(Type,											Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry, CombatPercent)
SELECT		('PROMOTION_PMMM_MGMOOD_SAD'),					('TXT_KEY_MGMOOD_SAD'),		('TXT_KEY_PROMOTION_PMMM_MGMOOD_SAD_HELP'),
			CannotBeChosen,		Sound,	2,	('PROMOTION_ATLAS_PMMM_MOODS'),	PediaType,	('TXT_KEY_MGMOOD_SAD'), -50
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');

INSERT INTO UnitPromotions
			(Type,											Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry, CombatPercent)
SELECT		('PROMOTION_PMMM_MGMOOD_UPSET'),					('TXT_KEY_MGMOOD_UPSET'),		('TXT_KEY_PROMOTION_PMMM_MGMOOD_UPSET_HELP'),
			CannotBeChosen,		Sound,	3,	('PROMOTION_ATLAS_PMMM_MOODS'),	PediaType,	('TXT_KEY_MGMOOD_UPSET'), -30
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');

INSERT INTO UnitPromotions
			(Type,											Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry, CombatPercent)
SELECT		('PROMOTION_PMMM_MGMOOD_GRUMPY'),					('TXT_KEY_MGMOOD_GRUMPY'),		('TXT_KEY_PROMOTION_PMMM_MGMOOD_GRUMPY_HELP'),
			CannotBeChosen,		Sound,	4,	('PROMOTION_ATLAS_PMMM_MOODS'),	PediaType,	('TXT_KEY_MGMOOD_GRUMPY'), -15
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');

INSERT INTO UnitPromotions
			(Type,											Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry, CombatPercent)
SELECT		('PROMOTION_PMMM_MGMOOD_GOOD'),					('TXT_KEY_MGMOOD_GOOD'),		('TXT_KEY_PROMOTION_PMMM_MGMOOD_GOOD_HELP'),
			CannotBeChosen,		Sound,	5,	('PROMOTION_ATLAS_PMMM_MOODS'),	PediaType,	('TXT_KEY_MGMOOD_GOOD'), 15
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');

INSERT INTO UnitPromotions
			(Type,											Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry, CombatPercent)
SELECT		('PROMOTION_PMMM_MGMOOD_HAPPY'),					('TXT_KEY_MGMOOD_HAPPY'),		('TXT_KEY_PROMOTION_PMMM_MGMOOD_HAPPY_HELP'),
			CannotBeChosen,		Sound,	6,	('PROMOTION_ATLAS_PMMM_MOODS'),	PediaType,	('TXT_KEY_MGMOOD_HAPPY'), 30
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');

INSERT INTO UnitPromotions
			(Type,											Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry, CombatPercent)
SELECT		('PROMOTION_PMMM_MGMOOD_ELATED'),					('TXT_KEY_MGMOOD_ELATED'),		('TXT_KEY_PROMOTION_PMMM_MGMOOD_ELATED_HELP'),
			CannotBeChosen,		Sound,	7,	('PROMOTION_ATLAS_PMMM_MOODS'),	PediaType,	('TXT_KEY_MGMOOD_ELATED'), 50
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');

INSERT INTO UnitPromotions
			(Type,											Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry, CombatPercent)
SELECT		('PROMOTION_PMMM_MGMOOD_BLISSFUL'),					('TXT_KEY_MGMOOD_BLISSFUL'),		('TXT_KEY_PROMOTION_PMMM_MGMOOD_BLISSFUL_HELP'),
			CannotBeChosen,		Sound,	8,	('PROMOTION_ATLAS_PMMM_MOODS'),	PediaType,	('TXT_KEY_MGMOOD_BLISSFUL'), 75
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');

INSERT INTO UnitPromotions
			(Type,											Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry, CombatPercent)
SELECT		('PROMOTION_PMMM_MGMOOD_ECSTATIC'),					('TXT_KEY_MGMOOD_ECSTATIC'),		('TXT_KEY_PROMOTION_PMMM_MGMOOD_ECSTATIC_HELP'),
			CannotBeChosen,		Sound,	9,	('PROMOTION_ATLAS_PMMM_MOODS'),	PediaType,	('TXT_KEY_MGMOOD_ECSTATIC'), 100
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');





INSERT INTO MG_MoodModifiers
			(Type,								Description,								PositiveTooltip,							NegativeTooltip,								Value,		MaxValue,	Turns)
VALUES		('MGMOODMOD_EMPIRE_HAPPINESS',		'TXT_KEY_MGMOODMOD_EMPIRE_HAPPINESS',		'TXT_KEY_MGMOODMOD_EMPIRE_HAPPINESS_TT',	'TXT_KEY_MGMOODMOD_EMPIRE_HAPPINESS_NEG_TT',	3,			null,		null),
			('MGMOODMOD_GOLDEN_AGE',			'TXT_KEY_MGMOODMOD_GOLDEN_AGE',				'TXT_KEY_MGMOODMOD_GOLDEN_AGE_TT',			null,											50,			null,		null),
			('MGMOODMOD_VACATION',				'TXT_KEY_MGMOODMOD_VACATION',				'TXT_KEY_MGMOODMOD_VACATION_TT',			null,											10,			null,		15),
			('MGMOODMOD_LIKES_DISLIKES',		'TXT_KEY_MGMOODMOD_LIKES_DISLIKES',			'TXT_KEY_MGMOODMOD_LIKES_DISLIKES_TT',		'TXT_KEY_MGMOODMOD_LIKES_DISLIKES_NEG_TT',		1,			null,		null),
			('MGMOODMOD_KILLED_WITCH',			'TXT_KEY_MGMOODMOD_KILLED_WITCH',			'TXT_KEY_MGMOODMOD_KILLED_WITCH_TT',		null,											100,		500,		20),
			('MGMOODMOD_SOCIALIZING',			'TXT_KEY_MGMOODMOD_SOCIALIZING',			'TXT_KEY_MGMOODMOD_SOCIALIZING_TT',			null,											20,			300,		15),
			('MGMOODMOD_POLICIES',				'TXT_KEY_MGMOODMOD_POLICIES',				'TXT_KEY_MGMOODMOD_POLICIES_TT',			'TXT_KEY_MGMOODMOD_POLICIES_NEG_TT',			null,		null,		null),
			('MGMOODMOD_BELIEFS',				'TXT_KEY_MGMOODMOD_BELIEFS',				'TXT_KEY_MGMOODMOD_BELIEFS_TT',				'TXT_KEY_MGMOODMOD_BELIEFS_NEG_TT',				null,		null,		null),
			('MGMOODMOD_BUILDINGS',				'TXT_KEY_MGMOODMOD_BUILDINGS',				'TXT_KEY_MGMOODMOD_BUILDINGS_TT',			'TXT_KEY_MGMOODMOD_BUILDINGS_NEG_TT',			null,		null,		null),
			('MGMOODMOD_TRAITS',				'TXT_KEY_MGMOODMOD_TRAITS',					'TXT_KEY_MGMOODMOD_TRAITS_TT',				'TXT_KEY_MGMOODMOD_TRAITS_NEG_TT',				null,		null,		null),
			('MGMOODMOD_INJURED',				'TXT_KEY_MGMOODMOD_INJURED',				null,										'TXT_KEY_MGMOODMOD_INJURED_TT',					3,			300,		null),
			('MGMOODMOD_HOSTILE_TERRAIN',		'TXT_KEY_MGMOODMOD_HOSTILE_TERRAIN',		null,										'TXT_KEY_MGMOODMOD_HOSTILE_TERRAIN_TT',			150,		null,		null),
			('MGMOODMOD_HOMESICK',				'TXT_KEY_MGMOODMOD_HOMESICK',				null,										'TXT_KEY_MGMOODMOD_HOMESICK_TT',				20,			1000,		20),
			('MGMOODMOD_NO_VACATION',			'TXT_KEY_MGMOODMOD_NO_VACATION',			null,										'TXT_KEY_MGMOODMOD_NO_VACATION_TT',				20,			500,		25),
			('MGMOODMOD_NO_SOCIALIZING',		'TXT_KEY_MGMOODMOD_NO_SOCIALIZING',			null,										'TXT_KEY_MGMOODMOD_NO_SOCIALIZING_TT',			20,			500,		15),
			('MGMOODMOD_FRIENDLY_UNIT_KILLED',	'TXT_KEY_MGMOODMOD_FRIENDLY_UNIT_KILLED',	null,										'TXT_KEY_MGMOODMOD_FRIENDLY_UNIT_KILLED_TT',	100,		1000,		20),
			('MGMOODMOD_KNOWS_THE_TRUTH',		'TXT_KEY_MGMOODMOD_KNOWS_THE_TRUTH',		null,										'TXT_KEY_MGMOODMOD_KNOWS_THE_TRUTH_TT',			750,		1500,		25),
			('MGMOODMOD_WAR_SCORE',				'TXT_KEY_MGMOODMOD_WAR_SCORE',				'TXT_KEY_MGMOODMOD_WAR_SCORE_TT',			'TXT_KEY_MGMOODMOD_WAR_SCORE_NEG_TT',			1,			400,		null),
			('MGMOODMOD_FOUGHT_NEAR_LEADER',	'TXT_KEY_MGMOODMOD_FOUGHT_NEAR_LEADER',		'TXT_KEY_MGMOODMOD_FOUGHT_NEAR_LEADER_TT',	null,											100,		null,		10),
			('MGMOODMOD_QB_EMOTIONAL_ABUSE',	'TXT_KEY_MGMOODMOD_QB_EMOTIONAL_ABUSE',		null,										'TXT_KEY_MGMOODMOD_QB_EMOTIONAL_ABUSE_TT',		200,		1000,		15),
			('MGMOODMOD_TRAIT_POPULATION',		'TXT_KEY_MGMOODMOD_TRAIT_POPULATION',		'TXT_KEY_MGMOODMOD_TRAIT_POPULATION_TT',	null,											1,			null,		null),
			('MGMOODMOD_TRAIT_BROKEN_PSYCHE',	'TXT_KEY_MGMOODMOD_TRAIT_BROKEN_PSYCHE',	null,										'TXT_KEY_MGMOODMOD_TRAIT_BROKEN_PSYCHE_TT',		500,		500,		null),
			('MGMOODMOD_AI_HANDICAP',			'TXT_KEY_MGMOODMOD_AI_HANDICAP',			'TXT_KEY_MGMOODMOD_AI_HANDICAP_TT',			null,											0,			null,		null),
			('MGMOODMOD_INADEQUACY',			'TXT_KEY_MGMOODMOD_INADEQUACY',				null,										'TXT_KEY_MGMOODMOD_INADEQUACY_TT',				75,			null,		30),
			('MGMOODMOD_RESTLESSNESS',			'TXT_KEY_MGMOODMOD_RESTLESSNESS',			null,										'TXT_KEY_MGMOODMOD_RESTLESSNESS_TT',			15,			375,		20);


--"Value" is a bit depreciated now, but it's still here since I'm using it on some occasions
INSERT INTO MG_LikeDislikes
			(Type,							Description,							Tooltip,								Value)
VALUES		('MGLIKEDISLIKE_POLICY',		'TXT_KEY_MGLIKEDISLIKE_POLICY',			'TXT_KEY_MGLIKEDISLIKE_POLICY_TT',		100),
			('MGLIKEDISLIKE_CIVILIZATION',	'TXT_KEY_MGLIKEDISLIKE_CIVILIZATION',	'TXT_KEY_MGLIKEDISLIKE_CIVILIZATION_TT',200),
			('MGLIKEDISLIKE_CITYSTATE',		'TXT_KEY_MGLIKEDISLIKE_CITYSTATE',		'TXT_KEY_MGLIKEDISLIKE_CITYSTATE_TT',	100),
			--('MGLIKEDISLIKE_GREATWORK',		'TXT_KEY_MGLIKEDISLIKE_GREATWORK',		'TXT_KEY_MGLIKEDISLIKE_GREATWORK_TT',	50), --scrapped until Relationships are in
			('MGLIKEDISLIKE_RELIGION',		'TXT_KEY_MGLIKEDISLIKE_RELIGION',		'TXT_KEY_MGLIKEDISLIKE_RELIGION_TT',	200),
			--('MGLIKEDISLIKE_WONDER',		'TXT_KEY_MGLIKEDISLIKE_WONDER',			'TXT_KEY_MGLIKEDISLIKE_WONDER_TT',		50), --scrapped due to there not being much doable with v25-style Likes/Dislikes
			--('MGLIKEDISLIKE_RESOLUTION',	'TXT_KEY_MGLIKEDISLIKE_RESOLUTION',		'TXT_KEY_MGLIKEDISLIKE_RESOLUTION_TT',	100), --scrapped for now, due to complications
			('MGLIKEDISLIKE_LUXURY',		'TXT_KEY_MGLIKEDISLIKE_LUXURY',			'TXT_KEY_MGLIKEDISLIKE_LUXURY_TT',		100),

			--This one applies to ALL MGs, regardless of how many others they have!
			('MGLIKEDISLIKE_IDEOLOGY',		'TXT_KEY_MGLIKEDISLIKE_IDEOLOGY',		'TXT_KEY_MGLIKEDISLIKE_IDEOLOGY_TT',	200);


--Dull Pain promotion
INSERT INTO UnitPromotions
			(Type,											Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry,
			AttackMod, MovesChange)
SELECT		('PROMOTION_PMMM_DULL_PAIN'),					('TXT_KEY_PROMOTION_PMMM_DULL_PAIN'),		('TXT_KEY_PROMOTION_PMMM_DULL_PAIN_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_PMMM_DULL_PAIN'),
			-20,		-1
FROM UnitPromotions	WHERE (Type = 'PROMOTION_EVIL_SPIRITS');

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Add things to the other databases related to Moods
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO BuildingClasses
			(Type,									DefaultBuilding)
VALUES		('BUILDINGCLASS_PMMM_YURIJI', 			'BUILDING_PMMM_YURIJI'),
			('BUILDINGCLASS_PMMM_MITAKIHARA_MS', 	'BUILDING_PMMM_MITAKIHARA_MS');
			
UPDATE BuildingClasses
SET MaxGlobalInstances = 1
WHERE Type = 'BUILDINGCLASS_PMMM_MITAKIHARA_MS';

-----------------------------------------------BELIEFS------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

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
SELECT		('BUILDING_PMMM_YURIJI'), ('TXT_KEY_BUILDING_PMMM_YURIJI'), ('TXT_KEY_BUILDING_PMMM_YURIJI_TEXT'), ('TXT_KEY_BUILDING_PMMM_YURIJI_STRATEGY'),
			('TXT_KEY_BUILDING_PMMM_YURIJI_HELP'), ThemingBonusHelp, Quote, GoldMaintenance, MutuallyExclusiveGroup, TeamShare, Water, River, 
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
			CityStateTradeRouteProductionModifier, GreatScientistBeakerModifier, ('BUILDINGCLASS_PMMM_YURIJI'), ArtDefineTag, NearbyTerrainRequired, ProhibitedCityTerrain, VictoryPrereq,
			FreeStartEra, MaxStartEra, ObsoleteTech, EnhancedYieldTech, TechEnhancedTourism, FreeBuilding, FreeBuildingThisCity, FreePromotion, TrainedFreePromotion,
			FreePromotionRemoved, ReplacementBuildingClass, PrereqTech, PolicyBranchType, SpecialistType, SpecialistCount, GreatWorkSlotType, FreeGreatWork, GreatWorkCount,
			SpecialistExtraCulture, GreatPeopleRateChange, ExtraLeagueVotes, CityWall, DisplayPosition, 1, WonderSplashImage, WonderSplashAnchor,
			WonderSplashAudio, ('BUILDING_COLOR_ATLAS_PMMM_V21'), ArtInfoCulturalVariation, ArtInfoEraVariation, ArtInfoRandomVariation
FROM Buildings WHERE (Type = 'BUILDING_PAGODA');


UPDATE Buildings
SET Happiness = 0, GreatPeopleRateChange = 10, PMMMMoodBonus = 10
WHERE Type = 'BUILDING_PMMM_YURIJI';


--*********************************************************************************
--Building_AreaYieldModifiers
--*********************************************************************************
INSERT INTO Building_AreaYieldModifiers
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_PMMM_YURIJI'), YieldType, Yield
FROM Building_AreaYieldModifiers WHERE (BuildingType = 'BUILDING_PAGODA');


--*********************************************************************************
--Building_BuildingClassHappiness
--*********************************************************************************
INSERT INTO Building_BuildingClassHappiness
			(BuildingType, BuildingClassType, Happiness)
SELECT		('BUILDING_PMMM_YURIJI'), BuildingClassType, Happiness
FROM Building_BuildingClassHappiness WHERE (BuildingType = 'BUILDING_PAGODA');

--*********************************************************************************
--Building_BuildingClassYieldChanges
--*********************************************************************************
INSERT INTO Building_BuildingClassYieldChanges
			(BuildingType, BuildingClassType, YieldType, YieldChange)
SELECT		('BUILDING_PMMM_YURIJI'), BuildingClassType, YieldType, YieldChange
FROM Building_BuildingClassYieldChanges WHERE (BuildingType = 'BUILDING_PAGODA');

--*********************************************************************************
--Building_ClassesNeededInCity
--*********************************************************************************
INSERT INTO Building_ClassesNeededInCity
			(BuildingType, BuildingClassType)
SELECT		('BUILDING_PMMM_YURIJI'), BuildingClassType
FROM Building_ClassesNeededInCity WHERE (BuildingType = 'BUILDING_PAGODA');

--*********************************************************************************
--Building_FreeUnits
--*********************************************************************************
INSERT INTO Building_FreeUnits
			(BuildingType, UnitType, NumUnits)
SELECT		('BUILDING_PMMM_YURIJI'), UnitType, NumUnits
FROM Building_FreeUnits WHERE (BuildingType = 'BUILDING_PAGODA');

--*********************************************************************************
--Building_DomainFreeExperiences
--*********************************************************************************
INSERT INTO Building_DomainFreeExperiences
			(BuildingType, DomainType, Experience)
SELECT		('BUILDING_PMMM_YURIJI'), DomainType, Experience
FROM Building_DomainFreeExperiences WHERE (BuildingType = 'BUILDING_PAGODA');

--*********************************************************************************
--Building_DomainFreeExperiencePerGreatWork
--*********************************************************************************
INSERT INTO Building_DomainFreeExperiencePerGreatWork
			(BuildingType, DomainType, Experience)
SELECT		('BUILDING_PMMM_YURIJI'), DomainType, Experience
FROM Building_DomainFreeExperiencePerGreatWork WHERE (BuildingType = 'BUILDING_PAGODA');

--*********************************************************************************
--Building_DomainProductionModifiers
--*********************************************************************************
INSERT INTO Building_DomainProductionModifiers
			(BuildingType, DomainType, Modifier)
SELECT		('BUILDING_PMMM_YURIJI'), DomainType, Modifier
FROM Building_DomainProductionModifiers WHERE (BuildingType = 'BUILDING_PAGODA');

--*********************************************************************************
--Building_FreeSpecialistCounts
--*********************************************************************************
INSERT INTO Building_FreeSpecialistCounts
			(BuildingType, SpecialistType, Count)
SELECT		('BUILDING_PMMM_YURIJI'), SpecialistType, Count
FROM Building_FreeSpecialistCounts WHERE (BuildingType = 'BUILDING_PAGODA');

--*********************************************************************************
--Building_Flavors
--*********************************************************************************
INSERT INTO Building_Flavors
			(BuildingType, FlavorType, Flavor)
SELECT		('BUILDING_PMMM_YURIJI'), FlavorType, Flavor+5
FROM Building_Flavors WHERE (BuildingType = 'BUILDING_PAGODA');

--*********************************************************************************
--Building_GlobalYieldModifiers
--*********************************************************************************
INSERT INTO Building_GlobalYieldModifiers
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_PMMM_YURIJI'), YieldType, Yield
FROM Building_GlobalYieldModifiers WHERE (BuildingType = 'BUILDING_PAGODA');

--*********************************************************************************
--Building_HurryModifiers
--*********************************************************************************
INSERT INTO Building_HurryModifiers
			(BuildingType, HurryType, HurryCostModifier)
SELECT		('BUILDING_PMMM_YURIJI'), HurryType, HurryCostModifier
FROM Building_HurryModifiers WHERE (BuildingType = 'BUILDING_PAGODA');

--*********************************************************************************
--Building_LocalResourceAnds
--*********************************************************************************
INSERT INTO Building_LocalResourceAnds
			(BuildingType, ResourceType)
SELECT		('BUILDING_PMMM_YURIJI'), ResourceType
FROM Building_LocalResourceAnds WHERE (BuildingType = 'BUILDING_PAGODA');

--*********************************************************************************
--Building_LocalResourceOrs
--*********************************************************************************
INSERT INTO Building_LocalResourceOrs
			(BuildingType, ResourceType)
SELECT		('BUILDING_PMMM_YURIJI'), ResourceType
FROM Building_LocalResourceOrs WHERE (BuildingType = 'BUILDING_PAGODA');

--*********************************************************************************
--Building_LockedBuildingClasses
--*********************************************************************************
INSERT INTO Building_LockedBuildingClasses
			(BuildingType, BuildingClassType)
SELECT		('BUILDING_PMMM_YURIJI'), BuildingClassType
FROM Building_LockedBuildingClasses WHERE (BuildingType = 'BUILDING_PAGODA');

--*********************************************************************************
--Building_PrereqBuildingClasses
--*********************************************************************************
INSERT INTO Building_PrereqBuildingClasses
			(BuildingType, BuildingClassType, NumBuildingNeeded)
SELECT		('BUILDING_PMMM_YURIJI'), BuildingClassType, NumBuildingNeeded
FROM Building_PrereqBuildingClasses WHERE (BuildingType = 'BUILDING_PAGODA');

--*********************************************************************************
--Building_ResourceQuantity
--*********************************************************************************
INSERT INTO Building_ResourceQuantity
			(BuildingType, ResourceType, Quantity)
SELECT		('BUILDING_PMMM_YURIJI'), ResourceType, Quantity
FROM Building_ResourceQuantity WHERE (BuildingType = 'BUILDING_PAGODA');

--*********************************************************************************
--Building_ResourceQuantityRequirements
--*********************************************************************************
INSERT INTO Building_ResourceQuantityRequirements
			(BuildingType, ResourceType, Cost)
SELECT		('BUILDING_PMMM_YURIJI'), ResourceType, Cost
FROM Building_ResourceQuantityRequirements WHERE (BuildingType = 'BUILDING_PAGODA');

--*********************************************************************************
--Building_ResourceYieldModifiers
--*********************************************************************************
INSERT INTO Building_ResourceYieldModifiers
			(BuildingType, ResourceType, YieldType, Yield)
SELECT		('BUILDING_PMMM_YURIJI'), ResourceType, YieldType, Yield
FROM Building_ResourceYieldModifiers WHERE (BuildingType = 'BUILDING_PAGODA');

--*********************************************************************************
--Building_ResourceCultureChanges
--*********************************************************************************
INSERT INTO Building_ResourceCultureChanges
			(BuildingType, ResourceType, CultureChange)
SELECT		('BUILDING_PMMM_YURIJI'), ResourceType, CultureChange
FROM Building_ResourceCultureChanges WHERE (BuildingType = 'BUILDING_PAGODA');

--*********************************************************************************
--Building_ResourceFaithChanges
--*********************************************************************************
INSERT INTO Building_ResourceFaithChanges
			(BuildingType, ResourceType, FaithChange)
SELECT		('BUILDING_PMMM_YURIJI'), ResourceType, FaithChange
FROM Building_ResourceFaithChanges WHERE (BuildingType = 'BUILDING_PAGODA');

--*********************************************************************************
--Building_RiverPlotYieldChanges
--*********************************************************************************
INSERT INTO Building_RiverPlotYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_PMMM_YURIJI'), YieldType, Yield
FROM Building_RiverPlotYieldChanges WHERE (BuildingType = 'BUILDING_PAGODA');

--*********************************************************************************
--Building_SeaPlotYieldChanges
--*********************************************************************************
INSERT INTO Building_SeaPlotYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_PMMM_YURIJI'), YieldType, Yield
FROM Building_SeaPlotYieldChanges WHERE (BuildingType = 'BUILDING_PAGODA');

--*********************************************************************************
--Building_LakePlotYieldChanges
--*********************************************************************************
INSERT INTO Building_LakePlotYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_PMMM_YURIJI'), YieldType, Yield
FROM Building_LakePlotYieldChanges WHERE (BuildingType = 'BUILDING_PAGODA');

--*********************************************************************************
--Building_SeaResourceYieldChanges
--*********************************************************************************
INSERT INTO Building_SeaResourceYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_PMMM_YURIJI'), YieldType, Yield
FROM Building_SeaResourceYieldChanges WHERE (BuildingType = 'BUILDING_PAGODA');

--*********************************************************************************
--Building_ResourceYieldChanges
--*********************************************************************************
INSERT INTO Building_ResourceYieldChanges
			(BuildingType, ResourceType, YieldType, Yield)
SELECT		('BUILDING_PMMM_YURIJI'), ResourceType, YieldType, Yield
FROM Building_ResourceYieldChanges WHERE (BuildingType = 'BUILDING_PAGODA');

--*********************************************************************************
--Building_FeatureYieldChanges
--*********************************************************************************
INSERT INTO Building_FeatureYieldChanges
			(BuildingType, FeatureType, YieldType, Yield)
SELECT		('BUILDING_PMMM_YURIJI'), FeatureType, YieldType, Yield
FROM Building_FeatureYieldChanges WHERE (BuildingType = 'BUILDING_PAGODA');

--*********************************************************************************
--Building_TerrainYieldChanges
--*********************************************************************************
INSERT INTO Building_TerrainYieldChanges
			(BuildingType, TerrainType, YieldType, Yield)
SELECT		('BUILDING_PMMM_YURIJI'), TerrainType, YieldType, Yield
FROM Building_TerrainYieldChanges WHERE (BuildingType = 'BUILDING_PAGODA');

--*********************************************************************************
--Building_SpecialistYieldChanges
--*********************************************************************************
INSERT INTO Building_SpecialistYieldChanges
			(BuildingType, SpecialistType, YieldType, Yield)
SELECT		('BUILDING_PMMM_YURIJI'), SpecialistType, YieldType, Yield
FROM Building_SpecialistYieldChanges WHERE (BuildingType = 'BUILDING_PAGODA');


--*********************************************************************************
--Building_UnitCombatFreeExperiences
--*********************************************************************************
INSERT INTO Building_UnitCombatFreeExperiences
			(BuildingType, UnitCombatType, Experience)
SELECT		('BUILDING_PMMM_YURIJI'), UnitCombatType, Experience
FROM Building_UnitCombatFreeExperiences WHERE (BuildingType = 'BUILDING_PAGODA');

--*********************************************************************************
--Building_UnitCombatProductionModifiers
--*********************************************************************************
INSERT INTO Building_UnitCombatProductionModifiers
			(BuildingType, UnitCombatType, Modifier)
SELECT		('BUILDING_PMMM_YURIJI'), UnitCombatType, Modifier
FROM Building_UnitCombatProductionModifiers WHERE (BuildingType = 'BUILDING_PAGODA');

--*********************************************************************************
--Building_TechAndPrereqs
--*********************************************************************************
INSERT INTO Building_TechAndPrereqs
			(BuildingType, TechType)
SELECT		('BUILDING_PMMM_YURIJI'), TechType
FROM Building_TechAndPrereqs WHERE (BuildingType = 'BUILDING_PAGODA');

--*********************************************************************************
--Building_YieldChanges
--*********************************************************************************
INSERT INTO Building_YieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_PMMM_YURIJI'), YieldType, Yield
FROM Building_YieldChanges WHERE (BuildingType = 'BUILDING_PAGODA');

DELETE FROM Building_YieldChanges
WHERE BuildingType = 'BUILDING_PMMM_YURIJI' AND YieldType = 'YIELD_CULTURE';

--*********************************************************************************
--Building_YieldChangesPerPop
--*********************************************************************************
INSERT INTO Building_YieldChangesPerPop
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_PMMM_YURIJI'), YieldType, Yield
FROM Building_YieldChangesPerPop WHERE (BuildingType = 'BUILDING_PAGODA');

--*********************************************************************************
--Building_YieldChangesPerReligion
--*********************************************************************************
INSERT INTO Building_YieldChangesPerReligion
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_PMMM_YURIJI'), YieldType, Yield
FROM Building_YieldChangesPerReligion WHERE (BuildingType = 'BUILDING_PAGODA');

--*********************************************************************************
--Building_TechEnhancedYieldChanges
--*********************************************************************************
INSERT INTO Building_TechEnhancedYieldChanges
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_PMMM_YURIJI'), YieldType, Yield
FROM Building_TechEnhancedYieldChanges WHERE (BuildingType = 'BUILDING_PAGODA');


--*********************************************************************************
--Building_YieldModifiers
--*********************************************************************************
INSERT INTO Building_YieldModifiers
			(BuildingType, YieldType, Yield)
SELECT		('BUILDING_PMMM_YURIJI'), YieldType, Yield
FROM Building_YieldModifiers WHERE (BuildingType = 'BUILDING_PAGODA');

--*********************************************************************************
--Building_ThemingBonuses
--*********************************************************************************
INSERT INTO Building_ThemingBonuses
			(BuildingType, Description, Bonus, SameEra, UniqueEras, MustBeArt, MustBeArtifact, MustBeEqualArtArtifact, RequiresOwner, RequiresAnyButOwner, RequiresSamePlayer, RequiresUniquePlayers, AIPriority)
SELECT		('BUILDING_PMMM_YURIJI'), Description, Bonus, SameEra, UniqueEras, MustBeArt, MustBeArtifact, MustBeEqualArtArtifact, RequiresOwner, RequiresAnyButOwner, RequiresSamePlayer, RequiresUniquePlayers, AIPriority
FROM Building_ThemingBonuses WHERE (BuildingType = 'BUILDING_PAGODA');



INSERT INTO Beliefs
			(Type,					Description,					ShortDescription,				Follower)
VALUES		('BELIEF_PMMM_YURIJI',	'TXT_KEY_BELIEF_PMMM_YURIJI_SHORT',	'TXT_KEY_BELIEF_PMMM_YURIJI',	1);

INSERT INTO Beliefs
			(Type,						Description,								ShortDescription,					Founder,	PMMMMoodBonusPerFollowingCity)
VALUES		('BELIEF_PMMM_YOUTH_CAMPS',	'TXT_KEY_BELIEF_PMMM_YOUTH_CAMPS_SHORT',	'TXT_KEY_BELIEF_PMMM_YOUTH_CAMPS',	1,			4);

INSERT INTO Belief_BuildingClassFaithPurchase
			(BeliefType,			BuildingClassType)
VALUES		('BELIEF_PMMM_YURIJI',	'BUILDINGCLASS_PMMM_YURIJI');






-----------------------------------------------POLICIES------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UPDATE Policies
SET PMMMMoodBonusPerCapitalPop = 2
WHERE Type = 'POLICY_TRADITION_FINISHER';

UPDATE Language_en_US
SET Text = Text || '[NEWLINE][NEWLINE]Adopting all Policies in Tradition will grant Magical Girls +2 [ICON_PMMM_MOOD] Mood for every [ICON_CITIZEN] Citizen in your [ICON_CAPITAL] Capital.'
WHERE Tag = 'TXT_KEY_POLICY_BRANCH_TRADITION_HELP';



UPDATE Policies
SET PMMMMoodBonusPerCity = 5
WHERE Type = 'POLICY_LIBERTY_FINISHER';

UPDATE Language_en_US
SET Text = Text || '[NEWLINE][NEWLINE]Adopting all Policies in Liberty will grant Magical Girls +5 [ICON_PMMM_MOOD] Mood for every City.'
WHERE Tag = 'TXT_KEY_POLICY_BRANCH_LIBERTY_HELP';



UPDATE Policies
SET PMMMMoodBonusPerNonMGMilitaryUnit = 3
WHERE Type = 'POLICY_HONOR_FINISHER';

UPDATE Language_en_US
SET Text = Text || '[NEWLINE][NEWLINE]Adopting all Policies in Honor will grant Magical Girls +3 [ICON_PMMM_MOOD] Mood for every non-Magical Girl, non-Witch Military Unit you control.'
WHERE Tag = 'TXT_KEY_POLICY_BRANCH_HONOR_HELP';



UPDATE Policies
SET PMMMMoodBonusPerReligiousFollower = 1
WHERE Type = 'POLICY_PIETY_FINISHER';

UPDATE Language_en_US
SET Text = Text || '[NEWLINE][NEWLINE]Adopting all Policies in Piety will grant Magical Girls +1 [ICON_PMMM_MOOD] Mood for every follower of your founded [ICON_RELIGION] Religion in the world.'
WHERE Tag = 'TXT_KEY_POLICY_BRANCH_PIETY_HELP';



UPDATE Policies
SET PMMMMoodBonusPerMinorCivAlly = 5
WHERE Type = 'POLICY_PATRONAGE_FINISHER';

UPDATE Language_en_US
SET Text = Text || '[NEWLINE][NEWLINE]Adopting all Policies in Patronage will grant Magical Girls +5 [ICON_PMMM_MOOD] Mood for every City-State Ally.'
WHERE Tag = 'TXT_KEY_POLICY_BRANCH_PATRONAGE_HELP';



UPDATE Policies
SET PMMMMoodBonusPerGreatWork = 5
WHERE Type = 'POLICY_AESTHETICS_FINISHER';

UPDATE Language_en_US
SET Text = Text || '[NEWLINE][NEWLINE]Adopting all Policies in Aesthetics will grant Magical Girls +5 [ICON_PMMM_MOOD] Mood for every [ICON_GREAT_WORK] Great Work.'
WHERE Tag = 'TXT_KEY_POLICY_BRANCH_AESTHETICS_HELP';



UPDATE Policies
SET PMMMMoodBonusPerLuxury = 5
WHERE Type = 'POLICY_COMMERCE_FINISHER';

UPDATE Language_en_US
SET Text = Text || '[NEWLINE][NEWLINE]Adopting all Policies in Commerce will grant Magical Girls +5 [ICON_PMMM_MOOD] Mood for every type of Luxury in your trade network.'
WHERE Tag = 'TXT_KEY_POLICY_BRANCH_COMMERCE_HELP';



UPDATE Policies
SET PMMMMoodBonusPerMapPercent = 1
WHERE Type = 'POLICY_EXPLORATION_FINISHER';

UPDATE Language_en_US
SET Text = Text || '[NEWLINE][NEWLINE]Adopting all Policies in Exploration will grant Magical Girls +1 [ICON_PMMM_MOOD] Mood for every percent of the world map explored.'
WHERE Tag = 'TXT_KEY_POLICY_BRANCH_EXPLORATION_HELP';



UPDATE Policies
SET PMMMMoodBonusPerTech = 1
WHERE Type = 'POLICY_RATIONALISM_FINISHER';

UPDATE Language_en_US
SET Text = Text || '[NEWLINE][NEWLINE]Adopting all Policies in Rationalism will grant Magical Girls +1 [ICON_PMMM_MOOD] Mood for every Technology discovered, including repeats of Future Tech.'
WHERE Tag = 'TXT_KEY_POLICY_BRANCH_RATIONALISM_HELP';



INSERT INTO Policies
			(Type,							Description,							Help,										PolicyBranchType,	CultureCost, Level, PortraitIndex, IconAtlas, IconAtlasAchieved)
SELECT		('POLICY_PMMM_NATIONAL_DREAM'),	('TXT_KEY_POLICY_PMMM_NATIONAL_DREAM'),('TXT_KEY_POLICY_PMMM_NATIONAL_DREAM_HELP'), PolicyBranchType,	CultureCost, Level, PortraitIndex, IconAtlas, IconAtlasAchieved
FROM Policies WHERE Type = 'POLICY_VOLUNTEER_ARMY';

UPDATE Policies
SET PMMMMoodBonusPerSpecialist = 2
WHERE Type = 'POLICY_PMMM_NATIONAL_DREAM';


INSERT INTO Policies
			(Type,							Description,							Help,										PolicyBranchType,	CultureCost, Level, PortraitIndex, IconAtlas, IconAtlasAchieved)
SELECT		('POLICY_PMMM_MEANS_OF_PRODUCTION'),	('TXT_KEY_POLICY_PMMM_MEANS_OF_PRODUCTION'),('TXT_KEY_POLICY_PMMM_MEANS_OF_PRODUCTION_HELP'), PolicyBranchType,	CultureCost, Level, PortraitIndex, IconAtlas, IconAtlasAchieved
FROM Policies WHERE Type = 'POLICY_FIVE_YEAR_PLAN';

UPDATE Policies
SET PMMMMoodBonusPerProductionTimes100 = 20
WHERE Type = 'POLICY_PMMM_MEANS_OF_PRODUCTION';


INSERT INTO Policies
			(Type,							Description,							Help,										PolicyBranchType,	CultureCost, Level, PortraitIndex, IconAtlas, IconAtlasAchieved)
SELECT		('POLICY_PMMM_SOCIAL_DARWINISM'),	('TXT_KEY_POLICY_PMMM_SOCIAL_DARWINISM'),('TXT_KEY_POLICY_PMMM_SOCIAL_DARWINISM_HELP'), PolicyBranchType,	CultureCost, Level, PortraitIndex, IconAtlas, IconAtlasAchieved
FROM Policies WHERE Type = 'POLICY_MILITARISM';

UPDATE Policies
SET PMMMMoodBonusPerScoreTimes100 = 10
WHERE Type = 'POLICY_PMMM_SOCIAL_DARWINISM';








----------------------Mitakihara Middle School Wonder-------------------------------------------------------------------------------------------------------------------------------------------------------

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
SELECT		('BUILDING_PMMM_MITAKIHARA_MS'), ('TXT_KEY_BUILDING_PMMM_MITAKIHARA_MS'), ('TXT_KEY_BUILDING_PMMM_MITAKIHARA_MS_TEXT'), null,
			('TXT_KEY_BUILDING_PMMM_MITAKIHARA_MS_HELP'), ThemingBonusHelp, ('TXT_KEY_BUILDING_PMMM_MITAKIHARA_MS_QUOTE'), GoldMaintenance, MutuallyExclusiveGroup, TeamShare, Water, River, 
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
			CityStateTradeRouteProductionModifier, GreatScientistBeakerModifier, ('BUILDINGCLASS_PMMM_MITAKIHARA_MS'), ArtDefineTag, NearbyTerrainRequired, ProhibitedCityTerrain, VictoryPrereq,
			FreeStartEra, MaxStartEra, ObsoleteTech, EnhancedYieldTech, TechEnhancedTourism, FreeBuilding, ('BUILDINGCLASS_PUBLIC_SCHOOL'), FreePromotion, TrainedFreePromotion,
			FreePromotionRemoved, ReplacementBuildingClass, ('TECH_SCIENTIFIC_THEORY'), PolicyBranchType, SpecialistType, SpecialistCount, GreatWorkSlotType, FreeGreatWork, GreatWorkCount,
			SpecialistExtraCulture, GreatPeopleRateChange, ExtraLeagueVotes, CityWall, DisplayPosition, 0, ('MitakiharaMiddleSchoolSplash.dds'), WonderSplashAnchor,
			0, ('BUILDING_COLOR_ATLAS_PMMM_V21'), ArtInfoCulturalVariation, ArtInfoEraVariation, ArtInfoRandomVariation
FROM Buildings WHERE (Type = 'BUILDING_BRANDENBURG_GATE');

UPDATE Buildings
SET PMMMMoodBonus = 150
WHERE Type = 'BUILDING_PMMM_MITAKIHARA_MS';

--*********************************************************************************
--Building_Flavors
--*********************************************************************************

INSERT INTO Building_Flavors
			(BuildingType,					FlavorType,				Flavor)
VALUES		('BUILDING_PMMM_MITAKIHARA_MS', 'FLAVOR_SCIENCE',		25),
			('BUILDING_PMMM_MITAKIHARA_MS', 'FLAVOR_GREAT_PEOPLE',	25);


--*********************************************************************************
--Building_YieldChanges
--*********************************************************************************
INSERT INTO Building_YieldChanges
			(BuildingType,					YieldType,			Yield)
VALUES		('BUILDING_PMMM_MITAKIHARA_MS',	'YIELD_CULTURE',	2),
			('BUILDING_PMMM_MITAKIHARA_MS',	'YIELD_SCIENCE',	1);