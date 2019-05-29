--All SQL Leader inserts were based off of SQL code from JFD's Civilizations.

--*******************************************************************
-- Marcus Cole, aka Statesman
--*******************************************************************

INSERT INTO Leaders 
			(Type, 					Description, 					Civilopedia, 						CivilopediaTag, 							ArtDefineTag,			
			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	
			Neediness, 	Forgiveness, Chattiness, Meanness, 	IconAtlas, 					PortraitIndex)
VALUES		('LEADER_STATESMAN', 	'TXT_KEY_LEADER_STATESMAN', 	'TXT_KEY_LEADER_STATESMAN_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_STATESMAN', 	'StatesmanScene.xml',
			6, 						5, 						6, 							3, 			8, 				10, 			8, 						5, 				9, 			
			3, 			6, 			4, 			4, 			'CIV_COLOR_ATLAS_PARAGON', 	1);


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 		MajorCivApproachType, 				Bias)
VALUES		('LEADER_STATESMAN', 	'MAJOR_CIV_APPROACH_WAR', 			4),
			('LEADER_STATESMAN', 	'MAJOR_CIV_APPROACH_HOSTILE', 		3),
			('LEADER_STATESMAN', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	2),
			('LEADER_STATESMAN', 	'MAJOR_CIV_APPROACH_GUARDED', 		7),
			('LEADER_STATESMAN', 	'MAJOR_CIV_APPROACH_AFRAID', 		1),
			('LEADER_STATESMAN', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		5),
			('LEADER_STATESMAN', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		8);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 		MinorCivApproachType, 				Bias)
VALUES		('LEADER_STATESMAN', 	'MINOR_CIV_APPROACH_IGNORE', 		4),
			('LEADER_STATESMAN', 	'MINOR_CIV_APPROACH_FRIENDLY', 		7),
			('LEADER_STATESMAN', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	8),
			('LEADER_STATESMAN', 	'MINOR_CIV_APPROACH_CONQUEST', 		2),
			('LEADER_STATESMAN', 	'MINOR_CIV_APPROACH_BULLY', 		3);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 		FlavorType, 						Flavor)
VALUES		('LEADER_STATESMAN', 	'FLAVOR_OFFENSE', 					3),
			('LEADER_STATESMAN', 	'FLAVOR_DEFENSE', 					7),
			('LEADER_STATESMAN', 	'FLAVOR_CITY_DEFENSE', 				8),
			('LEADER_STATESMAN', 	'FLAVOR_MILITARY_TRAINING', 		6),
			('LEADER_STATESMAN', 	'FLAVOR_RECON', 					3),
			('LEADER_STATESMAN', 	'FLAVOR_RANGED', 					7),
			('LEADER_STATESMAN', 	'FLAVOR_MOBILE', 					3),
			('LEADER_STATESMAN', 	'FLAVOR_NAVAL', 					7),
			('LEADER_STATESMAN', 	'FLAVOR_NAVAL_RECON', 				7),
			('LEADER_STATESMAN', 	'FLAVOR_NAVAL_GROWTH', 				6),
			('LEADER_STATESMAN', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	6),
			('LEADER_STATESMAN', 	'FLAVOR_AIR', 						7),
			('LEADER_STATESMAN', 	'FLAVOR_EXPANSION', 				3),
			('LEADER_STATESMAN', 	'FLAVOR_GROWTH', 					9),
			('LEADER_STATESMAN', 	'FLAVOR_TILE_IMPROVEMENT', 			7),
			('LEADER_STATESMAN', 	'FLAVOR_INFRASTRUCTURE', 			3),
			('LEADER_STATESMAN', 	'FLAVOR_PRODUCTION', 				3),
			('LEADER_STATESMAN', 	'FLAVOR_GOLD', 						7),
			('LEADER_STATESMAN', 	'FLAVOR_SCIENCE', 					7),
			('LEADER_STATESMAN', 	'FLAVOR_CULTURE', 					5),
			('LEADER_STATESMAN', 	'FLAVOR_HAPPINESS', 				6),
			('LEADER_STATESMAN', 	'FLAVOR_GREAT_PEOPLE', 				6),
			('LEADER_STATESMAN', 	'FLAVOR_WONDER', 					6),
			('LEADER_STATESMAN', 	'FLAVOR_RELIGION', 					3),
			('LEADER_STATESMAN', 	'FLAVOR_DIPLOMACY', 				6),
			('LEADER_STATESMAN', 	'FLAVOR_SPACESHIP', 				8),
			('LEADER_STATESMAN', 	'FLAVOR_WATER_CONNECTION', 			6),
			('LEADER_STATESMAN', 	'FLAVOR_NUKE', 						5),
			('LEADER_STATESMAN', 	'FLAVOR_USE_NUKE', 					2),
			('LEADER_STATESMAN', 	'FLAVOR_ESPIONAGE', 				5),
			('LEADER_STATESMAN', 	'FLAVOR_ANTIAIR',	 				7),
			('LEADER_STATESMAN', 	'FLAVOR_AIR_CARRIER', 				4),
			('LEADER_STATESMAN', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_STATESMAN', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_STATESMAN', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_STATESMAN', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_STATESMAN', 	'FLAVOR_ARCHAEOLOGY', 				5),
			('LEADER_STATESMAN', 	'FLAVOR_AIRLIFT', 					5);


--*******************************************************************
-- Trait Definition (Birthplace of Tomorrow)
--*******************************************************************
INSERT INTO Traits
			(Type,												Description,												ShortDescription,								  
			SciencePerMoreAdvancedEnemyUnit,	FreeBuilding)
VALUES		('TRAIT_FREE_WALLS_SCIENCE_FROM_ADVANCED_OPPONENT',	'TXT_KEY_TRAIT_FREE_WALLS_SCIENCE_FROM_ADVANCED_OPPONENT', 'TXT_KEY_TRAIT_FREE_WALLS_SCIENCE_FROM_ADVANCED_OPPONENT_SHORT', 
			3,									'BUILDING_WALLS');

			
--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 		TraitType)
VALUES		('LEADER_STATESMAN', 	'TRAIT_FREE_WALLS_SCIENCE_FROM_ADVANCED_OPPONENT');



INSERT INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_STATESMAN'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_STATESMAN_'),	1
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC';

INSERT INTO Diplomacy_Responses		
			(LeaderType, 		ResponseType, 					Response, 													Bias)
VALUES		('LEADER_STATESMAN', 	'RESPONSE_DEFEATED', 			'TXT_KEY_LEADER_STATESMAN_DEFEATED%', 							1),	
			('LEADER_STATESMAN', 	'RESPONSE_FIRST_GREETING', 		'TXT_KEY_LEADER_STATESMAN_FIRSTGREETING%', 					1);