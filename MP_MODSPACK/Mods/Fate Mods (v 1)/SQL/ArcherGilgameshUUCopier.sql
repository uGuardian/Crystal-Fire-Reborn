--BOTH GILGAMESH AND ARCHER WILL USE THIS


PRAGMA recursive_triggers;
PRAGMA recursive_triggers = 1;


ALTER TABLE Traits ADD COLUMN 'BuildAllUniqueUnits' BOOLEAN DEFAULT false;
ALTER TABLE Traits ADD COLUMN 'ConvertFaithToGold' BOOLEAN DEFAULT false;
ALTER TABLE Traits ADD COLUMN 'CanUseUnlimitedBladeWorks' BOOLEAN DEFAULT false;

--Add the regular/dummy UUs before anything else

INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 			UnitClassType, 					UnitType)
VALUES		('CIVILIZATION_SUMER_FSN', 	'UNITCLASS_ZIGGURAT_FSN',		'UNIT_ZIGGURAT_FSN'),
			('CIVILIZATION_SUMER_FSN', 	'UNITCLASS_GILGAMESH_VAULT',	'UNIT_GILGAMESH_VAULT'),
			('CIVILIZATION_JAPAN_FSN', 	'UNITCLASS_LONGSWORDSMAN', 	'UNIT_FSN_TRACER'),
			('CIVILIZATION_JAPAN_FSN', 	'UNITCLASS_FSN_KBFORGE', 	'UNIT_FSN_KBFORGE');

--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================
CREATE TRIGGER UBWUnitGameplay2DScripts 
AFTER INSERT ON UnitGameplay2DScripts
WHEN EXISTS (SELECT * FROM Units WHERE Type = NEW.UnitType||'_FSN_UBW')
BEGIN
	INSERT INTO UnitGameplay2DScripts 	
				(UnitType, 						SelectionSound,			FirstSelectionSound)
	VALUES		(NEW.UnitType || '_FSN_UBW',	NEW.SelectionSound,		NEW.FirstSelectionSound);
END;
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================

CREATE TRIGGER UBWUnit_AITypes
AFTER INSERT ON Unit_AITypes
WHEN EXISTS (SELECT * FROM Units WHERE Type = NEW.UnitType||'_FSN_UBW')
BEGIN
	INSERT INTO Unit_AITypes 	
				(UnitType, 					UnitAIType)
	VALUES		(NEW.UnitType || '_FSN_UBW',NEW.UnitAIType);
END;
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================

CREATE TRIGGER UBWUnit_Flavors
AFTER INSERT ON Unit_Flavors
WHEN EXISTS (SELECT * FROM Units WHERE Type = NEW.UnitType||'_FSN_UBW')
BEGIN
	INSERT INTO Unit_Flavors 	
				(UnitType, 						FlavorType,		Flavor)
	VALUES		(NEW.UnitType || '_FSN_UBW', 	NEW.FlavorType, NEW.Flavor);
END;

--==========================================================================================================================
-- Unit_Builds
--==========================================================================================================================


CREATE TRIGGER UBWUnit_Builds
AFTER INSERT ON Unit_Builds
WHEN EXISTS (SELECT * FROM Units WHERE Type = NEW.UnitType||'_FSN_UBW')
BEGIN
	INSERT INTO Unit_Builds 	
				(UnitType, 						BuildType)
	VALUES		(NEW.UnitType || '_FSN_UBW',	NEW.BuildType);
END;


--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================

CREATE TRIGGER UBWUnit_FreePromotions
AFTER INSERT ON Unit_FreePromotions
WHEN EXISTS (SELECT * FROM Units WHERE Type = NEW.UnitType||'_FSN_UBW')
BEGIN
	INSERT INTO Unit_FreePromotions 	
				(UnitType, 						PromotionType)
	VALUES		(NEW.UnitType || '_FSN_UBW',	NEW.PromotionType);
END;


--==========================================================================================================================
-- Unit_Buildings
--==========================================================================================================================

