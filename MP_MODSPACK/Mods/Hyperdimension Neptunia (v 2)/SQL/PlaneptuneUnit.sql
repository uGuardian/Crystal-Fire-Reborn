INSERT INTO UnitPromotions
			(Type,								Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_VV_DOGOO_KNIGHT'),		('TXT_KEY_PROMOTION_VV_DOGOO_KNIGHT'),		('TXT_KEY_PROMOTION_VV_DOGOO_KNIGHT_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_VV_DOGOO_KNIGHT')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_HOMELAND_GUARDIAN');


INSERT INTO UnitPromotions
			(Type,								Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,							PediaType,	PediaEntry,
			LostWithUpgrade)
SELECT		('PROMOTION_VV_DOGOO_KNIGHT_NOUPGRADE'),	('TXT_KEY_PROMOTION_VV_DOGOO_KNIGHT_NOUPGRADE'),('TXT_KEY_PROMOTION_VV_DOGOO_KNIGHT_NOUPGRADE_HELP'),
			CannotBeChosen,		Sound,	3,				('KRIS_SWORDSMAN_PROMOTION_ATLAS'),	PediaType,	('TXT_KEY_PROMOTION_VV_DOGOO_KNIGHT_NOUPGRADE'),
			1
FROM UnitPromotions	WHERE (Type = 'PROMOTION_HOMELAND_GUARDIAN');

INSERT INTO UnitPromotions_UnitClasses
			(PromotionType,							UnitClassType,				Modifier)
VALUES		('PROMOTION_VV_DOGOO_KNIGHT',			'UNITCLASS_SPEARMAN',		25),
			('PROMOTION_VV_DOGOO_KNIGHT',			'UNITCLASS_PIKEMAN',		25),
			('PROMOTION_VV_DOGOO_KNIGHT',			'UNITCLASS_LANCER',			25),
			('PROMOTION_VV_DOGOO_KNIGHT_NOUPGRADE',	'UNITCLASS_SWORDSMAN',		-25),
			('PROMOTION_VV_DOGOO_KNIGHT_NOUPGRADE',	'UNITCLASS_LONGSWORDSMAN',	-25);



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
SELECT		('UNIT_VV_DOGOO_KNIGHT'),	('TXT_KEY_UNIT_VV_DOGOO_KNIGHT'),	('TXT_KEY_UNIT_VV_DOGOO_KNIGHT_TEXT'),	('TXT_KEY_UNIT_VV_DOGOO_KNIGHT_STRATEGY'),	('TXT_KEY_UNIT_VV_DOGOO_KNIGHT_HELP'),
			Requirements, Combat + 1, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange,	Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,	Unhappiness,('ART_DEF_UNIT_DOGOO_KNIGHT'),0,0,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,0,4,('CIV_COLOR_ATLAS_VV_PLANEPTUNE'),('UNIT_FLAG_ATLAS_PLANEPTUNE')
FROM Units WHERE (Type = 'UNIT_KNIGHT');

--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 					SelectionSound,	FirstSelectionSound)
SELECT		('UNIT_VV_DOGOO_KNIGHT'),	SelectionSound,	FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_KNIGHT');
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================
INSERT INTO Unit_AITypes 	
			(UnitType, 					UnitAIType)
