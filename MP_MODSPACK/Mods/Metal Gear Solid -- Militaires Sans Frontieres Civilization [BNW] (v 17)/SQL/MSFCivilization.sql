--All SQL Civilization inserts were based off of SQL code from JFD's Civilizations.


--*******************************************************************
-- Militaires Sans Frontieres (uses America as a baseline)
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage)

SELECT ('CIVILIZATION_MSF'), ('TXT_KEY_CIV_MSF_DESC'), ('TXT_KEY_CIV_MSF_SHORT_DESC'), ('TXT_KEY_CIV_MSF_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_MSF'), ('PLAYERCOLOR_MSF'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_MSF'), 0, ('CIV_ALPHA_ATLAS_MSF'), ('AMERICA'), ('MSFSelectImage.dds'),
('TXT_KEY_CIV5_DAWN_BIGBOSS_TEXT'), ('DOM_Big_Boss.dds')

FROM Civilizations WHERE (Type = 'CIVILIZATION_AMERICA');

--*******************************************************************
-- Leader (Big Boss)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 		LeaderheadType)
VALUES		('CIVILIZATION_MSF', 	'LEADER_BIGBOSS');	



--*******************************************************************
-- Unique Units (Stealth Operative, Metal Gear)
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 		UnitClassType, 				UnitType)
VALUES		('CIVILIZATION_MSF', 	'UNITCLASS_PARATROOPER', 	'UNIT_STEALTH_OPERATIVE'),
			('CIVILIZATION_MSF', 	'UNITCLASS_METAL_GEAR', 	'UNIT_METAL_GEAR'),
			('CIVILIZATION_MSF', 	'UNITCLASS_CITYSTATEPUPPETER_DUMMY', 	'UNIT_CITYSTATEPUPPETER_DUMMY'); --dummy for Collective rule policy and later era starts


--*******************************************************************
-- Unique Buildings (has a Palatial replacement without its bonuses; the bonuses are done through the upgrade system)
--*******************************************************************

INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 		BuildingClassType, 				BuildingType)
VALUES		('CIVILIZATION_MSF', 	'BUILDINGCLASS_PALACE', 	'BUILDING_MSF_MAIN_HALL');


--******************************************************************************************************************************************
-- City Names (just Mother Base!)
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 		CityName)
VALUES		('CIVILIZATION_MSF', 	'TXT_KEY_CITY_NAME_MOTHER_BASE');

--*******************************************************************
-- Free Buildings (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 				BuildingClassType)
SELECT		('CIVILIZATION_MSF'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_AMERICA');

--*******************************************************************
-- Free Techs (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_MSF'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_AMERICA');

--*******************************************************************
-- Free Units (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_MSF'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_AMERICA');

--******************************************************************************************************************************************
--Religion (taken from America)
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 									ReligionType)
SELECT		('CIVILIZATION_MSF'),				ReligionType
FROM Civilization_Religions WHERE (CivilizationType = 'CIVILIZATION_AMERICA');

--*******************************************************************
-- Spy Names
--*******************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		
			('CIVILIZATION_MSF', 	'TXT_KEY_SPY_NAME_MSF_0'),	
			('CIVILIZATION_MSF', 	'TXT_KEY_SPY_NAME_MSF_1'),
			('CIVILIZATION_MSF', 	'TXT_KEY_SPY_NAME_MSF_2'),
			('CIVILIZATION_MSF', 	'TXT_KEY_SPY_NAME_MSF_3'),
			('CIVILIZATION_MSF', 	'TXT_KEY_SPY_NAME_MSF_4'),
			('CIVILIZATION_MSF', 	'TXT_KEY_SPY_NAME_MSF_5'),
			('CIVILIZATION_MSF', 	'TXT_KEY_SPY_NAME_MSF_6'),
			('CIVILIZATION_MSF', 	'TXT_KEY_SPY_NAME_MSF_7'),
			('CIVILIZATION_MSF', 	'TXT_KEY_SPY_NAME_MSF_8'),
			('CIVILIZATION_MSF', 	'TXT_KEY_SPY_NAME_MSF_9');
			
			
