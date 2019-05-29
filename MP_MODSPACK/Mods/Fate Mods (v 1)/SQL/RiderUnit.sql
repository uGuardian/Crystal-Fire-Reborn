--All SQL Unit inserts were based off of SQL code from JFD's Civilizations.

--Art Define

INSERT INTO ArtDefine_UnitInfos (Type,DamageStates,Formation)
	SELECT	('ART_DEF_UNIT_SOMATOPHYLAX_FSN'), DamageStates, Formation
	FROM ArtDefine_UnitInfos WHERE (Type = 'ART_DEF_UNIT_U_GREEK_HOPLITE');

INSERT INTO ArtDefine_UnitInfoMemberInfos (UnitInfoType,UnitMemberInfoType,NumMembers)
	SELECT	('ART_DEF_UNIT_SOMATOPHYLAX_FSN'), ('ART_DEF_UNIT_MEMBER_SOMATOPHYLAX_FSN'), 1
	FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_U_GREEK_HOPLITE');

INSERT INTO ArtDefine_UnitMemberCombats (UnitMemberType, EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
	SELECT	('ART_DEF_UNIT_MEMBER_SOMATOPHYLAX_FSN'), EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
	FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_U_GREEK_HOPLITE');

INSERT INTO ArtDefine_UnitMemberCombatWeapons (UnitMemberType, "Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
	SELECT ('ART_DEF_UNIT_MEMBER_SOMATOPHYLAX_FSN'), "Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
	FROM ArtDefine_UnitMemberCombatWeapons WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_U_GREEK_HOPLITE');

INSERT INTO ArtDefine_UnitMemberInfos (Type, Scale, ZOffset, Domain, Model, MaterialTypeTag, MaterialTypeSoundOverrideTag)
	SELECT	('ART_DEF_UNIT_MEMBER_SOMATOPHYLAX_FSN'), 0.20, ZOffset, Domain, ('Longswordsman_Greece.fxsxml'), MaterialTypeTag, MaterialTypeSoundOverrideTag
	FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_U_GREEK_HOPLITE');

INSERT INTO ArtDefine_UnitInfos (Type,DamageStates,Formation)
	SELECT	('ART_DEF_UNIT_GORDIUS_WHEEL_FSN'), DamageStates, Formation
	FROM ArtDefine_UnitInfos WHERE (Type = 'ART_DEF_UNIT_U_GREEK_COMPANIONCAVALRY');

INSERT INTO ArtDefine_UnitInfoMemberInfos (UnitInfoType,UnitMemberInfoType,NumMembers)
	SELECT	('ART_DEF_UNIT_GORDIUS_WHEEL_FSN'), ('ART_DEF_UNIT_MEMBER_GORDIUS_WHEEL_FSN'), NumMembers
	FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_U_GREEK_COMPANIONCAVALRY');

INSERT INTO ArtDefine_UnitMemberCombats (UnitMemberType, EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
	SELECT	('ART_DEF_UNIT_MEMBER_GORDIUS_WHEEL_FSN'), EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
	FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_U_GREEK_COMPANIONCAVALRY');

INSERT INTO ArtDefine_UnitMemberCombatWeapons (UnitMemberType, "Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
	SELECT ('ART_DEF_UNIT_MEMBER_GORDIUS_WHEEL_FSN'), "Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
	FROM ArtDefine_UnitMemberCombatWeapons WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_U_GREEK_COMPANIONCAVALRY');

INSERT INTO ArtDefine_UnitMemberInfos (Type, Scale, ZOffset, Domain, Model, MaterialTypeTag, MaterialTypeSoundOverrideTag)
	SELECT	('ART_DEF_UNIT_MEMBER_GORDIUS_WHEEL_FSN'), Scale, ZOffset, Domain, Model, MaterialTypeTag, MaterialTypeSoundOverrideTag
	FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_U_GREEK_COMPANIONCAVALRY');

INSERT INTO ArtDefine_StrategicView
			(StrategicViewType,					TileType,	Asset)
VALUES		('ART_DEF_UNIT_SOMATOPHYLAX_FSN',	'Unit',		'SV_RiderSomatophylax.dds'),
			('ART_DEF_UNIT_GORDIUS_WHEEL_FSN',	'Unit',		'SV_RiderGordius.dds');

--==========================================================================================================================
-- Promotion
--==========================================================================================================================

INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_GORDIUS_WHEEL'),		('TXT_KEY_PROMOTION_GORDIUS_WHEEL'),		('TXT_KEY_PROMOTION_GORDIUS_WHEEL_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_GORDIUS_WHEEL')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_STEAM_POWERED');


INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_SOMATOPHYLAX_BUFF'),		('TXT_KEY_PROMOTION_SOMATOPHYLAX_BUFF'),		('TXT_KEY_PROMOTION_SOMATOPHYLAX_BUFF_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_SOMATOPHYLAX_BUFF')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_STEAM_POWERED');

INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_SOMATOPHYLAX_NOT_GOLDEN_AGE_BONUS'),		('TXT_KEY_PROMOTION_SOMATOPHYLAX_NOT_GOLDEN_AGE_BONUS'),		('TXT_KEY_PROMOTION_SOMATOPHYLAX_NOT_GOLDEN_AGE_BONUS_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_SOMATOPHYLAX_NOT_GOLDEN_AGE_BONUS')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_STEAM_POWERED');

INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_SOMATOPHYLAX_GOLDEN_AGE_BONUS'),		('TXT_KEY_PROMOTION_SOMATOPHYLAX_GOLDEN_AGE_BONUS'),		('TXT_KEY_PROMOTION_SOMATOPHYLAX_GOLDEN_AGE_BONUS_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_SOMATOPHYLAX_GOLDEN_AGE_BONUS')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_STEAM_POWERED');

