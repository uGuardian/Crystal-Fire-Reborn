--All SQL Civilization inserts were based off of SQL code from JFD's Civilizations.


--*******************************************************************
-- Kyouko's Civilization (uses Japan as a baseline)
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage)

SELECT ('CIVILIZATION_KYOUKO'), ('TXT_KEY_CIV_KYOUKO_DESC'), ('TXT_KEY_CIV_KYOUKO_SHORT_DESC'), ('TXT_KEY_CIV_KYOUKO_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_KYOUKO'), ('PLAYERCOLOR_KYOUKO'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_KYOUKO'), 0, ('CIV_ALPHA_ATLAS_KYOUKO'), SoundtrackTag, ('KyoukoSelectImage.dds'),
('TXT_KEY_CIV5_DAWN_KYOUKO_TEXT'), ('DOM_Kyouko.dds')

FROM Civilizations WHERE (Type = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Leader (Kyouko)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 					LeaderheadType)
VALUES		('CIVILIZATION_KYOUKO', 	'LEADER_KYOUKO');	


--*******************************************************************
-- Unique Buildings (Sakura Church)
--*******************************************************************
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 					BuildingClassType, 					BuildingType)
VALUES		('CIVILIZATION_KYOUKO', 	'BUILDINGCLASS_TEMPLE', 	'BUILDING_PMMM_SAKURA_CHURCH');


--*******************************************************************
-- Unique Units (Chain Lancer)
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 					UnitClassType, 			UnitType)
VALUES		('CIVILIZATION_KYOUKO', 	'UNITCLASS_LANCER', 	'UNIT_PMMM_CHAIN_LANCER');


--******************************************************************************************************************************************
-- City Names (naming theme: Capital is Kazamino City, other cities after Japanese snack food/instant ramen manufacturers
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 					CityName)
VALUES		('CIVILIZATION_KYOUKO', 	'TXT_KEY_CITY_NAME_MADOMAGI_KASAMINO'),
			('CIVILIZATION_KYOUKO', 	'TXT_KEY_CITY_NAME_MADOMAGI_LOTTE'),
			('CIVILIZATION_KYOUKO', 	'TXT_KEY_CITY_NAME_MADOMAGI_GLICO'),
			('CIVILIZATION_KYOUKO', 	'TXT_KEY_CITY_NAME_MADOMAGI_MEIJI_SEIKA'),
			('CIVILIZATION_KYOUKO', 	'TXT_KEY_CITY_NAME_MADOMAGI_SAPPORO_KYOUKO'),
			('CIVILIZATION_KYOUKO', 	'TXT_KEY_CITY_NAME_MADOMAGI_ROYCE'),
			('CIVILIZATION_KYOUKO', 	'TXT_KEY_CITY_NAME_MADOMAGI_MORINAGA'),
			('CIVILIZATION_KYOUKO', 	'TXT_KEY_CITY_NAME_MADOMAGI_MARUCHAN'),
			('CIVILIZATION_KYOUKO', 	'TXT_KEY_CITY_NAME_MADOMAGI_NISSIN'),
			('CIVILIZATION_KYOUKO', 	'TXT_KEY_CITY_NAME_MADOMAGI_MIKAKUTO'),
			('CIVILIZATION_KYOUKO', 	'TXT_KEY_CITY_NAME_MADOMAGI_TOHATO'),
			('CIVILIZATION_KYOUKO', 	'TXT_KEY_CITY_NAME_MADOMAGI_KAMEDA_SEIKA'),
			('CIVILIZATION_KYOUKO', 	'TXT_KEY_CITY_NAME_MADOMAGI_KABAYA'),
			('CIVILIZATION_KYOUKO', 	'TXT_KEY_CITY_NAME_MADOMAGI_KURIYAMA_BEIKA'),
			('CIVILIZATION_KYOUKO', 	'TXT_KEY_CITY_NAME_MADOMAGI_TORAYA');
			
INSERT INTO Civilization_CityNames
			(CivilizationType, 					CityName)
SELECT		('CIVILIZATION_KYOUKO'),		Tag
FROM Language_en_US WHERE Tag LIKE ('TXT_KEY_CITY_NAME_KYOUKO_ADDON%');

--*******************************************************************
-- Free Buildings (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 					BuildingClassType)
SELECT		('CIVILIZATION_KYOUKO'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Free Techs (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_KYOUKO'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Free Units (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_KYOUKO'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--********************************************************************************************************************************************************
--Religion (Catholicism -- the most likely type of Christianity to be practiced by a Japanese family. Taken from Portugal for Religious mod compatibility)
--********************************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 					ReligionType)
SELECT		('CIVILIZATION_KYOUKO'), 			ReligionType
FROM Civilization_Religions WHERE (CivilizationType = 'CIVILIZATION_PORTUGAL');

--*******************************************************************
-- Spy Names (generic PMMM spy name list)
--*******************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		
			('CIVILIZATION_KYOUKO', 	'TXT_KEY_SPY_NAME_MADOKA_0'),	
			('CIVILIZATION_KYOUKO', 	'TXT_KEY_SPY_NAME_MADOKA_1'),
			('CIVILIZATION_KYOUKO', 	'TXT_KEY_SPY_NAME_MADOKA_2'),
			('CIVILIZATION_KYOUKO', 	'TXT_KEY_SPY_NAME_MADOKA_3'),
			('CIVILIZATION_KYOUKO', 	'TXT_KEY_SPY_NAME_MADOKA_4'),
			('CIVILIZATION_KYOUKO', 	'TXT_KEY_SPY_NAME_MADOKA_5'),
			('CIVILIZATION_KYOUKO', 	'TXT_KEY_SPY_NAME_MADOKA_6'),
			('CIVILIZATION_KYOUKO', 	'TXT_KEY_SPY_NAME_MADOKA_7'),
			('CIVILIZATION_KYOUKO', 	'TXT_KEY_SPY_NAME_MADOKA_8'),
			('CIVILIZATION_KYOUKO', 	'TXT_KEY_SPY_NAME_MADOKA_9');

