--*******************************************************************
-- CIA
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage)

SELECT ('CIVILIZATION_VV_CIA'), ('TXT_KEY_CIV_VV_CIA_DESC'), ('TXT_KEY_CIV_VV_CIA_SHORT_DESC'), ('TXT_KEY_CIV_VV_CIA_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_VV_CIA'), ('PLAYERCOLOR_VV_CIA'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_VV_CIA'), 0, ('CIV_ALPHA_ATLAS_VV_CIA'), ('AMERICA'), ('VVCIAMapImage.dds'),
('TXT_KEY_CIV5_DAWN_VV_CIA_TEXT'), ('DOM_VV_CIA.dds')

FROM Civilizations WHERE (Type = 'CIVILIZATION_AMERICA');

--*******************************************************************
-- Leader (CIA)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 			LeaderheadType)
VALUES		('CIVILIZATION_VV_CIA', 	'LEADER_VV_BILL_WILSON');	


--*******************************************************************
-- Unique Buildings
--*******************************************************************
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 			BuildingClassType, 						BuildingType)
VALUES		('CIVILIZATION_VV_CIA', 	'BUILDINGCLASS_INTELLIGENCE_AGENCY', 	'BUILDING_VV_CIA_AGENT_SEA');


--*******************************************************************
-- Unique Units
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 			UnitClassType, 					UnitType)
VALUES		('CIVILIZATION_VV_CIA', 	'UNITCLASS_GREAT_WAR_INFANTRY', 'UNIT_VV_HOTHEAD');


--******************************************************************************************************************************************
-- City Names
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 			CityName)
SELECT		('CIVILIZATION_VV_CIA'), 	Tag
FROM Language_en_US WHERE Tag LIKE ('TXT_KEY_CITY_NAME_VV_CIA%');


--*******************************************************************
-- Free Buildings (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 			BuildingClassType)
SELECT		('CIVILIZATION_VV_CIA'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_AMERICA');

--*******************************************************************
-- Free Techs (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 			TechType)
SELECT		('CIVILIZATION_VV_CIA'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_AMERICA');

--*******************************************************************
-- Free Units (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 			UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_VV_CIA'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_AMERICA');

--******************************************************************************************************************************************
--Religion
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 				ReligionType)
SELECT		('CIVILIZATION_VV_CIA'),		ReligionType
FROM Civilization_Religions WHERE (CivilizationType = 'CIVILIZATION_AMERICA');

--******************************************************************************************************************************************
-- Spy Names
--******************************************************************************************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 			SpyName)
VALUES		('CIVILIZATION_VV_CIA',		'TXT_KEY_SPY_NAME_VV_CIA_0'),
			('CIVILIZATION_VV_CIA',		'TXT_KEY_SPY_NAME_VV_CIA_1'),
			('CIVILIZATION_VV_CIA',		'TXT_KEY_SPY_NAME_VV_CIA_2'),
			('CIVILIZATION_VV_CIA',		'TXT_KEY_SPY_NAME_VV_CIA_3'),
			('CIVILIZATION_VV_CIA',		'TXT_KEY_SPY_NAME_VV_CIA_4'),
			('CIVILIZATION_VV_CIA',		'TXT_KEY_SPY_NAME_VV_CIA_5'),
			('CIVILIZATION_VV_CIA',		'TXT_KEY_SPY_NAME_VV_CIA_6'),
			('CIVILIZATION_VV_CIA',		'TXT_KEY_SPY_NAME_VV_CIA_7'),
			('CIVILIZATION_VV_CIA',		'TXT_KEY_SPY_NAME_VV_CIA_8'),
			('CIVILIZATION_VV_CIA',		'TXT_KEY_SPY_NAME_VV_CIA_9');