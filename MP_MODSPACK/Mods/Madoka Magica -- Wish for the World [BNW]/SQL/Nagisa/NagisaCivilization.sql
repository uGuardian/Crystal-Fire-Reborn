--All SQL Civilization inserts were based off of SQL code from JFD's Civilizations.


--*******************************************************************
-- Nagisa's Civilization (uses Japan as a baseline)
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage)

SELECT ('CIVILIZATION_NAGISA'), ('TXT_KEY_CIV_NAGISA_DESC'), ('TXT_KEY_CIV_NAGISA_SHORT_DESC'), ('TXT_KEY_CIV_NAGISA_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_NAGISA'), ('PLAYERCOLOR_NAGISA'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_NAGISA'), 0, ('CIV_ALPHA_ATLAS_NAGISA'), SoundtrackTag, ('NagisaSelectImage.dds'),
('TXT_KEY_CIV5_DAWN_NAGISA_TEXT'), ('DOM_Nagisa.dds')

FROM Civilizations WHERE (Type = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Leader (Nagisa)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 					LeaderheadType)
VALUES		('CIVILIZATION_NAGISA', 	'LEADER_NAGISA');	


--*******************************************************************
-- Unique Buildings (Magical Dairy)
--*******************************************************************
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 					BuildingClassType, 					BuildingType)
VALUES		('CIVILIZATION_NAGISA', 	'BUILDINGCLASS_CARAVANSARY', 	'BUILDING_PMMM_MAGICAL_DAIRY');


--*******************************************************************
-- Unique Units (Bubble Bomber)
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 					UnitClassType, 			UnitType)
VALUES		('CIVILIZATION_NAGISA', 	'UNITCLASS_WWI_BOMBER', 	'UNIT_PMMM_BUBBLE_BOMBER');


--******************************************************************************************************************************************
-- City Names (naming theme: Capital is Charlotte's Peak, other cities after cheese varieties
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 					CityName)
VALUES		('CIVILIZATION_NAGISA', 	'TXT_KEY_CITY_NAME_MADOMAGI_CHARLOTTES_PEAK'),
			('CIVILIZATION_NAGISA', 	'TXT_KEY_CITY_NAME_MADOMAGI_MASCARPONE'),
			('CIVILIZATION_NAGISA', 	'TXT_KEY_CITY_NAME_MADOMAGI_PARMIGIANO_REGGIANO'),
			('CIVILIZATION_NAGISA', 	'TXT_KEY_CITY_NAME_MADOMAGI_GORGONZOLA_DOLCE'),
			('CIVILIZATION_NAGISA', 	'TXT_KEY_CITY_NAME_MADOMAGI_MONTEREY_JACK'),
			('CIVILIZATION_NAGISA', 	'TXT_KEY_CITY_NAME_MADOMAGI_ROUMY'),
			('CIVILIZATION_NAGISA', 	'TXT_KEY_CITY_NAME_MADOMAGI_BEYAZ_PEYNIR'),
			('CIVILIZATION_NAGISA', 	'TXT_KEY_CITY_NAME_MADOMAGI_VASTERBOTTENSOST'),
			('CIVILIZATION_NAGISA', 	'TXT_KEY_CITY_NAME_MADOMAGI_MAJDOULE'),
			('CIVILIZATION_NAGISA', 	'TXT_KEY_CITY_NAME_MADOMAGI_SERRA_DA_ESTRELA'),
			('CIVILIZATION_NAGISA', 	'TXT_KEY_CITY_NAME_MADOMAGI_GBEJINA'),
			('CIVILIZATION_NAGISA', 	'TXT_KEY_CITY_NAME_MADOMAGI_ANTHOTYROS'),
			('CIVILIZATION_NAGISA', 	'TXT_KEY_CITY_NAME_MADOMAGI_WEISSLACKER'),
			('CIVILIZATION_NAGISA', 	'TXT_KEY_CITY_NAME_MADOMAGI_HALLOUMI'),
			('CIVILIZATION_NAGISA', 	'TXT_KEY_CITY_NAME_MADOMAGI_BERGKASE'),
			('CIVILIZATION_NAGISA', 	'TXT_KEY_CITY_NAME_MADOMAGI_KASHKAVAL');
			
			
INSERT INTO Civilization_CityNames
			(CivilizationType, 					CityName)
SELECT		('CIVILIZATION_NAGISA'),		Tag
FROM Language_en_US WHERE Tag LIKE ('TXT_KEY_CITY_NAME_NAGISA_ADDON%');

--*******************************************************************
-- Free Buildings (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 					BuildingClassType)
SELECT		('CIVILIZATION_NAGISA'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Free Techs (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_NAGISA'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Free Units (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_NAGISA'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--******************************************************************************************************************************************
--Religion (Church of Madoka)
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 					ReligionType)
VALUES		('CIVILIZATION_NAGISA', 	'RELIGION_CHURCH_OF_MADOKA');

--*******************************************************************
-- Spy Names (generic PMMM spy name list)
--*******************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		
			('CIVILIZATION_NAGISA', 	'TXT_KEY_SPY_NAME_MADOKA_0'),	
			('CIVILIZATION_NAGISA', 	'TXT_KEY_SPY_NAME_MADOKA_1'),
			('CIVILIZATION_NAGISA', 	'TXT_KEY_SPY_NAME_MADOKA_2'),
			('CIVILIZATION_NAGISA', 	'TXT_KEY_SPY_NAME_MADOKA_3'),
			('CIVILIZATION_NAGISA', 	'TXT_KEY_SPY_NAME_MADOKA_4'),
			('CIVILIZATION_NAGISA', 	'TXT_KEY_SPY_NAME_MADOKA_5'),
			('CIVILIZATION_NAGISA', 	'TXT_KEY_SPY_NAME_MADOKA_6'),
			('CIVILIZATION_NAGISA', 	'TXT_KEY_SPY_NAME_MADOKA_7'),
			('CIVILIZATION_NAGISA', 	'TXT_KEY_SPY_NAME_MADOKA_8'),
			('CIVILIZATION_NAGISA', 	'TXT_KEY_SPY_NAME_MADOKA_9');
