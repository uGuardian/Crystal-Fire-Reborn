--All SQL Civilization inserts were based off of SQL code from JFD's Civilizations.


--*******************************************************************
-- Nemesis Army (uses Germany as a baseline)
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage)

SELECT ('CIVILIZATION_NEMESIS'), ('TXT_KEY_CIV_NEMESIS_DESC'), ('TXT_KEY_CIV_NEMESIS_SHORT_DESC'), ('TXT_KEY_CIV_NEMESIS_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_NEMESIS'), ('PLAYERCOLOR_NEMESIS'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_NEMESIS'), 0, ('CIV_ALPHA_ATLAS_NEMESIS'), ('GERMANY'), ('StatesmanSelectImage.dds'),
('TXT_KEY_CIV5_DAWN_NEMESIS_TEXT'), ('DOM-Nemesis.dds')

FROM Civilizations WHERE (Type = 'CIVILIZATION_GERMANY');

--*******************************************************************
-- Leader (Nagisa)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 			LeaderheadType)
VALUES		('CIVILIZATION_NEMESIS', 	'LEADER_NEMESIS');	


--*******************************************************************
-- Unique Buildings (Steam Plant, which replaces both Nuclear and Solar Plants)
--*******************************************************************
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 			BuildingClassType, 				BuildingType)
VALUES		('CIVILIZATION_NEMESIS', 	'BUILDINGCLASS_SOLAR_PLANT', 	'BUILDING_STEAM_PLANT'),
			('CIVILIZATION_NEMESIS', 	'BUILDINGCLASS_NUCLEAR_PLANT');


--*******************************************************************
-- Unique Units (Armiger Surgeon)
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 			UnitClassType, 			UnitType)
VALUES		('CIVILIZATION_NEMESIS', 	'UNITCLASS_RIFLEMAN', 	'UNIT_ARMIGER_SURGEON');


--******************************************************************************************************************************************
-- City Names (a whole bunch of cities named after himself)
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 			CityName)
VALUES		('CIVILIZATION_NEMESIS', 	'TXT_KEY_CITY_NAME_NEMESIS_1'),
			('CIVILIZATION_NEMESIS', 	'TXT_KEY_CITY_NAME_NEMESIS_2'),
			('CIVILIZATION_NEMESIS', 	'TXT_KEY_CITY_NAME_NEMESIS_3'),
			('CIVILIZATION_NEMESIS', 	'TXT_KEY_CITY_NAME_NEMESIS_4'),
			('CIVILIZATION_NEMESIS', 	'TXT_KEY_CITY_NAME_NEMESIS_5'),
			('CIVILIZATION_NEMESIS', 	'TXT_KEY_CITY_NAME_NEMESIS_6'),
			('CIVILIZATION_NEMESIS', 	'TXT_KEY_CITY_NAME_NEMESIS_7'),
			('CIVILIZATION_NEMESIS', 	'TXT_KEY_CITY_NAME_NEMESIS_8'),
			('CIVILIZATION_NEMESIS', 	'TXT_KEY_CITY_NAME_NEMESIS_9'),
			('CIVILIZATION_NEMESIS', 	'TXT_KEY_CITY_NAME_NEMESIS_10'),
			('CIVILIZATION_NEMESIS', 	'TXT_KEY_CITY_NAME_NEMESIS_11'),
			('CIVILIZATION_NEMESIS', 	'TXT_KEY_CITY_NAME_NEMESIS_12'),
			('CIVILIZATION_NEMESIS', 	'TXT_KEY_CITY_NAME_NEMESIS_13'),
			('CIVILIZATION_NEMESIS', 	'TXT_KEY_CITY_NAME_NEMESIS_14'),
			('CIVILIZATION_NEMESIS', 	'TXT_KEY_CITY_NAME_NEMESIS_15'),
			('CIVILIZATION_NEMESIS', 	'TXT_KEY_CITY_NAME_NEMESIS_16'),
			('CIVILIZATION_NEMESIS', 	'TXT_KEY_CITY_NAME_NEMESIS_17'),
			('CIVILIZATION_NEMESIS', 	'TXT_KEY_CITY_NAME_NEMESIS_18');

--*******************************************************************
-- Free Buildings (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 					BuildingClassType)
SELECT		('CIVILIZATION_NEMESIS'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_GERMANY');

--*******************************************************************
-- Free Techs (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_NEMESIS'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_GERMANY');

--*******************************************************************
-- Free Units (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_NEMESIS'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_GERMANY');

--******************************************************************************************************************************************
--Religion
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 				ReligionType)
SELECT		('CIVILIZATION_NEMESIS'), 	ReligionType
FROM Civilization_Religions WHERE (CivilizationType = 'CIVILIZATION_ROME');

--*******************************************************************
-- Spy Names
--*******************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		
			('CIVILIZATION_NEMESIS', 	'TXT_KEY_SPY_NAME_NEMESIS_0'),	
			('CIVILIZATION_NEMESIS', 	'TXT_KEY_SPY_NAME_NEMESIS_1'),
			('CIVILIZATION_NEMESIS', 	'TXT_KEY_SPY_NAME_NEMESIS_2'),
			('CIVILIZATION_NEMESIS', 	'TXT_KEY_SPY_NAME_NEMESIS_3'),
			('CIVILIZATION_NEMESIS', 	'TXT_KEY_SPY_NAME_NEMESIS_4'),
			('CIVILIZATION_NEMESIS', 	'TXT_KEY_SPY_NAME_NEMESIS_5'),
			('CIVILIZATION_NEMESIS', 	'TXT_KEY_SPY_NAME_NEMESIS_6'),
			('CIVILIZATION_NEMESIS', 	'TXT_KEY_SPY_NAME_NEMESIS_7'),
			('CIVILIZATION_NEMESIS', 	'TXT_KEY_SPY_NAME_NEMESIS_8'),
			('CIVILIZATION_NEMESIS', 	'TXT_KEY_SPY_NAME_NEMESIS_9');
