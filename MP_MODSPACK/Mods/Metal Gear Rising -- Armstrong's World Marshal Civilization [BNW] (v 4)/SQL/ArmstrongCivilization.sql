--All SQL Civilization inserts were based off of SQL code from JFD's Civilizations.


--*******************************************************************
-- World Marshal (uses America as a baseline)
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage)

SELECT ('CIVILIZATION_WORLD_MARSHAL'), ('TXT_KEY_CIV_WORLD_MARSHAL_DESC'), ('TXT_KEY_CIV_WORLD_MARSHAL_SHORT_DESC'), ('TXT_KEY_CIV_WORLD_MARSHAL_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_WORLD_MARSHAL'), ('PLAYERCOLOR_WORLD_MARSHAL'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_WORLD_MARSHAL'), 0, ('CIV_ALPHA_ATLAS_WORLD_MARSHAL'), ('AMERICA'), ('SenArmstrongSelectImage.dds'),
('TXT_KEY_CIV5_DAWN_WORLD_MARSHAL_TEXT'), ('DOM-SenArmstrong.dds')

FROM Civilizations WHERE (Type = 'CIVILIZATION_AMERICA');

--*******************************************************************
-- Leader (Armstrong)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 				LeaderheadType)
VALUES		('CIVILIZATION_WORLD_MARSHAL', 	'LEADER_SENATOR_ARMSTRONG');	



--*******************************************************************
-- Unique Units (Cyborg Ninja)
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 				UnitClassType, 						UnitType)
VALUES		('CIVILIZATION_WORLD_MARSHAL', 	'UNITCLASS_MECHANIZED_INFANTRY', 	'UNIT_CYBORG_NINJA');


--*******************************************************************
-- Unique Buildings (Desperado Junta)
--*******************************************************************

INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 				BuildingClassType, 				BuildingType)
VALUES		('CIVILIZATION_WORLD_MARSHAL', 	'BUILDINGCLASS_COURTHOUSE', 	'BUILDING_DESPERADO_JUNTA');


--******************************************************************************************************************************************
-- City Names (naming theme: Capital is Stilwater, second city is Steelport, the other names are after individual neighborhoods within them.
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 					CityName)
VALUES		('CIVILIZATION_WORLD_MARSHAL', 	'TXT_KEY_CITY_NAME_WORLD_MARSHAL_1'),
			('CIVILIZATION_WORLD_MARSHAL', 	'TXT_KEY_CITY_NAME_WORLD_MARSHAL_2'),
			('CIVILIZATION_WORLD_MARSHAL', 	'TXT_KEY_CITY_NAME_WORLD_MARSHAL_3'),
			('CIVILIZATION_WORLD_MARSHAL', 	'TXT_KEY_CITY_NAME_WORLD_MARSHAL_4'),
			('CIVILIZATION_WORLD_MARSHAL', 	'TXT_KEY_CITY_NAME_WORLD_MARSHAL_5'),
			('CIVILIZATION_WORLD_MARSHAL', 	'TXT_KEY_CITY_NAME_WORLD_MARSHAL_6'),
			('CIVILIZATION_WORLD_MARSHAL', 	'TXT_KEY_CITY_NAME_WORLD_MARSHAL_7'),
			('CIVILIZATION_WORLD_MARSHAL', 	'TXT_KEY_CITY_NAME_WORLD_MARSHAL_8'),
			('CIVILIZATION_WORLD_MARSHAL', 	'TXT_KEY_CITY_NAME_WORLD_MARSHAL_9'),
			('CIVILIZATION_WORLD_MARSHAL', 	'TXT_KEY_CITY_NAME_WORLD_MARSHAL_10'),
			('CIVILIZATION_WORLD_MARSHAL', 	'TXT_KEY_CITY_NAME_WORLD_MARSHAL_11'),
			('CIVILIZATION_WORLD_MARSHAL', 	'TXT_KEY_CITY_NAME_WORLD_MARSHAL_12'),
			('CIVILIZATION_WORLD_MARSHAL', 	'TXT_KEY_CITY_NAME_WORLD_MARSHAL_13'),
			('CIVILIZATION_WORLD_MARSHAL', 	'TXT_KEY_CITY_NAME_WORLD_MARSHAL_14'),
			('CIVILIZATION_WORLD_MARSHAL', 	'TXT_KEY_CITY_NAME_WORLD_MARSHAL_15'),
			('CIVILIZATION_WORLD_MARSHAL', 	'TXT_KEY_CITY_NAME_WORLD_MARSHAL_16'),
			('CIVILIZATION_WORLD_MARSHAL', 	'TXT_KEY_CITY_NAME_WORLD_MARSHAL_17'),
			('CIVILIZATION_WORLD_MARSHAL', 	'TXT_KEY_CITY_NAME_WORLD_MARSHAL_18'),
			('CIVILIZATION_WORLD_MARSHAL', 	'TXT_KEY_CITY_NAME_WORLD_MARSHAL_19'),
			('CIVILIZATION_WORLD_MARSHAL', 	'TXT_KEY_CITY_NAME_WORLD_MARSHAL_20'),
			('CIVILIZATION_WORLD_MARSHAL', 	'TXT_KEY_CITY_NAME_WORLD_MARSHAL_21'),
			('CIVILIZATION_WORLD_MARSHAL', 	'TXT_KEY_CITY_NAME_WORLD_MARSHAL_22'),
			('CIVILIZATION_WORLD_MARSHAL', 	'TXT_KEY_CITY_NAME_WORLD_MARSHAL_23'),
			('CIVILIZATION_WORLD_MARSHAL', 	'TXT_KEY_CITY_NAME_WORLD_MARSHAL_24'),
			('CIVILIZATION_WORLD_MARSHAL', 	'TXT_KEY_CITY_NAME_WORLD_MARSHAL_25'),
			('CIVILIZATION_WORLD_MARSHAL', 	'TXT_KEY_CITY_NAME_WORLD_MARSHAL_26'),
			('CIVILIZATION_WORLD_MARSHAL', 	'TXT_KEY_CITY_NAME_WORLD_MARSHAL_27'),
			('CIVILIZATION_WORLD_MARSHAL', 	'TXT_KEY_CITY_NAME_WORLD_MARSHAL_28'),
			('CIVILIZATION_WORLD_MARSHAL', 	'TXT_KEY_CITY_NAME_WORLD_MARSHAL_29'),
			('CIVILIZATION_WORLD_MARSHAL', 	'TXT_KEY_CITY_NAME_WORLD_MARSHAL_30');