CREATE TRIGGER UBWUnit_Buildings
AFTER INSERT ON Unit_Buildings
WHEN EXISTS (SELECT * FROM Units WHERE Type = NEW.UnitType||'_FSN_UBW')
BEGIN
	INSERT INTO Unit_Buildings	
				(UnitType, 						BuildingType)
	VALUES		(NEW.UnitType || '_FSN_UBW', 	NEW.BuildingType);
END;

--==========================================================================================================================
-- Unit_BuildingClassRequireds
--==========================================================================================================================

CREATE TRIGGER UBWUnit_BuildingClassRequireds
AFTER INSERT ON Unit_BuildingClassRequireds
WHEN EXISTS (SELECT * FROM Units WHERE Type = NEW.UnitType||'_FSN_UBW')
BEGIN
	INSERT INTO Unit_BuildingClassRequireds	
				(UnitType, 						BuildingClassType)
	VALUES		(NEW.UnitType || '_FSN_UBW', 	NEW.BuildingClassType);
END;

--==========================================================================================================================
-- Unit_ProductionModifierBuildings
--==========================================================================================================================

CREATE TRIGGER UBWUnit_ProductionModifierBuildings
AFTER INSERT ON Unit_ProductionModifierBuildings
WHEN EXISTS (SELECT * FROM Units WHERE Type = NEW.UnitType||'_FSN_UBW')
BEGIN
	INSERT INTO Unit_ProductionModifierBuildings	
				(UnitType, 						BuildingType,		ProductionModifier)
	VALUES		(NEW.UnitType || '_FSN_UBW', 	NEW.BuildingType,	NEW.ProductionModifier);
END;


--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================
CREATE TRIGGER UBWUnit_ClassUpgrades
AFTER INSERT ON Unit_ClassUpgrades
WHEN EXISTS (SELECT * FROM Units WHERE Type = NEW.UnitType||'_FSN_UBW')
BEGIN
	INSERT INTO Unit_ClassUpgrades	
				(UnitType, 						UnitClassType)
	VALUES		(NEW.UnitType || '_FSN_UBW', 	NEW.UnitClassType);
END;

--==========================================================================================================================
-- Unit_GreatPersons
--==========================================================================================================================

CREATE TRIGGER UBWUnit_GreatPersons
AFTER INSERT ON Unit_GreatPersons
WHEN EXISTS (SELECT * FROM Units WHERE Type = NEW.UnitType||'_FSN_UBW')
BEGIN
	INSERT INTO Unit_GreatPersons	
				(UnitType, 						GreatPersonType)
	VALUES		(NEW.UnitType || '_FSN_UBW', 	NEW.GreatPersonType);
END;

--==========================================================================================================================
-- Unit_ResourceQuantityRequirements
--==========================================================================================================================

CREATE TRIGGER UBWUnit_ResourceQuantityRequirements
AFTER INSERT ON Unit_ResourceQuantityRequirements
WHEN EXISTS (SELECT * FROM Units WHERE Type = NEW.UnitType||'_FSN_UBW')
BEGIN
	INSERT INTO Unit_ResourceQuantityRequirements	
				(UnitType, 						ResourceType,		Cost)
	VALUES		(NEW.UnitType || '_FSN_UBW', 	NEW.ResourceType,	NEW.Cost);
END;


--==========================================================================================================================
-- Unit_YieldFromKills
--==========================================================================================================================
CREATE TRIGGER UBWUnit_YieldFromKills
AFTER INSERT ON Unit_YieldFromKills
WHEN EXISTS (SELECT * FROM Units WHERE Type = NEW.UnitType||'_FSN_UBW')
BEGIN
	INSERT INTO Unit_YieldFromKills	
				(UnitType, 						YieldType,		Yield)
	VALUES		(NEW.UnitType || '_FSN_UBW', 	NEW.YieldType,	NEW.Yield);
END;





