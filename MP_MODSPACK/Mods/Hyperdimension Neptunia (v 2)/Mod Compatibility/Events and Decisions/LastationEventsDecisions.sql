INSERT INTO DecisionsAddin_Support
			(FileName)
VALUES		('LastationDecisions.lua');

INSERT INTO EventsAddin_Support
			(FileName)
VALUES		('LastationEvents.lua');




INSERT INTO Policies	
			(Type,								Description)
VALUES		('POLICY_DECISION_LASTATION_CELL',	'TXT_KEY_DECISIONS_VV_LASTATION_CELL');

INSERT INTO Policy_BuildingClassTourismModifiers
			(PolicyType,						BuildingClassType,			TourismModifier)
VALUES		('POLICY_DECISION_LASTATION_CELL',	'BUILDINGCLASS_MONUMENT',	15);

INSERT INTO Policy_BuildingClassCultureChanges
			(PolicyType,						BuildingClassType,			CultureChange)
VALUES		('POLICY_DECISION_LASTATION_CELL',	'BUILDINGCLASS_MONUMENT',	1);




INSERT INTO Policies	
			(Type,									Description)
VALUES		('POLICY_DECISION_LASTATION_CDMEMORY',	'TXT_KEY_DECISIONS_VV_LASTATION_CDMEMORY');

INSERT INTO Policy_BuildingClassHappiness
			(PolicyType,							BuildingClassType,	Happiness)
SELECT		('POLICY_DECISION_LASTATION_CDMEMORY'),	BuildingClass,		1
FROM Buildings WHERE Happiness > 0 OR UnmoddedHappiness > 0;

CREATE TRIGGER NoireDecisionPolicyHappinessTrigger
AFTER INSERT ON Buildings
WHEN NEW.Happiness > 0 OR NEW.UnmoddedHappiness > 0
BEGIN
	INSERT INTO Policy_BuildingClassHappiness
				(PolicyType,							BuildingClassType,	Happiness)
	VALUES		('POLICY_DECISION_LASTATION_CDMEMORY',	NEW.BuildingClass,	1);
END;




INSERT INTO Policies	
			(Type,								Description,							LandTradeRouteGoldChange,	SeaTradeRouteGoldChange)
VALUES		('POLICY_DECISION_LASTATION_PLUS',	'TXT_KEY_DECISIONS_VV_LASTATION_PLUS',	200,						200);

INSERT INTO Policy_CapitalYieldPerPopChanges
			(PolicyType,						YieldType,		Yield)
VALUES		('POLICY_DECISION_LASTATION_PLUS',	'YIELD_GOLD',	-50);

INSERT INTO Policy_HurryModifiers
			(PolicyType,						HurryType,		HurryCostModifier)
VALUES		('POLICY_DECISION_LASTATION_PLUS',	'HURRY_GOLD',	-15);