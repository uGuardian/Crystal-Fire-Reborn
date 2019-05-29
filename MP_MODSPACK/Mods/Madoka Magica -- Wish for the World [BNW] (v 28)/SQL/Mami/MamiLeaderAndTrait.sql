--All SQL Leader inserts were based off of SQL code from JFD's Civilizations.

--*******************************************************************
-- Mami Tomoe
--*******************************************************************

INSERT INTO Leaders 
			(Type, 			Description, 			Civilopedia, 					CivilopediaTag, 					ArtDefineTag,		VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 				PortraitIndex)
VALUES		('LEADER_MAMI', 'TXT_KEY_LEADER_MAMI', 	'TXT_KEY_LEADER_MAMI_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_MAMI', 'MamiScene.xml',	4,						4, 						9, 							5, 			8, 				5, 				6, 						10, 			7, 			6, 			5, 				6, 			5, 			'CIV_COLOR_ATLAS_MAMI', 1);


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 		MajorCivApproachType, 				Bias)
VALUES		('LEADER_MAMI', 	'MAJOR_CIV_APPROACH_WAR', 			5),
			('LEADER_MAMI', 	'MAJOR_CIV_APPROACH_HOSTILE', 		4),
			('LEADER_MAMI', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	2),
			('LEADER_MAMI', 	'MAJOR_CIV_APPROACH_GUARDED', 		5),
			('LEADER_MAMI', 	'MAJOR_CIV_APPROACH_AFRAID', 		3),
			('LEADER_MAMI', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		8),
			('LEADER_MAMI', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		4);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 		MinorCivApproachType, 				Bias)
VALUES		('LEADER_MAMI', 	'MINOR_CIV_APPROACH_IGNORE', 		2),
			('LEADER_MAMI', 	'MINOR_CIV_APPROACH_FRIENDLY', 		8),
			('LEADER_MAMI', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	9),
			('LEADER_MAMI', 	'MINOR_CIV_APPROACH_CONQUEST', 		1),
			('LEADER_MAMI', 	'MINOR_CIV_APPROACH_BULLY', 		3);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 		FlavorType, 						Flavor)
VALUES		('LEADER_MAMI', 	'FLAVOR_OFFENSE', 					4),
			('LEADER_MAMI', 	'FLAVOR_DEFENSE', 					6),
			('LEADER_MAMI', 	'FLAVOR_CITY_DEFENSE', 				5),
			('LEADER_MAMI', 	'FLAVOR_MILITARY_TRAINING', 		4),
			('LEADER_MAMI', 	'FLAVOR_RECON', 					8),
			('LEADER_MAMI', 	'FLAVOR_RANGED', 					6),
			('LEADER_MAMI', 	'FLAVOR_MOBILE', 					7),
			('LEADER_MAMI', 	'FLAVOR_NAVAL', 					5),
			('LEADER_MAMI', 	'FLAVOR_NAVAL_RECON', 				5),
			('LEADER_MAMI', 	'FLAVOR_NAVAL_GROWTH', 				5),
			('LEADER_MAMI', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
			('LEADER_MAMI', 	'FLAVOR_AIR', 						6),
			('LEADER_MAMI', 	'FLAVOR_EXPANSION', 				8),
			('LEADER_MAMI', 	'FLAVOR_GROWTH', 					3),
			('LEADER_MAMI', 	'FLAVOR_TILE_IMPROVEMENT', 			4),
			('LEADER_MAMI', 	'FLAVOR_INFRASTRUCTURE', 			6),
			('LEADER_MAMI', 	'FLAVOR_PRODUCTION', 				4),
			('LEADER_MAMI', 	'FLAVOR_GOLD', 						7),
			('LEADER_MAMI', 	'FLAVOR_SCIENCE', 					6),
			('LEADER_MAMI', 	'FLAVOR_CULTURE', 					3),
			('LEADER_MAMI', 	'FLAVOR_HAPPINESS', 				5),
			('LEADER_MAMI', 	'FLAVOR_GREAT_PEOPLE', 				4),
			('LEADER_MAMI', 	'FLAVOR_WONDER', 					5),
			('LEADER_MAMI', 	'FLAVOR_RELIGION', 					3),
			('LEADER_MAMI', 	'FLAVOR_DIPLOMACY', 				9),
			('LEADER_MAMI', 	'FLAVOR_SPACESHIP', 				4),
			('LEADER_MAMI', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_MAMI', 	'FLAVOR_NUKE', 						2),
			('LEADER_MAMI', 	'FLAVOR_USE_NUKE', 					4),
			('LEADER_MAMI', 	'FLAVOR_ESPIONAGE', 				7),
			('LEADER_MAMI', 	'FLAVOR_ANTIAIR',	 				4),
			('LEADER_MAMI', 	'FLAVOR_AIR_CARRIER', 				5),
			('LEADER_MAMI', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_MAMI', 	'FLAVOR_I_TRADE_ORIGIN', 			8),
			('LEADER_MAMI', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_MAMI', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_MAMI', 	'FLAVOR_ARCHAEOLOGY', 				5),
			('LEADER_MAMI', 	'FLAVOR_AIRLIFT', 					5);


--*******************************************************************
-- Trait Definition (Not Afraid of Anything Anymore)
--*******************************************************************
INSERT INTO Traits
			(Type,									Description,								 ShortDescription,									MagicalGirlRelationshipModifier,	CityStateCombatStrengthModTimes100)
VALUES		('TRAIT_FRIENDSHIP_PRODUCTION_BONUS',	'TXT_KEY_TRAIT_FRIENDSHIP_PRODUCTION_BONUS', 'TXT_KEY_TRAIT_FRIENDSHIP_PRODUCTION_BONUS_SHORT',	25,									100); --Values increased until more of the trait is implemented


--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 			TraitType)
VALUES		('LEADER_MAMI', 	'TRAIT_FRIENDSHIP_PRODUCTION_BONUS');