CREATE TRIGGER UBWNewUnitAdded
AFTER INSERT ON Units
WHEN NEW.Type NOT LIKE('%_FSN_UBW') AND NEW.Type NOT IN('UNIT_FSN_TRACER') AND NEW.Type IN (SELECT UnitType FROM Civilization_UnitClassOverrides WHERE CivilizationType NOT LIKE ('CIVILIZATION_BARBARIAN')) AND NEW.Combat > 0 AND NEW.Cost > 0 AND NEW.Special IS NULL
BEGIN
	INSERT OR IGNORE INTO Units 	
				(Type,							Description,							Civilopedia,								Strategy,										Help,										
				Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
				CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
				OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost,
				MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
				SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
				PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,UnitArtInfo,UnitArtInfoCulturalVariation,UnitArtInfoEraVariation,
				ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,UnitFlagIconOffset,PortraitIndex,IconAtlas,UnitFlagAtlas)
	VALUES		(NEW.Type||'_FSN_UBW',				NEW.Description,		NEW.Civilopedia,							NEW.Strategy,										NEW.Help,	
				NEW.Requirements, NEW.Combat, NEW.RangedCombat, NEW.Cost, NEW.FaithCost, NEW.RequiresFaithPurchaseEnabled, NEW.PurchaseOnly, NEW.MoveAfterPurchase, NEW.Moves, NEW.Immobile, NEW.Range, NEW.BaseSightRange, REPLACE(NEW.Type, 'UNIT_', 'UNITCLASS_FSN_UBW_'), NEW.Special, NEW.Capture, NEW.CombatClass, NEW.Domain,
				NEW.CivilianAttackPriority, NEW.DefaultUnitAI, NEW.Food, NEW.NoBadGoodies, NEW.RivalTerritory, NEW.MilitarySupport, NEW.MilitaryProduction, NEW.Pillage, NEW.PillagePrereqTech, NEW.Found, NEW.FoundAbroad, NEW.CultureBombRadius, NEW.GoldenAgeTurns, NEW.FreePolicies,
				NEW.OneShotTourism, NEW.OneShotTourismPercentOthers, NEW.IgnoreBuildingDefense, NEW.PrereqResources, NEW.Mechanized, NEW.Suicide, NEW.CaptureWhileEmbarked, NEW.PrereqTech, NEW.ObsoleteTech, NEW.GoodyHutUpgradeUnitClass, NEW.HurryCostModifier, NEW.AdvancedStartCost,
				NEW.MinAreaSize, NEW.AirInterceptRange, NEW.AirUnitCap, NEW.NukeDamageLevel, NEW.WorkRate, NEW.NumFreeTechs, NEW.BaseBeakersTurnsToCount, NEW.BaseCultureTurnsToCount, NEW.RushBuilding, NEW.BaseHurry, NEW.HurryMultiplier, NEW.BaseGold, NEW.NumGoldPerEra,
				NEW.SpreadReligion, NEW.RemoveHeresy,NEW.ReligionSpreads,NEW.ReligiousStrength,NEW.FoundReligion,NEW.RequiresEnhancedReligion,NEW.ProhibitsSpread,NEW.CanBuyCityState,NEW.CombatLimit,NEW.RangeAttackOnlyInDomain,NEW.RangeAttackIgnoreLOS,NEW.Trade,NEW.NumExoticGoods,
				NEW.PolicyType, NEW.RangedCombatLimit, NEW.XPValueAttack, NEW.XPValueDefense,NEW.SpecialCargo,NEW.DomainCargo,NEW.Conscription,NEW.ExtraMaintenanceCost,NEW.NoMaintenance,NEW.Unhappiness,NEW.UnitArtInfo,NEW.UnitArtInfoCulturalVariation,NEW.UnitArtInfoEraVariation,
				NEW.ProjectPrereq,NEW.SpaceshipProject,NEW.LeaderPromotion,NEW.LeaderExperience,NEW.DontShowYields,0,NEW.MoveRate,NEW.UnitFlagIconOffset,NEW.PortraitIndex,NEW.IconAtlas,NEW.UnitFlagAtlas);
END;

CREATE TRIGGER UBWNewUnitAddedClass
AFTER INSERT ON Units
WHEN NEW.Type LIKE ('%_FSN_UBW')
BEGIN
	INSERT OR IGNORE INTO UnitClasses
				(Type,		Description,		DefaultUnit)
	VALUES		(NEW.Class,	NEW.Description,	null);
END;