UPDATE UnitPromotions
SET RangedDefenseMod = 25
WHERE TYPE = 'PROMOTION_GORDIUS_WHEEL';

UPDATE UnitPromotions
SET	GoldenAgeValueFromKills = 25
WHERE Type = 'PROMOTION_SOMATOPHYLAX_NOT_GOLDEN_AGE_BONUS';

UPDATE UnitPromotions
SET	OutsideFriendlyLandsModifier = 20
WHERE Type = 'PROMOTION_SOMATOPHYLAX_GOLDEN_AGE_BONUS';

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
SELECT		('UNIT_GORDIUS_WHEEL_FSN'),				Description,							Civilopedia,								Strategy,										Help,	
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,UnitArtInfo,UnitArtInfoCulturalVariation,UnitArtInfoEraVariation,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,UnitFlagIconOffset,PortraitIndex,IconAtlas,UnitFlagAtlas
FROM Units WHERE (Type = 'UNIT_HORSEMAN');

--Combat Info
UPDATE Units
SET Combat = Combat + 2
WHERE Type = 'UNIT_GORDIUS_WHEEL_FSN';

--Text Info
UPDATE Units
SET Description = 'TXT_KEY_' || Type, Civilopedia = 'TXT_KEY_' || Type || '_TEXT', Help = 'TXT_KEY_' || Type || '_HELP', Strategy = 'TXT_KEY_' || Type || '_STRATEGY'
WHERE Type = 'UNIT_GORDIUS_WHEEL_FSN';

--Art Info
UPDATE Units
SET UnitFlagAtlas = 'CIV_ALPHA_ATLAS_RIDER_FSN', UnitFlagIconOffset = 0, IconAtlas = 'CIV_COLOR_ATLAS_RIDER_FSN', PortraitIndex = 2, UnitArtInfo = 'ART_DEF_UNIT_GORDIUS_WHEEL_FSN', UnitArtInfoCulturalVariation = null, UnitArtInfoEraVariation = null
WHERE Type = 'UNIT_GORDIUS_WHEEL_FSN';



--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 						SelectionSound,			FirstSelectionSound)
SELECT		('UNIT_GORDIUS_WHEEL_FSN'), 	SelectionSound,			FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_HORSEMAN');
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================
INSERT INTO Unit_AITypes 	
			(UnitType, 				UnitAIType)
