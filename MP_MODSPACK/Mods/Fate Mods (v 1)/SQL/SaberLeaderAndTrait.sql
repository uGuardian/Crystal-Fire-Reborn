--All SQL Leader inserts were based off of SQL code from JFD's Civilizations.

--*******************************************************************
-- Arturia Pendragon, aka Saber
--*******************************************************************

INSERT INTO Leaders 
			(Type, 				Description, 				Civilopedia, 					CivilopediaTag, 						ArtDefineTag,			
			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness,
			Chattiness, Meanness, 	IconAtlas, 					PortraitIndex)
VALUES		('LEADER_SABER', 	'TXT_KEY_LEADER_SABER', 	'TXT_KEY_LEADER_SABER_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_SABER', 	'SaberScene.xml',
			7, 						4, 						4, 							8, 			6, 				4, 				5, 						5, 				9, 			1, 			4,
			3, 			4, 			'CIV_COLOR_ATLAS_SABER', 	1);


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 		MajorCivApproachType, 				Bias)
VALUES		('LEADER_SABER', 	'MAJOR_CIV_APPROACH_WAR', 			6),
			('LEADER_SABER', 	'MAJOR_CIV_APPROACH_HOSTILE', 		5),
			('LEADER_SABER', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	1),
			('LEADER_SABER', 	'MAJOR_CIV_APPROACH_GUARDED', 		7),
			('LEADER_SABER', 	'MAJOR_CIV_APPROACH_AFRAID', 		2),
			('LEADER_SABER', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		4),
			('LEADER_SABER', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		7);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 		MinorCivApproachType, 				Bias)
VALUES		('LEADER_SABER', 	'MINOR_CIV_APPROACH_IGNORE', 		7),
			('LEADER_SABER', 	'MINOR_CIV_APPROACH_FRIENDLY', 		6),
			('LEADER_SABER', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	4),
			('LEADER_SABER', 	'MINOR_CIV_APPROACH_CONQUEST', 		2),
			('LEADER_SABER', 	'MINOR_CIV_APPROACH_BULLY', 		4);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 		FlavorType, 						Flavor)
VALUES		('LEADER_SABER', 	'FLAVOR_OFFENSE', 					8),
			('LEADER_SABER', 	'FLAVOR_DEFENSE', 					4),
			('LEADER_SABER', 	'FLAVOR_CITY_DEFENSE', 				8),
			('LEADER_SABER', 	'FLAVOR_MILITARY_TRAINING', 		6),
			('LEADER_SABER', 	'FLAVOR_RECON', 					3),
			('LEADER_SABER', 	'FLAVOR_RANGED', 					4),
			('LEADER_SABER', 	'FLAVOR_MOBILE', 					7),
			('LEADER_SABER', 	'FLAVOR_NAVAL', 					6),
			('LEADER_SABER', 	'FLAVOR_NAVAL_RECON', 				4),
			('LEADER_SABER', 	'FLAVOR_NAVAL_GROWTH', 				7),
			('LEADER_SABER', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	6),
			('LEADER_SABER', 	'FLAVOR_AIR', 						6),
			('LEADER_SABER', 	'FLAVOR_EXPANSION', 				8),
			('LEADER_SABER', 	'FLAVOR_GROWTH', 					3),
			('LEADER_SABER', 	'FLAVOR_TILE_IMPROVEMENT', 			5),
			('LEADER_SABER', 	'FLAVOR_INFRASTRUCTURE', 			5),
			('LEADER_SABER', 	'FLAVOR_PRODUCTION', 				6),
			('LEADER_SABER', 	'FLAVOR_GOLD', 						4),
			('LEADER_SABER', 	'FLAVOR_SCIENCE', 					5),
			('LEADER_SABER', 	'FLAVOR_CULTURE', 					6),
			('LEADER_SABER', 	'FLAVOR_HAPPINESS', 				8),
			('LEADER_SABER', 	'FLAVOR_GREAT_PEOPLE', 				3),
			('LEADER_SABER', 	'FLAVOR_WONDER', 					3),
			('LEADER_SABER', 	'FLAVOR_RELIGION', 					4),
			('LEADER_SABER', 	'FLAVOR_DIPLOMACY', 				3),
			('LEADER_SABER', 	'FLAVOR_SPACESHIP', 				6),
			('LEADER_SABER', 	'FLAVOR_WATER_CONNECTION', 			7),
			('LEADER_SABER', 	'FLAVOR_NUKE', 						8),
			('LEADER_SABER', 	'FLAVOR_USE_NUKE', 					2),
			('LEADER_SABER', 	'FLAVOR_ESPIONAGE', 				2),
			('LEADER_SABER', 	'FLAVOR_ANTIAIR',	 				7),
			('LEADER_SABER', 	'FLAVOR_AIR_CARRIER', 				6),
			('LEADER_SABER', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_SABER', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_SABER', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_SABER', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_SABER', 	'FLAVOR_ARCHAEOLOGY', 				5),
			('LEADER_SABER', 	'FLAVOR_AIRLIFT', 					5);


--*******************************************************************
-- Trait Definition (Sword of Promised Victory)
--*******************************************************************
INSERT INTO Traits
			(Type,						Description,						ShortDescription)
VALUES		('TRAIT_MELEE_UNITS_SIEGE',	'TXT_KEY_TRAIT_MELEE_UNITS_SIEGE',	'TXT_KEY_TRAIT_MELEE_UNITS_SIEGE_SHORT');

INSERT INTO Trait_FreePromotionUnitCombats
			(TraitType,					UnitCombatType,		PromotionType)
VALUES		('TRAIT_MELEE_UNITS_SIEGE',	'UNITCOMBAT_MELEE',	'PROMOTION_SIEGE');

INSERT INTO Trait_FreeResourceFirstXCities
			(TraitType,					ResourceType,		ResourceQuantity,	NumCities)
VALUES		('TRAIT_MELEE_UNITS_SIEGE',	'RESOURCE_IRON',	2,					3);

--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 		TraitType)
VALUES		('LEADER_SABER', 	'TRAIT_MELEE_UNITS_SIEGE');


