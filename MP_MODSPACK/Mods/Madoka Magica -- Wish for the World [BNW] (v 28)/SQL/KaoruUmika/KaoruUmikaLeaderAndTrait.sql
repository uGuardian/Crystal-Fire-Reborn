--All SQL Leader inserts were based off of SQL code from JFD's Civilizations.

--*******************************************************************
-- Kazumi Subaru
-- NOTE: For compatibility reasons, Kazumi is still KAORU_UMIKA internally.
--*******************************************************************

INSERT INTO Leaders 
			(Type, 					Description, 					Civilopedia, 							CivilopediaTag, 							ArtDefineTag,			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 							PortraitIndex)
VALUES		('LEADER_KAORU_UMIKA', 	'TXT_KEY_LEADER_KAORU_UMIKA', 	'TXT_KEY_LEADER_KAORU_UMIKA_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_KAORU_UMIKA', 	'KazumiScene.xml',		4, 						4, 						5, 							4, 			3, 				4, 				6, 						6, 				7, 			4, 			5, 				4, 			4, 			'CIV_COLOR_ATLAS_KAORU_UMIKA', 		1);


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 			MajorCivApproachType, 				Bias)
VALUES		('LEADER_KAORU_UMIKA', 	'MAJOR_CIV_APPROACH_WAR', 			4),
			('LEADER_KAORU_UMIKA', 	'MAJOR_CIV_APPROACH_HOSTILE', 		4),
			('LEADER_KAORU_UMIKA', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	6),
			('LEADER_KAORU_UMIKA', 	'MAJOR_CIV_APPROACH_GUARDED', 		7),
			('LEADER_KAORU_UMIKA', 	'MAJOR_CIV_APPROACH_AFRAID', 		3),
			('LEADER_KAORU_UMIKA', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		7),
			('LEADER_KAORU_UMIKA', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		5);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 			MinorCivApproachType, 				Bias)
VALUES		('LEADER_KAORU_UMIKA', 	'MINOR_CIV_APPROACH_IGNORE', 		3),
			('LEADER_KAORU_UMIKA', 	'MINOR_CIV_APPROACH_FRIENDLY', 		5),
			('LEADER_KAORU_UMIKA', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	6),
			('LEADER_KAORU_UMIKA', 	'MINOR_CIV_APPROACH_CONQUEST', 		2),
			('LEADER_KAORU_UMIKA', 	'MINOR_CIV_APPROACH_BULLY', 		3);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 			FlavorType, 						Flavor)
VALUES		('LEADER_KAORU_UMIKA', 	'FLAVOR_OFFENSE', 					4),
			('LEADER_KAORU_UMIKA', 	'FLAVOR_DEFENSE', 					6),
			('LEADER_KAORU_UMIKA', 	'FLAVOR_CITY_DEFENSE', 				5),
			('LEADER_KAORU_UMIKA', 	'FLAVOR_MILITARY_TRAINING', 		4),
			('LEADER_KAORU_UMIKA', 	'FLAVOR_RECON', 					5),
			('LEADER_KAORU_UMIKA', 	'FLAVOR_RANGED', 					5),
			('LEADER_KAORU_UMIKA', 	'FLAVOR_MOBILE', 					7),
			('LEADER_KAORU_UMIKA', 	'FLAVOR_NAVAL', 					7),
			('LEADER_KAORU_UMIKA', 	'FLAVOR_NAVAL_RECON', 				5),
			('LEADER_KAORU_UMIKA', 	'FLAVOR_NAVAL_GROWTH', 				6),
			('LEADER_KAORU_UMIKA', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
			('LEADER_KAORU_UMIKA', 	'FLAVOR_AIR', 						7),
			('LEADER_KAORU_UMIKA', 	'FLAVOR_EXPANSION', 				4),
			('LEADER_KAORU_UMIKA', 	'FLAVOR_GROWTH', 					7),
			('LEADER_KAORU_UMIKA', 	'FLAVOR_TILE_IMPROVEMENT', 			6),
			('LEADER_KAORU_UMIKA', 	'FLAVOR_INFRASTRUCTURE', 			5),
			('LEADER_KAORU_UMIKA', 	'FLAVOR_PRODUCTION', 				6),
			('LEADER_KAORU_UMIKA', 	'FLAVOR_GOLD', 						4),
			('LEADER_KAORU_UMIKA', 	'FLAVOR_SCIENCE', 					6),
			('LEADER_KAORU_UMIKA', 	'FLAVOR_CULTURE', 					7),
			('LEADER_KAORU_UMIKA', 	'FLAVOR_HAPPINESS', 				7),
			('LEADER_KAORU_UMIKA', 	'FLAVOR_GREAT_PEOPLE', 				5),
			('LEADER_KAORU_UMIKA', 	'FLAVOR_WONDER', 					5),
			('LEADER_KAORU_UMIKA', 	'FLAVOR_RELIGION', 					4),
			('LEADER_KAORU_UMIKA', 	'FLAVOR_DIPLOMACY', 				8),
			('LEADER_KAORU_UMIKA', 	'FLAVOR_SPACESHIP', 				5),
			('LEADER_KAORU_UMIKA', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_KAORU_UMIKA', 	'FLAVOR_NUKE', 						2),
			('LEADER_KAORU_UMIKA', 	'FLAVOR_USE_NUKE', 					2),
			('LEADER_KAORU_UMIKA', 	'FLAVOR_ESPIONAGE', 				5),
			('LEADER_KAORU_UMIKA', 	'FLAVOR_ANTIAIR',	 				7),
			('LEADER_KAORU_UMIKA', 	'FLAVOR_AIR_CARRIER', 				5),
			('LEADER_KAORU_UMIKA', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_KAORU_UMIKA', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_KAORU_UMIKA', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_KAORU_UMIKA', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_KAORU_UMIKA', 	'FLAVOR_ARCHAEOLOGY', 				5),
			('LEADER_KAORU_UMIKA', 	'FLAVOR_AIRLIFT', 					5);


--*******************************************************************
-- Trait Definition (The Freezer)
--*******************************************************************
INSERT INTO Traits
			(Type,										Description,										ShortDescription,										EnableFreezerSystem)
VALUES		('TRAIT_MG_FROM_WITCHES_STORE_KILLED_MGS',	'TXT_KEY_TRAIT_MG_FROM_WITCHES_STORE_KILLED_MGS',	'TXT_KEY_TRAIT_MG_FROM_WITCHES_STORE_KILLED_MGS_SHORT',	1);

INSERT INTO Trait_NoTrain
			(TraitType,		UnitClassType)
VALUES		('TRAIT_MG_FROM_WITCHES_STORE_KILLED_MGS',	'UNITCLASS_SCOUT');



--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 			TraitType)
VALUES		('LEADER_KAORU_UMIKA', 	'TRAIT_MG_FROM_WITCHES_STORE_KILLED_MGS');
