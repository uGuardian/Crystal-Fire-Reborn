--*******************************************************************
-- Planeptune (uses Japan as a baseline)
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage,	DerivativeCiv)

SELECT ('CIVILIZATION_VV_PLANEPTUNE_PL'), ('TXT_KEY_CIV_VV_PLANEPTUNE_PL_DESC'), ('TXT_KEY_CIV_VV_PLANEPTUNE_PL_SHORT_DESC'), ('TXT_KEY_CIV_VV_PLANEPTUNE_PL_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_VV_PLANEPTUNE_PL'), ('PLAYERCOLOR_VV_PLANEPTUNE_PL'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_VV_PLANEPTUNE_PL'), 0, ('CIV_ALPHA_ATLAS_VV_PLANEPTUNE_PL'), ('JAPAN'), ('VVPlaneptuneUMapImage.dds'),
('TXT_KEY_CIV5_DAWN_VV_PLANEPTUNE_PL_TEXT'),('DOM_VV_Plutia.dds'), ('PLANEPTUNE')

FROM Civilizations WHERE (Type = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Leader (Plutia)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 					LeaderheadType)
VALUES		('CIVILIZATION_VV_PLANEPTUNE_PL', 	'LEADER_VV_PLUTIA');	


--*******************************************************************
-- Unique Units (Animated Doll)
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 					UnitClassType, 			UnitType)
VALUES		('CIVILIZATION_VV_PLANEPTUNE_PL', 	'UNITCLASS_WARRIOR', 	'UNIT_VV_ANIMATED_DOLL');


--*******************************************************************
-- Unique Building (Pudding Parlor)
--*******************************************************************
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 					BuildingClassType, 			BuildingType)
VALUES		('CIVILIZATION_VV_PLANEPTUNE_PL', 	'BUILDINGCLASS_GRANARY', 	'BUILDING_VV_DAYCARE');


--******************************************************************************************************************************************
-- City Name (only lists the Capital. Lua will name other cities)
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 					CityName)
VALUES		('CIVILIZATION_VV_PLANEPTUNE_PL', 	'TXT_KEY_CITY_NAME_VV_HDNCAPITAL_PLANEPTUNE_PL');


--*******************************************************************
-- Free Buildings 
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 					BuildingClassType)
SELECT		('CIVILIZATION_VV_PLANEPTUNE_PL'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Free Techs (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 				TechType)
SELECT		('CIVILIZATION_VV_PLANEPTUNE_PL'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Free Units (extra Animated Doll)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_VV_PLANEPTUNE_PL'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

INSERT OR IGNORE INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType,			Count,	UnitAIType)
VALUES		('CIVILIZATION_VV_PLANEPTUNE_PL',	'UNITCLASS_WARRIOR',	1,		'UNITAI_EXPLORE');


--******************************************************************************************************************************************
--Religion
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 				ReligionType)
VALUES		('CIVILIZATION_VV_PLANEPTUNE_PL',	'RELIGION_VV_PLANEPTUNE_PL');

