--*******************************************************************
-- Lowee (uses Germany as a baseline)
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage, DerivativeCiv)

SELECT ('CIVILIZATION_VV_LOWEE'), ('TXT_KEY_CIV_VV_LOWEE_DESC'), ('TXT_KEY_CIV_VV_LOWEE_SHORT_DESC'), ('TXT_KEY_CIV_VV_LOWEE_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_VV_LOWEE'), ('PLAYERCOLOR_VV_LOWEE'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_VV_LOWEE'), 0, ('CIV_ALPHA_ATLAS_VV_LOWEE'), ('GERMANY'), ('VVBlancMapImage.dds'),
('TXT_KEY_CIV5_DAWN_VV_LOWEE_TEXT'), ('DOM_VV_Blanc.dds'), ('LOWEE')

FROM Civilizations WHERE (Type = 'CIVILIZATION_GERMANY');

--*******************************************************************
-- Leader (Blanc)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 			LeaderheadType)
VALUES		('CIVILIZATION_VV_LOWEE', 	'LEADER_VV_BLANC');	


--*******************************************************************
-- Unique Units (Magical Soldier)
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 			UnitClassType, 			UnitType)
VALUES		('CIVILIZATION_VV_LOWEE', 	'UNITCLASS_RIFLEMAN', 	'UNIT_VV_LOWEE_SOLDIER');


--******************************************************************************************************************************************
-- City Name (only lists the Capital. Lua will name other cities)
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 			CityName)
VALUES		('CIVILIZATION_VV_LOWEE', 	'TXT_KEY_CITY_NAME_VV_HDNCAPITAL_LOWEE');


--*******************************************************************
-- Free Buildings (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 				BuildingClassType)
SELECT		('CIVILIZATION_VV_LOWEE'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_GERMANY');

--*******************************************************************
-- Free Techs (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 				TechType)
SELECT		('CIVILIZATION_VV_LOWEE'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_GERMANY');

--*******************************************************************
-- Free Units (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 				UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_VV_LOWEE'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_GERMANY');

--******************************************************************************************************************************************
--Religion
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 					ReligionType)
VALUES		('CIVILIZATION_VV_LOWEE',			'RELIGION_VV_LOWEE');

--******************************************************************************************************************************************
-- Spy Names
--******************************************************************************************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 				SpyName)
VALUES		('CIVILIZATION_VV_LOWEE',		'TXT_KEY_SPY_NAME_VV_LOWEE_0'),
			('CIVILIZATION_VV_LOWEE',		'TXT_KEY_SPY_NAME_VV_LOWEE_1'),
			('CIVILIZATION_VV_LOWEE',		'TXT_KEY_SPY_NAME_VV_LOWEE_2'),
			('CIVILIZATION_VV_LOWEE',		'TXT_KEY_SPY_NAME_VV_LOWEE_3'),
			('CIVILIZATION_VV_LOWEE',		'TXT_KEY_SPY_NAME_VV_LOWEE_4'),
			('CIVILIZATION_VV_LOWEE',		'TXT_KEY_SPY_NAME_VV_LOWEE_5'),
			('CIVILIZATION_VV_LOWEE',		'TXT_KEY_SPY_NAME_VV_LOWEE_6'),
			('CIVILIZATION_VV_LOWEE',		'TXT_KEY_SPY_NAME_VV_LOWEE_7'),
			('CIVILIZATION_VV_LOWEE',		'TXT_KEY_SPY_NAME_VV_LOWEE_8'),
			('CIVILIZATION_VV_LOWEE',		'TXT_KEY_SPY_NAME_VV_LOWEE_9');


--******************************************************************************************************************************************
-- Start Bias
--******************************************************************************************************************************************
INSERT INTO Civilization_Start_Region_Priority
			(CivilizationType,			RegionType)
VALUES		('CIVILIZATION_VV_LOWEE',	'REGION_TUNDRA');





--*******************************************************************
-- COPIED LOWEE
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage, Playable, AIPlayable, DerivativeCiv)

