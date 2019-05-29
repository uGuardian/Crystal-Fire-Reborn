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
SELECT		('UNIT_VV_GEARNAUGHT'),	('TXT_KEY_UNIT_VV_GEARNAUGHT'),	('TXT_KEY_UNIT_VV_GEARNAUGHT_TEXT'),	('TXT_KEY_UNIT_VV_GEARNAUGHT_STRATEGY'),	('TXT_KEY_UNIT_VV_GEARNAUGHT_HELP'),
			Requirements, Combat + 4, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange,	Class, Special, Capture, ('UNITCOMBAT_ARMOR'), Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, 1, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,	Unhappiness,('ART_DEF_UNIT_NEPGEARDAM'),0,0,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,0,3,('CIV_COLOR_ATLAS_VV_PLANEPTUNE_NG'),('UNIT_FLAG_ATLAS_PLANEPTUNE_NG')
FROM Units WHERE (Type = 'UNIT_CAVALRY');

--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 				SelectionSound,	FirstSelectionSound)
SELECT		('UNIT_VV_GEARNAUGHT'),	SelectionSound,	FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_MECH');
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================
INSERT INTO Unit_AITypes 	
			(UnitType, 					UnitAIType)
SELECT		('UNIT_VV_GEARNAUGHT'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_CAVALRY');
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================
INSERT INTO Unit_Flavors 	
			(UnitType, 					FlavorType, Flavor)
SELECT		('UNIT_VV_GEARNAUGHT'), 	FlavorType, Flavor + 5
FROM Unit_Flavors WHERE (UnitType = 'UNIT_CAVALRY');
--==========================================================================================================================
-- Unit_Builds
--==========================================================================================================================
INSERT INTO Unit_Builds 	
			(UnitType, 				BuildType)
SELECT		('UNIT_VV_GEARNAUGHT'), BuildType
FROM Unit_Builds WHERE (UnitType = 'UNIT_CAVALRY');

--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions 	
			(UnitType, 					PromotionType)
SELECT		('UNIT_VV_GEARNAUGHT'), 	PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_CAVALRY') AND (PromotionType != 'PROMOTION_CITY_PENALTY');

--==========================================================================================================================
-- Unit_Buildings
--==========================================================================================================================
INSERT INTO Unit_Buildings	
			(UnitType, 					BuildingType)
SELECT		('UNIT_VV_GEARNAUGHT'), 	BuildingType
FROM Unit_Buildings WHERE (UnitType = 'UNIT_CAVALRY');

--==========================================================================================================================
-- Unit_BuildingClassRequireds
--==========================================================================================================================
INSERT INTO Unit_BuildingClassRequireds	
			(UnitType, 					BuildingClassType)
SELECT		('UNIT_VV_GEARNAUGHT'), 	BuildingClassType
FROM Unit_BuildingClassRequireds WHERE (UnitType = 'UNIT_CAVALRY');

--==========================================================================================================================
-- Unit_ProductionModifierBuildings
--==========================================================================================================================
INSERT INTO Unit_ProductionModifierBuildings	
			(UnitType, 					BuildingType,	ProductionModifier)
SELECT		('UNIT_VV_GEARNAUGHT'), 	BuildingType,	ProductionModifier
FROM Unit_ProductionModifierBuildings WHERE (UnitType = 'UNIT_CAVALRY');

--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================
INSERT INTO Unit_ClassUpgrades	
			(UnitType, 					UnitClassType)
SELECT		('UNIT_VV_GEARNAUGHT'), 	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_CAVALRY');


--==========================================================================================================================
-- Unit_GreatPersons
--==========================================================================================================================
INSERT INTO Unit_GreatPersons	
			(UnitType, 					GreatPersonType)
SELECT		('UNIT_VV_GEARNAUGHT'), 	GreatPersonType
FROM Unit_GreatPersons WHERE (UnitType = 'UNIT_CAVALRY');


--==========================================================================================================================
-- Unit_ResourceQuantityRequirements
--==========================================================================================================================
INSERT INTO Unit_ResourceQuantityRequirements	
			(UnitType, 					ResourceType,		Cost)
VALUES		('UNIT_VV_GEARNAUGHT',		'RESOURCE_IRON',	1);

--==========================================================================================================================
-- Unit_YieldFromKills
--==========================================================================================================================
INSERT INTO Unit_YieldFromKills	
			(UnitType, 					YieldType,	Yield)
SELECT		('UNIT_VV_GEARNAUGHT'), 	YieldType,	Yield
FROM Unit_YieldFromKills WHERE (UnitType = 'UNIT_CAVALRY');



--****************************************************************************************************************************************************
--****************************************************************************************************************************************************
--															SHARICITE UNITS
--****************************************************************************************************************************************************
--****************************************************************************************************************************************************

INSERT INTO Language_en_US
			(Tag,					Text)
SELECT 		(Tag||'_SHARICITE'), 	('Sharicite '||Text)
FROM Language_en_US WHERE Tag IN (SELECT Description FROM Units WHERE (CombatClass = 'UNITCOMBAT_ARMOR') OR Domain IN ('DOMAIN_SEA', 'DOMAIN_AIR'));

INSERT INTO Language_en_US
		(Tag,					Text)
SELECT 	(Tag||'_SHARICITE'), 	(Text||'[NEWLINE][NEWLINE]This Sharicite-powered Unit requires no Strategic Resources, has a 10% higher base [ICON_STRENGTH] Combat Strength and [ICON_RANGE_STRENGTH] Ranged Combat Strength (if applicable), and costs 15% less [ICON_PRODUCTION] Production to build, but it will automatically consume [ICON_VV_SHARES] Shares upon its construction equal to 10% of its [ICON_STRENGTH] Combat Strength. It may only be built by Purple Sister and cannot be bought with [ICON_GOLD] Gold or [ICON_PEACE] Faith. Upgrading this Unit requires 1/3 of the Shares cost of the Unit to which it is being upgraded, in addition to the standard [ICON_GOLD] Gold cost, and may only be done as Purple Sister.')
FROM Language_en_US WHERE Tag IN (SELECT Help FROM Units WHERE (CombatClass = 'UNITCOMBAT_ARMOR') OR Domain IN ('DOMAIN_SEA', 'DOMAIN_AIR'));


--==========================================================================================================================
-- Units
--==========================================================================================================================
INSERT INTO Units 	
			(Type,					Description,					Civilopedia,	Strategy,					Help,										
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,	Unhappiness,UnitArtInfo,UnitArtInfoCulturalVariation,UnitArtInfoEraVariation,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,UnitFlagIconOffset,PortraitIndex,IconAtlas,UnitFlagAtlas)
SELECT		(Type||'_SHARICITE'),	(Description||'_SHARICITE'),	Civilopedia,	Strategy,	(Help||'_SHARICITE'),
			Requirements, CAST((Combat * 1.10) AS INT), CAST((RangedCombat * 1.10) AS INT), CAST((Cost * 0.85) AS INT), -1, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange,	(Class||'_SHARICITE'), Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, (GoodyHutUpgradeUnitClass||'_SHARICITE'), -1, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,	Unhappiness,UnitArtInfo,UnitArtInfoCulturalVariation,UnitArtInfoEraVariation,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,UnitFlagIconOffset,PortraitIndex,IconAtlas,UnitFlagAtlas
FROM Units WHERE (Cost > 1) AND ((Combat > 0 OR RangedCombat > 0) AND ((CombatClass = 'UNITCOMBAT_ARMOR') OR Domain IN ('DOMAIN_SEA', 'DOMAIN_AIR')) AND Type NOT IN (SELECT UnitType FROM Civilization_UnitClassOverrides WHERE UnitType NOT NULL)) OR Type = 'UNIT_VV_GEARNAUGHT';

--==========================================================================================================================
-- UnitClasses
--==========================================================================================================================
INSERT INTO UnitClasses
			(Type,		DefaultUnit)
SELECT 		Class,		null
FROM Units WHERE Type LIKE ('%_SHARICITE');

--==========================================================================================================================
-- Civilization_UnitClassOverrides
--==========================================================================================================================
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 					UnitClassType, 			UnitType)
SELECT		('CIVILIZATION_VV_PLANEPTUNE_PS'), 	Class, 					Type
FROM Units WHERE Type LIKE ('%_SHARICITE');


