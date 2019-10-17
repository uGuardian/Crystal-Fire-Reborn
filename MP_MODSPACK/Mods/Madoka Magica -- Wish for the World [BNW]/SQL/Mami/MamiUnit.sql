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
SELECT		('UNIT_PMMM_TIRO_MUSKETEER'),	('TXT_KEY_UNIT_PMMM_TIRO_MUSKETEER'),	('TXT_KEY_UNIT_PMMM_TIRO_MUSKETEER_TEXT'),	('TXT_KEY_UNIT_PMMM_TIRO_MUSKETEER_STRATEGY'),	('TXT_KEY_UNIT_PMMM_TIRO_MUSKETEER_HELP'),
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,UnitArtInfo,0,0,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,0,PortraitIndex,IconAtlas,('CIV_ALPHA_ATLAS_MAMI')
FROM Units WHERE (Type = 'UNIT_RIFLEMAN');


--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 				SelectionSound, FirstSelectionSound)
SELECT		('UNIT_PMMM_TIRO_MUSKETEER'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_RIFLEMAN');	
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================
INSERT INTO Unit_AITypes 	
			(UnitType, 				UnitAIType)
SELECT		('UNIT_PMMM_TIRO_MUSKETEER'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_RIFLEMAN');
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================
INSERT INTO Unit_Flavors 	
			(UnitType, 				FlavorType, Flavor)
SELECT		('UNIT_PMMM_TIRO_MUSKETEER'), 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_RIFLEMAN');
--==========================================================================================================================
-- Unit_Builds
--==========================================================================================================================
INSERT INTO Unit_Builds 	
			(UnitType, 				BuildType)
SELECT		('UNIT_PMMM_TIRO_MUSKETEER'), BuildType
FROM Unit_Builds WHERE (UnitType = 'UNIT_RIFLEMAN');
--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions 	
			(UnitType, 				PromotionType)
SELECT		('UNIT_PMMM_TIRO_MUSKETEER'), 	PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_RIFLEMAN');

INSERT INTO Unit_FreePromotions 	
			(UnitType, 							PromotionType)
VALUES		('UNIT_PMMM_TIRO_MUSKETEER', 	'PROMOTION_PMMM_TIRO_MUSKETEER');


--==========================================================================================================================
-- Unit_Buildings
--==========================================================================================================================
INSERT INTO Unit_Buildings	
			(UnitType, 				BuildingType)
SELECT		('UNIT_PMMM_TIRO_MUSKETEER'), 	BuildingType
FROM Unit_Buildings WHERE (UnitType = 'UNIT_RIFLEMAN');

--==========================================================================================================================
-- Unit_BuildingClassRequireds
--==========================================================================================================================
INSERT INTO Unit_BuildingClassRequireds	
			(UnitType, 				BuildingClassType)
SELECT		('UNIT_PMMM_TIRO_MUSKETEER'), 	BuildingClassType
FROM Unit_BuildingClassRequireds WHERE (UnitType = 'UNIT_RIFLEMAN');

--==========================================================================================================================
-- Unit_ProductionModifierBuildings
--==========================================================================================================================
INSERT INTO Unit_ProductionModifierBuildings	
			(UnitType, 				BuildingType,	ProductionModifier)
SELECT		('UNIT_PMMM_TIRO_MUSKETEER'), 	BuildingType,	ProductionModifier
FROM Unit_ProductionModifierBuildings WHERE (UnitType = 'UNIT_RIFLEMAN');


--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================
INSERT INTO Unit_ClassUpgrades	
			(UnitType, 				UnitClassType)
SELECT		('UNIT_PMMM_TIRO_MUSKETEER'), 	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_RIFLEMAN');

--==========================================================================================================================
-- Unit_GreatPersons
--==========================================================================================================================
INSERT INTO Unit_GreatPersons	
			(UnitType, 				GreatPersonType)
SELECT		('UNIT_PMMM_TIRO_MUSKETEER'), 	GreatPersonType
FROM Unit_GreatPersons WHERE (UnitType = 'UNIT_RIFLEMAN');


--==========================================================================================================================
-- Unit_ResourceQuantityRequirements
--==========================================================================================================================
INSERT INTO Unit_ResourceQuantityRequirements	
			(UnitType, 				ResourceType,	Cost)
SELECT		('UNIT_PMMM_TIRO_MUSKETEER'), 	ResourceType,	Cost
FROM Unit_ResourceQuantityRequirements WHERE (UnitType = 'UNIT_RIFLEMAN');


--==========================================================================================================================
-- Unit_YieldFromKills
--==========================================================================================================================
INSERT INTO Unit_YieldFromKills	
			(UnitType, 				YieldType,	Yield)
SELECT		('UNIT_PMMM_TIRO_MUSKETEER'), 	YieldType,	Yield
FROM Unit_YieldFromKills WHERE (UnitType = 'UNIT_RIFLEMAN');