--*******************************************************************
-- Free Buildings (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 				BuildingClassType)
SELECT		('CIVILIZATION_WORLD_MARSHAL'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_AMERICA');

--*******************************************************************
-- Free Techs (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_WORLD_MARSHAL'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_AMERICA');

--*******************************************************************
-- Free Units (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_WORLD_MARSHAL'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_AMERICA');

--******************************************************************************************************************************************
--Religion (taken from America)
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 									ReligionType)
SELECT		('CIVILIZATION_WORLD_MARSHAL'),				ReligionType
FROM Civilization_Religions WHERE (CivilizationType = 'CIVILIZATION_AMERICA');

--*******************************************************************
-- Spy Names
--*******************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		
			('CIVILIZATION_WORLD_MARSHAL', 	'TXT_KEY_SPY_NAME_WORLD_MARSHAL_0'),	
			('CIVILIZATION_WORLD_MARSHAL', 	'TXT_KEY_SPY_NAME_WORLD_MARSHAL_1'),
			('CIVILIZATION_WORLD_MARSHAL', 	'TXT_KEY_SPY_NAME_WORLD_MARSHAL_2'),
			('CIVILIZATION_WORLD_MARSHAL', 	'TXT_KEY_SPY_NAME_WORLD_MARSHAL_3'),
			('CIVILIZATION_WORLD_MARSHAL', 	'TXT_KEY_SPY_NAME_WORLD_MARSHAL_4'),
			('CIVILIZATION_WORLD_MARSHAL', 	'TXT_KEY_SPY_NAME_WORLD_MARSHAL_5'),
			('CIVILIZATION_WORLD_MARSHAL', 	'TXT_KEY_SPY_NAME_WORLD_MARSHAL_6'),
			('CIVILIZATION_WORLD_MARSHAL', 	'TXT_KEY_SPY_NAME_WORLD_MARSHAL_7'),
			('CIVILIZATION_WORLD_MARSHAL', 	'TXT_KEY_SPY_NAME_WORLD_MARSHAL_8'),
			('CIVILIZATION_WORLD_MARSHAL', 	'TXT_KEY_SPY_NAME_WORLD_MARSHAL_9');

