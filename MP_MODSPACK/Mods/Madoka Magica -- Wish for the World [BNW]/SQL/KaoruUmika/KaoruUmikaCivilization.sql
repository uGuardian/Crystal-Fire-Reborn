--All SQL Civilization inserts were based off of SQL code from JFD's Civilizations.


--*******************************************************************
-- Kazumi's Civilization (uses Japan as a baseline)
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage)

SELECT ('CIVILIZATION_KAORU_UMIKA'), ('TXT_KEY_CIV_KAORU_UMIKA_DESC'), ('TXT_KEY_CIV_KAORU_UMIKA_SHORT_DESC'), ('TXT_KEY_CIV_KAORU_UMIKA_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_KAORU_UMIKA'), ('PLAYERCOLOR_KAORU_UMIKA'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_KAORU_UMIKA'), 0, ('CIV_ALPHA_ATLAS_KAORU_UMIKA'), SoundtrackTag, ('PleiadesSelectImage.dds'),
('TXT_KEY_CIV5_DAWN_KAORU_UMIKA_TEXT'), ('DOM_Pleiades.dds')

FROM Civilizations WHERE (Type = 'CIVILIZATION_JAPAN');


--*******************************************************************
-- Leader (Kazumi)
-- NOTE: For compatibility reasons, Kazumi is still KAORU_UMIKA internally.
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 					LeaderheadType)
VALUES		('CIVILIZATION_KAORU_UMIKA', 	'LEADER_KAORU_UMIKA');	


--*******************************************************************
-- Unique Buildings (Angelica Bears)
--*******************************************************************
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 				BuildingClassType, 						BuildingType)
VALUES		('CIVILIZATION_KAORU_UMIKA', 	'BUILDINGCLASS_PMMM_AMUSEMENT_PARK', 	'BUILDING_PMMM_ANGELICA_BEARS');


--*******************************************************************
-- Unique Units (Artificial Incubator)
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 					UnitClassType, 			UnitType)
VALUES		('CIVILIZATION_KAORU_UMIKA', 	'UNITCLASS_PMMM_ARTIFICIAL_INCUBATOR', 	'UNIT_PMMM_ARTIFICIAL_INCUBATOR');


--******************************************************************************************************************************************
-- City Names (naming theme: Capital is Asunaro City, other cities after stars in the Pleiades cluster, and later entire other star clusters
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 					CityName)
VALUES		('CIVILIZATION_KAORU_UMIKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_ASUNARO'),
			('CIVILIZATION_KAORU_UMIKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_MAIA'),
			('CIVILIZATION_KAORU_UMIKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_ALCYONE'),
			('CIVILIZATION_KAORU_UMIKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_MEROPE'),
			('CIVILIZATION_KAORU_UMIKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_PLEIONE'),
			('CIVILIZATION_KAORU_UMIKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_ATLAS'),
			('CIVILIZATION_KAORU_UMIKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_CELAENO'),
			('CIVILIZATION_KAORU_UMIKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_ELECTRA'),
			('CIVILIZATION_KAORU_UMIKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_ASTEROPE'),
			('CIVILIZATION_KAORU_UMIKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_STEROPE'),
			('CIVILIZATION_KAORU_UMIKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_HYADES'),
			('CIVILIZATION_KAORU_UMIKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_MESSIER'),
			('CIVILIZATION_KAORU_UMIKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_PERSEI'),
			('CIVILIZATION_KAORU_UMIKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_COLLINDER'),
			('CIVILIZATION_KAORU_UMIKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_TRUMPLER'),
			('CIVILIZATION_KAORU_UMIKA', 	'TXT_KEY_CITY_NAME_MADOMAGI_HODGE');
			
INSERT INTO Civilization_CityNames
			(CivilizationType, 					CityName)
SELECT		('CIVILIZATION_KAORU_UMIKA'),		Tag
FROM Language_en_US WHERE Tag LIKE ('TXT_KEY_CITY_NAME_KAORU_UMIKA_ADDON%');

--*******************************************************************
-- Free Buildings (gets The Freezer)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 				BuildingClassType)
SELECT		('CIVILIZATION_KAORU_UMIKA'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

INSERT INTO Civilization_FreeBuildingClasses
			(CivilizationType, 				BuildingClassType)
VALUES		('CIVILIZATION_KAORU_UMIKA',	'BUILDINGCLASS_PMMM_FREEZER');

--*******************************************************************
-- Free Techs (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_KAORU_UMIKA'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Free Units (starts with an Artificial Incubator)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 				UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_KAORU_UMIKA'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

INSERT INTO Civilization_FreeUnits
			(CivilizationType, 				UnitClassType,							Count,	UnitAIType)
VALUES		('CIVILIZATION_KAORU_UMIKA',	'UNITCLASS_PMMM_ARTIFICIAL_INCUBATOR',	1,		'UNITAI_EXPLORE');

--******************************************************************************************************************************************
--Religion (Shinto, since they had no contact with or knowledge of Madoka)
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 					ReligionType)
SELECT		('CIVILIZATION_KAORU_UMIKA'), 	ReligionType
FROM Civilization_Religions WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Spy Names (first four are other Pleiades members, rest are generic)
--*******************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		
			('CIVILIZATION_KAORU_UMIKA', 	'TXT_KEY_SPY_NAME_KAORU_UMIKA_0'),	
			('CIVILIZATION_KAORU_UMIKA', 	'TXT_KEY_SPY_NAME_KAORU_UMIKA_1'),
			('CIVILIZATION_KAORU_UMIKA', 	'TXT_KEY_SPY_NAME_KAORU_UMIKA_2'),
			('CIVILIZATION_KAORU_UMIKA', 	'TXT_KEY_SPY_NAME_KAORU_UMIKA_3'),
			('CIVILIZATION_KAORU_UMIKA', 	'TXT_KEY_SPY_NAME_MADOKA_4'),
			('CIVILIZATION_KAORU_UMIKA', 	'TXT_KEY_SPY_NAME_MADOKA_5'),
			('CIVILIZATION_KAORU_UMIKA', 	'TXT_KEY_SPY_NAME_MADOKA_6'),
			('CIVILIZATION_KAORU_UMIKA', 	'TXT_KEY_SPY_NAME_MADOKA_7'),
			('CIVILIZATION_KAORU_UMIKA', 	'TXT_KEY_SPY_NAME_MADOKA_8'),
			('CIVILIZATION_KAORU_UMIKA', 	'TXT_KEY_SPY_NAME_MADOKA_9');
