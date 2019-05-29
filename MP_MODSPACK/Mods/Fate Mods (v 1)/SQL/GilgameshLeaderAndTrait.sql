--All SQL Leader inserts were based off of SQL code from JFD's Civilizations.

--*******************************************************************
-- Gilgamesh, King of Heroes
--*******************************************************************

INSERT INTO Leaders 
			(Type, 				Description, 				Civilopedia, 					CivilopediaTag, 						ArtDefineTag,			
			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness,
			Chattiness, Meanness, 	IconAtlas, 					PortraitIndex)
VALUES		('LEADER_GILGAMESH_FSN', 	'TXT_KEY_LEADER_GILGAMESH_FSN', 	'TXT_KEY_LEADER_GILGAMESH_FSN_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_GILGAMESH_FSN', 	'GilgameshFSNScene.xml',
			6, 						12, 					3, 							8, 			5, 				1, 				7, 						1, 				3, 			1, 			1,
			4, 			8, 			'CIV_COLOR_ATLAS_GILGAMESH_FSN', 	1);


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 				MajorCivApproachType, 				Bias)
VALUES		('LEADER_GILGAMESH_FSN', 	'MAJOR_CIV_APPROACH_WAR', 			8),
			('LEADER_GILGAMESH_FSN', 	'MAJOR_CIV_APPROACH_HOSTILE', 		8),
			('LEADER_GILGAMESH_FSN', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	7),
			('LEADER_GILGAMESH_FSN', 	'MAJOR_CIV_APPROACH_GUARDED', 		8),
			('LEADER_GILGAMESH_FSN', 	'MAJOR_CIV_APPROACH_AFRAID', 		1),
			('LEADER_GILGAMESH_FSN', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		4),
			('LEADER_GILGAMESH_FSN', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		2);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 		MinorCivApproachType, 				Bias)
VALUES		('LEADER_GILGAMESH_FSN', 	'MINOR_CIV_APPROACH_IGNORE', 		8),
			('LEADER_GILGAMESH_FSN', 	'MINOR_CIV_APPROACH_FRIENDLY', 		1),
			('LEADER_GILGAMESH_FSN', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	1),
			('LEADER_GILGAMESH_FSN', 	'MINOR_CIV_APPROACH_CONQUEST', 		2),
			('LEADER_GILGAMESH_FSN', 	'MINOR_CIV_APPROACH_BULLY', 		8);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 		FlavorType, 						Flavor)
VALUES		('LEADER_GILGAMESH_FSN', 	'FLAVOR_OFFENSE', 					8),
			('LEADER_GILGAMESH_FSN', 	'FLAVOR_DEFENSE', 					5),
			('LEADER_GILGAMESH_FSN', 	'FLAVOR_CITY_DEFENSE', 				4),
			('LEADER_GILGAMESH_FSN', 	'FLAVOR_MILITARY_TRAINING', 		4),
			('LEADER_GILGAMESH_FSN', 	'FLAVOR_RECON', 					7),
			('LEADER_GILGAMESH_FSN', 	'FLAVOR_RANGED', 					6),
			('LEADER_GILGAMESH_FSN', 	'FLAVOR_MOBILE', 					4),
			('LEADER_GILGAMESH_FSN', 	'FLAVOR_NAVAL', 					6),
			('LEADER_GILGAMESH_FSN', 	'FLAVOR_NAVAL_RECON', 				3),
			('LEADER_GILGAMESH_FSN', 	'FLAVOR_NAVAL_GROWTH', 				4),
			('LEADER_GILGAMESH_FSN', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
			('LEADER_GILGAMESH_FSN', 	'FLAVOR_AIR', 						5),
			('LEADER_GILGAMESH_FSN', 	'FLAVOR_EXPANSION', 				8),
			('LEADER_GILGAMESH_FSN', 	'FLAVOR_GROWTH', 					4),
			('LEADER_GILGAMESH_FSN', 	'FLAVOR_TILE_IMPROVEMENT', 			4),
			('LEADER_GILGAMESH_FSN', 	'FLAVOR_INFRASTRUCTURE', 			3),
			('LEADER_GILGAMESH_FSN', 	'FLAVOR_PRODUCTION', 				6),
			('LEADER_GILGAMESH_FSN', 	'FLAVOR_GOLD', 						10),
			('LEADER_GILGAMESH_FSN', 	'FLAVOR_SCIENCE', 					5),
			('LEADER_GILGAMESH_FSN', 	'FLAVOR_CULTURE', 					2),
			('LEADER_GILGAMESH_FSN', 	'FLAVOR_HAPPINESS', 				1),
			('LEADER_GILGAMESH_FSN', 	'FLAVOR_GREAT_PEOPLE', 				2),
			('LEADER_GILGAMESH_FSN', 	'FLAVOR_WONDER', 					7),
			('LEADER_GILGAMESH_FSN', 	'FLAVOR_RELIGION', 					1),
			('LEADER_GILGAMESH_FSN', 	'FLAVOR_DIPLOMACY', 				3),
			('LEADER_GILGAMESH_FSN', 	'FLAVOR_SPACESHIP', 				6),
			('LEADER_GILGAMESH_FSN', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_GILGAMESH_FSN', 	'FLAVOR_NUKE', 						6),
			('LEADER_GILGAMESH_FSN', 	'FLAVOR_USE_NUKE', 					9),
			('LEADER_GILGAMESH_FSN', 	'FLAVOR_ESPIONAGE', 				4),
			('LEADER_GILGAMESH_FSN', 	'FLAVOR_ANTIAIR',	 				4),
			('LEADER_GILGAMESH_FSN', 	'FLAVOR_AIR_CARRIER', 				5),
			('LEADER_GILGAMESH_FSN', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_GILGAMESH_FSN', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_GILGAMESH_FSN', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_GILGAMESH_FSN', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_GILGAMESH_FSN', 	'FLAVOR_ARCHAEOLOGY', 				5),
			('LEADER_GILGAMESH_FSN', 	'FLAVOR_AIRLIFT', 					5);


--*******************************************************************
-- Trait Definition (Gate of Babylon)
--*******************************************************************
INSERT INTO Traits
			(Type,						Description,						ShortDescription,						BuildAllUniqueUnits,	ConvertFaithToGold,	LevelExperienceModifier)
VALUES		('TRAIT_GATE_OF_BABYLON',	'TXT_KEY_TRAIT_GATE_OF_BABYLON',	'TXT_KEY_TRAIT_GATE_OF_BABYLON_SHORT',	1,						1,					100);

--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 		TraitType)
VALUES		('LEADER_GILGAMESH_FSN', 	'TRAIT_GATE_OF_BABYLON');



--Dummy Policy
INSERT INTO Policies
			(Type,						UnitGoldMaintenanceMod)
VALUES		('POLICY_GILGAMESH_VAULT',	-33);


INSERT INTO Policy_HurryModifiers
			(PolicyType,				HurryType,		HurryCostModifier)
VALUES		('POLICY_GILGAMESH_VAULT',	'HURRY_GOLD',	-15);