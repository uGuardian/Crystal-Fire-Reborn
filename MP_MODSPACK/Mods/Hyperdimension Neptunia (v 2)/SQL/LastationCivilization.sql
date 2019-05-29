--*******************************************************************
-- Lastation (uses England as a baseline)
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage, DerivativeCiv)

SELECT ('CIVILIZATION_VV_LASTATION'), ('TXT_KEY_CIV_VV_LASTATION_DESC'), ('TXT_KEY_CIV_VV_LASTATION_SHORT_DESC'), ('TXT_KEY_CIV_VV_LASTATION_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_VV_LASTATION'), ('PLAYERCOLOR_VV_LASTATION'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_VV_LASTATION'), 0, ('CIV_ALPHA_ATLAS_VV_LASTATION'), ('JAPAN'), ('VVLastationMapImage.dds'),
('TXT_KEY_CIV5_DAWN_VV_LASTATION_TEXT'), ('DOM_VV_Noire.dds'), ('LASTATION')

FROM Civilizations WHERE (Type = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Leader (Noire)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 				LeaderheadType)
VALUES		('CIVILIZATION_VV_LASTATION', 	'LEADER_VV_NOIRE');	


--*******************************************************************
-- Unique Buildings (Lastation Live Arcade)
--*******************************************************************
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 				BuildingClassType, 			BuildingType)
VALUES		('CIVILIZATION_VV_LASTATION', 	'BUILDINGCLASS_MARKET', 	'BUILDING_VV_COSPLAY_SHOP');


--*******************************************************************
-- Unique Units (Ran-Ran)
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 				UnitClassType, 			UnitType)
VALUES		('CIVILIZATION_VV_LASTATION', 	'UNITCLASS_LONGSWORDSMAN', 	'UNIT_VV_ARMAS');


--******************************************************************************************************************************************
-- City Name (only lists the Capital. Lua will name other cities)
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 				CityName)
VALUES		('CIVILIZATION_VV_LASTATION', 	'TXT_KEY_CITY_NAME_VV_HDNCAPITAL_LASTATION');


--*******************************************************************
-- Free Buildings (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 				BuildingClassType)
SELECT		('CIVILIZATION_VV_LASTATION'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Free Techs (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 				TechType)
SELECT		('CIVILIZATION_VV_LASTATION'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Free Units (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 				UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_VV_LASTATION'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--******************************************************************************************************************************************
--Religion
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 					ReligionType)
VALUES		('CIVILIZATION_VV_LASTATION',			'RELIGION_VV_LASTATION');

--******************************************************************************************************************************************
-- Spy Names
--******************************************************************************************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 				SpyName)
VALUES		('CIVILIZATION_VV_LASTATION',		'TXT_KEY_SPY_NAME_VV_LASTATION_0'),
			('CIVILIZATION_VV_LASTATION',		'TXT_KEY_SPY_NAME_VV_LASTATION_1'),
			('CIVILIZATION_VV_LASTATION',		'TXT_KEY_SPY_NAME_VV_LASTATION_2'),
			('CIVILIZATION_VV_LASTATION',		'TXT_KEY_SPY_NAME_VV_LASTATION_3'),
			('CIVILIZATION_VV_LASTATION',		'TXT_KEY_SPY_NAME_VV_LASTATION_4'),
			('CIVILIZATION_VV_LASTATION',		'TXT_KEY_SPY_NAME_VV_LASTATION_5'),
			('CIVILIZATION_VV_LASTATION',		'TXT_KEY_SPY_NAME_VV_LASTATION_6'),
			('CIVILIZATION_VV_LASTATION',		'TXT_KEY_SPY_NAME_VV_LASTATION_7'),
			('CIVILIZATION_VV_LASTATION',		'TXT_KEY_SPY_NAME_VV_LASTATION_8'),
			('CIVILIZATION_VV_LASTATION',		'TXT_KEY_SPY_NAME_VV_LASTATION_9');


--******************************************************************************************************************************************
-- Start Bias
--******************************************************************************************************************************************

--none




--*******************************************************************
-- COPIED LASTATION
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage, DerivativeCiv,	Playable, AIPlayable)

