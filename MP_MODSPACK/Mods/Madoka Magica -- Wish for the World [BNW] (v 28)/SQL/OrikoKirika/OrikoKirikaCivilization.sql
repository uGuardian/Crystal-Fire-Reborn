--All SQL Civilization inserts were based off of SQL code from JFD's Civilizations.


--*******************************************************************
-- Oriko and Kirika's Civilization (uses Japan as a baseline)
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage)

SELECT ('CIVILIZATION_ORIKO_KIRIKA'), ('TXT_KEY_CIV_ORIKO_KIRIKA_DESC'), ('TXT_KEY_CIV_ORIKO_KIRIKA_SHORT_DESC'), ('TXT_KEY_CIV_ORIKO_KIRIKA_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_ORIKO_KIRIKA'), ('PLAYERCOLOR_ORIKO_KIRIKA'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_ORIKO_KIRIKA'), 0, ('CIV_ALPHA_ATLAS_ORIKO_KIRIKA'), SoundtrackTag, ('ShiromeSelectImage.dds'),
('TXT_KEY_CIV5_DAWN_ORIKO_KIRIKA_TEXT'), ('DOM_Shirome.dds')

FROM Civilizations WHERE (Type = 'CIVILIZATION_JAPAN');


UPDATE Civilizations
SET LeaderMagicalGirlIconAtlasOverride = 'PMMM_LEADER_OVERRIDE_ATLAS', LeaderMagicalGirlPortraitIndexOverride = 0
WHERE Type = 'CIVILIZATION_ORIKO_KIRIKA';

--*******************************************************************
-- Leader (Oriko and Kirika)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 					LeaderheadType)
VALUES		('CIVILIZATION_ORIKO_KIRIKA', 	'LEADER_ORIKO_KIRIKA');	


--*******************************************************************
-- Unique Buildings (none -- they have a UI)
--*******************************************************************


--*******************************************************************
-- Unique Units (Magiclaw)
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 					UnitClassType, 			UnitType)
VALUES		('CIVILIZATION_ORIKO_KIRIKA', 	'UNITCLASS_SWORDSMAN', 	'UNIT_PMMM_MAGICLAW');


--**********************************************************************************************************************************************************************************************
-- City Names (naming theme: Capital is Shirome (the name of the academy Oriko attends), other cities after famous people whose future predictions came true.)
--**********************************************************************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 					CityName)
VALUES		('CIVILIZATION_ORIKO_KIRIKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_SHIROME'),
			('CIVILIZATION_ORIKO_KIRIKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_NOSTRADAMUS'),
			('CIVILIZATION_ORIKO_KIRIKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_PYTHIA'),
			('CIVILIZATION_ORIKO_KIRIKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_DIXON'),
			('CIVILIZATION_ORIKO_KIRIKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_CAYCE'),
			('CIVILIZATION_ORIKO_KIRIKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_BABA_VANGA'),
			('CIVILIZATION_ORIKO_KIRIKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_JAMISON'),
			('CIVILIZATION_ORIKO_KIRIKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_TWAIN'),
			('CIVILIZATION_ORIKO_KIRIKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_PALMER'),
			('CIVILIZATION_ORIKO_KIRIKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_HURKOS'),
			('CIVILIZATION_ORIKO_KIRIKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_JULES_BOIS'),
			('CIVILIZATION_ORIKO_KIRIKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_WATKINS'),
			('CIVILIZATION_ORIKO_KIRIKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_HOY'),
			('CIVILIZATION_ORIKO_KIRIKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_TOCQUEVILLE'),
			('CIVILIZATION_ORIKO_KIRIKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_ASIMOV'),
			('CIVILIZATION_ORIKO_KIRIKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_VERNE');
			
INSERT INTO Civilization_CityNames
			(CivilizationType, 					CityName)
SELECT		('CIVILIZATION_ORIKO_KIRIKA'),		Tag
FROM Language_en_US WHERE Tag LIKE ('TXT_KEY_CITY_NAME_ORIKO_KIRIKA_ADDON%');

--*******************************************************************
-- Free Buildings (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 					BuildingClassType)
SELECT		('CIVILIZATION_ORIKO_KIRIKA'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Free Techs (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_ORIKO_KIRIKA'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Free Units (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_ORIKO_KIRIKA'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--******************************************************************************************************************************************
--Religion (Church of Madoka)
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 					ReligionType)
VALUES		('CIVILIZATION_ORIKO_KIRIKA', 	'RELIGION_CHURCH_OF_MADOKA');

--*******************************************************************
-- Spy Names (generic PMMM spy name list)
--*******************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		
			('CIVILIZATION_ORIKO_KIRIKA', 	'TXT_KEY_SPY_NAME_MADOKA_0'),	
			('CIVILIZATION_ORIKO_KIRIKA', 	'TXT_KEY_SPY_NAME_MADOKA_1'),
			('CIVILIZATION_ORIKO_KIRIKA', 	'TXT_KEY_SPY_NAME_MADOKA_2'),
			('CIVILIZATION_ORIKO_KIRIKA', 	'TXT_KEY_SPY_NAME_MADOKA_3'),
			('CIVILIZATION_ORIKO_KIRIKA', 	'TXT_KEY_SPY_NAME_MADOKA_4'),
			('CIVILIZATION_ORIKO_KIRIKA', 	'TXT_KEY_SPY_NAME_MADOKA_5'),
			('CIVILIZATION_ORIKO_KIRIKA', 	'TXT_KEY_SPY_NAME_MADOKA_6'),
			('CIVILIZATION_ORIKO_KIRIKA', 	'TXT_KEY_SPY_NAME_MADOKA_7'),
			('CIVILIZATION_ORIKO_KIRIKA', 	'TXT_KEY_SPY_NAME_MADOKA_8'),
			('CIVILIZATION_ORIKO_KIRIKA', 	'TXT_KEY_SPY_NAME_MADOKA_9');

