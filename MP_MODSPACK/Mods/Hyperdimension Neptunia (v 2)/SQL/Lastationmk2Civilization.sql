--*******************************************************************
-- Lastation mk2 (uses Japan as a baseline)
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage, DerivativeCiv)

SELECT ('CIVILIZATION_VV_LASTATION_UN'), ('TXT_KEY_CIV_VV_LASTATION_UN_DESC'), ('TXT_KEY_CIV_VV_LASTATION_UN_SHORT_DESC'), ('TXT_KEY_CIV_VV_LASTATION_UN_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_VV_LASTATION_UN'), ('PLAYERCOLOR_VV_LASTATION_UN'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_VV_LASTATION_UN'), 0, ('CIV_ALPHA_ATLAS_VV_LASTATION_UN'), ('JAPAN'), ('VVLastationMapImage.dds'),
('TXT_KEY_CIV5_DAWN_VV_LASTATION_UN_TEXT'), ('DOM_VV_Uni.dds'), ('LASTATION')

FROM Civilizations WHERE (Type = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Leader (Uni)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 					LeaderheadType)
VALUES		('CIVILIZATION_VV_LASTATION_UN', 	'LEADER_VV_UNI');	


--*******************************************************************
-- Unique Units (XMB Artillery)
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 					UnitClassType, 			UnitType)
VALUES		('CIVILIZATION_VV_LASTATION_UN', 	'UNITCLASS_ARTILLERY', 	'UNIT_VV_XMB_ARTILLERY');

--*******************************************************************
-- Unique Building (DRM Tower)
--*******************************************************************
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 					BuildingClassType, 			BuildingType)
VALUES		('CIVILIZATION_VV_LASTATION_UN', 	'BUILDINGCLASS_CONSTABLE', 	'BUILDING_VV_DRM_TOWER');


--******************************************************************************************************************************************
-- City Name (only lists the Capital. Lua will name other cities)
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 					CityName)
VALUES		('CIVILIZATION_VV_LASTATION_UN', 	'TXT_KEY_CITY_NAME_VV_HDNCAPITAL_LASTATION_UN');


--*******************************************************************
-- Free Buildings (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 					BuildingClassType)
SELECT		('CIVILIZATION_VV_LASTATION_UN'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Free Techs (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 				TechType)
SELECT		('CIVILIZATION_VV_LASTATION_UN'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Free Units (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 				UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_VV_LASTATION_UN'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--******************************************************************************************************************************************
--Religion
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 					ReligionType)
VALUES		('CIVILIZATION_VV_LASTATION_UN',	'RELIGION_VV_LASTATION_UN');

--******************************************************************************************************************************************
-- Spy Names
--******************************************************************************************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 						SpyName)
VALUES		('CIVILIZATION_VV_LASTATION_UN',		'TXT_KEY_SPY_NAME_VV_LASTATION_UN_0'),
			('CIVILIZATION_VV_LASTATION_UN',		'TXT_KEY_SPY_NAME_VV_LASTATION_UN_1'),
			('CIVILIZATION_VV_LASTATION_UN',		'TXT_KEY_SPY_NAME_VV_LASTATION_UN_2'),
			('CIVILIZATION_VV_LASTATION_UN',		'TXT_KEY_SPY_NAME_VV_LASTATION_UN_3'),
			('CIVILIZATION_VV_LASTATION_UN',		'TXT_KEY_SPY_NAME_VV_LASTATION_UN_4'),
			('CIVILIZATION_VV_LASTATION_UN',		'TXT_KEY_SPY_NAME_VV_LASTATION_UN_5'),
			('CIVILIZATION_VV_LASTATION_UN',		'TXT_KEY_SPY_NAME_VV_LASTATION_UN_6'),
			('CIVILIZATION_VV_LASTATION_UN',		'TXT_KEY_SPY_NAME_VV_LASTATION_UN_7'),
			('CIVILIZATION_VV_LASTATION_UN',		'TXT_KEY_SPY_NAME_VV_LASTATION_UN_8'),
			('CIVILIZATION_VV_LASTATION_UN',		'TXT_KEY_SPY_NAME_VV_LASTATION_UN_9');


--******************************************************************************************************************************************
-- Start Bias
--******************************************************************************************************************************************


--Lastation has no start bias





--*******************************************************************
-- COPIED LASTATION MK2 
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage, Playable, AIPlayable, DerivativeCiv)

