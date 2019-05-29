--All SQL Civilization inserts were based off of SQL code from JFD's Civilizations.


--*******************************************************************
-- The Rikti (uses Indonesia as a baseline)
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage)

SELECT ('CIVILIZATION_RIKTI'), ('TXT_KEY_CIV_RIKTI_DESC'), ('TXT_KEY_CIV_RIKTI_SHORT_DESC'), ('TXT_KEY_CIV_RIKTI_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_RIKTI'), ('PLAYERCOLOR_RIKTI'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_RIKTI'), 0, ('CIV_ALPHA_ATLAS_RIKTI'), ('INDONESIA'), ('StatesmanSelectImage.dds'),
('TXT_KEY_CIV5_DAWN_RIKTI_TEXT'), ('DOM-Hrodtohz.dds')

FROM Civilizations WHERE (Type = 'CIVILIZATION_INDONESIA');

--*******************************************************************
-- Leader (Sayaka)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 		LeaderheadType)
VALUES		('CIVILIZATION_RIKTI', 	'LEADER_HRODTOHZ');	



--*******************************************************************
-- Unique Units (Drone, Chief Soldier)
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 		UnitClassType, 				UnitType)
VALUES		('CIVILIZATION_RIKTI', 	'UNITCLASS_BAZOOKA', 		'UNIT_RIKTI_DRONE'),
			('CIVILIZATION_RIKTI', 	'UNITCLASS_XCOM_SQUAD', 	'UNIT_RIKTI_CHIEF');


--******************************************************************************************************************************************
-- City Names
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 		CityName)
VALUES		('CIVILIZATION_RIKTI', 	'TXT_KEY_CITY_NAME_RIKTI_1');

			--A Lua script will be used to Riktify the City Names automatically assigned from the Huns-style random naming

--*******************************************************************
-- Free Buildings (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 			BuildingClassType)
SELECT		('CIVILIZATION_RIKTI'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_INDONESIA');

--*******************************************************************
-- Free Techs (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_RIKTI'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_INDONESIA');

--*******************************************************************
-- Free Units (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 			UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_RIKTI'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_INDONESIA');

--******************************************************************************************************************************************
--Religion
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 			ReligionType)
SELECT		('CIVILIZATION_RIKTI'), 	ReligionType
FROM Civilization_Religions WHERE (CivilizationType = 'CIVILIZATION_INDONESIA');

--*******************************************************************
-- Spy Names
--*******************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 		SpyName)
VALUES		
			('CIVILIZATION_RIKTI', 	'TXT_KEY_SPY_NAME_RIKTI_0'),	
			('CIVILIZATION_RIKTI', 	'TXT_KEY_SPY_NAME_RIKTI_1'),
			('CIVILIZATION_RIKTI', 	'TXT_KEY_SPY_NAME_RIKTI_2'),
			('CIVILIZATION_RIKTI', 	'TXT_KEY_SPY_NAME_RIKTI_3'),
			('CIVILIZATION_RIKTI', 	'TXT_KEY_SPY_NAME_RIKTI_4'),
			('CIVILIZATION_RIKTI', 	'TXT_KEY_SPY_NAME_RIKTI_5'),
			('CIVILIZATION_RIKTI', 	'TXT_KEY_SPY_NAME_RIKTI_6'),
			('CIVILIZATION_RIKTI', 	'TXT_KEY_SPY_NAME_RIKTI_7'),
			('CIVILIZATION_RIKTI', 	'TXT_KEY_SPY_NAME_RIKTI_8'),
			('CIVILIZATION_RIKTI', 	'TXT_KEY_SPY_NAME_RIKTI_9');


