--*******************************************************************
-- Planeptune (uses Japan as a baseline)
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage,	DerivativeCiv)

SELECT ('CIVILIZATION_VV_PLANEPTUNE'), ('TXT_KEY_CIV_VV_PLANEPTUNE_DESC'), ('TXT_KEY_CIV_VV_PLANEPTUNE_SHORT_DESC'), ('TXT_KEY_CIV_VV_PLANEPTUNE_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_VV_PLANEPTUNE'), ('PLAYERCOLOR_VV_PLANEPTUNE'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_VV_PLANEPTUNE'), 0, ('CIV_ALPHA_ATLAS_VV_PLANEPTUNE'), ('JAPAN'), ('VVPlaneptuneMapImage.dds'),
('TXT_KEY_CIV5_DAWN_VV_PLANEPTUNE_TEXT'),
(CASE WHEN EXISTS(SELECT * FROM VV_NeptuneModOptions WHERE Type = 'OUTFIT' AND Value = 2)
	THEN 'DOM_VV_NeptuneAlt.dds'
	ELSE 'DOM_VV_Neptune.dds'
END), ('PLANEPTUNE')

FROM Civilizations WHERE (Type = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Leader (Neptune)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 				LeaderheadType)
VALUES		('CIVILIZATION_VV_PLANEPTUNE', 	'LEADER_VV_NEPTUNE');	


--*******************************************************************
-- Unique Units (Dogoo Knight)
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 				UnitClassType, 			UnitType)
VALUES		('CIVILIZATION_VV_PLANEPTUNE', 	'UNITCLASS_KNIGHT', 	'UNIT_VV_DOGOO_KNIGHT');

--*******************************************************************
-- Unique Building (Pudding Parlor)
--*******************************************************************
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 				BuildingClassType, 			BuildingType)
VALUES		('CIVILIZATION_VV_PLANEPTUNE', 	'BUILDINGCLASS_STABLE', 	'BUILDING_VV_PUDDING_PARLOR');


--******************************************************************************************************************************************
-- City Name (only lists the Capital. Lua will name other cities)
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 				CityName)
VALUES		('CIVILIZATION_VV_PLANEPTUNE', 	'TXT_KEY_CITY_NAME_VV_HDNCAPITAL_PLANEPTUNE');


--*******************************************************************
-- Free Buildings (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 					BuildingClassType)
SELECT		('CIVILIZATION_VV_PLANEPTUNE'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Free Techs (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 				TechType)
SELECT		('CIVILIZATION_VV_PLANEPTUNE'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Free Units (Gets a Scout)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 				UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_VV_PLANEPTUNE'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_JAPAN');


--******************************************************************************************************************************************
--Religion
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 				ReligionType)
VALUES		('CIVILIZATION_VV_PLANEPTUNE',	'RELIGION_VV_PLANEPTUNE');

--******************************************************************************************************************************************
-- Spy Names
--******************************************************************************************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		('CIVILIZATION_VV_PLANEPTUNE',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_0'),
			('CIVILIZATION_VV_PLANEPTUNE',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_1'),
			('CIVILIZATION_VV_PLANEPTUNE',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_2'),
			('CIVILIZATION_VV_PLANEPTUNE',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_3'),
			('CIVILIZATION_VV_PLANEPTUNE',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_4'),
			('CIVILIZATION_VV_PLANEPTUNE',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_5'),
			('CIVILIZATION_VV_PLANEPTUNE',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_6'),
			('CIVILIZATION_VV_PLANEPTUNE',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_7'),
			('CIVILIZATION_VV_PLANEPTUNE',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_8'),
			('CIVILIZATION_VV_PLANEPTUNE',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_9');

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

SELECT ('CIVILIZATION_VV_PLANEPTUNE_PH'), ('TXT_KEY_CIV_VV_PLANEPTUNE_DESC'), ('TXT_KEY_CIV_VV_PLANEPTUNE_SHORT_DESC'), ('TXT_KEY_CIV_VV_PLANEPTUNE_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_VV_PLANEPTUNE'), ('PLAYERCOLOR_VV_PLANEPTUNE'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_VV_PLANEPTUNE'), 0, ('CIV_ALPHA_ATLAS_VV_PLANEPTUNE'), ('JAPAN'), ('VVPlaneptuneMapImage.dds'),
('TXT_KEY_CIV5_DAWN_VV_PLANEPTUNE_PH_TEXT'), 
CASE WHEN EXISTS(SELECT * FROM VV_NeptuneModOptions WHERE Type = 'OUTFIT' AND Value = 2)
	THEN 'DOM_VV_PurpleHeartAlt.dds'
	ELSE 'DOM_VV_PurpleHeart.dds'
END,
0, 0, ('PLANEPTUNE')

FROM Civilizations WHERE (Type = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Leader (Purple Heart)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 					LeaderheadType)
VALUES		('CIVILIZATION_VV_PLANEPTUNE_PH', 	'LEADER_VV_PURPLE_HEART');	


--*******************************************************************
-- Unique Units (Dogoo Knight)
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 					UnitClassType, 			UnitType)
VALUES		('CIVILIZATION_VV_PLANEPTUNE_PH', 	'UNITCLASS_KNIGHT', 	'UNIT_VV_DOGOO_KNIGHT');


--*******************************************************************
-- Unique Building (Pudding Parlor)
--*******************************************************************
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 					BuildingClassType, 			BuildingType)
VALUES		('CIVILIZATION_VV_PLANEPTUNE_PH', 	'BUILDINGCLASS_STABLE', 	'BUILDING_VV_PUDDING_PARLOR');


--******************************************************************************************************************************************
-- City Name (only lists the Capital. Lua will name other cities)
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 				CityName)
VALUES		('CIVILIZATION_VV_PLANEPTUNE_PH', 	'TXT_KEY_CITY_NAME_VV_HDNCAPITAL_PLANEPTUNE');


--*******************************************************************
-- Free Buildings (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 					BuildingClassType)
SELECT		('CIVILIZATION_VV_PLANEPTUNE_PH'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Free Techs (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_VV_PLANEPTUNE_PH'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Free Units (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_VV_PLANEPTUNE_PH'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--******************************************************************************************************************************************
--Religion
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 					ReligionType)
VALUES		('CIVILIZATION_VV_PLANEPTUNE_PH',	'RELIGION_VV_PLANEPTUNE');

--******************************************************************************************************************************************
-- Spy Names
--******************************************************************************************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 						SpyName)
VALUES		('CIVILIZATION_VV_PLANEPTUNE_PH',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_0'),
			('CIVILIZATION_VV_PLANEPTUNE_PH',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_1'),
			('CIVILIZATION_VV_PLANEPTUNE_PH',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_2'),
			('CIVILIZATION_VV_PLANEPTUNE_PH',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_3'),
			('CIVILIZATION_VV_PLANEPTUNE_PH',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_4'),
			('CIVILIZATION_VV_PLANEPTUNE_PH',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_5'),
			('CIVILIZATION_VV_PLANEPTUNE_PH',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_6'),
			('CIVILIZATION_VV_PLANEPTUNE_PH',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_7'),
			('CIVILIZATION_VV_PLANEPTUNE_PH',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_8'),
			('CIVILIZATION_VV_PLANEPTUNE_PH',		'TXT_KEY_SPY_NAME_VV_PLANEPTUNE_9');