CREATE TRIGGER UBWNewUnitAddedClassSetArcherUU
AFTER INSERT ON Units
WHEN NEW.Type LIKE ('%_FSN_UBW')
BEGIN
	INSERT OR IGNORE INTO Civilization_UnitClassOverrides
				(CivilizationType,			UnitClassType,	UnitType)
	VALUES		('CIVILIZATION_JAPAN_FSN',	NEW.Class,		NEW.Type),
				('CIVILIZATION_SUMER_FSN',	NEW.Class,		NEW.Type);
END;


INSERT INTO Units 	
			(Type,							Description,							Civilopedia,								Strategy,										Help,										
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,UnitArtInfo,UnitArtInfoCulturalVariation,UnitArtInfoEraVariation,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,UnitFlagIconOffset,PortraitIndex,IconAtlas,UnitFlagAtlas)
SELECT		(Type||'_FSN_UBW'),				Description, 							Civilopedia,								Strategy,										Help,	
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, REPLACE(Type, 'UNIT_', 'UNITCLASS_') || '_FSN_UBW', Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,UnitArtInfo,UnitArtInfoCulturalVariation,UnitArtInfoEraVariation,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,0,MoveRate,UnitFlagIconOffset,PortraitIndex,IconAtlas,UnitFlagAtlas
FROM Units WHERE Type NOT IN('UNIT_FSN_TRACER', 'UNIT_SHOSHONE_PATHFINDER') AND (Combat > 0 OR RangedCombat > 0) AND Cost > 0 AND (Special IS NULL OR Special NOT IN ('SPECIALUNIT_PEOPLE')) AND Type IN (SELECT UnitType FROM Civilization_UnitClassOverrides WHERE CivilizationType NOT LIKE ('CIVILIZATION_BARBARIAN'));



--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 			SelectionSound,			FirstSelectionSound)
SELECT		(UnitType || '_FSN_UBW'), SelectionSound,		FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType IN (SELECT UnitType FROM Civilization_UnitClassOverrides WHERE CivilizationType NOT IN ('CIVILIZATION_BARBARIAN', 'CIVILIZATION_JAPAN_FSN', 'CIVILIZATION_SUMER_FSN')) AND UnitType NOT IN('UNIT_FSN_TRACER', 'UNIT_SHOSHONE_PATHFINDER') AND UnitType IN (SELECT Type FROM Units WHERE (Combat > 0 OR RangedCombat > 0) AND Cost > 0 AND (Special IS NULL OR Special NOT IN ('SPECIALUNIT_PEOPLE')));
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================
INSERT INTO Unit_AITypes 	
			(UnitType, 				UnitAIType)
SELECT		(UnitType || '_FSN_UBW'), 	UnitAIType
FROM Unit_AITypes WHERE UnitType IN (SELECT UnitType FROM Civilization_UnitClassOverrides WHERE CivilizationType NOT IN ('CIVILIZATION_BARBARIAN', 'CIVILIZATION_JAPAN_FSN', 'CIVILIZATION_SUMER_FSN')) AND UnitType NOT IN('UNIT_FSN_TRACER', 'UNIT_SHOSHONE_PATHFINDER') AND UnitType IN (SELECT Type FROM Units WHERE (Combat > 0 OR RangedCombat > 0) AND Cost > 0 AND (Special IS NULL OR Special NOT IN ('SPECIALUNIT_PEOPLE')));
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================
INSERT INTO Unit_Flavors 	
			(UnitType, 				FlavorType, Flavor)
SELECT		(UnitType || '_FSN_UBW'), 	FlavorType, Flavor + 5
FROM Unit_Flavors WHERE UnitType IN (SELECT UnitType FROM Civilization_UnitClassOverrides WHERE CivilizationType NOT IN ('CIVILIZATION_BARBARIAN', 'CIVILIZATION_JAPAN_FSN', 'CIVILIZATION_SUMER_FSN')) AND UnitType NOT IN('UNIT_FSN_TRACER', 'UNIT_SHOSHONE_PATHFINDER') AND UnitType IN (SELECT Type FROM Units WHERE (Combat > 0 OR RangedCombat > 0) AND Cost > 0 AND (Special IS NULL OR Special NOT IN ('SPECIALUNIT_PEOPLE')));
--==========================================================================================================================
-- Unit_Builds
--==========================================================================================================================
INSERT INTO Unit_Builds 	
			(UnitType, 				BuildType)