SELECT ('CIVILIZATION_VV_LASTATION_BH'), ('TXT_KEY_CIV_VV_LASTATION_DESC'), ('TXT_KEY_CIV_VV_LASTATION_SHORT_DESC'), ('TXT_KEY_CIV_VV_LASTATION_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_VV_LASTATION'), ('PLAYERCOLOR_VV_LASTATION'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_VV_LASTATION'), 0, ('CIV_ALPHA_ATLAS_VV_LASTATION'), ('JAPAN'), ('VVLastationMapImage.dds'),
('TXT_KEY_CIV5_DAWN_VV_LASTATION_BH_TEXT'), ('DOM_VV_BlackHeart.dds'), ('LASTATION'), 0, 0

FROM Civilizations WHERE (Type = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Leader (Noire)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 				LeaderheadType)
VALUES		('CIVILIZATION_VV_LASTATION_BH', 	'LEADER_VV_BLACK_HEART');	


--*******************************************************************
-- Unique Buildings (Lastation Live Arcade)
--*******************************************************************
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 				BuildingClassType, 			BuildingType)
VALUES		('CIVILIZATION_VV_LASTATION_BH', 	'BUILDINGCLASS_MARKET', 	'BUILDING_VV_COSPLAY_SHOP');


--*******************************************************************
-- Unique Units (Ran-Ran)
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 				UnitClassType, 			UnitType)
VALUES		('CIVILIZATION_VV_LASTATION_BH', 	'UNITCLASS_LONGSWORDSMAN', 	'UNIT_VV_ARMAS');


--******************************************************************************************************************************************
-- City Name (only lists the Capital. Lua will name other cities)
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 				CityName)
VALUES		('CIVILIZATION_VV_LASTATION_BH', 	'TXT_KEY_CITY_NAME_VV_HDNCAPITAL_LASTATION');


--*******************************************************************
-- Free Buildings (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 					BuildingClassType)
SELECT		('CIVILIZATION_VV_LASTATION_BH'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Free Techs (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_VV_LASTATION_BH'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Free Units (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_VV_LASTATION_BH'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--******************************************************************************************************************************************
--Religion
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 				ReligionType)
VALUES		('CIVILIZATION_VV_LASTATION_BH',	'RELIGION_VV_LASTATION');

--******************************************************************************************************************************************
-- Spy Names
--******************************************************************************************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		('CIVILIZATION_VV_LASTATION_BH',		'TXT_KEY_SPY_NAME_VV_LASTATION_0'),
			('CIVILIZATION_VV_LASTATION_BH',		'TXT_KEY_SPY_NAME_VV_LASTATION_1'),
			('CIVILIZATION_VV_LASTATION_BH',		'TXT_KEY_SPY_NAME_VV_LASTATION_2'),
			('CIVILIZATION_VV_LASTATION_BH',		'TXT_KEY_SPY_NAME_VV_LASTATION_3'),
			('CIVILIZATION_VV_LASTATION_BH',		'TXT_KEY_SPY_NAME_VV_LASTATION_4'),
			('CIVILIZATION_VV_LASTATION_BH',		'TXT_KEY_SPY_NAME_VV_LASTATION_5'),
			('CIVILIZATION_VV_LASTATION_BH',		'TXT_KEY_SPY_NAME_VV_LASTATION_6'),
			('CIVILIZATION_VV_LASTATION_BH',		'TXT_KEY_SPY_NAME_VV_LASTATION_7'),
			('CIVILIZATION_VV_LASTATION_BH',		'TXT_KEY_SPY_NAME_VV_LASTATION_8'),
			('CIVILIZATION_VV_LASTATION_BH',		'TXT_KEY_SPY_NAME_VV_LASTATION_9');


--******************************************************************************************************************************************
-- Start Bias
--******************************************************************************************************************************************

--none






--******************************************************************************************************************************************
-- ULTRADIMENSION LASTATION
--******************************************************************************************************************************************


INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage, DerivativeCiv)

