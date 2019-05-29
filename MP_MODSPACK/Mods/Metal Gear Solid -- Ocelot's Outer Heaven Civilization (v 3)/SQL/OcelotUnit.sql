--All SQL Unit inserts were based off of SQL code from JFD's Civilizations.

--==========================================================================================================================
-- Promotion
--==========================================================================================================================

-----------Boss Promotions--------------------------------------------------------------------------------------------------
INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_HAVEN_TROOPER'),		('TXT_KEY_PROMOTION_HAVEN_TROOPER'),		('TXT_KEY_PROMOTION_HAVEN_TROOPER_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_HAVEN_TROOPER')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_STEAM_POWERED');

INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_SCREAMING_AMMO'),		('TXT_KEY_PROMOTION_SCREAMING_AMMO'),		('TXT_KEY_PROMOTION_SCREAMING_AMMO_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_SCREAMING_AMMO')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_STEAM_POWERED');

INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_LAUGHING_AMMO'),		('TXT_KEY_PROMOTION_LAUGHING_AMMO'),		('TXT_KEY_PROMOTION_LAUGHING_AMMO_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_LAUGHING_AMMO')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_STEAM_POWERED');

INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_LAUGHING_AMMO_DEBUFF'),		('TXT_KEY_PROMOTION_LAUGHING_AMMO_DEBUFF'),		('TXT_KEY_PROMOTION_LAUGHING_AMMO_DEBUFF_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_LAUGHING_AMMO_DEBUFF')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_UNWELCOME_EVANGELIST');

INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_RAGING_AMMO'),		('TXT_KEY_PROMOTION_RAGING_AMMO'),		('TXT_KEY_PROMOTION_RAGING_AMMO_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_RAGING_AMMO')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_STEAM_POWERED');

INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_CRYING_AMMO'),		('TXT_KEY_PROMOTION_CRYING_AMMO'),		('TXT_KEY_PROMOTION_CRYING_AMMO_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_CRYING_AMMO')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_STEAM_POWERED');

INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_CRYING_AMMO_DEBUFF'),		('TXT_KEY_PROMOTION_CRYING_AMMO_DEBUFF'),		('TXT_KEY_PROMOTION_CRYING_AMMO_DEBUFF_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_CRYING_AMMO_DEBUFF')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_UNWELCOME_EVANGELIST');

INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_RAGING_AMMO_DEBUFF'),		('TXT_KEY_PROMOTION_RAGING_AMMO_DEBUFF'),		('TXT_KEY_PROMOTION_RAGING_AMMO_DEBUFF_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_RAGING_AMMO_DEBUFF')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_UNWELCOME_EVANGELIST');

INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_OCELOT_GOLDEN_AGE'),		('TXT_KEY_PROMOTION_OCELOT_GOLDEN_AGE'),		('TXT_KEY_PROMOTION_OCELOT_GOLDEN_AGE_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_OCELOT_GOLDEN_AGE')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_STEAM_POWERED');

UPDATE UnitPromotions
SET FlankAttackModifier=100, CityAttack=50
WHERE Type = 'PROMOTION_HAVEN_TROOPER';

UPDATE UnitPromotions
SET NearbyEnemyCombatMod = -10, NearbyEnemyCombatRange = 1
WHERE Type = 'PROMOTION_SCREAMING_AMMO';
UPDATE UnitPromotions
SET ExperiencePercent = -50
WHERE Type = 'PROMOTION_LAUGHING_AMMO_DEBUFF';
UPDATE UnitPromotions
SET AttackMod = 10, DefenseMod = -20
WHERE Type = 'PROMOTION_RAGING_AMMO_DEBUFF';
UPDATE UnitPromotions
SET GreatGeneralModifier = 100
WHERE Type = 'PROMOTION_OCELOT_GOLDEN_AGE';


INSERT INTO UnitPromotions_UnitCombats
			(PromotionType,						UnitCombatType)
VALUES		('PROMOTION_SCREAMING_AMMO',		'UNITCOMBAT_GUN'),
			('PROMOTION_LAUGHING_AMMO',			'UNITCOMBAT_GUN'),
			('PROMOTION_RAGING_AMMO',			'UNITCOMBAT_GUN'),
			('PROMOTION_CRYING_AMMO',			'UNITCOMBAT_GUN'),
			('PROMOTION_SCREAMING_AMMO',		'UNITCOMBAT_ARMOR'),
			('PROMOTION_LAUGHING_AMMO',			'UNITCOMBAT_ARMOR'),
			('PROMOTION_RAGING_AMMO',			'UNITCOMBAT_ARMOR'),
			('PROMOTION_CRYING_AMMO',			'UNITCOMBAT_ARMOR');



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
SELECT		('UNIT_HAVEN_TROOPER'),				Description,							Civilopedia,								Strategy,										Help,	
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,UnitArtInfo,UnitArtInfoCulturalVariation,UnitArtInfoEraVariation,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,UnitFlagIconOffset,PortraitIndex,IconAtlas,UnitFlagAtlas
FROM Units WHERE (Type = 'UNIT_XCOM_SQUAD');