SELECT ('CIVILIZATION_VV_LASTATION_BS'), ('TXT_KEY_CIV_VV_LASTATION_UN_DESC'), ('TXT_KEY_CIV_VV_LASTATION_UN_SHORT_DESC'), ('TXT_KEY_CIV_VV_LASTATION_UN_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_VV_LASTATION_UN'), ('PLAYERCOLOR_VV_LASTATION_UN'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_VV_LASTATION_UN'), 0, ('CIV_ALPHA_ATLAS_VV_LASTATION_UN'), ('JAPAN'), ('VVLastationMapImage.dds'),
('TXT_KEY_CIV5_DAWN_VV_LASTATION_BS_TEXT'), ('DOM_VV_BlackSister.dds'), 0, 0, ('LASTATION')

FROM Civilizations WHERE (Type = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Leader (Black Sister)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 					LeaderheadType)
VALUES		('CIVILIZATION_VV_LASTATION_BS', 	'LEADER_VV_BLACK_SISTER');	


--*******************************************************************
-- Unique Units (XMB Artillery)
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 					UnitClassType, 			UnitType)
VALUES		('CIVILIZATION_VV_LASTATION_BS', 	'UNITCLASS_ARTILLERY', 	'UNIT_VV_XMB_ARTILLERY');


--*******************************************************************
-- Unique Building (DRM Tower)
--*******************************************************************
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 					BuildingClassType, 			BuildingType)
VALUES		('CIVILIZATION_VV_LASTATION_BS', 	'BUILDINGCLASS_CONSTABLE', 	'BUILDING_VV_DRM_TOWER');


--******************************************************************************************************************************************
-- City Name (only lists the Capital. Lua will name other cities)
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 					CityName)
VALUES		('CIVILIZATION_VV_LASTATION_BS', 	'TXT_KEY_CITY_NAME_VV_HDNCAPITAL_LASTATION_UN');


--*******************************************************************
-- Free Buildings (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 					BuildingClassType)
SELECT		('CIVILIZATION_VV_LASTATION_BS'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Free Techs (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_VV_LASTATION_BS'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--*******************************************************************
-- Free Units (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_VV_LASTATION_BS'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

--******************************************************************************************************************************************
--Religion
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 					ReligionType)
VALUES		('CIVILIZATION_VV_LASTATION_BS',	'RELIGION_VV_LASTATION_UN');

--******************************************************************************************************************************************
-- Spy Names
--******************************************************************************************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 						SpyName)
VALUES		('CIVILIZATION_VV_LASTATION_BS',		'TXT_KEY_SPY_NAME_VV_LASTATION_UN_0'),
			('CIVILIZATION_VV_LASTATION_BS',		'TXT_KEY_SPY_NAME_VV_LASTATION_UN_1'),
			('CIVILIZATION_VV_LASTATION_BS',		'TXT_KEY_SPY_NAME_VV_LASTATION_UN_2'),
			('CIVILIZATION_VV_LASTATION_BS',		'TXT_KEY_SPY_NAME_VV_LASTATION_UN_3'),
			('CIVILIZATION_VV_LASTATION_BS',		'TXT_KEY_SPY_NAME_VV_LASTATION_UN_4'),
			('CIVILIZATION_VV_LASTATION_BS',		'TXT_KEY_SPY_NAME_VV_LASTATION_UN_5'),
			('CIVILIZATION_VV_LASTATION_BS',		'TXT_KEY_SPY_NAME_VV_LASTATION_UN_6'),
			('CIVILIZATION_VV_LASTATION_BS',		'TXT_KEY_SPY_NAME_VV_LASTATION_UN_7'),
			('CIVILIZATION_VV_LASTATION_BS',		'TXT_KEY_SPY_NAME_VV_LASTATION_UN_8'),
			('CIVILIZATION_VV_LASTATION_BS',		'TXT_KEY_SPY_NAME_VV_LASTATION_UN_9');