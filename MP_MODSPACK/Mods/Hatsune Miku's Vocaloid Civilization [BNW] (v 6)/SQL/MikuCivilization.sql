--All SQL Civilization inserts were based off of SQL code from JFD's Civilizations.


INSERT INTO Colors
			(Type,									Red,	Green,	Blue,	Alpha)
VALUES
			('COLOR_PLAYER_VOCALOID_ICON',			0.30,	0.70,	0.70,	1.0),
			('COLOR_PLAYER_VOCALOID_BACKGROUND',	0.09,	0.09,	0.09,	1.0);


INSERT INTO PlayerColors
			(Type,									PrimaryColor,						SecondaryColor,						TextColor)
VALUES		('PLAYERCOLOR_VOCALOID',				'COLOR_PLAYER_VOCALOID_ICON',		'COLOR_PLAYER_VOCALOID_BACKGROUND',	'COLOR_PLAYER_WHITE_TEXT');

--*******************************************************************
-- Miku's Civilization (uses Japan as a baseline)
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage)

SELECT ('CIVILIZATION_VOCALOID'), ('TXT_KEY_CIV_VOCALOID_DESC'), ('TXT_KEY_CIV_VOCALOID_SHORT_DESC'), ('TXT_KEY_CIV_VOCALOID_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_VOCALOID'), ('PLAYERCOLOR_VOCALOID'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_MIKU'), 0, ('CIV_ALPHA_ATLAS_MIKU'), SoundtrackTag, ('MikuSelectImage.dds'),
('TXT_KEY_CIV5_DAWN_MIKU_TEXT'), ('DOM_Miku.dds')

FROM Civilizations WHERE (Type = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Leader
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 			LeaderheadType)
VALUES		('CIVILIZATION_VOCALOID', 	'LEADER_MIKU');	


--*******************************************************************
-- Unique Buildings
--*******************************************************************
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 			BuildingClassType, 							BuildingType)
VALUES		('CIVILIZATION_VOCALOID', 	'BUILDINGCLASS_SOFARM_CIVILOPEDIA_DUMMY', 	'BUILDING_SOFARM_CIVILOPEDIA_DUMMY'),
			('CIVILIZATION_VOCALOID', 	'BUILDINGCLASS_CIRCUS_MAXIMUS', 			'BUILDING_CIRCUS_MAXIMUS_VOCALOID'),
			('CIVILIZATION_VOCALOID', 	'BUILDINGCLASS_NATIONAL_TREASURY', 			'BUILDING_NATIONAL_TREASURY_VOCALOID'),
			('CIVILIZATION_VOCALOID', 	'BUILDINGCLASS_IRONWORKS', 					'BUILDING_IRONWORKS_VOCALOID'),
			('CIVILIZATION_VOCALOID', 	'BUILDINGCLASS_GRAND_TEMPLE', 				'BUILDING_GRAND_TEMPLE_VOCALOID'),
			('CIVILIZATION_VOCALOID', 	'BUILDINGCLASS_LIBRARY', 					'BUILDING_LIBRARY_VOCALOID'),
			('CIVILIZATION_VOCALOID', 	'BUILDINGCLASS_UNIVERSITY', 				'BUILDING_UNIVERSITY_VOCALOID'),
			('CIVILIZATION_VOCALOID', 	'BUILDINGCLASS_PUBLIC_SCHOOL', 				'BUILDING_PUBLIC_SCHOOL_VOCALOID'),
			('CIVILIZATION_VOCALOID', 	'BUILDINGCLASS_LABORATORY', 				'BUILDING_LABORATORY_VOCALOID');


--*******************************************************************
-- Unique Units
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 			UnitClassType, 			UnitType)
VALUES		('CIVILIZATION_VOCALOID', 	'UNITCLASS_MUSICIAN', 	'UNIT_VOCALOID');


