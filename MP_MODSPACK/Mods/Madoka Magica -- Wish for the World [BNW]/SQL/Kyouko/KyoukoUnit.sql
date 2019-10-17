--All SQL Unit inserts were based off of SQL code from JFD's Civilizations.

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
SELECT		('UNIT_PMMM_CHAIN_LANCER'),	('TXT_KEY_UNIT_PMMM_CHAIN_LANCER'),	('TXT_KEY_UNIT_PMMM_CHAIN_LANCER_TEXT'),	('TXT_KEY_UNIT_PMMM_CHAIN_LANCER_STRATEGY'),	('TXT_KEY_UNIT_PMMM_CHAIN_LANCER_HELP'),
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,UnitArtInfo,0,0,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,0,PortraitIndex,IconAtlas,('CIV_ALPHA_ATLAS_KYOUKO')
FROM Units WHERE (Type = 'UNIT_LANCER');

--Remove belief-buy requirement

UPDATE Units
SET RequiresFaithPurchaseEnabled=0
WHERE Type = 'UNIT_PMMM_CHAIN_LANCER';

--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 				SelectionSound, FirstSelectionSound)
SELECT		('UNIT_PMMM_CHAIN_LANCER'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_LANCER');	
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================
INSERT INTO Unit_AITypes 	
			(UnitType, 				UnitAIType)
SELECT		('UNIT_PMMM_CHAIN_LANCER'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_LANCER');
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================
INSERT INTO Unit_Flavors 	
			(UnitType, 				FlavorType, Flavor)
SELECT		('UNIT_PMMM_CHAIN_LANCER'), 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_LANCER');
--==========================================================================================================================
-- Unit_Builds
--==========================================================================================================================
INSERT INTO Unit_Builds 	
			(UnitType, 				BuildType)
SELECT		('UNIT_PMMM_CHAIN_LANCER'), BuildType
FROM Unit_Builds WHERE (UnitType = 'UNIT_LANCER');
--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions 	
			(UnitType, 				PromotionType)
SELECT		('UNIT_PMMM_CHAIN_LANCER'), 	PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_LANCER');

INSERT INTO Unit_FreePromotions 	
			(UnitType, 							PromotionType)
VALUES		('UNIT_PMMM_CHAIN_LANCER', 	'PROMOTION_PMMM_CHAIN_LANCER');


--==========================================================================================================================
-- Unit_Buildings
--==========================================================================================================================
INSERT INTO Unit_Buildings	
			(UnitType, 				BuildingType)
SELECT		('UNIT_PMMM_CHAIN_LANCER'), 	BuildingType
FROM Unit_Buildings WHERE (UnitType = 'UNIT_LANCER');

--==========================================================================================================================
-- Unit_BuildingClassRequireds
--==========================================================================================================================
INSERT INTO Unit_BuildingClassRequireds	
			(UnitType, 				BuildingClassType)
SELECT		('UNIT_PMMM_CHAIN_LANCER'), 	BuildingClassType
FROM Unit_BuildingClassRequireds WHERE (UnitType = 'UNIT_LANCER');

--==========================================================================================================================
-- Unit_ProductionModifierBuildings
--==========================================================================================================================
INSERT INTO Unit_ProductionModifierBuildings	
			(UnitType, 				BuildingType,	ProductionModifier)
SELECT		('UNIT_PMMM_CHAIN_LANCER'), 	BuildingType,	ProductionModifier
FROM Unit_ProductionModifierBuildings WHERE (UnitType = 'UNIT_LANCER');


--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================
INSERT INTO Unit_ClassUpgrades	
			(UnitType, 				UnitClassType)
SELECT		('UNIT_PMMM_CHAIN_LANCER'), 	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_LANCER');

--==========================================================================================================================
-- Unit_GreatPersons
--==========================================================================================================================
INSERT INTO Unit_GreatPersons	
			(UnitType, 				GreatPersonType)
SELECT		('UNIT_PMMM_CHAIN_LANCER'), 	GreatPersonType
FROM Unit_GreatPersons WHERE (UnitType = 'UNIT_LANCER');


--==========================================================================================================================
-- Unit_ResourceQuantityRequirements
--==========================================================================================================================
INSERT INTO Unit_ResourceQuantityRequirements	
			(UnitType, 				ResourceType,	Cost)
SELECT		('UNIT_PMMM_CHAIN_LANCER'), 	ResourceType,	Cost
FROM Unit_ResourceQuantityRequirements WHERE (UnitType = 'UNIT_LANCER');

--Delete Horse requirements
DELETE FROM Unit_ResourceQuantityRequirements
WHERE UnitType = 'UNIT_PMMM_CHAIN_LANCER' AND ResourceType = 'RESOURCE_HORSE';


--==========================================================================================================================
-- Unit_YieldFromKills
--==========================================================================================================================
INSERT INTO Unit_YieldFromKills	
			(UnitType, 				YieldType,	Yield)
SELECT		('UNIT_PMMM_CHAIN_LANCER'), 	YieldType,	Yield
FROM Unit_YieldFromKills WHERE (UnitType = 'UNIT_LANCER');