SELECT ('CIVILIZATION_VV_LASTATION_ULTRA'), ('TXT_KEY_CIV_VV_LASTATION_ULTRA_DESC'), ('TXT_KEY_CIV_VV_LASTATION_ULTRA_SHORT_DESC'), ('TXT_KEY_CIV_VV_LASTATION_ULTRA_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_VV_LASTATION'), ('PLAYERCOLOR_VV_LASTATION_ULTRA'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_VV_LASTATION_ULTRA'), 0, ('CIV_ALPHA_ATLAS_VV_LASTATION'), ('JAPAN'), ('VVLastationMapImage.dds'),
('TXT_KEY_CIV5_DAWN_VV_LASTATION_TEXT'), ('DOM_VV_NoireUltra.dds'), ('LASTATION')

FROM Civilizations WHERE (Type = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Leader (Noire)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 					LeaderheadType)
VALUES		('CIVILIZATION_VV_LASTATION_ULTRA', 	'LEADER_VV_NOIRE_ULTRA');	


--*******************************************************************
-- Unique Buildings (Lastation Live Arcade)
--*******************************************************************
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 					BuildingClassType, 			BuildingType)
VALUES		('CIVILIZATION_VV_LASTATION_ULTRA', 	'BUILDINGCLASS_MARKET', 	'BUILDING_VV_COSPLAY_SHOP');


--*******************************************************************
-- Unique Units (Ran-Ran)
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 					UnitClassType, 			UnitType)
VALUES		('CIVILIZATION_VV_LASTATION_ULTRA', 	'UNITCLASS_LONGSWORDSMAN', 	'UNIT_VV_ARMAS');


--******************************************************************************************************************************************
-- City Name (only lists the Capital. Lua will name other cities)
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 				CityName)
VALUES		('CIVILIZATION_VV_LASTATION_ULTRA', 	'TXT_KEY_CITY_NAME_VV_HDNCAPITAL_LASTATION_ULTRA');


--*******************************************************************
-- Free Buildings (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 				BuildingClassType)
SELECT		('CIVILIZATION_VV_LASTATION_ULTRA'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Free Techs (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 				TechType)
SELECT		('CIVILIZATION_VV_LASTATION_ULTRA'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Free Units (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 				UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_VV_LASTATION_ULTRA'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--******************************************************************************************************************************************
--Religion
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 					ReligionType)
VALUES		('CIVILIZATION_VV_LASTATION_ULTRA',			'RELIGION_VV_LASTATION');

--******************************************************************************************************************************************
-- Spy Names
--******************************************************************************************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 				SpyName)
VALUES		('CIVILIZATION_VV_LASTATION_ULTRA',		'TXT_KEY_SPY_NAME_VV_LASTATION_0'),
			('CIVILIZATION_VV_LASTATION_ULTRA',		'TXT_KEY_SPY_NAME_VV_LASTATION_1'),
			('CIVILIZATION_VV_LASTATION_ULTRA',		'TXT_KEY_SPY_NAME_VV_LASTATION_2'),
			('CIVILIZATION_VV_LASTATION_ULTRA',		'TXT_KEY_SPY_NAME_VV_LASTATION_3'),
			('CIVILIZATION_VV_LASTATION_ULTRA',		'TXT_KEY_SPY_NAME_VV_LASTATION_4'),
			('CIVILIZATION_VV_LASTATION_ULTRA',		'TXT_KEY_SPY_NAME_VV_LASTATION_5'),
			('CIVILIZATION_VV_LASTATION_ULTRA',		'TXT_KEY_SPY_NAME_VV_LASTATION_6'),
			('CIVILIZATION_VV_LASTATION_ULTRA',		'TXT_KEY_SPY_NAME_VV_LASTATION_7'),
			('CIVILIZATION_VV_LASTATION_ULTRA',		'TXT_KEY_SPY_NAME_VV_LASTATION_8'),
			('CIVILIZATION_VV_LASTATION_ULTRA',		'TXT_KEY_SPY_NAME_VV_LASTATION_9');


--******************************************************************************************************************************************
-- Start Bias
--******************************************************************************************************************************************

--none





--*******************************************************************
-- COPIED LASTATION
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage, DerivativeCiv, Playable, AIPlayable)

