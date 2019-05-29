--All SQL Unit inserts were based off of SQL code from JFD's Civilizations.

--==========================================================================================================================
-- Promotion
--==========================================================================================================================

INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_KOTR_FSN'),		('TXT_KEY_PROMOTION_KOTR_FSN'),		('TXT_KEY_PROMOTION_KOTR_FSN_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_KOTR_FSN')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_STEAM_POWERED');



--==========================================================================================================================
-- Units
--==========================================================================================================================
INSERT INTO Units 	
			(Type,							Description,							Civilopedia,								Strategy,										Help,										
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,UnitArtInfo,UnitArtInfoCulturalVariation,UnitArtInfoEraVariation,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,UnitFlagIconOffset,PortraitIndex,IconAtlas,UnitFlagAtlas)
SELECT		('UNIT_KOTR_FSN'),				Description,							Civilopedia,								Strategy,										Help,	
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,UnitArtInfo,UnitArtInfoCulturalVariation,UnitArtInfoEraVariation,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,UnitFlagIconOffset,PortraitIndex,IconAtlas,UnitFlagAtlas
FROM Units WHERE (Type = 'UNIT_GREAT_GENERAL');

--Combat Info
UPDATE Units
SET Combat = 14, Moves = 4, Domain = 'DOMAIN_LAND', CombatClass = 'UNITCOMBAT_MOUNTED', DefaultUnitAI = 'UNITAI_FAST_ATTACK', CivilianAttackPriority = null, CombatLimit = 100, DontShowYields = 0, MoveRate = 'QUADRUPED'
WHERE Type = 'UNIT_KOTR_FSN';

--Text Info
UPDATE Units
SET Description = 'TXT_KEY_' || Type, Civilopedia = 'TXT_KEY_' || Type || '_TEXT', Help = 'TXT_KEY_' || Type || '_HELP'
WHERE Type = 'UNIT_KOTR_FSN';

--Art Info
UPDATE Units
SET UnitFlagAtlas = 'UNIT_ALPHA_ATLAS_KOTR_FSN', UnitFlagIconOffset = 0, IconAtlas = 'CIV_COLOR_ATLAS_SABER', PortraitIndex = 2, UnitArtInfo = 'ART_DEF_UNIT_KOTR_FSN'
WHERE Type = 'UNIT_KOTR_FSN';



--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 			SelectionSound,			FirstSelectionSound)
VALUES		('UNIT_KOTR_FSN', 	'AS2D_SELECT_KNIGHT',	'AS2D_SELECT_KNIGHT');	
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================
INSERT INTO Unit_AITypes 	
			(UnitType, 				UnitAIType)
