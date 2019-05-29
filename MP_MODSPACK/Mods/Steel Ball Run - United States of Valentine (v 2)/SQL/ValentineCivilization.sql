--*******************************************************************
-- The United States of Valentine (uses America as a baseline)
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage)

SELECT ('CIVILIZATION_JJBA_AMERICA'), ('TXT_KEY_CIV_JJBA_AMERICA_DESC'), ('TXT_KEY_CIV_JJBA_AMERICA_SHORT_DESC'), ('TXT_KEY_CIV_JJBA_AMERICA_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_JJBA_AMERICA'), ('PLAYERCOLOR_JJBA_AMERICA'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_JJBA_AMERICA'), 0, ('CIV_ALPHA_ATLAS_JJBA_AMERICA'), ('AMERICA'), ('FunnyValentineMapImage.dds'),
('TXT_KEY_CIV5_DAWN_JJBA_AMERICA_TEXT'), ('DOM_FunnyValentine.dds')

FROM Civilizations WHERE (Type = 'CIVILIZATION_AMERICA');

--*******************************************************************
-- Leader (Funny Valentine)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 				LeaderheadType)
VALUES		('CIVILIZATION_JJBA_AMERICA', 	'LEADER_FUNNY_VALENTINE');	


--*******************************************************************
-- Unique Buildings (Pioneer Diner)
--*******************************************************************
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 				BuildingClassType, 			BuildingType)
VALUES		('CIVILIZATION_JJBA_AMERICA', 	'BUILDINGCLASS_HOSPITAL', 	'BUILDING_PIONEER_DINER');


--*******************************************************************
-- Unique Units (Steel Ball Runner)
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 				UnitClassType, 			UnitType)
VALUES		('CIVILIZATION_JJBA_AMERICA', 	'UNITCLASS_PROPHET', 	'UNIT_STEEL_BALL_RUNNER');


--******************************************************************************************************************************************
-- City Names (naming theme: Capital is Valentine, DC. All other cities are taken from the America list)
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 				CityName)
VALUES		('CIVILIZATION_JJBA_AMERICA', 	'TXT_KEY_CITY_NAME_JJBA_AMERICA_1');

INSERT INTO Civilization_CityNames
			(CivilizationType, 				CityName)
SELECT		('CIVILIZATION_JJBA_AMERICA'),	CityName
FROM Civilization_CityNames WHERE CivilizationType = 'CIVILIZATION_AMERICA';

--*******************************************************************
-- Free Buildings (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 					BuildingClassType)
SELECT		('CIVILIZATION_JJBA_AMERICA'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_AMERICA');

--*******************************************************************
-- Free Techs (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_JJBA_AMERICA'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_AMERICA');

--*******************************************************************
-- Free Units (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 				UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_JJBA_AMERICA'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_AMERICA');

--******************************************************************************************************************************************
--Religion (taken from America)
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 							ReligionType)
SELECT		('CIVILIZATION_JJBA_AMERICA'),				ReligionType
FROM Civilization_Religions WHERE (CivilizationType = 'CIVILIZATION_AMERICA');

--******************************************************************************************************************************************
-- Spy Names
--******************************************************************************************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		('CIVILIZATION_JJBA_AMERICA',		'TXT_KEY_SPY_NAME_JJBA_AMERICA_0'),
			('CIVILIZATION_JJBA_AMERICA',		'TXT_KEY_SPY_NAME_JJBA_AMERICA_1'),
			('CIVILIZATION_JJBA_AMERICA',		'TXT_KEY_SPY_NAME_JJBA_AMERICA_2'),
			('CIVILIZATION_JJBA_AMERICA',		'TXT_KEY_SPY_NAME_JJBA_AMERICA_3'),
			('CIVILIZATION_JJBA_AMERICA',		'TXT_KEY_SPY_NAME_JJBA_AMERICA_4'),
			('CIVILIZATION_JJBA_AMERICA',		'TXT_KEY_SPY_NAME_JJBA_AMERICA_5'),
			('CIVILIZATION_JJBA_AMERICA',		'TXT_KEY_SPY_NAME_JJBA_AMERICA_6'),
			('CIVILIZATION_JJBA_AMERICA',		'TXT_KEY_SPY_NAME_JJBA_AMERICA_7'),
			('CIVILIZATION_JJBA_AMERICA',		'TXT_KEY_SPY_NAME_JJBA_AMERICA_8'),
			('CIVILIZATION_JJBA_AMERICA',		'TXT_KEY_SPY_NAME_JJBA_AMERICA_9');