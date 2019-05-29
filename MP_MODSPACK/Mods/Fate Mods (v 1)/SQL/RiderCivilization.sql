--All SQL Civilization inserts were based off of SQL code from JFD's Civilizations.


--*******************************************************************
-- Macedon (uses Greece as a baseline)
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage)

SELECT ('CIVILIZATION_MACEDON_FSN'), ('TXT_KEY_CIV_MACEDON_FSN_DESC'), ('TXT_KEY_CIV_MACEDON_FSN_SHORT_DESC'), ('TXT_KEY_CIV_MACEDON_FSN_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_MACEDON_FSN'), ('PLAYERCOLOR_MACEDON_FSN'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_RIDER_FSN'), 0, ('CIV_ALPHA_ATLAS_RIDER_FSN'), ('GREECE'), MapImage,
('TXT_KEY_CIV5_DAWN_RIDER_FSN_TEXT'), ('DOM-Rider.dds')

FROM Civilizations WHERE (Type = 'CIVILIZATION_GREECE');

--*******************************************************************
-- Leader (Iskandar, aka Alexander the Great, aka Rider)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 				LeaderheadType)
VALUES		('CIVILIZATION_MACEDON_FSN', 	'LEADER_RIDER_FSN');	



--*******************************************************************
-- Unique Units (Gordius Wheel, Somatophylax)
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 				UnitClassType, 				UnitType)
VALUES		('CIVILIZATION_MACEDON_FSN', 	'UNITCLASS_HORSEMAN', 		'UNIT_GORDIUS_WHEEL_FSN'),
			('CIVILIZATION_MACEDON_FSN', 	'UNITCLASS_GREAT_GENERAL', 	'UNIT_SOMATOPHYLAX_FSN');


--*******************************************************************
-- Unique Buildings (none)
--*******************************************************************



--******************************************************************************************************************************************
-- City Names
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 					CityName)
VALUES		('CIVILIZATION_MACEDON_FSN', 	'TXT_KEY_CITY_NAME_PELLA'),
			('CIVILIZATION_MACEDON_FSN', 	'TXT_KEY_CITY_NAME_MACEDON_FSN_1'),
			('CIVILIZATION_MACEDON_FSN', 	'TXT_KEY_CITY_NAME_MACEDON_FSN_2'),
			('CIVILIZATION_MACEDON_FSN', 	'TXT_KEY_CITY_NAME_MACEDON_FSN_3'),
			('CIVILIZATION_MACEDON_FSN', 	'TXT_KEY_CITY_NAME_MACEDON_FSN_4'),
			('CIVILIZATION_MACEDON_FSN', 	'TXT_KEY_CITY_NAME_MACEDON_FSN_5'),
			('CIVILIZATION_MACEDON_FSN', 	'TXT_KEY_CITY_NAME_MACEDON_FSN_6'),
			('CIVILIZATION_MACEDON_FSN', 	'TXT_KEY_CITY_NAME_APOLLONIA'),
			('CIVILIZATION_MACEDON_FSN', 	'TXT_KEY_CITY_NAME_MACEDON_FSN_7'),
			('CIVILIZATION_MACEDON_FSN', 	'TXT_KEY_CITY_NAME_MACEDON_FSN_8'),
			('CIVILIZATION_MACEDON_FSN', 	'TXT_KEY_CITY_NAME_HERALKLEIA'),
			('CIVILIZATION_MACEDON_FSN', 	'TXT_KEY_CITY_NAME_MACEDON_FSN_9'),
			('CIVILIZATION_MACEDON_FSN', 	'TXT_KEY_CITY_NAME_MACEDON_FSN_10'),
			('CIVILIZATION_MACEDON_FSN', 	'TXT_KEY_CITY_NAME_MACEDON_FSN_11'),
			('CIVILIZATION_MACEDON_FSN', 	'TXT_KEY_CITY_NAME_MACEDON_FSN_12'),
			('CIVILIZATION_MACEDON_FSN', 	'TXT_KEY_CITY_NAME_MACEDON_FSN_13'),
			('CIVILIZATION_MACEDON_FSN', 	'TXT_KEY_CITY_NAME_HALICARNASSUS'),
			('CIVILIZATION_MACEDON_FSN', 	'TXT_KEY_CITY_NAME_MACEDON_FSN_14'),
			('CIVILIZATION_MACEDON_FSN', 	'TXT_KEY_CITY_NAME_MACEDON_FSN_15'),
			('CIVILIZATION_MACEDON_FSN', 	'TXT_KEY_CITY_NAME_MACEDON_FSN_16'),
			('CIVILIZATION_MACEDON_FSN', 	'TXT_KEY_CITY_NAME_GORDION'),
			('CIVILIZATION_MACEDON_FSN', 	'TXT_KEY_CITY_NAME_MILETOS'),
			('CIVILIZATION_MACEDON_FSN', 	'TXT_KEY_CITY_NAME_MACEDON_FSN_17'),
			('CIVILIZATION_MACEDON_FSN', 	'TXT_KEY_CITY_NAME_MACEDON_FSN_18'),
			('CIVILIZATION_MACEDON_FSN', 	'TXT_KEY_CITY_NAME_MACEDON_FSN_19'),
			('CIVILIZATION_MACEDON_FSN', 	'TXT_KEY_CITY_NAME_MACEDON_FSN_20'),
			('CIVILIZATION_MACEDON_FSN', 	'TXT_KEY_CITY_NAME_MACEDON_FSN_21'),
			('CIVILIZATION_MACEDON_FSN', 	'TXT_KEY_CITY_NAME_MACEDON_FSN_22');

