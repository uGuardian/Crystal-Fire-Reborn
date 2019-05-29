INSERT INTO DecisionsAddin_Support
			(FileName)
VALUES		('PMMMMadokaDecisions.lua');

INSERT INTO BuildingClasses
			(Type,	DefaultBuilding)
VALUES		('BUILDINGCLASS_DECISION_ORIGINAL_MADOKA_DUMMY', 'BUILDING_DECISION_ORIGINAL_MADOKA_DUMMY');

INSERT INTO Buildings
			(Type,										Description,									BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune,
			EnhancedYieldTech, TechEnhancedTourism)
VALUES		('BUILDING_DECISION_ORIGINAL_MADOKA_DUMMY',	'TXT_KEY_DECISIONS_ORIGINAL_MADOKA_MITAKUN',	'BUILDINGCLASS_DECISION_ORIGINAL_MADOKA_DUMMY',
			-1,		-1,			-1,				null,		1,				1,
			'TECH_COMBUSTION', 2);