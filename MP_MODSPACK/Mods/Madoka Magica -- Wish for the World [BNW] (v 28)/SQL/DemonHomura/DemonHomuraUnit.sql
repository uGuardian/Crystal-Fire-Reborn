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
SELECT		('UNIT_PMMM_INCUBATOR_SLAVE'),	('TXT_KEY_UNIT_PMMM_INCUBATOR_SLAVE'),	('TXT_KEY_UNIT_PMMM_INCUBATOR_SLAVE_TEXT'),	('TXT_KEY_UNIT_PMMM_INCUBATOR_SLAVE_STRATEGY'),	('TXT_KEY_UNIT_PMMM_INCUBATOR_SLAVE_HELP'),	
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,('ART_DEF_UNIT_INCUBATOR'),0,0,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,0,2,('CIV_COLOR_ATLAS_DEMON_HOMURA'),('UNIT_ATLAS_PMMM_INCUBATOR')
FROM Units WHERE (Type = 'UNIT_WORKER');	

INSERT INTO Units 	
			(Type,						Description,						Civilopedia,						Strategy,									Help,										
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,UnitArtInfo,UnitArtInfoCulturalVariation,UnitArtInfoEraVariation,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,UnitFlagIconOffset,PortraitIndex,IconAtlas,UnitFlagAtlas)
SELECT		('UNIT_PMMM_CLARA_DOLL'),	('TXT_KEY_UNIT_PMMM_CLARA_DOLL'),	('TXT_KEY_UNIT_PMMM_CLARA_DOLL_TEXT'),	('TXT_KEY_UNIT_PMMM_CLARA_DOLL_STRATEGY'),	('TXT_KEY_UNIT_PMMM_CLARA_DOLL_HELP'),
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,UnitArtInfo,0,0,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,0,3,('CIV_COLOR_ATLAS_DEMON_HOMURA'),('CIV_ALPHA_ATLAS_DEMON_HOMURA')
FROM Units WHERE (Type = 'UNIT_GREAT_GENERAL');	

--Incubator Slave gets 25% extra Work Rate compared to Worker
UPDATE Units
SET WorkRate=WorkRate*1.25
WHERE Type='UNIT_PMMM_INCUBATOR_SLAVE';

