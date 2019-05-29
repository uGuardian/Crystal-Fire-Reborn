INSERT INTO DecisionsAddin_Support
			(FileName)
VALUES		('PMMMUltimateMadokaDecisions.lua');

INSERT INTO Policies
			(Type,										Description)
VALUES		('POLICY_DECISIONS_MADOKA_YURI_VALHALLA',	'TXT_KEY_DECISIONS_MADOKA_YURI_VALHALLA');

UPDATE Policies
SET CityGrowthMod = 10
WHERE Type = 'POLICY_DECISIONS_MADOKA_YURI_VALHALLA';

INSERT INTO Policy_BuildingClassHappiness
			(PolicyType,								BuildingClassType,		Happiness)
VALUES		('POLICY_DECISIONS_MADOKA_YURI_VALHALLA',	'BUILDINGCLASS_GARDEN',	3);