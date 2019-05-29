--All SQL Unit inserts were based off of SQL code from JFD's Civilizations.

--==========================================================================================================================
-- Promotion
--==========================================================================================================================

-----------Boss Promotions--------------------------------------------------------------------------------------------------
INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_SRTT_BOSS'),		('TXT_KEY_PROMOTION_SRTT_BOSS'),		('TXT_KEY_PROMOTION_SRTT_BOSS_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_SRTT_BOSS')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_STEAM_POWERED');

INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_SRTT_BOSS_RESPECT_0'),		('TXT_KEY_PROMOTION_SRTT_BOSS_RESPECT_0'),		('TXT_KEY_PROMOTION_SRTT_BOSS_RESPECT_0_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_SRTT_BOSS_RESPECT_0')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_STEAM_POWERED');

INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_SRTT_BOSS_RESPECT_1'),		('TXT_KEY_PROMOTION_SRTT_BOSS_RESPECT_1'),		('TXT_KEY_PROMOTION_SRTT_BOSS_RESPECT_1_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_SRTT_BOSS_RESPECT_1')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_STEAM_POWERED');

INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_SRTT_BOSS_RESPECT_2'),		('TXT_KEY_PROMOTION_SRTT_BOSS_RESPECT_2'),		('TXT_KEY_PROMOTION_SRTT_BOSS_RESPECT_2_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_SRTT_BOSS_RESPECT_2')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_STEAM_POWERED');

INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_SRTT_BOSS_RESPECT_3'),		('TXT_KEY_PROMOTION_SRTT_BOSS_RESPECT_3'),		('TXT_KEY_PROMOTION_SRTT_BOSS_RESPECT_3_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_SRTT_BOSS_RESPECT_3')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_STEAM_POWERED');

INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_SRTT_BOSS_RESPECT_4'),		('TXT_KEY_PROMOTION_SRTT_BOSS_RESPECT_4'),		('TXT_KEY_PROMOTION_SRTT_BOSS_RESPECT_4_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_SRTT_BOSS_RESPECT_4')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_STEAM_POWERED');

INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_SRTT_BOSS_RESPECT_5'),		('TXT_KEY_PROMOTION_SRTT_BOSS_RESPECT_5'),		('TXT_KEY_PROMOTION_SRTT_BOSS_RESPECT_5_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_SRTT_BOSS_RESPECT_5')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_STEAM_POWERED');

UPDATE UnitPromotions
SET NearbyEnemyCombatMod=-15, NearbyEnemyCombatRange=2
WHERE Type = 'PROMOTION_SRTT_BOSS';

UPDATE UnitPromotions
SET MovesChange = 1
WHERE Type = 'PROMOTION_SRTT_BOSS_RESPECT_1';
UPDATE UnitPromotions
SET MovesChange = 2
WHERE Type = 'PROMOTION_SRTT_BOSS_RESPECT_2';
UPDATE UnitPromotions
SET MovesChange = 3
WHERE Type = 'PROMOTION_SRTT_BOSS_RESPECT_3';
UPDATE UnitPromotions
SET MovesChange = 4
WHERE Type = 'PROMOTION_SRTT_BOSS_RESPECT_4';
UPDATE UnitPromotions
SET MovesChange = 5
WHERE Type = 'PROMOTION_SRTT_BOSS_RESPECT_5';


----------Rim Jobs Promotions-----------------------------------------------------------------------------------------------
INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_SRTT_RJ_INTERIOR'),		('TXT_KEY_PROMOTION_SRTT_RJ_INTERIOR'),		('TXT_KEY_PROMOTION_SRTT_RJ_INTERIOR_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_SRTT_RJ_INTERIOR')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_STEAM_POWERED');

INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_SRTT_RJ_SAINT_PAINT'),		('TXT_KEY_PROMOTION_SRTT_RJ_SAINT_PAINT'),		('TXT_KEY_PROMOTION_SRTT_RJ_SAINT_PAINT_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_SRTT_RJ_SAINT_PAINT')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_STEAM_POWERED');

INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_SRTT_RJ_REINFORCED'),		('TXT_KEY_PROMOTION_SRTT_RJ_REINFORCED'),		('TXT_KEY_PROMOTION_SRTT_RJ_REINFORCED_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_SRTT_RJ_REINFORCED')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_STEAM_POWERED');

INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_SRTT_RJ_HYDRAULICS'),		('TXT_KEY_PROMOTION_SRTT_RJ_HYDRAULICS'),		('TXT_KEY_PROMOTION_SRTT_RJ_HYDRAULICS_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_SRTT_RJ_HYDRAULICS')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_STEAM_POWERED');

INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_SRTT_RJ_KNEECAPPERS'),		('TXT_KEY_PROMOTION_SRTT_RJ_KNEECAPPERS'),		('TXT_KEY_PROMOTION_SRTT_RJ_KNEECAPPERS_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_SRTT_RJ_KNEECAPPERS')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_STEAM_POWERED');

INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_SRTT_RJ_NITROUS'),		('TXT_KEY_PROMOTION_SRTT_RJ_NITROUS'),		('TXT_KEY_PROMOTION_SRTT_RJ_NITROUS_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_SRTT_RJ_NITROUS')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_STEAM_POWERED');

INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_SRTT_RJ_NITROUS_ACTIVE'),		('TXT_KEY_PROMOTION_SRTT_RJ_NITROUS_ACTIVE'),		('TXT_KEY_PROMOTION_SRTT_RJ_NITROUS_ACTIVE_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_SRTT_RJ_NITROUS_ACTIVE')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_STEAM_POWERED');


UPDATE UnitPromotions
SET ExperiencePercent = 25, RespectLevelRequired = 1, RJGoldCost = 300
WHERE Type = 'PROMOTION_SRTT_RJ_INTERIOR';

UPDATE UnitPromotions
SET RespectLevelRequired = 5, RJGoldCost = 600
WHERE Type = 'PROMOTION_SRTT_RJ_SAINT_PAINT';

UPDATE UnitPromotions
SET RespectLevelRequired = 10, RJGoldCost = 900
WHERE Type = 'PROMOTION_SRTT_RJ_REINFORCED';

UPDATE UnitPromotions
SET HillsDoubleMove = 1, RespectLevelRequired = 15, RJGoldCost = 1200
WHERE Type = 'PROMOTION_SRTT_RJ_HYDRAULICS';

INSERT INTO UnitPromotions_Features
			(PromotionType,		FeatureType,	DoubleMove)
VALUES		('PROMOTION_SRTT_RJ_HYDRAULICS',	'FEATURE_JUNGLE',	1),
			('PROMOTION_SRTT_RJ_HYDRAULICS',	'FEATURE_FOREST',	1);


UPDATE UnitPromotions
SET RespectLevelRequired = 20, RJGoldCost = 1500
WHERE Type = 'PROMOTION_SRTT_RJ_KNEECAPPERS';

UPDATE UnitPromotions
SET RespectLevelRequired = 25, RJGoldCost = 2000
WHERE Type = 'PROMOTION_SRTT_RJ_NITROUS';

UPDATE UnitPromotions
SET MovesChange = 5, IgnoreTerrainCost = 1
WHERE Type = 'PROMOTION_SRTT_RJ_NITROUS_ACTIVE';



--==========================================================================================================================
-- Units
--==========================================================================================================================
INSERT INTO Units 	
			(Type,							Description,							Civilopedia,								Strategy,										Help,										
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns,
			IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,
			RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,UnitArtInfo,UnitArtInfoCulturalVariation,UnitArtInfoEraVariation,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,UnitFlagIconOffset,PortraitIndex,IconAtlas,UnitFlagAtlas)
SELECT		('UNIT_SRTT_BOSS'),	('TXT_KEY_UNIT_SRTT_BOSS'),	('TXT_KEY_UNIT_SRTT_BOSS_TEXT'),	('TXT_KEY_UNIT_SRTT_BOSS_STRATEGY'),	('TXT_KEY_UNIT_SRTT_BOSS_HELP'),
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns,
			IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,
			RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,UnitArtInfo,0,0,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,7,2,('CIV_COLOR_ATLAS_THIRD_STREET_SAINTS'),('CIV_ALPHA_ATLAS')
