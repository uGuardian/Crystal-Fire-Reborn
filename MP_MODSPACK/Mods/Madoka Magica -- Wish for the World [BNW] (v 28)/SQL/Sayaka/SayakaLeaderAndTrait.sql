--All SQL Leader inserts were based off of SQL code from JFD's Civilizations.

--*******************************************************************
-- Sayaka Miki
--*******************************************************************

INSERT INTO Leaders 
			(Type, 				Description, 				Civilopedia, 					CivilopediaTag, 						ArtDefineTag,		VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 							PortraitIndex)
VALUES		('LEADER_SAYAKA', 	'TXT_KEY_LEADER_SAYAKA', 	'TXT_KEY_LEADER_SAYAKA_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_SAYAKA', 	'SayakaScene.xml',	8, 						6, 						2, 							6, 			5, 				7, 				8, 						8, 				8,			6, 			2, 				7, 			7, 			'CIV_COLOR_ATLAS_SAYAKA', 	1);


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 		MajorCivApproachType, 				Bias)
VALUES		('LEADER_SAYAKA', 	'MAJOR_CIV_APPROACH_WAR', 			7),
			('LEADER_SAYAKA', 	'MAJOR_CIV_APPROACH_HOSTILE', 		7),
			('LEADER_SAYAKA', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	2),
			('LEADER_SAYAKA', 	'MAJOR_CIV_APPROACH_GUARDED', 		3),
			('LEADER_SAYAKA', 	'MAJOR_CIV_APPROACH_AFRAID', 		3),
			('LEADER_SAYAKA', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		8),
			('LEADER_SAYAKA', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		2);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 		MinorCivApproachType, 				Bias)
VALUES		('LEADER_SAYAKA', 	'MINOR_CIV_APPROACH_IGNORE', 		4),
			('LEADER_SAYAKA', 	'MINOR_CIV_APPROACH_FRIENDLY', 		4),
			('LEADER_SAYAKA', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	4),
			('LEADER_SAYAKA', 	'MINOR_CIV_APPROACH_CONQUEST', 		5),
			('LEADER_SAYAKA', 	'MINOR_CIV_APPROACH_BULLY', 		8);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 		FlavorType, 						Flavor)
VALUES		('LEADER_SAYAKA', 	'FLAVOR_OFFENSE', 					7),
			('LEADER_SAYAKA', 	'FLAVOR_DEFENSE', 					5),
			('LEADER_SAYAKA', 	'FLAVOR_CITY_DEFENSE', 				3),
			('LEADER_SAYAKA', 	'FLAVOR_MILITARY_TRAINING', 		6),
			('LEADER_SAYAKA', 	'FLAVOR_RECON', 					7),
			('LEADER_SAYAKA', 	'FLAVOR_RANGED', 					4),
			('LEADER_SAYAKA', 	'FLAVOR_MOBILE', 					5),
			('LEADER_SAYAKA', 	'FLAVOR_NAVAL', 					3),
			('LEADER_SAYAKA', 	'FLAVOR_NAVAL_RECON', 				4),
			('LEADER_SAYAKA', 	'FLAVOR_NAVAL_GROWTH', 				3),
			('LEADER_SAYAKA', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	4),
			('LEADER_SAYAKA', 	'FLAVOR_AIR', 						4),
			('LEADER_SAYAKA', 	'FLAVOR_EXPANSION', 				6),
			('LEADER_SAYAKA', 	'FLAVOR_GROWTH', 					6),
			('LEADER_SAYAKA', 	'FLAVOR_TILE_IMPROVEMENT', 			4),
			('LEADER_SAYAKA', 	'FLAVOR_INFRASTRUCTURE', 			6),
			('LEADER_SAYAKA', 	'FLAVOR_PRODUCTION', 				5),
			('LEADER_SAYAKA', 	'FLAVOR_GOLD', 						2),
			('LEADER_SAYAKA', 	'FLAVOR_SCIENCE', 					4),
			('LEADER_SAYAKA', 	'FLAVOR_CULTURE', 					9),
			('LEADER_SAYAKA', 	'FLAVOR_HAPPINESS', 				7),
			('LEADER_SAYAKA', 	'FLAVOR_GREAT_PEOPLE', 				6),
			('LEADER_SAYAKA', 	'FLAVOR_WONDER', 					7),
			('LEADER_SAYAKA', 	'FLAVOR_RELIGION', 					4),
			('LEADER_SAYAKA', 	'FLAVOR_DIPLOMACY', 				2),
			('LEADER_SAYAKA', 	'FLAVOR_SPACESHIP', 				2),
			('LEADER_SAYAKA', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_SAYAKA', 	'FLAVOR_NUKE', 						4),
			('LEADER_SAYAKA', 	'FLAVOR_USE_NUKE', 					4),
			('LEADER_SAYAKA', 	'FLAVOR_ESPIONAGE', 				3),
			('LEADER_SAYAKA', 	'FLAVOR_ANTIAIR',	 				7),
			('LEADER_SAYAKA', 	'FLAVOR_AIR_CARRIER', 				4),
			('LEADER_SAYAKA', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_SAYAKA', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_SAYAKA', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_SAYAKA', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_SAYAKA', 	'FLAVOR_ARCHAEOLOGY', 				5),
			('LEADER_SAYAKA', 	'FLAVOR_AIRLIFT', 					5);


--*******************************************************************
-- Trait Definition (Orchestra For Justice)
--*******************************************************************
INSERT INTO Traits
			(Type,							 Description,							ShortDescription,							GreatPersonProgressFromKills,	CombatBonusFromTourismInfluence)
VALUES		('TRAIT_TOURISM_HEALING_BONUS', 'TXT_KEY_TRAIT_TOURISM_HEALING_BONUS', 'TXT_KEY_TRAIT_TOURISM_HEALING_BONUS_SHORT', 'SPECIALIST_MUSICIAN',			1);


--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 			TraitType)
VALUES		('LEADER_SAYAKA', 	'TRAIT_TOURISM_HEALING_BONUS');