SELECT ('CIVILIZATION_VV_LASTATION_BH_ULTRA'), ('TXT_KEY_CIV_VV_LASTATION_ULTRA_DESC'), ('TXT_KEY_CIV_VV_LASTATION_ULTRA_SHORT_DESC'), ('TXT_KEY_CIV_VV_LASTATION_ULTRA_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_VV_LASTATION'), ('PLAYERCOLOR_VV_LASTATION_ULTRA'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_VV_LASTATION_ULTRA'), 0, ('CIV_ALPHA_ATLAS_VV_LASTATION'), ('JAPAN'), ('VVLastationMapImage.dds'),
('TXT_KEY_CIV5_DAWN_VV_LASTATION_BH_TEXT'), ('DOM_VV_BlackHeartUltra.dds'), ('LASTATION'), 0, 0

FROM Civilizations WHERE (Type = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Leader (Noire)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 				LeaderheadType)
VALUES		('CIVILIZATION_VV_LASTATION_BH_ULTRA', 	'LEADER_VV_BLACK_HEART_ULTRA');	


--*******************************************************************
-- Unique Buildings (Lastation Live Arcade)
--*******************************************************************
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 				BuildingClassType, 			BuildingType)
VALUES		('CIVILIZATION_VV_LASTATION_BH_ULTRA', 	'BUILDINGCLASS_MARKET', 	'BUILDING_VV_COSPLAY_SHOP');


--*******************************************************************
-- Unique Units (Ran-Ran)
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 				UnitClassType, 			UnitType)
VALUES		('CIVILIZATION_VV_LASTATION_BH_ULTRA', 	'UNITCLASS_LONGSWORDSMAN', 	'UNIT_VV_ARMAS');


--******************************************************************************************************************************************
-- City Name (only lists the Capital. Lua will name other cities)
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 				CityName)
VALUES		('CIVILIZATION_VV_LASTATION_BH_ULTRA', 	'TXT_KEY_CITY_NAME_VV_HDNCAPITAL_LASTATION_ULTRA');


--*******************************************************************
-- Free Buildings (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 					BuildingClassType)
SELECT		('CIVILIZATION_VV_LASTATION_BH_ULTRA'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Free Techs (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_VV_LASTATION_BH_ULTRA'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Free Units (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_VV_LASTATION_BH_ULTRA'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--******************************************************************************************************************************************
--Religion
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 				ReligionType)
VALUES		('CIVILIZATION_VV_LASTATION_BH_ULTRA',	'RELIGION_VV_LASTATION');

--******************************************************************************************************************************************
-- Spy Names
--******************************************************************************************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		('CIVILIZATION_VV_LASTATION_BH_ULTRA',		'TXT_KEY_SPY_NAME_VV_LASTATION_0'),
			('CIVILIZATION_VV_LASTATION_BH_ULTRA',		'TXT_KEY_SPY_NAME_VV_LASTATION_1'),
			('CIVILIZATION_VV_LASTATION_BH_ULTRA',		'TXT_KEY_SPY_NAME_VV_LASTATION_2'),
			('CIVILIZATION_VV_LASTATION_BH_ULTRA',		'TXT_KEY_SPY_NAME_VV_LASTATION_3'),
			('CIVILIZATION_VV_LASTATION_BH_ULTRA',		'TXT_KEY_SPY_NAME_VV_LASTATION_4'),
			('CIVILIZATION_VV_LASTATION_BH_ULTRA',		'TXT_KEY_SPY_NAME_VV_LASTATION_5'),
			('CIVILIZATION_VV_LASTATION_BH_ULTRA',		'TXT_KEY_SPY_NAME_VV_LASTATION_6'),
			('CIVILIZATION_VV_LASTATION_BH_ULTRA',		'TXT_KEY_SPY_NAME_VV_LASTATION_7'),
			('CIVILIZATION_VV_LASTATION_BH_ULTRA',		'TXT_KEY_SPY_NAME_VV_LASTATION_8'),
			('CIVILIZATION_VV_LASTATION_BH_ULTRA',		'TXT_KEY_SPY_NAME_VV_LASTATION_9');


--******************************************************************************************************************************************
-- Start Bias
--******************************************************************************************************************************************

--none




--Options
UPDATE Civilizations
SET Playable = 0, AIPlayable = 0
WHERE Type IN ('CIVILIZATION_VV_LASTATION', 'CIVILIZATION_VV_LASTATION_BH') AND EXISTS (SELECT * FROM VV_NoireModOptions WHERE Type = 'ULTRADIMENSION' AND Value = 3);

UPDATE Civilizations
SET Playable = 0, AIPlayable = 0
WHERE Type IN ('CIVILIZATION_VV_LASTATION_ULTRA', 'CIVILIZATION_VV_LASTATION_BH_ULTRA') AND EXISTS (SELECT * FROM VV_NoireModOptions WHERE Type = 'ULTRADIMENSION' AND Value = 2);