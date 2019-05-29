--All SQL Leader inserts were based off of SQL code from JFD's Civilizations.

--*******************************************************************
-- MIKU Tomoe
--*******************************************************************

INSERT INTO Leaders 
			(Type, 			Description, 			Civilopedia, 					CivilopediaTag, 					ArtDefineTag,		
			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 
			Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 				PortraitIndex)
VALUES		('LEADER_NANOHA', 'TXT_KEY_LEADER_NANOHA', 	'TXT_KEY_LEADER_NANOHA_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_NANOHA', 'AdultNanohaScene.xml',
			4,						5, 						4, 							5, 			8, 				7, 				5, 						9, 			8, 
			6, 			10, 		7, 			5, 			'CIV_COLOR_ATLAS_TSAB_ADULT', 0);


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 		MajorCivApproachType, 				Bias)
VALUES		('LEADER_NANOHA', 	'MAJOR_CIV_APPROACH_WAR', 			4),
			('LEADER_NANOHA', 	'MAJOR_CIV_APPROACH_HOSTILE', 		3),
			('LEADER_NANOHA', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	2),
			('LEADER_NANOHA', 	'MAJOR_CIV_APPROACH_GUARDED', 		7),
			('LEADER_NANOHA', 	'MAJOR_CIV_APPROACH_AFRAID', 		3),
			('LEADER_NANOHA', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		9),
			('LEADER_NANOHA', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		6);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 		MinorCivApproachType, 				Bias)
VALUES		('LEADER_NANOHA', 	'MINOR_CIV_APPROACH_IGNORE', 		4),
			('LEADER_NANOHA', 	'MINOR_CIV_APPROACH_FRIENDLY', 		8),
			('LEADER_NANOHA', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	7),
			('LEADER_NANOHA', 	'MINOR_CIV_APPROACH_CONQUEST', 		2),
			('LEADER_NANOHA', 	'MINOR_CIV_APPROACH_BULLY', 		3);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 		FlavorType, 						Flavor)
VALUES		('LEADER_NANOHA', 	'FLAVOR_OFFENSE', 					3),
			('LEADER_NANOHA', 	'FLAVOR_DEFENSE', 					7),
			('LEADER_NANOHA', 	'FLAVOR_CITY_DEFENSE', 				7),
			('LEADER_NANOHA', 	'FLAVOR_MILITARY_TRAINING', 		7),
			('LEADER_NANOHA', 	'FLAVOR_RECON', 					5),
			('LEADER_NANOHA', 	'FLAVOR_RANGED', 					7),
			('LEADER_NANOHA', 	'FLAVOR_MOBILE', 					4),
			('LEADER_NANOHA', 	'FLAVOR_NAVAL', 					6),
			('LEADER_NANOHA', 	'FLAVOR_NAVAL_RECON', 				5),
			('LEADER_NANOHA', 	'FLAVOR_NAVAL_GROWTH', 				5),
			('LEADER_NANOHA', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
			('LEADER_NANOHA', 	'FLAVOR_AIR', 						8),
			('LEADER_NANOHA', 	'FLAVOR_EXPANSION', 				4),
			('LEADER_NANOHA', 	'FLAVOR_GROWTH', 					7),
			('LEADER_NANOHA', 	'FLAVOR_TILE_IMPROVEMENT', 			7),
			('LEADER_NANOHA', 	'FLAVOR_INFRASTRUCTURE', 			6),
			('LEADER_NANOHA', 	'FLAVOR_PRODUCTION', 				6),
			('LEADER_NANOHA', 	'FLAVOR_GOLD', 						4),
			('LEADER_NANOHA', 	'FLAVOR_SCIENCE', 					8),
			('LEADER_NANOHA', 	'FLAVOR_CULTURE', 					3),
			('LEADER_NANOHA', 	'FLAVOR_HAPPINESS', 				8),
			('LEADER_NANOHA', 	'FLAVOR_GREAT_PEOPLE', 				6),
			('LEADER_NANOHA', 	'FLAVOR_WONDER', 					5),
			('LEADER_NANOHA', 	'FLAVOR_RELIGION', 					3),
			('LEADER_NANOHA', 	'FLAVOR_DIPLOMACY', 				5),
			('LEADER_NANOHA', 	'FLAVOR_SPACESHIP', 				9),
			('LEADER_NANOHA', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_NANOHA', 	'FLAVOR_NUKE', 						8),
			('LEADER_NANOHA', 	'FLAVOR_USE_NUKE', 					2),
			('LEADER_NANOHA', 	'FLAVOR_ESPIONAGE', 				6),
			('LEADER_NANOHA', 	'FLAVOR_ANTIAIR',	 				7),
			('LEADER_NANOHA', 	'FLAVOR_AIR_CARRIER', 				5),
			('LEADER_NANOHA', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_NANOHA', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_NANOHA', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_NANOHA', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_NANOHA', 	'FLAVOR_ARCHAEOLOGY', 				9),
			('LEADER_NANOHA', 	'FLAVOR_AIRLIFT', 					6);


--*******************************************************************
-- Trait Definition (Not Afraid of Anything Anymore)
--*******************************************************************
INSERT INTO Traits
			(Type,									Description,								 ShortDescription,						DOFOnPeaceTreaty,	SiegeUnitsDefenseBonus)
VALUES		('TRAIT_DEFEAT_MEANS_FRIENDSHIP',	'TXT_KEY_TRAIT_DEFEAT_MEANS_FRIENDSHIP', 'TXT_KEY_TRAIT_DEFEAT_MEANS_FRIENDSHIP_SHORT',	1,					1);

INSERT INTO Trait_FreePromotionUnitCombats
			(TraitType,							UnitCombatType,		PromotionType)
VALUES		('TRAIT_DEFEAT_MEANS_FRIENDSHIP',	'UNITCOMBAT_SIEGE',	'PROMOTION_ACE_OF_ACES');


--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 			TraitType)
VALUES		('LEADER_NANOHA', 	'TRAIT_DEFEAT_MEANS_FRIENDSHIP');





