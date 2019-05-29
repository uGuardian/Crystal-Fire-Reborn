-------------------------------------------------------------------------------------------------------------------------------------------------------------
--Specialist
-------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO Specialists
			(Type,							Visible,	Description,							Strategy,
			GreatPeopleTitle,								IconAtlas,					PortraitIndex,
			PMMMEntertainment)
VALUES		('SPECIALIST_PMMM_ENTERTAINER',	1,			'TXT_KEY_SPECIALIST_PMMM_ENTERTAINER',	'TXT_KEY_SPECIALIST_PMMM_ENTERTAINER_STRATEGY',	
			'TXT_KEY_SPECIALIST_PMMM_ENTERTAINER_TITLE',	'SPECIALIST_ATLAS_PMMM',	0,
			3);


INSERT INTO SpecialistYields
			(SpecialistType,					YieldType,					Yield)
VALUES		('SPECIALIST_PMMM_ENTERTAINER',		'YIELD_TOURISM',			1),
			('SPECIALIST_PMMM_ENTERTAINER',		'YIELD_GOLD',				2);


INSERT INTO SpecialistFlavors
			(SpecialistType,					FlavorType,					Flavor)
VALUES		('SPECIALIST_PMMM_ENTERTAINER',		'FLAVOR_CULTURE',			40),
			('SPECIALIST_PMMM_ENTERTAINER',		'FLAVOR_GREAT_PEOPLE',		15);




-------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Not quite entertainment-related, but here nonetheless
-- MG Communications Buildings
-------------------------------------------------------------------------------------------------------------------------------------------------------------

--Central Post Office
INSERT INTO Buildings
			(Type,							Description,							Civilopedia,								Strategy,
			Help,										PortraitIndex,	IconAtlas,
			PrereqTech,	BuildingClass,
			Cost,	GoldMaintenance,	HurryCostModifier,	MinAreaSize,	ConquestProb,	DisplayPosition, NeverCapture)
SELECT		('BUILDING_PMMM_POST_OFFICE'),	('TXT_KEY_BUILDING_PMMM_POST_OFFICE'),	('TXT_KEY_BUILDING_PMMM_POST_OFFICE_TEXT'),	('TXT_KEY_BUILDING_PMMM_POST_OFFICE_STRATEGY'),
			('TXT_KEY_BUILDING_PMMM_POST_OFFICE_HELP'),	15,				('PMMM_ENTERTAINMENT_BUILDING_ATLAS'),
			PrereqTech,	('BUILDINGCLASS_PMMM_POST_OFFICE'),
			Cost,	0,					-1,					MinAreaSize,	0,				DisplayPosition, 1
FROM Buildings WHERE Type = 'BUILDING_COURTHOUSE';

--Telephone Infrastructure
INSERT INTO Buildings
			(Type,							Description,							Civilopedia,								Strategy,
			Help,										PortraitIndex,	IconAtlas,
			PrereqTech,	BuildingClass,
			Cost,	GoldMaintenance,	HurryCostModifier,	MinAreaSize,	ConquestProb,	DisplayPosition, NeverCapture)
SELECT		('BUILDING_PMMM_PHONE_NETWORK'),	('TXT_KEY_BUILDING_PMMM_PHONE_NETWORK'),	('TXT_KEY_BUILDING_PMMM_PHONE_NETWORK_TEXT'),	('TXT_KEY_BUILDING_PMMM_PHONE_NETWORK_STRATEGY'),
			('TXT_KEY_BUILDING_PMMM_PHONE_NETWORK_HELP'),	7,				('EXPANSION_TECH_ATLAS_1'),
			PrereqTech,	('BUILDINGCLASS_PMMM_PHONE_NETWORK'),
			Cost,	0,					-1,					MinAreaSize,	0,				DisplayPosition, 1
FROM Buildings WHERE Type = 'BUILDING_BROADCAST_TOWER';


INSERT INTO Building_ClassesNeededInCity
			(BuildingType,					BuildingClassType)
VALUES		('BUILDING_PMMM_POST_OFFICE',	'BUILDINGCLASS_PALACE'),
			('BUILDING_PMMM_PHONE_NETWORK',	'BUILDINGCLASS_PMMM_POST_OFFICE');


--Dummies
INSERT INTO Buildings
			(Type,										BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune)
