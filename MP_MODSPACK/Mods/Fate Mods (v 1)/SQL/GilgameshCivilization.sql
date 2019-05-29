--All SQL Civilization inserts were based off of SQL code from JFD's Civilizations.


--*******************************************************************
-- Sumer (uses Assyria as a baseline)
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage)

SELECT ('CIVILIZATION_SUMER_FSN'), ('TXT_KEY_CIV_SUMER_FSN_DESC'), ('TXT_KEY_CIV_SUMER_FSN_SHORT_DESC'), ('TXT_KEY_CIV_SUMER_FSN_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_SUMER_FSN'), ('PLAYERCOLOR_SUMER_FSN'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_GILGAMESH_FSN'), 0, ('CIV_ALPHA_ATLAS_GILGAMESH_FSN'), ('BABYLON'), ('GilgameshSelectImage.dds'),
('TXT_KEY_CIV5_DAWN_GILGAMESH_FSN_TEXT'), ('DOM-Gilgamesh.dds')

FROM Civilizations WHERE (Type = 'CIVILIZATION_ASSYRIA');

--*******************************************************************
-- Leader (Gilgamesh)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 			LeaderheadType)
VALUES		('CIVILIZATION_SUMER_FSN', 	'LEADER_GILGAMESH_FSN');	






--*******************************************************************
-- Unique Buildings (Ziggurat, Vault)
--*******************************************************************

INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 			BuildingClassType, 					BuildingType)
VALUES		('CIVILIZATION_SUMER_FSN', 	'BUILDINGCLASS_SHRINE',				'BUILDING_ZIGGURAT_FSN'),
			('CIVILIZATION_SUMER_FSN', 	'BUILDINGCLASS_NATIONAL_TREASURY',	'BUILDING_GILGAMESH_VAULT');


--******************************************************************************************************************************************
-- City Names
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 					CityName)
VALUES		('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_CITY_NAME_SUMER_FSN_1'),
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_CITY_NAME_SUMER_FSN_2'),
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_CITY_NAME_SUMER_FSN_3'),
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_CITY_NAME_SUMER_FSN_4'),
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_CITY_NAME_SUMER_FSN_5'),
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_CITY_NAME_SUMER_FSN_6'),
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_CITY_NAME_SUMER_FSN_7'),
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_CITY_NAME_SUMER_FSN_8'),
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_CITY_NAME_SUMER_FSN_9'),
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_CITY_NAME_SUMER_FSN_10'),
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_CITY_NAME_SUMER_FSN_11'),
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_CITY_NAME_SUMER_FSN_12'),
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_CITY_NAME_SUMER_FSN_13'),
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_CITY_NAME_SUMER_FSN_14'),
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_CITY_NAME_SUMER_FSN_15'),
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_CITY_NAME_SUMER_FSN_16'),
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_CITY_NAME_SUMER_FSN_17'),
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_CITY_NAME_SUMER_FSN_18'),
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_CITY_NAME_SUMER_FSN_19'),
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_CITY_NAME_SUMER_FSN_20'),
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_CITY_NAME_SUMER_FSN_21'),
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_CITY_NAME_SUMER_FSN_22'),
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_CITY_NAME_SUMER_FSN_23'),
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_CITY_NAME_SUMER_FSN_24'),
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_CITY_NAME_SUMER_FSN_25'),
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_CITY_NAME_SUMER_FSN_26'),
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_CITY_NAME_SUMER_FSN_27'),
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_CITY_NAME_SUMER_FSN_28'),
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_CITY_NAME_SUMER_FSN_29'),
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_CITY_NAME_SUMER_FSN_30'),
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_CITY_NAME_SUMER_FSN_31'),
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_CITY_NAME_SUMER_FSN_32'),
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_CITY_NAME_SUMER_FSN_33'),
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_CITY_NAME_SUMER_FSN_34'),
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_CITY_NAME_SUMER_FSN_35'),
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_CITY_NAME_SUMER_FSN_36'),
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_CITY_NAME_SUMER_FSN_37');

--*******************************************************************
-- Free Buildings (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 				BuildingClassType)
SELECT		('CIVILIZATION_SUMER_FSN'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_ASSYRIA');

--*******************************************************************
-- Free Techs (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_SUMER_FSN'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_ASSYRIA');

--*******************************************************************
-- Free Units (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_SUMER_FSN'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_ASSYRIA');

--******************************************************************************************************************************************
--Religion (taken from America)
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 									ReligionType)
SELECT		('CIVILIZATION_SUMER_FSN'),				ReligionType
FROM Civilization_Religions WHERE (CivilizationType = 'CIVILIZATION_ASSYRIA');

--*******************************************************************
-- Spy Names
--*******************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_SPY_NAME_SUMER_FSN_0'),	
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_SPY_NAME_SUMER_FSN_1'),
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_SPY_NAME_SUMER_FSN_2'),
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_SPY_NAME_SUMER_FSN_3'),
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_SPY_NAME_SUMER_FSN_4'),
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_SPY_NAME_SUMER_FSN_5'),
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_SPY_NAME_SUMER_FSN_6'),
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_SPY_NAME_SUMER_FSN_7'),
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_SPY_NAME_SUMER_FSN_8'),
			('CIVILIZATION_SUMER_FSN', 	'TXT_KEY_SPY_NAME_SUMER_FSN_9');


--Start bias (Desert River)

INSERT INTO Civilization_Start_Along_River
			(CivilizationType,			StartAlongRiver)
VALUES		('CIVILIZATION_SUMER_FSN',	1);


INSERT INTO Civilization_Start_Region_Priority
			(CivilizationType,			RegionType)
VALUES		('CIVILIZATION_SUMER_FSN',	'REGION_DESERT');