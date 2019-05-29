--*******************************************************************
-- Planeptune mk2 (uses Japan as a baseline)
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage, DerivativeCiv)

SELECT ('CIVILIZATION_VV_PLANEPTUNE_NG'), ('TXT_KEY_CIV_VV_PLANEPTUNE_NG_DESC'), ('TXT_KEY_CIV_VV_PLANEPTUNE_NG_SHORT_DESC'), ('TXT_KEY_CIV_VV_PLANEPTUNE_NG_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_VV_PLANEPTUNE_NG'), ('PLAYERCOLOR_VV_PLANEPTUNE_NG'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_VV_PLANEPTUNE_NG'), 0, ('CIV_ALPHA_ATLAS_VV_PLANEPTUNE_NG'), ('JAPAN'), ('VVNepgearMapImage.dds'),
('TXT_KEY_CIV5_DAWN_VV_PLANEPTUNE_NG_TEXT'), ('DOM_VV_Nepgear.dds'), ('PLANEPTUNE')

FROM Civilizations WHERE (Type = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Leader (Nepgear)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 					LeaderheadType)
VALUES		('CIVILIZATION_VV_PLANEPTUNE_NG', 	'LEADER_VV_NEPGEAR');	


--*******************************************************************
-- Unique Units (Gearnaught)
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 					UnitClassType, 			UnitType)
VALUES		('CIVILIZATION_VV_PLANEPTUNE_NG', 	'UNITCLASS_CAVALRY', 	'UNIT_VV_GEARNAUGHT');

--*******************************************************************
-- Unique Building (Hardware Store)
--*******************************************************************
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 					BuildingClassType, 			BuildingType)
VALUES		('CIVILIZATION_VV_PLANEPTUNE_NG', 	'BUILDINGCLASS_WORKSHOP', 	'BUILDING_VV_HARDWARE_STORE');


--******************************************************************************************************************************************
-- City Name (only lists the Capital. Lua will name other cities)
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 					CityName)
VALUES		('CIVILIZATION_VV_PLANEPTUNE_NG', 	'TXT_KEY_CITY_NAME_VV_HDNCAPITAL_PLANEPTUNE_NG');