SELECT		('UNIT_KOTR_FSN'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_KNIGHT');
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================
INSERT INTO Unit_Flavors 	
			(UnitType, 				FlavorType, Flavor)
SELECT		('UNIT_KOTR_FSN'), 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_GREAT_GENERAL');
--==========================================================================================================================
-- Unit_Builds
--==========================================================================================================================
INSERT INTO Unit_Builds 	
			(UnitType, 				BuildType)
SELECT		('UNIT_KOTR_FSN'), BuildType
FROM Unit_Builds WHERE (UnitType = 'UNIT_GREAT_GENERAL');

--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions 	
			(UnitType, 				PromotionType)
SELECT		('UNIT_KOTR_FSN'), PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_GREAT_GENERAL');

INSERT INTO Unit_FreePromotions 	
			(UnitType, 			PromotionType)
VALUES		('UNIT_KOTR_FSN', 	'PROMOTION_KOTR_FSN');


--==========================================================================================================================
-- Unit_Buildings
--==========================================================================================================================
INSERT INTO Unit_Buildings	
			(UnitType, 				BuildingType)
SELECT		('UNIT_KOTR_FSN'), 	BuildingType
FROM Unit_Buildings WHERE (UnitType = 'UNIT_GREAT_GENERAL');

--==========================================================================================================================
-- Unit_BuildingClassRequireds
--==========================================================================================================================
INSERT INTO Unit_BuildingClassRequireds	
			(UnitType, 				BuildingClassType)
SELECT		('UNIT_KOTR_FSN'), 	BuildingClassType
FROM Unit_BuildingClassRequireds WHERE (UnitType = 'UNIT_GREAT_GENERAL');

--==========================================================================================================================
-- Unit_ProductionModifierBuildings
--==========================================================================================================================
INSERT INTO Unit_ProductionModifierBuildings	
			(UnitType, 				BuildingType,	ProductionModifier)
SELECT		('UNIT_KOTR_FSN'), 	BuildingType,	ProductionModifier
FROM Unit_ProductionModifierBuildings WHERE (UnitType = 'UNIT_GREAT_GENERAL');


--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================
INSERT INTO Unit_ClassUpgrades	
			(UnitType, 				UnitClassType)
SELECT		('UNIT_KOTR_FSN'), 	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_GREAT_GENERAL');

--==========================================================================================================================
-- Unit_GreatPersons
--==========================================================================================================================
INSERT INTO Unit_GreatPersons	
			(UnitType, 				GreatPersonType)
SELECT		('UNIT_KOTR_FSN'), 	GreatPersonType
FROM Unit_GreatPersons WHERE (UnitType = 'UNIT_GREAT_GENERAL');


--==========================================================================================================================
-- Unit_ResourceQuantityRequirements
--==========================================================================================================================
INSERT INTO Unit_ResourceQuantityRequirements	
			(UnitType, 				ResourceType,	Cost)
SELECT		('UNIT_KOTR_FSN'), 	ResourceType,	Cost
FROM Unit_ResourceQuantityRequirements WHERE (UnitType = 'UNIT_GREAT_GENERAL');


--==========================================================================================================================
-- Unit_YieldFromKills
--==========================================================================================================================
INSERT INTO Unit_YieldFromKills	
			(UnitType, 				YieldType,	Yield)
SELECT		('UNIT_KOTR_FSN'), 	YieldType,	Yield
FROM Unit_YieldFromKills WHERE (UnitType = 'UNIT_GREAT_GENERAL');



--==========================================================================================================================
-- Unit_UniqueNames
--==========================================================================================================================

INSERT INTO Unit_UniqueNames
			(UnitType,				UniqueName)
VALUES		('UNIT_KOTR_FSN',		'TXT_KEY_GREAT_PERSON_FSN_GAWAIN'),
			('UNIT_KOTR_FSN',		'TXT_KEY_GREAT_PERSON_FSN_LANCELOT'),
			('UNIT_KOTR_FSN',		'TXT_KEY_GREAT_PERSON_FSN_PERCIVAL'),
			('UNIT_KOTR_FSN',		'TXT_KEY_GREAT_PERSON_FSN_GALAHAD'),
			('UNIT_KOTR_FSN',		'TXT_KEY_GREAT_PERSON_FSN_BORS_THE_YOUNGER'),
			('UNIT_KOTR_FSN',		'TXT_KEY_GREAT_PERSON_FSN_KAY'),
			('UNIT_KOTR_FSN',		'TXT_KEY_GREAT_PERSON_FSN_GARETH'),
			('UNIT_KOTR_FSN',		'TXT_KEY_GREAT_PERSON_FSN_BEDIVERE'),
			('UNIT_KOTR_FSN',		'TXT_KEY_GREAT_PERSON_FSN_LUCAN'),
			('UNIT_KOTR_FSN',		'TXT_KEY_GREAT_PERSON_FSN_GRIFLET'),
			('UNIT_KOTR_FSN',		'TXT_KEY_GREAT_PERSON_FSN_YVAIN'),
			('UNIT_KOTR_FSN',		'TXT_KEY_GREAT_PERSON_FSN_EREC'),
			('UNIT_KOTR_FSN',		'TXT_KEY_GREAT_PERSON_FSN_CADOR_OF_CORNWALL'),
			('UNIT_KOTR_FSN',		'TXT_KEY_GREAT_PERSON_FSN_HOEL'),
			('UNIT_KOTR_FSN',		'TXT_KEY_GREAT_PERSON_FSN_TRISTAN_DE_LYONES'),
			('UNIT_KOTR_FSN',		'TXT_KEY_GREAT_PERSON_FSN_PALEMEDES'),
			('UNIT_KOTR_FSN',		'TXT_KEY_GREAT_PERSON_FSN_DINADAN');
