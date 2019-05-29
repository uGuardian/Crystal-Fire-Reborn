--All SQL Leader inserts were based off of SQL code from JFD's Civilizations.

--*******************************************************************
-- Naked Snake
--*******************************************************************

INSERT INTO Leaders 
			(Type, 							Description, 							Civilopedia, 								CivilopediaTag, 									ArtDefineTag,			
			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness,
			Chattiness, Meanness, 	IconAtlas, 					PortraitIndex)
VALUES		('LEADER_BIGBOSS', 	'TXT_KEY_LEADER_BIGBOSS', 	'TXT_KEY_LEADER_BIGBOSS_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_BIGBOSS', 	'BigBossScene.xml',
			7, 						2, 						9, 							9, 			7, 				2, 				4, 						4, 				6, 			3, 			4,
			4, 			6, 			'CIV_COLOR_ATLAS_MSF', 	1);


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 		MajorCivApproachType, 				Bias)
VALUES		('LEADER_BIGBOSS', 	'MAJOR_CIV_APPROACH_WAR', 			9),
			('LEADER_BIGBOSS', 	'MAJOR_CIV_APPROACH_HOSTILE', 		6),
			('LEADER_BIGBOSS', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	6),
			('LEADER_BIGBOSS', 	'MAJOR_CIV_APPROACH_GUARDED', 		8),
			('LEADER_BIGBOSS', 	'MAJOR_CIV_APPROACH_AFRAID', 		2),
			('LEADER_BIGBOSS', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		5),
			('LEADER_BIGBOSS', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		5);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 		MinorCivApproachType, 				Bias)
VALUES		('LEADER_BIGBOSS', 	'MINOR_CIV_APPROACH_IGNORE', 		1),
			('LEADER_BIGBOSS', 	'MINOR_CIV_APPROACH_FRIENDLY', 		8),
			('LEADER_BIGBOSS', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	11),
			('LEADER_BIGBOSS', 	'MINOR_CIV_APPROACH_CONQUEST', 		2),
			('LEADER_BIGBOSS', 	'MINOR_CIV_APPROACH_BULLY', 		3);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 		FlavorType, 						Flavor)
