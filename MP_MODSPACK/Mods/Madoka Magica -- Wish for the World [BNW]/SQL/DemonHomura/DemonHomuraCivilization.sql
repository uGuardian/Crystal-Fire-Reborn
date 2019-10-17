--*******************************************************************
-- Demon Homura's Civilization (uses Assyria as a baseline)
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage)

SELECT ('CIVILIZATION_DEMON_HOMURA'), ('TXT_KEY_CIV_DEMON_HOMURA_DESC'), ('TXT_KEY_CIV_DEMON_HOMURA_SHORT_DESC'), ('TXT_KEY_CIV_DEMON_HOMURA_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_DEMON_HOMURA'), ('PLAYERCOLOR_DEMON_HOMURA'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_DEMON_HOMURA'), 0, ('CIV_ALPHA_ATLAS_DEMON_HOMURA'), SoundtrackTag, ('HomuraRebellionSelectImage.dds'),
('TXT_KEY_CIV5_DAWN_DEMON_HOMURA_TEXT'), ('DOM_HomuraRebellion.dds')

FROM Civilizations WHERE (Type = 'CIVILIZATION_ASSYRIA');

--*******************************************************************
-- Leader (Demon Homura)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 				LeaderheadType)
VALUES		('CIVILIZATION_DEMON_HOMURA', 	'LEADER_DEMON_HOMURA');	


--*******************************************************************
-- Unique Buildings (NONE)
--*******************************************************************


--*******************************************************************
-- Unique Units (Incubator Slave & Clara Doll)
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 				UnitClassType, 				UnitType)
VALUES		('CIVILIZATION_DEMON_HOMURA', 	'UNITCLASS_WORKER', 		'UNIT_PMMM_INCUBATOR_SLAVE'),
			('CIVILIZATION_DEMON_HOMURA', 	'UNITCLASS_GREAT_GENERAL', 	'UNIT_PMMM_CLARA_DOLL');


--******************************************************************************************************************************************
-- City Names (naming theme: Capital is Homura's Realm, other cities after locations in the Divine Comedy and the Greek underworld
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 				CityName)
VALUES		('CIVILIZATION_DEMON_HOMURA', 	'TXT_KEY_CITY_NAME_MADOMAGI_HOMURAS_DIMENSION'),
			('CIVILIZATION_DEMON_HOMURA', 	'TXT_KEY_CITY_NAME_MADOMAGI_STYX'),
			('CIVILIZATION_DEMON_HOMURA', 	'TXT_KEY_CITY_NAME_MADOMAGI_PHLEGETHON'),
			('CIVILIZATION_DEMON_HOMURA', 	'TXT_KEY_CITY_NAME_MADOMAGI_ACHERON'),
			('CIVILIZATION_DEMON_HOMURA', 	'TXT_KEY_CITY_NAME_MADOMAGI_COCYTUS'),
			('CIVILIZATION_DEMON_HOMURA', 	'TXT_KEY_CITY_NAME_MADOMAGI_CAINA'),
			('CIVILIZATION_DEMON_HOMURA', 	'TXT_KEY_CITY_NAME_MADOMAGI_ANTENORA'),
			('CIVILIZATION_DEMON_HOMURA', 	'TXT_KEY_CITY_NAME_MADOMAGI_PTOLOMAEA'),
			('CIVILIZATION_DEMON_HOMURA', 	'TXT_KEY_CITY_NAME_MADOMAGI_JUDECCA'),
			('CIVILIZATION_DEMON_HOMURA', 	'TXT_KEY_CITY_NAME_MADOMAGI_ERIDANOS'),
			('CIVILIZATION_DEMON_HOMURA', 	'TXT_KEY_CITY_NAME_MADOMAGI_ALPHEUS'),
			('CIVILIZATION_DEMON_HOMURA', 	'TXT_KEY_CITY_NAME_MADOMAGI_TARTARUS'),
			('CIVILIZATION_DEMON_HOMURA', 	'TXT_KEY_CITY_NAME_MADOMAGI_PURGATORIO'),
			('CIVILIZATION_DEMON_HOMURA', 	'TXT_KEY_CITY_NAME_MADOMAGI_EDEN'),
			('CIVILIZATION_DEMON_HOMURA', 	'TXT_KEY_CITY_NAME_MADOMAGI_PARADISIO'),
			('CIVILIZATION_DEMON_HOMURA', 	'TXT_KEY_CITY_NAME_MADOMAGI_LOVE');
			
INSERT INTO Civilization_CityNames
			(CivilizationType, 					CityName)
SELECT		('CIVILIZATION_DEMON_HOMURA'),		Tag
FROM Language_en_US WHERE Tag LIKE ('TXT_KEY_CITY_NAME_DEMON_HOMURA_ADDON%');

--*******************************************************************
-- Free Buildings (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 					BuildingClassType)
SELECT		('CIVILIZATION_DEMON_HOMURA'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_ASSYRIA');

--*******************************************************************
-- Free Techs (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_DEMON_HOMURA'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_ASSYRIA');

--*******************************************************************
-- Free Units (Archer)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 				UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_DEMON_HOMURA'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_ASSYRIA');

INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 				UnitClassType,		Count,	UnitAIType)
VALUES		('CIVILIZATION_DEMON_HOMURA',	'UNITCLASS_ARCHER',	1,		'UNITAI_RANGED');

--******************************************************************************************************************************************
--Religion (Cult of Homura)
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 					ReligionType)
VALUES		('CIVILIZATION_DEMON_HOMURA', 	'RELIGION_CULT_OF_HOMURA');

--*******************************************************************
-- Spy Names (unique list based off of the Clara Dolls)
--*******************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		
			('CIVILIZATION_DEMON_HOMURA', 	'TXT_KEY_SPY_NAME_DEMON_HOMURA_0'),	
			('CIVILIZATION_DEMON_HOMURA', 	'TXT_KEY_SPY_NAME_DEMON_HOMURA_1'),
			('CIVILIZATION_DEMON_HOMURA', 	'TXT_KEY_SPY_NAME_DEMON_HOMURA_2'),
			('CIVILIZATION_DEMON_HOMURA', 	'TXT_KEY_SPY_NAME_DEMON_HOMURA_3'),
			('CIVILIZATION_DEMON_HOMURA', 	'TXT_KEY_SPY_NAME_DEMON_HOMURA_4'),
			('CIVILIZATION_DEMON_HOMURA', 	'TXT_KEY_SPY_NAME_DEMON_HOMURA_5'),
			('CIVILIZATION_DEMON_HOMURA', 	'TXT_KEY_SPY_NAME_DEMON_HOMURA_6'),
			('CIVILIZATION_DEMON_HOMURA', 	'TXT_KEY_SPY_NAME_DEMON_HOMURA_7'),
			('CIVILIZATION_DEMON_HOMURA', 	'TXT_KEY_SPY_NAME_DEMON_HOMURA_8'),
			('CIVILIZATION_DEMON_HOMURA', 	'TXT_KEY_SPY_NAME_DEMON_HOMURA_9');

