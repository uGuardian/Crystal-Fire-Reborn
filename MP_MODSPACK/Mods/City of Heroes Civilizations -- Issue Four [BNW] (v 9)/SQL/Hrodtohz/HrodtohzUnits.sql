--All SQL Unit inserts were based off of SQL code from JFD's Civilizations.

INSERT INTO UnitPromotions
			(Type,											Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_DRONE_WITHDRAWAL'),					('TXT_KEY_PROMOTION_DRONE_WITHDRAWAL'),		('TXT_KEY_PROMOTION_DRONE_WITHDRAWAL_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_DRONE_WITHDRAWAL')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_STEAM_POWERED');

INSERT INTO UnitPromotions
			(Type,											Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_RIKTI_CHIEF'),					('TXT_KEY_PROMOTION_RIKTI_CHIEF'),		('TXT_KEY_PROMOTION_RIKTI_CHIEF_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_RIKTI_CHIEF')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_STEAM_POWERED');

UPDATE UnitPromotions
SET ExtraWithdrawal = 60, HoveringUnit = 1
WHERE Type = 'PROMOTION_DRONE_WITHDRAWAL';

UPDATE UnitPromotions
SET RangedDefenseMod = 25
WHERE Type = 'PROMOTION_RIKTI_CHIEF';

INSERT INTO UnitPromotions_UnitClasses
			(PromotionType,				UnitClassType,			Modifier,	PediaType)
VALUES		('PROMOTION_RIKTI_CHIEF',	'UNITCLASS_XCOM_SQUAD',	-50,		'PEDIA_ATTRIBUTES');

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
SELECT		('UNIT_RIKTI_DRONE'),	('TXT_KEY_UNIT_RIKTI_DRONE'),	('TXT_KEY_UNIT_RIKTI_DRONE_TEXT'),	('TXT_KEY_UNIT_RIKTI_DRONE_STRATEGY'),	('TXT_KEY_UNIT_RIKTI_DRONE_HELP'),
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,UnitArtInfo,0,0,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,0,2,IconAtlas,('CIV_ALPHA_ATLAS_RIKTI_DRONE')
FROM Units WHERE (Type = 'UNIT_BAZOOKA');	

UPDATE Units
SET UnitArtInfo = 'ART_DEF_UNIT_RIKTI_DRONE', UnitArtInfoCulturalVariation = null, UnitArtInfoEraVariation = null, IconAtlas = ('CIV_COLOR_ATLAS_RIKTI')
WHERE Type = 'UNIT_RIKTI_DRONE';


--Has Higher Ranged, but lower Combat
UPDATE Units
SET Combat =		CAST((Combat*0.66) AS INT),
	RangedCombat =	CAST((RangedCombat*1.33) AS INT)
WHERE Type = 'UNIT_RIKTI_DRONE';