SELECT ('CIVILIZATION_VV_LOWEE_WH'), ('TXT_KEY_CIV_VV_LOWEE_DESC'), ('TXT_KEY_CIV_VV_LOWEE_SHORT_DESC'), ('TXT_KEY_CIV_VV_LOWEE_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_VV_LOWEE'), ('PLAYERCOLOR_VV_LOWEE'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_VV_LOWEE'), 0, ('CIV_ALPHA_ATLAS_VV_LOWEE'), ('GERMANY'), ('VVBlancMapImage.dds'),
('TXT_KEY_CIV5_DAWN_VV_LOWEE_GH_TEXT'), ('DOM_VV_WhiteHeart.dds'), 0, 0, ('LOWEE')

FROM Civilizations WHERE (Type = 'CIVILIZATION_GERMANY');

--*******************************************************************
-- Leader (White Heart)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 				LeaderheadType)
VALUES		('CIVILIZATION_VV_LOWEE_WH', 	'LEADER_VV_WHITE_HEART');	


--*******************************************************************
-- Unique Units (Magical Soldier)
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 				UnitClassType, 			UnitType)
VALUES		('CIVILIZATION_VV_LOWEE_WH', 	'UNITCLASS_RIFLEMAN', 	'UNIT_VV_LOWEE_SOLDIER');


--******************************************************************************************************************************************
-- City Name (only lists the Capital. Lua will name other cities)
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 				CityName)
VALUES		('CIVILIZATION_VV_LOWEE_WH', 	'TXT_KEY_CITY_NAME_VV_HDNCAPITAL_LOWEE');


--*******************************************************************
-- Free Buildings (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 					BuildingClassType)
SELECT		('CIVILIZATION_VV_LOWEE_WH'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_GERMANY');

--*******************************************************************
-- Free Techs (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_VV_LOWEE_WH'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_GERMANY');

--*******************************************************************
-- Free Units (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_VV_LOWEE_WH'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_GERMANY');

--******************************************************************************************************************************************
--Religion
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 				ReligionType)
VALUES		('CIVILIZATION_VV_LOWEE_WH',	'RELIGION_VV_LOWEE');

--******************************************************************************************************************************************
-- Spy Names
--******************************************************************************************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		('CIVILIZATION_VV_LOWEE_WH',		'TXT_KEY_SPY_NAME_VV_LOWEE_0'),
			('CIVILIZATION_VV_LOWEE_WH',		'TXT_KEY_SPY_NAME_VV_LOWEE_1'),
			('CIVILIZATION_VV_LOWEE_WH',		'TXT_KEY_SPY_NAME_VV_LOWEE_2'),
			('CIVILIZATION_VV_LOWEE_WH',		'TXT_KEY_SPY_NAME_VV_LOWEE_3'),
			('CIVILIZATION_VV_LOWEE_WH',		'TXT_KEY_SPY_NAME_VV_LOWEE_4'),
			('CIVILIZATION_VV_LOWEE_WH',		'TXT_KEY_SPY_NAME_VV_LOWEE_5'),
			('CIVILIZATION_VV_LOWEE_WH',		'TXT_KEY_SPY_NAME_VV_LOWEE_6'),
			('CIVILIZATION_VV_LOWEE_WH',		'TXT_KEY_SPY_NAME_VV_LOWEE_7'),
			('CIVILIZATION_VV_LOWEE_WH',		'TXT_KEY_SPY_NAME_VV_LOWEE_8'),
			('CIVILIZATION_VV_LOWEE_WH',		'TXT_KEY_SPY_NAME_VV_LOWEE_9');


--******************************************************************************************************************************************
-- Start Bias
--******************************************************************************************************************************************
INSERT INTO Civilization_Start_Region_Priority
			(CivilizationType,				RegionType)
VALUES		('CIVILIZATION_VV_LOWEE_WH',	'REGION_TUNDRA');






--******************************************************************************************************************************************
-- ULTRADIMENSION LOWEE
--******************************************************************************************************************************************



--*******************************************************************
-- Lowee (uses Japan (not Germany!) as a baseline)
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage, DerivativeCiv)

