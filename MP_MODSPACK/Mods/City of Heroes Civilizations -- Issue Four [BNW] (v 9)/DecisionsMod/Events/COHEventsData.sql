INSERT INTO EventsAddin_Support
			(FileName)
VALUES		('COHEvents.lua');

INSERT INTO IconTextureAtlases 
			(Atlas, 					IconSize, 	Filename, 					IconsPerRow, 	IconsPerColumn)
VALUES		('EVENT_COLOR_ATLAS_COH',	256,		'COHEventAtlas256.dds',		2,				1),
			('EVENT_COLOR_ATLAS_COH',	128,		'COHEventAtlas128.dds',		2,				1),
			('EVENT_COLOR_ATLAS_COH',	80,			'COHEventAtlas80.dds',		2,				1),
			('EVENT_COLOR_ATLAS_COH',	64,			'COHEventAtlas64.dds',		2,				1),
			('EVENT_COLOR_ATLAS_COH',	45,			'COHEventAtlas45.dds',		2,				1),
			('EVENT_COLOR_ATLAS_COH',	32,			'COHEventAtlas32.dds',		2,				1);

INSERT INTO BuildingClasses
			(Type,												DefaultBuilding)
VALUES		('BUILDINGCLASS_EVENTS_POCKET_D',					'BUILDING_EVENTS_POCKET_D'),
			('BUILDINGCLASS_EVENTS_ARCHITECT_ENTERTAINMENT',	'BUILDING_EVENTS_ARCHITECT_ENTERTAINMENT');


INSERT INTO Buildings
			(Type,										BuildingClass,	
			Cost,	PrereqTech, NeverCapture,	NukeImmune)
VALUES		('BUILDING_EVENTS_POCKET_D',		'BUILDINGCLASS_EVENTS_POCKET_D',
			-1,		null,		1,				1),
			('BUILDING_EVENTS_ARCHITECT_ENTERTAINMENT',	'BUILDINGCLASS_EVENTS_ARCHITECT_ENTERTAINMENT',
			-1,		null,		1,				1);


UPDATE Buildings
SET Description = 'TXT_KEY_' || Type,	Help = 'TXT_KEY_' || Type || '_HELP', Civilopedia = 'TXT_KEY_' || Type || '_TEXT', IconAtlas = 'EVENT_COLOR_ATLAS_COH'
WHERE Type = 'BUILDING_EVENTS_POCKET_D' OR Type = 'BUILDING_EVENTS_ARCHITECT_ENTERTAINMENT';


UPDATE Buildings
SET PortraitIndex = 0, UnmoddedHappiness = 5, EnhancedYieldTech = 'TECH_AGRICULTURE', TechEnhancedTourism = 5
WHERE Type = 'BUILDING_EVENTS_POCKET_D';


UPDATE Buildings
SET PortraitIndex = 1, Happiness = 1
WHERE Type = 'BUILDING_EVENTS_ARCHITECT_ENTERTAINMENT';

INSERT INTO Building_DomainFreeExperiences
			(BuildingType,			DomainType,		Experience)
SELECT		('BUILDING_EVENTS_ARCHITECT_ENTERTAINMENT'),		DomainType,		Experience
FROM Building_DomainFreeExperiences WHERE BuildingType = 'BUILDING_BARRACKS';

INSERT INTO Building_YieldChanges
			(BuildingType,								YieldType,			Yield)
VALUES		('BUILDING_EVENTS_ARCHITECT_ENTERTAINMENT',	'YIELD_CULTURE',	1);

INSERT INTO Building_YieldModifiers
			(BuildingType,								YieldType,			Yield)
VALUES		('BUILDING_EVENTS_ARCHITECT_ENTERTAINMENT',	'YIELD_PRODUCTION',	-15);