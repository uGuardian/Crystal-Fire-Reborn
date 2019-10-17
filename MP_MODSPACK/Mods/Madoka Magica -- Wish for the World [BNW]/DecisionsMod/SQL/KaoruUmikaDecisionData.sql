INSERT INTO DecisionsAddin_Support
			(FileName)
VALUES		('PMMMKaoruUmikaDecisions.lua');

INSERT INTO Policies
			(Type,											Description)
VALUES		('POLICY_DECISIONS_KAORU_UMIKA_SOCCER',			'TXT_KEY_DECISIONS_KAORU_UMIKA_SOCCER'),
			('POLICY_DECISIONS_KAORU_UMIKA_PUBLISH_BOOKS',	'TXT_KEY_DECISIONS_KAORU_UMIKA_PUBLISH_BOOKS');

INSERT INTO Policy_TourismOnUnitCreation
			(PolicyType,									UnitClassType,							Tourism)
VALUES		('POLICY_DECISIONS_KAORU_UMIKA_PUBLISH_BOOKS',	'UNITCLASS_PMMM_ARTIFICIAL_INCUBATOR',	50);

INSERT INTO Policy_BuildingClassYieldChanges
			(PolicyType,							BuildingClassType,		YieldType,		YieldChange)
VALUES		('POLICY_DECISIONS_KAORU_UMIKA_SOCCER',	'BUILDINGCLASS_STADIUM','YIELD_GOLD',	1);

INSERT INTO Policy_BuildingClassCultureChanges
			(PolicyType,							BuildingClassType,		CultureChange)
VALUES		('POLICY_DECISIONS_KAORU_UMIKA_SOCCER',	'BUILDINGCLASS_STADIUM',1);

INSERT INTO Policy_BuildingClassTourismModifiers
			(PolicyType,							BuildingClassType,		TourismModifier)
VALUES		('POLICY_DECISIONS_KAORU_UMIKA_SOCCER',	'BUILDINGCLASS_STADIUM',20);