--******************************************************************************************************************************************
-- City Names
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 					CityName)
VALUES		('CIVILIZATION_VOCALOID', 	'TXT_KEY_CITY_NAME_VOCALOID_1'),
			('CIVILIZATION_VOCALOID', 	'TXT_KEY_CITY_NAME_VOCALOID_2'),
			('CIVILIZATION_VOCALOID', 	'TXT_KEY_CITY_NAME_VOCALOID_3'),
			('CIVILIZATION_VOCALOID', 	'TXT_KEY_CITY_NAME_VOCALOID_4'),
			('CIVILIZATION_VOCALOID', 	'TXT_KEY_CITY_NAME_VOCALOID_5'),
			('CIVILIZATION_VOCALOID', 	'TXT_KEY_CITY_NAME_VOCALOID_6'),
			('CIVILIZATION_VOCALOID', 	'TXT_KEY_CITY_NAME_VOCALOID_7'),
			('CIVILIZATION_VOCALOID', 	'TXT_KEY_CITY_NAME_VOCALOID_8'),
			('CIVILIZATION_VOCALOID', 	'TXT_KEY_CITY_NAME_VOCALOID_9'),
			('CIVILIZATION_VOCALOID', 	'TXT_KEY_CITY_NAME_VOCALOID_10'),
			('CIVILIZATION_VOCALOID', 	'TXT_KEY_CITY_NAME_VOCALOID_11'),
			('CIVILIZATION_VOCALOID', 	'TXT_KEY_CITY_NAME_VOCALOID_12'),
			('CIVILIZATION_VOCALOID', 	'TXT_KEY_CITY_NAME_VOCALOID_13'),
			('CIVILIZATION_VOCALOID', 	'TXT_KEY_CITY_NAME_VOCALOID_14'),
			('CIVILIZATION_VOCALOID', 	'TXT_KEY_CITY_NAME_VOCALOID_15'),
			('CIVILIZATION_VOCALOID', 	'TXT_KEY_CITY_NAME_VOCALOID_16'),
			('CIVILIZATION_VOCALOID', 	'TXT_KEY_CITY_NAME_VOCALOID_17'),
			('CIVILIZATION_VOCALOID', 	'TXT_KEY_CITY_NAME_VOCALOID_18');

--*******************************************************************
-- Free Buildings
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 					BuildingClassType)
SELECT		('CIVILIZATION_VOCALOID'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Free Techs (O. Madoka gets Archery for free!)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_VOCALOID'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Free Units (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_VOCALOID'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--******************************************************************************************************************************************
--Religion (taken from Japan, most likely Shinto -- she's not conceited enough to found Church of Madoka if she isn't a deity yet!)
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 			ReligionType)
SELECT		('CIVILIZATION_VOCALOID'), 	ReligionType
FROM Civilization_Religions WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Spy Names (generic PMMM spy name list)
--*******************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		
			('CIVILIZATION_VOCALOID', 	'TXT_KEY_SPY_NAME_VOCALOID_0'),	
			('CIVILIZATION_VOCALOID', 	'TXT_KEY_SPY_NAME_VOCALOID_1'),
			('CIVILIZATION_VOCALOID', 	'TXT_KEY_SPY_NAME_VOCALOID_2'),
			('CIVILIZATION_VOCALOID', 	'TXT_KEY_SPY_NAME_VOCALOID_3'),
			('CIVILIZATION_VOCALOID', 	'TXT_KEY_SPY_NAME_VOCALOID_4'),
			('CIVILIZATION_VOCALOID', 	'TXT_KEY_SPY_NAME_VOCALOID_5'),
			('CIVILIZATION_VOCALOID', 	'TXT_KEY_SPY_NAME_VOCALOID_6'),
			('CIVILIZATION_VOCALOID', 	'TXT_KEY_SPY_NAME_VOCALOID_7'),
			('CIVILIZATION_VOCALOID', 	'TXT_KEY_SPY_NAME_VOCALOID_8'),
			('CIVILIZATION_VOCALOID', 	'TXT_KEY_SPY_NAME_VOCALOID_9');



----Start priorities

INSERT INTO Civilization_Start_Region_Priority
			(CivilizationType,			RegionType)
VALUES		('CIVILIZATION_VOCALOID',	'REGION_GRASS');

INSERT INTO Civilization_Start_Along_River
			(CivilizationType,			StartAlongRiver)
VALUES		('CIVILIZATION_VOCALOID',	1);


