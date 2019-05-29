CREATE TABLE IF NOT EXISTS COMMUNITY(Type, Value);

--==========================================================================================================================
-- UnitClasses
--==========================================================================================================================
INSERT INTO UnitClasses
			(Type,									Description,							DefaultUnit)
VALUES		('UNITCLASS_PMMM_MAGICAL_GIRL',			'TXT_KEY_UNITCLASS_PMMM_MAGICAL_GIRL',	null),
			('UNITCLASS_PMMM_WITCH',				'TXT_KEY_UNITCLASS_PMMM_WITCH',			null),
			('UNITCLASS_PMMM_FAMILIAR',				'TXT_KEY_UNITCLASS_PMMM_FAMILIAR',		null),
			('UNITCLASS_PMMM_INCUBATOR',			'TXT_KEY_UNITCLASS_PMMM_INCUBATOR',		null);

--==========================================================================================================================
-- Units
--==========================================================================================================================
INSERT INTO Units 	
			(Type,							Description,							Civilopedia,								Strategy,										Help,										
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,UnitArtInfo,UnitArtInfoCulturalVariation,UnitArtInfoEraVariation,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,UnitFlagIconOffset,PortraitIndex,IconAtlas,UnitFlagAtlas)
SELECT		('UNIT_PMMM_MAGICAL_GIRL'),	('TXT_KEY_UNIT_PMMM_MAGICAL_GIRL'),	('TXT_KEY_UNIT_PMMM_MAGICAL_GIRL_TEXT'),	('TXT_KEY_UNIT_PMMM_MAGICAL_GIRL_STRATEGY'),	('TXT_KEY_UNIT_PMMM_MAGICAL_GIRL_HELP'),
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,('ART_DEF_UNIT_PMMM_MAGICAL_GIRL'),0,0,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,0,6,('CIV_COLOR_ATLAS_MADOKA'),('PMMM_MAGICAL_GIRL_ALPHA_ATLAS')
FROM Units WHERE (Type = 'UNIT_WARRIOR');

INSERT INTO Units 	
			(Type,							Description,							Civilopedia,								Strategy,										Help,										
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,UnitArtInfo,UnitArtInfoCulturalVariation,UnitArtInfoEraVariation,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,UnitFlagIconOffset,PortraitIndex,IconAtlas,UnitFlagAtlas)
SELECT		('UNIT_PMMM_WITCH'),	('TXT_KEY_UNIT_PMMM_WITCH'),	('TXT_KEY_UNIT_PMMM_WITCH_TEXT'),	('TXT_KEY_UNIT_PMMM_WITCH_STRATEGY'),	('TXT_KEY_UNIT_PMMM_WITCH_HELP'),
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,('ART_DEF_UNIT_PMMM_WITCH'),0,0,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,0,0,('UNIT_COLOR_ATLAS_PMMM_WITCH'),('PMMM_WITCH_ALPHA_ATLAS')
FROM Units WHERE (Type = 'UNIT_WARRIOR');

INSERT INTO Units 	
			(Type,							Description,							Civilopedia,								Strategy,										Help,										
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,UnitArtInfo,UnitArtInfoCulturalVariation,UnitArtInfoEraVariation,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,UnitFlagIconOffset,PortraitIndex,IconAtlas,UnitFlagAtlas)
SELECT		('UNIT_PMMM_FAMILIAR'),	('TXT_KEY_UNIT_PMMM_FAMILIAR'),	('TXT_KEY_UNIT_PMMM_FAMILIAR_TEXT'),	('TXT_KEY_UNIT_PMMM_FAMILIAR_STRATEGY'),	('TXT_KEY_UNIT_PMMM_FAMILIAR_HELP'),
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,('ART_DEF_UNIT_PMMM_FAMILIAR'),0,0,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,0,1,('UNIT_COLOR_ATLAS_PMMM_WITCH'),('PMMM_FAMILIAR_ALPHA_ATLAS')
FROM Units WHERE (Type = 'UNIT_WARRIOR');


INSERT INTO Units 	
			(Type,							Description,							Civilopedia,								Strategy,										Help,										
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,UnitArtInfo,UnitArtInfoCulturalVariation,UnitArtInfoEraVariation,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,UnitFlagIconOffset,PortraitIndex,IconAtlas,UnitFlagAtlas)
SELECT		('UNIT_PMMM_SEA_WITCH'),	('TXT_KEY_UNIT_PMMM_SEA_WITCH'),	('TXT_KEY_UNIT_PMMM_WITCH_TEXT'),	('TXT_KEY_UNIT_PMMM_WITCH_STRATEGY'),	('TXT_KEY_UNIT_PMMM_WITCH_HELP'),
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,('ART_DEF_UNIT_PMMM_SEA_WITCH'),0,0,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,0,2,('UNIT_COLOR_ATLAS_PMMM_WITCH'),('PMMM_WITCH_ALPHA_ATLAS')
FROM Units WHERE (Type = 'UNIT_TRIREME');

