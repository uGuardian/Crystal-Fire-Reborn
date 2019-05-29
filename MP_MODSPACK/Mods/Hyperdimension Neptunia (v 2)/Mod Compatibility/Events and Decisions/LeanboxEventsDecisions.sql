INSERT INTO DecisionsAddin_Support
			(FileName)
VALUES		('LeanboxDecisions.lua');

INSERT INTO EventsAddin_Support
			(FileName)
VALUES		('LeanboxEvents.lua');

INSERT OR IGNORE INTO EventsAddin_Support
			(FileName)
VALUES		('HDNSharedEvents.lua');

INSERT INTO BuildingClasses
			(Type,											DefaultBuilding)
VALUES		('BUILDINGCLASS_DECISIONS_LEANBOX_DUMMY',		'BUILDING_DECISIONS_LEANBOX_DUMMY'),
			('BUILDINGCLASS_DECISIONS_LEANBOX_DUMMY_2',		'BUILDING_DECISIONS_LEANBOX_DUMMY_2');

INSERT INTO Buildings
			(Type,										BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune)
VALUES		('BUILDING_DECISIONS_LEANBOX_DUMMY',		'BUILDINGCLASS_DECISIONS_LEANBOX_DUMMY',
			-1,		-1,			-1,				null,		1,				1);

INSERT INTO Buildings
			(Type,										BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune,
			FreeBuilding)
VALUES		('BUILDING_DECISIONS_LEANBOX_DUMMY_2',		'BUILDINGCLASS_DECISIONS_LEANBOX_DUMMY_2',
			-1,		-1,			-1,				null,		1,				1,
			'BUILDINGCLASS_POLICE_STATION');


INSERT INTO Building_YieldModifiers
			(BuildingType,							YieldType,			Yield)
VALUES		('BUILDING_DECISIONS_LEANBOX_DUMMY',	'YIELD_SCIENCE',	10),
			('BUILDING_DECISIONS_LEANBOX_DUMMY',	'YIELD_PRODUCTION',	10);


INSERT INTO Policies	
			(Type,									Description,								AttackBonusTurns)
VALUES		('POLICY_EVENTS_VV_LEANBOX_LEGENDARY',	'TXT_KEY_EVENT_VV_LEANBOX_LEGENDARY_THEME',	20);



INSERT INTO Audio_Sounds
			(SoundID,									Filename,						LoadType)
VALUES		('SND_EVENTS_VV_LEANBOX_LEGENDARY',			'LeanboxLegendaryHeroTheme',	'DynamicResident');

INSERT INTO Audio_2DSounds
			(ScriptID,									SoundID,
			SoundType,			MaxVolume,	MinVolume,	TaperSoundtrackVolume)
VALUES		('AS2D_EVENTS_VV_LEANBOX_LEGENDARY',		'SND_EVENTS_VV_LEANBOX_LEGENDARY',
			'GAME_MUSIC_STINGS',50,			50,			0.0);
