--All SQL Civilization inserts were based off of SQL code from JFD's Civilizations.


--*******************************************************************
-- Ireland (uses The Celts as a baseline)
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage)

SELECT ('CIVILIZATION_IRELAND_FSN'), ('TXT_KEY_CIV_IRELAND_FSN_DESC'), ('TXT_KEY_CIV_IRELAND_FSN_SHORT_DESC'), ('TXT_KEY_CIV_IRELAND_FSN_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_IRELAND_FSN'), ('PLAYERCOLOR_IRELAND_FSN'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_LANCER_FSN'), 0, ('CIV_ALPHA_ATLAS_LANCER_FSN'), ('GREECE'), MapImage,
('TXT_KEY_CIV5_DAWN_LANCER_FSN_TEXT'), ('DOM-Lancer.dds')

FROM Civilizations WHERE (Type = 'CIVILIZATION_CELTS');

--*******************************************************************
-- Leader (Diarmuid Ua Duibhne, aka Lancer)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 				LeaderheadType)
VALUES		('CIVILIZATION_IRELAND_FSN', 	'LEADER_LANCER_FSN');	



--*******************************************************************
-- Unique Units (Fianna)
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 				UnitClassType, 				UnitType)
VALUES		('CIVILIZATION_IRELAND_FSN', 	'UNITCLASS_SWORDSMAN', 		'UNIT_FIANNA_FSN');


--*******************************************************************
-- Unique Buildings (none)
--*******************************************************************



--******************************************************************************************************************************************
-- City Names
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 					CityName)
VALUES		('CIVILIZATION_IRELAND_FSN', 	'TXT_KEY_CITY_NAME_DUBLIN'),
			('CIVILIZATION_IRELAND_FSN', 	'TXT_KEY_CITY_NAME_CORK'),
			('CIVILIZATION_IRELAND_FSN', 	'TXT_KEY_CITY_NAME_LIMERICK'),
			('CIVILIZATION_IRELAND_FSN', 	'TXT_KEY_CITY_NAME_GALWAY'),
			('CIVILIZATION_IRELAND_FSN', 	'TXT_KEY_CITY_NAME_IRELAND_FSN_4'),
			('CIVILIZATION_IRELAND_FSN', 	'TXT_KEY_CITY_NAME_IRELAND_FSN_5'),
			('CIVILIZATION_IRELAND_FSN', 	'TXT_KEY_CITY_NAME_IRELAND_FSN_6'),
			('CIVILIZATION_IRELAND_FSN', 	'TXT_KEY_CITY_NAME_IRELAND_FSN_7'),
			('CIVILIZATION_IRELAND_FSN', 	'TXT_KEY_CITY_NAME_IRELAND_FSN_8'),
			('CIVILIZATION_IRELAND_FSN', 	'TXT_KEY_CITY_NAME_IRELAND_FSN_9'),
			('CIVILIZATION_IRELAND_FSN', 	'TXT_KEY_CITY_NAME_IRELAND_FSN_10'),
			('CIVILIZATION_IRELAND_FSN', 	'TXT_KEY_CITY_NAME_IRELAND_FSN_11'),
			('CIVILIZATION_IRELAND_FSN', 	'TXT_KEY_CITY_NAME_IRELAND_FSN_12'),
			('CIVILIZATION_IRELAND_FSN', 	'TXT_KEY_CITY_NAME_IRELAND_FSN_13'),
			('CIVILIZATION_IRELAND_FSN', 	'TXT_KEY_CITY_NAME_IRELAND_FSN_14'),
			('CIVILIZATION_IRELAND_FSN', 	'TXT_KEY_CITY_NAME_IRELAND_FSN_15'),
			('CIVILIZATION_IRELAND_FSN', 	'TXT_KEY_CITY_NAME_IRELAND_FSN_16'),
			('CIVILIZATION_IRELAND_FSN', 	'TXT_KEY_CITY_NAME_IRELAND_FSN_17'),
			('CIVILIZATION_IRELAND_FSN', 	'TXT_KEY_CITY_NAME_IRELAND_FSN_18'),
			('CIVILIZATION_IRELAND_FSN', 	'TXT_KEY_CITY_NAME_IRELAND_FSN_19'),
			('CIVILIZATION_IRELAND_FSN', 	'TXT_KEY_CITY_NAME_IRELAND_FSN_20');

--*******************************************************************
-- Free Buildings (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 				BuildingClassType)
SELECT		('CIVILIZATION_IRELAND_FSN'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_CELTS');

--*******************************************************************
-- Free Techs (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_IRELAND_FSN'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_CELTS');

--*******************************************************************
-- Free Units (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_IRELAND_FSN'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_CELTS');

--******************************************************************************************************************************************
--Religion (taken from America)
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 							ReligionType)
SELECT		('CIVILIZATION_IRELAND_FSN'),				ReligionType
FROM Civilization_Religions WHERE (CivilizationType = 'CIVILIZATION_CELTS');

--*******************************************************************
-- Spy Names
--*******************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		
			('CIVILIZATION_IRELAND_FSN', 	'TXT_KEY_SPY_NAME_IRELAND_FSN_0'),	
			('CIVILIZATION_IRELAND_FSN', 	'TXT_KEY_SPY_NAME_IRELAND_FSN_1'),
			('CIVILIZATION_IRELAND_FSN', 	'TXT_KEY_SPY_NAME_IRELAND_FSN_2'),
			('CIVILIZATION_IRELAND_FSN', 	'TXT_KEY_SPY_NAME_IRELAND_FSN_3'),
			('CIVILIZATION_IRELAND_FSN', 	'TXT_KEY_SPY_NAME_IRELAND_FSN_4'),
			('CIVILIZATION_IRELAND_FSN', 	'TXT_KEY_SPY_NAME_IRELAND_FSN_5'),
			('CIVILIZATION_IRELAND_FSN', 	'TXT_KEY_SPY_NAME_IRELAND_FSN_6'),
			('CIVILIZATION_IRELAND_FSN', 	'TXT_KEY_SPY_NAME_IRELAND_FSN_7'),
			('CIVILIZATION_IRELAND_FSN', 	'TXT_KEY_SPY_NAME_IRELAND_FSN_8'),
			('CIVILIZATION_IRELAND_FSN', 	'TXT_KEY_SPY_NAME_IRELAND_FSN_9');


--Start bias

INSERT INTO Civilization_Start_Region_Priority
			(CivilizationType,			RegionType)
VALUES		('CIVILIZATION_IRELAND_FSN',	'REGION_FOREST');