--*******************************************************************
-- SPECIAL CIVS USED WITH EVENTS & DECISIONS
--*******************************************************************	
			
			
--*******************************************************************
-- Diamond Dogs
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage)

SELECT ('CIVILIZATION_DIAMOND_DOGS'), ('TXT_KEY_CIV_DIAMOND_DOGS_DESC'), ('TXT_KEY_CIV_DIAMOND_DOGS_SHORT_DESC'), ('TXT_KEY_CIV_DIAMOND_DOGS_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_MSF'), ('PLAYERCOLOR_DIAMOND_DOGS'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_DIAMOND_DOGS'), 0, ('CIV_ALPHA_ATLAS_DIAMOND_DOGS'), ('AMERICA'), ('MSFSelectImage.dds'),
('TXT_KEY_CIV5_DAWN_DIAMOND_DOGS_TEXT'), ('DOM_VenomSnake.dds')

FROM Civilizations WHERE (Type = 'CIVILIZATION_AMERICA');

--*******************************************************************
-- Leader (Venom Snake)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 				LeaderheadType)
VALUES		('CIVILIZATION_DIAMOND_DOGS', 	'LEADER_VENOM_SNAKE');	



--*******************************************************************
-- Unique Units (Stealth Operative, Metal Gear)
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 				UnitClassType, 				UnitType)
VALUES		('CIVILIZATION_DIAMOND_DOGS', 	'UNITCLASS_PARATROOPER', 	'UNIT_STEALTH_OPERATIVE'),
			('CIVILIZATION_DIAMOND_DOGS', 	'UNITCLASS_METAL_GEAR', 	'UNIT_METAL_GEAR'),
			('CIVILIZATION_DIAMOND_DOGS', 	'UNITCLASS_CITYSTATEPUPPETER_DUMMY', 	'UNIT_CITYSTATEPUPPETER_DUMMY'); --dummy for Collective rule policy and later era starts



--*******************************************************************
-- Unique Buildings (none)
--*******************************************************************



--******************************************************************************************************************************************
-- City Names (just Mother Base!)
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 		CityName)
VALUES		('CIVILIZATION_DIAMOND_DOGS', 	'TXT_KEY_CITY_NAME_MOTHER_BASE');

--*******************************************************************
-- Free Buildings (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 				BuildingClassType)
SELECT		('CIVILIZATION_DIAMOND_DOGS'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_AMERICA');

--*******************************************************************
-- Free Techs (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_DIAMOND_DOGS'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_AMERICA');

--*******************************************************************
-- Free Units (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_DIAMOND_DOGS'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_AMERICA');

--******************************************************************************************************************************************
--Religion (taken from America)
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 									ReligionType)
SELECT		('CIVILIZATION_DIAMOND_DOGS'),				ReligionType
FROM Civilization_Religions WHERE (CivilizationType = 'CIVILIZATION_AMERICA');

--*******************************************************************
-- Spy Names
--*******************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		
			('CIVILIZATION_DIAMOND_DOGS', 	'TXT_KEY_SPY_NAME_MSF_0'),	
			('CIVILIZATION_DIAMOND_DOGS', 	'TXT_KEY_SPY_NAME_MSF_1'),
			('CIVILIZATION_DIAMOND_DOGS', 	'TXT_KEY_SPY_NAME_MSF_2'),
			('CIVILIZATION_DIAMOND_DOGS', 	'TXT_KEY_SPY_NAME_MSF_3'),
			('CIVILIZATION_DIAMOND_DOGS', 	'TXT_KEY_SPY_NAME_MSF_4'),
			('CIVILIZATION_DIAMOND_DOGS', 	'TXT_KEY_SPY_NAME_MSF_5'),
			('CIVILIZATION_DIAMOND_DOGS', 	'TXT_KEY_SPY_NAME_MSF_6'),
			('CIVILIZATION_DIAMOND_DOGS', 	'TXT_KEY_SPY_NAME_MSF_7'),
			('CIVILIZATION_DIAMOND_DOGS', 	'TXT_KEY_SPY_NAME_MSF_8'),
			('CIVILIZATION_DIAMOND_DOGS', 	'TXT_KEY_SPY_NAME_MSF_9');
			
			
			
			
			