VALUES		('BUILDING_PMMM_POST_OFFICE_DUMMY',			'BUILDINGCLASS_PMMM_POST_OFFICE_DUMMY',
			-1,		-1,			-1,				null,		1,				1);

INSERT INTO Buildings
			(Type,										BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune)
VALUES		('BUILDING_PMMM_PHONE_NETWORK_DUMMY',		'BUILDINGCLASS_PMMM_PHONE_NETWORK_DUMMY',
			-1,		-1,			-1,				null,		1,				1);

INSERT INTO Building_YieldChanges
			(BuildingType,						YieldType,			Yield)
VALUES		('BUILDING_PMMM_POST_OFFICE_DUMMY',	'YIELD_GOLD',		1),
			('BUILDING_PMMM_POST_OFFICE_DUMMY',	'YIELD_PRODUCTION',	1);

INSERT INTO Building_YieldModifiers
			(BuildingType,							YieldType,			Yield)
VALUES		('BUILDING_PMMM_PHONE_NETWORK_DUMMY',	'YIELD_GOLD',		10),
			('BUILDING_PMMM_PHONE_NETWORK_DUMMY',	'YIELD_PRODUCTION',	10);
-------------------------------------------------------------------------------------------------------------------------------------------------------------
--CORE ENTERTAINMENT BUILDINGS
-------------------------------------------------------------------------------------------------------------------------------------------------------------


--Theater
INSERT INTO Buildings
			(Type,						 Description,						Civilopedia,							Strategy,
			Help,									PortraitIndex,	IconAtlas,		SpecialistType,					SpecialistCount,
			PMMMEntertainment,	PrereqTech,
			Cost,	GoldMaintenance,	HurryCostModifier,	MinAreaSize,	ConquestProb,	DisplayPosition, NeverCapture)
SELECT		('BUILDING_PMMM_THEATER'),	('TXT_KEY_BUILDING_PMMM_THEATER'),	('TXT_KEY_BUILDING_PMMM_THEATER_TEXT'),	('TXT_KEY_BUILDING_PMMM_THEATER_STRATEGY'),
			('TXT_KEY_BUILDING_PMMM_THEATER_HELP'),	20,				('BW_ATLAS_1'),	('SPECIALIST_PMMM_ENTERTAINER'),	1,
			2,					PrereqTech,
			Cost,	GoldMaintenance,	HurryCostModifier,	MinAreaSize,	ConquestProb,	DisplayPosition, NeverCapture
FROM Buildings WHERE Type = 'BUILDING_AMPHITHEATER';



--Amusement Park
INSERT INTO Buildings
			(Type,						 Description,						Civilopedia,							Strategy,
			Help,									PortraitIndex,	IconAtlas,								SpecialistType,						SpecialistCount,
			PMMMEntertainment,	PrereqTech,
			Cost,	GoldMaintenance,	HurryCostModifier,	MinAreaSize,	ConquestProb,	DisplayPosition, NeverCapture)
SELECT		('BUILDING_PMMM_AMUSEMENT_PARK'),	('TXT_KEY_BUILDING_PMMM_AMUSEMENT_PARK'),	('TXT_KEY_BUILDING_PMMM_AMUSEMENT_PARK_TEXT'),	('TXT_KEY_BUILDING_PMMM_AMUSEMENT_PARK_STRATEGY'),
			('TXT_KEY_BUILDING_PMMM_AMUSEMENT_PARK_HELP'),3,				('PMMM_ENTERTAINMENT_BUILDING_ATLAS'),	('SPECIALIST_PMMM_ENTERTAINER'),	1,
			3,					('TECH_INDUSTRIALIZATION'),
			Cost,	GoldMaintenance,	HurryCostModifier,	MinAreaSize,	ConquestProb,	DisplayPosition, NeverCapture
FROM Buildings WHERE Type = 'BUILDING_FACTORY';


--Cinema
INSERT INTO Buildings
			(Type,						 Description,						Civilopedia,							Strategy,
			Help,									PortraitIndex,	IconAtlas,								SpecialistType,						SpecialistCount,
			PMMMEntertainment,	PrereqTech,
			Cost,	GoldMaintenance,	HurryCostModifier,	MinAreaSize,	ConquestProb,	DisplayPosition, NeverCapture)