--*******************************************************************
-- Free Buildings (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 					BuildingClassType)
SELECT		('CIVILIZATION_VV_PLANEPTUNE_NG'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Free Techs (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 				TechType)
SELECT		('CIVILIZATION_VV_PLANEPTUNE_NG'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Free Units (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 				UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_VV_PLANEPTUNE_NG'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--******************************************************************************************************************************************
--Religion
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 					ReligionType)
VALUES		('CIVILIZATION_VV_PLANEPTUNE_NG',	'RELIGION_VV_PLANEPTUNE_NG');

--******************************************************************************************************************************************
-- Spy Names
--******************************************************************************************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 						SpyName)
VALUES		('CIVILIZATION_VV_PLANEPTUNE_NG',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_NG_0'),
			('CIVILIZATION_VV_PLANEPTUNE_NG',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_NG_1'),
			('CIVILIZATION_VV_PLANEPTUNE_NG',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_NG_2'),
			('CIVILIZATION_VV_PLANEPTUNE_NG',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_NG_3'),
			('CIVILIZATION_VV_PLANEPTUNE_NG',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_NG_4'),
			('CIVILIZATION_VV_PLANEPTUNE_NG',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_NG_5'),
			('CIVILIZATION_VV_PLANEPTUNE_NG',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_NG_6'),
			('CIVILIZATION_VV_PLANEPTUNE_NG',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_NG_7'),
			('CIVILIZATION_VV_PLANEPTUNE_NG',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_NG_8'),
			('CIVILIZATION_VV_PLANEPTUNE_NG',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_NG_9');

--Events and Decisions changes things up a bit
DELETE FROM Civilization_SpyNames WHERE SpyName IN ('TXT_KEY_SPY_NAME_VV_PLANEPTUNE_NG_1', 'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_NG_2') AND EXISTS(SELECT * FROM Buildings WHERE Type = 'BUILDING_DECISIONS_BYZANTIUMWALLS');

INSERT INTO Civilization_SpyNames 
			(CivilizationType, 						SpyName)
SELECT		('CIVILIZATION_VV_PLANEPTUNE_NG'),		('TXT_KEY_SPY_NAME_VV_PLANEPTUNE_NG_1_ALT')
WHERE EXISTS(SELECT * FROM Buildings WHERE Type = 'BUILDING_DECISIONS_BYZANTIUMWALLS');

INSERT INTO Civilization_SpyNames 
			(CivilizationType, 						SpyName)
SELECT		('CIVILIZATION_VV_PLANEPTUNE_NG'),		('TXT_KEY_SPY_NAME_VV_PLANEPTUNE_NG_2_ALT')
WHERE EXISTS(SELECT * FROM Buildings WHERE Type = 'BUILDING_DECISIONS_BYZANTIUMWALLS');

--******************************************************************************************************************************************
-- Start Bias
--******************************************************************************************************************************************


--Planeptune has no start bias





--*******************************************************************
-- COPIED PLANEPTUNE MK2 
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage, Playable, AIPlayable, DerivativeCiv)

SELECT ('CIVILIZATION_VV_PLANEPTUNE_PS'), ('TXT_KEY_CIV_VV_PLANEPTUNE_NG_DESC'), ('TXT_KEY_CIV_VV_PLANEPTUNE_NG_SHORT_DESC'), ('TXT_KEY_CIV_VV_PLANEPTUNE_NG_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_VV_PLANEPTUNE_NG'), ('PLAYERCOLOR_VV_PLANEPTUNE_NG'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_VV_PLANEPTUNE_NG'), 0, ('CIV_ALPHA_ATLAS_VV_PLANEPTUNE_NG'), ('JAPAN'), ('VVNepgearMapImage.dds'),
('TXT_KEY_CIV5_DAWN_VV_PLANEPTUNE_PS_TEXT'), ('DOM_VV_PurpleSister.dds'), 0, 0, ('PLANEPTUNE')

FROM Civilizations WHERE (Type = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Leader (Purple Sister)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 					LeaderheadType)
VALUES		('CIVILIZATION_VV_PLANEPTUNE_PS', 	'LEADER_VV_PURPLE_SISTER');	


--*******************************************************************
-- Unique Units (Gearnaught)
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 					UnitClassType, 			UnitType)
VALUES		('CIVILIZATION_VV_PLANEPTUNE_PS', 	'UNITCLASS_CAVALRY', 	'UNIT_VV_GEARNAUGHT');


--*******************************************************************
-- Unique Building (Hardware Store)
--*******************************************************************
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 					BuildingClassType, 			BuildingType)
VALUES		('CIVILIZATION_VV_PLANEPTUNE_PS', 	'BUILDINGCLASS_WORKSHOP', 	'BUILDING_VV_HARDWARE_STORE');


--******************************************************************************************************************************************
-- City Name (only lists the Capital. Lua will name other cities)
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 				CityName)
VALUES		('CIVILIZATION_VV_PLANEPTUNE_PS', 	'TXT_KEY_CITY_NAME_VV_HDNCAPITAL_PLANEPTUNE_NG');


--*******************************************************************
-- Free Buildings (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 					BuildingClassType)
SELECT		('CIVILIZATION_VV_PLANEPTUNE_PS'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Free Techs (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_VV_PLANEPTUNE_PS'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Free Units (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_VV_PLANEPTUNE_PS'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--******************************************************************************************************************************************
--Religion
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 					ReligionType)
VALUES		('CIVILIZATION_VV_PLANEPTUNE_PS',	'RELIGION_VV_PLANEPTUNE_NG');

--******************************************************************************************************************************************
-- Spy Names
--******************************************************************************************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 						SpyName)
VALUES		('CIVILIZATION_VV_PLANEPTUNE_PS',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_NG_0'),
			('CIVILIZATION_VV_PLANEPTUNE_PS',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_NG_1'),
			('CIVILIZATION_VV_PLANEPTUNE_PS',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_NG_2'),
			('CIVILIZATION_VV_PLANEPTUNE_PS',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_NG_3'),
			('CIVILIZATION_VV_PLANEPTUNE_PS',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_NG_4'),
			('CIVILIZATION_VV_PLANEPTUNE_PS',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_NG_5'),
			('CIVILIZATION_VV_PLANEPTUNE_PS',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_NG_6'),
			('CIVILIZATION_VV_PLANEPTUNE_PS',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_NG_7'),
			('CIVILIZATION_VV_PLANEPTUNE_PS',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_NG_8'),
			('CIVILIZATION_VV_PLANEPTUNE_PS',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_NG_9');


--******************************************************************************************************************************************
-- Start Bias
--******************************************************************************************************************************************


--Coast

INSERT INTO Civilization_Start_Along_Ocean
			(CivilizationType,					StartAlongOcean)
VALUES		('CIVILIZATION_VV_PLANEPTUNE_NG',	1),
			('CIVILIZATION_VV_PLANEPTUNE_PS',	1);
