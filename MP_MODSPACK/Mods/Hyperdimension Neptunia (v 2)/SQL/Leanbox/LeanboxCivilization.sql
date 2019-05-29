--*******************************************************************
-- Leanbox (uses England as a baseline)
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage, DerivativeCiv)

SELECT ('CIVILIZATION_VV_LEANBOX'), ('TXT_KEY_CIV_VV_LEANBOX_DESC'), ('TXT_KEY_CIV_VV_LEANBOX_SHORT_DESC'), ('TXT_KEY_CIV_VV_LEANBOX_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_VV_LEANBOX'), ('PLAYERCOLOR_VV_LEANBOX'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_VV_LEANBOX'), 0, ('CIV_ALPHA_ATLAS_VV_LEANBOX'), ('ENGLAND'), ('VVVertMapImage.dds'),
('TXT_KEY_CIV5_DAWN_VV_LEANBOX_TEXT'), ('DOM_VV_Vert.dds'), ('LEANBOX')

FROM Civilizations WHERE (Type = 'CIVILIZATION_ENGLAND');

--*******************************************************************
-- Leader (Vert)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 				LeaderheadType)
VALUES		('CIVILIZATION_VV_LEANBOX', 	'LEADER_VV_VERT');	


--*******************************************************************
-- Unique Buildings (Leanbox Live Arcade)
--*******************************************************************
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 				BuildingClassType, 			BuildingType)
VALUES		('CIVILIZATION_VV_LEANBOX', 	'BUILDINGCLASS_COLOSSEUM', 	'BUILDING_VV_LEANBOX_ARCADE');


--*******************************************************************
-- Unique Units (Ran-Ran)
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 				UnitClassType, 			UnitType)
VALUES		('CIVILIZATION_VV_LEANBOX', 	'UNITCLASS_WORKER', 	'UNIT_VV_RANRAN');


--******************************************************************************************************************************************
-- City Name (only lists the Capital. Lua will name other cities)
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 				CityName)
VALUES		('CIVILIZATION_VV_LEANBOX', 	'TXT_KEY_CITY_NAME_VV_HDNCAPITAL_LEANBOX');


--*******************************************************************
-- Free Buildings (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 				BuildingClassType)
SELECT		('CIVILIZATION_VV_LEANBOX'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_ENGLAND');

--*******************************************************************
-- Free Techs (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 				TechType)
SELECT		('CIVILIZATION_VV_LEANBOX'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_ENGLAND');

--*******************************************************************
-- Free Units (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 				UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_VV_LEANBOX'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_ENGLAND');

--******************************************************************************************************************************************
--Religion
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 					ReligionType)
VALUES		('CIVILIZATION_VV_LEANBOX',			'RELIGION_VV_LEANBOX');

--******************************************************************************************************************************************
-- Spy Names
--******************************************************************************************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 				SpyName)
VALUES		('CIVILIZATION_VV_LEANBOX',		'TXT_KEY_SPY_NAME_VV_LEANBOX_0'),
			('CIVILIZATION_VV_LEANBOX',		'TXT_KEY_SPY_NAME_VV_LEANBOX_1'),
			('CIVILIZATION_VV_LEANBOX',		'TXT_KEY_SPY_NAME_VV_LEANBOX_2'),
			('CIVILIZATION_VV_LEANBOX',		'TXT_KEY_SPY_NAME_VV_LEANBOX_3'),
			('CIVILIZATION_VV_LEANBOX',		'TXT_KEY_SPY_NAME_VV_LEANBOX_4'),
			('CIVILIZATION_VV_LEANBOX',		'TXT_KEY_SPY_NAME_VV_LEANBOX_5'),
			('CIVILIZATION_VV_LEANBOX',		'TXT_KEY_SPY_NAME_VV_LEANBOX_6'),
			('CIVILIZATION_VV_LEANBOX',		'TXT_KEY_SPY_NAME_VV_LEANBOX_7'),
			('CIVILIZATION_VV_LEANBOX',		'TXT_KEY_SPY_NAME_VV_LEANBOX_8'),
			('CIVILIZATION_VV_LEANBOX',		'TXT_KEY_SPY_NAME_VV_LEANBOX_9');


--******************************************************************************************************************************************
-- Start Bias
--******************************************************************************************************************************************
INSERT INTO Civilization_Start_Region_Priority
			(CivilizationType,			RegionType)
VALUES		('CIVILIZATION_VV_LEANBOX',	'REGION_GRASS');





--*******************************************************************
-- COPIED LEANBOX
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage, DerivativeCiv,	Playable, AIPlayable)