SELECT		('BUILDING_PMMM_CINEMA'),	('TXT_KEY_BUILDING_PMMM_CINEMA'),	('TXT_KEY_BUILDING_PMMM_CINEMA_TEXT'),	('TXT_KEY_BUILDING_PMMM_CINEMA_STRATEGY'),
			('TXT_KEY_BUILDING_PMMM_CINEMA_HELP'),	1,				('PMMM_ENTERTAINMENT_BUILDING_ATLAS'),	('SPECIALIST_PMMM_ENTERTAINER'),	2,
			3,					('TECH_ELECTRONICS'),
			Cost,	GoldMaintenance,	HurryCostModifier,	MinAreaSize,	ConquestProb,	DisplayPosition, NeverCapture
FROM Buildings WHERE Type = 'BUILDING_STADIUM';



--Nightclub
INSERT INTO Buildings
			(Type,						 Description,						Civilopedia,							Strategy,
			Help,									PortraitIndex,	IconAtlas,
			PMMMEntertainmentModifier,	PrereqTech,
			Cost,	GoldMaintenance,	HurryCostModifier,	MinAreaSize,	ConquestProb,	DisplayPosition, NeverCapture)
SELECT		('BUILDING_PMMM_NIGHTCLUB'),	('TXT_KEY_BUILDING_PMMM_NIGHTCLUB'),	('TXT_KEY_BUILDING_PMMM_NIGHTCLUB_TEXT'),	('TXT_KEY_BUILDING_PMMM_NIGHTCLUB_STRATEGY'),
			('TXT_KEY_BUILDING_PMMM_NIGHTCLUB_HELP'),	2,				('PMMM_ENTERTAINMENT_BUILDING_ATLAS'),
			25,					('TECH_LASERS'),
			Cost,	GoldMaintenance,	HurryCostModifier,	MinAreaSize,	ConquestProb,	DisplayPosition, NeverCapture
FROM Buildings WHERE Type = 'BUILDING_SPACESHIP_FACTORY';


INSERT INTO Building_ClassesNeededInCity
			(BuildingType,						BuildingClassType)
VALUES		('BUILDING_PMMM_AMUSEMENT_PARK',	'BUILDINGCLASS_PMMM_THEATER'),
			('BUILDING_PMMM_CINEMA',			'BUILDINGCLASS_PMMM_AMUSEMENT_PARK'),
			('BUILDING_PMMM_NIGHTCLUB',			'BUILDINGCLASS_PMMM_CINEMA');

-------------------------------------------------------------------------------------------------------------------------------------------------------------
--NATIONAL WONDER
-------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO Buildings
			(Type,						 Description,						Civilopedia,							Strategy,
			Help,									PortraitIndex,	IconAtlas,
			PMMMEntertainmentModifier,	PMMMEntertainment,	PrereqTech,				Happiness,	
			Cost,	GoldMaintenance,	HurryCostModifier,	MinAreaSize,	ConquestProb,	DisplayPosition, NumCityCostMod, NukeImmune, NeverCapture)
SELECT		('BUILDING_PMMM_CONVENTION_CENTER'),	('TXT_KEY_BUILDING_PMMM_CONVENTION_CENTER'),	('TXT_KEY_BUILDING_PMMM_CONVENTION_CENTER_TEXT'),	('TXT_KEY_BUILDING_PMMM_CONVENTION_CENTER_STRATEGY'),
			('TXT_KEY_BUILDING_PMMM_CONVENTION_CENTER_HELP'),	4,				('PMMM_ENTERTAINMENT_BUILDING_ATLAS'),
			50,							4,					('TECH_RADAR'),		Happiness,	
			Cost,	0,					-1,					MinAreaSize,	0,				DisplayPosition, NumCityCostMod, NukeImmune, 1
FROM Buildings WHERE Type = 'BUILDING_SPACESHIP_FACTORY';


INSERT INTO Building_ClassesNeededInCity
			(BuildingType,						BuildingClassType)
VALUES		('BUILDING_PMMM_CONVENTION_CENTER',	'BUILDINGCLASS_PMMM_CINEMA');

INSERT INTO Building_PrereqBuildingClasses
			(BuildingType,						BuildingClassType,				NumBuildingNeeded)
VALUES		('BUILDING_PMMM_CONVENTION_CENTER',	'BUILDINGCLASS_PMMM_CINEMA',	-1);


