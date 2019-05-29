--All SQL Unit inserts were based off of SQL code from JFD's Civilizations.

--==========================================================================================================================
-- Art Define
--==========================================================================================================================

INSERT INTO ArtDefine_UnitInfos (Type,DamageStates,Formation)
	SELECT	('ART_DEF_UNIT_VV_STEALTH_OPERATIVE'), DamageStates, Formation
	FROM ArtDefine_UnitInfos WHERE (Type = 'ART_DEF_UNIT_INFANTRY');

INSERT INTO ArtDefine_UnitInfoMemberInfos (UnitInfoType,UnitMemberInfoType,NumMembers)
	SELECT	('ART_DEF_UNIT_VV_STEALTH_OPERATIVE'), ('ART_DEF_UNIT_MEMBER_VV_STEALTH_OPERATIVE'), NumMembers
	FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_INFANTRY');

INSERT INTO ArtDefine_UnitMemberCombats (UnitMemberType,	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
	SELECT	('ART_DEF_UNIT_MEMBER_VV_STEALTH_OPERATIVE'),			EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
	FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_INFANTRY');

INSERT INTO ArtDefine_UnitMemberInfos (Type,	Scale, ZOffset, Domain, Model,						MaterialTypeTag, MaterialTypeSoundOverrideTag)
	SELECT	('ART_DEF_UNIT_MEMBER_VV_STEALTH_OPERATIVE'),	Scale, ZOffset, Domain, ('stealthop.fxsxml'),	MaterialTypeTag, MaterialTypeSoundOverrideTag
	FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_INFANTRY');

INSERT INTO ArtDefine_StrategicView
			(StrategicViewType,						TileType,	Asset)
VALUES		('ART_DEF_UNIT_VV_STEALTH_OPERATIVE',	'Unit',		'SV_VV_UniUnit.dds');




INSERT INTO ArtDefine_UnitInfos (Type,DamageStates,Formation)
	SELECT	('ART_DEF_UNIT_VV_METAL_GEAR'), DamageStates, Formation
	FROM ArtDefine_UnitInfos WHERE (Type = 'ART_DEF_UNIT_MECH');

INSERT INTO ArtDefine_UnitInfoMemberInfos (UnitInfoType,UnitMemberInfoType,NumMembers)
	SELECT	('ART_DEF_UNIT_VV_METAL_GEAR'), ('ART_DEF_UNIT_MEMBER_VV_METAL_GEAR'), NumMembers
	FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_MECH');

INSERT INTO ArtDefine_UnitMemberCombats (UnitMemberType,	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
	SELECT	('ART_DEF_UNIT_MEMBER_VV_METAL_GEAR'),			EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
	FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_MECH');

INSERT INTO ArtDefine_UnitMemberInfos (Type,	Scale, ZOffset, Domain, Model,						MaterialTypeTag, MaterialTypeSoundOverrideTag)
	SELECT	('ART_DEF_UNIT_MEMBER_VV_METAL_GEAR'),	Scale, ZOffset, Domain, ('metalgear.fxsxml'),	MaterialTypeTag, MaterialTypeSoundOverrideTag
	FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_MECH');

INSERT INTO ArtDefine_StrategicView
			(StrategicViewType,						TileType,	Asset)
VALUES		('ART_DEF_UNIT_VV_METAL_GEAR',	'Unit',		'SV_VV_UniUnit.dds');


--==========================================================================================================================
-- Promotion
--==========================================================================================================================

UPDATE UnitPromotions
SET LostWithUpgrade = 1
WHERE Type = 'PROMOTION_NO_CAPTURE';

INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_TACTICAL_ESPIONAGE_ACTION'),		('TXT_KEY_PROMOTION_TACTICAL_ESPIONAGE_ACTION'),		('TXT_KEY_PROMOTION_TACTICAL_ESPIONAGE_ACTION_HELP'),
			1,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_TACTICAL_ESPIONAGE_ACTION')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');


UPDATE UnitPromotions
SET Invisible='INVISIBLE_SUBMARINE', AttackMod = 25, DefenseMod = -25, IgnoreZOC = 1
WHERE Type = 'PROMOTION_TACTICAL_ESPIONAGE_ACTION';


INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_CAPTURE_IN_OWN_TERRITORY'),		('TXT_KEY_PROMOTION_CAPTURE_IN_OWN_TERRITORY'),		('TXT_KEY_PROMOTION_CAPTURE_IN_OWN_TERRITORY_HELP'),
			1,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_CAPTURE_IN_OWN_TERRITORY')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');

INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_FULTON_RECOVERY_SYSTEM'),		('TXT_KEY_PROMOTION_FULTON_RECOVERY_SYSTEM'),		('TXT_KEY_PROMOTION_FULTON_RECOVERY_SYSTEM_HELP'),
			1,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_FULTON_RECOVERY_SYSTEM')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');


UPDATE UnitPromotions
SET CaptureDefeatedEnemy = 1
WHERE Type = 'PROMOTION_FULTON_RECOVERY_SYSTEM' OR Type = 'PROMOTION_CAPTURE_IN_OWN_TERRITORY';


INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_EXPERIENCE_BOOST_MSF'),		('TXT_KEY_PROMOTION_EXPERIENCE_BOOST_MSF'),		('TXT_KEY_PROMOTION_EXPERIENCE_BOOST_MSF_HELP'),
			1,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_EXPERIENCE_BOOST_MSF')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');

UPDATE UnitPromotions
SET ExperiencePercent = 2
WHERE Type = 'PROMOTION_EXPERIENCE_BOOST_MSF';

INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_DIAMOND_DOGS_RECAPTURE'),		('TXT_KEY_PROMOTION_DIAMOND_DOGS_RECAPTURE'),		('TXT_KEY_PROMOTION_DIAMOND_DOGS_RECAPTURE_HELP'),
			1,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_DIAMOND_DOGS_RECAPTURE')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');

UPDATE UnitPromotions
SET CombatPercent = 100, CityAttack = 100
WHERE Type = 'PROMOTION_DIAMOND_DOGS_RECAPTURE';


INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_BB_OUTER_HEAVEN'),		('TXT_KEY_PROMOTION_BB_OUTER_HEAVEN'),		('TXT_KEY_PROMOTION_BB_OUTER_HEAVEN_HELP'),
			1,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_BB_OUTER_HEAVEN')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');

UPDATE UnitPromotions
SET CombatPercent = 15
WHERE Type = 'PROMOTION_BB_OUTER_HEAVEN';


INSERT INTO UnitPromotions_UnitCombats
			(PromotionType,			UnitCombatType)
SELECT		('PROMOTION_EXPERIENCE_BOOST_MSF'),			UnitCombatType
FROM UnitPromotions_UnitCombats WHERE PromotionType = 'PROMOTION_INSTA_HEAL';

INSERT INTO UnitPromotions_UnitCombats
			(PromotionType,			UnitCombatType)
SELECT		('PROMOTION_BB_OUTER_HEAVEN'),			UnitCombatType
FROM UnitPromotions_UnitCombats WHERE PromotionType = 'PROMOTION_INSTA_HEAL';

INSERT INTO	UnitPromotions_UnitCombats
			(PromotionType,			UnitCombatType)
VALUES		('PROMOTION_FULTON_RECOVERY_SYSTEM', 'UNITCOMBAT_MELEE'),
			('PROMOTION_FULTON_RECOVERY_SYSTEM', 'UNITCOMBAT_MOUNTED'),
			('PROMOTION_FULTON_RECOVERY_SYSTEM', 'UNITCOMBAT_RECON'),
			('PROMOTION_FULTON_RECOVERY_SYSTEM', 'UNITCOMBAT_ARMOR'),
			('PROMOTION_FULTON_RECOVERY_SYSTEM', 'UNITCOMBAT_GUN');

