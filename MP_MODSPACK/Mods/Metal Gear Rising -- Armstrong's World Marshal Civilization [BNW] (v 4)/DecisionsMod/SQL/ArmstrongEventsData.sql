INSERT INTO EventsAddin_Support		
			(FileName)
VALUES		('ArmstrongEvents.lua');


INSERT INTO IconTextureAtlases 
			(Atlas, 								IconSize, 	Filename, 					IconsPerRow, 	IconsPerColumn)
VALUES		('CIV_COLOR_ATLAS_ARMSTRONG_DECISIONS',	256,		'MGSRaiden256.dds',			1,				1),
			('CIV_COLOR_ATLAS_ARMSTRONG_DECISIONS',	128,		'MGSRaiden128.dds',			1,				1),
			('CIV_COLOR_ATLAS_ARMSTRONG_DECISIONS',	80,			'MGSRaiden80.dds',			1,				1),
			('CIV_COLOR_ATLAS_ARMSTRONG_DECISIONS',	64,			'MGSRaiden64.dds',			1,				1),
			('CIV_COLOR_ATLAS_ARMSTRONG_DECISIONS',	45,			'MGSRaiden45.dds',			1,				1),
			('CIV_COLOR_ATLAS_ARMSTRONG_DECISIONS',	32,			'MGSRaiden32.dds',			1,				1);


INSERT INTO ArtDefine_UnitInfos (Type,DamageStates,Formation)
	SELECT	('ART_DEF_UNIT_DECISIONS_ARMSTRONG_RAIDEN'), DamageStates, Formation
	FROM ArtDefine_UnitInfos WHERE (Type = 'ART_DEF_UNIT_CYBORG_NINJA');

INSERT INTO ArtDefine_UnitInfoMemberInfos (UnitInfoType,UnitMemberInfoType,NumMembers)
	SELECT	('ART_DEF_UNIT_DECISIONS_ARMSTRONG_RAIDEN'), UnitMemberInfoType, 1
	FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_CYBORG_NINJA');

INSERT INTO ArtDefine_StrategicView
			(StrategicViewType,							TileType,	Asset)
VALUES		('ART_DEF_UNIT_DECISIONS_ARMSTRONG_RAIDEN',	'Unit',		'SV_CyborgNinja.dds');




INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_DECISIONS_ARMSTRONG_RAIDEN'),		('TXT_KEY_PROMOTION_DECISIONS_ARMSTRONG_RAIDEN'),		('TXT_KEY_PROMOTION_DECISIONS_ARMSTRONG_RAIDEN_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_DECISIONS_ARMSTRONG_RAIDEN')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_STEAM_POWERED');


UPDATE UnitPromotions
SET HPHealedIfDestroyEnemy=99
WHERE Type = 'PROMOTION_DECISIONS_ARMSTRONG_RAIDEN';

INSERT INTO UnitPromotions_UnitClasses
			(PromotionType,						UnitClassType,		Modifier,	PediaType)
VALUES		('PROMOTION_DECISIONS_ARMSTRONG_RAIDEN',	'UNITCLASS_MECH',	100,		'PEDIA_ATTRIBUTES');

INSERT INTO UnitPromotions_UnitClasses
			(PromotionType,						UnitClassType,				Modifier,	PediaType)
SELECT		('PROMOTION_DECISIONS_ARMSTRONG_RAIDEN'),	('UNITCLASS_METAL_GEAR'),	100,		('PEDIA_ATTRIBUTES')
WHERE EXISTS(SELECT * FROM Units WHERE Type = 'UNIT_METAL_GEAR');

CREATE TRIGGER MetalGearArmstrongDecisionBonus
AFTER INSERT ON Units
WHEN (instr(NEW.Type, 'UNIT_METAL_GEAR') > 0)
BEGIN
	INSERT INTO UnitPromotions_UnitClasses
				(PromotionType,						UnitClassType,				Modifier,	PediaType)
	SELECT		('PROMOTION_DECISIONS_ARMSTRONG_RAIDEN'),	('UNITCLASS_METAL_GEAR'),	100,		('PEDIA_ATTRIBUTES')
	WHERE NOT EXISTS(SELECT * FROM UnitPromotions_UnitClasses WHERE PromotionType = 'UNIT_METAL_GEAR' AND UnitClassType = 'UNITCLASS_METAL_GEAR');
END;



INSERT INTO Units 	
			(Type,							Description,							Civilopedia,								Strategy,										Help,										
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,UnitArtInfo,UnitArtInfoCulturalVariation,UnitArtInfoEraVariation,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,UnitFlagIconOffset,PortraitIndex,IconAtlas,UnitFlagAtlas)
SELECT		('UNIT_DECISIONS_ARMSTRONG_RAIDEN'),				Description,							Civilopedia,								Strategy,										Help,	
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,UnitArtInfo,UnitArtInfoCulturalVariation,UnitArtInfoEraVariation,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,UnitFlagIconOffset,PortraitIndex,IconAtlas,UnitFlagAtlas
FROM Units WHERE (Type = 'UNIT_CYBORG_NINJA');


