--All SQL Leader inserts were based off of SQL code from JFD's Civilizations.

--*******************************************************************
-- Madoka Kaname
--*******************************************************************

INSERT INTO Leaders 
			(Type, 						Description, 						Civilopedia, 								CivilopediaTag, 								ArtDefineTag,				VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 							PortraitIndex)
VALUES		('LEADER_ORIGINAL_MADOKA', 	'TXT_KEY_LEADER_ORIGINAL_MADOKA', 	'TXT_KEY_LEADER_ORIGINAL_MADOKA_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_ORIGINAL_MADOKA', 	'OriginalMadokaScene.xml', 4, 						7, 						7, 							4, 			7, 				9, 				5, 						10, 			9, 			8, 			8, 				8, 			1, 			'CIV_COLOR_ATLAS_ORIGINAL_MADOKA', 	1);


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 			MajorCivApproachType, 				Bias)
VALUES		('LEADER_ORIGINAL_MADOKA', 	'MAJOR_CIV_APPROACH_WAR', 			3),
			('LEADER_ORIGINAL_MADOKA', 	'MAJOR_CIV_APPROACH_HOSTILE', 		3),
			('LEADER_ORIGINAL_MADOKA', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	1),
			('LEADER_ORIGINAL_MADOKA', 	'MAJOR_CIV_APPROACH_GUARDED', 		5),
			('LEADER_ORIGINAL_MADOKA', 	'MAJOR_CIV_APPROACH_AFRAID', 		5),
			('LEADER_ORIGINAL_MADOKA', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		9),
			('LEADER_ORIGINAL_MADOKA', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		4);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 			MinorCivApproachType, 				Bias)
VALUES		('LEADER_ORIGINAL_MADOKA', 	'MINOR_CIV_APPROACH_IGNORE', 		2),
			('LEADER_ORIGINAL_MADOKA', 	'MINOR_CIV_APPROACH_FRIENDLY', 		8),
			('LEADER_ORIGINAL_MADOKA', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	7),
			('LEADER_ORIGINAL_MADOKA', 	'MINOR_CIV_APPROACH_CONQUEST', 		1),
			('LEADER_ORIGINAL_MADOKA', 	'MINOR_CIV_APPROACH_BULLY', 		2);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 			FlavorType, 						Flavor)
VALUES		('LEADER_ORIGINAL_MADOKA', 	'FLAVOR_OFFENSE', 					4),
			('LEADER_ORIGINAL_MADOKA', 	'FLAVOR_DEFENSE', 					6),
			('LEADER_ORIGINAL_MADOKA', 	'FLAVOR_CITY_DEFENSE', 				5),
			('LEADER_ORIGINAL_MADOKA', 	'FLAVOR_MILITARY_TRAINING', 		4),
			('LEADER_ORIGINAL_MADOKA', 	'FLAVOR_RECON', 					5),
			('LEADER_ORIGINAL_MADOKA', 	'FLAVOR_RANGED', 					8),
			('LEADER_ORIGINAL_MADOKA', 	'FLAVOR_MOBILE', 					4),
			('LEADER_ORIGINAL_MADOKA', 	'FLAVOR_NAVAL', 					5),
			('LEADER_ORIGINAL_MADOKA', 	'FLAVOR_NAVAL_RECON', 				5),
			('LEADER_ORIGINAL_MADOKA', 	'FLAVOR_NAVAL_GROWTH', 				4),
			('LEADER_ORIGINAL_MADOKA', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
			('LEADER_ORIGINAL_MADOKA', 	'FLAVOR_AIR', 						5),
			('LEADER_ORIGINAL_MADOKA', 	'FLAVOR_EXPANSION', 				4),
			('LEADER_ORIGINAL_MADOKA', 	'FLAVOR_GROWTH', 					7),
			('LEADER_ORIGINAL_MADOKA', 	'FLAVOR_TILE_IMPROVEMENT', 			6),
			('LEADER_ORIGINAL_MADOKA', 	'FLAVOR_INFRASTRUCTURE', 			5),
			('LEADER_ORIGINAL_MADOKA', 	'FLAVOR_PRODUCTION', 				6),
			('LEADER_ORIGINAL_MADOKA', 	'FLAVOR_GOLD', 						4),
			('LEADER_ORIGINAL_MADOKA', 	'FLAVOR_SCIENCE', 					6),
			('LEADER_ORIGINAL_MADOKA', 	'FLAVOR_CULTURE', 					7),
			('LEADER_ORIGINAL_MADOKA', 	'FLAVOR_HAPPINESS', 				7),
			('LEADER_ORIGINAL_MADOKA', 	'FLAVOR_GREAT_PEOPLE', 				5),
			('LEADER_ORIGINAL_MADOKA', 	'FLAVOR_WONDER', 					5),
			('LEADER_ORIGINAL_MADOKA', 	'FLAVOR_RELIGION', 					4),
			('LEADER_ORIGINAL_MADOKA', 	'FLAVOR_DIPLOMACY', 				8),
			('LEADER_ORIGINAL_MADOKA', 	'FLAVOR_SPACESHIP', 				5),
			('LEADER_ORIGINAL_MADOKA', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_ORIGINAL_MADOKA', 	'FLAVOR_NUKE', 						2),
			('LEADER_ORIGINAL_MADOKA', 	'FLAVOR_USE_NUKE', 					2),
			('LEADER_ORIGINAL_MADOKA', 	'FLAVOR_ESPIONAGE', 				5),
			('LEADER_ORIGINAL_MADOKA', 	'FLAVOR_ANTIAIR',	 				7),
			('LEADER_ORIGINAL_MADOKA', 	'FLAVOR_AIR_CARRIER', 				5),
			('LEADER_ORIGINAL_MADOKA', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_ORIGINAL_MADOKA', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_ORIGINAL_MADOKA', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_ORIGINAL_MADOKA', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_ORIGINAL_MADOKA', 	'FLAVOR_ARCHAEOLOGY', 				5),
			('LEADER_ORIGINAL_MADOKA', 	'FLAVOR_AIRLIFT', 					5);


--*******************************************************************
-- Trait Definition (Arrow of Hope)
--*******************************************************************
INSERT INTO Traits
			(Type,										 Description,										 ShortDescription,										   MGMoodBonus)
VALUES		('TRAIT_FREE_ARCHERY_BONUS_GARRISON_ATTACK', 'TXT_KEY_TRAIT_FREE_ARCHERY_BONUS_GARRISON_ATTACK', 'TXT_KEY_TRAIT_FREE_ARCHERY_BONUS_GARRISON_ATTACK_SHORT', 100);

INSERT INTO Trait_MoodModChanges
			(TraitType,										MoodModType,					Modifier)
VALUES		('TRAIT_FREE_ARCHERY_BONUS_GARRISON_ATTACK',	'MGMOODMOD_FOUGHT_NEAR_LEADER',	100);


--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 			TraitType)
VALUES		('LEADER_ORIGINAL_MADOKA', 	'TRAIT_FREE_ARCHERY_BONUS_GARRISON_ATTACK');
