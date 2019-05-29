INSERT INTO DecisionsAddin_Support		
			(FileName)
VALUES		('GilgameshDecisions.lua');


INSERT INTO IconTextureAtlases 
			(Atlas, 									IconSize, 		Filename, 					IconsPerRow, 	IconsPerColumn)
VALUES		('CIV_COLOR_ATLAS_GILGAMESH_FSN_DECISIONS',	256,		'GilgameshEa256.dds',			1,				1),
			('CIV_COLOR_ATLAS_GILGAMESH_FSN_DECISIONS',	128,		'GilgameshEa128.dds',			1,				1),
			('CIV_COLOR_ATLAS_GILGAMESH_FSN_DECISIONS',	80,			'GilgameshEa80.dds',			1,				1),
			('CIV_COLOR_ATLAS_GILGAMESH_FSN_DECISIONS',	64,			'GilgameshEa64.dds',			1,				1),
			('CIV_COLOR_ATLAS_GILGAMESH_FSN_DECISIONS',	45,			'GilgameshEa45.dds',			1,				1),
			('CIV_COLOR_ATLAS_GILGAMESH_FSN_DECISIONS',	32,			'GilgameshEa32.dds',			1,				1);




INSERT INTO BuildingClasses
			(Type,											DefaultBuilding,								NoLimit)
VALUES		('BUILDINGCLASS_DECISIONS_GILGAMESH_FSN',		'BUILDING_DECISIONS_GILGAMESH_FSN',				0);

INSERT INTO Buildings
			(Type,								BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune)
VALUES		('BUILDING_DECISIONS_GILGAMESH_FSN',		'BUILDINGCLASS_DECISIONS_GILGAMESH_FSN',
			-1,		-1,			-1,				null,		1,				1);

INSERT INTO Building_ResourceYieldChanges
			(BuildingType,							ResourceType,		YieldType,		Yield)
VALUES		('BUILDING_DECISIONS_GILGAMESH_FSN',	'RESOURCE_WINE',	'YIELD_GOLD',	3);

			


INSERT INTO ArtDefine_UnitInfos (Type,DamageStates,Formation)
	SELECT	('ART_DEF_UNIT_GILGAMESH_EA'), DamageStates, Formation
	FROM ArtDefine_UnitInfos WHERE (Type = 'ART_DEF_UNIT_LONGSWORDSMAN');

INSERT INTO ArtDefine_UnitInfoMemberInfos (UnitInfoType,UnitMemberInfoType,NumMembers)
	SELECT	('ART_DEF_UNIT_GILGAMESH_EA'), ('ART_DEF_UNIT_MEMBER_GILGAMESH_EA'), 1
	FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_LONGSWORDSMAN');