VALUES		('LEADER_BIGBOSS', 	'FLAVOR_OFFENSE', 					8),
			('LEADER_BIGBOSS', 	'FLAVOR_DEFENSE', 					6),
			('LEADER_BIGBOSS', 	'FLAVOR_CITY_DEFENSE', 				4),
			('LEADER_BIGBOSS', 	'FLAVOR_MILITARY_TRAINING', 		6),
			('LEADER_BIGBOSS', 	'FLAVOR_RECON', 					5),
			('LEADER_BIGBOSS', 	'FLAVOR_RANGED', 					6),
			('LEADER_BIGBOSS', 	'FLAVOR_MOBILE', 					8),
			('LEADER_BIGBOSS', 	'FLAVOR_NAVAL', 					7),
			('LEADER_BIGBOSS', 	'FLAVOR_NAVAL_RECON', 				6),
			('LEADER_BIGBOSS', 	'FLAVOR_NAVAL_GROWTH', 				3),
			('LEADER_BIGBOSS', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	4),
			('LEADER_BIGBOSS', 	'FLAVOR_AIR', 						5),
			('LEADER_BIGBOSS', 	'FLAVOR_EXPANSION', 				9),
			('LEADER_BIGBOSS', 	'FLAVOR_GROWTH', 					7),
			('LEADER_BIGBOSS', 	'FLAVOR_TILE_IMPROVEMENT', 			7),
			('LEADER_BIGBOSS', 	'FLAVOR_INFRASTRUCTURE', 			2),
			('LEADER_BIGBOSS', 	'FLAVOR_PRODUCTION', 				5),
			('LEADER_BIGBOSS', 	'FLAVOR_GOLD', 						8),
			('LEADER_BIGBOSS', 	'FLAVOR_SCIENCE', 					8),
			('LEADER_BIGBOSS', 	'FLAVOR_CULTURE', 					2),
			('LEADER_BIGBOSS', 	'FLAVOR_HAPPINESS', 				3),
			('LEADER_BIGBOSS', 	'FLAVOR_GREAT_PEOPLE', 				2),
			('LEADER_BIGBOSS', 	'FLAVOR_WONDER', 					1),
			('LEADER_BIGBOSS', 	'FLAVOR_RELIGION', 					2),
			('LEADER_BIGBOSS', 	'FLAVOR_DIPLOMACY', 				8),
			('LEADER_BIGBOSS', 	'FLAVOR_SPACESHIP', 				3),
			('LEADER_BIGBOSS', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_BIGBOSS', 	'FLAVOR_NUKE', 						9),
			('LEADER_BIGBOSS', 	'FLAVOR_USE_NUKE', 					3),
			('LEADER_BIGBOSS', 	'FLAVOR_ESPIONAGE', 				10),
			('LEADER_BIGBOSS', 	'FLAVOR_ANTIAIR',	 				6),
			('LEADER_BIGBOSS', 	'FLAVOR_AIR_CARRIER', 				4),
			('LEADER_BIGBOSS', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_BIGBOSS', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_BIGBOSS', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_BIGBOSS', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_BIGBOSS', 	'FLAVOR_ARCHAEOLOGY', 				2),
			('LEADER_BIGBOSS', 	'FLAVOR_AIRLIFT', 					6);


--*******************************************************************
-- Trait Definition (Army Without a Nation)
--*******************************************************************
INSERT INTO Traits
			(Type,							Description,						ShortDescription,								NoAnnexing,	AngerFreeIntrusionOfCityStates,	StaysAliveZeroCities)
VALUES		('TRAIT_MERCENARY_CITY_STATE',	'TXT_KEY_TRAIT_MERCENARY_CITY_STATE',	'TXT_KEY_TRAIT_MERCENARY_CITY_STATE_SHORT',	1,			1,								1);

INSERT INTO Trait_NoTrain
			(TraitType,						UnitClassType)
VALUES		('TRAIT_MERCENARY_CITY_STATE',	'UNITCLASS_SETTLER'),
			('TRAIT_MERCENARY_CITY_STATE',	'UNITCLASS_MECH');

--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 		TraitType)
VALUES		('LEADER_BIGBOSS', 	'TRAIT_MERCENARY_CITY_STATE');







--*******************************************************************
-- Venom Snake
--*******************************************************************

INSERT INTO Leaders 
			(Type, 							Description, 							Civilopedia, 								CivilopediaTag, 									ArtDefineTag,			
			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness,
			Chattiness, Meanness, 	IconAtlas, 					PortraitIndex)
VALUES		('LEADER_VENOM_SNAKE', 	'TXT_KEY_LEADER_VENOM_SNAKE', 	'TXT_KEY_LEADER_VENOM_SNAKE_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_BIGBOSS', 	'VenomSnakeScene.xml',
			7, 						2, 						9, 							10, 			7, 				2, 				4, 						2, 				3, 			3, 			4,
			4, 			6, 			'CIV_COLOR_ATLAS_DIAMOND_DOGS', 	1);


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 		MajorCivApproachType, 				Bias)
VALUES		('LEADER_VENOM_SNAKE', 	'MAJOR_CIV_APPROACH_WAR', 			9),
			('LEADER_VENOM_SNAKE', 	'MAJOR_CIV_APPROACH_HOSTILE', 		9),
			('LEADER_VENOM_SNAKE', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	8),
			('LEADER_VENOM_SNAKE', 	'MAJOR_CIV_APPROACH_GUARDED', 		8),
			('LEADER_VENOM_SNAKE', 	'MAJOR_CIV_APPROACH_AFRAID', 		2),
			('LEADER_VENOM_SNAKE', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		2),
			('LEADER_VENOM_SNAKE', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		4);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 		MinorCivApproachType, 				Bias)
