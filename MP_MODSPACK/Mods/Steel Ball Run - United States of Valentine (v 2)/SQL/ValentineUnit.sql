--==========================================================================================================================
-- Promotion
--==========================================================================================================================

INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry,
			RangedSupportFire)
SELECT		('PROMOTION_STEEL_BALL_RUNNER'),		('TXT_KEY_PROMOTION_STEEL_BALL_RUNNER'),		('TXT_KEY_PROMOTION_STEEL_BALL_RUNNER_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_STEEL_BALL_RUNNER'),
			1
FROM UnitPromotions	WHERE (Type = 'PROMOTION_HOMELAND_GUARDIAN');



--==========================================================================================================================
-- Units
--==========================================================================================================================
INSERT INTO Units 	
			(Type,							Description,							Civilopedia,						Strategy,										Help,										
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,UnitArtInfo,UnitArtInfoCulturalVariation,UnitArtInfoEraVariation,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,UnitFlagIconOffset,PortraitIndex,IconAtlas,UnitFlagAtlas)
SELECT		('UNIT_STEEL_BALL_RUNNER'),	('TXT_KEY_UNIT_STEEL_BALL_RUNNER'),	('TXT_KEY_UNIT_STEEL_BALL_RUNNER_TEXT'),	('TXT_KEY_UNIT_STEEL_BALL_RUNNER_STRATEGY'),	('TXT_KEY_UNIT_STEEL_BALL_RUNNER_HELP'),
			Requirements, 16, RangedCombat, -1, -1, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, ('UNITCLASS_PROPHET'), ('SPECIALUNIT_PEOPLE'), Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, null, null, null, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,('ART_DEF_UNIT_STEEL_BALL_RUNNER'),0,0,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,0,2,('CIV_COLOR_ATLAS_JJBA_AMERICA'),('UNIT_FLAG_ATLAS_STEEL_BALL_RUNNER')
FROM Units WHERE (Type = 'UNIT_CAVALRY');	