--v27: Buffs Entertainers
INSERT INTO Building_SpecialistYieldChanges
			(BuildingType,						SpecialistType,					YieldType,			Yield)
VALUES		('BUILDING_PMMM_CONVENTION_CENTER',	'SPECIALIST_PMMM_ENTERTAINER',	'YIELD_TOURISM',	1);



-------------------------------------------------------------------------------------------------------------------------------------------------------------
--AREA-SPECIFIC BUILDINGS
-------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO Buildings
			(Type,						 Description,						Civilopedia,							Strategy,
			Help,									PortraitIndex,	IconAtlas,
			PMMMEntertainment,	PrereqTech,			MutuallyExclusiveGroup,	PMMMRequiresAdjacentLake,
			Cost,	HurryCostModifier,	MinAreaSize,	ConquestProb,	DisplayPosition, NeverCapture)
SELECT		('BUILDING_PMMM_MARINA'),	('TXT_KEY_BUILDING_PMMM_MARINA'),	('TXT_KEY_BUILDING_PMMM_MARINA_TEXT'),	('TXT_KEY_BUILDING_PMMM_MARINA_STRATEGY'),
			('TXT_KEY_BUILDING_PMMM_MARINA_HELP'),	5,				('PMMM_ENTERTAINMENT_BUILDING_ATLAS'),
			4,					('TECH_COMPASS'),	11,						1,
			50,		0,					MinAreaSize,	ConquestProb,	DisplayPosition, NeverCapture
FROM Buildings WHERE Type = 'BUILDING_HARBOR';


INSERT INTO Buildings
			(Type,						 Description,						Civilopedia,							Strategy,
			Help,									PortraitIndex,	IconAtlas,
			PMMMEntertainment,	PrereqTech,			MutuallyExclusiveGroup, Water,
			Cost,	HurryCostModifier,	MinAreaSize,	ConquestProb,	DisplayPosition, NeverCapture)
SELECT		('BUILDING_PMMM_BEACH'),	('TXT_KEY_BUILDING_PMMM_BEACH'),	('TXT_KEY_BUILDING_PMMM_BEACH_TEXT'),	('TXT_KEY_BUILDING_PMMM_BEACH_STRATEGY'),
			('TXT_KEY_BUILDING_PMMM_BEACH_HELP'),	6,				('PMMM_ENTERTAINMENT_BUILDING_ATLAS'),
			2,					('TECH_COMPASS'),	11,						1,
			50,		0,					MinAreaSize,	ConquestProb,	DisplayPosition, NeverCapture
FROM Buildings WHERE Type = 'BUILDING_HARBOR';


INSERT INTO Buildings
			(Type,						 Description,						Civilopedia,							Strategy,
			Help,											PortraitIndex,	IconAtlas,
			PMMMEntertainment,	PrereqTech,				MutuallyExclusiveGroup, PMMMMaxLandAreaSize,
			Cost,		HurryCostModifier,	MinAreaSize,	ConquestProb,	DisplayPosition, NeverCapture)
SELECT		('BUILDING_PMMM_ISLAND_RESORT'),	('TXT_KEY_BUILDING_PMMM_ISLAND_RESORT'),	('TXT_KEY_BUILDING_PMMM_ISLAND_RESORT_TEXT'),	('TXT_KEY_BUILDING_PMMM_ISLAND_RESORT_STRATEGY'),
			('TXT_KEY_BUILDING_PMMM_ISLAND_RESORT_HELP'),	10,				('PMMM_ENTERTAINMENT_BUILDING_ATLAS'),
			8,					('TECH_STEAM_POWER'),	11,						5,
			50,			0,					MinAreaSize,	ConquestProb,	DisplayPosition, NeverCapture
FROM Buildings WHERE Type = 'BUILDING_HOSPITAL';


INSERT INTO Buildings
			(Type,						 Description,						Civilopedia,							Strategy,
			Help,									PortraitIndex,	IconAtlas,
			PMMMEntertainment,	PrereqTech,			River,
			Cost,	HurryCostModifier,	MinAreaSize,	ConquestProb,	DisplayPosition, NeverCapture)
