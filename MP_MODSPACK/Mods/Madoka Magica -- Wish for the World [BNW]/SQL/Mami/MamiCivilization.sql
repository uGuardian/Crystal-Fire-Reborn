--All SQL Civilization inserts were based off of SQL code from JFD's Civilizations.


--*******************************************************************
-- Mami's Civilization (uses Rome as a baseline)
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage)

SELECT ('CIVILIZATION_MAMI'), ('TXT_KEY_CIV_MAMI_DESC'), ('TXT_KEY_CIV_MAMI_SHORT_DESC'), ('TXT_KEY_CIV_MAMI_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_MAMI'), ('PLAYERCOLOR_MAMI'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_MAMI'), 0, ('CIV_ALPHA_ATLAS_MAMI'), SoundtrackTag, ('MamiSelectImage.dds'),
('TXT_KEY_CIV5_DAWN_MAMI_TEXT'), ('DOM_Mami.dds')

FROM Civilizations WHERE (Type = 'CIVILIZATION_ROME');

--*******************************************************************
-- Leader (Mami)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 					LeaderheadType)
VALUES		('CIVILIZATION_MAMI', 	'LEADER_MAMI');	


--*******************************************************************
-- Unique Buildings (Teahouse)
--*******************************************************************
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 					BuildingClassType, 					BuildingType)
VALUES		('CIVILIZATION_MAMI', 	'BUILDINGCLASS_CARAVANSARY', 	'BUILDING_PMMM_TEAHOUSE');


--*******************************************************************
-- Unique Units (Tiro Musketeer)
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 					UnitClassType, 			UnitType)
VALUES		('CIVILIZATION_MAMI', 	'UNITCLASS_RIFLEMAN', 	'UNIT_PMMM_TIRO_MUSKETEER');


--******************************************************************************************************************************************
-- City Names (naming theme: Capital is Citta di Tiro, other cities after some silly stuff translated into Italian by Google
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 					CityName)
VALUES		('CIVILIZATION_MAMI', 	'TXT_KEY_CITY_NAME_MADOMAGI_CITTA_DI_TIRO'),
			('CIVILIZATION_MAMI', 	'TXT_KEY_CITY_NAME_MADOMAGI_ROMA_NUOVA'),
			('CIVILIZATION_MAMI', 	'TXT_KEY_CITY_NAME_MADOMAGI_PALLOTTOLA'),
			('CIVILIZATION_MAMI', 	'TXT_KEY_CITY_NAME_MADOMAGI_LEGGE_DEI_CICLI'),
			('CIVILIZATION_MAMI', 	'TXT_KEY_CITY_NAME_MADOMAGI_PICCO_DI_SPERANZA'),
			('CIVILIZATION_MAMI', 	'TXT_KEY_CITY_NAME_MADOMAGI_COVE_MISTICO'),
			('CIVILIZATION_MAMI', 	'TXT_KEY_CITY_NAME_MADOMAGI_EGIDA'),
			('CIVILIZATION_MAMI', 	'TXT_KEY_CITY_NAME_MADOMAGI_NASTRI_DORO'),
			('CIVILIZATION_MAMI', 	'TXT_KEY_CITY_NAME_MADOMAGI_MILIONI_DI_MOSCHETTI'),
			('CIVILIZATION_MAMI', 	'TXT_KEY_CITY_NAME_MADOMAGI_AMICIZIA'),
			('CIVILIZATION_MAMI', 	'TXT_KEY_CITY_NAME_MADOMAGI_TERRITORIO_ASSOLUTA'),
			('CIVILIZATION_MAMI', 	'TXT_KEY_CITY_NAME_MADOMAGI_ROGO_DELLA_STREGA'),
			('CIVILIZATION_MAMI', 	'TXT_KEY_CITY_NAME_MADOMAGI_PASE_FOGLIA_DI_TE'),
			('CIVILIZATION_MAMI', 	'TXT_KEY_CITY_NAME_MADOMAGI_TORTACITTA'),
			('CIVILIZATION_MAMI', 	'TXT_KEY_CITY_NAME_MADOMAGI_DUE_CANNONI_ENORMI'),
			('CIVILIZATION_MAMI', 	'TXT_KEY_CITY_NAME_MADOMAGI_MA_QUESTO_E_AMORE_PROIBITO');
			
			
INSERT INTO Civilization_CityNames
			(CivilizationType, 					CityName)
SELECT		('CIVILIZATION_MAMI'),		Tag
FROM Language_en_US WHERE Tag LIKE ('TXT_KEY_CITY_NAME_MAMI_ADDON%');

--*******************************************************************
-- Free Buildings (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 					BuildingClassType)
SELECT		('CIVILIZATION_MAMI'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_ROME');

--*******************************************************************
-- Free Techs (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_MAMI'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_ROME');

--*******************************************************************
-- Free Units (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_MAMI'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_ROME');

--******************************************************************************************************************************************
--Religion (Church of Madoka)
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 					ReligionType)
VALUES		('CIVILIZATION_MAMI', 	'RELIGION_CHURCH_OF_MADOKA');

--*******************************************************************
-- Spy Names (generic PMMM spy name list)
--*******************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		
			('CIVILIZATION_MAMI', 	'TXT_KEY_SPY_NAME_MADOKA_0'),	
			('CIVILIZATION_MAMI', 	'TXT_KEY_SPY_NAME_MADOKA_1'),
			('CIVILIZATION_MAMI', 	'TXT_KEY_SPY_NAME_MADOKA_2'),
			('CIVILIZATION_MAMI', 	'TXT_KEY_SPY_NAME_MADOKA_3'),
			('CIVILIZATION_MAMI', 	'TXT_KEY_SPY_NAME_MADOKA_4'),
			('CIVILIZATION_MAMI', 	'TXT_KEY_SPY_NAME_MADOKA_5'),
			('CIVILIZATION_MAMI', 	'TXT_KEY_SPY_NAME_MADOKA_6'),
			('CIVILIZATION_MAMI', 	'TXT_KEY_SPY_NAME_MADOKA_7'),
			('CIVILIZATION_MAMI', 	'TXT_KEY_SPY_NAME_MADOKA_8'),
			('CIVILIZATION_MAMI', 	'TXT_KEY_SPY_NAME_MADOKA_9');