--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 						SelectionSound, FirstSelectionSound)
SELECT		('UNIT_STEEL_BALL_RUNNER'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_CAVALRY');	
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================
INSERT INTO Unit_AITypes 	
			(UnitType, 						UnitAIType)
SELECT		('UNIT_STEEL_BALL_RUNNER'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_CAVALRY');
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================
INSERT INTO Unit_Flavors 	
			(UnitType, 						FlavorType, Flavor)
SELECT		('UNIT_STEEL_BALL_RUNNER'), 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_CAVALRY');
--==========================================================================================================================
-- Unit_Builds
--==========================================================================================================================
INSERT INTO Unit_Builds 	
			(UnitType, 					BuildType)
SELECT		('UNIT_STEEL_BALL_RUNNER'), BuildType
FROM Unit_Builds WHERE (UnitType = 'UNIT_CAVALRY');

INSERT INTO Unit_Builds 	
			(UnitType, 					BuildType)
SELECT		('UNIT_STEEL_BALL_RUNNER'), BuildType
FROM Unit_Builds WHERE (UnitType = 'UNIT_PROPHET');

--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions 	
			(UnitType, 				PromotionType)
SELECT		('UNIT_STEEL_BALL_RUNNER'), 	PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_CAVALRY');

INSERT INTO Unit_FreePromotions 	
			(UnitType, 					PromotionType)
VALUES		('UNIT_STEEL_BALL_RUNNER', 	'PROMOTION_STEEL_BALL_RUNNER');


--==========================================================================================================================
-- Unit_Buildings
--==========================================================================================================================
INSERT INTO Unit_Buildings	
			(UnitType, 						BuildingType)
SELECT		('UNIT_STEEL_BALL_RUNNER'), 	BuildingType
FROM Unit_Buildings WHERE (UnitType = 'UNIT_CAVALRY');

--==========================================================================================================================
-- Unit_BuildingClassRequireds
--==========================================================================================================================
INSERT INTO Unit_BuildingClassRequireds	
			(UnitType, 						BuildingClassType)
SELECT		('UNIT_STEEL_BALL_RUNNER'), 	BuildingClassType
FROM Unit_BuildingClassRequireds WHERE (UnitType = 'UNIT_CAVALRY');

--==========================================================================================================================
-- Unit_ProductionModifierBuildings
--==========================================================================================================================
INSERT INTO Unit_ProductionModifierBuildings	
			(UnitType, 						BuildingType,	ProductionModifier)
SELECT		('UNIT_STEEL_BALL_RUNNER'), 	BuildingType,	ProductionModifier
FROM Unit_ProductionModifierBuildings WHERE (UnitType = 'UNIT_CAVALRY');


--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================
--none
--==========================================================================================================================
-- Unit_GreatPersons
--==========================================================================================================================
INSERT INTO Unit_GreatPersons	
			(UnitType, 						GreatPersonType)
SELECT		('UNIT_STEEL_BALL_RUNNER'), 	GreatPersonType
FROM Unit_GreatPersons WHERE (UnitType = 'UNIT_CAVALRY');


--==========================================================================================================================
-- Unit_ResourceQuantityRequirements
--==========================================================================================================================
--none


--==========================================================================================================================
-- Unit_YieldFromKills
--==========================================================================================================================
INSERT INTO Unit_YieldFromKills	
			(UnitType, 						YieldType,	Yield)
SELECT		('UNIT_STEEL_BALL_RUNNER'), 	YieldType,	Yield
FROM Unit_YieldFromKills WHERE (UnitType = 'UNIT_CAVALRY');

INSERT INTO Unit_YieldFromKills	
			(UnitType, 					YieldType,		Yield)
VALUES		('UNIT_STEEL_BALL_RUNNER', 	'YIELD_FAITH',	100);


--==========================================================================================================================
-- Unit_UniqueNames
--==========================================================================================================================
INSERT INTO Unit_UniqueNames
			(UnitType,					UniqueName)
VALUES		('UNIT_STEEL_BALL_RUNNER',	'TXT_KEY_STEEL_BALL_RUNNER_NAME_1'),
			('UNIT_STEEL_BALL_RUNNER',	'TXT_KEY_STEEL_BALL_RUNNER_NAME_2'),
			('UNIT_STEEL_BALL_RUNNER',	'TXT_KEY_STEEL_BALL_RUNNER_NAME_3'),
			('UNIT_STEEL_BALL_RUNNER',	'TXT_KEY_STEEL_BALL_RUNNER_NAME_4'),
			('UNIT_STEEL_BALL_RUNNER',	'TXT_KEY_STEEL_BALL_RUNNER_NAME_5'),
			('UNIT_STEEL_BALL_RUNNER',	'TXT_KEY_STEEL_BALL_RUNNER_NAME_6'),
			('UNIT_STEEL_BALL_RUNNER',	'TXT_KEY_STEEL_BALL_RUNNER_NAME_7'),
			('UNIT_STEEL_BALL_RUNNER',	'TXT_KEY_STEEL_BALL_RUNNER_NAME_8'),
			('UNIT_STEEL_BALL_RUNNER',	'TXT_KEY_STEEL_BALL_RUNNER_NAME_9'),
			('UNIT_STEEL_BALL_RUNNER',	'TXT_KEY_STEEL_BALL_RUNNER_NAME_10'),
			('UNIT_STEEL_BALL_RUNNER',	'TXT_KEY_STEEL_BALL_RUNNER_NAME_11'),
			('UNIT_STEEL_BALL_RUNNER',	'TXT_KEY_STEEL_BALL_RUNNER_NAME_12'),
			('UNIT_STEEL_BALL_RUNNER',	'TXT_KEY_STEEL_BALL_RUNNER_NAME_13'),
			('UNIT_STEEL_BALL_RUNNER',	'TXT_KEY_STEEL_BALL_RUNNER_NAME_14'),
			('UNIT_STEEL_BALL_RUNNER',	'TXT_KEY_STEEL_BALL_RUNNER_NAME_15'),
			('UNIT_STEEL_BALL_RUNNER',	'TXT_KEY_STEEL_BALL_RUNNER_NAME_16'),
			('UNIT_STEEL_BALL_RUNNER',	'TXT_KEY_STEEL_BALL_RUNNER_NAME_17'),
			('UNIT_STEEL_BALL_RUNNER',	'TXT_KEY_STEEL_BALL_RUNNER_NAME_18'),
			('UNIT_STEEL_BALL_RUNNER',	'TXT_KEY_STEEL_BALL_RUNNER_NAME_19'),
			('UNIT_STEEL_BALL_RUNNER',	'TXT_KEY_STEEL_BALL_RUNNER_NAME_20'),
			('UNIT_STEEL_BALL_RUNNER',	'TXT_KEY_STEEL_BALL_RUNNER_NAME_21'),
			('UNIT_STEEL_BALL_RUNNER',	'TXT_KEY_STEEL_BALL_RUNNER_NAME_22'),
			('UNIT_STEEL_BALL_RUNNER',	'TXT_KEY_STEEL_BALL_RUNNER_NAME_23');




----------------------Dummy Units--------------------------------------------------------------------------------------------

INSERT INTO UnitClasses
			(Type,								DefaultUnit)
VALUES		('UNITCLASS_VALENTINE_DUMMY_UNITS',	null);

INSERT INTO Units
			(Type,						Class,								ShowInPedia,	Moves,	Description)
VALUES		('UNIT_CORPSEPART_DUMMY',	'UNITCLASS_VALENTINE_DUMMY_UNITS',	0,				2,		'TXT_KEY_UNIT_CORPSEPART_DUMMY');

INSERT INTO Unit_UniqueNames
			(UnitType,					UniqueName,						GreatWorkType)
VALUES		('UNIT_CORPSEPART_DUMMY',	'TXT_KEY_SBR_CORPSEPART_NAME_1','GREAT_WORK_CORPSE_PART_1'),
			('UNIT_CORPSEPART_DUMMY',	'TXT_KEY_SBR_CORPSEPART_NAME_2','GREAT_WORK_CORPSE_PART_2'),
			('UNIT_CORPSEPART_DUMMY',	'TXT_KEY_SBR_CORPSEPART_NAME_3','GREAT_WORK_CORPSE_PART_3'),
			('UNIT_CORPSEPART_DUMMY',	'TXT_KEY_SBR_CORPSEPART_NAME_4','GREAT_WORK_CORPSE_PART_4');

INSERT INTO Units
			(Type,								Class,								FoundReligion,	ShowInPedia,	Moves)
VALUES		('UNIT_VALENTINE_RELIGION_DUMMY',	'UNITCLASS_VALENTINE_DUMMY_UNITS',	1,				0,				2);



INSERT INTO GreatWorks
			(Type,							GreatWorkClassType,		Description,					Quote,								Image)
VALUES		('GREAT_WORK_CORPSE_PART_1',	'GREAT_WORK_ARTIFACT',	'TXT_KEY_SBR_CORPSE_PART_1',	'TXT_KEY_SBR_CORPSE_PART_1_QUOTE',	'GreatWriter_Background.dds'),
			('GREAT_WORK_CORPSE_PART_2',	'GREAT_WORK_ARTIFACT',	'TXT_KEY_SBR_CORPSE_PART_2',	'TXT_KEY_SBR_CORPSE_PART_2_QUOTE',	'GreatWriter_Background.dds'),
			('GREAT_WORK_CORPSE_PART_3',	'GREAT_WORK_ARTIFACT',	'TXT_KEY_SBR_CORPSE_PART_3',	'TXT_KEY_SBR_CORPSE_PART_3_QUOTE',	'GreatWriter_Background.dds'),
			('GREAT_WORK_CORPSE_PART_4',	'GREAT_WORK_ARTIFACT',	'TXT_KEY_SBR_CORPSE_PART_4',	'TXT_KEY_SBR_CORPSE_PART_4_QUOTE',	'GreatWriter_Background.dds');