--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 					SelectionSound,	FirstSelectionSound)
SELECT		(UnitType||'_SHARICITE'),	SelectionSound,	FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType||'_SHARICITE' IN (SELECT Type FROM Units);
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================
INSERT INTO Unit_AITypes 	
			(UnitType, 					UnitAIType)
SELECT		(UnitType||'_SHARICITE'), 	UnitAIType
FROM Unit_AITypes WHERE UnitType||'_SHARICITE' IN (SELECT Type FROM Units);
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================
INSERT INTO Unit_Flavors 	
			(UnitType, 					FlavorType, Flavor)
SELECT		(UnitType||'_SHARICITE'), 	FlavorType, Flavor + 5
FROM Unit_Flavors WHERE UnitType||'_SHARICITE' IN (SELECT Type FROM Units);
--==========================================================================================================================
-- Unit_Builds
--==========================================================================================================================
INSERT INTO Unit_Builds 	
			(UnitType, 				BuildType)
SELECT		(UnitType||'_SHARICITE'), BuildType
FROM Unit_Builds WHERE UnitType||'_SHARICITE' IN (SELECT Type FROM Units);

--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions 	
			(UnitType, 					PromotionType)
SELECT		(UnitType||'_SHARICITE'), 	PromotionType
FROM Unit_FreePromotions WHERE UnitType||'_SHARICITE' IN (SELECT Type FROM Units);

