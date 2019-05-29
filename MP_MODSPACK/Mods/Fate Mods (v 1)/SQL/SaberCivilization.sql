--All SQL Civilization inserts were based off of SQL code from JFD's Civilizations.


--*******************************************************************
-- Britain (uses England as a baseline)
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage)

SELECT ('CIVILIZATION_BRITAIN_FSN'), ('TXT_KEY_CIV_BRITAIN_FSN_DESC'), ('TXT_KEY_CIV_BRITAIN_FSN_SHORT_DESC'), ('TXT_KEY_CIV_BRITAIN_FSN_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_BRITAIN_FSN'), ('PLAYERCOLOR_BRITAIN_FSN'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_SABER'), 0, ('CIV_ALPHA_ATLAS_SABER'), ('ENGLAND'), MapImage,
('TXT_KEY_CIV5_DAWN_SABER_TEXT'), ('DOM-Saber.dds')

FROM Civilizations WHERE (Type = 'CIVILIZATION_ENGLAND');

--*******************************************************************
-- Leader (Saber/Arturia)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 				LeaderheadType)
VALUES		('CIVILIZATION_BRITAIN_FSN', 	'LEADER_SABER');	



--*******************************************************************
-- Unique Units (Knight of the Round Table)
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 				UnitClassType, 				UnitType)
VALUES		('CIVILIZATION_BRITAIN_FSN', 	'UNITCLASS_GREAT_GENERAL', 	'UNIT_KOTR_FSN');


--*******************************************************************
-- Unique Buildings (Arthurian Court)
--*******************************************************************

INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 				BuildingClassType, 				BuildingType)
VALUES		('CIVILIZATION_BRITAIN_FSN', 	'BUILDINGCLASS_CASTLE', 	'BUILDING_ARTHURIAN_COURT');


--******************************************************************************************************************************************
-- City Names
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 					CityName)
VALUES		('CIVILIZATION_BRITAIN_FSN', 	'TXT_KEY_CITY_NAME_BRITAIN_FSN_1'),
			('CIVILIZATION_BRITAIN_FSN', 	'TXT_KEY_CITY_NAME_BRITAIN_FSN_2'),
			('CIVILIZATION_BRITAIN_FSN', 	'TXT_KEY_CITY_NAME_BRITAIN_FSN_3'),
			('CIVILIZATION_BRITAIN_FSN', 	'TXT_KEY_CITY_NAME_BRITAIN_FSN_4'),
			('CIVILIZATION_BRITAIN_FSN', 	'TXT_KEY_CITY_NAME_BRITAIN_FSN_5'),
			('CIVILIZATION_BRITAIN_FSN', 	'TXT_KEY_CITY_NAME_BRITAIN_FSN_6'),
			('CIVILIZATION_BRITAIN_FSN', 	'TXT_KEY_CITY_NAME_BRITAIN_FSN_7'),
			('CIVILIZATION_BRITAIN_FSN', 	'TXT_KEY_CITY_NAME_BRITAIN_FSN_8'),
			('CIVILIZATION_BRITAIN_FSN', 	'TXT_KEY_CITY_NAME_BRITAIN_FSN_9'),
			('CIVILIZATION_BRITAIN_FSN', 	'TXT_KEY_CITY_NAME_BRITAIN_FSN_10'),
			('CIVILIZATION_BRITAIN_FSN', 	'TXT_KEY_CITY_NAME_BRITAIN_FSN_11'),
			('CIVILIZATION_BRITAIN_FSN', 	'TXT_KEY_CITY_NAME_BRITAIN_FSN_12'),
			('CIVILIZATION_BRITAIN_FSN', 	'TXT_KEY_CITY_NAME_BRITAIN_FSN_13'),
			('CIVILIZATION_BRITAIN_FSN', 	'TXT_KEY_CITY_NAME_BRITAIN_FSN_14'),
			('CIVILIZATION_BRITAIN_FSN', 	'TXT_KEY_CITY_NAME_BRITAIN_FSN_15'),
			('CIVILIZATION_BRITAIN_FSN', 	'TXT_KEY_CITY_NAME_BRITAIN_FSN_16'),
			('CIVILIZATION_BRITAIN_FSN', 	'TXT_KEY_CITY_NAME_BRITAIN_FSN_17'),
			('CIVILIZATION_BRITAIN_FSN', 	'TXT_KEY_CITY_NAME_BRITAIN_FSN_18'),
			('CIVILIZATION_BRITAIN_FSN', 	'TXT_KEY_CITY_NAME_BRITAIN_FSN_19');

--*******************************************************************
-- Free Buildings (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 				BuildingClassType)
SELECT		('CIVILIZATION_BRITAIN_FSN'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_ENGLAND');

--*******************************************************************
-- Free Techs (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_BRITAIN_FSN'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_ENGLAND');

--*******************************************************************
-- Free Units (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_BRITAIN_FSN'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_ENGLAND');

--******************************************************************************************************************************************
--Religion (taken from America)
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 									ReligionType)
SELECT		('CIVILIZATION_BRITAIN_FSN'),				ReligionType
FROM Civilization_Religions WHERE (CivilizationType = 'CIVILIZATION_ENGLAND');

--*******************************************************************
-- Spy Names
--*******************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		
			('CIVILIZATION_BRITAIN_FSN', 	'TXT_KEY_SPY_NAME_BRITAIN_FSN_0'),	
			('CIVILIZATION_BRITAIN_FSN', 	'TXT_KEY_SPY_NAME_BRITAIN_FSN_1'),
			('CIVILIZATION_BRITAIN_FSN', 	'TXT_KEY_SPY_NAME_BRITAIN_FSN_2'),
			('CIVILIZATION_BRITAIN_FSN', 	'TXT_KEY_SPY_NAME_BRITAIN_FSN_3'),
			('CIVILIZATION_BRITAIN_FSN', 	'TXT_KEY_SPY_NAME_BRITAIN_FSN_4'),
			('CIVILIZATION_BRITAIN_FSN', 	'TXT_KEY_SPY_NAME_BRITAIN_FSN_5'),
			('CIVILIZATION_BRITAIN_FSN', 	'TXT_KEY_SPY_NAME_BRITAIN_FSN_6'),
			('CIVILIZATION_BRITAIN_FSN', 	'TXT_KEY_SPY_NAME_BRITAIN_FSN_7'),
			('CIVILIZATION_BRITAIN_FSN', 	'TXT_KEY_SPY_NAME_BRITAIN_FSN_8'),
			('CIVILIZATION_BRITAIN_FSN', 	'TXT_KEY_SPY_NAME_BRITAIN_FSN_9');


--Start along Ocean for flavor (not necessarily balance)

INSERT INTO Civilization_Start_Along_Ocean
			(CivilizationType,			StartAlongOcean)
VALUES		('CIVILIZATION_BRITAIN_FSN',1);