SELECT		(UnitType || '_FSN_UBW'), BuildType
FROM Unit_Builds WHERE UnitType IN (SELECT UnitType FROM Civilization_UnitClassOverrides WHERE CivilizationType NOT IN ('CIVILIZATION_BARBARIAN', 'CIVILIZATION_JAPAN_FSN', 'CIVILIZATION_SUMER_FSN')) AND UnitType NOT IN('UNIT_FSN_TRACER', 'UNIT_SHOSHONE_PATHFINDER') AND UnitType IN (SELECT Type FROM Units WHERE (Combat > 0 OR RangedCombat > 0) AND Cost > 0 AND (Special IS NULL OR Special NOT IN ('SPECIALUNIT_PEOPLE')));

--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions 	
			(UnitType, 				PromotionType)
SELECT		(UnitType || '_FSN_UBW'), PromotionType
FROM Unit_FreePromotions WHERE UnitType IN (SELECT UnitType FROM Civilization_UnitClassOverrides WHERE CivilizationType NOT IN ('CIVILIZATION_BARBARIAN', 'CIVILIZATION_JAPAN_FSN', 'CIVILIZATION_SUMER_FSN')) AND UnitType NOT IN('UNIT_FSN_TRACER', 'UNIT_SHOSHONE_PATHFINDER') AND UnitType IN (SELECT Type FROM Units WHERE (Combat > 0 OR RangedCombat > 0) AND Cost > 0 AND (Special IS NULL OR Special NOT IN ('SPECIALUNIT_PEOPLE')));


--==========================================================================================================================
-- Unit_Buildings
--==========================================================================================================================
INSERT INTO Unit_Buildings	
			(UnitType, 				BuildingType)
SELECT		(UnitType || '_FSN_UBW'), 	BuildingType
FROM Unit_Buildings WHERE UnitType IN (SELECT UnitType FROM Civilization_UnitClassOverrides WHERE CivilizationType NOT IN ('CIVILIZATION_BARBARIAN', 'CIVILIZATION_JAPAN_FSN', 'CIVILIZATION_SUMER_FSN')) AND UnitType NOT IN('UNIT_FSN_TRACER', 'UNIT_SHOSHONE_PATHFINDER') AND UnitType IN (SELECT Type FROM Units WHERE (Combat > 0 OR RangedCombat > 0) AND Cost > 0 AND (Special IS NULL OR Special NOT IN ('SPECIALUNIT_PEOPLE')));

--==========================================================================================================================
-- Unit_BuildingClassRequireds
--==========================================================================================================================
INSERT INTO Unit_BuildingClassRequireds	
			(UnitType, 				BuildingClassType)
SELECT		(UnitType || '_FSN_UBW'), 	BuildingClassType
FROM Unit_BuildingClassRequireds WHERE UnitType IN (SELECT UnitType FROM Civilization_UnitClassOverrides WHERE CivilizationType NOT IN ('CIVILIZATION_BARBARIAN', 'CIVILIZATION_JAPAN_FSN', 'CIVILIZATION_SUMER_FSN')) AND UnitType NOT IN('UNIT_FSN_TRACER', 'UNIT_SHOSHONE_PATHFINDER') AND UnitType IN (SELECT Type FROM Units WHERE (Combat > 0 OR RangedCombat > 0) AND Cost > 0 AND (Special IS NULL OR Special NOT IN ('SPECIALUNIT_PEOPLE')));

--==========================================================================================================================
-- Unit_ProductionModifierBuildings
--==========================================================================================================================
INSERT INTO Unit_ProductionModifierBuildings	
			(UnitType, 				BuildingType,	ProductionModifier)
