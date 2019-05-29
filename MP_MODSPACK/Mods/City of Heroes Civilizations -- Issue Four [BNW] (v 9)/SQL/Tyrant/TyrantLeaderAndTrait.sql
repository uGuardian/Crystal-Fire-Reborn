--All SQL Leader inserts were based off of SQL code from JFD's Civilizations.

--*******************************************************************
-- Marcus Cole, aka Tyrant
--*******************************************************************

INSERT INTO Leaders 
			(Type, 				Description, 			Civilopedia, 					CivilopediaTag, 						ArtDefineTag,		
			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness,
			Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 					PortraitIndex)
VALUES		('LEADER_TYRANT','TXT_KEY_LEADER_TYRANT', 	'TXT_KEY_LEADER_TYRANT_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_TYRANT',	'TyrantScene.xml',	
			7,						4, 						4, 							8, 			4, 				4, 				6, 						4, 
			5, 			3, 			3, 				2, 			7, 			'CIV_COLOR_ATLAS_PRAETORIA', 1);


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 		MajorCivApproachType, 				Bias)
VALUES		('LEADER_TYRANT', 	'MAJOR_CIV_APPROACH_WAR', 			7),
			('LEADER_TYRANT', 	'MAJOR_CIV_APPROACH_HOSTILE', 		7),
			('LEADER_TYRANT', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	5),
			('LEADER_TYRANT', 	'MAJOR_CIV_APPROACH_GUARDED', 		8),
			('LEADER_TYRANT', 	'MAJOR_CIV_APPROACH_AFRAID', 		1),
			('LEADER_TYRANT', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		4),
			('LEADER_TYRANT', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		6);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 		MinorCivApproachType, 				Bias)
VALUES		('LEADER_TYRANT', 	'MINOR_CIV_APPROACH_IGNORE', 		7),
			('LEADER_TYRANT', 	'MINOR_CIV_APPROACH_FRIENDLY', 		4),
			('LEADER_TYRANT', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	4),
			('LEADER_TYRANT', 	'MINOR_CIV_APPROACH_CONQUEST', 		4),
			('LEADER_TYRANT', 	'MINOR_CIV_APPROACH_BULLY', 		6);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 		FlavorType, 						Flavor)
VALUES		('LEADER_TYRANT', 	'FLAVOR_OFFENSE', 					9),
			('LEADER_TYRANT', 	'FLAVOR_DEFENSE', 					6),
			('LEADER_TYRANT', 	'FLAVOR_CITY_DEFENSE', 				8),
			('LEADER_TYRANT', 	'FLAVOR_MILITARY_TRAINING', 		7),
			('LEADER_TYRANT', 	'FLAVOR_RECON', 					4),
			('LEADER_TYRANT', 	'FLAVOR_RANGED', 					5),
			('LEADER_TYRANT', 	'FLAVOR_MOBILE', 					7),
			('LEADER_TYRANT', 	'FLAVOR_NAVAL', 					4),
			('LEADER_TYRANT', 	'FLAVOR_NAVAL_RECON', 				3),
			('LEADER_TYRANT', 	'FLAVOR_NAVAL_GROWTH', 				4),
			('LEADER_TYRANT', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	2),
			('LEADER_TYRANT', 	'FLAVOR_AIR', 						7),
			('LEADER_TYRANT', 	'FLAVOR_EXPANSION', 				6),
			('LEADER_TYRANT', 	'FLAVOR_GROWTH', 					4),
			('LEADER_TYRANT', 	'FLAVOR_TILE_IMPROVEMENT', 			5),
			('LEADER_TYRANT', 	'FLAVOR_INFRASTRUCTURE', 			4),
			('LEADER_TYRANT', 	'FLAVOR_PRODUCTION', 				4),
			('LEADER_TYRANT', 	'FLAVOR_GOLD', 						2),
			('LEADER_TYRANT', 	'FLAVOR_SCIENCE', 					6),
			('LEADER_TYRANT', 	'FLAVOR_CULTURE', 					6),
			('LEADER_TYRANT', 	'FLAVOR_HAPPINESS', 				3),
			('LEADER_TYRANT', 	'FLAVOR_GREAT_PEOPLE', 				4),
			('LEADER_TYRANT', 	'FLAVOR_WONDER', 					8),
			('LEADER_TYRANT', 	'FLAVOR_RELIGION', 					6),
			('LEADER_TYRANT', 	'FLAVOR_DIPLOMACY', 				2),
			('LEADER_TYRANT', 	'FLAVOR_SPACESHIP', 				8),
			('LEADER_TYRANT', 	'FLAVOR_WATER_CONNECTION', 			3),
			('LEADER_TYRANT', 	'FLAVOR_NUKE', 						8),
			('LEADER_TYRANT', 	'FLAVOR_USE_NUKE', 					10),
			('LEADER_TYRANT', 	'FLAVOR_ESPIONAGE', 				6),
			('LEADER_TYRANT', 	'FLAVOR_ANTIAIR',	 				4),
			('LEADER_TYRANT', 	'FLAVOR_AIR_CARRIER', 				5),
			('LEADER_TYRANT', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_TYRANT', 	'FLAVOR_I_TRADE_ORIGIN', 			8),
			('LEADER_TYRANT', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_TYRANT', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_TYRANT', 	'FLAVOR_ARCHAEOLOGY', 				5),
			('LEADER_TYRANT', 	'FLAVOR_AIRLIFT', 					5);


--*******************************************************************
-- Trait Definition (Champion of the Well)
--*******************************************************************
INSERT INTO Traits
			(Type,							Description,						 ShortDescription,							VictoryPointsPerStrengthPoint)
VALUES		('TRAIT_STRENGTH_FROM_SCORE',	'TXT_KEY_TRAIT_STRENGTH_FROM_SCORE', 'TXT_KEY_TRAIT_STRENGTH_FROM_SCORE_SHORT',	200);


--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 		TraitType)
VALUES		('LEADER_TYRANT', 	'TRAIT_STRENGTH_FROM_SCORE');





INSERT INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_TYRANT'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_TYRANT_'),	1
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC';

INSERT INTO Diplomacy_Responses		
			(LeaderType, 		ResponseType, 					Response, 													Bias)
VALUES		('LEADER_TYRANT', 	'RESPONSE_DEFEATED', 			'TXT_KEY_LEADER_TYRANT_DEFEATED%', 							1),	
			('LEADER_TYRANT', 	'RESPONSE_FIRST_GREETING', 		'TXT_KEY_LEADER_TYRANT_FIRSTGREETING%', 					1);