INSERT INTO Units 	
			(Type,							Description,							Civilopedia,								Strategy,										Help,										
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,UnitArtInfo,UnitArtInfoCulturalVariation,UnitArtInfoEraVariation,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,UnitFlagIconOffset,PortraitIndex,IconAtlas,UnitFlagAtlas)
SELECT		('UNIT_PMMM_SEA_FAMILIAR'),	('TXT_KEY_UNIT_PMMM_SEA_FAMILIAR'),	('TXT_KEY_UNIT_PMMM_FAMILIAR_TEXT'),	('TXT_KEY_UNIT_PMMM_FAMILIAR_STRATEGY'),	('TXT_KEY_UNIT_PMMM_FAMILIAR_HELP'),
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,('ART_DEF_UNIT_PMMM_SEA_FAMILIAR'),0,0,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,0,3,('UNIT_COLOR_ATLAS_PMMM_WITCH'),('PMMM_FAMILIAR_ALPHA_ATLAS')
FROM Units WHERE (Type = 'UNIT_TRIREME');


INSERT INTO Units 	
			(Type,							Description,							Civilopedia,								Strategy,										Help,										
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,UnitArtInfo,UnitArtInfoCulturalVariation,UnitArtInfoEraVariation,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,UnitFlagIconOffset,PortraitIndex,IconAtlas,UnitFlagAtlas)
SELECT		('UNIT_PMMM_INCUBATOR'),	('TXT_KEY_UNIT_PMMM_INCUBATOR'),	('TXT_KEY_UNIT_PMMM_INCUBATOR_TEXT'),	('TXT_KEY_UNIT_PMMM_INCUBATOR_STRATEGY'),	('TXT_KEY_UNIT_PMMM_INCUBATOR_HELP'),
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,('ART_DEF_UNIT_INCUBATOR'),0,0,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,0,0,('UNIT_COLOR_ATLAS_PMMM_INCUBATOR'),('UNIT_ATLAS_PMMM_INCUBATOR')
FROM Units WHERE (Type = 'UNIT_WARRIOR');


UPDATE Units
SET Cost = -1, FaithCost = -1, Class = 'UNITCLASS_PMMM_MAGICAL_GIRL', NoMaintenance = 1
WHERE Type = 'UNIT_PMMM_MAGICAL_GIRL';

UPDATE Units
SET Cost = -1, FaithCost = -1, Class = 'UNITCLASS_PMMM_WITCH', NoMaintenance = 1
WHERE Type IN ('UNIT_PMMM_WITCH', 'UNIT_PMMM_SEA_WITCH');

UPDATE Units
SET Cost = -1, FaithCost = -1, Class = 'UNITCLASS_PMMM_FAMILIAR', NoMaintenance = 1
WHERE Type IN('UNIT_PMMM_FAMILIAR', 'UNIT_PMMM_SEA_FAMILIAR');

UPDATE Units
SET Cost = -1, FaithCost = -1, Class = 'UNITCLASS_PMMM_INCUBATOR', NoMaintenance = 1
WHERE Type IN('UNIT_PMMM_FAMILIAR', 'UNIT_PMMM_SEA_FAMILIAR');