--*******************************************************************
-- Outer Heaven
--*******************************************************************
INSERT INTO Civilizations (Type, Description, ShortDescription,	Adjective, Civilopedia, CivilopediaTag, DefaultPlayerColor,
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, PortraitIndex, AlphaIconAtlas, SoundtrackTag, MapImage,
DawnOfManQuote,	DawnOfManImage)

SELECT ('CIVILIZATION_BB_OUTER_HEAVEN'), ('TXT_KEY_CIV_BB_OUTER_HEAVEN_DESC'), ('TXT_KEY_CIV_BB_OUTER_HEAVEN_SHORT_DESC'), ('TXT_KEY_CIV_BB_OUTER_HEAVEN_ADJECTIVE'), Civilopedia, ('TXT_KEY_CIV_MSF'), ('PLAYERCOLOR_BB_OUTER_HEAVEN'),
ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('CIV_COLOR_ATLAS_BB_OUTER_HEAVEN'), 0, ('CIV_ALPHA_ATLAS_BB_OUTER_HEAVEN'), ('AMERICA'), ('MSFSelectImage.dds'),
('TXT_KEY_CIV5_DAWN_BB_OUTER_HEAVEN_TEXT'), ('DOM_BigBossOH.dds')

FROM Civilizations WHERE (Type = 'CIVILIZATION_AMERICA');

--*******************************************************************
-- Leader (Old Big Boss)
--*******************************************************************
INSERT INTO Civilization_Leaders 
			(CivilizationType, 				LeaderheadType)
VALUES		('CIVILIZATION_BB_OUTER_HEAVEN', 	'LEADER_BIGBOSS_OH');	



--*******************************************************************
-- Unique Units (Stealth Operative, Metal Gear)
--*******************************************************************
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 				UnitClassType, 				UnitType)
VALUES		('CIVILIZATION_BB_OUTER_HEAVEN', 	'UNITCLASS_PARATROOPER', 	'UNIT_STEALTH_OPERATIVE'),
			('CIVILIZATION_BB_OUTER_HEAVEN', 	'UNITCLASS_METAL_GEAR', 	'UNIT_METAL_GEAR');
			--doesn't need the dummy since it doesn't have NoAnnexing

--*******************************************************************
-- Unique Buildings (none)
--*******************************************************************



--******************************************************************************************************************************************
-- City Names
--******************************************************************************************************************************************
INSERT INTO Civilization_CityNames 
			(CivilizationType, 		CityName)
VALUES		('CIVILIZATION_BB_OUTER_HEAVEN', 	'TXT_KEY_CITY_NAME_OUTER_HEAVEN');	

--*******************************************************************
-- Free Buildings (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 				BuildingClassType)
SELECT		('CIVILIZATION_BB_OUTER_HEAVEN'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_AMERICA');

--*******************************************************************
-- Free Techs (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_BB_OUTER_HEAVEN'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_AMERICA');

--*******************************************************************
-- Free Units (nothing special)
--*******************************************************************
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_BB_OUTER_HEAVEN'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_AMERICA');

--******************************************************************************************************************************************
--Religion (taken from America)
--******************************************************************************************************************************************
INSERT INTO Civilization_Religions 
			(CivilizationType, 									ReligionType)
SELECT		('CIVILIZATION_BB_OUTER_HEAVEN'),				ReligionType
FROM Civilization_Religions WHERE (CivilizationType = 'CIVILIZATION_AMERICA');

