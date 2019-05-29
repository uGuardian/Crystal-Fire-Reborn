--All SQL Leader inserts were based off of SQL code from JFD's Civilizations.

--*******************************************************************
-- Pierce Washington
--*******************************************************************

INSERT INTO Leaders 
			(Type, 							Description, 							Civilopedia, 								CivilopediaTag, 									ArtDefineTag,			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 								PortraitIndex)
VALUES		('LEADER_PIERCE_WASHINGTON', 	'TXT_KEY_LEADER_PIERCE_WASHINGTON', 	'TXT_KEY_LEADER_PIERCE_WASHINGTON_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_PIERCE_WASHINGTON', 	'SRTTPierceScene.xml',	8, 						6, 						2, 							8, 			3, 				1, 				6, 						5, 				8, 			5, 			2, 				8, 			8, 			'CIV_COLOR_ATLAS_THIRD_STREET_SAINTS', 	1);


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 					MajorCivApproachType, 				Bias)
VALUES		('LEADER_PIERCE_WASHINGTON', 	'MAJOR_CIV_APPROACH_WAR', 			8),
			('LEADER_PIERCE_WASHINGTON', 	'MAJOR_CIV_APPROACH_HOSTILE', 		7),
			('LEADER_PIERCE_WASHINGTON', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	5),
			('LEADER_PIERCE_WASHINGTON', 	'MAJOR_CIV_APPROACH_GUARDED', 		6),
			('LEADER_PIERCE_WASHINGTON', 	'MAJOR_CIV_APPROACH_AFRAID', 		3),
			('LEADER_PIERCE_WASHINGTON', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		6),
			('LEADER_PIERCE_WASHINGTON', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		5);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 					MinorCivApproachType, 				Bias)
VALUES		('LEADER_PIERCE_WASHINGTON', 	'MINOR_CIV_APPROACH_IGNORE', 		4),
			('LEADER_PIERCE_WASHINGTON', 	'MINOR_CIV_APPROACH_FRIENDLY', 		4),
			('LEADER_PIERCE_WASHINGTON', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	4),
			('LEADER_PIERCE_WASHINGTON', 	'MINOR_CIV_APPROACH_CONQUEST', 		5),
			('LEADER_PIERCE_WASHINGTON', 	'MINOR_CIV_APPROACH_BULLY', 		8);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 					FlavorType, 						Flavor)
VALUES		('LEADER_PIERCE_WASHINGTON', 	'FLAVOR_OFFENSE', 					8),
			('LEADER_PIERCE_WASHINGTON', 	'FLAVOR_DEFENSE', 					3),
			('LEADER_PIERCE_WASHINGTON', 	'FLAVOR_CITY_DEFENSE', 				4),
			('LEADER_PIERCE_WASHINGTON', 	'FLAVOR_MILITARY_TRAINING', 		8),
			('LEADER_PIERCE_WASHINGTON', 	'FLAVOR_RECON', 					6),
			('LEADER_PIERCE_WASHINGTON', 	'FLAVOR_RANGED', 					5),
			('LEADER_PIERCE_WASHINGTON', 	'FLAVOR_MOBILE', 					9),
			('LEADER_PIERCE_WASHINGTON', 	'FLAVOR_NAVAL', 					6),
			('LEADER_PIERCE_WASHINGTON', 	'FLAVOR_NAVAL_RECON', 				5),
			('LEADER_PIERCE_WASHINGTON', 	'FLAVOR_NAVAL_GROWTH', 				4),
			('LEADER_PIERCE_WASHINGTON', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
			('LEADER_PIERCE_WASHINGTON', 	'FLAVOR_AIR', 						6),
			('LEADER_PIERCE_WASHINGTON', 	'FLAVOR_EXPANSION', 				7),
			('LEADER_PIERCE_WASHINGTON', 	'FLAVOR_GROWTH', 					4),
			('LEADER_PIERCE_WASHINGTON', 	'FLAVOR_TILE_IMPROVEMENT', 			4),
			('LEADER_PIERCE_WASHINGTON', 	'FLAVOR_INFRASTRUCTURE', 			6),
			('LEADER_PIERCE_WASHINGTON', 	'FLAVOR_PRODUCTION', 				7),
			('LEADER_PIERCE_WASHINGTON', 	'FLAVOR_GOLD', 						7),
			('LEADER_PIERCE_WASHINGTON', 	'FLAVOR_SCIENCE', 					5),
			('LEADER_PIERCE_WASHINGTON', 	'FLAVOR_CULTURE', 					5),
			('LEADER_PIERCE_WASHINGTON', 	'FLAVOR_HAPPINESS', 				4),
			('LEADER_PIERCE_WASHINGTON', 	'FLAVOR_GREAT_PEOPLE', 				3),
			('LEADER_PIERCE_WASHINGTON', 	'FLAVOR_WONDER', 					5),
			('LEADER_PIERCE_WASHINGTON', 	'FLAVOR_RELIGION', 					2),
			('LEADER_PIERCE_WASHINGTON', 	'FLAVOR_DIPLOMACY', 				2),
			('LEADER_PIERCE_WASHINGTON', 	'FLAVOR_SPACESHIP', 				7),
			('LEADER_PIERCE_WASHINGTON', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_PIERCE_WASHINGTON', 	'FLAVOR_NUKE', 						8),
			('LEADER_PIERCE_WASHINGTON', 	'FLAVOR_USE_NUKE', 					8),
			('LEADER_PIERCE_WASHINGTON', 	'FLAVOR_ESPIONAGE', 				6),
			('LEADER_PIERCE_WASHINGTON', 	'FLAVOR_ANTIAIR',	 				6),
			('LEADER_PIERCE_WASHINGTON', 	'FLAVOR_AIR_CARRIER', 				5),
			('LEADER_PIERCE_WASHINGTON', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_PIERCE_WASHINGTON', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_PIERCE_WASHINGTON', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_PIERCE_WASHINGTON', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_PIERCE_WASHINGTON', 	'FLAVOR_ARCHAEOLOGY', 				5),
			('LEADER_PIERCE_WASHINGTON', 	'FLAVOR_AIRLIFT', 					5);


--*******************************************************************
-- Trait Definition (Riders on the Row)
--*******************************************************************
INSERT INTO Traits
			(Type,							Description,							ShortDescription,							EnableRespectSystem)
VALUES		('TRAIT_SRTT_RESPECT_SYSTEM',	'TXT_KEY_TRAIT_SRTT_RESPECT_SYSTEM',	'TXT_KEY_TRAIT_SRTT_RESPECT_SYSTEM_SHORT',	1);

--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 					TraitType)
VALUES		('LEADER_PIERCE_WASHINGTON', 	'TRAIT_SRTT_RESPECT_SYSTEM');





