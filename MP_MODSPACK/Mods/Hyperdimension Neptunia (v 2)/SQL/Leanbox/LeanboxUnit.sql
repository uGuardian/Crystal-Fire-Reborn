--==========================================================================================================================
-- Promotion
--==========================================================================================================================

INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_VV_RANRAN'),		('TXT_KEY_PROMOTION_VV_RANRAN'),		('TXT_KEY_PROMOTION_VV_RANRAN_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_VV_RANRAN')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_HOMELAND_GUARDIAN');

INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry,
			DefenseMod)
SELECT		('PROMOTION_VV_RANRAN_BUFF'),		('TXT_KEY_PROMOTION_VV_RANRAN_BUFF'),		('TXT_KEY_PROMOTION_VV_RANRAN_HELP_BUFF'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_VV_RANRAN_BUFF'),
			10
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
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,	Unhappiness,UnitArtInfo,UnitArtInfoCulturalVariation,UnitArtInfoEraVariation,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,UnitFlagIconOffset,PortraitIndex,IconAtlas,UnitFlagAtlas)
SELECT		('UNIT_VV_RANRAN'),	('TXT_KEY_UNIT_VV_RANRAN'),	('TXT_KEY_UNIT_VV_RANRAN_TEXT'),	('TXT_KEY_UNIT_VV_RANRAN_STRATEGY'),	('TXT_KEY_UNIT_VV_RANRAN_HELP'),
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange,	Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, null, null, null, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,1,				Unhappiness,UnitArtInfo,UnitArtInfoCulturalVariation,null,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,0,3,('CIV_COLOR_ATLAS_VV_LEANBOX'),('UNIT_FLAG_ATLAS_RANRAN')
FROM Units WHERE (Type = 'UNIT_WORKER');