--*******************************************************************
-- Free Buildings (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 				BuildingClassType)
SELECT		('CIVILIZATION_MACEDON_FSN'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_GREECE');

--*******************************************************************
-- Free Techs (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_MACEDON_FSN'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_GREECE');

--*******************************************************************
-- Free Units (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_MACEDON_FSN'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_GREECE');

--******************************************************************************************************************************************
--Religion (taken from America)
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 							ReligionType)
SELECT		('CIVILIZATION_MACEDON_FSN'),				ReligionType
FROM Civilization_Religions WHERE (CivilizationType = 'CIVILIZATION_GREECE');

--*******************************************************************
-- Spy Names
--*******************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		
			('CIVILIZATION_MACEDON_FSN', 	'TXT_KEY_SPY_NAME_MACEDON_FSN_0'),	
			('CIVILIZATION_MACEDON_FSN', 	'TXT_KEY_SPY_NAME_MACEDON_FSN_1'),
			('CIVILIZATION_MACEDON_FSN', 	'TXT_KEY_SPY_NAME_MACEDON_FSN_2'),
			('CIVILIZATION_MACEDON_FSN', 	'TXT_KEY_SPY_NAME_MACEDON_FSN_3'),
			('CIVILIZATION_MACEDON_FSN', 	'TXT_KEY_SPY_NAME_MACEDON_FSN_4'),
			('CIVILIZATION_MACEDON_FSN', 	'TXT_KEY_SPY_NAME_MACEDON_FSN_5'),
			('CIVILIZATION_MACEDON_FSN', 	'TXT_KEY_SPY_NAME_MACEDON_FSN_6'),
			('CIVILIZATION_MACEDON_FSN', 	'TXT_KEY_SPY_NAME_MACEDON_FSN_7'),
			('CIVILIZATION_MACEDON_FSN', 	'TXT_KEY_SPY_NAME_MACEDON_FSN_8'),
			('CIVILIZATION_MACEDON_FSN', 	'TXT_KEY_SPY_NAME_MACEDON_FSN_9');


--Start bias (Desert River)

INSERT INTO Civilization_Start_Along_Ocean
			(CivilizationType,			StartAlongOcean)
VALUES		('CIVILIZATION_MACEDON_FSN',	1);