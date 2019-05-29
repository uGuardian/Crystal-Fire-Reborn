--All SQL Civilization inserts were based off of SQL code from JFD's Civilizations.


--*******************************************************************
-- Outer Heaven (uses America as a baseline)
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage)

SELECT ('CIVILIZATION_OUTER_HEAVEN'), ('TXT_KEY_CIV_OUTER_HEAVEN_DESC'), ('TXT_KEY_CIV_OUTER_HEAVEN_SHORT_DESC'), ('TXT_KEY_CIV_OUTER_HEAVEN_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_OUTER_HEAVEN'), ('PLAYERCOLOR_OUTER_HEAVEN'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_OCELOT'), 0, ('CIV_ALPHA_ATLAS_OCELOT'), ('AMERICA'), ('OcelotSelectImage.dds'),
('TXT_KEY_CIV5_DAWN_OUTER_HEAVEN_TEXT'), ('DOM-Ocelot.dds')

FROM Civilizations WHERE (Type = 'CIVILIZATION_AMERICA');

--*******************************************************************
-- Leader (Ocelot)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 						LeaderheadType)
VALUES		('CIVILIZATION_OUTER_HEAVEN', 	'LEADER_OCELOT');	



--*******************************************************************
-- Unique Units (Haven Trooper, PMC Incorporator)
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 				UnitClassType, 				UnitType)
VALUES		('CIVILIZATION_OUTER_HEAVEN', 	'UNITCLASS_XCOM_SQUAD', 	'UNIT_HAVEN_TROOPER'),
			('CIVILIZATION_OUTER_HEAVEN', 	'UNITCLASS_GREAT_GENERAL', 	'UNIT_PMC_INCORPORATOR');


--******************************************************************************************************************************************
-- City Names (naming theme: Capital is Stilwater, second city is Steelport, the other names are after individual neighborhoods within them.
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 					CityName)
VALUES		('CIVILIZATION_OUTER_HEAVEN', 	'TXT_KEY_CITY_NAME_OUTER_HEAVEN_1'),
			('CIVILIZATION_OUTER_HEAVEN', 	'TXT_KEY_CITY_NAME_OUTER_HEAVEN_2'),
			('CIVILIZATION_OUTER_HEAVEN', 	'TXT_KEY_CITY_NAME_OUTER_HEAVEN_3'),
			('CIVILIZATION_OUTER_HEAVEN', 	'TXT_KEY_CITY_NAME_OUTER_HEAVEN_4'),
			('CIVILIZATION_OUTER_HEAVEN', 	'TXT_KEY_CITY_NAME_OUTER_HEAVEN_5'),
			('CIVILIZATION_OUTER_HEAVEN', 	'TXT_KEY_CITY_NAME_OUTER_HEAVEN_6'),
			('CIVILIZATION_OUTER_HEAVEN', 	'TXT_KEY_CITY_NAME_OUTER_HEAVEN_7'),
			('CIVILIZATION_OUTER_HEAVEN', 	'TXT_KEY_CITY_NAME_OUTER_HEAVEN_8'),
			('CIVILIZATION_OUTER_HEAVEN', 	'TXT_KEY_CITY_NAME_OUTER_HEAVEN_9'),
			('CIVILIZATION_OUTER_HEAVEN', 	'TXT_KEY_CITY_NAME_OUTER_HEAVEN_10');

--*******************************************************************
-- Free Buildings (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 				BuildingClassType)
SELECT		('CIVILIZATION_OUTER_HEAVEN'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_AMERICA');

--*******************************************************************
-- Free Techs (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_OUTER_HEAVEN'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_AMERICA');

--*******************************************************************
-- Free Units (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_OUTER_HEAVEN'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_AMERICA');

--******************************************************************************************************************************************
--Religion (taken from America)
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 									ReligionType)
SELECT		('CIVILIZATION_OUTER_HEAVEN'),				ReligionType
FROM Civilization_Religions WHERE (CivilizationType = 'CIVILIZATION_AMERICA');

--*******************************************************************
-- Spy Names
--*******************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		
			('CIVILIZATION_OUTER_HEAVEN', 	'TXT_KEY_SPY_NAME_OUTER_HEAVEN_0'),	
			('CIVILIZATION_OUTER_HEAVEN', 	'TXT_KEY_SPY_NAME_OUTER_HEAVEN_1'),
			('CIVILIZATION_OUTER_HEAVEN', 	'TXT_KEY_SPY_NAME_OUTER_HEAVEN_2'),
			('CIVILIZATION_OUTER_HEAVEN', 	'TXT_KEY_SPY_NAME_OUTER_HEAVEN_3'),
			('CIVILIZATION_OUTER_HEAVEN', 	'TXT_KEY_SPY_NAME_OUTER_HEAVEN_4'),
			('CIVILIZATION_OUTER_HEAVEN', 	'TXT_KEY_SPY_NAME_OUTER_HEAVEN_5'),
			('CIVILIZATION_OUTER_HEAVEN', 	'TXT_KEY_SPY_NAME_OUTER_HEAVEN_6'),
			('CIVILIZATION_OUTER_HEAVEN', 	'TXT_KEY_SPY_NAME_OUTER_HEAVEN_7'),
			('CIVILIZATION_OUTER_HEAVEN', 	'TXT_KEY_SPY_NAME_OUTER_HEAVEN_8'),
			('CIVILIZATION_OUTER_HEAVEN', 	'TXT_KEY_SPY_NAME_OUTER_HEAVEN_9');

