--All SQL Civilization inserts were based off of SQL code from JFD's Civilizations.


--*******************************************************************
-- Classic Homura's Civilization (uses Japan as a baseline)
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage)

SELECT ('CIVILIZATION_HOMURA'), ('TXT_KEY_CIV_HOMURA_DESC'), ('TXT_KEY_CIV_HOMURA_SHORT_DESC'), ('TXT_KEY_CIV_HOMURA_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_HOMURA'), ('PLAYERCOLOR_HOMURA'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_HOMURA'), 0, ('CIV_ALPHA_ATLAS_HOMURA'), SoundtrackTag, ('HomuraSelectImage.dds'),
('TXT_KEY_CIV5_DAWN_HOMURA_TEXT'), ('DOM_Homura.dds')

FROM Civilizations WHERE (Type = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Leader (Original Homura)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 					LeaderheadType)
VALUES		('CIVILIZATION_HOMURA', 	'LEADER_HOMURA');	


--*******************************************************************
-- Unique Buildings (Dimensional Armory)
--*******************************************************************
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 					BuildingClassType, 					BuildingType)
VALUES		('CIVILIZATION_HOMURA', 	'BUILDINGCLASS_MILITARY_ACADEMY', 	'BUILDING_PMMM_DIMENSIONAL_ARMORY');


--*******************************************************************
-- Unique Units (Clockstopper)
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 					UnitClassType, 			UnitType)
VALUES		('CIVILIZATION_HOMURA', 	'UNITCLASS_INFANTRY', 	'UNIT_PMMM_CLOCKSTOPPER');


--******************************************************************************************************************************************
-- City Names (naming theme: Capital is New Mitakihara, other cities after firearm manufacturers
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 					CityName)
VALUES		('CIVILIZATION_HOMURA', 	'TXT_KEY_CITY_NAME_MADOMAGI_NEW_MITAKIHARA'),
			('CIVILIZATION_HOMURA', 	'TXT_KEY_CITY_NAME_MADOMAGI_HECKLER'),
			('CIVILIZATION_HOMURA', 	'TXT_KEY_CITY_NAME_MADOMAGI_BERETTA'),
			('CIVILIZATION_HOMURA', 	'TXT_KEY_CITY_NAME_MADOMAGI_WESSON'),
			('CIVILIZATION_HOMURA', 	'TXT_KEY_CITY_NAME_MADOMAGI_BROWNING'),
			('CIVILIZATION_HOMURA', 	'TXT_KEY_CITY_NAME_MADOMAGI_KALASHNIKOV'),
			('CIVILIZATION_HOMURA', 	'TXT_KEY_CITY_NAME_MADOMAGI_BENELLI'),
			('CIVILIZATION_HOMURA', 	'TXT_KEY_CITY_NAME_MADOMAGI_SAUER'),
			('CIVILIZATION_HOMURA', 	'TXT_KEY_CITY_NAME_MADOMAGI_WALTHER'),
			('CIVILIZATION_HOMURA', 	'TXT_KEY_CITY_NAME_MADOMAGI_STEYR'),
			('CIVILIZATION_HOMURA', 	'TXT_KEY_CITY_NAME_MADOMAGI_TAURUS'),
			('CIVILIZATION_HOMURA', 	'TXT_KEY_CITY_NAME_MADOMAGI_RUGER'),
			('CIVILIZATION_HOMURA', 	'TXT_KEY_CITY_NAME_MADOMAGI_FABRIQUE'),
			('CIVILIZATION_HOMURA', 	'TXT_KEY_CITY_NAME_MADOMAGI_SPRINGFIELD'),
			('CIVILIZATION_HOMURA', 	'TXT_KEY_CITY_NAME_MADOMAGI_GLOCK'),
			('CIVILIZATION_HOMURA', 	'TXT_KEY_CITY_NAME_MADOMAGI_THOMPSON');
			
INSERT INTO Civilization_CityNames
			(CivilizationType, 					CityName)
SELECT		('CIVILIZATION_HOMURA'),		Tag
FROM Language_en_US WHERE Tag LIKE ('TXT_KEY_CITY_NAME_HOMURA_ADDON%');

--*******************************************************************
-- Free Buildings (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 					BuildingClassType)
SELECT		('CIVILIZATION_HOMURA'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Free Techs (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_HOMURA'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Free Units (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_HOMURA'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--******************************************************************************************************************************************
--Religion (Church of Madoka)
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 					ReligionType)
VALUES		('CIVILIZATION_HOMURA',				'RELIGION_CHURCH_OF_MADOKA');

--*******************************************************************
-- Spy Names (generic PMMM spy name list)
--*******************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		
			('CIVILIZATION_HOMURA', 	'TXT_KEY_SPY_NAME_MADOKA_0'),	
			('CIVILIZATION_HOMURA', 	'TXT_KEY_SPY_NAME_MADOKA_1'),
			('CIVILIZATION_HOMURA', 	'TXT_KEY_SPY_NAME_MADOKA_2'),
			('CIVILIZATION_HOMURA', 	'TXT_KEY_SPY_NAME_MADOKA_3'),
			('CIVILIZATION_HOMURA', 	'TXT_KEY_SPY_NAME_MADOKA_4'),
			('CIVILIZATION_HOMURA', 	'TXT_KEY_SPY_NAME_MADOKA_5'),
			('CIVILIZATION_HOMURA', 	'TXT_KEY_SPY_NAME_MADOKA_6'),
			('CIVILIZATION_HOMURA', 	'TXT_KEY_SPY_NAME_MADOKA_7'),
			('CIVILIZATION_HOMURA', 	'TXT_KEY_SPY_NAME_MADOKA_8'),
			('CIVILIZATION_HOMURA', 	'TXT_KEY_SPY_NAME_MADOKA_9');