FROM Units WHERE (Type = 'UNIT_GREAT_GENERAL');	

--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 				SelectionSound, FirstSelectionSound)
SELECT		('UNIT_SRTT_BOSS'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_GREAT_GENERAL');	
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================
INSERT INTO Unit_AITypes 	
			(UnitType, 				UnitAIType)
SELECT		('UNIT_SRTT_BOSS'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_GREAT_GENERAL');
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================
INSERT INTO Unit_Flavors 	
			(UnitType, 				FlavorType, Flavor)
SELECT		('UNIT_SRTT_BOSS'), 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_GREAT_GENERAL');
--==========================================================================================================================
-- Unit_Builds
--==========================================================================================================================
INSERT INTO Unit_Builds 	
			(UnitType, 				BuildType)
SELECT		('UNIT_SRTT_BOSS'), BuildType
FROM Unit_Builds WHERE (UnitType = 'UNIT_GREAT_GENERAL');

--Boss can't build Citadels
DELETE FROM Unit_Builds
WHERE UnitType='UNIT_SRTT_BOSS' AND BuildType='BUILD_CITADEL';

--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions 	
			(UnitType, 				PromotionType)
SELECT		('UNIT_SRTT_BOSS'), 	PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_GREAT_GENERAL');

INSERT INTO Unit_FreePromotions 	
			(UnitType, 			PromotionType)
VALUES		('UNIT_SRTT_BOSS', 	'PROMOTION_SRTT_BOSS');


--==========================================================================================================================
-- Unit_Buildings
--==========================================================================================================================
INSERT INTO Unit_Buildings	
			(UnitType, 				BuildingType)
SELECT		('UNIT_SRTT_BOSS'), 	BuildingType
FROM Unit_Buildings WHERE (UnitType = 'UNIT_GREAT_GENERAL');

--==========================================================================================================================
-- Unit_BuildingClassRequireds
--==========================================================================================================================
INSERT INTO Unit_BuildingClassRequireds	
			(UnitType, 				BuildingClassType)
SELECT		('UNIT_SRTT_BOSS'), 	BuildingClassType
FROM Unit_BuildingClassRequireds WHERE (UnitType = 'UNIT_GREAT_GENERAL');

--==========================================================================================================================
-- Unit_ProductionModifierBuildings
--==========================================================================================================================
INSERT INTO Unit_ProductionModifierBuildings	
			(UnitType, 				BuildingType,	ProductionModifier)
SELECT		('UNIT_SRTT_BOSS'), 	BuildingType,	ProductionModifier
FROM Unit_ProductionModifierBuildings WHERE (UnitType = 'UNIT_GREAT_GENERAL');


--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================
INSERT INTO Unit_ClassUpgrades	
			(UnitType, 				UnitClassType)
SELECT		('UNIT_SRTT_BOSS'), 	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_GREAT_GENERAL');

--==========================================================================================================================
-- Unit_GreatPersons
--==========================================================================================================================
INSERT INTO Unit_GreatPersons	
			(UnitType, 				GreatPersonType)
SELECT		('UNIT_SRTT_BOSS'), 	GreatPersonType
FROM Unit_GreatPersons WHERE (UnitType = 'UNIT_GREAT_GENERAL');


--==========================================================================================================================
-- Unit_ResourceQuantityRequirements
--==========================================================================================================================
INSERT INTO Unit_ResourceQuantityRequirements	
			(UnitType, 				ResourceType,	Cost)
SELECT		('UNIT_SRTT_BOSS'), 	ResourceType,	Cost
FROM Unit_ResourceQuantityRequirements WHERE (UnitType = 'UNIT_GREAT_GENERAL');


--==========================================================================================================================
-- Unit_YieldFromKills
--==========================================================================================================================
INSERT INTO Unit_YieldFromKills	
			(UnitType, 				YieldType,	Yield)
SELECT		('UNIT_SRTT_BOSS'), 	YieldType,	Yield
FROM Unit_YieldFromKills WHERE (UnitType = 'UNIT_GREAT_GENERAL');