SELECT		('UNIT_VV_DOGOO_KNIGHT'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_KNIGHT');
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================
INSERT INTO Unit_Flavors 	
			(UnitType, 					FlavorType, Flavor)
SELECT		('UNIT_VV_DOGOO_KNIGHT'), 	FlavorType, Flavor + 5
FROM Unit_Flavors WHERE (UnitType = 'UNIT_KNIGHT');
--==========================================================================================================================
-- Unit_Builds
--==========================================================================================================================
INSERT INTO Unit_Builds 	
			(UnitType, 				BuildType)
SELECT		('UNIT_VV_DOGOO_KNIGHT'), BuildType
FROM Unit_Builds WHERE (UnitType = 'UNIT_KNIGHT');

--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions 	
			(UnitType, 					PromotionType)
SELECT		('UNIT_VV_DOGOO_KNIGHT'), 	PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_KNIGHT');

INSERT INTO Unit_FreePromotions
			(UnitType, 					PromotionType)
VALUES		('UNIT_VV_DOGOO_KNIGHT',	'PROMOTION_VV_DOGOO_KNIGHT'),
			('UNIT_VV_DOGOO_KNIGHT',	'PROMOTION_VV_DOGOO_KNIGHT_NOUPGRADE');

--==========================================================================================================================
-- Unit_Buildings
--==========================================================================================================================
INSERT INTO Unit_Buildings	
			(UnitType, 					BuildingType)
SELECT		('UNIT_VV_DOGOO_KNIGHT'), 	BuildingType
FROM Unit_Buildings WHERE (UnitType = 'UNIT_KNIGHT');

--==========================================================================================================================
-- Unit_BuildingClassRequireds
--==========================================================================================================================
INSERT INTO Unit_BuildingClassRequireds	
			(UnitType, 					BuildingClassType)
SELECT		('UNIT_VV_DOGOO_KNIGHT'), 	BuildingClassType
FROM Unit_BuildingClassRequireds WHERE (UnitType = 'UNIT_KNIGHT');

--==========================================================================================================================
-- Unit_ProductionModifierBuildings
--==========================================================================================================================
INSERT INTO Unit_ProductionModifierBuildings	
			(UnitType, 					BuildingType,	ProductionModifier)
SELECT		('UNIT_VV_DOGOO_KNIGHT'), 	BuildingType,	ProductionModifier
FROM Unit_ProductionModifierBuildings WHERE (UnitType = 'UNIT_KNIGHT');

--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================
INSERT INTO Unit_ClassUpgrades	
			(UnitType, 					UnitClassType)
SELECT		('UNIT_VV_DOGOO_KNIGHT'), 	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_KNIGHT');


--==========================================================================================================================
-- Unit_GreatPersons
--==========================================================================================================================
INSERT INTO Unit_GreatPersons	
			(UnitType, 					GreatPersonType)
SELECT		('UNIT_VV_DOGOO_KNIGHT'), 	GreatPersonType
FROM Unit_GreatPersons WHERE (UnitType = 'UNIT_KNIGHT');


--==========================================================================================================================
-- Unit_ResourceQuantityRequirements
--==========================================================================================================================
--none

--==========================================================================================================================
-- Unit_YieldFromKills
--==========================================================================================================================
INSERT INTO Unit_YieldFromKills	
			(UnitType, 					YieldType,	Yield)
SELECT		('UNIT_VV_DOGOO_KNIGHT'), 	YieldType,	Yield
FROM Unit_YieldFromKills WHERE (UnitType = 'UNIT_KNIGHT');




--Improvement

INSERT INTO ArtDefine_StrategicView(StrategicViewType, TileType, Asset)
SELECT 'ART_DEF_IMPROVEMENT_VV_DOGOO_SLIME', 'Improvement', 'SV_VV_NeptuneImprovement.dds';


INSERT INTO Improvements
			(Type,								Description,						Civilopedia,
			Help,											ArtDefineTag,								PortraitIndex,	IconAtlas,
			PillageGold, 	DestroyedWhenPillaged, DefenseModifier)
VALUES		('IMPROVEMENT_VV_DOGOO_SLIME',	'TXT_KEY_IMPROVEMENT_VV_DOGOO_SLIME',	'TXT_KEY_IMPROVEMENT_VV_DOGOO_SLIME_TEXT',
			'TXT_KEY_IMPROVEMENT_VV_DOGOO_SLIME_HELP','ART_DEF_IMPROVEMENT_VV_DOGOO_SLIME', 7,			'CIV_COLOR_ATLAS_VV_PLANEPTUNE',
			0,				1,						-20);