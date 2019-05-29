--All SQL Civilization inserts were based off of SQL code from JFD's Civilizations.


INSERT INTO Colors
			(Type,									Red,	Green,	Blue,	Alpha)
VALUES
			('COLOR_PLAYER_TSAB_ICON',			0.09,	0.16,	0.75,	1.0),
			('COLOR_PLAYER_TSAB_BACKGROUND',	1,	1,	1,	1.0);


INSERT INTO PlayerColors
			(Type,									PrimaryColor,						SecondaryColor,						TextColor)
VALUES		('PLAYERCOLOR_TSAB',				'COLOR_PLAYER_TSAB_ICON',		'COLOR_PLAYER_TSAB_BACKGROUND',	'COLOR_PLAYER_WHITE_TEXT');

--*******************************************************************
-- Nanoha's Civilization (uses England as a baseline)
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage)

SELECT ('CIVILIZATION_TSAB'), ('TXT_KEY_CIV_TSAB_DESC'), ('TXT_KEY_CIV_TSAB_SHORT_DESC'), ('TXT_KEY_CIV_TSAB_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_TSAB'), ('PLAYERCOLOR_TSAB'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_TSAB'), 0, ('CIV_ALPHA_ATLAS_TSAB'), ('England'), ('AdultNanohaSelectImage.dds'),
('TXT_KEY_CIV5_DAWN_NANOHA_TEXT'), ('DOM_AdultNanoha.dds')

FROM Civilizations WHERE (Type = 'CIVILIZATION_ENGLAND');

--*******************************************************************
-- Leader
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 			LeaderheadType)
VALUES		('CIVILIZATION_TSAB', 	'LEADER_NANOHA');	


--*******************************************************************
-- Unique Buildings
--*******************************************************************
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 			BuildingClassType, 		BuildingType)
VALUES		('CIVILIZATION_TSAB', 	'BUILDINGCLASS_LIBRARY', 	'BUILDING_INFINITY_LIBRARY');


--*******************************************************************
-- Unique Units
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 		UnitClassType, 				UnitType)
VALUES		('CIVILIZATION_TSAB', 	'UNITCLASS_ARCHAEOLOGIST', 	'UNIT_LOST_LOGIA_TEAM');


--******************************************************************************************************************************************
-- City Names
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 					CityName)
VALUES		('CIVILIZATION_TSAB', 	'TXT_KEY_CITY_NAME_TSAB_0'),
			('CIVILIZATION_TSAB', 	'TXT_KEY_CITY_NAME_TSAB_1'),
			('CIVILIZATION_TSAB', 	'TXT_KEY_CITY_NAME_TSAB_2'),
			('CIVILIZATION_TSAB', 	'TXT_KEY_CITY_NAME_TSAB_3'),
			('CIVILIZATION_TSAB', 	'TXT_KEY_CITY_NAME_TSAB_4'),
			('CIVILIZATION_TSAB', 	'TXT_KEY_CITY_NAME_TSAB_5'),
			('CIVILIZATION_TSAB', 	'TXT_KEY_CITY_NAME_TSAB_6'),
			('CIVILIZATION_TSAB', 	'TXT_KEY_CITY_NAME_TSAB_7'),
			('CIVILIZATION_TSAB', 	'TXT_KEY_CITY_NAME_TSAB_8'),
			('CIVILIZATION_TSAB', 	'TXT_KEY_CITY_NAME_TSAB_9'),
			('CIVILIZATION_TSAB', 	'TXT_KEY_CITY_NAME_TSAB_10'),
			('CIVILIZATION_TSAB', 	'TXT_KEY_CITY_NAME_TSAB_11'),
			('CIVILIZATION_TSAB', 	'TXT_KEY_CITY_NAME_TSAB_12'),
			('CIVILIZATION_TSAB', 	'TXT_KEY_CITY_NAME_TSAB_13'),
			('CIVILIZATION_TSAB', 	'TXT_KEY_CITY_NAME_TSAB_14'),
			('CIVILIZATION_TSAB', 	'TXT_KEY_CITY_NAME_TSAB_15'),
			('CIVILIZATION_TSAB', 	'TXT_KEY_CITY_NAME_TSAB_16'),
			('CIVILIZATION_TSAB', 	'TXT_KEY_CITY_NAME_TSAB_17');

--*******************************************************************
-- Free Buildings
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 					BuildingClassType)
SELECT		('CIVILIZATION_TSAB'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_ENGLAND');

--*******************************************************************
-- Free Techs (O. Madoka gets Archery for free!)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_TSAB'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_ENGLAND');

--*******************************************************************
-- Free Units (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_TSAB'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_ENGLAND');

--******************************************************************************************************************************************
--Religion (taken from Japan, most likely Shinto -- she's not conceited enough to found Church of Madoka if she isn't a deity yet!)
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 			ReligionType)
SELECT		('CIVILIZATION_TSAB'), 	ReligionType
FROM Civilization_Religions WHERE (CivilizationType = 'CIVILIZATION_ENGLAND');

--*******************************************************************
-- Spy Names (generic PMMM spy name list)
--*******************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		
			('CIVILIZATION_TSAB', 	'TXT_KEY_SPY_NAME_TSAB_0'),	
			('CIVILIZATION_TSAB', 	'TXT_KEY_SPY_NAME_TSAB_1'),
			('CIVILIZATION_TSAB', 	'TXT_KEY_SPY_NAME_TSAB_2'),
			('CIVILIZATION_TSAB', 	'TXT_KEY_SPY_NAME_TSAB_3'),
			('CIVILIZATION_TSAB', 	'TXT_KEY_SPY_NAME_TSAB_4'),
			('CIVILIZATION_TSAB', 	'TXT_KEY_SPY_NAME_TSAB_5'),
			('CIVILIZATION_TSAB', 	'TXT_KEY_SPY_NAME_TSAB_6'),
			('CIVILIZATION_TSAB', 	'TXT_KEY_SPY_NAME_TSAB_7'),
			('CIVILIZATION_TSAB', 	'TXT_KEY_SPY_NAME_TSAB_8'),
			('CIVILIZATION_TSAB', 	'TXT_KEY_SPY_NAME_TSAB_9');