SELECT		(UnitType || '_FSN_UBW'), 	BuildingType,	ProductionModifier
FROM Unit_ProductionModifierBuildings WHERE UnitType IN (SELECT UnitType FROM Civilization_UnitClassOverrides WHERE CivilizationType NOT IN ('CIVILIZATION_BARBARIAN', 'CIVILIZATION_JAPAN_FSN', 'CIVILIZATION_SUMER_FSN')) AND UnitType NOT IN('UNIT_FSN_TRACER', 'UNIT_SHOSHONE_PATHFINDER') AND UnitType IN (SELECT Type FROM Units WHERE (Combat > 0 OR RangedCombat > 0) AND Cost > 0 AND (Special IS NULL OR Special NOT IN ('SPECIALUNIT_PEOPLE')));


--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================
INSERT INTO Unit_ClassUpgrades	
			(UnitType, 				UnitClassType)
SELECT		(UnitType || '_FSN_UBW'), 	UnitClassType
FROM Unit_ClassUpgrades WHERE UnitType IN (SELECT UnitType FROM Civilization_UnitClassOverrides WHERE CivilizationType NOT IN ('CIVILIZATION_BARBARIAN', 'CIVILIZATION_JAPAN_FSN', 'CIVILIZATION_SUMER_FSN')) AND UnitType NOT IN('UNIT_FSN_TRACER', 'UNIT_SHOSHONE_PATHFINDER') AND UnitType IN (SELECT Type FROM Units WHERE (Combat > 0 OR RangedCombat > 0) AND Cost > 0 AND (Special IS NULL OR Special NOT IN ('SPECIALUNIT_PEOPLE')));

--==========================================================================================================================
-- Unit_GreatPersons
--==========================================================================================================================
INSERT INTO Unit_GreatPersons	
			(UnitType, 				GreatPersonType)
SELECT		(UnitType || '_FSN_UBW'), 	GreatPersonType
FROM Unit_GreatPersons WHERE UnitType IN (SELECT UnitType FROM Civilization_UnitClassOverrides WHERE CivilizationType NOT IN ('CIVILIZATION_BARBARIAN', 'CIVILIZATION_JAPAN_FSN', 'CIVILIZATION_SUMER_FSN')) AND UnitType NOT IN('UNIT_FSN_TRACER', 'UNIT_SHOSHONE_PATHFINDER') AND UnitType IN (SELECT Type FROM Units WHERE (Combat > 0 OR RangedCombat > 0) AND Cost > 0 AND (Special IS NULL OR Special NOT IN ('SPECIALUNIT_PEOPLE')));


--==========================================================================================================================
-- Unit_ResourceQuantityRequirements
--==========================================================================================================================
INSERT INTO Unit_ResourceQuantityRequirements	
			(UnitType, 					ResourceType,		Cost)
SELECT		(UnitType || '_FSN_UBW'), 	ResourceType,		Cost
FROM Unit_ResourceQuantityRequirements WHERE UnitType IN (SELECT UnitType FROM Civilization_UnitClassOverrides WHERE CivilizationType NOT IN ('CIVILIZATION_BARBARIAN', 'CIVILIZATION_JAPAN_FSN', 'CIVILIZATION_SUMER_FSN')) AND UnitType NOT IN('UNIT_FSN_TRACER', 'UNIT_SHOSHONE_PATHFINDER') AND UnitType IN (SELECT Type FROM Units WHERE (Combat > 0 OR RangedCombat > 0) AND Cost > 0 AND (Special IS NULL OR Special NOT IN ('SPECIALUNIT_PEOPLE')));

--==========================================================================================================================
-- Unit_YieldFromKills
--==========================================================================================================================
INSERT INTO Unit_YieldFromKills	
			(UnitType, 				YieldType,	Yield)
SELECT		(UnitType || '_FSN_UBW'), 	YieldType,	Yield
FROM Unit_YieldFromKills WHERE UnitType IN (SELECT UnitType FROM Civilization_UnitClassOverrides WHERE CivilizationType NOT IN ('CIVILIZATION_BARBARIAN', 'CIVILIZATION_JAPAN_FSN', 'CIVILIZATION_SUMER_FSN')) AND UnitType NOT IN('UNIT_FSN_TRACER', 'UNIT_SHOSHONE_PATHFINDER') AND UnitType IN (SELECT Type FROM Units WHERE (Combat > 0 OR RangedCombat > 0) AND Cost > 0 AND (Special IS NULL OR Special NOT IN ('SPECIALUNIT_PEOPLE')));