INSERT INTO DecisionsAddin_Support
			(FileName)
VALUES		('PMMMOrikoKirikaDecisions.lua');

INSERT INTO BuildingClasses
			(Type,	DefaultBuilding)
VALUES		('BUILDINGCLASS_DECISION_ORIKO_KIRIKA_DUMMY', 'BUILDING_DECISION_ORIKO_KIRIKA_DUMMY');

INSERT INTO Buildings
			(Type,										BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune)
VALUES		('BUILDING_DECISION_ORIKO_KIRIKA_DUMMY',		'BUILDINGCLASS_DECISION_ORIKO_KIRIKA_DUMMY',
			-1,		-1,			-1,				null,		1,				1);

INSERT INTO Building_DomainFreeExperiences
			(BuildingType,								DomainType,		Experience)
VALUES		('BUILDING_DECISION_ORIKO_KIRIKA_DUMMY',	'DOMAIN_LAND',	15);