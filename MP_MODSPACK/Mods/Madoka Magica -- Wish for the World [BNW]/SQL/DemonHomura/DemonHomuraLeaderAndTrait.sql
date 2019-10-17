--All SQL Leader inserts were based off of SQL code from JFD's Civilizations.

--*******************************************************************
-- Demon Homura
--*******************************************************************

INSERT INTO Leaders 
			(Type, 						Description, 						Civilopedia, 							CivilopediaTag, 								ArtDefineTag,				VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 							PortraitIndex)
VALUES		('LEADER_DEMON_HOMURA', 	'TXT_KEY_LEADER_DEMON_HOMURA', 		'TXT_KEY_LEADER_DEMON_HOMURA_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_DEMON_HOMURA', 	'HomuraRebellionScene.xml',	9,						2, 						2, 							6, 			5, 				6, 				4, 						4, 				1, 			4, 			0, 				3, 			12, 		'CIV_COLOR_ATLAS_DEMON_HOMURA', 	1);


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 				MajorCivApproachType, 				Bias)
VALUES		('LEADER_DEMON_HOMURA', 	'MAJOR_CIV_APPROACH_WAR', 			5),
			('LEADER_DEMON_HOMURA', 	'MAJOR_CIV_APPROACH_HOSTILE', 		7),
			('LEADER_DEMON_HOMURA', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	11),
			('LEADER_DEMON_HOMURA', 	'MAJOR_CIV_APPROACH_GUARDED', 		8),
			('LEADER_DEMON_HOMURA', 	'MAJOR_CIV_APPROACH_AFRAID', 		1),
			('LEADER_DEMON_HOMURA', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		2),
			('LEADER_DEMON_HOMURA', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		2);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 			MinorCivApproachType, 				Bias)
VALUES		('LEADER_DEMON_HOMURA', 	'MINOR_CIV_APPROACH_IGNORE', 		7),
			('LEADER_DEMON_HOMURA', 	'MINOR_CIV_APPROACH_FRIENDLY', 		2),
			('LEADER_DEMON_HOMURA', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	2),
			('LEADER_DEMON_HOMURA', 	'MINOR_CIV_APPROACH_CONQUEST', 		8),
			('LEADER_DEMON_HOMURA', 	'MINOR_CIV_APPROACH_BULLY', 		6);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 				FlavorType, 						Flavor)
VALUES		('LEADER_DEMON_HOMURA', 	'FLAVOR_OFFENSE', 					3),
			('LEADER_DEMON_HOMURA', 	'FLAVOR_DEFENSE', 					8),
			('LEADER_DEMON_HOMURA', 	'FLAVOR_CITY_DEFENSE', 				5),
			('LEADER_DEMON_HOMURA', 	'FLAVOR_MILITARY_TRAINING', 		6),
			('LEADER_DEMON_HOMURA', 	'FLAVOR_RECON', 					3),
			('LEADER_DEMON_HOMURA', 	'FLAVOR_RANGED', 					8),
			('LEADER_DEMON_HOMURA', 	'FLAVOR_MOBILE', 					6),
			('LEADER_DEMON_HOMURA', 	'FLAVOR_NAVAL', 					6),
			('LEADER_DEMON_HOMURA', 	'FLAVOR_NAVAL_RECON', 				4),
			('LEADER_DEMON_HOMURA', 	'FLAVOR_NAVAL_GROWTH', 				4),
			('LEADER_DEMON_HOMURA', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	6),
			('LEADER_DEMON_HOMURA', 	'FLAVOR_AIR', 						5),
			('LEADER_DEMON_HOMURA', 	'FLAVOR_EXPANSION', 				5),
			('LEADER_DEMON_HOMURA', 	'FLAVOR_GROWTH', 					8),
			('LEADER_DEMON_HOMURA', 	'FLAVOR_TILE_IMPROVEMENT', 			7),
			('LEADER_DEMON_HOMURA', 	'FLAVOR_INFRASTRUCTURE', 			5),
			('LEADER_DEMON_HOMURA', 	'FLAVOR_PRODUCTION', 				4),
			('LEADER_DEMON_HOMURA', 	'FLAVOR_GOLD', 						3),
			('LEADER_DEMON_HOMURA', 	'FLAVOR_SCIENCE', 					7),
			('LEADER_DEMON_HOMURA', 	'FLAVOR_CULTURE', 					8),
			('LEADER_DEMON_HOMURA', 	'FLAVOR_HAPPINESS', 				7),
			('LEADER_DEMON_HOMURA', 	'FLAVOR_GREAT_PEOPLE', 				2),
			('LEADER_DEMON_HOMURA', 	'FLAVOR_WONDER', 					5),
			('LEADER_DEMON_HOMURA', 	'FLAVOR_RELIGION', 					4),
			('LEADER_DEMON_HOMURA', 	'FLAVOR_DIPLOMACY', 				2),
			('LEADER_DEMON_HOMURA', 	'FLAVOR_SPACESHIP', 				3),
			('LEADER_DEMON_HOMURA', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_DEMON_HOMURA', 	'FLAVOR_NUKE', 						12),
			('LEADER_DEMON_HOMURA', 	'FLAVOR_USE_NUKE', 					12),
			('LEADER_DEMON_HOMURA', 	'FLAVOR_ESPIONAGE', 				7),
			('LEADER_DEMON_HOMURA', 	'FLAVOR_ANTIAIR',	 				4),
			('LEADER_DEMON_HOMURA', 	'FLAVOR_AIR_CARRIER', 				7),
			('LEADER_DEMON_HOMURA', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_DEMON_HOMURA', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_DEMON_HOMURA', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_DEMON_HOMURA', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_DEMON_HOMURA', 	'FLAVOR_ARCHAEOLOGY', 				5),
			('LEADER_DEMON_HOMURA', 	'FLAVOR_AIRLIFT', 					5);


--*******************************************************************
-- Trait Definition (Lovevil)
--*******************************************************************
INSERT INTO Traits
			(Type,										 Description,										 ShortDescription,																		
			NoMagicalGirls,			CapitalBonusPerKilledMagicalGirl,	MagicalGirlAttrition)
VALUES		('TRAIT_NO_GREAT_PEOPLE_CAPITAL_YIELD_FROM_MG_KILLS', 'TXT_KEY_TRAIT_NO_GREAT_PEOPLE_CAPITAL_YIELD_FROM_MG_KILLS', 'TXT_KEY_TRAIT_NO_GREAT_PEOPLE_CAPITAL_YIELD_FROM_MG_KILLS_SHORT',
			1,						1,									5);


--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 			TraitType)
VALUES		('LEADER_DEMON_HOMURA', 	'TRAIT_NO_GREAT_PEOPLE_CAPITAL_YIELD_FROM_MG_KILLS');