--==========================================================================================================================
-- Unit_Buildings
--==========================================================================================================================
INSERT INTO Unit_Buildings	
			(UnitType, 						BuildingType)
SELECT		(UnitType||'_SHARICITE'), 	BuildingType
FROM Unit_Buildings WHERE UnitType||'_SHARICITE' IN (SELECT Type FROM Units);

--==========================================================================================================================
-- Unit_BuildingClassRequireds
--==========================================================================================================================
INSERT INTO Unit_BuildingClassRequireds	
			(UnitType, 						BuildingClassType)
SELECT		(UnitType||'_SHARICITE'), 	BuildingClassType
FROM Unit_BuildingClassRequireds WHERE UnitType||'_SHARICITE' IN (SELECT Type FROM Units);

--==========================================================================================================================
-- Unit_ProductionModifierBuildings
--==========================================================================================================================
INSERT INTO Unit_ProductionModifierBuildings	
			(UnitType, 					BuildingType,	ProductionModifier)
SELECT		(UnitType||'_SHARICITE'), 	BuildingType,	ProductionModifier
FROM Unit_ProductionModifierBuildings WHERE UnitType||'_SHARICITE' IN (SELECT Type FROM Units);

--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================
INSERT INTO Unit_ClassUpgrades	
			(UnitType, 					UnitClassType)
SELECT		(UnitType||'_SHARICITE'), 	(UnitClassType||'_SHARICITE')
FROM Unit_ClassUpgrades WHERE UnitType||'_SHARICITE' IN (SELECT Type FROM Units);


--==========================================================================================================================
-- Unit_GreatPersons
--==========================================================================================================================
INSERT INTO Unit_GreatPersons	
			(UnitType, 					GreatPersonType)
SELECT		(UnitType||'_SHARICITE'), 	GreatPersonType
FROM Unit_GreatPersons WHERE UnitType||'_SHARICITE' IN (SELECT Type FROM Units);


--==========================================================================================================================
-- Unit_ResourceQuantityRequirements
--==========================================================================================================================

--NONE

--==========================================================================================================================
-- Unit_YieldFromKills
--==========================================================================================================================
INSERT INTO Unit_YieldFromKills	
			(UnitType, 						YieldType,	Yield)
SELECT		(UnitType||'_SHARICITE'), 	YieldType,	Yield
FROM Unit_YieldFromKills WHERE UnitType||'_SHARICITE' IN (SELECT Type FROM Units);




--*************************************************************************************************************************************
--  Tech Expo Stuff
--*************************************************************************************************************************************

UPDATE Units 
SET WorkRate = 100
WHERE (CombatClass = 'UNITCOMBAT_ARMOR' OR Domain = 'DOMAIN_SEA') AND WorkRate = 0;


INSERT INTO Builds
			(Type,					Description,
			Help,									EntityEvent,HotKey,OrderPriority,IconIndex,
			IconAtlas,				Kill)
SELECT		('BUILD_VV_TECH_EXPO'),	('TXT_KEY_BUILD_VV_TECH_EXPO'),
			('TXT_KEY_BUILD_VV_TECH_EXPO_HELP'),	EntityEvent,HotKey,OrderPriority,36,
			('UNIT_ACTION_ATLAS'),	1
FROM Builds WHERE (Type = 'BUILD_REMOVE_FOREST');


INSERT INTO BuildFeatures
			(BuildType,						FeatureType,			Remove)
VALUES		('BUILD_VV_TECH_EXPO',			'FEATURE_VV_TECH_EXPO', 1);


INSERT INTO Unit_Builds
			(UnitType,				BuildType)
SELECT		Type,					('BUILD_VV_TECH_EXPO')
FROM Units WHERE (CombatClass = 'UNITCOMBAT_ARMOR');


CREATE TRIGGER TechExposForNewArmorUnits
AFTER INSERT ON Units
WHEN (NEW.CombatClass = 'UNITCOMBAT_ARMOR')
BEGIN
	INSERT INTO Unit_Builds
				(UnitType,	BuildType)
	VALUES		(NEW.Type,	'BUILD_VV_TECH_EXPO');
END;