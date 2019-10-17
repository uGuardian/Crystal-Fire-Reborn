--All SQL Civilization inserts were based off of SQL code from JFD's Civilizations.


--*******************************************************************
-- Sayaka's Civilization (uses Germany as a baseline)
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage)

SELECT ('CIVILIZATION_SAYAKA'), ('TXT_KEY_CIV_SAYAKA_DESC'), ('TXT_KEY_CIV_SAYAKA_SHORT_DESC'), ('TXT_KEY_CIV_SAYAKA_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_SAYAKA'), ('PLAYERCOLOR_SAYAKA'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_SAYAKA'), 0, ('CIV_ALPHA_ATLAS_SAYAKA'), SoundtrackTag, ('SayakaSelectImage.dds'),
('TXT_KEY_CIV5_DAWN_SAYAKA_TEXT'), ('DOM_Sayaka.dds')

FROM Civilizations WHERE (Type = 'CIVILIZATION_GERMANY');

--*******************************************************************
-- Leader (Sayaka)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 					LeaderheadType)
VALUES		('CIVILIZATION_SAYAKA', 	'LEADER_SAYAKA');	


--*******************************************************************
-- Unique Buildings (Stage of Oktavia)
--*******************************************************************
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 					BuildingClassType, 					BuildingType)
VALUES		('CIVILIZATION_SAYAKA', 	'BUILDINGCLASS_OPERA_HOUSE', 	'BUILDING_PMMM_STAGE_OF_OKTAVIA');


--*******************************************************************
-- Unique Units (Cutlass Conductor)
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 					UnitClassType, 			UnitType)
VALUES		('CIVILIZATION_SAYAKA', 	'UNITCLASS_LONGSWORDSMAN', 	'UNIT_PMMM_CUTLASS_CONDUCTOR');


--******************************************************************************************************************************************
-- City Names (naming theme: Capital is Oktavianna, second city is Kamijou, other cities after famous composers
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 					CityName)
VALUES		('CIVILIZATION_SAYAKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_OKTAVIANNA'),
			('CIVILIZATION_SAYAKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_KAMIJOU'),
			('CIVILIZATION_SAYAKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_AMADEUS'),
			('CIVILIZATION_SAYAKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_PETROVICH'),
			('CIVILIZATION_SAYAKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_ILYICH'),
			('CIVILIZATION_SAYAKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_BARTHOLDY'),
			('CIVILIZATION_SAYAKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_VIVALDI'),
			('CIVILIZATION_SAYAKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_LISZT'),
			('CIVILIZATION_SAYAKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_FRIDERIC'),
			('CIVILIZATION_SAYAKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_ACHILLE'),
			('CIVILIZATION_SAYAKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_TELEMANN'),
			('CIVILIZATION_SAYAKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_SCHOENBERG'),
			('CIVILIZATION_SAYAKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_PAGANINI'),
			('CIVILIZATION_SAYAKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_ROSSINI'),
			('CIVILIZATION_SAYAKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_PACHELBEL'),
			('CIVILIZATION_SAYAKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_SCHUBERT'),
			('CIVILIZATION_SAYAKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_BOCCHERINI');
			
INSERT INTO Civilization_CityNames
			(CivilizationType, 					CityName)
SELECT		('CIVILIZATION_SAYAKA'),		Tag
FROM Language_en_US WHERE Tag LIKE ('TXT_KEY_CITY_NAME_SAYAKA_ADDON%');

--*******************************************************************
-- Free Buildings (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 					BuildingClassType)
SELECT		('CIVILIZATION_SAYAKA'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_GERMANY');

--*******************************************************************
-- Free Techs (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_SAYAKA'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_GERMANY');

--*******************************************************************
-- Free Units (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_SAYAKA'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_GERMANY');

--******************************************************************************************************************************************
--Religion (Church of Madoka)
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 					ReligionType)
VALUES		('CIVILIZATION_SAYAKA', 	'RELIGION_CHURCH_OF_MADOKA');

--*******************************************************************
-- Spy Names (generic PMMM spy name list)
--*******************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		
			('CIVILIZATION_SAYAKA', 	'TXT_KEY_SPY_NAME_MADOKA_0'),	
			('CIVILIZATION_SAYAKA', 	'TXT_KEY_SPY_NAME_MADOKA_1'),
			('CIVILIZATION_SAYAKA', 	'TXT_KEY_SPY_NAME_MADOKA_2'),
			('CIVILIZATION_SAYAKA', 	'TXT_KEY_SPY_NAME_MADOKA_3'),
			('CIVILIZATION_SAYAKA', 	'TXT_KEY_SPY_NAME_MADOKA_4'),
			('CIVILIZATION_SAYAKA', 	'TXT_KEY_SPY_NAME_MADOKA_5'),
			('CIVILIZATION_SAYAKA', 	'TXT_KEY_SPY_NAME_MADOKA_6'),
			('CIVILIZATION_SAYAKA', 	'TXT_KEY_SPY_NAME_MADOKA_7'),
			('CIVILIZATION_SAYAKA', 	'TXT_KEY_SPY_NAME_MADOKA_8'),
			('CIVILIZATION_SAYAKA', 	'TXT_KEY_SPY_NAME_MADOKA_9');