SELECT		('UNIT_GORDIUS_WHEEL_FSN'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_HORSEMAN');
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================
INSERT INTO Unit_Flavors 	
			(UnitType, 				FlavorType, Flavor)
SELECT		('UNIT_GORDIUS_WHEEL_FSN'), 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_HORSEMAN');
--==========================================================================================================================
-- Unit_Builds
--==========================================================================================================================
INSERT INTO Unit_Builds 	
			(UnitType, 				BuildType)
SELECT		('UNIT_GORDIUS_WHEEL_FSN'), BuildType
FROM Unit_Builds WHERE (UnitType = 'UNIT_HORSEMAN');

--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions 	
			(UnitType, 				PromotionType)
SELECT		('UNIT_GORDIUS_WHEEL_FSN'), PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_HORSEMAN');

INSERT INTO Unit_FreePromotions 	
			(UnitType, 			PromotionType)
VALUES		('UNIT_GORDIUS_WHEEL_FSN', 	'PROMOTION_GORDIUS_WHEEL'),
			('UNIT_GORDIUS_WHEEL_FSN', 	'PROMOTION_ROUGH_TERRAIN_ENDS_TURN');

DELETE FROM Unit_FreePromotions WHERE UnitType = 'UNIT_GORDIUS_WHEEL_FSN' AND PromotionType = 'PROMOTION_CITY_PENALTY';

--==========================================================================================================================
-- Unit_Buildings
--==========================================================================================================================
INSERT INTO Unit_Buildings	
			(UnitType, 				BuildingType)
SELECT		('UNIT_GORDIUS_WHEEL_FSN'), 	BuildingType
FROM Unit_Buildings WHERE (UnitType = 'UNIT_HORSEMAN');

--==========================================================================================================================
-- Unit_BuildingClassRequireds
--==========================================================================================================================
INSERT INTO Unit_BuildingClassRequireds	
			(UnitType, 				BuildingClassType)
SELECT		('UNIT_GORDIUS_WHEEL_FSN'), 	BuildingClassType
FROM Unit_BuildingClassRequireds WHERE (UnitType = 'UNIT_HORSEMAN');

--==========================================================================================================================
-- Unit_ProductionModifierBuildings
--==========================================================================================================================
INSERT INTO Unit_ProductionModifierBuildings	
			(UnitType, 				BuildingType,	ProductionModifier)
SELECT		('UNIT_GORDIUS_WHEEL_FSN'), 	BuildingType,	ProductionModifier
FROM Unit_ProductionModifierBuildings WHERE (UnitType = 'UNIT_HORSEMAN');


--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================
INSERT INTO Unit_ClassUpgrades	
			(UnitType, 				UnitClassType)
SELECT		('UNIT_GORDIUS_WHEEL_FSN'), 	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_HORSEMAN');

--==========================================================================================================================
-- Unit_GreatPersons
--==========================================================================================================================
INSERT INTO Unit_GreatPersons	
			(UnitType, 				GreatPersonType)
SELECT		('UNIT_GORDIUS_WHEEL_FSN'), 	GreatPersonType
FROM Unit_GreatPersons WHERE (UnitType = 'UNIT_HORSEMAN');


--==========================================================================================================================
-- Unit_ResourceQuantityRequirements
--==========================================================================================================================
INSERT INTO Unit_ResourceQuantityRequirements	
			(UnitType, 				ResourceType,	Cost)
SELECT		('UNIT_GORDIUS_WHEEL_FSN'), 	ResourceType,	Cost
FROM Unit_ResourceQuantityRequirements WHERE (UnitType = 'UNIT_HORSEMAN');


--==========================================================================================================================
-- Unit_YieldFromKills
--==========================================================================================================================
INSERT INTO Unit_YieldFromKills	
			(UnitType, 				YieldType,	Yield)
SELECT		('UNIT_GORDIUS_WHEEL_FSN'), 	YieldType,	Yield
FROM Unit_YieldFromKills WHERE (UnitType = 'UNIT_HORSEMAN');




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
SELECT		('UNIT_SOMATOPHYLAX_FSN'),				Description,							Civilopedia,								Strategy,										Help,	
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,UnitArtInfo,UnitArtInfoCulturalVariation,UnitArtInfoEraVariation,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,UnitFlagIconOffset,PortraitIndex,IconAtlas,UnitFlagAtlas
FROM Units WHERE (Type = 'UNIT_GREAT_GENERAL');


--Text Info
UPDATE Units
SET Description = 'TXT_KEY_' || Type, Civilopedia = 'TXT_KEY_' || Type || '_TEXT', Help = 'TXT_KEY_' || Type || '_HELP'
WHERE Type = 'UNIT_SOMATOPHYLAX_FSN';

--Art Info
UPDATE Units
SET UnitFlagAtlas = 'UNIT_ALPHA_ATLAS_SOMATOPHYLAX_FSN', UnitFlagIconOffset = 0, IconAtlas = 'CIV_COLOR_ATLAS_RIDER_FSN', PortraitIndex = 3, UnitArtInfo = 'ART_DEF_UNIT_SOMATOPHYLAX_FSN', UnitArtInfoCulturalVariation = null, UnitArtInfoEraVariation = null
WHERE Type = 'UNIT_SOMATOPHYLAX_FSN';



--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 							SelectionSound,			FirstSelectionSound)
SELECT		('UNIT_SOMATOPHYLAX_FSN'), 	SelectionSound,			FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_GREAT_GENERAL');
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================
INSERT INTO Unit_AITypes 	
			(UnitType, 				UnitAIType)