--*********************************************************************************
--BuildingClasses (dummies)
--*********************************************************************************
INSERT INTO BuildingClasses
			(Type,										DefaultBuilding)
VALUES		('BUILDINGCLASS_PMMM_DEMON_HOMURA_DUMMY_1','BUILDING_PMMM_DEMON_HOMURA_DUMMY_1'),
			('BUILDINGCLASS_PMMM_DEMON_HOMURA_DUMMY_2','BUILDING_PMMM_DEMON_HOMURA_DUMMY_2'),
			('BUILDINGCLASS_PMMM_DEMON_HOMURA_DUMMY_4','BUILDING_PMMM_DEMON_HOMURA_DUMMY_4'),
			('BUILDINGCLASS_PMMM_DEMON_HOMURA_DUMMY_8','BUILDING_PMMM_DEMON_HOMURA_DUMMY_8'),
			('BUILDINGCLASS_PMMM_DEMON_HOMURA_DUMMY_16','BUILDING_PMMM_DEMON_HOMURA_DUMMY_16'),
			('BUILDINGCLASS_PMMM_DEMON_HOMURA_DUMMY_32','BUILDING_PMMM_DEMON_HOMURA_DUMMY_32'),
			('BUILDINGCLASS_PMMM_DEMON_HOMURA_DUMMY_64','BUILDING_PMMM_DEMON_HOMURA_DUMMY_64'),
			('BUILDINGCLASS_PMMM_DEMON_HOMURA_DUMMY_128','BUILDING_PMMM_DEMON_HOMURA_DUMMY_128'),
			('BUILDINGCLASS_PMMM_DEMON_HOMURA_DUMMY_256','BUILDING_PMMM_DEMON_HOMURA_DUMMY_256');


--Dummies
INSERT INTO Buildings
			(Type,										BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune)
SELECT		DefaultBuilding,							Type,
			-1,		-1,			-1,				null,		1,				1
FROM BuildingClasses WHERE Type LIKE ('BUILDINGCLASS_PMMM_DEMON_HOMURA_DUMMY_%');



--*********************************************************************************
--Building_BuildingClassYieldChanges
--*********************************************************************************
INSERT INTO Building_BuildingClassYieldChanges
			(BuildingType,		BuildingClassType,			YieldType,			YieldChange)
SELECT		Type,				('BUILDINGCLASS_PALACE'),	('YIELD_CULTURE'),	CAST(REPLACE(Type, 'BUILDING_PMMM_DEMON_HOMURA_DUMMY_', '') AS INT)
FROM Buildings WHERE Type LIKE ('BUILDING_PMMM_DEMON_HOMURA_DUMMY_%');

INSERT INTO Building_BuildingClassYieldChanges
			(BuildingType,		BuildingClassType,			YieldType,				YieldChange)
SELECT		Type,				('BUILDINGCLASS_PALACE'),	('YIELD_PRODUCTION'),	CAST(REPLACE(Type, 'BUILDING_PMMM_DEMON_HOMURA_DUMMY_', '') AS INT)
FROM Buildings WHERE Type LIKE ('BUILDING_PMMM_DEMON_HOMURA_DUMMY_%');

INSERT INTO Building_BuildingClassYieldChanges
			(BuildingType,		BuildingClassType,			YieldType,			YieldChange)
SELECT		Type,				('BUILDINGCLASS_PALACE'),	('YIELD_SCIENCE'),	CAST(REPLACE(Type, 'BUILDING_PMMM_DEMON_HOMURA_DUMMY_', '') AS INT)
FROM Buildings WHERE Type LIKE ('BUILDING_PMMM_DEMON_HOMURA_DUMMY_%');

INSERT INTO Building_BuildingClassYieldChanges
			(BuildingType,		BuildingClassType,			YieldType,			YieldChange)
SELECT		Type,				('BUILDINGCLASS_PALACE'),	('YIELD_GOLD'),		CAST(REPLACE(Type, 'BUILDING_PMMM_DEMON_HOMURA_DUMMY_', '') AS INT)
FROM Buildings WHERE Type LIKE ('BUILDING_PMMM_DEMON_HOMURA_DUMMY_%');

INSERT INTO Building_BuildingClassYieldChanges
			(BuildingType,		BuildingClassType,			YieldType,			YieldChange)
SELECT		Type,				('BUILDINGCLASS_PALACE'),	('YIELD_TOURISM'),	CAST(REPLACE(Type, 'BUILDING_PMMM_DEMON_HOMURA_DUMMY_', '') AS INT)
FROM Buildings WHERE Type LIKE ('BUILDING_PMMM_DEMON_HOMURA_DUMMY_%');