VALUES		('LEADER_VENOM_SNAKE', 	'MINOR_CIV_APPROACH_IGNORE', 		4),
			('LEADER_VENOM_SNAKE', 	'MINOR_CIV_APPROACH_FRIENDLY', 		4),
			('LEADER_VENOM_SNAKE', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	5),
			('LEADER_VENOM_SNAKE', 	'MINOR_CIV_APPROACH_CONQUEST', 		6),
			('LEADER_VENOM_SNAKE', 	'MINOR_CIV_APPROACH_BULLY', 		8);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 		FlavorType, 						Flavor)
VALUES		('LEADER_VENOM_SNAKE', 	'FLAVOR_OFFENSE', 					8),
			('LEADER_VENOM_SNAKE', 	'FLAVOR_DEFENSE', 					6),
			('LEADER_VENOM_SNAKE', 	'FLAVOR_CITY_DEFENSE', 				4),
			('LEADER_VENOM_SNAKE', 	'FLAVOR_MILITARY_TRAINING', 		6),
			('LEADER_VENOM_SNAKE', 	'FLAVOR_RECON', 					5),
			('LEADER_VENOM_SNAKE', 	'FLAVOR_RANGED', 					6),
			('LEADER_VENOM_SNAKE', 	'FLAVOR_MOBILE', 					8),
			('LEADER_VENOM_SNAKE', 	'FLAVOR_NAVAL', 					7),
			('LEADER_VENOM_SNAKE', 	'FLAVOR_NAVAL_RECON', 				6),
			('LEADER_VENOM_SNAKE', 	'FLAVOR_NAVAL_GROWTH', 				3),
			('LEADER_VENOM_SNAKE', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	4),
			('LEADER_VENOM_SNAKE', 	'FLAVOR_AIR', 						5),
			('LEADER_VENOM_SNAKE', 	'FLAVOR_EXPANSION', 				9),
			('LEADER_VENOM_SNAKE', 	'FLAVOR_GROWTH', 					7),
			('LEADER_VENOM_SNAKE', 	'FLAVOR_TILE_IMPROVEMENT', 			7),
			('LEADER_VENOM_SNAKE', 	'FLAVOR_INFRASTRUCTURE', 			2),
			('LEADER_VENOM_SNAKE', 	'FLAVOR_PRODUCTION', 				5),
			('LEADER_VENOM_SNAKE', 	'FLAVOR_GOLD', 						8),
			('LEADER_VENOM_SNAKE', 	'FLAVOR_SCIENCE', 					8),
			('LEADER_VENOM_SNAKE', 	'FLAVOR_CULTURE', 					2),
			('LEADER_VENOM_SNAKE', 	'FLAVOR_HAPPINESS', 				3),
			('LEADER_VENOM_SNAKE', 	'FLAVOR_GREAT_PEOPLE', 				2),
			('LEADER_VENOM_SNAKE', 	'FLAVOR_WONDER', 					1),
			('LEADER_VENOM_SNAKE', 	'FLAVOR_RELIGION', 					2),
			('LEADER_VENOM_SNAKE', 	'FLAVOR_DIPLOMACY', 				8),
			('LEADER_VENOM_SNAKE', 	'FLAVOR_SPACESHIP', 				3),
			('LEADER_VENOM_SNAKE', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_VENOM_SNAKE', 	'FLAVOR_NUKE', 						9),
			('LEADER_VENOM_SNAKE', 	'FLAVOR_USE_NUKE', 					3),
			('LEADER_VENOM_SNAKE', 	'FLAVOR_ESPIONAGE', 				10),
			('LEADER_VENOM_SNAKE', 	'FLAVOR_ANTIAIR',	 				6),
			('LEADER_VENOM_SNAKE', 	'FLAVOR_AIR_CARRIER', 				4),
			('LEADER_VENOM_SNAKE', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_VENOM_SNAKE', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_VENOM_SNAKE', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_VENOM_SNAKE', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_VENOM_SNAKE', 	'FLAVOR_ARCHAEOLOGY', 				2),
			('LEADER_VENOM_SNAKE', 	'FLAVOR_AIRLIFT', 					6);


--*******************************************************************
-- Trait Definition (Only For Revenge)
--*******************************************************************
INSERT INTO Traits
			(Type,							Description,							ShortDescription,								NoAnnexing,	StaysAliveZeroCities)
VALUES		('TRAIT_ALL_YIELDS_FROM_KILLS',	'TXT_KEY_TRAIT_ALL_YIELDS_FROM_KILLS',	'TXT_KEY_TRAIT_ALL_YIELDS_FROM_KILLS_SHORT',	1,			1);

INSERT INTO Trait_NoTrain
			(TraitType,						UnitClassType)
VALUES		('TRAIT_ALL_YIELDS_FROM_KILLS',	'UNITCLASS_SETTLER'),
			('TRAIT_ALL_YIELDS_FROM_KILLS',	'UNITCLASS_MECH');

--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 		TraitType)
VALUES		('LEADER_VENOM_SNAKE', 	'TRAIT_ALL_YIELDS_FROM_KILLS');







