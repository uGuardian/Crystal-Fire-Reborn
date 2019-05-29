INSERT INTO DecisionsAddin_Support
			(FileName)
VALUES		('Planeptunemk2Decisions.lua');

INSERT INTO EventsAddin_Support
			(FileName)
VALUES		('Planeptunemk2Events.lua');

INSERT OR IGNORE INTO EventsAddin_Support
			(FileName)
VALUES		('HDNSharedEvents.lua');



INSERT INTO IconTextureAtlases 
			(Atlas, 								IconSize, 	Filename, 						IconsPerRow, 	IconsPerColumn)
VALUES		('DECISIONS_ATLAS_VV_NEPGEAR', 			256, 		'IFCompaAtlas256.dds',			2, 				1),
			('DECISIONS_ATLAS_VV_NEPGEAR', 			128, 		'IFCompaAtlas128.dds',			2, 				1),
			('DECISIONS_ATLAS_VV_NEPGEAR', 			80, 		'IFCompaAtlas80.dds',			2, 				1),
			('DECISIONS_ATLAS_VV_NEPGEAR',			64, 		'IFCompaAtlas64.dds',			2, 				1),
			('DECISIONS_ATLAS_VV_NEPGEAR', 			45, 		'IFCompaAtlas45.dds',			2, 				1),
			('DECISIONS_ATLAS_VV_NEPGEAR', 			32, 		'IFCompaAtlas32.dds',			2, 				1),
			('UNIT_FLAG_ATLAS_VV_COMPA',			32,			'CompaUnitFlag.dds',			1, 				1),
			('UNIT_FLAG_ATLAS_VV_IF',				32,			'IFUnitFlag.dds',				1, 				1);


INSERT INTO UnitPromotions
			(Type,											Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry,
			AlwaysHeal,		DefenseMod,		EnemyHealChange,	NeutralHealChange,	FriendlyHealChange)
SELECT		('PROMOTION_VV_COMPA'),					('TXT_KEY_UNIT_VV_DECISIONS_COMPA_PROMOTION'),		('TXT_KEY_UNIT_VV_DECISIONS_COMPA_PROMOTION_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_UNIT_VV_DECISIONS_COMPA_PROMOTION'),
			1,				-50,			20,					20,					20
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');


INSERT INTO UnitPromotions
			(Type,											Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_VV_IF'),					('TXT_KEY_UNIT_VV_DECISIONS_IF_PROMOTION'),		('TXT_KEY_UNIT_VV_DECISIONS_IF_PROMOTION_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_UNIT_VV_DECISIONS_IF_PROMOTION')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');


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
SELECT		('UNIT_VV_DECISIONS_COMPA'),	('TXT_KEY_UNIT_VV_DECISIONS_COMPA'),	('TXT_KEY_UNIT_VV_DECISIONS_COMPA_TEXT'),	null,	('TXT_KEY_UNIT_VV_DECISIONS_COMPA_HELP'),
			Requirements, 6, RangedCombat, -1, -1, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange,	Class, ('SPECIALUNIT_PEOPLE'), Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, null, null, null, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,	Unhappiness,('ART_DEF_UNIT_HDN_COMPA'),0,0,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,0,1,('DECISIONS_ATLAS_VV_NEPGEAR'),('UNIT_FLAG_ATLAS_VV_COMPA')
FROM Units WHERE (Type = 'UNIT_PIKEMAN');

--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 					SelectionSound,				FirstSelectionSound)
VALUES		('UNIT_VV_DECISIONS_COMPA',	'AS2D_UNIT_SELECT_VV_COMPA',	'AS2D_UNIT_SELECT_VV_COMPA');
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================
INSERT INTO Unit_AITypes 	
			(UnitType, 					UnitAIType)