SELECT		('BUILDING_PMMM_RAPIDS'),	('TXT_KEY_BUILDING_PMMM_RAPIDS'),	('TXT_KEY_BUILDING_PMMM_RAPIDS_TEXT'),	('TXT_KEY_BUILDING_PMMM_RAPIDS_STRATEGY'),
			('TXT_KEY_BUILDING_PMMM_RAPIDS_HELP'),	7,				('PMMM_ENTERTAINMENT_BUILDING_ATLAS'),
			2,					('TECH_PHYSICS'),	1,
			50,		0,					MinAreaSize,	ConquestProb,	DisplayPosition, NeverCapture
FROM Buildings WHERE Type = 'BUILDING_HARBOR';


INSERT INTO Buildings
			(Type,						 Description,						Civilopedia,							Strategy,
			Help,									PortraitIndex,	IconAtlas,
			PMMMEntertainment,	PrereqTech,				Mountain,
			Cost,	HurryCostModifier,	MinAreaSize,	ConquestProb,	DisplayPosition, NeverCapture)
SELECT		('BUILDING_PMMM_ALPINE'),	('TXT_KEY_BUILDING_PMMM_ALPINE'),	('TXT_KEY_BUILDING_PMMM_ALPINE_TEXT'),	('TXT_KEY_BUILDING_PMMM_ALPINE_STRATEGY'),
			('TXT_KEY_BUILDING_PMMM_ALPINE_HELP'),	8,				('PMMM_ENTERTAINMENT_BUILDING_ATLAS'),
			3,					('TECH_ARCHAEOLOGY'),	1,
			50,		0,					MinAreaSize,	ConquestProb,	DisplayPosition, NeverCapture
FROM Buildings WHERE Type = 'BUILDING_PUBLIC_SCHOOL';


INSERT INTO Buildings
			(Type,						 Description,						Civilopedia,							Strategy,
			Help,									PortraitIndex,	IconAtlas,
			PMMMEntertainment,	PrereqTech,					NearbyTerrainRequired,
			Cost,	HurryCostModifier,	MinAreaSize,	ConquestProb,	DisplayPosition, NeverCapture)
SELECT		('BUILDING_PMMM_WINTER_RESORT'),	('TXT_KEY_BUILDING_PMMM_WINTER_RESORT'),	('TXT_KEY_BUILDING_PMMM_WINTER_RESORT_TEXT'),	('TXT_KEY_BUILDING_PMMM_WINTER_RESORT_STRATEGY'),
			('TXT_KEY_BUILDING_PMMM_WINTER_RESORT_HELP'),	9,				('PMMM_ENTERTAINMENT_BUILDING_ATLAS'),
			8,					('TECH_INDUSTRIALIZATION'),	('TERRAIN_SNOW'),
			50,		0,					MinAreaSize,	ConquestProb,	DisplayPosition, NeverCapture
FROM Buildings WHERE Type = 'BUILDING_PUBLIC_SCHOOL';



-------------------------------------------------------------------------------------------------------------------------------------------------------------
--RESOURCE-CONSUMING BUILDINGS
-------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO Buildings
			(Type,						 Description,						Civilopedia,							Strategy,
			Help,									PortraitIndex,	IconAtlas,
			PMMMEntertainment,	PrereqTech,
			Cost,	GoldMaintenance,HurryCostModifier,	MinAreaSize,	ConquestProb,	DisplayPosition, NeverCapture)
SELECT		('BUILDING_PMMM_EQUESTRIAN'),	('TXT_KEY_BUILDING_PMMM_EQUESTRIAN'),	('TXT_KEY_BUILDING_PMMM_EQUESTRIAN_TEXT'),	('TXT_KEY_BUILDING_PMMM_EQUESTRIAN_STRATEGY'),
			('TXT_KEY_BUILDING_PMMM_EQUESTRIAN_HELP'),	11,				('TECH_ATLAS_1'),
			3,					PrereqTech,
			50,		GoldMaintenance, 0,					MinAreaSize,	ConquestProb,	DisplayPosition, NeverCapture
FROM Buildings WHERE Type = 'BUILDING_STABLE';


INSERT INTO Buildings
			(Type,						 Description,						Civilopedia,							Strategy,
			Help,									PortraitIndex,	IconAtlas,
			PMMMEntertainment,	PrereqTech,
			Cost,		GoldMaintenance,	HurryCostModifier,	MinAreaSize,	ConquestProb,	DisplayPosition, NeverCapture)
