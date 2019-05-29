INSERT INTO DecisionsAddin_Support
			(FileName)
VALUES		('LoweeDecisions.lua');

INSERT INTO EventsAddin_Support
			(FileName)
VALUES		('LoweeEvents.lua');


INSERT INTO BuildingClasses
			(Type,												DefaultBuilding)
VALUES		('BUILDINGCLASS_DECISIONS_LOWEE_DUMMY',				'BUILDING_DECISIONS_LOWEE_DUMMY'),
			('BUILDINGCLASS_EVENTS_LOWEE_SHOVELWARE_ALLOW',		'BUILDING_EVENTS_LOWEE_SHOVELWARE_ALLOW'),
			('BUILDINGCLASS_EVENTS_LOWEE_SHOVELWARE_DENY',		'BUILDING_EVENTS_LOWEE_SHOVELWARE_DENY'),
			('BUILDINGCLASS_EVENTS_LOWEE_GUEST_FIGHTER',		'BUILDING_EVENTS_LOWEE_GUEST_FIGHTER');

INSERT INTO Buildings
			(Type,										BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune)
VALUES		('BUILDING_DECISIONS_LOWEE_DUMMY',		'BUILDINGCLASS_DECISIONS_LOWEE_DUMMY',
			-1,		-1,			-1,				null,		1,				1);

INSERT INTO Buildings
			(Type,										BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune,
			CultureRateModifier)
VALUES		('BUILDING_EVENTS_LOWEE_SHOVELWARE_ALLOW',		'BUILDINGCLASS_EVENTS_LOWEE_SHOVELWARE_ALLOW',
			-1,		-1,			-1,				null,		1,				1,
			-10),
			('BUILDING_EVENTS_LOWEE_SHOVELWARE_DENY',		'BUILDINGCLASS_EVENTS_LOWEE_SHOVELWARE_DENY',
			-1,		-1,			-1,				null,		1,				1,
			10);

INSERT INTO Buildings
			(Type,										BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune,
			TechEnhancedTourism,	EnhancedYieldTech)
VALUES		('BUILDING_EVENTS_LOWEE_GUEST_FIGHTER',		'BUILDINGCLASS_EVENTS_LOWEE_GUEST_FIGHTER',
			-1,		-1,			-1,				null,		1,				1,
			4,						'TECH_AGRICULTURE');

INSERT INTO Building_YieldModifiers
			(BuildingType,						YieldType,		Yield)
VALUES		('BUILDING_DECISIONS_LOWEE_DUMMY',	'YIELD_GOLD',	10),
			('BUILDING_DECISIONS_LOWEE_DUMMY',	'YIELD_FOOD',	10);

INSERT INTO Building_GlobalYieldModifiers
			(BuildingType,								YieldType,		Yield)
VALUES		('BUILDING_EVENTS_LOWEE_SHOVELWARE_ALLOW',	'YIELD_GOLD',	10),
			('BUILDING_EVENTS_LOWEE_SHOVELWARE_DENY',	'YIELD_GOLD',	-10);


INSERT INTO Policies	
			(Type,							Description,									MilitaryProductionModifier,	FreeExperience)
VALUES		('POLICY_DECISIONS_VV_LOWEE',	'TXT_KEY_DECISIONS_VV_LOWEE_SMASH_BROTHERS',	20,							10);



INSERT INTO Audio_Sounds
			(SoundID,								Filename,			LoadType)
VALUES		('SND_EVENTS_VV_LOWEE_STAR',			'LoweeEventMusic1',	'DynamicResident');

INSERT INTO Audio_2DSounds
			(ScriptID,									SoundID,
			SoundType,			MaxVolume,	MinVolume,	TaperSoundtrackVolume)
VALUES		('AS2D_EVENTS_VV_LOWEE_STAR',		'SND_EVENTS_VV_LOWEE_STAR',
			'GAME_MUSIC_STINGS',50,			50,			0.0);