--******************************************************************************************************************************************
-- Spy Names
--******************************************************************************************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 						SpyName)
VALUES		('CIVILIZATION_VV_PLANEPTUNE_PL',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_PL_0'),
			('CIVILIZATION_VV_PLANEPTUNE_PL',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_PL_1'),
			('CIVILIZATION_VV_PLANEPTUNE_PL',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_PL_2'),
			('CIVILIZATION_VV_PLANEPTUNE_PL',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_PL_3'),
			('CIVILIZATION_VV_PLANEPTUNE_PL',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_PL_4'),
			('CIVILIZATION_VV_PLANEPTUNE_PL',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_PL_5'),
			('CIVILIZATION_VV_PLANEPTUNE_PL',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_PL_6'),
			('CIVILIZATION_VV_PLANEPTUNE_PL',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_PL_7'),
			('CIVILIZATION_VV_PLANEPTUNE_PL',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_PL_8'),
			('CIVILIZATION_VV_PLANEPTUNE_PL',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_PL_9');

--******************************************************************************************************************************************
-- Start Bias
--******************************************************************************************************************************************


--Planeptune has no start bias



--*******************************************************************
-- COPIED PLANEPTUNE
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage, Playable, AIPlayable, DerivativeCiv)

SELECT ('CIVILIZATION_VV_PLANEPTUNE_IH'), ('TXT_KEY_CIV_VV_PLANEPTUNE_PL_DESC'), ('TXT_KEY_CIV_VV_PLANEPTUNE_PL_SHORT_DESC'), ('TXT_KEY_CIV_VV_PLANEPTUNE_PL_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_VV_PLANEPTUNE_PL'), ('PLAYERCOLOR_VV_PLANEPTUNE_PL'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_VV_PLANEPTUNE_PL'), 0, ('CIV_ALPHA_ATLAS_VV_PLANEPTUNE_PL'), ('JAPAN'), ('VVPlaneptuneUMapImage.dds'),
('TXT_KEY_CIV5_DAWN_VV_PLANEPTUNE_IH_TEXT'),('DOM_VV_IrisHeart.dds'), 0, 0, ('PLANEPTUNE')

FROM Civilizations WHERE (Type = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Leader (Iris Heart)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 					LeaderheadType)
VALUES		('CIVILIZATION_VV_PLANEPTUNE_IH', 	'LEADER_VV_IRIS_HEART');	


--*******************************************************************
-- Unique Units (Animated Doll)
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 					UnitClassType, 			UnitType)
VALUES		('CIVILIZATION_VV_PLANEPTUNE_IH', 	'UNITCLASS_WARRIOR', 	'UNIT_VV_ANIMATED_DOLL');


--*******************************************************************
-- Unique Building (Pudding Parlor)
--*******************************************************************
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 					BuildingClassType, 			BuildingType)
VALUES		('CIVILIZATION_VV_PLANEPTUNE_IH', 	'BUILDINGCLASS_GRANARY', 	'BUILDING_VV_DAYCARE');


--******************************************************************************************************************************************
-- City Name (only lists the Capital. Lua will name other cities)
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 				CityName)
VALUES		('CIVILIZATION_VV_PLANEPTUNE_IH', 	'TXT_KEY_CITY_NAME_VV_HDNCAPITAL_PLANEPTUNE_PL');


--*******************************************************************
-- Free Buildings (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 					BuildingClassType)
SELECT		('CIVILIZATION_VV_PLANEPTUNE_IH'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Free Techs (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_VV_PLANEPTUNE_IH'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Free Units (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_VV_PLANEPTUNE_IH'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--******************************************************************************************************************************************
--Religion
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 					ReligionType)
VALUES		('CIVILIZATION_VV_PLANEPTUNE_IH',	'RELIGION_VV_PLANEPTUNE_PL');

--******************************************************************************************************************************************
-- Spy Names
--******************************************************************************************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 						SpyName)
VALUES		('CIVILIZATION_VV_PLANEPTUNE_IH',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_PL_0'),
			('CIVILIZATION_VV_PLANEPTUNE_IH',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_PL_1'),
			('CIVILIZATION_VV_PLANEPTUNE_IH',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_PL_2'),
			('CIVILIZATION_VV_PLANEPTUNE_IH',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_PL_3'),
			('CIVILIZATION_VV_PLANEPTUNE_IH',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_PL_4'),
			('CIVILIZATION_VV_PLANEPTUNE_IH',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_PL_5'),
			('CIVILIZATION_VV_PLANEPTUNE_IH',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_PL_6'),
			('CIVILIZATION_VV_PLANEPTUNE_IH',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_PL_7'),
			('CIVILIZATION_VV_PLANEPTUNE_IH',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_PL_8'),
			('CIVILIZATION_VV_PLANEPTUNE_IH',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_PL_9');