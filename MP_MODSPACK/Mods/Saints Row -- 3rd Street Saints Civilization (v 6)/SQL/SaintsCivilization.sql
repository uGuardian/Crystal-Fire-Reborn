--All SQL Civilization inserts were based off of SQL code from JFD's Civilizations.


--*******************************************************************
-- The Third Street Saints (uses America as a baseline)
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage)

SELECT ('CIVILIZATION_THIRD_STREET_SAINTS'), ('TXT_KEY_CIV_THIRD_STREET_SAINTS_DESC'), ('TXT_KEY_CIV_THIRD_STREET_SAINTS_SHORT_DESC'), ('TXT_KEY_CIV_THIRD_STREET_SAINTS_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_THIRD_STREET_SAINTS'), ('PLAYERCOLOR_THIRD_STREET_SAINTS'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_THIRD_STREET_SAINTS'), 7, AlphaIconAtlas, ('AMERICA'), ('SRTTMapImage.dds'),
('TXT_KEY_CIV5_DAWN_THIRD_STREET_SAINTS_TEXT'), ('DOM_SRTTPierce.dds')

FROM Civilizations WHERE (Type = 'CIVILIZATION_AMERICA');

--*******************************************************************
-- Leader (Pierce)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 						LeaderheadType)
VALUES		('CIVILIZATION_THIRD_STREET_SAINTS', 	'LEADER_PIERCE_WASHINGTON');	


--*******************************************************************
-- Unique Buildings (Rim Jobs)
--*******************************************************************
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 						BuildingClassType, 					BuildingType)
VALUES		('CIVILIZATION_THIRD_STREET_SAINTS', 	'BUILDINGCLASS_MILITARY_ACADEMY', 	'BUILDING_SRTT_RIM_JOBS');


--*******************************************************************
-- Unique Units (Boss)
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 						UnitClassType, 				UnitType)
VALUES		('CIVILIZATION_THIRD_STREET_SAINTS', 	'UNITCLASS_GREAT_GENERAL', 	'UNIT_SRTT_BOSS');


--******************************************************************************************************************************************
-- City Names (naming theme: Capital is Stilwater, second city is Steelport, the other names are after individual neighborhoods within them.
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 					CityName)
VALUES		('CIVILIZATION_THIRD_STREET_SAINTS', 	'TXT_KEY_CITY_NAME_THIRD_STREET_SAINTS_1'),
			('CIVILIZATION_THIRD_STREET_SAINTS', 	'TXT_KEY_CITY_NAME_THIRD_STREET_SAINTS_2'),
			('CIVILIZATION_THIRD_STREET_SAINTS', 	'TXT_KEY_CITY_NAME_THIRD_STREET_SAINTS_3'),
			('CIVILIZATION_THIRD_STREET_SAINTS', 	'TXT_KEY_CITY_NAME_THIRD_STREET_SAINTS_4'),
			('CIVILIZATION_THIRD_STREET_SAINTS', 	'TXT_KEY_CITY_NAME_THIRD_STREET_SAINTS_5'),
			('CIVILIZATION_THIRD_STREET_SAINTS', 	'TXT_KEY_CITY_NAME_THIRD_STREET_SAINTS_6'),
			('CIVILIZATION_THIRD_STREET_SAINTS', 	'TXT_KEY_CITY_NAME_THIRD_STREET_SAINTS_7'),
			('CIVILIZATION_THIRD_STREET_SAINTS', 	'TXT_KEY_CITY_NAME_THIRD_STREET_SAINTS_8'),
			('CIVILIZATION_THIRD_STREET_SAINTS', 	'TXT_KEY_CITY_NAME_THIRD_STREET_SAINTS_9'),
			('CIVILIZATION_THIRD_STREET_SAINTS', 	'TXT_KEY_CITY_NAME_THIRD_STREET_SAINTS_10'),
			('CIVILIZATION_THIRD_STREET_SAINTS', 	'TXT_KEY_CITY_NAME_THIRD_STREET_SAINTS_11'),
			('CIVILIZATION_THIRD_STREET_SAINTS', 	'TXT_KEY_CITY_NAME_THIRD_STREET_SAINTS_12'),
			('CIVILIZATION_THIRD_STREET_SAINTS', 	'TXT_KEY_CITY_NAME_THIRD_STREET_SAINTS_13'),
			('CIVILIZATION_THIRD_STREET_SAINTS', 	'TXT_KEY_CITY_NAME_THIRD_STREET_SAINTS_14'),
			('CIVILIZATION_THIRD_STREET_SAINTS', 	'TXT_KEY_CITY_NAME_THIRD_STREET_SAINTS_15'),
			('CIVILIZATION_THIRD_STREET_SAINTS', 	'TXT_KEY_CITY_NAME_THIRD_STREET_SAINTS_16'),
			('CIVILIZATION_THIRD_STREET_SAINTS', 	'TXT_KEY_CITY_NAME_THIRD_STREET_SAINTS_17'),
			('CIVILIZATION_THIRD_STREET_SAINTS', 	'TXT_KEY_CITY_NAME_THIRD_STREET_SAINTS_18'),
			('CIVILIZATION_THIRD_STREET_SAINTS', 	'TXT_KEY_CITY_NAME_THIRD_STREET_SAINTS_19');

--*******************************************************************
-- Free Buildings (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 					BuildingClassType)
SELECT		('CIVILIZATION_THIRD_STREET_SAINTS'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_AMERICA');

--*******************************************************************
-- Free Techs (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_THIRD_STREET_SAINTS'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_AMERICA');

--*******************************************************************
-- Free Units (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_THIRD_STREET_SAINTS'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_AMERICA');

--******************************************************************************************************************************************
--Religion (taken from America)
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 									ReligionType)
SELECT		('CIVILIZATION_THIRD_STREET_SAINTS'),				ReligionType
FROM Civilization_Religions WHERE (CivilizationType = 'CIVILIZATION_AMERICA');

--*******************************************************************
-- Spy Names
--*******************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		
			('CIVILIZATION_THIRD_STREET_SAINTS', 	'TXT_KEY_SPY_NAME_THIRD_STREET_SAINTS_0'),	
			('CIVILIZATION_THIRD_STREET_SAINTS', 	'TXT_KEY_SPY_NAME_THIRD_STREET_SAINTS_1'),
			('CIVILIZATION_THIRD_STREET_SAINTS', 	'TXT_KEY_SPY_NAME_THIRD_STREET_SAINTS_2'),
			('CIVILIZATION_THIRD_STREET_SAINTS', 	'TXT_KEY_SPY_NAME_THIRD_STREET_SAINTS_3'),
			('CIVILIZATION_THIRD_STREET_SAINTS', 	'TXT_KEY_SPY_NAME_THIRD_STREET_SAINTS_4'),
			('CIVILIZATION_THIRD_STREET_SAINTS', 	'TXT_KEY_SPY_NAME_THIRD_STREET_SAINTS_5'),
			('CIVILIZATION_THIRD_STREET_SAINTS', 	'TXT_KEY_SPY_NAME_THIRD_STREET_SAINTS_6'),
			('CIVILIZATION_THIRD_STREET_SAINTS', 	'TXT_KEY_SPY_NAME_THIRD_STREET_SAINTS_7'),
			('CIVILIZATION_THIRD_STREET_SAINTS', 	'TXT_KEY_SPY_NAME_THIRD_STREET_SAINTS_8'),
			('CIVILIZATION_THIRD_STREET_SAINTS', 	'TXT_KEY_SPY_NAME_THIRD_STREET_SAINTS_9');

