--All SQL Civilization inserts were based off of SQL code from JFD's Civilizations.


--*******************************************************************
-- Ultimate Madoka's Civilization (uses Assyria as a baseline)
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage)

SELECT ('CIVILIZATION_MADOKA'), ('TXT_KEY_CIV_MADOKA_DESC'), ('TXT_KEY_CIV_MADOKA_SHORT_DESC'), ('TXT_KEY_CIV_MADOKA_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_MADOKA'), ('PLAYERCOLOR_MADOKA'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_MADOKA_TEMP'), 0, ('CIV_ALPHA_ATLAS_MADOKA'), SoundtrackTag, ('MadokaSelectImage.dds'),
('TXT_KEY_CIV5_DAWN_MADOKA_TEXT'), ('DOM_Madoka.dds')

FROM Civilizations WHERE (Type = 'CIVILIZATION_ASSYRIA');

--*******************************************************************
-- Leader (Ultimate Madoka)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 					LeaderheadType)
VALUES		('CIVILIZATION_MADOKA', 	'LEADER_MADOKA');	


--*******************************************************************
-- Unique Buildings (Luminous Garden)
--*******************************************************************
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 					BuildingClassType, 					BuildingType)
VALUES		('CIVILIZATION_MADOKA', 	'BUILDINGCLASS_GARDEN', 	'BUILDING_PMMM_LUMINOUS_GARDEN');


--*******************************************************************
-- Unique Units (Herald of Madoka)
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 					UnitClassType, 			UnitType)
VALUES		('CIVILIZATION_MADOKA', 	'UNITCLASS_MISSIONARY', 	'UNIT_PMMM_HERALD_OF_MADOKA');


--******************************************************************************************************************************************
-- City Names (naming theme: Capital is Madoka's Dimension, other cities after Witches
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 					CityName)
VALUES		('CIVILIZATION_MADOKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_MADOKAS_REALM'),
			('CIVILIZATION_MADOKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_GERTRUD'),
			('CIVILIZATION_MADOKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_ELSA_MARIA'),
			('CIVILIZATION_MADOKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_ELLY'),
			('CIVILIZATION_MADOKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_ALBERTINE'),
			('CIVILIZATION_MADOKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_GISELA'),
			('CIVILIZATION_MADOKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_UHRMANN'),
			('CIVILIZATION_MADOKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_IZABEL'),
			('CIVILIZATION_MADOKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_QUITTERIE'),
			('CIVILIZATION_MADOKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_ITZLI'),
			('CIVILIZATION_MADOKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_NIE_BLUEHEN_HERZEN'),
			('CIVILIZATION_MADOKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_ROSASHARN'),
			('CIVILIZATION_MADOKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_CECIL'),
			('CIVILIZATION_MADOKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_VIRGINIA'),
			('CIVILIZATION_MADOKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_STACY'),
			('CIVILIZATION_MADOKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_MARGOT');
			
INSERT INTO Civilization_CityNames
			(CivilizationType, 					CityName)
SELECT		('CIVILIZATION_MADOKA'),		Tag
FROM Language_en_US WHERE Tag LIKE ('TXT_KEY_CITY_NAME_MADOKA_ADDON%');

--*******************************************************************
-- Free Buildings (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 					BuildingClassType)
SELECT		('CIVILIZATION_MADOKA'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_ASSYRIA');

--*******************************************************************
-- Free Techs (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_MADOKA'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_ASSYRIA');

--*******************************************************************
-- Free Units (Archer)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_MADOKA'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_ASSYRIA');

INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 		UnitClassType,		Count,	UnitAIType)
VALUES		('CIVILIZATION_MADOKA',	'UNITCLASS_ARCHER',	1,		'UNITAI_RANGED');

--******************************************************************************************************************************************
--Religion (Church of Madoka)
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 					ReligionType)
VALUES		('CIVILIZATION_MADOKA', 	'RELIGION_CHURCH_OF_MADOKA');

--*******************************************************************
-- Spy Names (generic PMMM spy name list)
--*******************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		
			('CIVILIZATION_MADOKA', 	'TXT_KEY_SPY_NAME_MADOKA_0'),	
			('CIVILIZATION_MADOKA', 	'TXT_KEY_SPY_NAME_MADOKA_1'),
			('CIVILIZATION_MADOKA', 	'TXT_KEY_SPY_NAME_MADOKA_2'),
			('CIVILIZATION_MADOKA', 	'TXT_KEY_SPY_NAME_MADOKA_3'),
			('CIVILIZATION_MADOKA', 	'TXT_KEY_SPY_NAME_MADOKA_4'),
			('CIVILIZATION_MADOKA', 	'TXT_KEY_SPY_NAME_MADOKA_5'),
			('CIVILIZATION_MADOKA', 	'TXT_KEY_SPY_NAME_MADOKA_6'),
			('CIVILIZATION_MADOKA', 	'TXT_KEY_SPY_NAME_MADOKA_7'),
			('CIVILIZATION_MADOKA', 	'TXT_KEY_SPY_NAME_MADOKA_8'),
			('CIVILIZATION_MADOKA', 	'TXT_KEY_SPY_NAME_MADOKA_9');