--Text Info
UPDATE Units
SET Description = 'TXT_KEY_' || Type, Civilopedia = 'TXT_KEY_' || Type || '_TEXT', Strategy = 'TXT_KEY_' || Type || '_STRATEGY', Help = 'TXT_KEY_' || Type || '_HELP'
WHERE Type = 'UNIT_HAVEN_TROOPER';

--Art Info
UPDATE Units
SET UnitFlagAtlas = 'CIV_ALPHA_ATLAS_OCELOT', UnitFlagIconOffset = 0, IconAtlas = 'CIV_COLOR_ATLAS_OCELOT', PortraitIndex = 3
WHERE Type = 'UNIT_HAVEN_TROOPER';



--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 				SelectionSound, FirstSelectionSound)
SELECT		('UNIT_HAVEN_TROOPER'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_XCOM_SQUAD');	
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================
INSERT INTO Unit_AITypes 	
			(UnitType, 				UnitAIType)
SELECT		('UNIT_HAVEN_TROOPER'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_XCOM_SQUAD');
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================
INSERT INTO Unit_Flavors 	
			(UnitType, 				FlavorType, Flavor)
SELECT		('UNIT_HAVEN_TROOPER'), 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_XCOM_SQUAD');
--==========================================================================================================================
-- Unit_Builds
--==========================================================================================================================
INSERT INTO Unit_Builds 	
			(UnitType, 				BuildType)
SELECT		('UNIT_HAVEN_TROOPER'), BuildType
FROM Unit_Builds WHERE (UnitType = 'UNIT_XCOM_SQUAD');

--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions 	
			(UnitType, 				PromotionType)
SELECT		('UNIT_HAVEN_TROOPER'), PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_XCOM_SQUAD');

INSERT INTO Unit_FreePromotions 	
			(UnitType, 				PromotionType)
VALUES		('UNIT_HAVEN_TROOPER', 	'PROMOTION_HAVEN_TROOPER');


--==========================================================================================================================
-- Unit_Buildings
--==========================================================================================================================
INSERT INTO Unit_Buildings	
			(UnitType, 				BuildingType)
SELECT		('UNIT_HAVEN_TROOPER'), 	BuildingType
FROM Unit_Buildings WHERE (UnitType = 'UNIT_XCOM_SQUAD');

--==========================================================================================================================
-- Unit_BuildingClassRequireds
--==========================================================================================================================
INSERT INTO Unit_BuildingClassRequireds	
			(UnitType, 				BuildingClassType)
SELECT		('UNIT_HAVEN_TROOPER'), 	BuildingClassType
FROM Unit_BuildingClassRequireds WHERE (UnitType = 'UNIT_XCOM_SQUAD');

--==========================================================================================================================
-- Unit_ProductionModifierBuildings
--==========================================================================================================================
INSERT INTO Unit_ProductionModifierBuildings	
			(UnitType, 				BuildingType,	ProductionModifier)
SELECT		('UNIT_HAVEN_TROOPER'), 	BuildingType,	ProductionModifier
FROM Unit_ProductionModifierBuildings WHERE (UnitType = 'UNIT_XCOM_SQUAD');


--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================
INSERT INTO Unit_ClassUpgrades	
			(UnitType, 				UnitClassType)
SELECT		('UNIT_HAVEN_TROOPER'), 	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_XCOM_SQUAD');

--==========================================================================================================================
-- Unit_GreatPersons
--==========================================================================================================================
INSERT INTO Unit_GreatPersons	
			(UnitType, 				GreatPersonType)
SELECT		('UNIT_HAVEN_TROOPER'), 	GreatPersonType
FROM Unit_GreatPersons WHERE (UnitType = 'UNIT_XCOM_SQUAD');


--==========================================================================================================================
-- Unit_ResourceQuantityRequirements
--==========================================================================================================================
INSERT INTO Unit_ResourceQuantityRequirements	
			(UnitType, 				ResourceType,	Cost)
SELECT		('UNIT_HAVEN_TROOPER'), 	ResourceType,	Cost
FROM Unit_ResourceQuantityRequirements WHERE (UnitType = 'UNIT_XCOM_SQUAD');


--==========================================================================================================================
-- Unit_YieldFromKills
--==========================================================================================================================
INSERT INTO Unit_YieldFromKills	
			(UnitType, 				YieldType,	Yield)
SELECT		('UNIT_HAVEN_TROOPER'), 	YieldType,	Yield
FROM Unit_YieldFromKills WHERE (UnitType = 'UNIT_XCOM_SQUAD');











INSERT INTO Units 	
			(Type,							Description,							Civilopedia,								Strategy,										Help,										
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,UnitArtInfo,UnitArtInfoCulturalVariation,UnitArtInfoEraVariation,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,UnitFlagIconOffset,PortraitIndex,IconAtlas,UnitFlagAtlas)
SELECT		('UNIT_PMC_INCORPORATOR'),				Description,							Civilopedia,								Strategy,										Help,	
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,UnitArtInfo,UnitArtInfoCulturalVariation,UnitArtInfoEraVariation,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,UnitFlagIconOffset,PortraitIndex,IconAtlas,UnitFlagAtlas
FROM Units WHERE (Type = 'UNIT_GREAT_GENERAL');


UPDATE Units
SET Found = 1
WHERE Type = 'UNIT_PMC_INCORPORATOR';

--Text Info
UPDATE Units
SET Description = 'TXT_KEY_' || Type, Civilopedia = 'TXT_KEY_' || Type || '_TEXT', Strategy = 'TXT_KEY_' || Type || '_STRATEGY', Help = 'TXT_KEY_' || Type || '_HELP'
WHERE Type = 'UNIT_PMC_INCORPORATOR';

--Art Info
UPDATE Units
SET UnitFlagAtlas = 'CIV_ALPHA_ATLAS_OCELOT', UnitFlagIconOffset = 0, IconAtlas = 'CIV_COLOR_ATLAS_OCELOT', PortraitIndex = 2, UnitArtInfoCulturalVariation = 0, UnitArtInfoEraVariation = 0
WHERE Type = 'UNIT_PMC_INCORPORATOR';


--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 				SelectionSound, FirstSelectionSound)
SELECT		('UNIT_PMC_INCORPORATOR'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_GREAT_GENERAL');	
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================
INSERT INTO Unit_AITypes 	
			(UnitType, 					UnitAIType)
SELECT		('UNIT_PMC_INCORPORATOR'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_SETTLER');
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================
INSERT INTO Unit_Flavors 	
			(UnitType, 				FlavorType, Flavor)
SELECT		('UNIT_PMC_INCORPORATOR'), 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_GREAT_GENERAL');
--==========================================================================================================================
-- Unit_Builds
--==========================================================================================================================
INSERT INTO Unit_Builds 	
			(UnitType, 					BuildType)
VALUES		('UNIT_PMC_INCORPORATOR',	'BUILD_CUSTOMS_HOUSE'),
			('UNIT_PMC_INCORPORATOR',	'BUILD_MANUFACTORY');

--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions 	
			(UnitType, 				PromotionType)
SELECT		('UNIT_PMC_INCORPORATOR'), 	PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_GREAT_GENERAL');


--==========================================================================================================================
-- Unit_Buildings
--==========================================================================================================================
INSERT INTO Unit_Buildings	
			(UnitType, 				BuildingType)
SELECT		('UNIT_PMC_INCORPORATOR'), 	BuildingType
FROM Unit_Buildings WHERE (UnitType = 'UNIT_GREAT_GENERAL');

--==========================================================================================================================
-- Unit_BuildingClassRequireds
--==========================================================================================================================
INSERT INTO Unit_BuildingClassRequireds	
			(UnitType, 				BuildingClassType)
SELECT		('UNIT_PMC_INCORPORATOR'), 	BuildingClassType
FROM Unit_BuildingClassRequireds WHERE (UnitType = 'UNIT_GREAT_GENERAL');

--==========================================================================================================================
-- Unit_ProductionModifierBuildings
--==========================================================================================================================
INSERT INTO Unit_ProductionModifierBuildings	
			(UnitType, 				BuildingType,	ProductionModifier)
SELECT		('UNIT_PMC_INCORPORATOR'), 	BuildingType,	ProductionModifier
FROM Unit_ProductionModifierBuildings WHERE (UnitType = 'UNIT_GREAT_GENERAL');


--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================
INSERT INTO Unit_ClassUpgrades	
			(UnitType, 				UnitClassType)
SELECT		('UNIT_PMC_INCORPORATOR'), 	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_GREAT_GENERAL');

--==========================================================================================================================
-- Unit_GreatPersons
--==========================================================================================================================
INSERT INTO Unit_GreatPersons	
			(UnitType, 				GreatPersonType)
SELECT		('UNIT_PMC_INCORPORATOR'), 	GreatPersonType
FROM Unit_GreatPersons WHERE (UnitType = 'UNIT_GREAT_GENERAL');


--==========================================================================================================================
-- Unit_ResourceQuantityRequirements
--==========================================================================================================================
INSERT INTO Unit_ResourceQuantityRequirements	
			(UnitType, 				ResourceType,	Cost)
SELECT		('UNIT_PMC_INCORPORATOR'), 	ResourceType,	Cost
FROM Unit_ResourceQuantityRequirements WHERE (UnitType = 'UNIT_GREAT_GENERAL');


--==========================================================================================================================
-- Unit_YieldFromKills
--==========================================================================================================================
INSERT INTO Unit_YieldFromKills	
			(UnitType, 				YieldType,	Yield)
SELECT		('UNIT_PMC_INCORPORATOR'), 	YieldType,	Yield
FROM Unit_YieldFromKills WHERE (UnitType = 'UNIT_GREAT_GENERAL');