SELECT ('CIVILIZATION_VV_LOWEE_ULTRA'), ('TXT_KEY_CIV_VV_LOWEE_ULTRA_DESC'), ('TXT_KEY_CIV_VV_LOWEE_ULTRA_SHORT_DESC'), ('TXT_KEY_CIV_VV_LOWEE_ULTRA_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_VV_LOWEE'), ('PLAYERCOLOR_VV_LOWEE_ULTRA'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_VV_LOWEE_ULTRA'), 0, ('CIV_ALPHA_ATLAS_VV_LOWEE'), ('JAPAN'), ('VVBlancMapImage.dds'),
('TXT_KEY_CIV5_DAWN_VV_LOWEE_TEXT'), ('DOM_VV_BlancUltra.dds'), ('LOWEE')

FROM Civilizations WHERE (Type = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Leader (Blanc)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 					LeaderheadType)
VALUES		('CIVILIZATION_VV_LOWEE_ULTRA', 	'LEADER_VV_BLANC_ULTRA');	


--*******************************************************************
-- Unique Units (Magical Soldier)
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 					UnitClassType, 			UnitType)
VALUES		('CIVILIZATION_VV_LOWEE_ULTRA', 	'UNITCLASS_RIFLEMAN', 	'UNIT_VV_LOWEE_SOLDIER');


--******************************************************************************************************************************************
-- City Name (only lists the Capital. Lua will name other cities)
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 					CityName)
VALUES		('CIVILIZATION_VV_LOWEE_ULTRA', 	'TXT_KEY_CITY_NAME_VV_HDNCAPITAL_LOWEE_ULTRA');


--*******************************************************************
-- Free Buildings (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 				BuildingClassType)
SELECT		('CIVILIZATION_VV_LOWEE_ULTRA'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Free Techs (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 				TechType)
SELECT		('CIVILIZATION_VV_LOWEE_ULTRA'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Free Units (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 				UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_VV_LOWEE_ULTRA'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--******************************************************************************************************************************************
--Religion
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 					ReligionType)
VALUES		('CIVILIZATION_VV_LOWEE_ULTRA',			'RELIGION_VV_LOWEE');

--******************************************************************************************************************************************
-- Spy Names
--******************************************************************************************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 				SpyName)
VALUES		('CIVILIZATION_VV_LOWEE_ULTRA',		'TXT_KEY_SPY_NAME_VV_LOWEE_0'),
			('CIVILIZATION_VV_LOWEE_ULTRA',		'TXT_KEY_SPY_NAME_VV_LOWEE_1'),
			('CIVILIZATION_VV_LOWEE_ULTRA',		'TXT_KEY_SPY_NAME_VV_LOWEE_2'),
			('CIVILIZATION_VV_LOWEE_ULTRA',		'TXT_KEY_SPY_NAME_VV_LOWEE_3'),
			('CIVILIZATION_VV_LOWEE_ULTRA',		'TXT_KEY_SPY_NAME_VV_LOWEE_4'),
			('CIVILIZATION_VV_LOWEE_ULTRA',		'TXT_KEY_SPY_NAME_VV_LOWEE_5'),
			('CIVILIZATION_VV_LOWEE_ULTRA',		'TXT_KEY_SPY_NAME_VV_LOWEE_6'),
			('CIVILIZATION_VV_LOWEE_ULTRA',		'TXT_KEY_SPY_NAME_VV_LOWEE_7'),
			('CIVILIZATION_VV_LOWEE_ULTRA',		'TXT_KEY_SPY_NAME_VV_LOWEE_8'),
			('CIVILIZATION_VV_LOWEE_ULTRA',		'TXT_KEY_SPY_NAME_VV_LOWEE_9');


--******************************************************************************************************************************************
-- Start Bias
--******************************************************************************************************************************************
INSERT INTO Civilization_Start_Region_Priority
			(CivilizationType,			RegionType)
VALUES		('CIVILIZATION_VV_LOWEE_ULTRA',	'REGION_TUNDRA');





--*******************************************************************
-- COPIED LOWEE
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage, Playable, AIPlayable, DerivativeCiv)