--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 				SelectionSound, FirstSelectionSound)
SELECT		('UNIT_PMMM_MAGICAL_GIRL'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_WARRIOR');	

INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 				SelectionSound, FirstSelectionSound)
SELECT		('UNIT_PMMM_WITCH'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_WARRIOR');

INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 				SelectionSound, FirstSelectionSound)
SELECT		('UNIT_PMMM_FAMILIAR'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_WARRIOR');

INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 				SelectionSound, FirstSelectionSound)
SELECT		('UNIT_PMMM_SEA_WITCH'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_TRIREME');

INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 				SelectionSound, FirstSelectionSound)
SELECT		('UNIT_PMMM_SEA_FAMILIAR'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_TRIREME');

INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 				SelectionSound, FirstSelectionSound)
SELECT		('UNIT_PMMM_INCUBATOR'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_WARRIOR');		
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================
INSERT INTO Unit_AITypes 	
			(UnitType, 				UnitAIType)
SELECT		('UNIT_PMMM_MAGICAL_GIRL'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_WARRIOR');

INSERT INTO Unit_AITypes 	
			(UnitType, 				UnitAIType)
SELECT		('UNIT_PMMM_WITCH'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_WARRIOR');

INSERT INTO Unit_AITypes 	
			(UnitType, 				UnitAIType)
SELECT		('UNIT_PMMM_FAMILIAR'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_WARRIOR');

INSERT INTO Unit_AITypes 	
			(UnitType, 				UnitAIType)
SELECT		('UNIT_PMMM_SEA_WITCH'), UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_TRIREME');

INSERT INTO Unit_AITypes 	
			(UnitType, 				UnitAIType)
SELECT		('UNIT_PMMM_SEA_FAMILIAR'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_TRIREME');

INSERT INTO Unit_AITypes 	
			(UnitType, 				UnitAIType)
SELECT		('UNIT_PMMM_INCUBATOR'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_WARRIOR');
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================
INSERT INTO Unit_Flavors 	
			(UnitType, 				FlavorType, Flavor)
SELECT		('UNIT_PMMM_MAGICAL_GIRL'), 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_WARRIOR');

INSERT INTO Unit_Flavors 	
			(UnitType, 				FlavorType, Flavor)
SELECT		('UNIT_PMMM_WITCH'), 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_WARRIOR');

INSERT INTO Unit_Flavors 	
			(UnitType, 				FlavorType, Flavor)
SELECT		('UNIT_PMMM_FAMILIAR'), 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_WARRIOR');

INSERT INTO Unit_Flavors 	
			(UnitType, 				FlavorType, Flavor)
SELECT		('UNIT_PMMM_SEA_WITCH'), 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_TRIREME');

INSERT INTO Unit_Flavors 	
			(UnitType, 				FlavorType, Flavor)
SELECT		('UNIT_PMMM_SEA_FAMILIAR'), 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_TRIREME');
--==========================================================================================================================
-- Unit_Builds
--==========================================================================================================================
INSERT INTO Unit_Builds 	
			(UnitType, 				BuildType)
SELECT		('UNIT_PMMM_MAGICAL_GIRL'), BuildType
FROM Unit_Builds WHERE (UnitType = 'UNIT_WARRIOR');

INSERT INTO Unit_Builds 	
			(UnitType, 				BuildType)
SELECT		('UNIT_PMMM_WITCH'), BuildType
FROM Unit_Builds WHERE (UnitType = 'UNIT_WARRIOR');

INSERT INTO Unit_Builds 	
			(UnitType, 				BuildType)
SELECT		('UNIT_PMMM_FAMILIAR'), BuildType
FROM Unit_Builds WHERE (UnitType = 'UNIT_WARRIOR');

INSERT INTO Unit_Builds 	
			(UnitType, 				BuildType)
SELECT		('UNIT_PMMM_SEA_WITCH'), BuildType
FROM Unit_Builds WHERE (UnitType = 'UNIT_TRIREME');

INSERT INTO Unit_Builds 	
			(UnitType, 				BuildType)
SELECT		('UNIT_PMMM_SEA_FAMILIAR'), BuildType
FROM Unit_Builds WHERE (UnitType = 'UNIT_TRIREME');
--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions 	
			(UnitType, 				PromotionType)
SELECT		('UNIT_PMMM_MAGICAL_GIRL'), 	PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_WARRIOR');

INSERT INTO Unit_FreePromotions 	
			(UnitType, 				PromotionType)
SELECT		('UNIT_PMMM_WITCH'), 	PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_WARRIOR');
	

INSERT INTO Unit_FreePromotions 	
			(UnitType, 				PromotionType)
SELECT		('UNIT_PMMM_FAMILIAR'), 	PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_WARRIOR');

INSERT INTO Unit_FreePromotions 	
			(UnitType, 				PromotionType)
SELECT		('UNIT_PMMM_SEA_WITCH'), 	PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_TRIREME');
	

INSERT INTO Unit_FreePromotions 	
			(UnitType, 				PromotionType)
SELECT		('UNIT_PMMM_SEA_FAMILIAR'), 	PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_TRIREME');

INSERT INTO Unit_FreePromotions 	
			(UnitType, 				PromotionType)
SELECT		('UNIT_PMMM_INCUBATOR'), 	PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_WARRIOR');

INSERT INTO Unit_FreePromotions 	
			(UnitType, 				PromotionType)
VALUES		('UNIT_PMMM_INCUBATOR',	'PROMOTION_PMMM_INCUBATOR'),
			('UNIT_PMMM_INCUBATOR',	'PROMOTION_ONLY_DEFENSIVE');

--==========================================================================================================================
-- Unit_Buildings (do not use here)
--==========================================================================================================================

--==========================================================================================================================
-- Unit_BuildingClassRequireds (do not use)
--==========================================================================================================================

--==========================================================================================================================
-- Unit_ProductionModifierBuildings
--==========================================================================================================================
INSERT INTO Unit_ProductionModifierBuildings	
			(UnitType, 				BuildingType,	ProductionModifier)
SELECT		('UNIT_PMMM_MAGICAL_GIRL'), 	BuildingType,	ProductionModifier
FROM Unit_ProductionModifierBuildings WHERE (UnitType = 'UNIT_WARRIOR');

INSERT INTO Unit_ProductionModifierBuildings	
			(UnitType, 				BuildingType,	ProductionModifier)
SELECT		('UNIT_PMMM_WITCH'), 	BuildingType,	ProductionModifier
FROM Unit_ProductionModifierBuildings WHERE (UnitType = 'UNIT_WARRIOR');

INSERT INTO Unit_ProductionModifierBuildings	
			(UnitType, 				BuildingType,	ProductionModifier)
SELECT		('UNIT_PMMM_FAMILIAR'), 	BuildingType,	ProductionModifier
FROM Unit_ProductionModifierBuildings WHERE (UnitType = 'UNIT_WARRIOR');

INSERT INTO Unit_ProductionModifierBuildings	
			(UnitType, 				BuildingType,	ProductionModifier)
SELECT		('UNIT_PMMM_SEA_WITCH'), 	BuildingType,	ProductionModifier
FROM Unit_ProductionModifierBuildings WHERE (UnitType = 'UNIT_TRIREME');

INSERT INTO Unit_ProductionModifierBuildings	
			(UnitType, 				BuildingType,	ProductionModifier)
SELECT		('UNIT_PMMM_SEA_FAMILIAR'), 	BuildingType,	ProductionModifier
FROM Unit_ProductionModifierBuildings WHERE (UnitType = 'UNIT_TRIREME');


--==========================================================================================================================
-- Unit_ClassUpgrades (do not use here!)
--==========================================================================================================================


--==========================================================================================================================
-- Unit_GreatPersons
--==========================================================================================================================
INSERT INTO Unit_GreatPersons	
			(UnitType, 				GreatPersonType)
SELECT		('UNIT_PMMM_MAGICAL_GIRL'), 	GreatPersonType
FROM Unit_GreatPersons WHERE (UnitType = 'UNIT_WARRIOR');

INSERT INTO Unit_GreatPersons	
			(UnitType, 				GreatPersonType)
SELECT		('UNIT_PMMM_WITCH'), 	GreatPersonType
FROM Unit_GreatPersons WHERE (UnitType = 'UNIT_WARRIOR');

INSERT INTO Unit_GreatPersons	
			(UnitType, 				GreatPersonType)
SELECT		('UNIT_PMMM_FAMILIAR'), 	GreatPersonType
FROM Unit_GreatPersons WHERE (UnitType = 'UNIT_WARRIOR');

INSERT INTO Unit_GreatPersons	
			(UnitType, 				GreatPersonType)
SELECT		('UNIT_PMMM_SEA_WITCH'), 	GreatPersonType
FROM Unit_GreatPersons WHERE (UnitType = 'UNIT_TRIREME');

INSERT INTO Unit_GreatPersons	
			(UnitType, 				GreatPersonType)
SELECT		('UNIT_PMMM_SEA_FAMILIAR'), 	GreatPersonType
FROM Unit_GreatPersons WHERE (UnitType = 'UNIT_TRIREME');
--==========================================================================================================================
-- Unit_ResourceQuantityRequirements (do not use)
--==========================================================================================================================


--==========================================================================================================================
-- Unit_YieldFromKills
--==========================================================================================================================
INSERT INTO Unit_YieldFromKills	
			(UnitType, 				YieldType,	Yield)
SELECT		('UNIT_PMMM_MAGICAL_GIRL'), 	YieldType,	Yield
FROM Unit_YieldFromKills WHERE (UnitType = 'UNIT_WARRIOR');

INSERT INTO Unit_YieldFromKills	
			(UnitType, 				YieldType,	Yield)
SELECT		('UNIT_PMMM_WITCH'), 	YieldType,	Yield
FROM Unit_YieldFromKills WHERE (UnitType = 'UNIT_WARRIOR');

INSERT INTO Unit_YieldFromKills	
			(UnitType, 				YieldType,	Yield)
SELECT		('UNIT_PMMM_FAMILIAR'), 	YieldType,	Yield
FROM Unit_YieldFromKills WHERE (UnitType = 'UNIT_WARRIOR');

INSERT INTO Unit_YieldFromKills	
			(UnitType, 				YieldType,	Yield)
SELECT		('UNIT_PMMM_SEA_WITCH'), 	YieldType,	Yield
FROM Unit_YieldFromKills WHERE (UnitType = 'UNIT_TRIREME');

INSERT INTO Unit_YieldFromKills	
			(UnitType, 				YieldType,	Yield)
SELECT		('UNIT_PMMM_SEA_FAMILIAR'), 	YieldType,	Yield
FROM Unit_YieldFromKills WHERE (UnitType = 'UNIT_TRIREME');


--==========================================================================================================================
--==========================================================================================================================
--Promotions
--==========================================================================================================================
--==========================================================================================================================

INSERT INTO UnitPromotions
			(Type,											Description,									Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_PMMM_MAGICAL_GIRL_LEADER'),		('TXT_KEY_PROMOTION_PMMM_MAGICAL_GIRL_LEADER'),('TXT_KEY_PROMOTION_PMMM_MAGICAL_GIRL_LEADER_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_PMMM_MAGICAL_GIRL_LEADER')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');



UPDATE UnitPromotions
SET ExperiencePercent = 50, AlwaysHeal = 1, CombatPercent = 20, MGLikeDislikeSpreadBonus = 3, MGSocializeBonus = 1
WHERE Type = 'PROMOTION_PMMM_MAGICAL_GIRL_LEADER';


INSERT INTO UnitPromotions
			(Type,											Description,									Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_PMMM_INCUBATOR'),		('TXT_KEY_PROMOTION_PMMM_INCUBATOR'),('TXT_KEY_PROMOTION_PMMM_INCUBATOR_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_PMMM_INCUBATOR')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');



UPDATE UnitPromotions
SET RangedDefenseMod = 75, ExtraWithdrawal = 70, MovesChange = 1
WHERE Type = 'PROMOTION_PMMM_INCUBATOR';



-------NEW V25 PROMOTIONS-------------
INSERT INTO UnitPromotions
			(Type,								Description,							Help,
			Sound,	PortraitIndex,	IconAtlas,									PediaType,				PediaEntry,
			MGLikeDislikeSpreadBonus,	MGSocializeBonus)
SELECT		('PROMOTION_PMMM_CHARISMA_I'),		('TXT_KEY_PROMOTION_PMMM_CHARISMA_I'),	('TXT_KEY_PROMOTION_PMMM_CHARISMA_I_HELP'),
			Sound,	2,				('PROMOTION_ATLAS_PMMM_V25_PROMOTIONS'),	('PEDIA_MAGICALGIRL'),	('TXT_KEY_PROMOTION_PMMM_CHARISMA_I'),
			3,							1
FROM UnitPromotions	WHERE (Type = 'PROMOTION_DRILL_1');

INSERT INTO UnitPromotions
			(Type,								Description,							Help,
			Sound,	PortraitIndex,	IconAtlas,									PediaType,				PediaEntry,
			MGLikeDislikeSpreadBonus,	MGSocializeBonus,	PromotionPrereqOr1)
SELECT		('PROMOTION_PMMM_CHARISMA_II'),		('TXT_KEY_PROMOTION_PMMM_CHARISMA_II'),	('TXT_KEY_PROMOTION_PMMM_CHARISMA_II_HELP'),
			Sound,	2,				('PROMOTION_ATLAS_PMMM_V25_PROMOTIONS'),	('PEDIA_MAGICALGIRL'),	('TXT_KEY_PROMOTION_PMMM_CHARISMA_II'),
			3,							1,					('PROMOTION_PMMM_CHARISMA_I')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_DRILL_1');

INSERT INTO UnitPromotions
			(Type,								Description,							Help,
			Sound,	PortraitIndex,	IconAtlas,									PediaType,				PediaEntry,
			MGSocializingLoyaltyGrantedToPartner,	PromotionPrereqOr1)
SELECT		('PROMOTION_PMMM_PATRIOTISM'),		('TXT_KEY_PROMOTION_PMMM_PATRIOTISM'),	('TXT_KEY_PROMOTION_PMMM_PATRIOTISM_HELP'),
			Sound,	5,				('PROMOTION_ATLAS_PMMM_V25_PROMOTIONS'),	('PEDIA_MAGICALGIRL'),	('TXT_KEY_PROMOTION_PMMM_PATRIOTISM'),
			10,										('PROMOTION_PMMM_CHARISMA_II')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_DRILL_1');


INSERT INTO UnitPromotions
			(Type,								Description,							Help,
			Sound,	PortraitIndex,	IconAtlas,									PediaType,				PediaEntry,
			MGSparringPartnerBonus,	MGSparringCooldownReduction)
SELECT		('PROMOTION_PMMM_TRAINER_I'),		('TXT_KEY_PROMOTION_PMMM_TRAINER_I'),	('TXT_KEY_PROMOTION_PMMM_TRAINER_I_HELP'),
			Sound,	1,				('PROMOTION_ATLAS_PMMM_V25_PROMOTIONS'),	('PEDIA_MAGICALGIRL'),	('TXT_KEY_PROMOTION_PMMM_TRAINER_I'),
			5,						2
FROM UnitPromotions	WHERE (Type = 'PROMOTION_DRILL_1');

INSERT INTO UnitPromotions
			(Type,								Description,							Help,
			Sound,	PortraitIndex,	IconAtlas,									PediaType,				PediaEntry,
			MGSparringPartnerBonus,	MGSparringCooldownReduction,	PromotionPrereqOr1)
SELECT		('PROMOTION_PMMM_TRAINER_II'),		('TXT_KEY_PROMOTION_PMMM_TRAINER_II'),	('TXT_KEY_PROMOTION_PMMM_TRAINER_II_HELP'),
			Sound,	1,				('PROMOTION_ATLAS_PMMM_V25_PROMOTIONS'),	('PEDIA_MAGICALGIRL'),	('TXT_KEY_PROMOTION_PMMM_TRAINER_II'),
			5,						2,					('PROMOTION_PMMM_TRAINER_I')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_DRILL_1');

INSERT INTO UnitPromotions
			(Type,								Description,							Help,
			Sound,	PortraitIndex,	IconAtlas,									PediaType,				PediaEntry,
			MGSocializingXPGrantedToPartner,	PromotionPrereqOr1)
SELECT		('PROMOTION_PMMM_TEACHER'),		('TXT_KEY_PROMOTION_PMMM_TEACHER'),	('TXT_KEY_PROMOTION_PMMM_TEACHER_HELP'),
			Sound,	3,				('PROMOTION_ATLAS_PMMM_V25_PROMOTIONS'),	('PEDIA_MAGICALGIRL'),	('TXT_KEY_PROMOTION_PMMM_TEACHER'),
			1,								('PROMOTION_PMMM_TRAINER_II')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_DRILL_1');


INSERT INTO UnitPromotions_UnitCombats
			(PromotionType,					UnitCombatType)
VALUES		('PROMOTION_PMMM_CHARISMA_I',	'UNITCOMBAT_MAGICALGIRL'),
			('PROMOTION_PMMM_CHARISMA_II',	'UNITCOMBAT_MAGICALGIRL'),
			('PROMOTION_PMMM_PATRIOTISM',	'UNITCOMBAT_MAGICALGIRL'),
			('PROMOTION_PMMM_TRAINER_I',	'UNITCOMBAT_MAGICALGIRL'),
			('PROMOTION_PMMM_TRAINER_II',	'UNITCOMBAT_MAGICALGIRL'),
			('PROMOTION_PMMM_TEACHER',		'UNITCOMBAT_MAGICALGIRL');


--==========================================================================================================================
--==========================================================================================================================
--Immune to Truth
--==========================================================================================================================
--==========================================================================================================================

INSERT INTO UnitPromotions
			(Type,											Description,									Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_PMMM_IMMUNE_TO_TRUTH'),		('TXT_KEY_PROMOTION_PMMM_IMMUNE_TO_TRUTH'),('TXT_KEY_PROMOTION_PMMM_IMMUNE_TO_TRUTH_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_PMMM_IMMUNE_TO_TRUTH')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');


--==========================================================================================================================
--==========================================================================================================================
--Attempt to replace any reference to Barbarians with Witches/Hostile
--==========================================================================================================================
--==========================================================================================================================


UPDATE Language_en_US
SET Text = replace(Text, 'Barbarian Encampments', "Witch Labyrinths")
WHERE Text LIKE ('%Barbarian Encampments%');

UPDATE Language_en_US
SET Text = replace(Text, 'Barbarian Encampment', "Witch's Labyrinth")
WHERE Text LIKE ('%Barbarian Encampment%');

UPDATE Language_en_US
SET Text = replace(Text, 'Barbarian encampments', "Witch Labyrinths")
WHERE Text LIKE ('%Barbarian encampments%');

UPDATE Language_en_US
SET Text = replace(Text, 'Barbarian Encampment', "Witch's Labyrinth")
WHERE Text LIKE ('%Barbarian Encampment%');

UPDATE Language_en_US
SET Text = replace(Text, 'Encampment', "Labyrinth")
WHERE Text LIKE ('%Encampment%');

UPDATE Language_en_US
SET Text = replace(Text, 'encampment', "Labyrinth")
WHERE Text LIKE ('%encampment%');

UPDATE Language_en_US
SET Text = replace(Text, 'Barbarians', 'Hostile Units')
WHERE Text LIKE ('%Barbarians%');

UPDATE Language_en_US
SET Text = replace(Text, 'Barbarian', 'Hostile')
WHERE Text LIKE ('%Barbarian%');



UPDATE Language_en_US
SET Text = 'The rate at which Witches, Familiars, and Incubators spawn is greatly increased.'
WHERE Tag='TXT_KEY_GAME_OPTION_RAGING_BARBARIANS_HELP';

UPDATE Language_en_US
SET Text = 'Raging Witches'
WHERE Tag='TXT_KEY_GAME_OPTION_RAGING_BARBARIANS';

UPDATE Language_en_US
SET Text = 'Witches and Familiars do not appear on the map automatically (though Incubators will). Hidden Witch Labyrinths may be uncovered from the beginning of the game, and are the only way Witches can be spawned (aside from Magical Girls turning into them, of course).' 
WHERE Tag='TXT_KEY_GAME_OPTION_NO_BARBARIANS_HELP';

UPDATE Language_en_US
SET Text = 'Always Hidden Witches'
WHERE Tag='TXT_KEY_GAME_OPTION_NO_BARBARIANS';


--==========================================================================================================================
--==========================================================================================================================
--Attempt to replace any reference to Great People with Prodigies
--==========================================================================================================================
--==========================================================================================================================

UPDATE Language_en_US
SET Text = replace(Text, 'Great Scientists', 'Scientist Prodigies')
WHERE Text LIKE ('%Great Scientists%');

UPDATE Language_en_US
SET Text = replace(Text, 'Great Scientist', 'Scientist Prodigy')
WHERE Text LIKE ('%Great Scientist%');

UPDATE Language_en_US
SET Text = replace(Text, 'Great Merchants', 'Merchant Prodigies')
WHERE Text LIKE ('%Great Merchants%');

UPDATE Language_en_US
SET Text = replace(Text, 'Great Merchant', 'Merchant Prodigy')
WHERE Text LIKE ('%Great Merchant%');

UPDATE Language_en_US
SET Text = replace(Text, 'Great Engineers', 'Engineer Prodigies')
WHERE Text LIKE ('%Great Engineers%');

UPDATE Language_en_US
SET Text = replace(Text, 'Great Engineer', 'Engineer Prodigy')
WHERE Text LIKE ('%Great Engineer%');

UPDATE Language_en_US
SET Text = replace(Text, 'Great Prophets', 'Prophet Prodigies')
WHERE Text LIKE ('%Great Prophets%');

UPDATE Language_en_US
SET Text = replace(Text, 'Great Prophet', 'Prophet Prodigy')
WHERE Text LIKE ('%Great Prophet%');

UPDATE Language_en_US
SET Text = replace(Text, 'Great Generals', 'Commander Prodigies')
WHERE Text LIKE ('%Great Generals%');

UPDATE Language_en_US
SET Text = replace(Text, 'Great General', 'Commander Prodigy')
WHERE Text LIKE ('%Great General%');

UPDATE Language_en_US
SET Text = replace(Text, 'Great Admirals', 'Navigator Prodigies')
WHERE Text LIKE ('%Great Admirals%');

UPDATE Language_en_US
SET Text = replace(Text, 'Great Admiral', 'Navigator Prodigy')
WHERE Text LIKE ('%Great Admiral%');

UPDATE Language_en_US
SET Text = replace(Text, 'Great Writers', 'Writer Prodigies')
WHERE Text LIKE ('%Great Writers%');

UPDATE Language_en_US
SET Text = replace(Text, 'Great Writer', 'Writer Prodigy')
WHERE Text LIKE ('%Great Writer%');

UPDATE Language_en_US
SET Text = replace(Text, 'Great Artists', 'Artist Prodigies')
WHERE Text LIKE ('%Great Artists%');

UPDATE Language_en_US
SET Text = replace(Text, 'Great Artist', 'Artist Prodigy')
WHERE Text LIKE ('%Great Artist%');

UPDATE Language_en_US
SET Text = replace(Text, 'Great Musicians', 'Musician Prodigies')
WHERE Text LIKE ('%Great Musicians%');

UPDATE Language_en_US
SET Text = replace(Text, 'Great Musician', 'Musician Prodigy')
WHERE Text LIKE ('%Great Musician%');

--CSD
UPDATE Language_en_US
SET Text = replace(Text, 'Great Diplomats', 'Diplomat Prodigies')
WHERE Text LIKE ('%Great Diplomats%');

UPDATE Language_en_US
SET Text = replace(Text, 'Great Diplomat', 'Diplomat Prodigy')
WHERE Text LIKE ('%Great Diplomat%');
--End CSD

UPDATE Language_en_US
SET Text = replace(Text, 'Great People', 'Prodigies')
WHERE Text LIKE ('%Great People%');

UPDATE Language_en_US
SET Text = replace(Text, 'Great Person', 'Prodigy')
WHERE Text LIKE ('%Great Person%');



--==========================================================================================================================
--==========================================================================================================================
--Set gold for Barb Camps to 1 for all difficulties
--Firaxis tries to divide by this number when discovering Natural Wonders (*really?*), so we just now set it to 1
-- and then remove 1 gold in Lua
--==========================================================================================================================
--==========================================================================================================================


UPDATE HandicapInfos
SET BarbCampGold = 1;

CREATE TRIGGER SetBarbCampGold0
AFTER INSERT ON HandicapInfos
BEGIN
	UPDATE		HandicapInfos
	SET BarbCampGold = 1
	WHERE Type = NEW.Type;
END;


--==========================================================================================================================
--==========================================================================================================================
--Update Witch's Labyrinth Graphics
--==========================================================================================================================
--==========================================================================================================================
INSERT INTO ArtDefine_Landmarks(Era, State, Scale, ImprovementType, LayoutHandler, ResourceType, Model, TerrainContour)
SELECT 'Any', 'UnderConstruction', 2.0,  'ART_DEF_IMPROVEMENT_PMMM_WITCH_BARRIER', 'SNAPSHOT', 'ART_DEF_RESOURCE_NONE', 'BloodfireVents_PL.fxsxml', 1 UNION ALL
SELECT 'Any', 'Constructed', 2.0,  'ART_DEF_IMPROVEMENT_PMMM_WITCH_BARRIER', 'SNAPSHOT', 'ART_DEF_RESOURCE_NONE', 'BloodfireVents.fxsxml', 1 UNION ALL
SELECT 'Any', 'Pillaged', 2.0,  'ART_DEF_IMPROVEMENT_PMMM_WITCH_BARRIER', 'SNAPSHOT', 'ART_DEF_RESOURCE_NONE', 'BloodfireVents_PL.fxsxml', 1;


UPDATE Improvements
SET ArtDefineTag = 'ART_DEF_IMPROVEMENT_PMMM_WITCH_BARRIER'
WHERE Type = 'IMPROVEMENT_BARBARIAN_CAMP';


--==========================================================================================================================
--==========================================================================================================================
--Change the Heathen Conversion belief and change name of Reliquary
--==========================================================================================================================
--==========================================================================================================================

UPDATE Beliefs
SET ConvertsBarbarians = 0, AllowMissionarySGPurification = 1
WHERE Type = 'BELIEF_HEATHEN_CONVERSION';











--==========================================================================================================================
--==========================================================================================================================
--Add effects of Lightning Warfare and Navigation School to the text of the Policies, and add the Promotions
--==========================================================================================================================
--==========================================================================================================================

UPDATE Language_en_US
SET Text = Text || ' +1 [ICON_MOVES] Movement for Magical Girls born from Commander Prodigies.'
WHERE Tag IN ('TXT_KEY_POLICY_LIGHTNING_WARFARE_HELP');

UPDATE Language_en_US
SET Text = Text || ' +1 [ICON_MOVES] Movement for Magical Girls born from Navigator Prodigies.'
WHERE Tag IN ('TXT_KEY_POLICY_NAVIGATION_SCHOOL_HELP');

INSERT INTO UnitPromotions
			(Type,											Description,									Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry,
			MovesChange)
SELECT		('PROMOTION_MG_MOVE_BONUS_FROM_POLICY'),		('TXT_KEY_PROMOTION_MG_MOVE_BONUS_FROM_POLICY'),('TXT_KEY_PROMOTION_MG_MOVE_BONUS_FROM_POLICY_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_MG_MOVE_BONUS_FROM_POLICY'),
			1
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');




--==========================================================================================================================
--==========================================================================================================================
--Add in Generic MG Names
--==========================================================================================================================
--==========================================================================================================================


INSERT INTO MG_GenericNames
			(Type,																						TextKey)
SELECT		Replace(Tag, 'TXT_KEY_PMMM_GENERIC_MAGICAL_GIRL_NAME', 'PMMM_GENERIC_MAGICAL_GIRL_NAME'),	Tag
FROM Language_en_US WHERE Tag LIKE ('TXT_KEY_PMMM_GENERIC_MAGICAL_GIRL_NAME%');



--==========================================================================================================================
--==========================================================================================================================
--Add in Witch Names
--==========================================================================================================================
--==========================================================================================================================


INSERT INTO Witch_GenericNames
			(Type,																		TextKey)
SELECT		Replace(Tag, 'TXT_KEY_PMMM_GENERIC_WITCH_NAME', 'PMMM_GENERIC_WITCH_NAME'),	Tag
FROM Language_en_US WHERE Tag LIKE ('TXT_KEY_PMMM_GENERIC_WITCH_NAME%');


--==========================================================================================================================
--==========================================================================================================================
--Rune Icons
--==========================================================================================================================
--==========================================================================================================================


INSERT INTO IconFontMapping 
			(IconName, 				IconFontTexture,						   IconMapping)
VALUES		('ICON_MR_A',			'ICON_FONT_TEXTURE_PMMM_RUNES',			   1),
			('ICON_MR_B',			'ICON_FONT_TEXTURE_PMMM_RUNES',			   2),
			('ICON_MR_C',			'ICON_FONT_TEXTURE_PMMM_RUNES',			   3),
			('ICON_MR_D',			'ICON_FONT_TEXTURE_PMMM_RUNES',			   4),
			('ICON_MR_E',			'ICON_FONT_TEXTURE_PMMM_RUNES',			   5),
			('ICON_MR_F',			'ICON_FONT_TEXTURE_PMMM_RUNES',			   6),
			('ICON_MR_G',			'ICON_FONT_TEXTURE_PMMM_RUNES',			   7),
			('ICON_MR_H',			'ICON_FONT_TEXTURE_PMMM_RUNES',			   8),
			('ICON_MR_I',			'ICON_FONT_TEXTURE_PMMM_RUNES',			   9),
			('ICON_MR_J',			'ICON_FONT_TEXTURE_PMMM_RUNES',			  10),
			('ICON_MR_K',			'ICON_FONT_TEXTURE_PMMM_RUNES',			  11),
			('ICON_MR_L',			'ICON_FONT_TEXTURE_PMMM_RUNES',			  12),
			('ICON_MR_M',			'ICON_FONT_TEXTURE_PMMM_RUNES',			  13),
			('ICON_MR_N',			'ICON_FONT_TEXTURE_PMMM_RUNES',			  14),
			('ICON_MR_O',			'ICON_FONT_TEXTURE_PMMM_RUNES',			  15),
			('ICON_MR_P',			'ICON_FONT_TEXTURE_PMMM_RUNES',			  16),
			('ICON_MR_Q',			'ICON_FONT_TEXTURE_PMMM_RUNES',			  17),
			('ICON_MR_R',			'ICON_FONT_TEXTURE_PMMM_RUNES',			  18),
			('ICON_MR_S',			'ICON_FONT_TEXTURE_PMMM_RUNES',			  19),
			('ICON_MR_T',			'ICON_FONT_TEXTURE_PMMM_RUNES',			  20),
			('ICON_MR_U',			'ICON_FONT_TEXTURE_PMMM_RUNES',			  21),
			('ICON_MR_V',			'ICON_FONT_TEXTURE_PMMM_RUNES',			  22),
			('ICON_MR_W',			'ICON_FONT_TEXTURE_PMMM_RUNES',			  23),
			('ICON_MR_X',			'ICON_FONT_TEXTURE_PMMM_RUNES',			  24),
			('ICON_MR_Y',			'ICON_FONT_TEXTURE_PMMM_RUNES',			  25),
			('ICON_MR_Z',			'ICON_FONT_TEXTURE_PMMM_RUNES',			  26),
			('ICON_MR_QUESTION',	'ICON_FONT_TEXTURE_PMMM_RUNES',			  27);




--CannotBeCaptured  (REQUIRES COMMUNITY PATCH)

INSERT INTO UnitPromotions
			(Type,											Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry,
			CannotBeCaptured)
SELECT		('PROMOTION_PMMM_NOCAPTURE'),					('TXT_KEY_PROMOTION_PMMM_NOCAPTURE'),		('TXT_KEY_PROMOTION_PMMM_NOCAPTURE_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_PMMM_NOCAPTURE'),
			1
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');


INSERT INTO Unit_FreePromotions
			(UnitType,					PromotionType)
VALUES		('UNIT_PMMM_MAGICAL_GIRL',	'PROMOTION_PMMM_NOCAPTURE'),
			('UNIT_PMMM_WITCH',			'PROMOTION_PMMM_NOCAPTURE'),
			('UNIT_PMMM_FAMILIAR',		'PROMOTION_PMMM_NOCAPTURE'),
			('UNIT_PMMM_SEA_WITCH',		'PROMOTION_PMMM_NOCAPTURE'),
			('UNIT_PMMM_SEA_FAMILIAR',	'PROMOTION_PMMM_NOCAPTURE'),
			('UNIT_PMMM_INCUBATOR',		'PROMOTION_PMMM_NOCAPTURE');

