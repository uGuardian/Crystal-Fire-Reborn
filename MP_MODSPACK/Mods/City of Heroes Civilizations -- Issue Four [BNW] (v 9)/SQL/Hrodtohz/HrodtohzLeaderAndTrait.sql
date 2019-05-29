--All SQL Leader inserts were based off of SQL code from JFD's Civilizations.

--*******************************************************************
-- Hro'Dtohz, Lord of War
--*******************************************************************

INSERT INTO Leaders 
			(Type, 					Description, 				Civilopedia, 						CivilopediaTag, 							ArtDefineTag,		
			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, 
			Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 							PortraitIndex)
VALUES		('LEADER_HRODTOHZ', 	'TXT_KEY_LEADER_HRODTOHZ', 	'TXT_KEY_LEADER_HRODTOHZ_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_HRODTOHZ', 	'HrodtohzScene.xml',	
			9, 						2, 						1, 							10, 		2, 				1, 				4, 						1, 				
			5,			1, 			1, 				1, 			5, 			'CIV_COLOR_ATLAS_RIKTI', 	1);


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 			MajorCivApproachType, 				Bias)
VALUES		('LEADER_HRODTOHZ', 	'MAJOR_CIV_APPROACH_WAR', 			10),
			('LEADER_HRODTOHZ', 	'MAJOR_CIV_APPROACH_HOSTILE', 		10),
			('LEADER_HRODTOHZ', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	3),
			('LEADER_HRODTOHZ', 	'MAJOR_CIV_APPROACH_GUARDED', 		9),
			('LEADER_HRODTOHZ', 	'MAJOR_CIV_APPROACH_AFRAID', 		3),
			('LEADER_HRODTOHZ', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		2),
			('LEADER_HRODTOHZ', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		4);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 			MinorCivApproachType, 				Bias)
VALUES		('LEADER_HRODTOHZ', 	'MINOR_CIV_APPROACH_IGNORE', 		4),
			('LEADER_HRODTOHZ', 	'MINOR_CIV_APPROACH_FRIENDLY', 		2),
			('LEADER_HRODTOHZ', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	1),
			('LEADER_HRODTOHZ', 	'MINOR_CIV_APPROACH_CONQUEST', 		8),
			('LEADER_HRODTOHZ', 	'MINOR_CIV_APPROACH_BULLY', 		10);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 		FlavorType, 						Flavor)
VALUES		('LEADER_HRODTOHZ', 	'FLAVOR_OFFENSE', 					10),
			('LEADER_HRODTOHZ', 	'FLAVOR_DEFENSE', 					4),
			('LEADER_HRODTOHZ', 	'FLAVOR_CITY_DEFENSE', 				4),
			('LEADER_HRODTOHZ', 	'FLAVOR_MILITARY_TRAINING', 		4),
			('LEADER_HRODTOHZ', 	'FLAVOR_RECON', 					3),
			('LEADER_HRODTOHZ', 	'FLAVOR_RANGED', 					8),
			('LEADER_HRODTOHZ', 	'FLAVOR_MOBILE', 					8),
			('LEADER_HRODTOHZ', 	'FLAVOR_NAVAL', 					5),
			('LEADER_HRODTOHZ', 	'FLAVOR_NAVAL_RECON', 				5),
			('LEADER_HRODTOHZ', 	'FLAVOR_NAVAL_GROWTH', 				5),
			('LEADER_HRODTOHZ', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
			('LEADER_HRODTOHZ', 	'FLAVOR_AIR', 						8),
			('LEADER_HRODTOHZ', 	'FLAVOR_EXPANSION', 				9),
			('LEADER_HRODTOHZ', 	'FLAVOR_GROWTH', 					2),
			('LEADER_HRODTOHZ', 	'FLAVOR_TILE_IMPROVEMENT', 			3),
			('LEADER_HRODTOHZ', 	'FLAVOR_INFRASTRUCTURE', 			3),
			('LEADER_HRODTOHZ', 	'FLAVOR_PRODUCTION', 				8),
			('LEADER_HRODTOHZ', 	'FLAVOR_GOLD', 						5),
			('LEADER_HRODTOHZ', 	'FLAVOR_SCIENCE', 					8),
			('LEADER_HRODTOHZ', 	'FLAVOR_CULTURE', 					1),
			('LEADER_HRODTOHZ', 	'FLAVOR_HAPPINESS', 				1),
			('LEADER_HRODTOHZ', 	'FLAVOR_GREAT_PEOPLE', 				1),
			('LEADER_HRODTOHZ', 	'FLAVOR_WONDER', 					2),
			('LEADER_HRODTOHZ', 	'FLAVOR_RELIGION', 					1),
			('LEADER_HRODTOHZ', 	'FLAVOR_DIPLOMACY', 				1),
			('LEADER_HRODTOHZ', 	'FLAVOR_SPACESHIP', 				7),
			('LEADER_HRODTOHZ', 	'FLAVOR_WATER_CONNECTION', 			3),
			('LEADER_HRODTOHZ', 	'FLAVOR_NUKE', 						10),
			('LEADER_HRODTOHZ', 	'FLAVOR_USE_NUKE', 					10),
			('LEADER_HRODTOHZ', 	'FLAVOR_ESPIONAGE', 				5),
			('LEADER_HRODTOHZ', 	'FLAVOR_ANTIAIR',	 				7),
			('LEADER_HRODTOHZ', 	'FLAVOR_AIR_CARRIER', 				5),
			('LEADER_HRODTOHZ', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_HRODTOHZ', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_HRODTOHZ', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_HRODTOHZ', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_HRODTOHZ', 	'FLAVOR_ARCHAEOLOGY', 				5),
			('LEADER_HRODTOHZ', 	'FLAVOR_AIRLIFT', 					5);


--*******************************************************************
-- Trait Definition (Rikti Portals)
--*******************************************************************
INSERT INTO Traits
			(Type,								 Description,								ShortDescription)
VALUES		('TRAIT_MACHINERY_AIRLIFT_PYLONS', 'TXT_KEY_TRAIT_MACHINERY_AIRLIFT_PYLONS', 'TXT_KEY_TRAIT_MACHINERY_AIRLIFT_PYLONS_SHORT');


--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 			TraitType)
VALUES		('LEADER_HRODTOHZ', 	'TRAIT_MACHINERY_AIRLIFT_PYLONS');


--Trait dummy building
INSERT INTO BuildingClasses
			(Type,							DefaultBuilding)
VALUES		('BUILDINGCLASS_RIKTI_DUMMY',	'BUILDING_RIKTI_DUMMY');

INSERT INTO Buildings
			(Type,										BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune,
			Airlift)
VALUES		('BUILDING_RIKTI_DUMMY',		'BUILDINGCLASS_RIKTI_DUMMY',
			-1,		-1,			-1,				'NULL',		1,				1,
			1);


INSERT INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_HRODTOHZ'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_HRODTOHZ_'),	1
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC';

INSERT INTO Diplomacy_Responses		
			(LeaderType, 		ResponseType, 					Response, 													Bias)
VALUES		('LEADER_HRODTOHZ', 	'RESPONSE_DEFEATED', 			'TXT_KEY_LEADER_HRODTOHZ_DEFEATED%', 							1),	
			('LEADER_HRODTOHZ', 	'RESPONSE_FIRST_GREETING', 		'TXT_KEY_LEADER_HRODTOHZ_FIRSTGREETING%', 					1);
