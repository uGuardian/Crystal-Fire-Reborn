--All SQL Leader inserts were based off of SQL code from JFD's Civilizations.

--*******************************************************************
-- CLOCHE LEYTHAL PASTALIA
--*******************************************************************

INSERT INTO Leaders 
			(Type, 			Description, 			Civilopedia, 					CivilopediaTag, 					ArtDefineTag,		
			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 
			Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 				PortraitIndex)
VALUES		('LEADER_CLOCHE', 'TXT_KEY_LEADER_CLOCHE', 	'TXT_KEY_LEADER_CLOCHE_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_CLOCHE', 'Cloche_Scene.xml',
			8,						6, 						6, 							8, 			6, 				5, 				6, 						5, 			7, 
			5, 			5, 				5, 			8, 			'CIV_COLOR_ATLAS_CLOCHE', 1);


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 		MajorCivApproachType, 				Bias)
VALUES		('LEADER_CLOCHE', 	'MAJOR_CIV_APPROACH_WAR', 			7),
			('LEADER_CLOCHE', 	'MAJOR_CIV_APPROACH_HOSTILE', 		6),
			('LEADER_CLOCHE', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	6),
			('LEADER_CLOCHE', 	'MAJOR_CIV_APPROACH_GUARDED', 		8),
			('LEADER_CLOCHE', 	'MAJOR_CIV_APPROACH_AFRAID', 		4),
			('LEADER_CLOCHE', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		7),
			('LEADER_CLOCHE', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		6);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 		MinorCivApproachType, 				Bias)
VALUES		('LEADER_CLOCHE', 	'MINOR_CIV_APPROACH_IGNORE', 		4),
			('LEADER_CLOCHE', 	'MINOR_CIV_APPROACH_FRIENDLY', 		7),
			('LEADER_CLOCHE', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	6),
			('LEADER_CLOCHE', 	'MINOR_CIV_APPROACH_CONQUEST', 		2),
			('LEADER_CLOCHE', 	'MINOR_CIV_APPROACH_BULLY', 		3);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 		FlavorType, 						Flavor)
VALUES		('LEADER_CLOCHE', 	'FLAVOR_OFFENSE', 					6),
			('LEADER_CLOCHE', 	'FLAVOR_DEFENSE', 					6),
			('LEADER_CLOCHE', 	'FLAVOR_CITY_DEFENSE', 				6),
			('LEADER_CLOCHE', 	'FLAVOR_MILITARY_TRAINING', 		6),
			('LEADER_CLOCHE', 	'FLAVOR_RECON', 					5),
			('LEADER_CLOCHE', 	'FLAVOR_RANGED', 					6),
			('LEADER_CLOCHE', 	'FLAVOR_MOBILE', 					5),
			('LEADER_CLOCHE', 	'FLAVOR_NAVAL', 					5),
			('LEADER_CLOCHE', 	'FLAVOR_NAVAL_RECON', 				5),
			('LEADER_CLOCHE', 	'FLAVOR_NAVAL_GROWTH', 				6),
			('LEADER_CLOCHE', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	6),
			('LEADER_CLOCHE', 	'FLAVOR_AIR', 						7),
			('LEADER_CLOCHE', 	'FLAVOR_EXPANSION', 				7),
			('LEADER_CLOCHE', 	'FLAVOR_GROWTH', 					6),
			('LEADER_CLOCHE', 	'FLAVOR_TILE_IMPROVEMENT', 			5),
			('LEADER_CLOCHE', 	'FLAVOR_INFRASTRUCTURE', 			4),
			('LEADER_CLOCHE', 	'FLAVOR_PRODUCTION', 				4),
			('LEADER_CLOCHE', 	'FLAVOR_GOLD', 						5),
			('LEADER_CLOCHE', 	'FLAVOR_SCIENCE', 					6),
			('LEADER_CLOCHE', 	'FLAVOR_CULTURE', 					8),
			('LEADER_CLOCHE', 	'FLAVOR_HAPPINESS', 				8),
			('LEADER_CLOCHE', 	'FLAVOR_GREAT_PEOPLE', 				8),
			('LEADER_CLOCHE', 	'FLAVOR_WONDER', 					6),
			('LEADER_CLOCHE', 	'FLAVOR_RELIGION', 					11),
			('LEADER_CLOCHE', 	'FLAVOR_DIPLOMACY', 				5),
			('LEADER_CLOCHE', 	'FLAVOR_SPACESHIP', 				4),
			('LEADER_CLOCHE', 	'FLAVOR_WATER_CONNECTION', 			6),
			('LEADER_CLOCHE', 	'FLAVOR_NUKE', 						11),
			('LEADER_CLOCHE', 	'FLAVOR_USE_NUKE', 					11),
			('LEADER_CLOCHE', 	'FLAVOR_ESPIONAGE', 				7),
			('LEADER_CLOCHE', 	'FLAVOR_ANTIAIR',	 				6),
			('LEADER_CLOCHE', 	'FLAVOR_AIR_CARRIER', 				6),
			('LEADER_CLOCHE', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_CLOCHE', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_CLOCHE', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_CLOCHE', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_CLOCHE', 	'FLAVOR_ARCHAEOLOGY', 				6),
			('LEADER_CLOCHE', 	'FLAVOR_AIRLIFT', 					7);


--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 			TraitType)
VALUES		('LEADER_CLOCHE', 	'TRAIT_HOLY_MAIDEN_OF_GRAND_BELL');