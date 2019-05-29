INSERT INTO DecisionsAddin_Support		
			(FileName)
VALUES		('ArmstrongDecisions.lua');


INSERT INTO Policies
			(Type)
VALUES		('POLICY_DECISIONS_ARMSTRONG_HIRE_OUT_MERCS');

UPDATE Policies
SET AfraidMinorPerTurnInfluence = 100
WHERE Type = 'POLICY_DECISIONS_ARMSTRONG_HIRE_OUT_MERCS';



INSERT INTO BuildingClasses
			(Type,													DefaultBuilding,								NoLimit)
VALUES		('BUILDINGCLASS_DECISIONS_ARMSTRONG_CHILD_SOLDIERS',	'BUILDING_DECISIONS_ARMSTRONG_CHILD_SOLDIERS',	0),
			('BUILDINGCLASS_ARMSTRONG_MERC_GOLD_BUILDING',			'BUILDING_ARMSTRONG_MERC_GOLD_BUILDING',		1);



INSERT INTO Buildings
			(Type,								BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune,
			MilitaryProductionModifier,	ExtraCityHitPoints,	Defense)
VALUES		('BUILDING_DECISIONS_ARMSTRONG_CHILD_SOLDIERS',		'BUILDINGCLASS_DECISIONS_ARMSTRONG_CHILD_SOLDIERS',
			-1,		-1,			-1,				null,		1,				1,
			50,							25,					1000);

INSERT INTO Buildings
			(Type,								BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune)
VALUES		('BUILDING_ARMSTRONG_MERC_GOLD_BUILDING',		'BUILDINGCLASS_ARMSTRONG_MERC_GOLD_BUILDING',
			-1,		-1,			-1,				null,		1,				1);

INSERT INTO Building_YieldChanges
			(BuildingType,								YieldType,		Yield)
VALUES		('BUILDING_ARMSTRONG_MERC_GOLD_BUILDING',	'YIELD_GOLD',	1);