--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 				SelectionSound, FirstSelectionSound)
SELECT		('UNIT_RIKTI_DRONE'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_BAZOOKA');	
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================
INSERT INTO Unit_AITypes 	
			(UnitType, 				UnitAIType)
SELECT		('UNIT_RIKTI_DRONE'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_BAZOOKA');
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================
INSERT INTO Unit_Flavors 	
			(UnitType, 				FlavorType, Flavor)
SELECT		('UNIT_RIKTI_DRONE'), 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_BAZOOKA');
--==========================================================================================================================
-- Unit_Builds
--==========================================================================================================================
INSERT INTO Unit_Builds 	
			(UnitType, 				BuildType)
SELECT		('UNIT_RIKTI_DRONE'), BuildType
FROM Unit_Builds WHERE (UnitType = 'UNIT_BAZOOKA');
--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions 	
			(UnitType, 				PromotionType)
SELECT		('UNIT_RIKTI_DRONE'), 	PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_BAZOOKA');

INSERT INTO Unit_FreePromotions 	
			(UnitType, 				PromotionType)
VALUES		('UNIT_RIKTI_DRONE', 	'PROMOTION_DRONE_WITHDRAWAL');


--==========================================================================================================================
-- Unit_Buildings
--==========================================================================================================================
INSERT INTO Unit_Buildings	
			(UnitType, 				BuildingType)
SELECT		('UNIT_RIKTI_DRONE'), 	BuildingType
FROM Unit_Buildings WHERE (UnitType = 'UNIT_BAZOOKA');

--==========================================================================================================================
-- Unit_BuildingClassRequireds
--==========================================================================================================================
INSERT INTO Unit_BuildingClassRequireds	
			(UnitType, 				BuildingClassType)
SELECT		('UNIT_RIKTI_DRONE'), 	BuildingClassType
FROM Unit_BuildingClassRequireds WHERE (UnitType = 'UNIT_BAZOOKA');

--==========================================================================================================================
-- Unit_ProductionModifierBuildings
--==========================================================================================================================
INSERT INTO Unit_ProductionModifierBuildings	
			(UnitType, 				BuildingType,	ProductionModifier)
SELECT		('UNIT_RIKTI_DRONE'), 	BuildingType,	ProductionModifier
FROM Unit_ProductionModifierBuildings WHERE (UnitType = 'UNIT_BAZOOKA');


--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================
INSERT INTO Unit_ClassUpgrades	
			(UnitType, 				UnitClassType)
SELECT		('UNIT_RIKTI_DRONE'), 	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_BAZOOKA');

--==========================================================================================================================
-- Unit_GreatPersons
--==========================================================================================================================
INSERT INTO Unit_GreatPersons	
			(UnitType, 				GreatPersonType)
SELECT		('UNIT_RIKTI_DRONE'), 	GreatPersonType
FROM Unit_GreatPersons WHERE (UnitType = 'UNIT_BAZOOKA');


--==========================================================================================================================
-- Unit_ResourceQuantityRequirements
--==========================================================================================================================
INSERT INTO Unit_ResourceQuantityRequirements	
			(UnitType, 				ResourceType,	Cost)
SELECT		('UNIT_RIKTI_DRONE'), 	ResourceType,	Cost
FROM Unit_ResourceQuantityRequirements WHERE (UnitType = 'UNIT_BAZOOKA');


--==========================================================================================================================
-- Unit_YieldFromKills
--==========================================================================================================================
INSERT INTO Unit_YieldFromKills	
			(UnitType, 				YieldType,	Yield)
SELECT		('UNIT_RIKTI_DRONE'), 	YieldType,	Yield
FROM Unit_YieldFromKills WHERE (UnitType = 'UNIT_BAZOOKA');




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
SELECT		('UNIT_RIKTI_CHIEF'),	('TXT_KEY_UNIT_RIKTI_CHIEF'),	('TXT_KEY_UNIT_RIKTI_CHIEF_TEXT'),	('TXT_KEY_UNIT_RIKTI_CHIEF_STRATEGY'),	('TXT_KEY_UNIT_RIKTI_CHIEF_HELP'),
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,UnitArtInfo,0,0,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,0,3,IconAtlas,('CIV_ALPHA_ATLAS_RIKTI_HEAVY')
FROM Units WHERE (Type = 'UNIT_XCOM_SQUAD');

UPDATE Units
SET UnitArtInfo = 'ART_DEF_UNIT_RIKTI_CHIEF', UnitArtInfoCulturalVariation = null, UnitArtInfoEraVariation = null, IconAtlas = ('CIV_COLOR_ATLAS_RIKTI')
WHERE Type = 'UNIT_RIKTI_CHIEF';

--Has Higher Combat
UPDATE Units
SET Combat = CAST((Combat*1.30) AS INT)
WHERE Type = 'UNIT_RIKTI_CHIEF';

--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 				SelectionSound, FirstSelectionSound)
SELECT		('UNIT_RIKTI_CHIEF'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_XCOM_SQUAD');	
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================
INSERT INTO Unit_AITypes 	
			(UnitType, 				UnitAIType)
SELECT		('UNIT_RIKTI_CHIEF'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_XCOM_SQUAD');
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================
INSERT INTO Unit_Flavors 	
			(UnitType, 				FlavorType, Flavor)
SELECT		('UNIT_RIKTI_CHIEF'), 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_XCOM_SQUAD');
--==========================================================================================================================
-- Unit_Builds
--==========================================================================================================================
INSERT INTO Unit_Builds 	
			(UnitType, 				BuildType)
SELECT		('UNIT_RIKTI_CHIEF'), BuildType
FROM Unit_Builds WHERE (UnitType = 'UNIT_XCOM_SQUAD');
--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions 	
			(UnitType, 				PromotionType)
SELECT		('UNIT_RIKTI_CHIEF'), 	PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_XCOM_SQUAD');

INSERT INTO Unit_FreePromotions 	
			(UnitType, 				PromotionType)
VALUES		('UNIT_RIKTI_CHIEF', 	'PROMOTION_RIKTI_CHIEF');



--==========================================================================================================================
-- Unit_Buildings
--==========================================================================================================================
INSERT INTO Unit_Buildings	
			(UnitType, 				BuildingType)
SELECT		('UNIT_RIKTI_CHIEF'), 	BuildingType
FROM Unit_Buildings WHERE (UnitType = 'UNIT_XCOM_SQUAD');

--==========================================================================================================================
-- Unit_BuildingClassRequireds
--==========================================================================================================================
INSERT INTO Unit_BuildingClassRequireds	
			(UnitType, 				BuildingClassType)
SELECT		('UNIT_RIKTI_CHIEF'), 	BuildingClassType
FROM Unit_BuildingClassRequireds WHERE (UnitType = 'UNIT_XCOM_SQUAD');

--==========================================================================================================================
-- Unit_ProductionModifierBuildings
--==========================================================================================================================
INSERT INTO Unit_ProductionModifierBuildings	
			(UnitType, 				BuildingType,	ProductionModifier)
SELECT		('UNIT_RIKTI_CHIEF'), 	BuildingType,	ProductionModifier
FROM Unit_ProductionModifierBuildings WHERE (UnitType = 'UNIT_XCOM_SQUAD');


--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================
INSERT INTO Unit_ClassUpgrades	
			(UnitType, 				UnitClassType)
SELECT		('UNIT_RIKTI_CHIEF'), 	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_XCOM_SQUAD');

--==========================================================================================================================
-- Unit_GreatPersons
--==========================================================================================================================
INSERT INTO Unit_GreatPersons	
			(UnitType, 				GreatPersonType)
SELECT		('UNIT_RIKTI_CHIEF'), 	GreatPersonType
FROM Unit_GreatPersons WHERE (UnitType = 'UNIT_XCOM_SQUAD');


--==========================================================================================================================
-- Unit_ResourceQuantityRequirements
--==========================================================================================================================
INSERT INTO Unit_ResourceQuantityRequirements	
			(UnitType, 				ResourceType,	Cost)
SELECT		('UNIT_RIKTI_CHIEF'), 	ResourceType,	Cost
FROM Unit_ResourceQuantityRequirements WHERE (UnitType = 'UNIT_XCOM_SQUAD');


--==========================================================================================================================
-- Unit_YieldFromKills
--==========================================================================================================================
INSERT INTO Unit_YieldFromKills	
			(UnitType, 				YieldType,	Yield)
SELECT		('UNIT_RIKTI_CHIEF'), 	YieldType,	Yield
FROM Unit_YieldFromKills WHERE (UnitType = 'UNIT_XCOM_SQUAD');







--DUMMY GREAT GENERAL -------------------------------------------------------------------------------------------------------


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
SELECT		('UNIT_GREAT_GENERAL_RIKTI'),	Description,								Civilopedia,								Strategy,										Help,
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,UnitArtInfo,UnitArtInfoCulturalVariation,UnitArtInfoEraVariation,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,UnitFlagIconOffset,PortraitIndex,IconAtlas,UnitFlagAtlas
FROM Units WHERE (Type = 'UNIT_GREAT_GENERAL');

UPDATE Units
SET ShowInPedia = 0
WHERE Type = 'UNIT_GREAT_GENERAL_RIKTI';

--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 				SelectionSound, FirstSelectionSound)
SELECT		('UNIT_GREAT_GENERAL_RIKTI'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_GREAT_GENERAL');	
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================
INSERT INTO Unit_AITypes 	
			(UnitType, 				UnitAIType)
SELECT		('UNIT_GREAT_GENERAL_RIKTI'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_GREAT_GENERAL');
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================
INSERT INTO Unit_Flavors 	
			(UnitType, 				FlavorType, Flavor)
SELECT		('UNIT_GREAT_GENERAL_RIKTI'), 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_GREAT_GENERAL');
--==========================================================================================================================
-- Unit_Builds
--==========================================================================================================================
INSERT INTO Unit_Builds 	
			(UnitType, 				BuildType)
VALUES		('UNIT_GREAT_GENERAL_RIKTI', 'BUILD_RIKTI_PYLON');
--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions 	
			(UnitType, 				PromotionType)
SELECT		('UNIT_GREAT_GENERAL_RIKTI'), 	PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_GREAT_GENERAL');

--==========================================================================================================================
-- Unit_Buildings
--==========================================================================================================================
INSERT INTO Unit_Buildings	
			(UnitType, 				BuildingType)
SELECT		('UNIT_GREAT_GENERAL_RIKTI'), 	BuildingType
FROM Unit_Buildings WHERE (UnitType = 'UNIT_GREAT_GENERAL');

--==========================================================================================================================
-- Unit_BuildingClassRequireds
--==========================================================================================================================
INSERT INTO Unit_BuildingClassRequireds	
			(UnitType, 				BuildingClassType)
SELECT		('UNIT_GREAT_GENERAL_RIKTI'), 	BuildingClassType
FROM Unit_BuildingClassRequireds WHERE (UnitType = 'UNIT_GREAT_GENERAL');

--==========================================================================================================================
-- Unit_ProductionModifierBuildings
--==========================================================================================================================
INSERT INTO Unit_ProductionModifierBuildings	
			(UnitType, 				BuildingType,	ProductionModifier)
SELECT		('UNIT_GREAT_GENERAL_RIKTI'), 	BuildingType,	ProductionModifier
FROM Unit_ProductionModifierBuildings WHERE (UnitType = 'UNIT_GREAT_GENERAL');


--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================
INSERT INTO Unit_ClassUpgrades	
			(UnitType, 				UnitClassType)
SELECT		('UNIT_GREAT_GENERAL_RIKTI'), 	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_GREAT_GENERAL');

--==========================================================================================================================
-- Unit_GreatPersons
--==========================================================================================================================
INSERT INTO Unit_GreatPersons	
			(UnitType, 				GreatPersonType)
SELECT		('UNIT_GREAT_GENERAL_RIKTI'), 	GreatPersonType
FROM Unit_GreatPersons WHERE (UnitType = 'UNIT_GREAT_GENERAL');


--==========================================================================================================================
-- Unit_ResourceQuantityRequirements
--==========================================================================================================================
INSERT INTO Unit_ResourceQuantityRequirements	
			(UnitType, 				ResourceType,	Cost)
SELECT		('UNIT_GREAT_GENERAL_RIKTI'), 	ResourceType,	Cost
FROM Unit_ResourceQuantityRequirements WHERE (UnitType = 'UNIT_GREAT_GENERAL');


--==========================================================================================================================
-- Unit_YieldFromKills
--==========================================================================================================================
INSERT INTO Unit_YieldFromKills	
			(UnitType, 				YieldType,	Yield)
SELECT		('UNIT_GREAT_GENERAL_RIKTI'), 	YieldType,	Yield
FROM Unit_YieldFromKills WHERE (UnitType = 'UNIT_GREAT_GENERAL');

--==========================================================================================================================
-- Unit_UniqueNames
--==========================================================================================================================
INSERT INTO Unit_UniqueNames	
			(UnitType, 						UniqueName)
SELECT		('UNIT_GREAT_GENERAL_RIKTI'), 	UniqueName
FROM Unit_UniqueNames WHERE (UnitType = 'UNIT_GREAT_GENERAL');

--Pylon definition


INSERT INTO Improvements
			(Type,									Description,								Civilopedia,
			Help,											ArtDefineTag,				PortraitIndex,	IconAtlas,
			PillageGold,	CultureBombRadius,	CreatedByGreatPerson,	InAdjacentFriendly,	NearbyEnemyDamage,		BuildableOnResources)
SELECT		('IMPROVEMENT_RIKTI_PYLON'),	('TXT_KEY_IMPROVEMENT_RIKTI_PYLON'),	('TXT_KEY_IMPROVEMENT_RIKTI_PYLON_PEDIA'),
			('TXT_KEY_IMPROVEMENT_RIKTI_PYLON_HELP'),('ART_DEF_IMPROVEMENT_RIKTI_PYLON'), 4,			'CIV_COLOR_ATLAS_RIKTI',
			PillageGold,	CultureBombRadius,	CreatedByGreatPerson,	InAdjacentFriendly,	NearbyEnemyDamage * 2,	BuildableOnResources
FROM Improvements WHERE Type = 'IMPROVEMENT_CITADEL';	


INSERT INTO Improvement_Yields
			(ImprovementType,			YieldType,				Yield)
VALUES		('IMPROVEMENT_RIKTI_PYLON',	'YIELD_SCIENCE',		4),
			('IMPROVEMENT_RIKTI_PYLON',	'YIELD_PRODUCTION',		2);


INSERT INTO Improvement_ValidTerrains
			(ImprovementType,						TerrainType)
SELECT		('IMPROVEMENT_RIKTI_PYLON'),	TerrainType
FROM Improvement_ValidTerrains WHERE (ImprovementType = 'IMPROVEMENT_CITADEL');

INSERT INTO Improvement_ResourceTypes
			(ImprovementType,					ResourceType)
SELECT		('IMPROVEMENT_RIKTI_PYLON'),		ResourceType
FROM Improvement_ResourceTypes WHERE (ImprovementType = 'IMPROVEMENT_CITADEL');

CREATE TRIGGER RiktiPylonNewResources
AFTER INSERT ON Improvement_ResourceTypes
WHEN ImprovementType = 'IMPROVEMENT_CITADEL'
BEGIN
	INSERT INTO Improvement_ResourceTypes
				(ImprovementType,				ResourceType)
	VALUES		('IMPROVEMENT_RIKTI_PYLON',		NEW.ResourceType);
END;



INSERT INTO Builds
			(Type,					Time,	ImprovementType,						Description,
			Help,								Recommendation,	EntityEvent,HotKey,OrderPriority,IconIndex,
			IconAtlas,				Kill)
SELECT		('BUILD_RIKTI_PYLON'),	Time,	('IMPROVEMENT_RIKTI_PYLON'),	('TXT_KEY_BUILD_RIKTI_PYLON'),
			('TXT_KEY_BUILD_RIKTI_PYLON_HELP'),	null,			EntityEvent,HotKey,OrderPriority,0,
			('RIKTI_BUILD_ATLAS'),	Kill
FROM Builds WHERE (Type = 'BUILD_CITADEL');

INSERT INTO BuildFeatures
			(BuildType,				FeatureType,PrereqTech,Time,Remove)
SELECT		('BUILD_RIKTI_PYLON'),	FeatureType,PrereqTech,Time,Remove
FROM BuildFeatures WHERE (BuildType = 'BUILD_CITADEL');