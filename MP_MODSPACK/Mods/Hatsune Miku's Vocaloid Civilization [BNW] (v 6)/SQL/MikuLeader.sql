--All SQL Leader inserts were based off of SQL code from JFD's Civilizations.

--*******************************************************************
-- MIKU Tomoe
--*******************************************************************

INSERT INTO Leaders 
			(Type, 			Description, 			Civilopedia, 					CivilopediaTag, 					ArtDefineTag,		
			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 
			Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 				PortraitIndex)
VALUES		('LEADER_MIKU', 'TXT_KEY_LEADER_MIKU', 	'TXT_KEY_LEADER_MIKU_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_MIKU', 'MikuScene.xml',
			3,						9, 						6, 							3, 			6, 				5, 				6, 						8, 			6, 
			7, 			5, 				8, 			4, 			'CIV_COLOR_ATLAS_MIKU', 1);


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 		MajorCivApproachType, 				Bias)
VALUES		('LEADER_MIKU', 	'MAJOR_CIV_APPROACH_WAR', 			3),
			('LEADER_MIKU', 	'MAJOR_CIV_APPROACH_HOSTILE', 		3),
			('LEADER_MIKU', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	5),
			('LEADER_MIKU', 	'MAJOR_CIV_APPROACH_GUARDED', 		5),
			('LEADER_MIKU', 	'MAJOR_CIV_APPROACH_AFRAID', 		4),
			('LEADER_MIKU', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		7),
			('LEADER_MIKU', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		6);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 		MinorCivApproachType, 				Bias)
VALUES		('LEADER_MIKU', 	'MINOR_CIV_APPROACH_IGNORE', 		4),
			('LEADER_MIKU', 	'MINOR_CIV_APPROACH_FRIENDLY', 		7),
			('LEADER_MIKU', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	6),
			('LEADER_MIKU', 	'MINOR_CIV_APPROACH_CONQUEST', 		2),
			('LEADER_MIKU', 	'MINOR_CIV_APPROACH_BULLY', 		3);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 		FlavorType, 						Flavor)
VALUES		('LEADER_MIKU', 	'FLAVOR_OFFENSE', 					3),
			('LEADER_MIKU', 	'FLAVOR_DEFENSE', 					5),
			('LEADER_MIKU', 	'FLAVOR_CITY_DEFENSE', 				5),
			('LEADER_MIKU', 	'FLAVOR_MILITARY_TRAINING', 		4),
			('LEADER_MIKU', 	'FLAVOR_RECON', 					5),
			('LEADER_MIKU', 	'FLAVOR_RANGED', 					6),
			('LEADER_MIKU', 	'FLAVOR_MOBILE', 					5),
			('LEADER_MIKU', 	'FLAVOR_NAVAL', 					5),
			('LEADER_MIKU', 	'FLAVOR_NAVAL_RECON', 				5),
			('LEADER_MIKU', 	'FLAVOR_NAVAL_GROWTH', 				6),
			('LEADER_MIKU', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	6),
			('LEADER_MIKU', 	'FLAVOR_AIR', 						7),
			('LEADER_MIKU', 	'FLAVOR_EXPANSION', 				4),
			('LEADER_MIKU', 	'FLAVOR_GROWTH', 					8),
			('LEADER_MIKU', 	'FLAVOR_TILE_IMPROVEMENT', 			7),
			('LEADER_MIKU', 	'FLAVOR_INFRASTRUCTURE', 			4),
			('LEADER_MIKU', 	'FLAVOR_PRODUCTION', 				4),
			('LEADER_MIKU', 	'FLAVOR_GOLD', 						5),
			('LEADER_MIKU', 	'FLAVOR_SCIENCE', 					8),
			('LEADER_MIKU', 	'FLAVOR_CULTURE', 					8),
			('LEADER_MIKU', 	'FLAVOR_HAPPINESS', 				5),
			('LEADER_MIKU', 	'FLAVOR_GREAT_PEOPLE', 				8),
			('LEADER_MIKU', 	'FLAVOR_WONDER', 					6),
			('LEADER_MIKU', 	'FLAVOR_RELIGION', 					3),
			('LEADER_MIKU', 	'FLAVOR_DIPLOMACY', 				4),
			('LEADER_MIKU', 	'FLAVOR_SPACESHIP', 				8),
			('LEADER_MIKU', 	'FLAVOR_WATER_CONNECTION', 			6),
			('LEADER_MIKU', 	'FLAVOR_NUKE', 						5),
			('LEADER_MIKU', 	'FLAVOR_USE_NUKE', 					2),
			('LEADER_MIKU', 	'FLAVOR_ESPIONAGE', 				7),
			('LEADER_MIKU', 	'FLAVOR_ANTIAIR',	 				6),
			('LEADER_MIKU', 	'FLAVOR_AIR_CARRIER', 				6),
			('LEADER_MIKU', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_MIKU', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_MIKU', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_MIKU', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_MIKU', 	'FLAVOR_ARCHAEOLOGY', 				6),
			('LEADER_MIKU', 	'FLAVOR_AIRLIFT', 					5);


--*******************************************************************
-- Trait Definition (Not Afraid of Anything Anymore)
--*******************************************************************
INSERT INTO Traits
			(Type,									Description,								 ShortDescription)
VALUES		('TRAIT_TOURISM_FROM_SCIENCE',	'TXT_KEY_TRAIT_TOURISM_FROM_SCIENCE', 'TXT_KEY_TRAIT_TOURISM_FROM_SCIENCE_SHORT');


--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 			TraitType)
VALUES		('LEADER_MIKU', 	'TRAIT_TOURISM_FROM_SCIENCE');





