--All SQL Leader inserts were based off of SQL code from JFD's Civilizations.

--*******************************************************************
-- Nemesis, the Prussian Prince of Automatons
--*******************************************************************

INSERT INTO Leaders 
			(Type, 						Description, 						Civilopedia, 								CivilopediaTag, 								ArtDefineTag,		
			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty,
			Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 							PortraitIndex)
VALUES		('LEADER_NEMESIS', 			'TXT_KEY_LEADER_NEMESIS', 			'TXT_KEY_LEADER_NEMESIS_PEDIA',				'TXT_KEY_CIVILOPEDIA_LEADERS_NEMESIS', 			'NemesisScene.xml',
			8, 						3, 						3, 							6, 			5, 				1, 				5, 						7,				1, 
			5, 			3, 				2, 			6, 			'CIV_COLOR_ATLAS_NEMESIS', 			1);


--***************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 			MajorCivApproachType, 				Bias)
VALUES		('LEADER_NEMESIS', 	'MAJOR_CIV_APPROACH_WAR', 			6),
			('LEADER_NEMESIS', 	'MAJOR_CIV_APPROACH_HOSTILE', 		4),
			('LEADER_NEMESIS', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	11),
			('LEADER_NEMESIS', 	'MAJOR_CIV_APPROACH_GUARDED', 		9),
			('LEADER_NEMESIS', 	'MAJOR_CIV_APPROACH_AFRAID', 		2),
			('LEADER_NEMESIS', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		6),
			('LEADER_NEMESIS', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		6);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 			MinorCivApproachType, 				Bias)
VALUES		('LEADER_NEMESIS', 	'MINOR_CIV_APPROACH_IGNORE', 		4),
			('LEADER_NEMESIS', 	'MINOR_CIV_APPROACH_FRIENDLY', 		6),
			('LEADER_NEMESIS', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	6),
			('LEADER_NEMESIS', 	'MINOR_CIV_APPROACH_CONQUEST', 		5),
			('LEADER_NEMESIS', 	'MINOR_CIV_APPROACH_BULLY', 		6);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 			FlavorType, 					Flavor)
VALUES		('LEADER_NEMESIS', 	'FLAVOR_OFFENSE', 					7),
			('LEADER_NEMESIS', 	'FLAVOR_DEFENSE', 					7),
			('LEADER_NEMESIS', 	'FLAVOR_CITY_DEFENSE', 				8),
			('LEADER_NEMESIS', 	'FLAVOR_MILITARY_TRAINING', 		5),
			('LEADER_NEMESIS', 	'FLAVOR_RECON', 					8),
			('LEADER_NEMESIS', 	'FLAVOR_RANGED', 					8),
			('LEADER_NEMESIS', 	'FLAVOR_MOBILE', 					5),
			('LEADER_NEMESIS', 	'FLAVOR_NAVAL', 					4),
			('LEADER_NEMESIS', 	'FLAVOR_NAVAL_RECON', 				6),
			('LEADER_NEMESIS', 	'FLAVOR_NAVAL_GROWTH', 				4),
			('LEADER_NEMESIS', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	2),
			('LEADER_NEMESIS', 	'FLAVOR_AIR', 						4),
			('LEADER_NEMESIS', 	'FLAVOR_EXPANSION', 				7),
			('LEADER_NEMESIS', 	'FLAVOR_GROWTH', 					3),
			('LEADER_NEMESIS', 	'FLAVOR_TILE_IMPROVEMENT', 			3),
			('LEADER_NEMESIS', 	'FLAVOR_INFRASTRUCTURE', 			4),
			('LEADER_NEMESIS', 	'FLAVOR_PRODUCTION', 				8),
			('LEADER_NEMESIS', 	'FLAVOR_GOLD', 						4),
			('LEADER_NEMESIS', 	'FLAVOR_SCIENCE', 					9),
			('LEADER_NEMESIS', 	'FLAVOR_CULTURE', 					1),
			('LEADER_NEMESIS', 	'FLAVOR_HAPPINESS', 				2),
			('LEADER_NEMESIS', 	'FLAVOR_GREAT_PEOPLE', 				1),
			('LEADER_NEMESIS', 	'FLAVOR_WONDER', 					3),
			('LEADER_NEMESIS', 	'FLAVOR_RELIGION', 					1),
			('LEADER_NEMESIS', 	'FLAVOR_DIPLOMACY', 				3),
			('LEADER_NEMESIS', 	'FLAVOR_SPACESHIP', 				10),
			('LEADER_NEMESIS', 	'FLAVOR_WATER_CONNECTION', 			3),
			('LEADER_NEMESIS', 	'FLAVOR_NUKE', 						9),
			('LEADER_NEMESIS', 	'FLAVOR_USE_NUKE', 					7),
			('LEADER_NEMESIS', 	'FLAVOR_ESPIONAGE', 				10),
			('LEADER_NEMESIS', 	'FLAVOR_ANTIAIR',	 				6),
			('LEADER_NEMESIS', 	'FLAVOR_AIR_CARRIER', 				5),
			('LEADER_NEMESIS', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_NEMESIS', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_NEMESIS', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_NEMESIS', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_NEMESIS', 	'FLAVOR_ARCHAEOLOGY', 				5),
			('LEADER_NEMESIS', 	'FLAVOR_AIRLIFT', 					5);



--*******************************************************************
-- Trait Definition (Nemesis Plots)
--*******************************************************************
INSERT INTO Traits
			(Type,								 Description,							 ShortDescription)
VALUES		('TRAIT_INTRIGUE_BONUS_VENGEANCE', 'TXT_KEY_TRAIT_INTRIGUE_BONUS_VENGEANCE', 'TXT_KEY_TRAIT_INTRIGUE_BONUS_VENGEANCE_SHORT');


--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 			TraitType)
VALUES		('LEADER_NEMESIS',		'TRAIT_INTRIGUE_BONUS_VENGEANCE');



--Dummies
INSERT INTO BuildingClasses
			(Type,							DefaultBuilding,			NoLimit)
VALUES		('BUILDINGCLASS_NEMESIS_DUMMY',	'BUILDING_NEMESIS_DUMMY',	1);

INSERT INTO Buildings
			(Type,										BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune)
VALUES		('BUILDING_NEMESIS_DUMMY',		'BUILDINGCLASS_NEMESIS_DUMMY',
			-1,		-1,			-1,				'NULL',		1,				1);


INSERT INTO Building_YieldModifiers
			(BuildingType,			YieldType,				Yield)
VALUES		('BUILDING_NEMESIS_DUMMY','YIELD_SCIENCE',		1),
			('BUILDING_NEMESIS_DUMMY','YIELD_PRODUCTION',	1);



INSERT INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_NEMESIS'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_NEMESIS_'),	1
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC';

INSERT INTO Diplomacy_Responses		
			(LeaderType, 		ResponseType, 					Response, 													Bias)
VALUES		('LEADER_NEMESIS', 	'RESPONSE_DEFEATED', 			'TXT_KEY_LEADER_NEMESIS_DEFEATED%', 							1),	
			('LEADER_NEMESIS', 	'RESPONSE_FIRST_GREETING', 		'TXT_KEY_LEADER_NEMESIS_FIRSTGREETING%', 					1);