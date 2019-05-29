INSERT INTO EventsAddin_Support		
			(FileName)
VALUES		('GilgameshEvents.lua');


INSERT INTO BuildingClasses
			(Type,												DefaultBuilding,								NoLimit)
VALUES		('BUILDINGCLASS_EVENTS_GILGAMESH_FSN_VENGEANCE',	'BUILDING_EVENTS_GILGAMESH_FSN_VENGEANCE',		0),
			('BUILDINGCLASS_EVENTS_GILGAMESH_FSN_IMMORTALITY',	'BUILDING_EVENTS_GILGAMESH_FSN_IMMORTALITY',	0);

INSERT INTO Buildings
			(Type,								BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune)
VALUES		('BUILDING_EVENTS_GILGAMESH_FSN_IMMORTALITY',		'BUILDINGCLASS_EVENTS_GILGAMESH_FSN_IMMORTALITY',
			-1,		-1,			-1,				null,		1,				1),
			('BUILDING_EVENTS_GILGAMESH_FSN_VENGEANCE',		'BUILDINGCLASS_EVENTS_GILGAMESH_FSN_VENGEANCE',
			-1,		-1,			-1,				null,		1,				1);

INSERT INTO Building_YieldChanges
			(BuildingType,								YieldType,			Yield)
VALUES		('BUILDING_EVENTS_GILGAMESH_FSN_VENGEANCE',	'YIELD_FAITH',		-100);

UPDATE Buildings
SET CultureRateModifier = 25
WHERE Type = 'BUILDING_EVENTS_GILGAMESH_FSN_IMMORTALITY';

INSERT INTO Building_GlobalYieldModifiers
			(BuildingType,									YieldType,			Yield)
VALUES		('BUILDING_EVENTS_GILGAMESH_FSN_VENGEANCE',		'YIELD_PRODUCTION',	10),
			('BUILDING_EVENTS_GILGAMESH_FSN_IMMORTALITY',	'YIELD_SCIENCE',	25),
			('BUILDING_EVENTS_GILGAMESH_FSN_IMMORTALITY',	'YIELD_PRODUCTION',	25);


INSERT INTO UnitPromotions	
			(Type,										Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_EVENTS_GILGAMESH'),		('TXT_KEY_PROMOTION_EVENTS_GILGAMESH'),('TXT_KEY_PROMOTION_EVENTS_GILGAMESH_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_EVENTS_GILGAMESH')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_STEAM_POWERED');

UPDATE UnitPromotions
SET CombatPercent = 33
WHERE Type = 'PROMOTION_EVENTS_GILGAMESH';