SELECT		('BUILDING_PMMM_RACECOURSE'),	('TXT_KEY_BUILDING_PMMM_RACECOURSE'),	('TXT_KEY_BUILDING_PMMM_RACECOURSE_TEXT'),	('TXT_KEY_BUILDING_PMMM_RACECOURSE_STRATEGY'),
			('TXT_KEY_BUILDING_PMMM_RACECOURSE_HELP'),	11,				('PMMM_ENTERTAINMENT_BUILDING_ATLAS'),
			4,					('TECH_COMBUSTION'),
			50,			GoldMaintenance - 1, 0,					MinAreaSize,	ConquestProb,	DisplayPosition, NeverCapture
FROM Buildings WHERE Type = 'BUILDING_LABORATORY';


INSERT INTO Building_ResourceQuantityRequirements
			(BuildingType,					ResourceType,		Cost)
VALUES		('BUILDING_PMMM_EQUESTRIAN',	'RESOURCE_HORSE',	2),
			('BUILDING_PMMM_RACECOURSE',	'RESOURCE_OIL',		1);



-------------------------------------------------------------------------------------------------------------------------------------------------------------
--WORLD WONDERS
-------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO Buildings
			(Type,							 BuildingClass,						Description,							Civilopedia,								Strategy,
			Help,										PortraitIndex,	IconAtlas,								
			PMMMEntertainmentCitizenModifier,	PrereqTech,	UnmoddedHappiness,	WonderSplashImage,
			Cost,	HurryCostModifier,	MinAreaSize,	ConquestProb,	DisplayPosition, NeverCapture, ArtDefineTag,
			Quote)
SELECT		('BUILDING_PMMM_PANATHENAIC'),	('BUILDINGCLASS_PMMM_PANATHENAIC'),	('TXT_KEY_BUILDING_PMMM_PANATHENAIC'),	('TXT_KEY_BUILDING_PMMM_PANATHENAIC_TEXT'),	null,
			('TXT_KEY_BUILDING_PMMM_PANATHENAIC_HELP'),	12,				('PMMM_ENTERTAINMENT_BUILDING_ATLAS'),	
			50,									PrereqTech,	2,					('PMMMPanathenaicStadium.dds'),
			Cost,	 HurryCostModifier,	MinAreaSize,	ConquestProb,	DisplayPosition, NeverCapture, ArtDefineTag,
			('TXT_KEY_BUILDING_PMMM_PANATHENAIC_QUOTE')
FROM Buildings WHERE Type = 'BUILDING_PARTHENON';


INSERT INTO Buildings
			(Type,						 BuildingClass,					Description,						Civilopedia,							Strategy,
			Help,										PortraitIndex,	IconAtlas,								SpecialistType,			GreatPeopleRateChange,
			PMMMEntertainmentSpecialistModifier,	PrereqTech,	WonderSplashImage,						FreeBuildingThisCity,
			Cost,	HurryCostModifier,	MinAreaSize,	ConquestProb,	DisplayPosition, NeverCapture, ArtDefineTag,
			Quote)
SELECT		('BUILDING_PMMM_RUNGRADO'),	('BUILDINGCLASS_PMMM_RUNGRADO'),('TXT_KEY_BUILDING_PMMM_RUNGRADO'),	('TXT_KEY_BUILDING_PMMM_RUNGRADO_TEXT'),	null,
			('TXT_KEY_BUILDING_PMMM_RUNGRADO_HELP'),	13,				('PMMM_ENTERTAINMENT_BUILDING_ATLAS'),	('SPECIALIST_MERCHANT'),2,
			1,									('TECH_REFRIGERATION'),	('PMMMMayDayStadium.dds'),		('BUILDINGCLASS_STADIUM'),
			Cost,	HurryCostModifier,	MinAreaSize,	ConquestProb,	DisplayPosition, NeverCapture, ArtDefineTag,
			('TXT_KEY_BUILDING_PMMM_RUNGRADO_QUOTE')
FROM Buildings WHERE Type = 'BUILDING_BROADWAY';