UPDATE Units
SET Combat = 150, Cost = -1, FaithCost = -1, PrereqTech = null
WHERE Type = 'UNIT_DECISIONS_ARMSTRONG_RAIDEN';

--Text Info
UPDATE Units
SET Description = 'TXT_KEY_' || Type
WHERE Type = 'UNIT_DECISIONS_ARMSTRONG_RAIDEN';

--Art Info
UPDATE Units
SET UnitArtInfo = 'ART_DEF_UNIT_DECISIONS_ARMSTRONG_RAIDEN', UnitArtInfoCulturalVariation = 0, UnitArtInfoEraVariation = 0, UnitFlagAtlas = 'UNIT_ALPHA_ATLAS_CYBORG_NINJA', UnitFlagIconOffset = 0, IconAtlas = 'CIV_COLOR_ATLAS_ARMSTRONG_DECISIONS', PortraitIndex = 0
WHERE Type = 'UNIT_DECISIONS_ARMSTRONG_RAIDEN';


--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================
INSERT INTO Unit_AITypes 	
			(UnitType, 				UnitAIType)
SELECT		('UNIT_DECISIONS_ARMSTRONG_RAIDEN'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_CYBORG_NINJA');
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================
INSERT INTO Unit_Flavors 	
			(UnitType, 				FlavorType, Flavor)
SELECT		('UNIT_DECISIONS_ARMSTRONG_RAIDEN'), 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_CYBORG_NINJA');
--==========================================================================================================================
-- Unit_Builds
--==========================================================================================================================
INSERT INTO Unit_Builds 	
			(UnitType, 				BuildType)
SELECT		('UNIT_DECISIONS_ARMSTRONG_RAIDEN'), BuildType
FROM Unit_Builds WHERE (UnitType = 'UNIT_CYBORG_NINJA');
--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions 	
			(UnitType, 							PromotionType)
VALUES		('UNIT_DECISIONS_ARMSTRONG_RAIDEN', 'PROMOTION_DECISIONS_ARMSTRONG_RAIDEN');

--==========================================================================================================================
-- Unit_Buildings
--==========================================================================================================================
INSERT INTO Unit_Buildings	
			(UnitType, 				BuildingType)
SELECT		('UNIT_DECISIONS_ARMSTRONG_RAIDEN'), 	BuildingType
FROM Unit_Buildings WHERE (UnitType = 'UNIT_CYBORG_NINJA');

--==========================================================================================================================
-- Unit_BuildingClassRequireds
--==========================================================================================================================
INSERT INTO Unit_BuildingClassRequireds	
			(UnitType, 				BuildingClassType)
SELECT		('UNIT_DECISIONS_ARMSTRONG_RAIDEN'), 	BuildingClassType
FROM Unit_BuildingClassRequireds WHERE (UnitType = 'UNIT_CYBORG_NINJA');

--==========================================================================================================================
-- Unit_ProductionModifierBuildings
--==========================================================================================================================
INSERT INTO Unit_ProductionModifierBuildings	
			(UnitType, 				BuildingType,	ProductionModifier)
SELECT		('UNIT_DECISIONS_ARMSTRONG_RAIDEN'), 	BuildingType,	ProductionModifier
FROM Unit_ProductionModifierBuildings WHERE (UnitType = 'UNIT_CYBORG_NINJA');


--==========================================================================================================================
-- Unit_GreatPersons
--==========================================================================================================================
INSERT INTO Unit_GreatPersons	
			(UnitType, 				GreatPersonType)
SELECT		('UNIT_DECISIONS_ARMSTRONG_RAIDEN'), 	GreatPersonType
FROM Unit_GreatPersons WHERE (UnitType = 'UNIT_CYBORG_NINJA');


--==========================================================================================================================
-- Unit_ResourceQuantityRequirements
--==========================================================================================================================
INSERT INTO Unit_ResourceQuantityRequirements	
			(UnitType, 				ResourceType,	Cost)
SELECT		('UNIT_DECISIONS_ARMSTRONG_RAIDEN'), 	ResourceType,	Cost
FROM Unit_ResourceQuantityRequirements WHERE (UnitType = 'UNIT_CYBORG_NINJA');


--==========================================================================================================================
-- Unit_YieldFromKills
--==========================================================================================================================
INSERT INTO Unit_YieldFromKills	
			(UnitType, 				YieldType,	Yield)
SELECT		('UNIT_DECISIONS_ARMSTRONG_RAIDEN'), 	YieldType,	Yield
FROM Unit_YieldFromKills WHERE (UnitType = 'UNIT_CYBORG_NINJA');


INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 				SelectionSound,					FirstSelectionSound)
VALUES		('UNIT_DECISIONS_ARMSTRONG_RAIDEN', 	'AS2D_SELECT_LONGSWORDSMAN',	'AS2D_SELECT_LONGSWORDSMAN');