--All SQL Leader inserts were based off of SQL code from JFD's Civilizations.

--*******************************************************************
-- Steven Armstrong
--*******************************************************************

INSERT INTO Leaders 
			(Type, 							Description, 							Civilopedia, 								CivilopediaTag, 									ArtDefineTag,			
			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness,
			Chattiness, Meanness, 	IconAtlas, 					PortraitIndex)
VALUES		('LEADER_SENATOR_ARMSTRONG', 	'TXT_KEY_LEADER_SENATOR_ARMSTRONG', 	'TXT_KEY_LEADER_SENATOR_ARMSTRONG_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_SENATOR_ARMSTRONG', 	'SenArmstrongScene.xml',
			8, 						3, 						5, 							8, 			3, 				1, 				5, 						5, 				5, 			4, 			3,
			6, 			7, 			'CIV_COLOR_ATLAS_WORLD_MARSHAL', 	1);


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 		MajorCivApproachType, 				Bias)
VALUES		('LEADER_SENATOR_ARMSTRONG', 	'MAJOR_CIV_APPROACH_WAR', 			7),
			('LEADER_SENATOR_ARMSTRONG', 	'MAJOR_CIV_APPROACH_HOSTILE', 		7),
			('LEADER_SENATOR_ARMSTRONG', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	4),
			('LEADER_SENATOR_ARMSTRONG', 	'MAJOR_CIV_APPROACH_GUARDED', 		5),
			('LEADER_SENATOR_ARMSTRONG', 	'MAJOR_CIV_APPROACH_AFRAID', 		2),
			('LEADER_SENATOR_ARMSTRONG', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		6),
			('LEADER_SENATOR_ARMSTRONG', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		5);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 		MinorCivApproachType, 				Bias)
VALUES		('LEADER_SENATOR_ARMSTRONG', 	'MINOR_CIV_APPROACH_IGNORE', 		2),
			('LEADER_SENATOR_ARMSTRONG', 	'MINOR_CIV_APPROACH_FRIENDLY', 		7),
			('LEADER_SENATOR_ARMSTRONG', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	8),
			('LEADER_SENATOR_ARMSTRONG', 	'MINOR_CIV_APPROACH_CONQUEST', 		8),
			('LEADER_SENATOR_ARMSTRONG', 	'MINOR_CIV_APPROACH_BULLY', 		3);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 		FlavorType, 						Flavor)
VALUES		('LEADER_SENATOR_ARMSTRONG', 	'FLAVOR_OFFENSE', 					8),
			('LEADER_SENATOR_ARMSTRONG', 	'FLAVOR_DEFENSE', 					5),
			('LEADER_SENATOR_ARMSTRONG', 	'FLAVOR_CITY_DEFENSE', 				4),
			('LEADER_SENATOR_ARMSTRONG', 	'FLAVOR_MILITARY_TRAINING', 		6),
			('LEADER_SENATOR_ARMSTRONG', 	'FLAVOR_RECON', 					4),
			('LEADER_SENATOR_ARMSTRONG', 	'FLAVOR_RANGED', 					4),
			('LEADER_SENATOR_ARMSTRONG', 	'FLAVOR_MOBILE', 					6),
			('LEADER_SENATOR_ARMSTRONG', 	'FLAVOR_NAVAL', 					5),
			('LEADER_SENATOR_ARMSTRONG', 	'FLAVOR_NAVAL_RECON', 				5),
			('LEADER_SENATOR_ARMSTRONG', 	'FLAVOR_NAVAL_GROWTH', 				4),
			('LEADER_SENATOR_ARMSTRONG', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	6),
			('LEADER_SENATOR_ARMSTRONG', 	'FLAVOR_AIR', 						6),
			('LEADER_SENATOR_ARMSTRONG', 	'FLAVOR_EXPANSION', 				7),
			('LEADER_SENATOR_ARMSTRONG', 	'FLAVOR_GROWTH', 					5),
			('LEADER_SENATOR_ARMSTRONG', 	'FLAVOR_TILE_IMPROVEMENT', 			4),
			('LEADER_SENATOR_ARMSTRONG', 	'FLAVOR_INFRASTRUCTURE', 			4),
			('LEADER_SENATOR_ARMSTRONG', 	'FLAVOR_PRODUCTION', 				6),
			('LEADER_SENATOR_ARMSTRONG', 	'FLAVOR_GOLD', 						4),
			('LEADER_SENATOR_ARMSTRONG', 	'FLAVOR_SCIENCE', 					6),
			('LEADER_SENATOR_ARMSTRONG', 	'FLAVOR_CULTURE', 					2),
			('LEADER_SENATOR_ARMSTRONG', 	'FLAVOR_HAPPINESS', 				4),
			('LEADER_SENATOR_ARMSTRONG', 	'FLAVOR_GREAT_PEOPLE', 				4),
			('LEADER_SENATOR_ARMSTRONG', 	'FLAVOR_WONDER', 					3),
			('LEADER_SENATOR_ARMSTRONG', 	'FLAVOR_RELIGION', 					3),
			('LEADER_SENATOR_ARMSTRONG', 	'FLAVOR_DIPLOMACY', 				10),
			('LEADER_SENATOR_ARMSTRONG', 	'FLAVOR_SPACESHIP', 				6),
			('LEADER_SENATOR_ARMSTRONG', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_SENATOR_ARMSTRONG', 	'FLAVOR_NUKE', 						8),
			('LEADER_SENATOR_ARMSTRONG', 	'FLAVOR_USE_NUKE', 					8),
			('LEADER_SENATOR_ARMSTRONG', 	'FLAVOR_ESPIONAGE', 				6),
			('LEADER_SENATOR_ARMSTRONG', 	'FLAVOR_ANTIAIR',	 				6),
			('LEADER_SENATOR_ARMSTRONG', 	'FLAVOR_AIR_CARRIER', 				5),
			('LEADER_SENATOR_ARMSTRONG', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_SENATOR_ARMSTRONG', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_SENATOR_ARMSTRONG', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_SENATOR_ARMSTRONG', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_SENATOR_ARMSTRONG', 	'FLAVOR_ARCHAEOLOGY', 				4),
			('LEADER_SENATOR_ARMSTRONG', 	'FLAVOR_AIRLIFT', 					6);


--*******************************************************************
-- Trait Definition (War Off Our Shores)
--*******************************************************************
INSERT INTO Traits
			(Type,							Description,						ShortDescription,							DelegatesFromWar)
VALUES		('TRAIT_DELEGATES_FROM_WAR',	'TXT_KEY_TRAIT_DELEGATES_FROM_WAR',	'TXT_KEY_TRAIT_DELEGATES_FROM_WAR_SHORT',	1);

--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 					TraitType)
VALUES		('LEADER_SENATOR_ARMSTRONG', 	'TRAIT_DELEGATES_FROM_WAR');



--Dummy Policy

INSERT INTO Policies
			(Type,						UnitPurchaseCostModifier)
VALUES		('POLICY_ARMSTRONG_DUMMY',	15);