INSERT INTO Buildings
			(Type,						 BuildingClass,					Description,						Civilopedia,							Strategy,
			Help,										PortraitIndex,	IconAtlas,								SpecialistType,			GreatPeopleRateChange,
			PMMMEntertainmentConnectionModifier,	PrereqTech,			WonderSplashImage,				FreeBuildingThisCity,
			Cost,	HurryCostModifier,	MinAreaSize,	ConquestProb,	DisplayPosition, NeverCapture, ArtDefineTag,
			Quote)
SELECT		('BUILDING_PMMM_LEMANS'),	('BUILDINGCLASS_PMMM_LEMANS'),	('TXT_KEY_BUILDING_PMMM_LEMANS'),	('TXT_KEY_BUILDING_PMMM_LEMANS_TEXT'),	null,
			('TXT_KEY_BUILDING_PMMM_LEMANS_HELP'),	14,				('PMMM_ENTERTAINMENT_BUILDING_ATLAS'),	('SPECIALIST_ENGINEER'),2,
			2,									('TECH_COMBUSTION'),	('PMMMCircuitDeLaSarthe.dds'),	('BUILDINGCLASS_PMMM_RACECOURSE'),
			Cost,	 HurryCostModifier,	MinAreaSize,	ConquestProb,	DisplayPosition, NeverCapture, ArtDefineTag,
			('TXT_KEY_BUILDING_PMMM_LEMANS_QUOTE')
FROM Buildings WHERE Type = 'BUILDING_CRISTO_REDENTOR';



INSERT INTO Building_YieldChanges
			(BuildingType,					YieldType,			Yield)
VALUES		('BUILDING_PMMM_PANATHENAIC',	'YIELD_CULTURE',	3),
			('BUILDING_PMMM_RUNGRADO',		'YIELD_CULTURE',	2),
			('BUILDING_PMMM_LEMANS',		'YIELD_GOLD',		4);

INSERT INTO Building_Flavors
			(BuildingType,					FlavorType,				Flavor)
VALUES		('BUILDING_PMMM_PANATHENAIC',	'FLAVOR_GREAT_PEOPLE',	15),
			('BUILDING_PMMM_PANATHENAIC',	'FLAVOR_CULTURE',		25),
			('BUILDING_PMMM_PANATHENAIC',	'FLAVOR_HAPPINESS',		15),
			('BUILDING_PMMM_RUNGRADO',		'FLAVOR_CULTURE',		25),
			('BUILDING_PMMM_RUNGRADO',		'FLAVOR_HAPPINESS',		15),
			('BUILDING_PMMM_RUNGRADO',		'FLAVOR_GREAT_PEOPLE',	15),
			('BUILDING_PMMM_LEMANS',		'FLAVOR_CULTURE',		20),
			('BUILDING_PMMM_LEMANS',		'FLAVOR_GOLD',			10),
			('BUILDING_PMMM_LEMANS',		'FLAVOR_GREAT_PEOPLE',	10);




-------------------------------------------------------------------------------------------------------------------------------------------------------------
--BUILDING CLASSES
-------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO BuildingClasses
			(Type,		DefaultBuilding)
SELECT		REPLACE(Type, 'BUILDING_', 'BUILDINGCLASS_'), Type
FROM Buildings WHERE (PMMMEntertainment > 0 OR PMMMEntertainmentModifier > 0);

UPDATE BuildingClasses
SET MaxPlayerInstances = 1
WHERE Type = 'BUILDINGCLASS_PMMM_CONVENTION_CENTER';


INSERT INTO BuildingClasses
			(Type,								DefaultBuilding,				MaxGlobalInstances)
VALUES		('BUILDINGCLASS_PMMM_PANATHENAIC',	'BUILDING_PMMM_PANATHENAIC',	1),
			('BUILDINGCLASS_PMMM_RUNGRADO',		'BUILDING_PMMM_RUNGRADO',		1),
			('BUILDINGCLASS_PMMM_LEMANS',		'BUILDING_PMMM_LEMANS',			1);

INSERT INTO BuildingClasses
			(Type,								DefaultBuilding,				MaxPlayerInstances)
VALUES		('BUILDINGCLASS_PMMM_POST_OFFICE',	'BUILDING_PMMM_POST_OFFICE',	1),
			('BUILDINGCLASS_PMMM_PHONE_NETWORK','BUILDING_PMMM_PHONE_NETWORK',	1);

INSERT INTO BuildingClasses
			(Type,										DefaultBuilding)
