--All SQL Civilization inserts were based off of SQL code from JFD's Civilizations.


--*******************************************************************
-- The Rogue Isles (uses France as a baseline)
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage)

SELECT ('CIVILIZATION_ARACHNOS'), ('TXT_KEY_CIV_ARACHNOS_DESC'), ('TXT_KEY_CIV_ARACHNOS_SHORT_DESC'), ('TXT_KEY_CIV_ARACHNOS_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_ARACHNOS'), ('PLAYERCOLOR_ARACHNOS'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_ARACHNOS'), 0, ('CIV_ALPHA_ATLAS_ARACHNOS'), ('ROME'), ('RecluseSelectImage.dds'),
('TXT_KEY_CIV5_DAWN_RECLUSE_TEXT'), ('DOM-Recluse.dds')

FROM Civilizations WHERE (Type = 'CIVILIZATION_FRANCE');

--*******************************************************************
-- Leader (Original Madoka)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 			LeaderheadType)
VALUES		('CIVILIZATION_ARACHNOS', 	'LEADER_RECLUSE');	



--*******************************************************************
-- Unique Units (Toxic Tarantula)
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 			UnitClassType, 				UnitType)
VALUES		('CIVILIZATION_ARACHNOS', 	'UNITCLASS_MODERN_ARMOR', 	'UNIT_TOXIC_TARANTULA');


--******************************************************************************************************************************************
-- City Names
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 			CityName)
VALUES		('CIVILIZATION_ARACHNOS', 	'TXT_KEY_CITY_NAME_ARACHNOS_1'),
			('CIVILIZATION_ARACHNOS', 	'TXT_KEY_CITY_NAME_ARACHNOS_2'),
			('CIVILIZATION_ARACHNOS', 	'TXT_KEY_CITY_NAME_ARACHNOS_3'),
			('CIVILIZATION_ARACHNOS', 	'TXT_KEY_CITY_NAME_ARACHNOS_4'),
			('CIVILIZATION_ARACHNOS', 	'TXT_KEY_CITY_NAME_ARACHNOS_5'),
			('CIVILIZATION_ARACHNOS', 	'TXT_KEY_CITY_NAME_ARACHNOS_6'),
			('CIVILIZATION_ARACHNOS', 	'TXT_KEY_CITY_NAME_ARACHNOS_7'),
			('CIVILIZATION_ARACHNOS', 	'TXT_KEY_CITY_NAME_ARACHNOS_8'),
			('CIVILIZATION_ARACHNOS', 	'TXT_KEY_CITY_NAME_ARACHNOS_9'),
			('CIVILIZATION_ARACHNOS', 	'TXT_KEY_CITY_NAME_ARACHNOS_10');


			--NOTE: some cities are named via Lua so that they may be dynamically named (e.g. Mercy Island becomes Mercy if not on a very small landmass).
			--These cities are not in this list.

--*******************************************************************
-- Free Buildings (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 					BuildingClassType)
SELECT		('CIVILIZATION_ARACHNOS'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_FRANCE');

--*******************************************************************
-- Free Techs
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_ARACHNOS'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_FRANCE');


--*******************************************************************
-- Free Units (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 			UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_ARACHNOS'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_FRANCE');


--******************************************************************************************************************************************
--Religion
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 			ReligionType)
SELECT		('CIVILIZATION_ARACHNOS'), 	ReligionType
FROM Civilization_Religions WHERE (CivilizationType = 'CIVILIZATION_FRANCE');

--*******************************************************************
-- Spy Names
--*******************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		
			('CIVILIZATION_ARACHNOS', 	'TXT_KEY_SPY_NAME_ARACHNOS_0'),	
			('CIVILIZATION_ARACHNOS', 	'TXT_KEY_SPY_NAME_ARACHNOS_1'),
			('CIVILIZATION_ARACHNOS', 	'TXT_KEY_SPY_NAME_ARACHNOS_2'),
			('CIVILIZATION_ARACHNOS', 	'TXT_KEY_SPY_NAME_ARACHNOS_3'),
			('CIVILIZATION_ARACHNOS', 	'TXT_KEY_SPY_NAME_ARACHNOS_4'),
			('CIVILIZATION_ARACHNOS', 	'TXT_KEY_SPY_NAME_ARACHNOS_5'),
			('CIVILIZATION_ARACHNOS', 	'TXT_KEY_SPY_NAME_ARACHNOS_6'),
			('CIVILIZATION_ARACHNOS', 	'TXT_KEY_SPY_NAME_ARACHNOS_7'),
			('CIVILIZATION_ARACHNOS', 	'TXT_KEY_SPY_NAME_ARACHNOS_8'),
			('CIVILIZATION_ARACHNOS', 	'TXT_KEY_SPY_NAME_ARACHNOS_9');



INSERT INTO Civilization_Start_Along_Ocean
			(CivilizationType,			StartAlongOcean)
VALUES		('CIVILIZATION_ARACHNOS',	1);