--==========================================================================================================================
-- Stealth Operative
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
SELECT		('UNIT_STEALTH_OPERATIVE'),				Description,							Civilopedia,								Strategy,										Help,	
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves + 2, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,('ART_DEF_UNIT_VV_STEALTH_OPERATIVE'),0,0,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,0,3,('CIV_COLOR_ATLAS_MSF'),('CIV_ALPHA_ATLAS_STOPS')
FROM Units WHERE (Type = 'UNIT_PARATROOPER');

--Text Info
UPDATE Units
SET Description = 'TXT_KEY_' || Type, Civilopedia = 'TXT_KEY_' || Type || '_TEXT', Strategy = 'TXT_KEY_' || Type || '_STRATEGY', Help = 'TXT_KEY_' || Type || '_HELP'
WHERE Type = 'UNIT_STEALTH_OPERATIVE';


--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 					SelectionSound,						FirstSelectionSound)
VALUES		('UNIT_STEALTH_OPERATIVE', 	'AS2D_SELECT_STEALTH_OPERATIVE',	'AS2D_SELECT_STEALTH_OPERATIVE');	
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================
INSERT INTO Unit_AITypes 	
			(UnitType, 				UnitAIType)
SELECT		('UNIT_STEALTH_OPERATIVE'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_PARATROOPER');
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================
INSERT INTO Unit_Flavors 	
			(UnitType, 				FlavorType, Flavor)
SELECT		('UNIT_STEALTH_OPERATIVE'), 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_PARATROOPER');
--==========================================================================================================================
-- Unit_Builds
--==========================================================================================================================
INSERT INTO Unit_Builds 	
			(UnitType, 				BuildType)
SELECT		('UNIT_STEALTH_OPERATIVE'), BuildType
FROM Unit_Builds WHERE (UnitType = 'UNIT_PARATROOPER');

--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions 	
			(UnitType, 				PromotionType)
VALUES		('UNIT_STEALTH_OPERATIVE', 	'PROMOTION_TACTICAL_ESPIONAGE_ACTION'),
			('UNIT_STEALTH_OPERATIVE', 	'PROMOTION_NO_CAPTURE'),
			('UNIT_STEALTH_OPERATIVE', 	'PROMOTION_CITY_PENALTY');


--==========================================================================================================================
-- Unit_Buildings
--==========================================================================================================================
INSERT INTO Unit_Buildings	
			(UnitType, 				BuildingType)
SELECT		('UNIT_STEALTH_OPERATIVE'), 	BuildingType
FROM Unit_Buildings WHERE (UnitType = 'UNIT_PARATROOPER');

--==========================================================================================================================
-- Unit_BuildingClassRequireds
--==========================================================================================================================
INSERT INTO Unit_BuildingClassRequireds	
			(UnitType, 				BuildingClassType)
SELECT		('UNIT_STEALTH_OPERATIVE'), 	BuildingClassType
FROM Unit_BuildingClassRequireds WHERE (UnitType = 'UNIT_PARATROOPER');

--==========================================================================================================================
-- Unit_ProductionModifierBuildings
--==========================================================================================================================
INSERT INTO Unit_ProductionModifierBuildings	
			(UnitType, 				BuildingType,	ProductionModifier)
SELECT		('UNIT_STEALTH_OPERATIVE'), 	BuildingType,	ProductionModifier
FROM Unit_ProductionModifierBuildings WHERE (UnitType = 'UNIT_PARATROOPER');


--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================
INSERT INTO Unit_ClassUpgrades	
			(UnitType, 				UnitClassType)
SELECT		('UNIT_STEALTH_OPERATIVE'), 	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_PARATROOPER');

--==========================================================================================================================
-- Unit_GreatPersons
--==========================================================================================================================
INSERT INTO Unit_GreatPersons	
			(UnitType, 				GreatPersonType)
SELECT		('UNIT_STEALTH_OPERATIVE'), 	GreatPersonType
FROM Unit_GreatPersons WHERE (UnitType = 'UNIT_PARATROOPER');


--==========================================================================================================================
-- Unit_ResourceQuantityRequirements
--==========================================================================================================================
INSERT INTO Unit_ResourceQuantityRequirements	
			(UnitType, 				ResourceType,	Cost)
SELECT		('UNIT_STEALTH_OPERATIVE'), 	ResourceType,	Cost
FROM Unit_ResourceQuantityRequirements WHERE (UnitType = 'UNIT_PARATROOPER');

--==========================================================================================================================
-- Unit_YieldFromKills
--==========================================================================================================================
INSERT INTO Unit_YieldFromKills	
			(UnitType, 				YieldType,	Yield)
SELECT		('UNIT_STEALTH_OPERATIVE'), 	YieldType,	Yield
FROM Unit_YieldFromKills WHERE (UnitType = 'UNIT_PARATROOPER');











--==========================================================================================================================
-- Metal Gear
--==========================================================================================================================

INSERT INTO UnitClasses
			(Type,									Description)
VALUES		('UNITCLASS_METAL_GEAR',				'TXT_KEY_UNIT_METAL_GEAR'),
			('UNITCLASS_CITYSTATEPUPPETER_DUMMY',	'TXT_KEY_UNIT_STEALTH_OPERATIVE');

UPDATE UnitClasses
SET MaxPlayerInstances = 1
WHERE Type = 'UNITCLASS_METAL_GEAR';



INSERT INTO Units 	
			(Type,							Description,							Civilopedia,								Strategy,										Help,										
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,UnitArtInfo,UnitArtInfoCulturalVariation,UnitArtInfoEraVariation,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,UnitFlagIconOffset,PortraitIndex,IconAtlas,UnitFlagAtlas)
SELECT		('UNIT_METAL_GEAR'),				Description,							Civilopedia,								Strategy,										Help,	
			Requirements, Combat + 50, RangedCombat, CAST((Cost * 1.75) AS INT), -1, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, ('UNITCLASS_METAL_GEAR'), Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, ('TECH_ROBOTICS'), ObsoleteTech, GoodyHutUpgradeUnitClass, -1, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,('SPECIALUNIT_MISSILE'),('DOMAIN_AIR'),Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,('ART_DEF_UNIT_VV_METAL_GEAR'),0,0,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,0,2,('CIV_COLOR_ATLAS_MSF'),('CIV_ALPHA_ATLAS_MG')
FROM Units WHERE (Type = 'UNIT_MECH');


--Text Info
UPDATE Units
SET Description = 'TXT_KEY_' || Type, Civilopedia = 'TXT_KEY_' || Type || '_TEXT', Strategy = 'TXT_KEY_' || Type || '_STRATEGY', Help = 'TXT_KEY_' || Type || '_HELP'
WHERE Type = 'UNIT_METAL_GEAR';



--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 				SelectionSound,				FirstSelectionSound)
VALUES		('UNIT_METAL_GEAR', 	'AS2D_SELECT_METAL_GEAR',	'AS2D_SELECT_METAL_GEAR');	
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================
INSERT INTO Unit_AITypes 	
			(UnitType, 				UnitAIType)