SELECT		('UNIT_SOMATOPHYLAX_FSN'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_GREAT_GENERAL');
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================
INSERT INTO Unit_Flavors 	
			(UnitType, 				FlavorType, Flavor)
SELECT		('UNIT_SOMATOPHYLAX_FSN'), 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_GREAT_GENERAL');
--==========================================================================================================================
-- Unit_Builds
--==========================================================================================================================
INSERT INTO Unit_Builds 	
			(UnitType, 				BuildType)
SELECT		('UNIT_SOMATOPHYLAX_FSN'), BuildType
FROM Unit_Builds WHERE (UnitType = 'UNIT_GREAT_GENERAL');

--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions 	
			(UnitType, 				PromotionType)
SELECT		('UNIT_SOMATOPHYLAX_FSN'), PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_GREAT_GENERAL');

INSERT INTO Unit_FreePromotions 	
			(UnitType, 					PromotionType)
VALUES		('UNIT_SOMATOPHYLAX_FSN', 	'PROMOTION_SOMATOPHYLAX_BUFF');


--==========================================================================================================================
-- Unit_Buildings
--==========================================================================================================================
INSERT INTO Unit_Buildings	
			(UnitType, 				BuildingType)
SELECT		('UNIT_SOMATOPHYLAX_FSN'), 	BuildingType
FROM Unit_Buildings WHERE (UnitType = 'UNIT_GREAT_GENERAL');

--==========================================================================================================================
-- Unit_BuildingClassRequireds
--==========================================================================================================================
INSERT INTO Unit_BuildingClassRequireds	
			(UnitType, 				BuildingClassType)
SELECT		('UNIT_SOMATOPHYLAX_FSN'), 	BuildingClassType
FROM Unit_BuildingClassRequireds WHERE (UnitType = 'UNIT_GREAT_GENERAL');

--==========================================================================================================================
-- Unit_ProductionModifierBuildings
--==========================================================================================================================
INSERT INTO Unit_ProductionModifierBuildings	
			(UnitType, 				BuildingType,	ProductionModifier)
SELECT		('UNIT_SOMATOPHYLAX_FSN'), 	BuildingType,	ProductionModifier
FROM Unit_ProductionModifierBuildings WHERE (UnitType = 'UNIT_GREAT_GENERAL');


--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================
INSERT INTO Unit_ClassUpgrades	
			(UnitType, 				UnitClassType)
SELECT		('UNIT_SOMATOPHYLAX_FSN'), 	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_GREAT_GENERAL');

--==========================================================================================================================
-- Unit_GreatPersons
--==========================================================================================================================
INSERT INTO Unit_GreatPersons	
			(UnitType, 				GreatPersonType)
SELECT		('UNIT_SOMATOPHYLAX_FSN'), 	GreatPersonType
FROM Unit_GreatPersons WHERE (UnitType = 'UNIT_GREAT_GENERAL');


--==========================================================================================================================
-- Unit_ResourceQuantityRequirements
--==========================================================================================================================
INSERT INTO Unit_ResourceQuantityRequirements	
			(UnitType, 				ResourceType,	Cost)
SELECT		('UNIT_SOMATOPHYLAX_FSN'), 	ResourceType,	Cost
FROM Unit_ResourceQuantityRequirements WHERE (UnitType = 'UNIT_GREAT_GENERAL');


--==========================================================================================================================
-- Unit_YieldFromKills
--==========================================================================================================================
INSERT INTO Unit_YieldFromKills	
			(UnitType, 				YieldType,	Yield)
SELECT		('UNIT_SOMATOPHYLAX_FSN'), 	YieldType,	Yield
FROM Unit_YieldFromKills WHERE (UnitType = 'UNIT_GREAT_GENERAL');


--==========================================================================================================================
-- Unit_UniqueNames
--==========================================================================================================================

INSERT INTO Unit_UniqueNames
			(UnitType,					UniqueName)
SELECT		('UNIT_SOMATOPHYLAX_FSN'),	Tag
FROM Language_en_US WHERE instr(Tag, 'TXT_KEY_GREAT_PERSON_RIDER_SOMATOPHYLAX_') > 0 AND instr(Tag, '_PMMM_FEMALEREPLACE') <= 0;