SELECT ('CIVILIZATION_VV_LEANBOX_GH'), ('TXT_KEY_CIV_VV_LEANBOX_DESC'), ('TXT_KEY_CIV_VV_LEANBOX_SHORT_DESC'), ('TXT_KEY_CIV_VV_LEANBOX_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_VV_LEANBOX'), ('PLAYERCOLOR_VV_LEANBOX'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_VV_LEANBOX'), 0, ('CIV_ALPHA_ATLAS_VV_LEANBOX'), ('ENGLAND'), ('VVVertMapImage.dds'),
('TXT_KEY_CIV5_DAWN_VV_LEANBOX_GH_TEXT'), ('DOM_VV_GreenHeart.dds'), ('LEANBOX'), 0, 0

FROM Civilizations WHERE (Type = 'CIVILIZATION_ENGLAND');

--*******************************************************************
-- Leader (Vert)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 				LeaderheadType)
VALUES		('CIVILIZATION_VV_LEANBOX_GH', 	'LEADER_VV_GREEN_HEART');	


--*******************************************************************
-- Unique Buildings (Leanbox Live Arcade)
--*******************************************************************
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 				BuildingClassType, 			BuildingType)
VALUES		('CIVILIZATION_VV_LEANBOX_GH', 	'BUILDINGCLASS_COLOSSEUM', 	'BUILDING_VV_LEANBOX_ARCADE');


--*******************************************************************
-- Unique Units (Ran-Ran)
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 				UnitClassType, 			UnitType)
VALUES		('CIVILIZATION_VV_LEANBOX_GH', 	'UNITCLASS_WORKER', 	'UNIT_VV_RANRAN');


--******************************************************************************************************************************************
-- City Name (only lists the Capital. Lua will name other cities)
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 				CityName)
VALUES		('CIVILIZATION_VV_LEANBOX_GH', 	'TXT_KEY_CITY_NAME_VV_HDNCAPITAL_LEANBOX');


--*******************************************************************
-- Free Buildings (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 					BuildingClassType)
SELECT		('CIVILIZATION_VV_LEANBOX_GH'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_ENGLAND');

--*******************************************************************
-- Free Techs (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_VV_LEANBOX_GH'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_ENGLAND');

--*******************************************************************
-- Free Units (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_VV_LEANBOX_GH'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_ENGLAND');

--******************************************************************************************************************************************
--Religion
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 				ReligionType)
VALUES		('CIVILIZATION_VV_LEANBOX_GH',	'RELIGION_VV_LEANBOX');

--******************************************************************************************************************************************
-- Spy Names
--******************************************************************************************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		('CIVILIZATION_VV_LEANBOX_GH',		'TXT_KEY_SPY_NAME_VV_LEANBOX_0'),
			('CIVILIZATION_VV_LEANBOX_GH',		'TXT_KEY_SPY_NAME_VV_LEANBOX_1'),
			('CIVILIZATION_VV_LEANBOX_GH',		'TXT_KEY_SPY_NAME_VV_LEANBOX_2'),
			('CIVILIZATION_VV_LEANBOX_GH',		'TXT_KEY_SPY_NAME_VV_LEANBOX_3'),
			('CIVILIZATION_VV_LEANBOX_GH',		'TXT_KEY_SPY_NAME_VV_LEANBOX_4'),
			('CIVILIZATION_VV_LEANBOX_GH',		'TXT_KEY_SPY_NAME_VV_LEANBOX_5'),
			('CIVILIZATION_VV_LEANBOX_GH',		'TXT_KEY_SPY_NAME_VV_LEANBOX_6'),
			('CIVILIZATION_VV_LEANBOX_GH',		'TXT_KEY_SPY_NAME_VV_LEANBOX_7'),
			('CIVILIZATION_VV_LEANBOX_GH',		'TXT_KEY_SPY_NAME_VV_LEANBOX_8'),
			('CIVILIZATION_VV_LEANBOX_GH',		'TXT_KEY_SPY_NAME_VV_LEANBOX_9');


--******************************************************************************************************************************************
-- Start Bias
--******************************************************************************************************************************************
INSERT INTO Civilization_Start_Region_Priority
			(CivilizationType,				RegionType)
VALUES		('CIVILIZATION_VV_LEANBOX_GH',	'REGION_GRASS');






--******************************************************************************************************************************************
-- ULTRADIMENSION LEANBOX
--******************************************************************************************************************************************


INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage, DerivativeCiv)

SELECT ('CIVILIZATION_VV_LEANBOX_ULTRA'), ('TXT_KEY_CIV_VV_LEANBOX_ULTRA_DESC'), ('TXT_KEY_CIV_VV_LEANBOX_ULTRA_SHORT_DESC'), ('TXT_KEY_CIV_VV_LEANBOX_ULTRA_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_VV_LEANBOX'), ('PLAYERCOLOR_VV_LEANBOX_ULTRA'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_VV_LEANBOX_ULTRA'), 0, ('CIV_ALPHA_ATLAS_VV_LEANBOX'), ('ENGLAND'), ('VVVertMapImage.dds'),
('TXT_KEY_CIV5_DAWN_VV_LEANBOX_TEXT'), ('DOM_VV_VertUltra.dds'), ('LEANBOX')

FROM Civilizations WHERE (Type = 'CIVILIZATION_ENGLAND');

--*******************************************************************
-- Leader (Vert)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 					LeaderheadType)
VALUES		('CIVILIZATION_VV_LEANBOX_ULTRA', 	'LEADER_VV_VERT_ULTRA');	


