--All SQL Civilization inserts were based off of SQL code from JFD's Civilizations.


--*******************************************************************
-- Praetoria (uses Rome as a baseline)
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage)

SELECT ('CIVILIZATION_PRAETORIA'), ('TXT_KEY_CIV_PRAETORIA_DESC'), ('TXT_KEY_CIV_PRAETORIA_SHORT_DESC'), ('TXT_KEY_CIV_PRAETORIA_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_PRAETORIA'), ('PLAYERCOLOR_PRAETORIA'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_PRAETORIA'), 0, ('CIV_ALPHA_ATLAS_PRAETORIA'), ('AMERICA'), ('TyrantSelectImage.dds'),
('TXT_KEY_CIV5_DAWN_TYRANT_TEXT'), ('DOM-Tyrant.dds')

FROM Civilizations WHERE (Type = 'CIVILIZATION_AMERICA');

--*******************************************************************
-- Leader (Cole)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 			LeaderheadType)
VALUES		('CIVILIZATION_PRAETORIA', 	'LEADER_TYRANT');	


--*******************************************************************
-- Unique Buildings (BAF)
--*******************************************************************
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 			BuildingClassType, 				BuildingType)
VALUES		('CIVILIZATION_PRAETORIA', 	'BUILDINGCLASS_CONSTABLE', 	'BUILDING_PRAETORIA_BAF');


--*******************************************************************
-- Unique Units (War Walker)
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 			UnitClassType, 			UnitType)
VALUES		('CIVILIZATION_PRAETORIA', 	'UNITCLASS_MECH', 	'UNIT_PRAETORIAN_WAR_WALKER');


--******************************************************************************************************************************************
-- City Names
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 					CityName)
VALUES		('CIVILIZATION_PRAETORIA', 	'TXT_KEY_CITY_NAME_PRAETORIA_1'),
			('CIVILIZATION_PRAETORIA', 	'TXT_KEY_CITY_NAME_PRAETORIA_2'),
			('CIVILIZATION_PRAETORIA', 	'TXT_KEY_CITY_NAME_PRAETORIA_3'),
			('CIVILIZATION_PRAETORIA', 	'TXT_KEY_CITY_NAME_PRAETORIA_4'),
			('CIVILIZATION_PRAETORIA', 	'TXT_KEY_CITY_NAME_PRAETORIA_5'),
			('CIVILIZATION_PRAETORIA', 	'TXT_KEY_CITY_NAME_PRAETORIA_6');

			--City after 4 is Lua-assigned and is either Keyes Island or Keyesopolis depending on landmass size
			--After city #7, city names will automatically be generated in the format "Ward #x" where x is a number greater than 1

--*******************************************************************
-- Free Buildings (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 					BuildingClassType)
SELECT		('CIVILIZATION_PRAETORIA'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_ROME');

--*******************************************************************
-- Free Techs (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_PRAETORIA'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_ROME');

--*******************************************************************
-- Free Units (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_PRAETORIA'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_ROME');

--******************************************************************************************************************************************
--Religion
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 				ReligionType)
SELECT		('CIVILIZATION_PRAETORIA'), 	ReligionType
FROM Civilization_Religions WHERE (CivilizationType = 'CIVILIZATION_ROME');

--*******************************************************************
-- Spy Names (generic PMMM spy name list)
--*******************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		
			('CIVILIZATION_PRAETORIA', 	'TXT_KEY_SPY_NAME_PRAETORIA_0'),	
			('CIVILIZATION_PRAETORIA', 	'TXT_KEY_SPY_NAME_PRAETORIA_1'),
			('CIVILIZATION_PRAETORIA', 	'TXT_KEY_SPY_NAME_PRAETORIA_2'),
			('CIVILIZATION_PRAETORIA', 	'TXT_KEY_SPY_NAME_PRAETORIA_3'),
			('CIVILIZATION_PRAETORIA', 	'TXT_KEY_SPY_NAME_PRAETORIA_4'),
			('CIVILIZATION_PRAETORIA', 	'TXT_KEY_SPY_NAME_PRAETORIA_5'),
			('CIVILIZATION_PRAETORIA', 	'TXT_KEY_SPY_NAME_PRAETORIA_6'),
			('CIVILIZATION_PRAETORIA', 	'TXT_KEY_SPY_NAME_PRAETORIA_7'),
			('CIVILIZATION_PRAETORIA', 	'TXT_KEY_SPY_NAME_PRAETORIA_8'),
			('CIVILIZATION_PRAETORIA', 	'TXT_KEY_SPY_NAME_PRAETORIA_9');



INSERT INTO Civilization_Start_Along_River
			(CivilizationType,			StartAlongRiver)
VALUES		('CIVILIZATION_PRAETORIA',	1);


INSERT INTO Civilization_Start_Region_Priority
			(CivilizationType,			RegionType)
VALUES		('CIVILIZATION_PRAETORIA',	'REGION_JUNGLE');