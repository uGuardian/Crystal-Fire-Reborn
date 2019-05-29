--All SQL Civilization inserts were based off of SQL code from JFD's Civilizations.


--*******************************************************************
-- Paragon (uses America as a baseline)
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage)

SELECT ('CIVILIZATION_PARAGON'), ('TXT_KEY_CIV_PARAGON_DESC'), ('TXT_KEY_CIV_PARAGON_SHORT_DESC'), ('TXT_KEY_CIV_PARAGON_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_PARAGON'), ('PLAYERCOLOR_PARAGON'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_PARAGON'), 0, ('CIV_ALPHA_ATLAS_PARAGON'), ('AMERICA'), ('StatesmanSelectImage.dds'),
('TXT_KEY_CIV5_DAWN_STATESMAN_TEXT'), ('DOM-Statesman.dds')

FROM Civilizations WHERE (Type = 'CIVILIZATION_AMERICA');

--*******************************************************************
-- Leader (Statesman)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 			LeaderheadType)
VALUES		('CIVILIZATION_PARAGON', 	'LEADER_STATESMAN');	


--*******************************************************************
-- Unique Buildings (Wentworth's)
--*******************************************************************
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 			BuildingClassType, 					BuildingType)
VALUES		('CIVILIZATION_PARAGON', 	'BUILDINGCLASS_STOCK_EXCHANGE', 	'BUILDING_WENTWORTHS');


--*******************************************************************
-- Unique Units (Longbow Rifleman)
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 			UnitClassType, 			UnitType)
VALUES		('CIVILIZATION_PARAGON', 	'UNITCLASS_MARINE', 	'UNIT_LONGBOW_RIFLEMAN');


--******************************************************************************************************************************************
-- City Names
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 					CityName)
VALUES		('CIVILIZATION_PARAGON', 	'TXT_KEY_CITY_NAME_PARAGON_1'),
			('CIVILIZATION_PARAGON', 	'TXT_KEY_CITY_NAME_PARAGON_2'),
			('CIVILIZATION_PARAGON', 	'TXT_KEY_CITY_NAME_PARAGON_3'),
			('CIVILIZATION_PARAGON', 	'TXT_KEY_CITY_NAME_PARAGON_4'),
			('CIVILIZATION_PARAGON', 	'TXT_KEY_CITY_NAME_PARAGON_5'),
			('CIVILIZATION_PARAGON', 	'TXT_KEY_CITY_NAME_PARAGON_6'),
			('CIVILIZATION_PARAGON', 	'TXT_KEY_CITY_NAME_PARAGON_7'),
			('CIVILIZATION_PARAGON', 	'TXT_KEY_CITY_NAME_PARAGON_8'),
			('CIVILIZATION_PARAGON', 	'TXT_KEY_CITY_NAME_PARAGON_9'),
			('CIVILIZATION_PARAGON', 	'TXT_KEY_CITY_NAME_PARAGON_10'),
			('CIVILIZATION_PARAGON', 	'TXT_KEY_CITY_NAME_PARAGON_11'),
			('CIVILIZATION_PARAGON', 	'TXT_KEY_CITY_NAME_PARAGON_12'),
			('CIVILIZATION_PARAGON', 	'TXT_KEY_CITY_NAME_PARAGON_13');

			--NOTE: some cities are named via Lua so that they may be dynamically named (e.g. Independence Port becomes Independence City if not coastal).
			--These cities are not in this list.

--*******************************************************************
-- Free Buildings (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 					BuildingClassType)
SELECT		('CIVILIZATION_PARAGON'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_AMERICA');

--*******************************************************************
-- Free Techs (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_PARAGON'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_AMERICA');

--*******************************************************************
-- Free Units (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_PARAGON'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_AMERICA');

--********************************************************************************************************************************************************
--Religion
--********************************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 					ReligionType)
SELECT		('CIVILIZATION_PARAGON'), 			ReligionType
FROM Civilization_Religions WHERE (CivilizationType = 'CIVILIZATION_AMERICA');

--*******************************************************************
-- Spy Names
--*******************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		
			('CIVILIZATION_PARAGON', 	'TXT_KEY_SPY_NAME_PARAGON_0'),	
			('CIVILIZATION_PARAGON', 	'TXT_KEY_SPY_NAME_PARAGON_1'),
			('CIVILIZATION_PARAGON', 	'TXT_KEY_SPY_NAME_PARAGON_2'),
			('CIVILIZATION_PARAGON', 	'TXT_KEY_SPY_NAME_PARAGON_3'),
			('CIVILIZATION_PARAGON', 	'TXT_KEY_SPY_NAME_PARAGON_4'),
			('CIVILIZATION_PARAGON', 	'TXT_KEY_SPY_NAME_PARAGON_5'),
			('CIVILIZATION_PARAGON', 	'TXT_KEY_SPY_NAME_PARAGON_6'),
			('CIVILIZATION_PARAGON', 	'TXT_KEY_SPY_NAME_PARAGON_7'),
			('CIVILIZATION_PARAGON', 	'TXT_KEY_SPY_NAME_PARAGON_8'),
			('CIVILIZATION_PARAGON', 	'TXT_KEY_SPY_NAME_PARAGON_9');



INSERT INTO Civilization_Start_Along_Ocean
			(CivilizationType,			StartAlongOcean)
VALUES		('CIVILIZATION_PARAGON',	1);