--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 				SelectionSound, FirstSelectionSound)
SELECT		('UNIT_PMMM_INCUBATOR_SLAVE'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_WORKER');

INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 				SelectionSound, FirstSelectionSound)
SELECT		('UNIT_PMMM_CLARA_DOLL'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_GREAT_GENERAL');	
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================
INSERT INTO Unit_AITypes 	
			(UnitType, 				UnitAIType)
SELECT		('UNIT_PMMM_INCUBATOR_SLAVE'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_WORKER');

INSERT INTO Unit_AITypes 	
			(UnitType, 				UnitAIType)
SELECT		('UNIT_PMMM_CLARA_DOLL'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_GREAT_GENERAL');
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================
INSERT INTO Unit_Flavors 	
			(UnitType, 				FlavorType, Flavor)
SELECT		('UNIT_PMMM_INCUBATOR_SLAVE'), 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_WORKER');

INSERT INTO Unit_Flavors 	
			(UnitType, 				FlavorType, Flavor)
SELECT		('UNIT_PMMM_CLARA_DOLL'), 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_GREAT_GENERAL');
--==========================================================================================================================
-- Unit_Builds
--==========================================================================================================================
INSERT INTO Unit_Builds 	
			(UnitType, 				BuildType)
SELECT		('UNIT_PMMM_INCUBATOR_SLAVE'), 	BuildType
FROM Unit_Builds WHERE (UnitType = 'UNIT_WORKER');

INSERT INTO Unit_Builds 	
			(UnitType, 				BuildType)
SELECT		('UNIT_PMMM_CLARA_DOLL'), 	BuildType
FROM Unit_Builds WHERE (UnitType = 'UNIT_GREAT_GENERAL');

DELETE FROM Unit_Builds
WHERE UnitType = 'UNIT_PMMM_CLARA_DOLL' and BuildType = 'IMPROVEMENT_CITADEL';
--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions 	
			(UnitType, 				PromotionType)
SELECT		('UNIT_PMMM_INCUBATOR_SLAVE'), 	PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_WORKER');

INSERT INTO Unit_FreePromotions 	
			(UnitType, 				PromotionType)
SELECT		('UNIT_PMMM_CLARA_DOLL'), 	PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_GREAT_GENERAL');

INSERT INTO Unit_FreePromotions 	
			(UnitType, 				PromotionType)
SELECT		('UNIT_PMMM_CLARA_DOLL'), 	PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_GREAT_ADMIRAL');

INSERT INTO Unit_FreePromotions 	
			(UnitType, 							PromotionType)
VALUES		('UNIT_PMMM_INCUBATOR_SLAVE',			'PROMOTION_INCUBATOR_SLAVE'),
			('UNIT_PMMM_CLARA_DOLL', 				'PROMOTION_PMMM_CLARA_DOLL'),
			('UNIT_PMMM_CLARA_DOLL', 				'PROMOTION_DOES_NOT_BECOME_GMG');
--==========================================================================================================================
-- Unit_UniqueNames
--==========================================================================================================================
INSERT INTO Unit_UniqueNames 
			(UnitType, 				UniqueName)
VALUES		('UNIT_PMMM_CLARA_DOLL',	'TXT_KEY_GREAT_PERSON_CLARA_DOLL_PRIDE'),
			('UNIT_PMMM_CLARA_DOLL',	'TXT_KEY_GREAT_PERSON_CLARA_DOLL_PESSIMISM'),
			('UNIT_PMMM_CLARA_DOLL',	'TXT_KEY_GREAT_PERSON_CLARA_DOLL_LIAR'),
			('UNIT_PMMM_CLARA_DOLL',	'TXT_KEY_GREAT_PERSON_CLARA_DOLL_COLDHEARTEDNESS'),
			('UNIT_PMMM_CLARA_DOLL',	'TXT_KEY_GREAT_PERSON_CLARA_DOLL_SELFISHNESS'),
			('UNIT_PMMM_CLARA_DOLL',	'TXT_KEY_GREAT_PERSON_CLARA_DOLL_SLANDER'),
			('UNIT_PMMM_CLARA_DOLL',	'TXT_KEY_GREAT_PERSON_CLARA_DOLL_BLOCKHEAD'),
			('UNIT_PMMM_CLARA_DOLL',	'TXT_KEY_GREAT_PERSON_CLARA_DOLL_JEALOUSY'),
			('UNIT_PMMM_CLARA_DOLL',	'TXT_KEY_GREAT_PERSON_CLARA_DOLL_LAZINESS'),
			('UNIT_PMMM_CLARA_DOLL',	'TXT_KEY_GREAT_PERSON_CLARA_DOLL_VANITY'),
			('UNIT_PMMM_CLARA_DOLL',	'TXT_KEY_GREAT_PERSON_CLARA_DOLL_COWARDICE'),
			('UNIT_PMMM_CLARA_DOLL',	'TXT_KEY_GREAT_PERSON_CLARA_DOLL_STUPID_LOOKING'),
			('UNIT_PMMM_CLARA_DOLL',	'TXT_KEY_GREAT_PERSON_CLARA_DOLL_INFERIORITY'),
			('UNIT_PMMM_CLARA_DOLL',	'TXT_KEY_GREAT_PERSON_CLARA_DOLL_STUBBORNNESS'),
			('UNIT_PMMM_CLARA_DOLL',	'TXT_KEY_GREAT_PERSON_CLARA_DOLL_LOVE');
--==========================================================================================================================
--==========================================================================================================================	


--==========================================================================================================================
-- Unit_Buildings
--==========================================================================================================================
INSERT INTO Unit_Buildings	
			(UnitType, 				BuildingType)
SELECT		('UNIT_PMMM_INCUBATOR_SLAVE'), 	BuildingType
FROM Unit_Buildings WHERE (UnitType = 'UNIT_WORKER');

INSERT INTO Unit_Buildings	
			(UnitType, 				BuildingType)
SELECT		('UNIT_PMMM_CLARA_DOLL'), 	BuildingType
FROM Unit_Buildings WHERE (UnitType = 'UNIT_GREAT_GENERAL');

--==========================================================================================================================
-- Unit_BuildingClassRequireds
--==========================================================================================================================
INSERT INTO Unit_BuildingClassRequireds	
			(UnitType, 				BuildingClassType)
SELECT		('UNIT_PMMM_INCUBATOR_SLAVE'), 	BuildingClassType
FROM Unit_BuildingClassRequireds WHERE (UnitType = 'UNIT_WORKER');

INSERT INTO Unit_BuildingClassRequireds	
			(UnitType, 				BuildingClassType)
SELECT		('UNIT_PMMM_CLARA_DOLL'), 	BuildingClassType
FROM Unit_BuildingClassRequireds WHERE (UnitType = 'UNIT_GREAT_GENERAL');

--==========================================================================================================================
-- Unit_ProductionModifierBuildings
--==========================================================================================================================
INSERT INTO Unit_ProductionModifierBuildings	
			(UnitType, 				BuildingType,	ProductionModifier)
SELECT		('UNIT_PMMM_INCUBATOR_SLAVE'), 	BuildingType,	ProductionModifier
FROM Unit_ProductionModifierBuildings WHERE (UnitType = 'UNIT_WORKER');

INSERT INTO Unit_ProductionModifierBuildings	
			(UnitType, 				BuildingType,	ProductionModifier)
SELECT		('UNIT_PMMM_CLARA_DOLL'), 	BuildingType,	ProductionModifier
FROM Unit_ProductionModifierBuildings WHERE (UnitType = 'UNIT_GREAT_GENERAL');


--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================
INSERT INTO Unit_ClassUpgrades	
			(UnitType, 				UnitClassType)
SELECT		('UNIT_PMMM_INCUBATOR_SLAVE'), 	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_WORKER');

INSERT INTO Unit_ClassUpgrades	
			(UnitType, 				UnitClassType)
SELECT		('UNIT_PMMM_CLARA_DOLL'), 	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_GREAT_GENERAL');

--==========================================================================================================================
-- Unit_GreatPersons
--==========================================================================================================================
INSERT INTO Unit_GreatPersons	
			(UnitType, 				GreatPersonType)
SELECT		('UNIT_PMMM_INCUBATOR_SLAVE'), 	GreatPersonType
FROM Unit_GreatPersons WHERE (UnitType = 'UNIT_WORKER');

INSERT INTO Unit_GreatPersons	
			(UnitType, 				GreatPersonType)
SELECT		('UNIT_PMMM_CLARA_DOLL'), 	GreatPersonType
FROM Unit_GreatPersons WHERE (UnitType = 'UNIT_GREAT_GENERAL');


--==========================================================================================================================
-- Unit_ResourceQuantityRequirements
--==========================================================================================================================
INSERT INTO Unit_ResourceQuantityRequirements	
			(UnitType, 				ResourceType,	Cost)
SELECT		('UNIT_PMMM_INCUBATOR_SLAVE'), 	ResourceType,	Cost
FROM Unit_ResourceQuantityRequirements WHERE (UnitType = 'UNIT_WORKER');


INSERT INTO Unit_ResourceQuantityRequirements	
			(UnitType, 				ResourceType,	Cost)
SELECT		('UNIT_PMMM_CLARA_DOLL'), 	ResourceType,	Cost
FROM Unit_ResourceQuantityRequirements WHERE (UnitType = 'UNIT_GREAT_GENERAL');

--==========================================================================================================================
-- Unit_YieldFromKills
--==========================================================================================================================
INSERT INTO Unit_YieldFromKills	
			(UnitType, 				YieldType,	Yield)
SELECT		('UNIT_PMMM_INCUBATOR_SLAVE'), 	YieldType,	Yield
FROM Unit_YieldFromKills WHERE (UnitType = 'UNIT_WORKER');

INSERT INTO Unit_YieldFromKills	
			(UnitType, 				YieldType,	Yield)
SELECT		('UNIT_PMMM_CLARA_DOLL'), 	YieldType,	Yield
FROM Unit_YieldFromKills WHERE (UnitType = 'UNIT_GREAT_GENERAL');