SELECT		('UNIT_VV_DECISIONS_COMPA'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_PIKEMAN');
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================
INSERT INTO Unit_Flavors 	
			(UnitType, 					FlavorType, Flavor)
SELECT		('UNIT_VV_DECISIONS_COMPA'), 	FlavorType, Flavor + 5
FROM Unit_Flavors WHERE (UnitType = 'UNIT_PIKEMAN');
--==========================================================================================================================
-- Unit_Builds
--==========================================================================================================================
INSERT INTO Unit_Builds 	
			(UnitType, 				BuildType)
SELECT		('UNIT_VV_DECISIONS_COMPA'), BuildType
FROM Unit_Builds WHERE (UnitType = 'UNIT_PIKEMAN');

--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions 	
			(UnitType, 					PromotionType)
SELECT		('UNIT_VV_DECISIONS_COMPA'), 	PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_PIKEMAN');

INSERT INTO Unit_FreePromotions
			(UnitType,					PromotionType)
VALUES		('UNIT_VV_DECISIONS_COMPA',	'PROMOTION_VV_COMPA');

--==========================================================================================================================
-- Unit_Buildings
--==========================================================================================================================
INSERT INTO Unit_Buildings	
			(UnitType, 					BuildingType)
SELECT		('UNIT_VV_DECISIONS_COMPA'), 	BuildingType
FROM Unit_Buildings WHERE (UnitType = 'UNIT_PIKEMAN');

--==========================================================================================================================
-- Unit_BuildingClassRequireds
--==========================================================================================================================
INSERT INTO Unit_BuildingClassRequireds	
			(UnitType, 					BuildingClassType)
SELECT		('UNIT_VV_DECISIONS_COMPA'), 	BuildingClassType
FROM Unit_BuildingClassRequireds WHERE (UnitType = 'UNIT_PIKEMAN');

--==========================================================================================================================
-- Unit_ProductionModifierBuildings
--==========================================================================================================================
INSERT INTO Unit_ProductionModifierBuildings	
			(UnitType, 					BuildingType,	ProductionModifier)
SELECT		('UNIT_VV_DECISIONS_COMPA'), 	BuildingType,	ProductionModifier
FROM Unit_ProductionModifierBuildings WHERE (UnitType = 'UNIT_PIKEMAN');

--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================


--==========================================================================================================================
-- Unit_GreatPersons
--==========================================================================================================================
INSERT INTO Unit_GreatPersons	
			(UnitType, 					GreatPersonType)
SELECT		('UNIT_VV_DECISIONS_COMPA'), 	GreatPersonType
FROM Unit_GreatPersons WHERE (UnitType = 'UNIT_PIKEMAN');


--==========================================================================================================================
-- Unit_ResourceQuantityRequirements
--==========================================================================================================================

--==========================================================================================================================
-- Unit_YieldFromKills
--==========================================================================================================================
INSERT INTO Unit_YieldFromKills	
			(UnitType, 					YieldType,	Yield)
SELECT		('UNIT_VV_DECISIONS_COMPA'), 	YieldType,	Yield
FROM Unit_YieldFromKills WHERE (UnitType = 'UNIT_PIKEMAN');





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
SELECT		('UNIT_VV_DECISIONS_IF'),	('TXT_KEY_UNIT_VV_DECISIONS_IF'),	('TXT_KEY_UNIT_VV_DECISIONS_IF_TEXT'),	null,	('TXT_KEY_UNIT_VV_DECISIONS_IF_HELP'),
			Requirements, 7, RangedCombat, -1, -1, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves + 2, Immobile, Range, BaseSightRange,	Class, ('SPECIALUNIT_PEOPLE'), Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, null, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,	Unhappiness,('ART_DEF_UNIT_HDN_IF'),0,0,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,0,0,('DECISIONS_ATLAS_VV_NEPGEAR'),('UNIT_FLAG_ATLAS_VV_IF')
FROM Units WHERE (Type = 'UNIT_SCOUT');

--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 					SelectionSound,				FirstSelectionSound)
VALUES		('UNIT_VV_DECISIONS_IF',	'AS2D_UNIT_SELECT_VV_IF',	'AS2D_UNIT_SELECT_VV_IF');
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================
INSERT INTO Unit_AITypes 	
			(UnitType, 					UnitAIType)