INSERT INTO ArtDefine_UnitMemberCombats (UnitMemberType, EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
	SELECT	('ART_DEF_UNIT_MEMBER_GILGAMESH_EA'), EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
	FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_LONGSWORDSMAN');
	
INSERT INTO ArtDefine_UnitMemberCombatWeapons (UnitMemberType, "Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
	SELECT ('ART_DEF_UNIT_MEMBER_GILGAMESH_EA'), "Index", SubIndex, ID, 100.0, 100.0, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, ('ART_DEF_VEFFECT_NUCLEAR_BOMB_01'), 1.0, HitRadius, ProjectileChildEffectScale, 0.5, ContinuousFire, 1, TargetGround, IsDropped, ('EXPLOSIVE'), ('EXPLOSION1TON')
	FROM ArtDefine_UnitMemberCombatWeapons WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_LONGSWORDSMAN');

INSERT INTO ArtDefine_UnitMemberInfos (Type, Scale, ZOffset, Domain, Model, MaterialTypeTag, MaterialTypeSoundOverrideTag)
	SELECT	('ART_DEF_UNIT_MEMBER_GILGAMESH_EA'), 0.21, ZOffset, Domain, Model, MaterialTypeTag, MaterialTypeSoundOverrideTag
	FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_LONGSWORDSMAN');



INSERT INTO Units 	
			(Type,							Description,							Civilopedia,								Strategy,										Help,										
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,UnitArtInfo,UnitArtInfoCulturalVariation,UnitArtInfoEraVariation,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,UnitFlagIconOffset,PortraitIndex,IconAtlas,UnitFlagAtlas)
SELECT		('UNIT_GILGAMESH_DECISION_EA'),				Description,							Civilopedia,								Strategy,										Help,	
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,UnitArtInfo,UnitArtInfoCulturalVariation,UnitArtInfoEraVariation,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,UnitFlagIconOffset,PortraitIndex,IconAtlas,UnitFlagAtlas
FROM Units WHERE (Type = 'UNIT_NUCLEAR_MISSILE');

--Combat Info
UPDATE Units
SET Range = 1, PrereqTech = null
WHERE Type = 'UNIT_GILGAMESH_DECISION_EA';

--Text Info
UPDATE Units
SET Description = 'TXT_KEY_' || Type, Civilopedia = 'TXT_KEY_' || Type || '_TEXT', Help = 'TXT_KEY_' || Type || '_HELP'
WHERE Type = 'UNIT_GILGAMESH_DECISION_EA';

--Art Info
UPDATE Units
SET IconAtlas = 'CIV_COLOR_ATLAS_GILGAMESH_FSN_DECISIONS', PortraitIndex = 0, UnitArtInfo = 'ART_DEF_UNIT_GILGAMESH_EA', UnitArtInfoCulturalVariation = null, UnitArtInfoEraVariation = null
WHERE Type = 'UNIT_GILGAMESH_DECISION_EA';


--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 							SelectionSound,			FirstSelectionSound)
SELECT		('UNIT_GILGAMESH_DECISION_EA'), 	SelectionSound,			FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_NUCLEAR_MISSILE');
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================
INSERT INTO Unit_AITypes 	
			(UnitType, 				UnitAIType)
SELECT		('UNIT_GILGAMESH_DECISION_EA'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_NUCLEAR_MISSILE');
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================
INSERT INTO Unit_Flavors 	
			(UnitType, 				FlavorType, Flavor)
SELECT		('UNIT_GILGAMESH_DECISION_EA'), 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_NUCLEAR_MISSILE');
--==========================================================================================================================
-- Unit_Builds
--==========================================================================================================================
INSERT INTO Unit_Builds 	
			(UnitType, 				BuildType)
SELECT		('UNIT_GILGAMESH_DECISION_EA'), BuildType
FROM Unit_Builds WHERE (UnitType = 'UNIT_NUCLEAR_MISSILE');

--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions 	
			(UnitType, 				PromotionType)
SELECT		('UNIT_GILGAMESH_DECISION_EA'), PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_NUCLEAR_MISSILE');

INSERT INTO Unit_FreePromotions 	
			(UnitType, 			PromotionType)
VALUES		('UNIT_GILGAMESH_DECISION_EA', 	'PROMOTION_EVASION_II');


--==========================================================================================================================
-- Unit_Buildings
--==========================================================================================================================
INSERT INTO Unit_Buildings	
			(UnitType, 				BuildingType)
SELECT		('UNIT_GILGAMESH_DECISION_EA'), 	BuildingType
FROM Unit_Buildings WHERE (UnitType = 'UNIT_NUCLEAR_MISSILE');

--==========================================================================================================================
-- Unit_BuildingClassRequireds
--==========================================================================================================================
INSERT INTO Unit_BuildingClassRequireds	
			(UnitType, 				BuildingClassType)
SELECT		('UNIT_GILGAMESH_DECISION_EA'), 	BuildingClassType
FROM Unit_BuildingClassRequireds WHERE (UnitType = 'UNIT_NUCLEAR_MISSILE');

--==========================================================================================================================
-- Unit_ProductionModifierBuildings
--==========================================================================================================================
INSERT INTO Unit_ProductionModifierBuildings	
			(UnitType, 				BuildingType,	ProductionModifier)
SELECT		('UNIT_GILGAMESH_DECISION_EA'), 	BuildingType,	ProductionModifier
FROM Unit_ProductionModifierBuildings WHERE (UnitType = 'UNIT_NUCLEAR_MISSILE');


--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================
INSERT INTO Unit_ClassUpgrades	
			(UnitType, 				UnitClassType)
SELECT		('UNIT_GILGAMESH_DECISION_EA'), 	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_NUCLEAR_MISSILE');

--==========================================================================================================================
-- Unit_GreatPersons
--==========================================================================================================================
INSERT INTO Unit_GreatPersons	
			(UnitType, 				GreatPersonType)
SELECT		('UNIT_GILGAMESH_DECISION_EA'), 	GreatPersonType
FROM Unit_GreatPersons WHERE (UnitType = 'UNIT_NUCLEAR_MISSILE');


--==========================================================================================================================
-- Unit_ResourceQuantityRequirements
--==========================================================================================================================


--==========================================================================================================================
-- Unit_YieldFromKills
--==========================================================================================================================
INSERT INTO Unit_YieldFromKills	
			(UnitType, 				YieldType,	Yield)
SELECT		('UNIT_GILGAMESH_DECISION_EA'), 	YieldType,	Yield
FROM Unit_YieldFromKills WHERE (UnitType = 'UNIT_NUCLEAR_MISSILE');