SELECT		('UNIT_METAL_GEAR'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_MECH');
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================
INSERT INTO Unit_Flavors 	
			(UnitType, 				FlavorType, Flavor)
SELECT		('UNIT_METAL_GEAR'), 	FlavorType, CAST((Flavor * 2) AS INT)
FROM Unit_Flavors WHERE (UnitType = 'UNIT_MECH');
--==========================================================================================================================
-- Unit_Builds
--==========================================================================================================================
INSERT INTO Unit_Builds 	
			(UnitType, 				BuildType)
SELECT		('UNIT_METAL_GEAR'), BuildType
FROM Unit_Builds WHERE (UnitType = 'UNIT_MECH');

--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions 	
			(UnitType, 				PromotionType)
SELECT		('UNIT_METAL_GEAR'),	PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_MECH');

INSERT INTO Unit_FreePromotions 	
			(UnitType, 				PromotionType)
VALUES		('UNIT_METAL_GEAR',		'PROMOTION_CARGO_I'),
			('UNIT_METAL_GEAR',		'PROMOTION_IGNORE_TERRAIN_COST');


--==========================================================================================================================
-- Unit_Buildings
--==========================================================================================================================
INSERT INTO Unit_Buildings	
			(UnitType, 				BuildingType)
SELECT		('UNIT_METAL_GEAR'), 	BuildingType
FROM Unit_Buildings WHERE (UnitType = 'UNIT_MECH');

--==========================================================================================================================
-- Unit_BuildingClassRequireds
--==========================================================================================================================
INSERT INTO Unit_BuildingClassRequireds	
			(UnitType, 				BuildingClassType)
VALUES		('UNIT_METAL_GEAR',		'BUILDINGCLASS_METAL_GEAR_HANGAR');

--==========================================================================================================================
-- Unit_ProductionModifierBuildings
--==========================================================================================================================
INSERT INTO Unit_ProductionModifierBuildings	
			(UnitType, 				BuildingType,	ProductionModifier)
SELECT		('UNIT_METAL_GEAR'), 	BuildingType,	ProductionModifier
FROM Unit_ProductionModifierBuildings WHERE (UnitType = 'UNIT_MECH');


--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================
INSERT INTO Unit_ClassUpgrades	
			(UnitType, 				UnitClassType)
SELECT		('UNIT_METAL_GEAR'), 	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_MECH');

--==========================================================================================================================
-- Unit_GreatPersons
--==========================================================================================================================
INSERT INTO Unit_GreatPersons	
			(UnitType, 				GreatPersonType)
SELECT		('UNIT_METAL_GEAR'), 	GreatPersonType
FROM Unit_GreatPersons WHERE (UnitType = 'UNIT_MECH');


--==========================================================================================================================
-- Unit_ResourceQuantityRequirements
--==========================================================================================================================
INSERT INTO Unit_ResourceQuantityRequirements	
			(UnitType, 				ResourceType,			Cost)
VALUES		('UNIT_METAL_GEAR',		'RESOURCE_ALUMINUM',	4);

--==========================================================================================================================
-- Unit_YieldFromKills
--==========================================================================================================================
INSERT INTO Unit_YieldFromKills	
			(UnitType, 				YieldType,	Yield)
SELECT		('UNIT_METAL_GEAR'), 	YieldType,	Yield
FROM Unit_YieldFromKills WHERE (UnitType = 'UNIT_MECH');



--Dummy City State Puppeter

INSERT INTO Units 	
			(Type,							Description,							Civilopedia,								Strategy,										Help,										
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,UnitArtInfo,UnitArtInfoCulturalVariation,UnitArtInfoEraVariation,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,UnitFlagIconOffset,PortraitIndex,IconAtlas,UnitFlagAtlas)
SELECT		('UNIT_CITYSTATEPUPPETER_DUMMY'),				Description,							Civilopedia,								Strategy,										Help,	
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,UnitArtInfo,UnitArtInfoCulturalVariation,UnitArtInfoEraVariation,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,UnitFlagIconOffset,PortraitIndex,IconAtlas,UnitFlagAtlas
FROM Units WHERE (Type = 'UNIT_VENETIAN_MERCHANT');

UPDATE Units
SET Class = 'UNITCLASS_CITYSTATEPUPPETER_DUMMY', Cost = -1, Special = null, Capture = null
WHERE Type = 'UNIT_CITYSTATEPUPPETER_DUMMY';
