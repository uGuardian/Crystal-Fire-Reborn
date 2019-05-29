--All SQL Civilization inserts were based off of SQL code from JFD's Civilizations.


INSERT INTO Colors
			(Type,									Red,	Green,	Blue,	Alpha)
VALUES
			('COLOR_PLAYER_PASTALIA_ICON',			1.0,	1.0,	1.0,	1.0),
			('COLOR_PLAYER_PASTALIA_BACKGROUND',	0.5,	0.0,	0.0,	1.0);


INSERT INTO PlayerColors
			(Type,									PrimaryColor,						SecondaryColor,						TextColor)
VALUES		('PLAYERCOLOR_PASTALIA',				'COLOR_PLAYER_PASTALIA_ICON',		'COLOR_PLAYER_PASTALIA_BACKGROUND',	'COLOR_PLAYER_WHITE_TEXT');

--*******************************************************************
-- Civilization
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage, DawnOfManAudio,
DawnOfManQuote,	DawnOfManImage)

SELECT ('CIVILIZATION_PASTALIA'), ('TXT_KEY_CIV_PASTALIA_DESC'), ('TXT_KEY_CIV_PASTALIA_SHORT_DESC'), ('TXT_KEY_CIV_PASTALIA_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_PASTALIA'), ('PLAYERCOLOR_PASTALIA'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_CLOCHE'), 0, ('CLOCHE_CIV_ALPHA_ATLAS'), ('ARTONELICO'), ('ArTonelicoMap.dds'),('AS2D_DOM_SPEECH_PASTALIAN'),
('TXT_KEY_CIV5_DAWN_CLOCHE_TEXT'), ('ClocheDOM.dds')

FROM Civilizations WHERE (Type = 'CIVILIZATION_AUSTRIA');

--*******************************************************************
-- Leader
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 			LeaderheadType)
VALUES		('CIVILIZATION_PASTALIA', 	'LEADER_CLOCHE');	


--*******************************************************************
-- Unique Buildings
--*******************************************************************
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 			BuildingClassType, 							BuildingType)
VALUES		('CIVILIZATION_PASTALIA', 	'BUILDINGCLASS_SHRINE', 	        'BUILDING_SPEECH_HALL'),
            ('CIVILIZATION_PASTALIA', 	'BUILDINGCLASS_CIRCUS_MAXIMUS', 	      'BUILDING_CIRCUS_MAXIMUS_PASTALIA'),
            ('CIVILIZATION_PASTALIA', 	'BUILDINGCLASS_CATHEDRAL', 	              'BUILDING_CATHEDRAL_PASTALIA'),
			('CIVILIZATION_PASTALIA', 	'BUILDINGCLASS_TEMPLE', 				'BUILDING_TEMPLE_PASTALIA'),
			('CIVILIZATION_PASTALIA', 	'BUILDINGCLASS_MOSQUE', 					'BUILDING_MOSQUE_PASTALIA'),
			('CIVILIZATION_PASTALIA', 	'BUILDINGCLASS_PAGODA', 				'BUILDING_PAGODA_PASTALIA'),
			('CIVILIZATION_PASTALIA', 	'BUILDINGCLASS_MONASTERY', 				'BUILDING_MONASTERY_PASTALIA'),
			('CIVILIZATION_PASTALIA', 	'BUILDINGCLASS_GRAND_TEMPLE', 				'BUILDING_GRAND_TEMPLE_PASTALIA');


--*******************************************************************
-- Unique Units
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 			UnitClassType, 			UnitType)
VALUES		('CIVILIZATION_PASTALIA', 	'UNITCLASS_RIFLEMAN', 	'UNIT_PASTALIAN_GRAND_BELL_KNIGHT');