--*******************************************************************
-- Spy Names
--*******************************************************************
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		
			('CIVILIZATION_BB_OUTER_HEAVEN', 	'TXT_KEY_SPY_NAME_MSF_0'),	
			('CIVILIZATION_BB_OUTER_HEAVEN', 	'TXT_KEY_SPY_NAME_MSF_1'),
			('CIVILIZATION_BB_OUTER_HEAVEN', 	'TXT_KEY_SPY_NAME_MSF_2'),
			('CIVILIZATION_BB_OUTER_HEAVEN', 	'TXT_KEY_SPY_NAME_MSF_3'),
			('CIVILIZATION_BB_OUTER_HEAVEN', 	'TXT_KEY_SPY_NAME_MSF_4'),
			('CIVILIZATION_BB_OUTER_HEAVEN', 	'TXT_KEY_SPY_NAME_MSF_5'),
			('CIVILIZATION_BB_OUTER_HEAVEN', 	'TXT_KEY_SPY_NAME_MSF_6'),
			('CIVILIZATION_BB_OUTER_HEAVEN', 	'TXT_KEY_SPY_NAME_MSF_7'),
			('CIVILIZATION_BB_OUTER_HEAVEN', 	'TXT_KEY_SPY_NAME_MSF_8'),
			('CIVILIZATION_BB_OUTER_HEAVEN', 	'TXT_KEY_SPY_NAME_MSF_9');

			

INSERT INTO Civilization_Start_Along_Ocean
			(CivilizationType,				StartAlongOcean)
VALUES		('CIVILIZATION_MSF',			1),
			('CIVILIZATION_DIAMOND_DOGS',	1),
			('CIVILIZATION_BB_OUTER_HEAVEN',1);


INSERT INTO Civilization_Start_Place_First_Along_Ocean
			(CivilizationType,				PlaceFirst)
VALUES		('CIVILIZATION_MSF',			1),
			('CIVILIZATION_DIAMOND_DOGS',	1),
			('CIVILIZATION_BB_OUTER_HEAVEN',1);



--Icon Atlases
INSERT INTO IconTextureAtlases 
			(Atlas, 										IconSize, 	Filename, 							IconsPerRow, 	IconsPerColumn)
			-------------------Color-----------------------------------------------------------------------------------------------------------
VALUES		('CIV_COLOR_ATLAS_DIAMOND_DOGS', 				256, 		'DiamondDogsAtlas256.dds',			2, 				1),
			('CIV_COLOR_ATLAS_DIAMOND_DOGS', 				128, 		'DiamondDogsAtlas128.dds',			2, 				1),
			('CIV_COLOR_ATLAS_DIAMOND_DOGS', 				80, 		'DiamondDogsAtlas80.dds',			2, 				1),
			('CIV_COLOR_ATLAS_DIAMOND_DOGS', 				64, 		'DiamondDogsAtlas64.dds',			2, 				1),
			('CIV_COLOR_ATLAS_DIAMOND_DOGS', 				45, 		'DiamondDogsAtlas45.dds',			2, 				1),
			('CIV_COLOR_ATLAS_DIAMOND_DOGS', 				32, 		'DiamondDogsAtlas32.dds',			2, 				1),
			('CIV_COLOR_ATLAS_BB_OUTER_HEAVEN', 			256, 		'BBOuterHeavenAtlas256.dds',		2, 				1),
			('CIV_COLOR_ATLAS_BB_OUTER_HEAVEN', 			128, 		'BBOuterHeavenAtlas128.dds',		2, 				1),
			('CIV_COLOR_ATLAS_BB_OUTER_HEAVEN', 			80, 		'BBOuterHeavenAtlas80.dds',			2, 				1),
			('CIV_COLOR_ATLAS_BB_OUTER_HEAVEN', 			64, 		'BBOuterHeavenAtlas64.dds',			2, 				1),
			('CIV_COLOR_ATLAS_BB_OUTER_HEAVEN', 			45, 		'BBOuterHeavenAtlas45.dds',			2, 				1),
			('CIV_COLOR_ATLAS_BB_OUTER_HEAVEN', 			32, 		'BBOuterHeavenAtlas32.dds',			2, 				1),
			--------------------------Civ Alphas-----------------------------------------------------------------------------------------------
			('CIV_ALPHA_ATLAS_DIAMOND_DOGS', 				128, 		'DiamondDogsAlphaAtlas128.dds',		1, 				1),
			('CIV_ALPHA_ATLAS_DIAMOND_DOGS', 				80, 		'DiamondDogsAlphaAtlas80.dds',		1, 				1),
			('CIV_ALPHA_ATLAS_DIAMOND_DOGS', 				64, 		'DiamondDogsAlphaAtlas64.dds',		1, 				1),
			('CIV_ALPHA_ATLAS_DIAMOND_DOGS', 				48, 		'DiamondDogsAlphaAtlas48.dds',		1, 				1),
			('CIV_ALPHA_ATLAS_DIAMOND_DOGS', 				32, 		'DiamondDogsAlphaAtlas32.dds',		1, 				1),
			('CIV_ALPHA_ATLAS_DIAMOND_DOGS', 				24, 		'DiamondDogsAlphaAtlas24.dds',		1, 				1),
			('CIV_ALPHA_ATLAS_DIAMOND_DOGS', 				16, 		'DiamondDogsAlphaAtlas16.dds',		1, 				1),
			('CIV_ALPHA_ATLAS_BB_OUTER_HEAVEN', 			128, 		'BBOuterHeavenAlphaAtlas128.dds',	1, 				1),
			('CIV_ALPHA_ATLAS_BB_OUTER_HEAVEN', 			80, 		'BBOuterHeavenAlphaAtlas80.dds',	1, 				1),
			('CIV_ALPHA_ATLAS_BB_OUTER_HEAVEN', 			64, 		'BBOuterHeavenAlphaAtlas64.dds',	1, 				1),
			('CIV_ALPHA_ATLAS_BB_OUTER_HEAVEN',				48, 		'BBOuterHeavenAlphaAtlas48.dds',	1, 				1),
			('CIV_ALPHA_ATLAS_BB_OUTER_HEAVEN',				32, 		'BBOuterHeavenAlphaAtlas32.dds',	1, 				1),
			('CIV_ALPHA_ATLAS_BB_OUTER_HEAVEN',				24, 		'BBOuterHeavenAlphaAtlas24.dds',	1, 				1),
			('CIV_ALPHA_ATLAS_BB_OUTER_HEAVEN',				16, 		'BBOuterHeavenAlphaAtlas16.dds',	1, 				1);