--*******************************************************************
-- Unique Buildings (Leanbox Live Arcade)
--*******************************************************************
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 					BuildingClassType, 			BuildingType)
VALUES		('CIVILIZATION_VV_LEANBOX_ULTRA', 	'BUILDINGCLASS_COLOSSEUM', 	'BUILDING_VV_LEANBOX_ARCADE');


--*******************************************************************
-- Unique Units (Ran-Ran)
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 					UnitClassType, 			UnitType)
VALUES		('CIVILIZATION_VV_LEANBOX_ULTRA', 	'UNITCLASS_WORKER', 	'UNIT_VV_RANRAN');


--******************************************************************************************************************************************
-- City Name (only lists the Capital. Lua will name other cities)
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 				CityName)
VALUES		('CIVILIZATION_VV_LEANBOX_ULTRA', 	'TXT_KEY_CITY_NAME_VV_HDNCAPITAL_LEANBOX_ULTRA');


--*******************************************************************
-- Free Buildings (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 				BuildingClassType)
SELECT		('CIVILIZATION_VV_LEANBOX_ULTRA'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_ENGLAND');

--*******************************************************************
-- Free Techs (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 				TechType)
SELECT		('CIVILIZATION_VV_LEANBOX_ULTRA'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_ENGLAND');

--*******************************************************************
-- Free Units (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 				UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_VV_LEANBOX_ULTRA'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_ENGLAND');

--******************************************************************************************************************************************
--Religion
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 					ReligionType)
VALUES		('CIVILIZATION_VV_LEANBOX_ULTRA',			'RELIGION_VV_LEANBOX');

--******************************************************************************************************************************************
-- Spy Names
--******************************************************************************************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 				SpyName)
VALUES		('CIVILIZATION_VV_LEANBOX_ULTRA',		'TXT_KEY_SPY_NAME_VV_LEANBOX_0'),
			('CIVILIZATION_VV_LEANBOX_ULTRA',		'TXT_KEY_SPY_NAME_VV_LEANBOX_1'),
			('CIVILIZATION_VV_LEANBOX_ULTRA',		'TXT_KEY_SPY_NAME_VV_LEANBOX_2'),
			('CIVILIZATION_VV_LEANBOX_ULTRA',		'TXT_KEY_SPY_NAME_VV_LEANBOX_3'),
			('CIVILIZATION_VV_LEANBOX_ULTRA',		'TXT_KEY_SPY_NAME_VV_LEANBOX_4'),
			('CIVILIZATION_VV_LEANBOX_ULTRA',		'TXT_KEY_SPY_NAME_VV_LEANBOX_5'),
			('CIVILIZATION_VV_LEANBOX_ULTRA',		'TXT_KEY_SPY_NAME_VV_LEANBOX_6'),
			('CIVILIZATION_VV_LEANBOX_ULTRA',		'TXT_KEY_SPY_NAME_VV_LEANBOX_7'),
			('CIVILIZATION_VV_LEANBOX_ULTRA',		'TXT_KEY_SPY_NAME_VV_LEANBOX_8'),
			('CIVILIZATION_VV_LEANBOX_ULTRA',		'TXT_KEY_SPY_NAME_VV_LEANBOX_9');


--******************************************************************************************************************************************
-- Start Bias
--******************************************************************************************************************************************
INSERT INTO Civilization_Start_Region_Priority
			(CivilizationType,			RegionType)
VALUES		('CIVILIZATION_VV_LEANBOX_ULTRA',	'REGION_GRASS');





--*******************************************************************
-- COPIED LEANBOX
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage, DerivativeCiv, Playable, AIPlayable)

SELECT ('CIVILIZATION_VV_LEANBOX_GH_ULTRA'), ('TXT_KEY_CIV_VV_LEANBOX_ULTRA_DESC'), ('TXT_KEY_CIV_VV_LEANBOX_ULTRA_SHORT_DESC'), ('TXT_KEY_CIV_VV_LEANBOX_ULTRA_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_VV_LEANBOX'), ('PLAYERCOLOR_VV_LEANBOX_ULTRA'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_VV_LEANBOX_ULTRA'), 0, ('CIV_ALPHA_ATLAS_VV_LEANBOX'), ('ENGLAND'), ('VVVertMapImage.dds'),
('TXT_KEY_CIV5_DAWN_VV_LEANBOX_GH_TEXT'), ('DOM_VV_GreenHeartUltra.dds'), ('LEANBOX'), 0, 0

FROM Civilizations WHERE (Type = 'CIVILIZATION_ENGLAND');

--*******************************************************************
-- Leader (Vert)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 				LeaderheadType)
VALUES		('CIVILIZATION_VV_LEANBOX_GH_ULTRA', 	'LEADER_VV_GREEN_HEART_ULTRA');	


