--All SQL Leader inserts were based off of SQL code from JFD's Civilizations.

--*******************************************************************
-- Lord Recluse
--*******************************************************************

INSERT INTO Leaders 
			(Type, 				Description, 				Civilopedia, 						CivilopediaTag, 						ArtDefineTag,		
			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness,
			Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 							PortraitIndex)
VALUES		('LEADER_RECLUSE', 	'TXT_KEY_LEADER_RECLUSE', 	'TXT_KEY_LEADER_RECLUSE_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_RECLUSE', 	'RecluseScene.xml', 
			9, 						1, 						2, 							6, 			2, 				1, 				3, 						1, 
			1, 			8, 			2, 				1, 			10, 		'CIV_COLOR_ATLAS_ARACHNOS', 		1);


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 		MajorCivApproachType, 			Bias)
VALUES		('LEADER_RECLUSE', 	'MAJOR_CIV_APPROACH_WAR', 			7),
			('LEADER_RECLUSE', 	'MAJOR_CIV_APPROACH_HOSTILE', 		10),
			('LEADER_RECLUSE', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	8),
			('LEADER_RECLUSE', 	'MAJOR_CIV_APPROACH_GUARDED', 		9),
			('LEADER_RECLUSE', 	'MAJOR_CIV_APPROACH_AFRAID', 		2),
			('LEADER_RECLUSE', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		2),
			('LEADER_RECLUSE', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		2);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 		MinorCivApproachType, 				Bias)
VALUES		('LEADER_RECLUSE', 	'MINOR_CIV_APPROACH_IGNORE', 		6),
			('LEADER_RECLUSE', 	'MINOR_CIV_APPROACH_FRIENDLY', 		2),
			('LEADER_RECLUSE', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	2),
			('LEADER_RECLUSE', 	'MINOR_CIV_APPROACH_CONQUEST', 		5),
			('LEADER_RECLUSE', 	'MINOR_CIV_APPROACH_BULLY', 		10);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 		FlavorType, 						Flavor)
VALUES		('LEADER_RECLUSE', 	'FLAVOR_OFFENSE', 					5),
			('LEADER_RECLUSE', 	'FLAVOR_DEFENSE', 					8),
			('LEADER_RECLUSE', 	'FLAVOR_CITY_DEFENSE', 				8),
			('LEADER_RECLUSE', 	'FLAVOR_MILITARY_TRAINING', 		5),
			('LEADER_RECLUSE', 	'FLAVOR_RECON', 					6),
			('LEADER_RECLUSE', 	'FLAVOR_RANGED', 					5),
			('LEADER_RECLUSE', 	'FLAVOR_MOBILE', 					7),
			('LEADER_RECLUSE', 	'FLAVOR_NAVAL', 					8),
			('LEADER_RECLUSE', 	'FLAVOR_NAVAL_RECON', 				6),
			('LEADER_RECLUSE', 	'FLAVOR_NAVAL_GROWTH', 				8),
			('LEADER_RECLUSE', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	7),
			('LEADER_RECLUSE', 	'FLAVOR_AIR', 						6),
			('LEADER_RECLUSE', 	'FLAVOR_EXPANSION', 				2),
			('LEADER_RECLUSE', 	'FLAVOR_GROWTH', 					8),
			('LEADER_RECLUSE', 	'FLAVOR_TILE_IMPROVEMENT', 			7),
			('LEADER_RECLUSE', 	'FLAVOR_INFRASTRUCTURE', 			3),
			('LEADER_RECLUSE', 	'FLAVOR_PRODUCTION', 				6),
			('LEADER_RECLUSE', 	'FLAVOR_GOLD', 						4),
			('LEADER_RECLUSE', 	'FLAVOR_SCIENCE', 					9),
			('LEADER_RECLUSE', 	'FLAVOR_CULTURE', 					3),
			('LEADER_RECLUSE', 	'FLAVOR_HAPPINESS', 				4),
			('LEADER_RECLUSE', 	'FLAVOR_GREAT_PEOPLE', 				9),
			('LEADER_RECLUSE', 	'FLAVOR_WONDER', 					5),
			('LEADER_RECLUSE', 	'FLAVOR_RELIGION', 					3),
			('LEADER_RECLUSE', 	'FLAVOR_DIPLOMACY', 				1),
			('LEADER_RECLUSE', 	'FLAVOR_SPACESHIP', 				10),
			('LEADER_RECLUSE', 	'FLAVOR_WATER_CONNECTION', 			6),
			('LEADER_RECLUSE', 	'FLAVOR_NUKE', 						8),
			('LEADER_RECLUSE', 	'FLAVOR_USE_NUKE', 					8),
			('LEADER_RECLUSE', 	'FLAVOR_ESPIONAGE', 				7),
			('LEADER_RECLUSE', 	'FLAVOR_ANTIAIR',	 				5),
			('LEADER_RECLUSE', 	'FLAVOR_AIR_CARRIER', 				7),
			('LEADER_RECLUSE', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_RECLUSE', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_RECLUSE', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_RECLUSE', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_RECLUSE', 	'FLAVOR_ARCHAEOLOGY', 				5),
			('LEADER_RECLUSE', 	'FLAVOR_AIRLIFT', 					5);


--*******************************************************************
-- Trait Definition (Project: DESTINY)
--*******************************************************************
INSERT INTO Traits
			(Type,							Description,							ShortDescription,							GreatPeopleRateModifier,GreatPeopleSpawnAsVillains,	GreatGeneralExtraBonus)
VALUES		('TRAIT_GREAT_PERSON_VILLAINS', 'TXT_KEY_TRAIT_GREAT_PERSON_VILLAINS', 'TXT_KEY_TRAIT_GREAT_PERSON_VILLAINS_SHORT', 25,						1,							5);

INSERT INTO Trait_ImprovementYieldChanges
			(TraitType,						ImprovementType,		YieldType,			Yield)
SELECT		('TRAIT_GREAT_PERSON_VILLAINS'),ImprovementType,		YieldType,			CAST((Yield * 0.25) AS INT)
FROM Improvement_Yields WHERE EXISTS(SELECT * FROM Improvements WHERE Type = ImprovementType AND CreatedByGreatPerson = 1);

--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 		TraitType)
VALUES		('LEADER_RECLUSE', 	'TRAIT_GREAT_PERSON_VILLAINS');



INSERT INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_RECLUSE'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_RECLUSE_'),	1
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC';

INSERT INTO Diplomacy_Responses		
			(LeaderType, 		ResponseType, 					Response, 													Bias)
VALUES		('LEADER_RECLUSE', 	'RESPONSE_DEFEATED', 			'TXT_KEY_LEADER_RECLUSE_DEFEATED%', 							1),	
			('LEADER_RECLUSE', 	'RESPONSE_FIRST_GREETING', 		'TXT_KEY_LEADER_RECLUSE_FIRSTGREETING%', 					1);