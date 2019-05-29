INSERT INTO DecisionsAddin_Support
			(FileName)
VALUES		('UPlaneptuneDecisions.lua');

INSERT INTO EventsAddin_Support
			(FileName)
VALUES		('UPlaneptuneEvents.lua');




INSERT INTO Policies	
			(Type,									Description)
VALUES		('POLICY_DECISION_PLANEPTUNE_PL_BLAST',	'TXT_KEY_DECISIONS_VV_PLANEPTUNE_PL_BLAST');

INSERT INTO Policy_TourismOnUnitCreation
			(PolicyType,							UnitClassType,	Tourism)
SELECT		('POLICY_DECISION_PLANEPTUNE_PL_BLAST'),Class,			10
FROM Units WHERE Combat > 0 OR Domain = 'DOMAIN_AIR';

CREATE TRIGGER PlutiaNewUnitsDecision
AFTER INSERT ON Units
WHEN NEW.Combat > 0 OR NEW.Domain = 'DOMAIN_AIR'
BEGIN
	INSERT INTO Policy_TourismOnUnitCreation
				(PolicyType,							UnitClassType,	Tourism)
	VALUES		('POLICY_DECISION_PLANEPTUNE_PL_BLAST',	NEW.Class,		25);
END;



INSERT INTO Units 	
			(Type,							Description,							Civilopedia,							Strategy,	Help,										
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,	Unhappiness,UnitArtInfo,UnitArtInfoCulturalVariation,UnitArtInfoEraVariation,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,UnitFlagIconOffset,PortraitIndex,IconAtlas,UnitFlagAtlas)
SELECT		('UNIT_VV_PLUTIA_CLIMAX'),		('TXT_KEY_UNIT_VV_PLUTIA_CLIMAX'),		('TXT_KEY_UNIT_VV_PLUTIA_CLIMAX_TEXT'),	null,		('TXT_KEY_UNIT_VV_PLUTIA_CLIMAX_HELP'),
			Requirements, Combat, RangedCombat, -1, -1, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, 0, Immobile, Range, BaseSightRange,	Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, null, null, null, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,1,	Unhappiness,null,0,0,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,0,2,('CIV_COLOR_ATLAS_VV_PLANEPTUNE_PL'),('RELIGION_ATLAS_VV_PLANEPTUNE_PL')
FROM Units WHERE (Type = 'UNIT_NUCLEAR_MISSILE');



/*INSERT INTO Policy_BuildingClassTourismModifiers
			(PolicyType,						BuildingClassType,			TourismModifier)
VALUES		('POLICY_DECISION_PLANEPTUNE_PL_CELL',	'BUILDINGCLASS_MONUMENT',	15);

INSERT INTO Policy_BuildingClassCultureChanges
			(PolicyType,						BuildingClassType,			CultureChange)
VALUES		('POLICY_DECISION_PLANEPTUNE_PL_CELL',	'BUILDINGCLASS_MONUMENT',	1);




INSERT INTO Policies	
			(Type,									Description)
VALUES		('POLICY_DECISION_PLANEPTUNE_PL_CDMEMORY',	'TXT_KEY_DECISIONS_VV_PLANEPTUNE_PL_CDMEMORY');

INSERT INTO Policy_BuildingClassHappiness
			(PolicyType,							BuildingClassType,	Happiness)
SELECT		('POLICY_DECISION_PLANEPTUNE_PL_CDMEMORY'),	BuildingClass,		1
FROM Buildings WHERE Happiness > 0 OR UnmoddedHappiness > 0;



INSERT INTO Policies	
			(Type,								Description,							LandTradeRouteGoldChange,	SeaTradeRouteGoldChange)
VALUES		('POLICY_DECISION_PLANEPTUNE_PL_PLUS',	'TXT_KEY_DECISIONS_VV_PLANEPTUNE_PL_PLUS',	200,						200);

INSERT INTO Policy_CapitalYieldPerPopChanges
			(PolicyType,						YieldType,		Yield)
VALUES		('POLICY_DECISION_PLANEPTUNE_PL_PLUS',	'YIELD_GOLD',	-50);

INSERT INTO Policy_HurryModifiers
			(PolicyType,						HurryType,		HurryCostModifier)
VALUES		('POLICY_DECISION_PLANEPTUNE_PL_PLUS',	'HURRY_GOLD',	-15); */