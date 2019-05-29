--All SQL Leader inserts were based off of SQL code from JFD's Civilizations.

--*******************************************************************
-- Ultimate Madoka
--*******************************************************************

INSERT INTO Leaders 
			(Type, 				Description, 				Civilopedia, 					CivilopediaTag, 						ArtDefineTag,		VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 							PortraitIndex)
VALUES		('LEADER_MADOKA', 	'TXT_KEY_LEADER_MADOKA', 	'TXT_KEY_LEADER_MADOKA_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_MADOKA', 	'MadokaScene.xml',	4, 						7, 						7, 							2, 			8, 				10, 			5, 						9, 				10, 		8, 			9, 				7, 			1, 			'CIV_COLOR_ATLAS_MADOKA', 	1);


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 		MajorCivApproachType, 				Bias)
VALUES		('LEADER_MADOKA', 	'MAJOR_CIV_APPROACH_WAR', 			2),
			('LEADER_MADOKA', 	'MAJOR_CIV_APPROACH_HOSTILE', 		2),
			('LEADER_MADOKA', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	1),
			('LEADER_MADOKA', 	'MAJOR_CIV_APPROACH_GUARDED', 		5),
			('LEADER_MADOKA', 	'MAJOR_CIV_APPROACH_AFRAID', 		5),
			('LEADER_MADOKA', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		9),
			('LEADER_MADOKA', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		4);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 		MinorCivApproachType, 				Bias)
VALUES		('LEADER_MADOKA', 	'MINOR_CIV_APPROACH_IGNORE', 		2),
			('LEADER_MADOKA', 	'MINOR_CIV_APPROACH_FRIENDLY', 		8),
			('LEADER_MADOKA', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	7),
			('LEADER_MADOKA', 	'MINOR_CIV_APPROACH_CONQUEST', 		1),
			('LEADER_MADOKA', 	'MINOR_CIV_APPROACH_BULLY', 		2);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 		FlavorType, 						Flavor)
VALUES		('LEADER_MADOKA', 	'FLAVOR_OFFENSE', 					2),
			('LEADER_MADOKA', 	'FLAVOR_DEFENSE', 					5),
			('LEADER_MADOKA', 	'FLAVOR_CITY_DEFENSE', 				7),
			('LEADER_MADOKA', 	'FLAVOR_MILITARY_TRAINING', 		2),
			('LEADER_MADOKA', 	'FLAVOR_RECON', 					6),
			('LEADER_MADOKA', 	'FLAVOR_RANGED', 					8),
			('LEADER_MADOKA', 	'FLAVOR_MOBILE', 					4),
			('LEADER_MADOKA', 	'FLAVOR_NAVAL', 					4),
			('LEADER_MADOKA', 	'FLAVOR_NAVAL_RECON', 				5),
			('LEADER_MADOKA', 	'FLAVOR_NAVAL_GROWTH', 				4),
			('LEADER_MADOKA', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
			('LEADER_MADOKA', 	'FLAVOR_AIR', 						6),
			('LEADER_MADOKA', 	'FLAVOR_EXPANSION', 				2),
			('LEADER_MADOKA', 	'FLAVOR_GROWTH', 					9),
			('LEADER_MADOKA', 	'FLAVOR_TILE_IMPROVEMENT', 			8),
			('LEADER_MADOKA', 	'FLAVOR_INFRASTRUCTURE', 			4),
			('LEADER_MADOKA', 	'FLAVOR_PRODUCTION', 				7),
			('LEADER_MADOKA', 	'FLAVOR_GOLD', 						2),
			('LEADER_MADOKA', 	'FLAVOR_SCIENCE', 					7),
			('LEADER_MADOKA', 	'FLAVOR_CULTURE', 					7),
			('LEADER_MADOKA', 	'FLAVOR_HAPPINESS', 				7),
			('LEADER_MADOKA', 	'FLAVOR_GREAT_PEOPLE', 				10),
			('LEADER_MADOKA', 	'FLAVOR_WONDER', 					8),
			('LEADER_MADOKA', 	'FLAVOR_RELIGION', 					6),
			('LEADER_MADOKA', 	'FLAVOR_DIPLOMACY', 				7),
			('LEADER_MADOKA', 	'FLAVOR_SPACESHIP', 				5),
			('LEADER_MADOKA', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_MADOKA', 	'FLAVOR_NUKE', 						2),
			('LEADER_MADOKA', 	'FLAVOR_USE_NUKE', 					2),
			('LEADER_MADOKA', 	'FLAVOR_ESPIONAGE', 				4),
			('LEADER_MADOKA', 	'FLAVOR_ANTIAIR',	 				6),
			('LEADER_MADOKA', 	'FLAVOR_AIR_CARRIER', 				5),
			('LEADER_MADOKA', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_MADOKA', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_MADOKA', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_MADOKA', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_MADOKA', 	'FLAVOR_ARCHAEOLOGY', 				5),
			('LEADER_MADOKA', 	'FLAVOR_AIRLIFT', 					5);
			


--*******************************************************************
-- Trait Definition (Law of Cycles)
--*******************************************************************
INSERT INTO Traits
			(Type,				 Description,				 ShortDescription,				   NoWitches,	CanSummonWitches)
VALUES		('TRAIT_NO_WITCHES', 'TXT_KEY_TRAIT_NO_WITCHES', 'TXT_KEY_TRAIT_NO_WITCHES_SHORT', 1,			1);


--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 			TraitType)
VALUES		('LEADER_MADOKA', 	'TRAIT_NO_WITCHES');