SELECT		('UNIT_VV_DECISIONS_IF'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_SCOUT');
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================
INSERT INTO Unit_Flavors 	
			(UnitType, 					FlavorType, Flavor)
SELECT		('UNIT_VV_DECISIONS_IF'), 	FlavorType, Flavor + 5
FROM Unit_Flavors WHERE (UnitType = 'UNIT_SCOUT');
--==========================================================================================================================
-- Unit_Builds
--==========================================================================================================================
INSERT INTO Unit_Builds 	
			(UnitType, 				BuildType)
SELECT		('UNIT_VV_DECISIONS_IF'), BuildType
FROM Unit_Builds WHERE (UnitType = 'UNIT_SCOUT');

--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions 	
			(UnitType, 					PromotionType)
SELECT		('UNIT_VV_DECISIONS_IF'), 	PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_SCOUT');

INSERT INTO Unit_FreePromotions
			(UnitType,					PromotionType)
VALUES		('UNIT_VV_DECISIONS_IF',	'PROMOTION_VV_IF'),
			('UNIT_VV_DECISIONS_IF',	'PROMOTION_RIVAL_TERRITORY');

--==========================================================================================================================
-- Unit_Buildings
--==========================================================================================================================
INSERT INTO Unit_Buildings	
			(UnitType, 					BuildingType)
SELECT		('UNIT_VV_DECISIONS_IF'), 	BuildingType
FROM Unit_Buildings WHERE (UnitType = 'UNIT_SCOUT');

--==========================================================================================================================
-- Unit_BuildingClassRequireds
--==========================================================================================================================
INSERT INTO Unit_BuildingClassRequireds	
			(UnitType, 					BuildingClassType)
SELECT		('UNIT_VV_DECISIONS_IF'), 	BuildingClassType
FROM Unit_BuildingClassRequireds WHERE (UnitType = 'UNIT_SCOUT');

--==========================================================================================================================
-- Unit_ProductionModifierBuildings
--==========================================================================================================================
INSERT INTO Unit_ProductionModifierBuildings	
			(UnitType, 					BuildingType,	ProductionModifier)
SELECT		('UNIT_VV_DECISIONS_IF'), 	BuildingType,	ProductionModifier
FROM Unit_ProductionModifierBuildings WHERE (UnitType = 'UNIT_SCOUT');

--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================


--==========================================================================================================================
-- Unit_GreatPersons
--==========================================================================================================================
INSERT INTO Unit_GreatPersons	
			(UnitType, 					GreatPersonType)
SELECT		('UNIT_VV_DECISIONS_IF'), 	GreatPersonType
FROM Unit_GreatPersons WHERE (UnitType = 'UNIT_SCOUT');


--==========================================================================================================================
-- Unit_ResourceQuantityRequirements
--==========================================================================================================================

--==========================================================================================================================
-- Unit_YieldFromKills
--==========================================================================================================================
INSERT INTO Unit_YieldFromKills	
			(UnitType, 					YieldType,	Yield)
SELECT		('UNIT_VV_DECISIONS_IF'), 	YieldType,	Yield
FROM Unit_YieldFromKills WHERE (UnitType = 'UNIT_SCOUT');







INSERT INTO ArtDefine_UnitInfos (Type,DamageStates,Formation)
	SELECT	('ART_DEF_UNIT_HDN_COMPA'), DamageStates, Formation
	FROM ArtDefine_UnitInfos WHERE (Type = 'ART_DEF_UNIT_SPEARMAN');

INSERT INTO ArtDefine_UnitInfoMemberInfos (UnitInfoType,UnitMemberInfoType,NumMembers)
	VALUES	('ART_DEF_UNIT_HDN_COMPA', 'ART_DEF_UNIT_MEMBER_HDN_COMPA', 1);

INSERT INTO ArtDefine_UnitMemberCombats (UnitMemberType,	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
	SELECT	('ART_DEF_UNIT_MEMBER_HDN_COMPA'),			EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
	FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_SPEARMAN');

INSERT INTO ArtDefine_UnitMemberCombatWeapons (UnitMemberType,	"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
	SELECT ('ART_DEF_UNIT_MEMBER_HDN_COMPA'),				"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
	FROM ArtDefine_UnitMemberCombatWeapons WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_SPEARMAN');

INSERT INTO ArtDefine_UnitMemberInfos (Type,	Scale, ZOffset, Domain, Model,						MaterialTypeTag, MaterialTypeSoundOverrideTag)
	SELECT	('ART_DEF_UNIT_MEMBER_HDN_COMPA'),	0.22, ZOffset, Domain, ('Compa.fxsxml'),	MaterialTypeTag, MaterialTypeSoundOverrideTag
	FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_SPEARMAN');

INSERT INTO ArtDefine_StrategicView
			(StrategicViewType,			TileType,	Asset)
VALUES		('ART_DEF_UNIT_HDN_COMPA',	'Unit',		'SV_VV_Compa.dds');



INSERT INTO ArtDefine_UnitInfos (Type,DamageStates,Formation)
	SELECT	('ART_DEF_UNIT_HDN_IF'), DamageStates, Formation
	FROM ArtDefine_UnitInfos WHERE (Type = 'ART_DEF_UNIT_SPEARMAN');

INSERT INTO ArtDefine_UnitInfoMemberInfos (UnitInfoType,UnitMemberInfoType,NumMembers)
	VALUES	('ART_DEF_UNIT_HDN_IF', 'ART_DEF_UNIT_MEMBER_HDN_IF', 1);

INSERT INTO ArtDefine_UnitMemberCombats (UnitMemberType,	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
	SELECT	('ART_DEF_UNIT_MEMBER_HDN_IF'),			EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
	FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_SPEARMAN');

INSERT INTO ArtDefine_UnitMemberCombatWeapons (UnitMemberType,	"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
	SELECT ('ART_DEF_UNIT_MEMBER_HDN_IF'),				"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
	FROM ArtDefine_UnitMemberCombatWeapons WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_SPEARMAN');

INSERT INTO ArtDefine_UnitMemberInfos (Type,	Scale, ZOffset, Domain, Model,						MaterialTypeTag, MaterialTypeSoundOverrideTag)
	SELECT	('ART_DEF_UNIT_MEMBER_HDN_IF'),	0.22, ZOffset, Domain, ('HDN_IF.fxsxml'),	MaterialTypeTag, MaterialTypeSoundOverrideTag
	FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_SPEARMAN');

INSERT INTO ArtDefine_StrategicView
			(StrategicViewType,		TileType,	Asset)
VALUES		('ART_DEF_UNIT_HDN_IF',	'Unit',		'SV_VV_IF.dds');



INSERT INTO  Audio_Sounds (SoundID,				Filename,			LoadType)
VALUES		('SND_UNIT_DEATH_VOX_VV_COMPA',		'Compa_Death',		'DynamicResident'),
			('SND_UNIT_FORTIFY_VOX_VV_COMPA',	'Compa_Fortify',	'DynamicResident'),
			('SND_UNIT_ATTACK_VOX_VV_COMPA',	'Compa_Attack',		'DynamicResident'),
			('SND_UNIT_VICTORY_VOX_VV_COMPA',	'Compa_Victory',	'DynamicResident'),
			('SND_UNIT_SELECT_VV_COMPA',		'Compa_Select',		'DynamicResident'),
			('SND_UNIT_DEATH_VOX_VV_IF',		'HDN_IF_Death',		'DynamicResident'),
			('SND_UNIT_FORTIFY_VOX_VV_IF',		'HDN_IF_Fortify',	'DynamicResident'),
			('SND_UNIT_ATTACK_VOX_VV_IF',		'HDN_IF_Attack',	'DynamicResident'),
			('SND_UNIT_VICTORY_VOX_VV_IF',		'HDN_IF_Victory',	'DynamicResident'),
			('SND_UNIT_SELECT_VV_IF',			'HDN_IF_Select',	'DynamicResident');



INSERT INTO Audio_3DSounds
			(ScriptID,								SoundID,							SoundType,			MaxVolume,	MinVolume,	PitchChangeDown, PitchChangeUp, DontPlayMoreThan)
VALUES		('AS3D_UNIT_VV_COMPA_FORTIFY_VOX',		'SND_UNIT_FORTIFY_VOX_VV_COMPA',	'GAME_SFX',			80,			50,			-1,				 1,				1),
			('AS3D_UNIT_VV_COMPA_DEATH_VOX',		'SND_UNIT_DEATH_VOX_VV_COMPA',		'GAME_SFX',			80,			50,			-1,				 1,				1),
			('AS3D_UNIT_VV_COMPA_ATTACK_VOX',		'SND_UNIT_ATTACK_VOX_VV_COMPA',		'GAME_SFX',			80,			50,			-1,				 1,				1),
			('AS3D_UNIT_VV_COMPA_VICTORY_VOX',		'SND_UNIT_DEATH_VOX_VV_COMPA',		'GAME_SFX',			80,			50,			-1,				 1,				1),
			('AS3D_UNIT_VV_IF_FORTIFY_VOX',			'SND_UNIT_FORTIFY_VOX_VV_IF',		'GAME_SFX',			80,			50,			-1,				 1,				1),
			('AS3D_UNIT_VV_IF_DEATH_VOX',			'SND_UNIT_DEATH_VOX_VV_IF',			'GAME_SFX',			80,			50,			-1,				 1,				1),
			('AS3D_UNIT_VV_IF_ATTACK_VOX',			'SND_UNIT_ATTACK_VOX_VV_IF',		'GAME_SFX',			80,			50,			-1,				 1,				1),
			('AS3D_UNIT_VV_IF_VICTORY_VOX',			'SND_UNIT_DEATH_VOX_VV_IF',			'GAME_SFX',			80,			50,			-1,				 1,				1);

INSERT INTO Audio_2DSounds
			(ScriptID,									SoundID,
			SoundType,			MaxVolume,	MinVolume,	IsMusic)
VALUES		('AS2D_UNIT_SELECT_VV_COMPA',			'SND_UNIT_SELECT_VV_COMPA',
			'GAME_SFX',			70,			70,			0),
			('AS2D_UNIT_SELECT_VV_IF',				'SND_UNIT_SELECT_VV_IF',
			'GAME_SFX',			70,			70,			0);



--==========================================================================================================================
-- Dummy Buildings
--==========================================================================================================================

INSERT INTO BuildingClasses
			(Type,														DefaultBuilding)
VALUES		('BUILDINGCLASS_DECISIONS_VV_PLANEPTUNE_NG_DUMMY_COMPA',	'BUILDING_DECISIONS_VV_PLANEPTUNE_NG_DUMMY_COMPA'),
			('BUILDINGCLASS_DECISIONS_VV_PLANEPTUNE_NG_DUMMY_IF',		'BUILDING_DECISIONS_VV_PLANEPTUNE_NG_DUMMY_IF'),
			('BUILDINGCLASS_DECISIONS_VV_IF_ESPIONAGE',					'BUILDING_DECISIONS_VV_IF_ESPIONAGE'),
			('BUILDINGCLASS_EVENTS_VV_PLANEPTUNE_NG_GEHABURN_1',		'BUILDING_EVENTS_VV_PLANEPTUNE_NG_GEHABURN_1'),
			('BUILDINGCLASS_EVENTS_VV_PLANEPTUNE_NG_GEHABURN_2',		'BUILDING_EVENTS_VV_PLANEPTUNE_NG_GEHABURN_2'),
			('BUILDINGCLASS_EVENTS_VV_NEPGEAR_CONQUEST_BONUS',			'BUILDING_EVENTS_VV_NEPGEAR_CONQUEST_BONUS');

INSERT INTO Buildings
			(Type,													BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune)
VALUES		('BUILDING_DECISIONS_VV_PLANEPTUNE_NG_DUMMY_COMPA',		'BUILDINGCLASS_DECISIONS_VV_PLANEPTUNE_NG_DUMMY_COMPA',
			-1,		-1,			-1,				null,		1,				1);

INSERT INTO Building_BuildingClassYieldChanges
			(BuildingType,										BuildingClassType,			YieldType,		YieldChange)
VALUES		('BUILDING_DECISIONS_VV_PLANEPTUNE_NG_DUMMY_COMPA',	'BUILDINGCLASS_HOSPITAL',	'YIELD_FOOD',	1),
			('BUILDING_DECISIONS_VV_PLANEPTUNE_NG_DUMMY_COMPA',	'BUILDINGCLASS_HOSPITAL',	'YIELD_SCIENCE',1);


INSERT INTO Buildings
			(Type,													BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune)
VALUES		('BUILDING_DECISIONS_VV_PLANEPTUNE_NG_DUMMY_IF',		'BUILDINGCLASS_DECISIONS_VV_PLANEPTUNE_NG_DUMMY_IF',
			-1,		-1,			-1,				null,		1,				1);

INSERT INTO Building_YieldChanges
			(BuildingType,										YieldType,			Yield)
VALUES		('BUILDING_DECISIONS_VV_PLANEPTUNE_NG_DUMMY_IF',	'YIELD_SCIENCE',	1),
			('BUILDING_DECISIONS_VV_PLANEPTUNE_NG_DUMMY_IF',	'YIELD_PRODUCTION',	1),
			('BUILDING_DECISIONS_VV_PLANEPTUNE_NG_DUMMY_IF',	'YIELD_CULTURE',	1),
			('BUILDING_DECISIONS_VV_PLANEPTUNE_NG_DUMMY_IF',	'YIELD_GOLD',		1);


INSERT INTO Buildings
			(Type,										BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune,
			EspionageModifier)
VALUES		('BUILDING_DECISIONS_VV_IF_ESPIONAGE',		'BUILDINGCLASS_DECISIONS_VV_IF_ESPIONAGE',
			-1,		-1,			-1,				null,		1,				1,
			33);


INSERT INTO Buildings
			(Type,										BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune,
			PolicyCostModifier)
VALUES		('BUILDING_EVENTS_VV_PLANEPTUNE_NG_GEHABURN_1',		'BUILDINGCLASS_EVENTS_VV_PLANEPTUNE_NG_GEHABURN_1',
			-1,		-1,			-1,				null,		1,				1,
			-25);

INSERT INTO Buildings
			(Type,										BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune)
VALUES		('BUILDING_EVENTS_VV_PLANEPTUNE_NG_GEHABURN_2',		'BUILDINGCLASS_EVENTS_VV_PLANEPTUNE_NG_GEHABURN_2',
			-1,		-1,			-1,				null,		1,				1);

INSERT INTO Building_YieldChanges
			(BuildingType,										YieldType,			Yield)
VALUES		('BUILDING_EVENTS_VV_PLANEPTUNE_NG_GEHABURN_2',		'YIELD_SCIENCE',	2);

INSERT INTO Building_YieldModifiers
			(BuildingType,										YieldType,			Yield)
VALUES		('BUILDING_EVENTS_VV_PLANEPTUNE_NG_GEHABURN_2',		'YIELD_SCIENCE',	50);



INSERT INTO Buildings
			(Type,										BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune,
			CultureRateModifier)
VALUES		('BUILDING_EVENTS_VV_NEPGEAR_CONQUEST_BONUS',		'BUILDINGCLASS_EVENTS_VV_NEPGEAR_CONQUEST_BONUS',
			-1,		-1,			-1,				null,		1,				1,
			10);


INSERT INTO Building_YieldModifiers
			(BuildingType,									YieldType,			Yield)
VALUES		('BUILDING_EVENTS_VV_NEPGEAR_CONQUEST_BONUS',	'YIELD_FOOD',		10),
			('BUILDING_EVENTS_VV_NEPGEAR_CONQUEST_BONUS',	'YIELD_SCIENCE',	10),
			('BUILDING_EVENTS_VV_NEPGEAR_CONQUEST_BONUS',	'YIELD_PRODUCTION',	10),
			('BUILDING_EVENTS_VV_NEPGEAR_CONQUEST_BONUS',	'YIELD_GOLD',		10);



INSERT OR IGNORE INTO Language_en_US
					(Tag,								Text)
VALUES				('TXT_KEY_SPECIFIC_DIPLO_STRING_2',	'Bonus/Penalty from Events');