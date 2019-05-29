--All SQL Civilization inserts were based off of SQL code from JFD's Civilizations.


--*******************************************************************
-- Classic Madoka's Civilization (uses Japan as a baseline)
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage)

SELECT ('CIVILIZATION_ORIGINAL_MADOKA'), ('TXT_KEY_CIV_ORIGINAL_MADOKA_DESC'), ('TXT_KEY_CIV_ORIGINAL_MADOKA_SHORT_DESC'), ('TXT_KEY_CIV_ORIGINAL_MADOKA_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_ORIGINAL_MADOKA'), ('PLAYERCOLOR_ORIGINAL_MADOKA'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_ORIGINAL_MADOKA'), 0, ('CIV_ALPHA_ATLAS_ORIGINAL_MADOKA'), SoundtrackTag, ('OriginalMadokaSelectImage.dds'),
('TXT_KEY_CIV5_DAWN_ORIGINAL_MADOKA_TEXT'), ('DOM_OriginalMadoka.dds')

FROM Civilizations WHERE (Type = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Leader (Original Madoka)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 					LeaderheadType)
VALUES		('CIVILIZATION_ORIGINAL_MADOKA', 	'LEADER_ORIGINAL_MADOKA');	


--*******************************************************************
-- Unique Buildings (Middle School)
--*******************************************************************
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 					BuildingClassType, 					BuildingType)
VALUES		('CIVILIZATION_ORIGINAL_MADOKA', 	'BUILDINGCLASS_PUBLIC_SCHOOL', 	'BUILDING_PMMM_MIDDLE_SCHOOL');


--*******************************************************************
-- Unique Units (Rosebow Infantry)
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 					UnitClassType, 			UnitType)
VALUES		('CIVILIZATION_ORIGINAL_MADOKA', 	'UNITCLASS_COMPOSITE_BOWMAN', 	'UNIT_PMMM_ROSEBOW_INFANTRY');


--******************************************************************************************************************************************
-- City Names (naming theme: Capital is Mitakihara, other cities after varieties of roses)
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 					CityName)
VALUES		('CIVILIZATION_ORIGINAL_MADOKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_MITAKIHARA'),
			('CIVILIZATION_ORIGINAL_MADOKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_FORTUNIANA'),
			('CIVILIZATION_ORIGINAL_MADOKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_KATHLEEN'),
			('CIVILIZATION_ORIGINAL_MADOKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_SOMBREUIL'),
			('CIVILIZATION_ORIGINAL_MADOKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_BOCCELLA'),
			('CIVILIZATION_ORIGINAL_MADOKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_NATCHITOCHES'),
			('CIVILIZATION_ORIGINAL_MADOKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_GRAVEREAUX'),
			('CIVILIZATION_ORIGINAL_MADOKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_PAESTUM'),
			('CIVILIZATION_ORIGINAL_MADOKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_RUSSELLIANA'),
			('CIVILIZATION_ORIGINAL_MADOKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_ALTISSIMO'),
			('CIVILIZATION_ORIGINAL_MADOKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_JACQUEMINOT'),
			('CIVILIZATION_ORIGINAL_MADOKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_FELLENBERG'),
			('CIVILIZATION_ORIGINAL_MADOKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_AUDUBON'),
			('CIVILIZATION_ORIGINAL_MADOKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_GROOTENDORST'),
			('CIVILIZATION_ORIGINAL_MADOKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_CAROLINE'),
			('CIVILIZATION_ORIGINAL_MADOKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_FRANCESCA'),
			('CIVILIZATION_ORIGINAL_MADOKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_HILLINGTON');
			
INSERT INTO Civilization_CityNames
			(CivilizationType, 					CityName)
SELECT		('CIVILIZATION_ORIGINAL_MADOKA'),		Tag
FROM Language_en_US WHERE Tag LIKE ('TXT_KEY_CITY_NAME_ORIGINAL_MADOKA_ADDON%');

--*******************************************************************
-- Free Buildings (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 					BuildingClassType)
SELECT		('CIVILIZATION_ORIGINAL_MADOKA'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Free Techs (O. Madoka gets Archery for free!)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_ORIGINAL_MADOKA'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_JAPAN');


--Insert Archery, but only if some other mod didn't already give it to her!
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_ORIGINAL_MADOKA'),	('TECH_ARCHERY')
WHERE NOT EXISTS
			(SELECT * FROM Civilization_FreeTechs WHERE CivilizationType = 'CIVILIZATION_ORIGINAL_MADOKA' AND TechType = 'TECH_ARCHERY');

--*******************************************************************
-- Free Units (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_ORIGINAL_MADOKA'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_JAPAN');


--******************************************************************************************************************************************
--Religion (taken from Japan, most likely Shinto -- she's not conceited enough to found Church of Madoka if she isn't a deity yet!)
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 					ReligionType)
SELECT		('CIVILIZATION_ORIGINAL_MADOKA'), 	ReligionType
FROM Civilization_Religions WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Spy Names (generic PMMM spy name list)
--*******************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		
			('CIVILIZATION_ORIGINAL_MADOKA', 	'TXT_KEY_SPY_NAME_MADOKA_0'),	
			('CIVILIZATION_ORIGINAL_MADOKA', 	'TXT_KEY_SPY_NAME_MADOKA_1'),
			('CIVILIZATION_ORIGINAL_MADOKA', 	'TXT_KEY_SPY_NAME_MADOKA_2'),
			('CIVILIZATION_ORIGINAL_MADOKA', 	'TXT_KEY_SPY_NAME_MADOKA_3'),
			('CIVILIZATION_ORIGINAL_MADOKA', 	'TXT_KEY_SPY_NAME_MADOKA_4'),
			('CIVILIZATION_ORIGINAL_MADOKA', 	'TXT_KEY_SPY_NAME_MADOKA_5'),
			('CIVILIZATION_ORIGINAL_MADOKA', 	'TXT_KEY_SPY_NAME_MADOKA_6'),
			('CIVILIZATION_ORIGINAL_MADOKA', 	'TXT_KEY_SPY_NAME_MADOKA_7'),
			('CIVILIZATION_ORIGINAL_MADOKA', 	'TXT_KEY_SPY_NAME_MADOKA_8'),
			('CIVILIZATION_ORIGINAL_MADOKA', 	'TXT_KEY_SPY_NAME_MADOKA_9');