--*******************************************************************
-- Big Boss
--*******************************************************************

INSERT INTO Leaders 
			(Type, 							Description, 							Civilopedia, 								CivilopediaTag, 									ArtDefineTag,			
			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness,
			Chattiness, Meanness, 	IconAtlas, 					PortraitIndex)
VALUES		('LEADER_BIGBOSS_OH', 	'TXT_KEY_LEADER_BIGBOSS_OH', 	'TXT_KEY_LEADER_BIGBOSS_OH_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_BIGBOSS', 	'BigBossOHScene.xml',
			7, 						2, 						9, 							10, 			7, 				2, 				4, 						2, 				3, 			3, 			4,
			4, 			6, 			'CIV_COLOR_ATLAS_BB_OUTER_HEAVEN', 	1);


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 		MajorCivApproachType, 				Bias)
VALUES		('LEADER_BIGBOSS_OH', 	'MAJOR_CIV_APPROACH_WAR', 			9),
			('LEADER_BIGBOSS_OH', 	'MAJOR_CIV_APPROACH_HOSTILE', 		9),
			('LEADER_BIGBOSS_OH', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	8),
			('LEADER_BIGBOSS_OH', 	'MAJOR_CIV_APPROACH_GUARDED', 		8),
			('LEADER_BIGBOSS_OH', 	'MAJOR_CIV_APPROACH_AFRAID', 		2),
			('LEADER_BIGBOSS_OH', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		2),
			('LEADER_BIGBOSS_OH', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		4);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 		MinorCivApproachType, 				Bias)
VALUES		('LEADER_BIGBOSS_OH', 	'MINOR_CIV_APPROACH_IGNORE', 		4),
			('LEADER_BIGBOSS_OH', 	'MINOR_CIV_APPROACH_FRIENDLY', 		4),
			('LEADER_BIGBOSS_OH', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	5),
			('LEADER_BIGBOSS_OH', 	'MINOR_CIV_APPROACH_CONQUEST', 		6),
			('LEADER_BIGBOSS_OH', 	'MINOR_CIV_APPROACH_BULLY', 		8);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 		FlavorType, 						Flavor)
