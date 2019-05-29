INSERT INTO EventsAddin_Support		
			(FileName)
VALUES		('OcelotEvents.lua');


INSERT INTO IconTextureAtlases 
			(Atlas, 								IconSize, 	Filename, 					IconsPerRow, 	IconsPerColumn)
VALUES		('CIV_COLOR_ATLAS_OCELOT_DECISIONS',	256,		'SolidSnake256.dds',		1,				1),
			('CIV_COLOR_ATLAS_OCELOT_DECISIONS',	128,		'SolidSnake128.dds',		1,				1),
			('CIV_COLOR_ATLAS_OCELOT_DECISIONS',	80,			'SolidSnake80.dds',			1,				1),
			('CIV_COLOR_ATLAS_OCELOT_DECISIONS',	64,			'SolidSnake64.dds',			1,				1),
			('CIV_COLOR_ATLAS_OCELOT_DECISIONS',	45,			'SolidSnake45.dds',			1,				1),
			('CIV_COLOR_ATLAS_OCELOT_DECISIONS',	32,			'SolidSnake32.dds',			1,				1);


INSERT INTO ArtDefine_UnitInfos (Type,DamageStates,Formation)
	SELECT	('ART_DEF_UNIT_DECISIONS_OCELOT_LSO'), DamageStates, Formation
	FROM ArtDefine_UnitInfos WHERE (Type = 'ART_DEF_UNIT_PARATROOPER');

INSERT INTO ArtDefine_UnitInfoMemberInfos (UnitInfoType,UnitMemberInfoType,NumMembers)
	SELECT	('ART_DEF_UNIT_DECISIONS_OCELOT_LSO'), UnitMemberInfoType, 1
	FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_PARATROOPER');




INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_DECISIONS_OCELOT_LSO'),		('TXT_KEY_PROMOTION_DECISIONS_OCELOT_LSO'),		('TXT_KEY_PROMOTION_DECISIONS_OCELOT_LSO_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_DECISIONS_OCELOT_LSO')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_STEAM_POWERED');

UPDATE UnitPromotions
SET AttackMod = 25, Invisible = 'INVISIBLE_SUBMARINE'
WHERE Type = 'PROMOTION_DECISIONS_OCELOT_LSO';

INSERT INTO UnitPromotions_UnitClasses
			(PromotionType,						UnitClassType,		Modifier,	PediaType)
VALUES		('PROMOTION_DECISIONS_OCELOT_LSO',	'UNITCLASS_MECH',	100,		'PEDIA_ATTRIBUTES');

INSERT INTO UnitPromotions_UnitClasses
			(PromotionType,						UnitClassType,				Modifier,	PediaType)
SELECT		('PROMOTION_DECISIONS_OCELOT_LSO'),	('UNITCLASS_METAL_GEAR'),	100,		('PEDIA_ATTRIBUTES')
WHERE EXISTS(SELECT * FROM Units WHERE Type = 'UNIT_METAL_GEAR');

CREATE TRIGGER MetalGearOcelotDecisionBonus
AFTER INSERT ON Units
WHEN (instr(NEW.Type, 'UNIT_METAL_GEAR') > 0)
BEGIN
	INSERT INTO UnitPromotions_UnitClasses
				(PromotionType,						UnitClassType,				Modifier,	PediaType)
	SELECT		('PROMOTION_DECISIONS_OCELOT_LSO'),	('UNITCLASS_METAL_GEAR'),	100,		('PEDIA_ATTRIBUTES')
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
SELECT		('UNIT_DECISIONS_OCELOT_LSO'),				Description,							Civilopedia,								Strategy,										Help,	
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,UnitArtInfo,UnitArtInfoCulturalVariation,UnitArtInfoEraVariation,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,UnitFlagIconOffset,PortraitIndex,IconAtlas,UnitFlagAtlas
FROM Units WHERE (Type = 'UNIT_PARATROOPER');


UPDATE Units
SET Combat = 110, GoodyHutUpgradeUnitClass = null, Cost = -1, FaithCost = -1, PrereqTech = null, ObsoleteTech = null, MoveRate = MoveRate + 1
WHERE Type = 'UNIT_DECISIONS_OCELOT_LSO';

--Text Info
UPDATE Units
SET Description = 'TXT_KEY_' || Type, Civilopedia = 'TXT_KEY_' || Type || '_TEXT', Strategy = null, Help = 'TXT_KEY_' || Type || '_HELP'
WHERE Type = 'UNIT_DECISIONS_OCELOT_LSO';