--Soundtrack compatibility; can be deleted if you aren't playing with the soundtrack

UPDATE Civilizations
SET SoundtrackTag = 'BIGBOSS'
WHERE Type = 'CIVILIZATION_MSF' OR Type = 'CIVILIZATION_DIAMOND_DOGS' OR Type = 'CIVILIZATION_BB_OUTER_HEAVEN';

INSERT INTO Audio_2DSounds
			(ScriptID,									SoundID,								SoundType,			MaxVolume,			MinVolume,			IsMusic)
VALUES		('AS2D_LEADER_MUSIC_VENOM_SNAKE_PEACE',		'SND_LEADER_MUSIC_BIGBOSS_PEACE',		'GAME_MUSIC',		40,		40,		1);

INSERT INTO Audio_2DSounds
			(ScriptID,									SoundID,			SoundType,			MaxVolume,			MinVolume,			IsMusic)
VALUES		('AS2D_LEADER_MUSIC_BIGBOSS_OH_PEACE',		'SND_LEADER_MUSIC_BIGBOSS_WAR',		'GAME_MUSIC',		40,		40,		1);

INSERT INTO Audio_2DSounds
			(ScriptID,								SoundID,			SoundType,			MaxVolume,			MinVolume,			IsMusic)
VALUES		('AS2D_LEADER_MUSIC_VENOM_SNAKE_WAR',	'SND_LEADER_MUSIC_BIGBOSS_PEACE',		'GAME_MUSIC',		40,		40,		1);

INSERT INTO Audio_2DSounds
			(ScriptID,								SoundID,			SoundType,			MaxVolume,			MinVolume,			IsMusic)
VALUES		('AS2D_LEADER_MUSIC_BIGBOSS_OH_WAR',	'SND_LEADER_MUSIC_BIGBOSS_WAR',		'GAME_MUSIC',		40,		40,		1);


--By Default, Diamond Dogs and Outer Heaven are unselectable from the game setup screen due to them not being balanced for it -- they are intended to branch off from MSF.
--This can be deleted if you want to ignore this restriction.

UPDATE Civilizations
SET Playable = 0, AIPlayable = 0
WHERE Type = 'CIVILIZATION_DIAMOND_DOGS' OR Type = 'CIVILIZATION_BB_OUTER_HEAVEN';