SELECT ('CIVILIZATION_VV_LOWEE_WH_ULTRA'), ('TXT_KEY_CIV_VV_LOWEE_ULTRA_DESC'), ('TXT_KEY_CIV_VV_LOWEE_ULTRA_SHORT_DESC'), ('TXT_KEY_CIV_VV_LOWEE_ULTRA_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_VV_LOWEE'), ('PLAYERCOLOR_VV_LOWEE_ULTRA'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_VV_LOWEE_ULTRA'), 0, ('CIV_ALPHA_ATLAS_VV_LOWEE'), ('JAPAN'), ('VVBlancMapImage.dds'),
('TXT_KEY_CIV5_DAWN_VV_LOWEE_GH_TEXT'), ('DOM_VV_WhiteHeartUltra.dds'), 0, 0, ('LOWEE')

FROM Civilizations WHERE (Type = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Leader (White Heart)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 					LeaderheadType)
VALUES		('CIVILIZATION_VV_LOWEE_WH_ULTRA', 	'LEADER_VV_WHITE_HEART_ULTRA');	


--*******************************************************************
-- Unique Units (Magical Soldier)
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 				UnitClassType, 			UnitType)
VALUES		('CIVILIZATION_VV_LOWEE_WH_ULTRA', 	'UNITCLASS_RIFLEMAN', 	'UNIT_VV_LOWEE_SOLDIER');


--******************************************************************************************************************************************
-- City Name (only lists the Capital. Lua will name other cities)
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 				CityName)
VALUES		('CIVILIZATION_VV_LOWEE_WH_ULTRA', 	'TXT_KEY_CITY_NAME_VV_HDNCAPITAL_LOWEE_ULTRA');


--*******************************************************************
-- Free Buildings (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 					BuildingClassType)
SELECT		('CIVILIZATION_VV_LOWEE_WH_ULTRA'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Free Techs (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_VV_LOWEE_WH_ULTRA'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Free Units (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_VV_LOWEE_WH_ULTRA'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--******************************************************************************************************************************************
--Religion
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 				ReligionType)
VALUES		('CIVILIZATION_VV_LOWEE_WH_ULTRA',	'RELIGION_VV_LOWEE');

--******************************************************************************************************************************************
-- Spy Names
--******************************************************************************************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		('CIVILIZATION_VV_LOWEE_WH_ULTRA',		'TXT_KEY_SPY_NAME_VV_LOWEE_0'),
			('CIVILIZATION_VV_LOWEE_WH_ULTRA',		'TXT_KEY_SPY_NAME_VV_LOWEE_1'),
			('CIVILIZATION_VV_LOWEE_WH_ULTRA',		'TXT_KEY_SPY_NAME_VV_LOWEE_2'),
			('CIVILIZATION_VV_LOWEE_WH_ULTRA',		'TXT_KEY_SPY_NAME_VV_LOWEE_3'),
			('CIVILIZATION_VV_LOWEE_WH_ULTRA',		'TXT_KEY_SPY_NAME_VV_LOWEE_4'),
			('CIVILIZATION_VV_LOWEE_WH_ULTRA',		'TXT_KEY_SPY_NAME_VV_LOWEE_5'),
			('CIVILIZATION_VV_LOWEE_WH_ULTRA',		'TXT_KEY_SPY_NAME_VV_LOWEE_6'),
			('CIVILIZATION_VV_LOWEE_WH_ULTRA',		'TXT_KEY_SPY_NAME_VV_LOWEE_7'),
			('CIVILIZATION_VV_LOWEE_WH_ULTRA',		'TXT_KEY_SPY_NAME_VV_LOWEE_8'),
			('CIVILIZATION_VV_LOWEE_WH_ULTRA',		'TXT_KEY_SPY_NAME_VV_LOWEE_9');


--******************************************************************************************************************************************
-- Start Bias
--******************************************************************************************************************************************
INSERT INTO Civilization_Start_Region_Priority
			(CivilizationType,				RegionType)
VALUES		('CIVILIZATION_VV_LOWEE_WH_ULTRA',	'REGION_TUNDRA');




--Options
UPDATE Civilizations
SET Playable = 0, AIPlayable = 0
WHERE Type IN ('CIVILIZATION_VV_LOWEE', 'CIVILIZATION_VV_LOWEE_WH') AND EXISTS (SELECT * FROM VV_BlancModOptions WHERE Type = 'ULTRADIMENSION' AND Value = 3);

UPDATE Civilizations
SET Playable = 0, AIPlayable = 0
WHERE Type IN ('CIVILIZATION_VV_LOWEE_ULTRA', 'CIVILIZATION_VV_LOWEE_WH_ULTRA') AND EXISTS (SELECT * FROM VV_BlancModOptions WHERE Type = 'ULTRADIMENSION' AND Value = 2);