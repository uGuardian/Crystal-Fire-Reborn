--All SQL Leader inserts were based off of SQL code from JFD's Civilizations.

--*******************************************************************
-- Iskandar, King of Conquerors
--*******************************************************************

INSERT INTO Leaders 
			(Type, 					Description, 					Civilopedia, 						CivilopediaTag, 							ArtDefineTag,			
			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness,
			Chattiness, Meanness, 	IconAtlas, 					PortraitIndex)
VALUES		('LEADER_RIDER_FSN', 	'TXT_KEY_LEADER_RIDER_FSN', 	'TXT_KEY_LEADER_RIDER_FSN_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_RIDER_FSN', 	'RiderScene.xml',
			8, 						6, 						5, 							9, 			4, 				1, 				6, 						6, 				7, 			4, 			5,
			8, 			8, 			'CIV_COLOR_ATLAS_RIDER_FSN', 	1);


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 			MajorCivApproachType, 				Bias)
VALUES		('LEADER_RIDER_FSN', 	'MAJOR_CIV_APPROACH_WAR', 			8),
			('LEADER_RIDER_FSN', 	'MAJOR_CIV_APPROACH_HOSTILE', 		7),
			('LEADER_RIDER_FSN', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	3),
			('LEADER_RIDER_FSN', 	'MAJOR_CIV_APPROACH_GUARDED', 		5),
			('LEADER_RIDER_FSN', 	'MAJOR_CIV_APPROACH_AFRAID', 		2),
			('LEADER_RIDER_FSN', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		7),
			('LEADER_RIDER_FSN', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		4);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 		MinorCivApproachType, 				Bias)
VALUES		('LEADER_RIDER_FSN', 	'MINOR_CIV_APPROACH_IGNORE', 		4),
			('LEADER_RIDER_FSN', 	'MINOR_CIV_APPROACH_FRIENDLY', 		5),
			('LEADER_RIDER_FSN', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	6),
			('LEADER_RIDER_FSN', 	'MINOR_CIV_APPROACH_CONQUEST', 		4),
			('LEADER_RIDER_FSN', 	'MINOR_CIV_APPROACH_BULLY', 		3);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 		FlavorType, 						Flavor)
VALUES		('LEADER_RIDER_FSN', 	'FLAVOR_OFFENSE', 					8),
			('LEADER_RIDER_FSN', 	'FLAVOR_DEFENSE', 					5),
			('LEADER_RIDER_FSN', 	'FLAVOR_CITY_DEFENSE', 				4),
			('LEADER_RIDER_FSN', 	'FLAVOR_MILITARY_TRAINING', 		5),
			('LEADER_RIDER_FSN', 	'FLAVOR_RECON', 					8),
			('LEADER_RIDER_FSN', 	'FLAVOR_RANGED', 					3),
			('LEADER_RIDER_FSN', 	'FLAVOR_MOBILE', 					8),
			('LEADER_RIDER_FSN', 	'FLAVOR_NAVAL', 					5),
			('LEADER_RIDER_FSN', 	'FLAVOR_NAVAL_RECON', 				7),
			('LEADER_RIDER_FSN', 	'FLAVOR_NAVAL_GROWTH', 				6),
			('LEADER_RIDER_FSN', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	6),
			('LEADER_RIDER_FSN', 	'FLAVOR_AIR', 						3),
			('LEADER_RIDER_FSN', 	'FLAVOR_EXPANSION', 				8),
			('LEADER_RIDER_FSN', 	'FLAVOR_GROWTH', 					4),
			('LEADER_RIDER_FSN', 	'FLAVOR_TILE_IMPROVEMENT', 			4),
			('LEADER_RIDER_FSN', 	'FLAVOR_INFRASTRUCTURE', 			4),
			('LEADER_RIDER_FSN', 	'FLAVOR_PRODUCTION', 				6),
			('LEADER_RIDER_FSN', 	'FLAVOR_GOLD', 						3),
			('LEADER_RIDER_FSN', 	'FLAVOR_SCIENCE', 					6),
			('LEADER_RIDER_FSN', 	'FLAVOR_CULTURE', 					7),
			('LEADER_RIDER_FSN', 	'FLAVOR_HAPPINESS', 				5),
			('LEADER_RIDER_FSN', 	'FLAVOR_GREAT_PEOPLE', 				6),
			('LEADER_RIDER_FSN', 	'FLAVOR_WONDER', 					6),
			('LEADER_RIDER_FSN', 	'FLAVOR_RELIGION', 					5),
			('LEADER_RIDER_FSN', 	'FLAVOR_DIPLOMACY', 				4),
			('LEADER_RIDER_FSN', 	'FLAVOR_SPACESHIP', 				7),
			('LEADER_RIDER_FSN', 	'FLAVOR_WATER_CONNECTION', 			6),
			('LEADER_RIDER_FSN', 	'FLAVOR_NUKE', 						7),
			('LEADER_RIDER_FSN', 	'FLAVOR_USE_NUKE', 					5),
			('LEADER_RIDER_FSN', 	'FLAVOR_ESPIONAGE', 				5),
			('LEADER_RIDER_FSN', 	'FLAVOR_ANTIAIR',	 				5),
			('LEADER_RIDER_FSN', 	'FLAVOR_AIR_CARRIER', 				5),
			('LEADER_RIDER_FSN', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_RIDER_FSN', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_RIDER_FSN', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_RIDER_FSN', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_RIDER_FSN', 	'FLAVOR_ARCHAEOLOGY', 				5),
			('LEADER_RIDER_FSN', 	'FLAVOR_AIRLIFT', 					5);


--*******************************************************************
-- Trait Definition (Golden Rule)
--*******************************************************************
INSERT INTO Traits
			(Type,									Description,									ShortDescription,										UnitsRequiredPerHappinessPoint)
VALUES		('TRAIT_HAPPINESS_FROM_MILITARY_UNITS',	'TXT_KEY_TRAIT_HAPPINESS_FROM_MILITARY_UNITS',	'TXT_KEY_TRAIT_HAPPINESS_FROM_MILITARY_UNITS_SHORT',	4);

--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 			TraitType)
VALUES		('LEADER_RIDER_FSN', 	'TRAIT_HAPPINESS_FROM_MILITARY_UNITS');


--Dummy Policy

INSERT INTO Policies
			(Type)
VALUES		('POLICY_RIDER_DUMMY');