INSERT INTO BuildingClasses
			(Type,									DefaultBuilding, 						NoLimit)
VALUES		('BUILDINGCLASS_RIDER_DUMMY_BUILDING',	'BUILDING_RIDER_DUMMY_BUILDING', 		1),
			('BUILDINGCLASS_OKEANOS_DUMMY',			'BUILDING_OKEANOS_DUMMY', 		1);


INSERT INTO Buildings
			(Type,								BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune)
VALUES		('BUILDING_RIDER_DUMMY_BUILDING',		'BUILDINGCLASS_RIDER_DUMMY_BUILDING',
			-1,		-1,			-1,				null,		1,				1),
			('BUILDING_OKEANOS_DUMMY',		'BUILDINGCLASS_OKEANOS_DUMMY',
			-1,		-1,			-1,				null,		1,				1);


UPDATE Buildings
SET UnmoddedHappiness = 1
WHERE Type = 'BUILDING_RIDER_DUMMY_BUILDING';

UPDATE Buildings
SET InstantMilitaryIncrease = 1
WHERE Type = 'BUILDING_OKEANOS_DUMMY';