VALUES		('LEADER_BIGBOSS_OH', 	'FLAVOR_OFFENSE', 					8),
			('LEADER_BIGBOSS_OH', 	'FLAVOR_DEFENSE', 					6),
			('LEADER_BIGBOSS_OH', 	'FLAVOR_CITY_DEFENSE', 				4),
			('LEADER_BIGBOSS_OH', 	'FLAVOR_MILITARY_TRAINING', 		6),
			('LEADER_BIGBOSS_OH', 	'FLAVOR_RECON', 					5),
			('LEADER_BIGBOSS_OH', 	'FLAVOR_RANGED', 					6),
			('LEADER_BIGBOSS_OH', 	'FLAVOR_MOBILE', 					8),
			('LEADER_BIGBOSS_OH', 	'FLAVOR_NAVAL', 					7),
			('LEADER_BIGBOSS_OH', 	'FLAVOR_NAVAL_RECON', 				6),
			('LEADER_BIGBOSS_OH', 	'FLAVOR_NAVAL_GROWTH', 				3),
			('LEADER_BIGBOSS_OH', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	4),
			('LEADER_BIGBOSS_OH', 	'FLAVOR_AIR', 						5),
			('LEADER_BIGBOSS_OH', 	'FLAVOR_EXPANSION', 				9),
			('LEADER_BIGBOSS_OH', 	'FLAVOR_GROWTH', 					7),
			('LEADER_BIGBOSS_OH', 	'FLAVOR_TILE_IMPROVEMENT', 			7),
			('LEADER_BIGBOSS_OH', 	'FLAVOR_INFRASTRUCTURE', 			2),
			('LEADER_BIGBOSS_OH', 	'FLAVOR_PRODUCTION', 				5),
			('LEADER_BIGBOSS_OH', 	'FLAVOR_GOLD', 						8),
			('LEADER_BIGBOSS_OH', 	'FLAVOR_SCIENCE', 					8),
			('LEADER_BIGBOSS_OH', 	'FLAVOR_CULTURE', 					2),
			('LEADER_BIGBOSS_OH', 	'FLAVOR_HAPPINESS', 				3),
			('LEADER_BIGBOSS_OH', 	'FLAVOR_GREAT_PEOPLE', 				2),
			('LEADER_BIGBOSS_OH', 	'FLAVOR_WONDER', 					1),
			('LEADER_BIGBOSS_OH', 	'FLAVOR_RELIGION', 					2),
			('LEADER_BIGBOSS_OH', 	'FLAVOR_DIPLOMACY', 				8),
			('LEADER_BIGBOSS_OH', 	'FLAVOR_SPACESHIP', 				3),
			('LEADER_BIGBOSS_OH', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_BIGBOSS_OH', 	'FLAVOR_NUKE', 						9),
			('LEADER_BIGBOSS_OH', 	'FLAVOR_USE_NUKE', 					3),
			('LEADER_BIGBOSS_OH', 	'FLAVOR_ESPIONAGE', 				10),
			('LEADER_BIGBOSS_OH', 	'FLAVOR_ANTIAIR',	 				6),
			('LEADER_BIGBOSS_OH', 	'FLAVOR_AIR_CARRIER', 				4),
			('LEADER_BIGBOSS_OH', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_BIGBOSS_OH', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_BIGBOSS_OH', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_BIGBOSS_OH', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_BIGBOSS_OH', 	'FLAVOR_ARCHAEOLOGY', 				2),
			('LEADER_BIGBOSS_OH', 	'FLAVOR_AIRLIFT', 					6);


--*******************************************************************
-- Trait Definition (Fortress Nation)
--*******************************************************************
INSERT INTO Traits
			(Type,							Description,							ShortDescription,							NoAnnexing)
VALUES		('TRAIT_ALL_UNIT_COMBAT_BONUS',	'TXT_KEY_TRAIT_ALL_UNIT_COMBAT_BONUS',	'TXT_KEY_TRAIT_ALL_UNIT_COMBAT_BONUS_SHORT',1);

INSERT INTO Trait_NoTrain
			(TraitType,						UnitClassType)
VALUES		('TRAIT_ALL_UNIT_COMBAT_BONUS',	'UNITCLASS_SETTLER'),
			('TRAIT_ALL_UNIT_COMBAT_BONUS',	'UNITCLASS_MECH');

INSERT INTO Trait_FreePromotionUnitCombats
			(TraitType,						UnitCombatType,	PromotionType)
SELECT		('TRAIT_ALL_UNIT_COMBAT_BONUS'),UnitCombatType,	('PROMOTION_BB_OUTER_HEAVEN')
FROM UnitPromotions_UnitCombats WHERE PromotionType = 'PROMOTION_INSTA_HEAL';

--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 			TraitType)
VALUES		('LEADER_BIGBOSS_OH', 	'TRAIT_ALL_UNIT_COMBAT_BONUS');