--Art Info
UPDATE Units
SET UnitArtInfo = 'ART_DEF_UNIT_DECISIONS_OCELOT_LSO', UnitArtInfoCulturalVariation = 0, UnitArtInfoEraVariation = 0, UnitFlagAtlas = 'CIV_ALPHA_ATLAS_OCELOT', UnitFlagIconOffset = 0, IconAtlas = 'CIV_COLOR_ATLAS_OCELOT_DECISIONS', PortraitIndex = 0
WHERE Type = 'UNIT_DECISIONS_OCELOT_LSO';


--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================
INSERT INTO Unit_AITypes 	
			(UnitType, 				UnitAIType)
SELECT		('UNIT_DECISIONS_OCELOT_LSO'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_INFANTRY');
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================
INSERT INTO Unit_Flavors 	
			(UnitType, 				FlavorType, Flavor)
SELECT		('UNIT_DECISIONS_OCELOT_LSO'), 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_PARATROOPER');
--==========================================================================================================================
-- Unit_Builds
--==========================================================================================================================
INSERT INTO Unit_Builds 	
			(UnitType, 				BuildType)
SELECT		('UNIT_DECISIONS_OCELOT_LSO'), BuildType
FROM Unit_Builds WHERE (UnitType = 'UNIT_PARATROOPER');
--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions 	
			(UnitType, 					PromotionType)
VALUES		('UNIT_DECISIONS_OCELOT_LSO', 'PROMOTION_DECISIONS_OCELOT_LSO');

--==========================================================================================================================
-- Unit_Buildings
--==========================================================================================================================
INSERT INTO Unit_Buildings	
			(UnitType, 				BuildingType)
SELECT		('UNIT_DECISIONS_OCELOT_LSO'), 	BuildingType
FROM Unit_Buildings WHERE (UnitType = 'UNIT_PARATROOPER');

--==========================================================================================================================
-- Unit_BuildingClassRequireds
--==========================================================================================================================
INSERT INTO Unit_BuildingClassRequireds	
			(UnitType, 				BuildingClassType)
SELECT		('UNIT_DECISIONS_OCELOT_LSO'), 	BuildingClassType
FROM Unit_BuildingClassRequireds WHERE (UnitType = 'UNIT_PARATROOPER');

--==========================================================================================================================
-- Unit_ProductionModifierBuildings
--==========================================================================================================================
INSERT INTO Unit_ProductionModifierBuildings	
			(UnitType, 				BuildingType,	ProductionModifier)
SELECT		('UNIT_DECISIONS_OCELOT_LSO'), 	BuildingType,	ProductionModifier
FROM Unit_ProductionModifierBuildings WHERE (UnitType = 'UNIT_PARATROOPER');


--==========================================================================================================================
-- Unit_GreatPersons
--==========================================================================================================================
INSERT INTO Unit_GreatPersons	
			(UnitType, 				GreatPersonType)
SELECT		('UNIT_DECISIONS_OCELOT_LSO'), 	GreatPersonType
FROM Unit_GreatPersons WHERE (UnitType = 'UNIT_PARATROOPER');


--==========================================================================================================================
-- Unit_ResourceQuantityRequirements
--==========================================================================================================================
INSERT INTO Unit_ResourceQuantityRequirements	
			(UnitType, 				ResourceType,	Cost)
SELECT		('UNIT_DECISIONS_OCELOT_LSO'), 	ResourceType,	Cost
FROM Unit_ResourceQuantityRequirements WHERE (UnitType = 'UNIT_PARATROOPER');


--==========================================================================================================================
-- Unit_YieldFromKills
--==========================================================================================================================
INSERT INTO Unit_YieldFromKills	
			(UnitType, 				YieldType,	Yield)
SELECT		('UNIT_DECISIONS_OCELOT_LSO'), 	YieldType,	Yield
FROM Unit_YieldFromKills WHERE (UnitType = 'UNIT_PARATROOPER');



INSERT INTO Unit_UniqueNames
			(UnitType,						UniqueName)
VALUES		('UNIT_DECISIONS_OCELOT_LSO',	'UNITNAME_DECISIONS_OCELOT_LSO');


INSERT INTO Audio_Sounds
			(SoundID,								Filename,			LoadType)
VALUES		('SND_SELECT_OCELOT_LSO',				'StOpsSelect',		'DynamicResident');


INSERT INTO Audio_2DSounds
			(ScriptID,					SoundID,					SoundType,		MaxVolume,		MinVolume)
VALUES		('AS2D_SELECT_OCELOT_LSO',	'SND_SELECT_OCELOT_LSO',	'GAME_SFX',		60,				60);


INSERT INTO UnitGameplay2DScripts
			(UnitType,						SelectionSound,				FirstSelectionSound)
VALUES		('UNIT_DECISIONS_OCELOT_LSO',	'AS2D_SELECT_OCELOT_LSO',	'AS2D_SELECT_OCELOT_LSO');