--*******************************************************************
-- Unique Buildings (Leanbox Live Arcade)
--*******************************************************************
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 				BuildingClassType, 			BuildingType)
VALUES		('CIVILIZATION_VV_LEANBOX_GH_ULTRA', 	'BUILDINGCLASS_COLOSSEUM', 	'BUILDING_VV_LEANBOX_ARCADE');


--*******************************************************************
-- Unique Units (Ran-Ran)
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 				UnitClassType, 			UnitType)
VALUES		('CIVILIZATION_VV_LEANBOX_GH_ULTRA', 	'UNITCLASS_WORKER', 	'UNIT_VV_RANRAN');


--******************************************************************************************************************************************
-- City Name (only lists the Capital. Lua will name other cities)
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 				CityName)
VALUES		('CIVILIZATION_VV_LEANBOX_GH_ULTRA', 	'TXT_KEY_CITY_NAME_VV_HDNCAPITAL_LEANBOX_ULTRA');


--*******************************************************************
-- Free Buildings (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 					BuildingClassType)
SELECT		('CIVILIZATION_VV_LEANBOX_GH_ULTRA'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_ENGLAND');

--*******************************************************************
-- Free Techs (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_VV_LEANBOX_GH_ULTRA'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_ENGLAND');

--*******************************************************************
-- Free Units (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_VV_LEANBOX_GH_ULTRA'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_ENGLAND');

--******************************************************************************************************************************************
--Religion
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 				ReligionType)
VALUES		('CIVILIZATION_VV_LEANBOX_GH_ULTRA',	'RELIGION_VV_LEANBOX');

--******************************************************************************************************************************************
-- Spy Names
--******************************************************************************************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		('CIVILIZATION_VV_LEANBOX_GH_ULTRA',		'TXT_KEY_SPY_NAME_VV_LEANBOX_0'),
			('CIVILIZATION_VV_LEANBOX_GH_ULTRA',		'TXT_KEY_SPY_NAME_VV_LEANBOX_1'),
			('CIVILIZATION_VV_LEANBOX_GH_ULTRA',		'TXT_KEY_SPY_NAME_VV_LEANBOX_2'),
			('CIVILIZATION_VV_LEANBOX_GH_ULTRA',		'TXT_KEY_SPY_NAME_VV_LEANBOX_3'),
			('CIVILIZATION_VV_LEANBOX_GH_ULTRA',		'TXT_KEY_SPY_NAME_VV_LEANBOX_4'),
			('CIVILIZATION_VV_LEANBOX_GH_ULTRA',		'TXT_KEY_SPY_NAME_VV_LEANBOX_5'),
			('CIVILIZATION_VV_LEANBOX_GH_ULTRA',		'TXT_KEY_SPY_NAME_VV_LEANBOX_6'),
			('CIVILIZATION_VV_LEANBOX_GH_ULTRA',		'TXT_KEY_SPY_NAME_VV_LEANBOX_7'),
			('CIVILIZATION_VV_LEANBOX_GH_ULTRA',		'TXT_KEY_SPY_NAME_VV_LEANBOX_8'),
			('CIVILIZATION_VV_LEANBOX_GH_ULTRA',		'TXT_KEY_SPY_NAME_VV_LEANBOX_9');


--******************************************************************************************************************************************
-- Start Bias
--******************************************************************************************************************************************
INSERT INTO Civilization_Start_Region_Priority
			(CivilizationType,				RegionType)
VALUES		('CIVILIZATION_VV_LEANBOX_GH_ULTRA',	'REGION_GRASS'); 




--Options
UPDATE Civilizations
SET Playable = 0, AIPlayable = 0
WHERE Type IN ('CIVILIZATION_VV_LEANBOX', 'CIVILIZATION_VV_LEANBOX_GH') AND EXISTS (SELECT * FROM VV_VertModOptions WHERE Type = 'ULTRADIMENSION' AND Value = 3);

UPDATE Civilizations
SET Playable = 0, AIPlayable = 0
WHERE Type IN ('CIVILIZATION_VV_LEANBOX_ULTRA', 'CIVILIZATION_VV_LEANBOX_GH_ULTRA') AND EXISTS (SELECT * FROM VV_VertModOptions WHERE Type = 'ULTRADIMENSION' AND Value = 2);