--*******************************************************************************
-- City Names
--*******************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 					CityName)
VALUES		('CIVILIZATION_PASTALIA', 	'TXT_KEY_CITY_NAME_PASTALIA_1'),
			('CIVILIZATION_PASTALIA', 	'TXT_KEY_CITY_NAME_PASTALIA_2'),
			('CIVILIZATION_PASTALIA', 	'TXT_KEY_CITY_NAME_PASTALIA_3'),
			('CIVILIZATION_PASTALIA', 	'TXT_KEY_CITY_NAME_PASTALIA_4'),
			('CIVILIZATION_PASTALIA', 	'TXT_KEY_CITY_NAME_PASTALIA_5'),
			('CIVILIZATION_PASTALIA', 	'TXT_KEY_CITY_NAME_PASTALIA_6'),
			('CIVILIZATION_PASTALIA', 	'TXT_KEY_CITY_NAME_PASTALIA_7'),
			('CIVILIZATION_PASTALIA', 	'TXT_KEY_CITY_NAME_PASTALIA_8'),
			('CIVILIZATION_PASTALIA', 	'TXT_KEY_CITY_NAME_PASTALIA_9'),
			('CIVILIZATION_PASTALIA', 	'TXT_KEY_CITY_NAME_PASTALIA_10'),
			('CIVILIZATION_PASTALIA', 	'TXT_KEY_CITY_NAME_PASTALIA_11'),
			('CIVILIZATION_PASTALIA', 	'TXT_KEY_CITY_NAME_PASTALIA_12'),
			('CIVILIZATION_PASTALIA', 	'TXT_KEY_CITY_NAME_PASTALIA_13'),
			('CIVILIZATION_PASTALIA', 	'TXT_KEY_CITY_NAME_PASTALIA_14'),
			('CIVILIZATION_PASTALIA', 	'TXT_KEY_CITY_NAME_PASTALIA_15'),
			('CIVILIZATION_PASTALIA', 	'TXT_KEY_CITY_NAME_PASTALIA_16'),
			('CIVILIZATION_PASTALIA', 	'TXT_KEY_CITY_NAME_PASTALIA_17'),
			('CIVILIZATION_PASTALIA', 	'TXT_KEY_CITY_NAME_PASTALIA_18'),
			('CIVILIZATION_PASTALIA', 	'TXT_KEY_CITY_NAME_PASTALIA_19'),
			('CIVILIZATION_PASTALIA', 	'TXT_KEY_CITY_NAME_PASTALIA_20'),
			('CIVILIZATION_PASTALIA', 	'TXT_KEY_CITY_NAME_PASTALIA_21'),
			('CIVILIZATION_PASTALIA', 	'TXT_KEY_CITY_NAME_PASTALIA_22'),
			('CIVILIZATION_PASTALIA', 	'TXT_KEY_CITY_NAME_PASTALIA_23'),
			('CIVILIZATION_PASTALIA', 	'TXT_KEY_CITY_NAME_PASTALIA_24'),
			('CIVILIZATION_PASTALIA', 	'TXT_KEY_CITY_NAME_PASTALIA_25'),
			('CIVILIZATION_PASTALIA', 	'TXT_KEY_CITY_NAME_PASTALIA_26'),
			('CIVILIZATION_PASTALIA', 	'TXT_KEY_CITY_NAME_PASTALIA_27'),
			('CIVILIZATION_PASTALIA', 	'TXT_KEY_CITY_NAME_PASTALIA_28'),
			('CIVILIZATION_PASTALIA', 	'TXT_KEY_CITY_NAME_PASTALIA_29'),
			('CIVILIZATION_PASTALIA', 	'TXT_KEY_CITY_NAME_PASTALIA_30'),
			('CIVILIZATION_PASTALIA', 	'TXT_KEY_CITY_NAME_PASTALIA_31'),
			('CIVILIZATION_PASTALIA', 	'TXT_KEY_CITY_NAME_PASTALIA_32'),
			('CIVILIZATION_PASTALIA', 	'TXT_KEY_CITY_NAME_PASTALIA_33'),
			('CIVILIZATION_PASTALIA', 	'TXT_KEY_CITY_NAME_PASTALIA_34'),
			('CIVILIZATION_PASTALIA', 	'TXT_KEY_CITY_NAME_PASTALIA_35');

--*******************************************************************
-- Free Buildings
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 					BuildingClassType)
SELECT		('CIVILIZATION_PASTALIA'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_AUSTRIA');

--*******************************************************************
-- Free Techs 
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_PASTALIA'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_AUSTRIA');

--*******************************************************************
-- Free Units (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_PASTALIA'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_AUSTRIA');

--*********************************************************************
--Religion 
--*********************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 			ReligionType)
SELECT		('CIVILIZATION_PASTALIA'), 	ReligionType
FROM Civilization_Religions WHERE (CivilizationType = 'CIVILIZATION_AUSTRIA');

--*******************************************************************
-- Spy Names (generic PMMM spy name list)
--*******************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		
			('CIVILIZATION_PASTALIA', 	'TXT_KEY_SPY_NAME_PASTALIA_0'),	
			('CIVILIZATION_PASTALIA', 	'TXT_KEY_SPY_NAME_PASTALIA_1'),
			('CIVILIZATION_PASTALIA', 	'TXT_KEY_SPY_NAME_PASTALIA_2'),
			('CIVILIZATION_PASTALIA', 	'TXT_KEY_SPY_NAME_PASTALIA_3'),
			('CIVILIZATION_PASTALIA', 	'TXT_KEY_SPY_NAME_PASTALIA_4'),
			('CIVILIZATION_PASTALIA', 	'TXT_KEY_SPY_NAME_PASTALIA_5'),
			('CIVILIZATION_PASTALIA', 	'TXT_KEY_SPY_NAME_PASTALIA_6'),
			('CIVILIZATION_PASTALIA', 	'TXT_KEY_SPY_NAME_PASTALIA_7'),
			('CIVILIZATION_PASTALIA', 	'TXT_KEY_SPY_NAME_PASTALIA_8'),
			('CIVILIZATION_PASTALIA', 	'TXT_KEY_SPY_NAME_PASTALIA_9');



----Start priorities

INSERT INTO Civilization_Start_Region_Priority
			(CivilizationType,			RegionType)
VALUES		('CIVILIZATION_PASTALIA',	'REGION_HILLS');

INSERT INTO Civilization_Start_Along_River
			(CivilizationType,			StartAlongRiver)
VALUES		('CIVILIZATION_PASTALIA',	1);