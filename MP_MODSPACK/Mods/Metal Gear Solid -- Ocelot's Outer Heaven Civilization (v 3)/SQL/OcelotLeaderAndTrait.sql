--All SQL Leader inserts were based off of SQL code from JFD's Civilizations.

--*******************************************************************
-- Pierce Washington
--*******************************************************************

INSERT INTO Leaders 
			(Type, 				Description, 				Civilopedia, 					CivilopediaTag, 						ArtDefineTag,		VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 					PortraitIndex)
VALUES		('LEADER_OCELOT', 	'TXT_KEY_LEADER_OCELOT', 	'TXT_KEY_LEADER_OCELOT_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_OCELOT', 	'OcelotScene.xml',	8, 						2, 						3, 							9, 			4, 				0, 				3, 						4, 				0, 			4, 			3, 				4, 			8, 			'CIV_COLOR_ATLAS_OCELOT', 	1);


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 		MajorCivApproachType, 				Bias)
VALUES		('LEADER_OCELOT', 	'MAJOR_CIV_APPROACH_WAR', 			9),
			('LEADER_OCELOT', 	'MAJOR_CIV_APPROACH_HOSTILE', 		7),
			('LEADER_OCELOT', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	12),
			('LEADER_OCELOT', 	'MAJOR_CIV_APPROACH_GUARDED', 		9),
			('LEADER_OCELOT', 	'MAJOR_CIV_APPROACH_AFRAID', 		3),
			('LEADER_OCELOT', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		3),
			('LEADER_OCELOT', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		2);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 		MinorCivApproachType, 				Bias)
VALUES		('LEADER_OCELOT', 	'MINOR_CIV_APPROACH_IGNORE', 		6),
			('LEADER_OCELOT', 	'MINOR_CIV_APPROACH_FRIENDLY', 		3),
			('LEADER_OCELOT', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	2),
			('LEADER_OCELOT', 	'MINOR_CIV_APPROACH_CONQUEST', 		5),
			('LEADER_OCELOT', 	'MINOR_CIV_APPROACH_BULLY', 		9);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 		FlavorType, 						Flavor)
VALUES		('LEADER_OCELOT', 	'FLAVOR_OFFENSE', 					9),
			('LEADER_OCELOT', 	'FLAVOR_DEFENSE', 					6),
			('LEADER_OCELOT', 	'FLAVOR_CITY_DEFENSE', 				8),
			('LEADER_OCELOT', 	'FLAVOR_MILITARY_TRAINING', 		6),
			('LEADER_OCELOT', 	'FLAVOR_RECON', 					3),
			('LEADER_OCELOT', 	'FLAVOR_RANGED', 					7),
			('LEADER_OCELOT', 	'FLAVOR_MOBILE', 					6),
			('LEADER_OCELOT', 	'FLAVOR_NAVAL', 					4),
			('LEADER_OCELOT', 	'FLAVOR_NAVAL_RECON', 				4),
			('LEADER_OCELOT', 	'FLAVOR_NAVAL_GROWTH', 				4),
			('LEADER_OCELOT', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	4),
			('LEADER_OCELOT', 	'FLAVOR_AIR', 						5),
			('LEADER_OCELOT', 	'FLAVOR_EXPANSION', 				8),
			('LEADER_OCELOT', 	'FLAVOR_GROWTH', 					8),
			('LEADER_OCELOT', 	'FLAVOR_TILE_IMPROVEMENT', 			7),
			('LEADER_OCELOT', 	'FLAVOR_INFRASTRUCTURE', 			6),
			('LEADER_OCELOT', 	'FLAVOR_PRODUCTION', 				7),
			('LEADER_OCELOT', 	'FLAVOR_GOLD', 						5),
			('LEADER_OCELOT', 	'FLAVOR_SCIENCE', 					6),
			('LEADER_OCELOT', 	'FLAVOR_CULTURE', 					2),
			('LEADER_OCELOT', 	'FLAVOR_HAPPINESS', 				3),
			('LEADER_OCELOT', 	'FLAVOR_GREAT_PEOPLE', 				3),
			('LEADER_OCELOT', 	'FLAVOR_WONDER', 					2),
			('LEADER_OCELOT', 	'FLAVOR_RELIGION', 					2),
			('LEADER_OCELOT', 	'FLAVOR_DIPLOMACY', 				3),
			('LEADER_OCELOT', 	'FLAVOR_SPACESHIP', 				6),
			('LEADER_OCELOT', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_OCELOT', 	'FLAVOR_NUKE', 						9),
			('LEADER_OCELOT', 	'FLAVOR_USE_NUKE', 					9),
			('LEADER_OCELOT', 	'FLAVOR_ESPIONAGE', 				10),
			('LEADER_OCELOT', 	'FLAVOR_ANTIAIR',	 				4),
			('LEADER_OCELOT', 	'FLAVOR_AIR_CARRIER', 				4),
			('LEADER_OCELOT', 	'FLAVOR_I_TRADE_DESTINATION', 		6),
			('LEADER_OCELOT', 	'FLAVOR_I_TRADE_ORIGIN', 			7),
			('LEADER_OCELOT', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		6),
			('LEADER_OCELOT', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		4),
			('LEADER_OCELOT', 	'FLAVOR_ARCHAEOLOGY', 				5),
			('LEADER_OCELOT', 	'FLAVOR_AIRLIFT', 					8);


--*******************************************************************
-- Trait Definition (Riders on the Row)
--*******************************************************************
INSERT INTO Traits
			(Type,							Description,							ShortDescription)
VALUES		('TRAIT_GOLDEN_AGE_FROM_WARS',	'TXT_KEY_TRAIT_GOLDEN_AGE_FROM_WARS',	'TXT_KEY_TRAIT_GOLDEN_AGE_FROM_WARS_SHORT');

INSERT INTO Trait_NoTrain
			(TraitType,						UnitClassType)
VALUES		('TRAIT_GOLDEN_AGE_FROM_WARS',	'UNITCLASS_SETTLER');

--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 					TraitType)
VALUES		('LEADER_OCELOT', 	'TRAIT_GOLDEN_AGE_FROM_WARS');