--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 						SelectionSound, FirstSelectionSound)
SELECT		('UNIT_VV_RANRAN'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_WORKER');	
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================
INSERT INTO Unit_AITypes 	
			(UnitType, 						UnitAIType)
SELECT		('UNIT_VV_RANRAN'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_WORKER');
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================
INSERT INTO Unit_Flavors 	
			(UnitType, 						FlavorType, Flavor)
SELECT		('UNIT_VV_RANRAN'), 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_WORKER');
--==========================================================================================================================
-- Unit_Builds
--==========================================================================================================================
INSERT INTO Unit_Builds 	
			(UnitType, 					BuildType)
SELECT		('UNIT_VV_RANRAN'), BuildType
FROM Unit_Builds WHERE (UnitType = 'UNIT_WORKER');

--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions 	
			(UnitType, 				PromotionType)
SELECT		('UNIT_VV_RANRAN'), 	PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_WORKER');

INSERT INTO Unit_FreePromotions 	
			(UnitType, 			PromotionType)
VALUES		('UNIT_VV_RANRAN', 	'PROMOTION_VV_RANRAN');

--==========================================================================================================================
-- Unit_Buildings
--==========================================================================================================================
INSERT INTO Unit_Buildings	
			(UnitType, 						BuildingType)
SELECT		('UNIT_VV_RANRAN'), 	BuildingType
FROM Unit_Buildings WHERE (UnitType = 'UNIT_WORKER');

--==========================================================================================================================
-- Unit_BuildingClassRequireds
--==========================================================================================================================
INSERT INTO Unit_BuildingClassRequireds	
			(UnitType, 						BuildingClassType)
SELECT		('UNIT_VV_RANRAN'), 	BuildingClassType
FROM Unit_BuildingClassRequireds WHERE (UnitType = 'UNIT_WORKER');

--==========================================================================================================================
-- Unit_ProductionModifierBuildings
--==========================================================================================================================
INSERT INTO Unit_ProductionModifierBuildings	
			(UnitType, 						BuildingType,	ProductionModifier)
SELECT		('UNIT_VV_RANRAN'), 	BuildingType,	ProductionModifier
FROM Unit_ProductionModifierBuildings WHERE (UnitType = 'UNIT_WORKER');

--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================
--none
--==========================================================================================================================
-- Unit_GreatPersons
--==========================================================================================================================
INSERT INTO Unit_GreatPersons	
			(UnitType, 						GreatPersonType)
SELECT		('UNIT_VV_RANRAN'), 	GreatPersonType
FROM Unit_GreatPersons WHERE (UnitType = 'UNIT_WORKER');


--==========================================================================================================================
-- Unit_ResourceQuantityRequirements
--==========================================================================================================================
--none

--==========================================================================================================================
-- Unit_YieldFromKills
--==========================================================================================================================
INSERT INTO Unit_YieldFromKills	
			(UnitType, 				YieldType,	Yield)
SELECT		('UNIT_VV_RANRAN'), 	YieldType,	Yield
FROM Unit_YieldFromKills WHERE (UnitType = 'UNIT_WORKER');




INSERT INTO Units 	
			(Type,							Description,							Civilopedia,						Strategy,										Help,										
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,UnitArtInfo,UnitArtInfoCulturalVariation,UnitArtInfoEraVariation,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,UnitFlagIconOffset,PortraitIndex,IconAtlas,UnitFlagAtlas)
SELECT		('UNIT_VV_GREAT_GAME_DEV'),	('TXT_KEY_UNIT_VV_GREAT_GAME_DEV'),	('TXT_KEY_UNIT_VV_GREAT_GAME_DEV_TEXT'),	('TXT_KEY_UNIT_VV_GREAT_GAME_DEV_STRATEGY'),	('TXT_KEY_UNIT_VV_GREAT_GAME_DEV_HELP'),
			Requirements, Combat, RangedCombat, -1, -1, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, null, null, null, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount - 4, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,UnitArtInfo,UnitArtInfoCulturalVariation,UnitArtInfoEraVariation,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,0,5,('CIV_COLOR_ATLAS_VV_LEANBOX'),('UNIT_FLAG_ATLAS_GAME_DEV')
FROM Units WHERE (Type = 'UNIT_SCIENTIST');

--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 						SelectionSound, FirstSelectionSound)
SELECT		('UNIT_VV_GREAT_GAME_DEV'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_SCIENTIST');	
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================
INSERT INTO Unit_AITypes 	
			(UnitType, 						UnitAIType)
SELECT		('UNIT_VV_GREAT_GAME_DEV'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_ARTIST');
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================
INSERT INTO Unit_Flavors 	
			(UnitType, 						FlavorType, Flavor)
SELECT		('UNIT_VV_GREAT_GAME_DEV'), 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_SCIENTIST');
--==========================================================================================================================
-- Unit_Builds
--==========================================================================================================================
-- none

--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions 	
			(UnitType, 				PromotionType)
SELECT		('UNIT_VV_GREAT_GAME_DEV'), 	PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_SCIENTIST');

--==========================================================================================================================
-- Unit_Buildings
--==========================================================================================================================
INSERT INTO Unit_Buildings	
			(UnitType, 						BuildingType)
SELECT		('UNIT_VV_GREAT_GAME_DEV'), 	BuildingType
FROM Unit_Buildings WHERE (UnitType = 'UNIT_SCIENTIST');

--==========================================================================================================================
-- Unit_BuildingClassRequireds
--==========================================================================================================================
INSERT INTO Unit_BuildingClassRequireds	
			(UnitType, 						BuildingClassType)
SELECT		('UNIT_VV_GREAT_GAME_DEV'), 	BuildingClassType
FROM Unit_BuildingClassRequireds WHERE (UnitType = 'UNIT_SCIENTIST');

--==========================================================================================================================
-- Unit_ProductionModifierBuildings
--==========================================================================================================================
INSERT INTO Unit_ProductionModifierBuildings	
			(UnitType, 						BuildingType,	ProductionModifier)
SELECT		('UNIT_VV_GREAT_GAME_DEV'), 	BuildingType,	ProductionModifier
FROM Unit_ProductionModifierBuildings WHERE (UnitType = 'UNIT_SCIENTIST');

--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================
--none
--==========================================================================================================================
-- Unit_GreatPersons
--==========================================================================================================================
INSERT INTO Unit_GreatPersons	
			(UnitType, 						GreatPersonType)
SELECT		('UNIT_VV_GREAT_GAME_DEV'), 	GreatPersonType
FROM Unit_GreatPersons WHERE (UnitType = 'UNIT_SCIENTIST');


--==========================================================================================================================
-- Unit_ResourceQuantityRequirements
--==========================================================================================================================
--none

--==========================================================================================================================
-- Unit_YieldFromKills
--==========================================================================================================================
INSERT INTO Unit_YieldFromKills	
			(UnitType, 						YieldType,	Yield)
SELECT		('UNIT_VV_GREAT_GAME_DEV'), 	YieldType,	Yield
FROM Unit_YieldFromKills WHERE (UnitType = 'UNIT_SCIENTIST');


--==========================================================================================================================
-- Unit_UniqueNames
--==========================================================================================================================

INSERT INTO Unit_UniqueNames
			(UnitType,					UniqueName,						GreatWorkType)
VALUES		('UNIT_VV_GREAT_GAME_DEV',	'TXT_KEY_VV_GAME_DEV_NAME_1',	'GREAT_WORK_VV_GAME_DEV_1'),
			('UNIT_VV_GREAT_GAME_DEV',	'TXT_KEY_VV_GAME_DEV_NAME_2',	'GREAT_WORK_VV_GAME_DEV_2'),
			('UNIT_VV_GREAT_GAME_DEV',	'TXT_KEY_VV_GAME_DEV_NAME_3',	'GREAT_WORK_VV_GAME_DEV_3'),
			('UNIT_VV_GREAT_GAME_DEV',	'TXT_KEY_VV_GAME_DEV_NAME_4',	'GREAT_WORK_VV_GAME_DEV_4'),
			('UNIT_VV_GREAT_GAME_DEV',	'TXT_KEY_VV_GAME_DEV_NAME_5',	'GREAT_WORK_VV_GAME_DEV_5'),
			('UNIT_VV_GREAT_GAME_DEV',	'TXT_KEY_VV_GAME_DEV_NAME_6',	'GREAT_WORK_VV_GAME_DEV_6'),
			('UNIT_VV_GREAT_GAME_DEV',	'TXT_KEY_VV_GAME_DEV_NAME_7',	'GREAT_WORK_VV_GAME_DEV_7'),
			('UNIT_VV_GREAT_GAME_DEV',	'TXT_KEY_VV_GAME_DEV_NAME_8',	'GREAT_WORK_VV_GAME_DEV_8'),
			('UNIT_VV_GREAT_GAME_DEV',	'TXT_KEY_VV_GAME_DEV_NAME_9',	'GREAT_WORK_VV_GAME_DEV_9'),
			('UNIT_VV_GREAT_GAME_DEV',	'TXT_KEY_VV_GAME_DEV_NAME_10',	'GREAT_WORK_VV_GAME_DEV_10'),
			('UNIT_VV_GREAT_GAME_DEV',	'TXT_KEY_VV_GAME_DEV_NAME_11',	'GREAT_WORK_VV_GAME_DEV_11'),
			('UNIT_VV_GREAT_GAME_DEV',	'TXT_KEY_VV_GAME_DEV_NAME_12',	'GREAT_WORK_VV_GAME_DEV_12'),
			('UNIT_VV_GREAT_GAME_DEV',	'TXT_KEY_VV_GAME_DEV_NAME_13',	'GREAT_WORK_VV_GAME_DEV_13'),
			('UNIT_VV_GREAT_GAME_DEV',	'TXT_KEY_VV_GAME_DEV_NAME_14',	'GREAT_WORK_VV_GAME_DEV_14'),
			('UNIT_VV_GREAT_GAME_DEV',	'TXT_KEY_VV_GAME_DEV_NAME_15',	'GREAT_WORK_VV_GAME_DEV_15'),
			('UNIT_VV_GREAT_GAME_DEV',	'TXT_KEY_VV_GAME_DEV_NAME_16',	'GREAT_WORK_VV_GAME_DEV_16'),
			('UNIT_VV_GREAT_GAME_DEV',	'TXT_KEY_VV_GAME_DEV_NAME_17',	'GREAT_WORK_VV_GAME_DEV_17'),
			('UNIT_VV_GREAT_GAME_DEV',	'TXT_KEY_VV_GAME_DEV_NAME_18',	'GREAT_WORK_VV_GAME_DEV_18'),
			('UNIT_VV_GREAT_GAME_DEV',	'TXT_KEY_VV_GAME_DEV_NAME_19',	'GREAT_WORK_VV_GAME_DEV_19'),
			('UNIT_VV_GREAT_GAME_DEV',	'TXT_KEY_VV_GAME_DEV_NAME_20',	'GREAT_WORK_VV_GAME_DEV_20');




--==========================================================================================================================
-- GreatWorks
--==========================================================================================================================

INSERT INTO GreatWorks
			(Type,							GreatWorkClassType,	Description,							Image,						Audio)
VALUES		('GREAT_WORK_VV_GAME_DEV_1',	'GREAT_WORK_ART',	'TXT_KEY_VV_GAME_DEV_GREAT_WORK_1',		'GDPong.dds',				'AS2D_GREAT_ARTIST_ARTWORK'),
			('GREAT_WORK_VV_GAME_DEV_2',	'GREAT_WORK_ART',	'TXT_KEY_VV_GAME_DEV_GREAT_WORK_2',		'GDSpaceInvaders.dds',		'AS2D_GREAT_ARTIST_ARTWORK'),
			('GREAT_WORK_VV_GAME_DEV_3',	'GREAT_WORK_ART',	'TXT_KEY_VV_GAME_DEV_GREAT_WORK_3',		'GDPacMan.dds',				'AS2D_GREAT_ARTIST_ARTWORK'),
			('GREAT_WORK_VV_GAME_DEV_4',	'GREAT_WORK_ART',	'TXT_KEY_VV_GAME_DEV_GREAT_WORK_4',		'GDDoom.dds',				'AS2D_GREAT_ARTIST_ARTWORK'),
			('GREAT_WORK_VV_GAME_DEV_5',	'GREAT_WORK_ART',	'TXT_KEY_VV_GAME_DEV_GREAT_WORK_5',		'GDCivilization.dds',		'AS2D_GREAT_ARTIST_ARTWORK'),
			('GREAT_WORK_VV_GAME_DEV_6',	'GREAT_WORK_ART',	'TXT_KEY_VV_GAME_DEV_GREAT_WORK_6',		'GDHalo.dds',				'AS2D_GREAT_ARTIST_ARTWORK'),
			('GREAT_WORK_VV_GAME_DEV_7',	'GREAT_WORK_ART',	'TXT_KEY_VV_GAME_DEV_GREAT_WORK_7',		'GDGearsOfWar.dds',			'AS2D_GREAT_ARTIST_ARTWORK'),
			('GREAT_WORK_VV_GAME_DEV_8',	'GREAT_WORK_ART',	'TXT_KEY_VV_GAME_DEV_GREAT_WORK_8',		'GDCallOfDuty.dds',			'AS2D_GREAT_ARTIST_ARTWORK'),
			('GREAT_WORK_VV_GAME_DEV_9',	'GREAT_WORK_ART',	'TXT_KEY_VV_GAME_DEV_GREAT_WORK_9',		'GDMinecraft.dds',			'AS2D_GREAT_ARTIST_ARTWORK'),
			('GREAT_WORK_VV_GAME_DEV_10',	'GREAT_WORK_ART',	'TXT_KEY_VV_GAME_DEV_GREAT_WORK_10',	'GDTetris.dds',				'AS2D_GREAT_ARTIST_ARTWORK'),
			('GREAT_WORK_VV_GAME_DEV_11',	'GREAT_WORK_ART',	'TXT_KEY_VV_GAME_DEV_GREAT_WORK_11',	'GDHalfLife.dds',			'AS2D_GREAT_ARTIST_ARTWORK'),
			('GREAT_WORK_VV_GAME_DEV_12',	'GREAT_WORK_ART',	'TXT_KEY_VV_GAME_DEV_GREAT_WORK_12',	'GDMetalGearSolid.dds',		'AS2D_GREAT_ARTIST_ARTWORK'),
			('GREAT_WORK_VV_GAME_DEV_13',	'GREAT_WORK_ART',	'TXT_KEY_VV_GAME_DEV_GREAT_WORK_13',	'GDStreetFighterII.dds',	'AS2D_GREAT_ARTIST_ARTWORK'),
			('GREAT_WORK_VV_GAME_DEV_14',	'GREAT_WORK_ART',	'TXT_KEY_VV_GAME_DEV_GREAT_WORK_14',	'GDAssassinsCreed.dds',		'AS2D_GREAT_ARTIST_ARTWORK'),
			('GREAT_WORK_VV_GAME_DEV_15',	'GREAT_WORK_ART',	'TXT_KEY_VV_GAME_DEV_GREAT_WORK_15',	'GDGrandTheftAuto3.dds',	'AS2D_GREAT_ARTIST_ARTWORK'),
			('GREAT_WORK_VV_GAME_DEV_16',	'GREAT_WORK_ART',	'TXT_KEY_VV_GAME_DEV_GREAT_WORK_16',	'GDWorldOfWarcraft.dds',	'AS2D_GREAT_ARTIST_ARTWORK'),
			('GREAT_WORK_VV_GAME_DEV_17',	'GREAT_WORK_ART',	'TXT_KEY_VV_GAME_DEV_GREAT_WORK_17',	'GDStarcraft.dds',			'AS2D_GREAT_ARTIST_ARTWORK'),
			('GREAT_WORK_VV_GAME_DEV_18',	'GREAT_WORK_ART',	'TXT_KEY_VV_GAME_DEV_GREAT_WORK_18',	'GDFable.dds',				'AS2D_GREAT_ARTIST_ARTWORK'),
			('GREAT_WORK_VV_GAME_DEV_19',	'GREAT_WORK_ART',	'TXT_KEY_VV_GAME_DEV_GREAT_WORK_19',	'GDMassEffect.dds',			'AS2D_GREAT_ARTIST_ARTWORK'),
			('GREAT_WORK_VV_GAME_DEV_20',	'GREAT_WORK_ART',	'TXT_KEY_VV_GAME_DEV_GREAT_WORK_20',	'GDFallout.dds',			'AS2D_GREAT_ARTIST_ARTWORK');