VALUES		('BUILDINGCLASS_PMMM_POST_OFFICE_DUMMY',	'BUILDING_PMMM_POST_OFFICE_DUMMY'),
			('BUILDINGCLASS_PMMM_PHONE_NETWORK_DUMMY',	'BUILDING_PMMM_PHONE_NETWORK_DUMMY');



UPDATE Buildings
SET BuildingClass = REPLACE(Type, 'BUILDING_', 'BUILDINGCLASS_')
WHERE PMMMEntertainment > 0 OR PMMMEntertainmentModifier > 0;


-------------------------------------------------------------------------------------------------------------------------------------------------------------
--BUILDING FLAVORS
-------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO Building_Flavors
			(BuildingType,	FlavorType,					Flavor)
SELECT		Type,			('FLAVOR_GREAT_PEOPLE'),	PMMMEntertainment * 6
FROM Buildings WHERE PMMMEntertainment > 0;

INSERT INTO Building_Flavors
			(BuildingType,	FlavorType,					Flavor)
SELECT		Type,			('FLAVOR_CULTURE'),			PMMMEntertainment * 8
FROM Buildings WHERE PMMMEntertainment > 0;

UPDATE Building_Flavors
SET Flavor = Flavor + 10
WHERE BuildingType IN (SELECT Type FROM Buildings WHERE SpecialistType = 'SPECIALIST_PMMM_ENTERTAINER');
			
INSERT INTO Building_Flavors
			(BuildingType,	FlavorType,					Flavor)
SELECT		Type,			('FLAVOR_GREAT_PEOPLE'),	PMMMEntertainmentModifier
FROM Buildings WHERE PMMMEntertainmentModifier > 0;

INSERT INTO Building_Flavors
			(BuildingType,	FlavorType,					Flavor)
SELECT		Type,			('FLAVOR_CULTURE'),			PMMMEntertainmentModifier
FROM Buildings WHERE PMMMEntertainmentModifier > 0;


INSERT INTO Building_Flavors
			(BuildingType,					FlavorType,				Flavor)
VALUES		('BUILDING_PMMM_POST_OFFICE',	'FLAVOR_GOLD',			15),
			('BUILDING_PMMM_POST_OFFICE',	'FLAVOR_PRODUCTION',	15),
			('BUILDING_PMMM_POST_OFFICE',	'FLAVOR_GREAT_PEOPLE',	15),
			('BUILDING_PMMM_PHONE_NETWORK',	'FLAVOR_GOLD',			35),
			('BUILDING_PMMM_PHONE_NETWORK',	'FLAVOR_PRODUCTION',	35),
			('BUILDING_PMMM_PHONE_NETWORK',	'FLAVOR_GREAT_PEOPLE',	35);



-------------------------------------------------------------------------------------------------------------------------------------------------------------
--UPDATE EXISTING WONDERS 
-------------------------------------------------------------------------------------------------------------------------------------------------------------
UPDATE Buildings
SET PMMMEntertainment = 3
WHERE Type = 'BUILDING_GLOBE_THEATER';

UPDATE Language_en_US
SET Text = Text||'[NEWLINE][NEWLINE]+3 [ICON_PMMM_ENTERTAINMENT] Entertainment.'
WHERE Tag = 'TXT_KEY_WONDER_GLOBE_THEATER_HELP';

UPDATE Buildings
SET PMMMEntertainment = 4
WHERE Type IN ('BUILDING_PRORA_RESORT', 'BUILDING_SYDNEY_OPERA_HOUSE', 'BUILDING_BROADWAY');

UPDATE Language_en_US
SET Text = Text||'[NEWLINE][NEWLINE]+4 [ICON_PMMM_ENTERTAINMENT] Entertainment.'
WHERE Tag IN ('TXT_KEY_WONDER_PRORA_RESORT_HELP', 'TXT_KEY_WONDER_BROADWAY_HELP', 'TXT_KEY_WONDER_SYDNEY_OPERA_HOUSE_HELP');


INSERT INTO Building_SpecialistYieldChanges
			(BuildingType,					SpecialistType,					YieldType,			Yield)
VALUES		('BUILDING_STATUE_OF_LIBERTY',	'SPECIALIST_PMMM_ENTERTAINER',	'YIELD_PRODUCTION',	1);