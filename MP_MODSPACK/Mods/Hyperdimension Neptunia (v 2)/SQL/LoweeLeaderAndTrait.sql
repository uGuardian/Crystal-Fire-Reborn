--*******************************************************************
-- Blanc
--*******************************************************************

INSERT INTO Leaders 
			(Type, 					Description, 			Civilopedia, 						CivilopediaTag, 						ArtDefineTag,				
			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty,
			Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 						PortraitIndex,
			VV_LeaderSceneOverride,			VV_LeaderSceneOverrideFriendly,			VV_LeaderSceneOverrideGuarded,		VV_LeaderSceneOverrideHostile,
			VV_LeaderSceneOverrideAfraid,	VV_LeaderSceneOverrideDenouncing,		VV_LeaderSceneOverrideWar,				VV_LeaderSceneOverrideDefeat)
VALUES		('LEADER_VV_BLANC', 	'TXT_KEY_LEADER_VV_BLANC', 	'TXT_KEY_LEADER_VV_BLANC_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_VV_BLANC', 	'VVBlancScene.xml',
			5, 						4, 						4, 							6, 			6, 				4, 				7, 						7, 				8,
			7, 			5, 				3, 			12, 			'CIV_COLOR_ATLAS_VV_LOWEE', 	1,
			'VVBlancSceneDynamic.dds',	'VVBlancSceneDynamicFriendly.dds',	'VVBlancSceneDynamicGuarded.dds', 'VVBlancSceneDynamicHostile.dds',
			'VVBlancSceneDynamicAfraid.dds',	'VVBlancSceneDynamicDenouncing.dds',	'VVBlancSceneDynamicWar.dds', 'VVBlancSceneDynamicDefeat.dds');


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 			MajorCivApproachType, 				Bias)
VALUES		('LEADER_VV_BLANC', 	'MAJOR_CIV_APPROACH_WAR', 			6),
			('LEADER_VV_BLANC', 	'MAJOR_CIV_APPROACH_HOSTILE', 		8),
			('LEADER_VV_BLANC', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	3),
			('LEADER_VV_BLANC', 	'MAJOR_CIV_APPROACH_GUARDED', 		2),
			('LEADER_VV_BLANC', 	'MAJOR_CIV_APPROACH_AFRAID', 		3),
			('LEADER_VV_BLANC', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		8),
			('LEADER_VV_BLANC', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		5);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 			MinorCivApproachType, 				Bias)
VALUES		('LEADER_VV_BLANC', 	'MINOR_CIV_APPROACH_IGNORE', 		2),
			('LEADER_VV_BLANC', 	'MINOR_CIV_APPROACH_FRIENDLY', 		7),
			('LEADER_VV_BLANC', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	5),
			('LEADER_VV_BLANC', 	'MINOR_CIV_APPROACH_CONQUEST', 		3),
			('LEADER_VV_BLANC', 	'MINOR_CIV_APPROACH_BULLY', 		4);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 			FlavorType, 						Flavor)
VALUES		('LEADER_VV_BLANC', 	'FLAVOR_OFFENSE', 					7),
			('LEADER_VV_BLANC', 	'FLAVOR_DEFENSE', 					3),
			('LEADER_VV_BLANC', 	'FLAVOR_CITY_DEFENSE', 				5),
			('LEADER_VV_BLANC', 	'FLAVOR_MILITARY_TRAINING', 		4),
			('LEADER_VV_BLANC', 	'FLAVOR_RECON', 					4),
			('LEADER_VV_BLANC', 	'FLAVOR_RANGED', 					6),
			('LEADER_VV_BLANC', 	'FLAVOR_MOBILE', 					5),
			('LEADER_VV_BLANC', 	'FLAVOR_NAVAL', 					6),
			('LEADER_VV_BLANC', 	'FLAVOR_NAVAL_RECON', 				4),
			('LEADER_VV_BLANC', 	'FLAVOR_NAVAL_GROWTH', 				6),
			('LEADER_VV_BLANC', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
			('LEADER_VV_BLANC', 	'FLAVOR_AIR', 						6),
			('LEADER_VV_BLANC', 	'FLAVOR_EXPANSION', 				7),
			('LEADER_VV_BLANC', 	'FLAVOR_GROWTH', 					5),
			('LEADER_VV_BLANC', 	'FLAVOR_TILE_IMPROVEMENT', 			8),
			('LEADER_VV_BLANC', 	'FLAVOR_INFRASTRUCTURE', 			4),
			('LEADER_VV_BLANC', 	'FLAVOR_PRODUCTION', 				5),
			('LEADER_VV_BLANC', 	'FLAVOR_GOLD', 						5),
			('LEADER_VV_BLANC', 	'FLAVOR_SCIENCE', 					4),
			('LEADER_VV_BLANC', 	'FLAVOR_CULTURE', 					8),
			('LEADER_VV_BLANC', 	'FLAVOR_HAPPINESS', 				7),
			('LEADER_VV_BLANC', 	'FLAVOR_GREAT_PEOPLE', 				6),
			('LEADER_VV_BLANC', 	'FLAVOR_WONDER', 					6),
			('LEADER_VV_BLANC', 	'FLAVOR_RELIGION', 					7),
			('LEADER_VV_BLANC', 	'FLAVOR_DIPLOMACY', 				3),
			('LEADER_VV_BLANC', 	'FLAVOR_SPACESHIP', 				6),
			('LEADER_VV_BLANC', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_VV_BLANC', 	'FLAVOR_NUKE', 						6),
			('LEADER_VV_BLANC', 	'FLAVOR_USE_NUKE', 					8),
			('LEADER_VV_BLANC', 	'FLAVOR_ESPIONAGE', 				4),
			('LEADER_VV_BLANC', 	'FLAVOR_ANTIAIR',	 				6),
			('LEADER_VV_BLANC', 	'FLAVOR_AIR_CARRIER', 				5),
			('LEADER_VV_BLANC', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_VV_BLANC', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_VV_BLANC', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_VV_BLANC', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_VV_BLANC', 	'FLAVOR_ARCHAEOLOGY', 				7),
			('LEADER_VV_BLANC', 	'FLAVOR_AIRLIFT', 					5);


--*******************************************************************
-- Trait Definition (Land of White Serenity) 
--*******************************************************************
INSERT INTO Traits
			(Type,				Description,				ShortDescription)
VALUES		('TRAIT_VV_BLANC',	'TXT_KEY_TRAIT_VV_BLANC',	'TXT_KEY_TRAIT_VV_BLANC_SHORT');

INSERT INTO Trait_VV_Shares_Terrain
			(TraitType,			TerrainType,		Shares)
VALUES		('TRAIT_VV_BLANC',	'TERRAIN_TUNDRA',	1),
			('TRAIT_VV_BLANC',	'TERRAIN_SNOW',		2);


--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 			TraitType)
VALUES		('LEADER_VV_BLANC', 	'TRAIT_VV_BLANC');




------------------------------------------------------------------------------------------------------------------------------------------------------------


--*******************************************************************
-- White Heart
--*******************************************************************

INSERT INTO Leaders 
			(Type, 						Description, 						Civilopedia, 						CivilopediaTag, 						ArtDefineTag,				
			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty,
			Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 						PortraitIndex,
			VV_LeaderSceneOverride,			VV_LeaderSceneOverrideFriendly,			VV_LeaderSceneOverrideGuarded,		VV_LeaderSceneOverrideHostile,
			VV_LeaderSceneOverrideAfraid,	VV_LeaderSceneOverrideDenouncing,		VV_LeaderSceneOverrideWar,				VV_LeaderSceneOverrideDefeat)
VALUES		('LEADER_VV_WHITE_HEART', 	'TXT_KEY_LEADER_VV_WHITE_HEART', 	'TXT_KEY_LEADER_VV_BLANC_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_VV_BLANC', 	'VVWhiteHeartScene.xml',
			5, 						4, 						4, 							9, 			4, 				3, 				8, 						3, 				7,
			6, 			3, 				6, 			12, 		'CIV_COLOR_ATLAS_VV_LOWEE', 	2,
			'VVWhiteHeartSceneDynamic.dds',	'VVWhiteHeartSceneDynamicFriendly.dds',	'VVWhiteHeartSceneDynamicGuarded.dds', 'VVWhiteHeartSceneDynamicHostile.dds',
			'VVWhiteHeartSceneDynamicAfraid.dds',	'VVWhiteHeartSceneDynamicDenouncing.dds',	'VVWhiteHeartSceneDynamicWar.dds', 'VVWhiteHeartSceneDynamicDefeat.dds');


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 				MajorCivApproachType, 				Bias)
VALUES		('LEADER_VV_WHITE_HEART', 	'MAJOR_CIV_APPROACH_WAR', 			9),
			('LEADER_VV_WHITE_HEART', 	'MAJOR_CIV_APPROACH_HOSTILE', 		8),
			('LEADER_VV_WHITE_HEART', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	2),
			('LEADER_VV_WHITE_HEART', 	'MAJOR_CIV_APPROACH_GUARDED', 		2),
			('LEADER_VV_WHITE_HEART', 	'MAJOR_CIV_APPROACH_AFRAID', 		2),
			('LEADER_VV_WHITE_HEART', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		6),
			('LEADER_VV_WHITE_HEART', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		3);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 				MinorCivApproachType, 				Bias)
VALUES		('LEADER_VV_WHITE_HEART', 	'MINOR_CIV_APPROACH_IGNORE', 		2),
			('LEADER_VV_WHITE_HEART', 	'MINOR_CIV_APPROACH_FRIENDLY', 		5),
			('LEADER_VV_WHITE_HEART', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	4),
			('LEADER_VV_WHITE_HEART', 	'MINOR_CIV_APPROACH_CONQUEST', 		5),
			('LEADER_VV_WHITE_HEART', 	'MINOR_CIV_APPROACH_BULLY', 		6);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 				FlavorType, 						Flavor)
VALUES		('LEADER_VV_WHITE_HEART', 	'FLAVOR_OFFENSE', 					7),
			('LEADER_VV_WHITE_HEART', 	'FLAVOR_DEFENSE', 					3),
			('LEADER_VV_WHITE_HEART', 	'FLAVOR_CITY_DEFENSE', 				5),
			('LEADER_VV_WHITE_HEART', 	'FLAVOR_MILITARY_TRAINING', 		4),
			('LEADER_VV_WHITE_HEART', 	'FLAVOR_RECON', 					4),
			('LEADER_VV_WHITE_HEART', 	'FLAVOR_RANGED', 					6),
			('LEADER_VV_WHITE_HEART', 	'FLAVOR_MOBILE', 					5),
			('LEADER_VV_WHITE_HEART', 	'FLAVOR_NAVAL', 					6),
			('LEADER_VV_WHITE_HEART', 	'FLAVOR_NAVAL_RECON', 				4),
			('LEADER_VV_WHITE_HEART', 	'FLAVOR_NAVAL_GROWTH', 				6),
			('LEADER_VV_WHITE_HEART', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
			('LEADER_VV_WHITE_HEART', 	'FLAVOR_AIR', 						6),
			('LEADER_VV_WHITE_HEART', 	'FLAVOR_EXPANSION', 				7),
			('LEADER_VV_WHITE_HEART', 	'FLAVOR_GROWTH', 					5),
			('LEADER_VV_WHITE_HEART', 	'FLAVOR_TILE_IMPROVEMENT', 			8),
			('LEADER_VV_WHITE_HEART', 	'FLAVOR_INFRASTRUCTURE', 			4),
			('LEADER_VV_WHITE_HEART', 	'FLAVOR_PRODUCTION', 				5),
			('LEADER_VV_WHITE_HEART', 	'FLAVOR_GOLD', 						5),
			('LEADER_VV_WHITE_HEART', 	'FLAVOR_SCIENCE', 					4),
			('LEADER_VV_WHITE_HEART', 	'FLAVOR_CULTURE', 					8),
			('LEADER_VV_WHITE_HEART', 	'FLAVOR_HAPPINESS', 				7),
			('LEADER_VV_WHITE_HEART', 	'FLAVOR_GREAT_PEOPLE', 				6),
			('LEADER_VV_WHITE_HEART', 	'FLAVOR_WONDER', 					6),
			('LEADER_VV_WHITE_HEART', 	'FLAVOR_RELIGION', 					7),
			('LEADER_VV_WHITE_HEART', 	'FLAVOR_DIPLOMACY', 				3),
			('LEADER_VV_WHITE_HEART', 	'FLAVOR_SPACESHIP', 				6),
			('LEADER_VV_WHITE_HEART', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_VV_WHITE_HEART', 	'FLAVOR_NUKE', 						6),
			('LEADER_VV_WHITE_HEART', 	'FLAVOR_USE_NUKE', 					8),
			('LEADER_VV_WHITE_HEART', 	'FLAVOR_ESPIONAGE', 				4),
			('LEADER_VV_WHITE_HEART', 	'FLAVOR_ANTIAIR',	 				6),
			('LEADER_VV_WHITE_HEART', 	'FLAVOR_AIR_CARRIER', 				5),
			('LEADER_VV_WHITE_HEART', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_VV_WHITE_HEART', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_VV_WHITE_HEART', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_VV_WHITE_HEART', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_VV_WHITE_HEART', 	'FLAVOR_ARCHAEOLOGY', 				7),
			('LEADER_VV_WHITE_HEART', 	'FLAVOR_AIRLIFT', 					5);


--*******************************************************************
-- Trait Definition (White Heart's Wrath) 
--*******************************************************************
INSERT INTO Traits
			(Type,						Description,					ShortDescription)
VALUES		('TRAIT_VV_WHITE_HEART',	'TXT_KEY_TRAIT_VV_WHITE_HEART',	'TXT_KEY_TRAIT_VV_WHITE_HEART_SHORT');



--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 				TraitType)
VALUES		('LEADER_VV_WHITE_HEART', 	'TRAIT_VV_WHITE_HEART');


--HDD Setup
INSERT INTO Trait_VV_HDDModes
			(NormalTraitType,		HDDTraitType,		NormalDummyPolicy,		HDDDummyPolicy,	
			ScriptName)
VALUES		('TRAIT_VV_BLANC',	'TRAIT_VV_WHITE_HEART',	'POLICY_VV_BLANC_DUMMY', 'POLICY_VV_WHITE_HEART_DUMMY',
			'BlancWhiteHeartTraitScript.lua');





--*********************************************************************************************************************************
-- ULTRADIMENSION BLANC
--*********************************************************************************************************************************

INSERT INTO Leaders 
			(Type, 					Description, 			Civilopedia, 						CivilopediaTag, 						ArtDefineTag,				
			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty,
			Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 						PortraitIndex,
			VV_LeaderSceneOverride,			VV_LeaderSceneOverrideFriendly,			VV_LeaderSceneOverrideGuarded,		VV_LeaderSceneOverrideHostile,
			VV_LeaderSceneOverrideAfraid,	VV_LeaderSceneOverrideDenouncing,		VV_LeaderSceneOverrideWar,				VV_LeaderSceneOverrideDefeat)
VALUES		('LEADER_VV_BLANC_ULTRA', 	'TXT_KEY_LEADER_VV_BLANC', 	'TXT_KEY_LEADER_VV_BLANC_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_VV_BLANC', 	'VVBlancScene.xml',
			6, 						4, 						4, 							7, 			6, 				4, 				8, 						5, 				9,
			7, 			4, 				3, 			12, 			'CIV_COLOR_ATLAS_VV_LOWEE_ULTRA', 	1,
			'VVBlancSceneDynamicUltra.dds',	'VVBlancSceneDynamicFriendlyUltra.dds',	'VVBlancSceneDynamicGuardedUltra.dds', 'VVBlancSceneDynamicHostileUltra.dds',
			'VVBlancSceneDynamicAfraidUltra.dds',	'VVBlancSceneDynamicDenouncingUltra.dds',	'VVBlancSceneDynamicWarUltra.dds', 'VVBlancSceneDynamicDefeatUltra.dds');


--UD Blanc is less friendly and a bit less focused on culture.


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 			MajorCivApproachType, 				Bias)
VALUES		('LEADER_VV_BLANC_ULTRA', 	'MAJOR_CIV_APPROACH_WAR', 			7),
			('LEADER_VV_BLANC_ULTRA', 	'MAJOR_CIV_APPROACH_HOSTILE', 		9),
			('LEADER_VV_BLANC_ULTRA', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	2),
			('LEADER_VV_BLANC_ULTRA', 	'MAJOR_CIV_APPROACH_GUARDED', 		2),
			('LEADER_VV_BLANC_ULTRA', 	'MAJOR_CIV_APPROACH_AFRAID', 		4),
			('LEADER_VV_BLANC_ULTRA', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		7),
			('LEADER_VV_BLANC_ULTRA', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		6);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 			MinorCivApproachType, 				Bias)
VALUES		('LEADER_VV_BLANC_ULTRA', 	'MINOR_CIV_APPROACH_IGNORE', 		3),
			('LEADER_VV_BLANC_ULTRA', 	'MINOR_CIV_APPROACH_FRIENDLY', 		4),
			('LEADER_VV_BLANC_ULTRA', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	4),
			('LEADER_VV_BLANC_ULTRA', 	'MINOR_CIV_APPROACH_CONQUEST', 		5),
			('LEADER_VV_BLANC_ULTRA', 	'MINOR_CIV_APPROACH_BULLY', 		5);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 				FlavorType, 						Flavor)
VALUES		('LEADER_VV_BLANC_ULTRA', 	'FLAVOR_OFFENSE', 					8),
			('LEADER_VV_BLANC_ULTRA', 	'FLAVOR_DEFENSE', 					3),
			('LEADER_VV_BLANC_ULTRA', 	'FLAVOR_CITY_DEFENSE', 				5),
			('LEADER_VV_BLANC_ULTRA', 	'FLAVOR_MILITARY_TRAINING', 		4),
			('LEADER_VV_BLANC_ULTRA', 	'FLAVOR_RECON', 					4),
			('LEADER_VV_BLANC_ULTRA', 	'FLAVOR_RANGED', 					6),
			('LEADER_VV_BLANC_ULTRA', 	'FLAVOR_MOBILE', 					5),
			('LEADER_VV_BLANC_ULTRA', 	'FLAVOR_NAVAL', 					6),
			('LEADER_VV_BLANC_ULTRA', 	'FLAVOR_NAVAL_RECON', 				4),
			('LEADER_VV_BLANC_ULTRA', 	'FLAVOR_NAVAL_GROWTH', 				6),
			('LEADER_VV_BLANC_ULTRA', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
			('LEADER_VV_BLANC_ULTRA', 	'FLAVOR_AIR', 						6),
			('LEADER_VV_BLANC_ULTRA', 	'FLAVOR_EXPANSION', 				8),
			('LEADER_VV_BLANC_ULTRA', 	'FLAVOR_GROWTH', 					5),
			('LEADER_VV_BLANC_ULTRA', 	'FLAVOR_TILE_IMPROVEMENT', 			8),
			('LEADER_VV_BLANC_ULTRA', 	'FLAVOR_INFRASTRUCTURE', 			5),
			('LEADER_VV_BLANC_ULTRA', 	'FLAVOR_PRODUCTION', 				6),
			('LEADER_VV_BLANC_ULTRA', 	'FLAVOR_GOLD', 						6),
			('LEADER_VV_BLANC_ULTRA', 	'FLAVOR_SCIENCE', 					7),
			('LEADER_VV_BLANC_ULTRA', 	'FLAVOR_CULTURE', 					7),
			('LEADER_VV_BLANC_ULTRA', 	'FLAVOR_HAPPINESS', 				4),
			('LEADER_VV_BLANC_ULTRA', 	'FLAVOR_GREAT_PEOPLE', 				4),
			('LEADER_VV_BLANC_ULTRA', 	'FLAVOR_WONDER', 					4),
			('LEADER_VV_BLANC_ULTRA', 	'FLAVOR_RELIGION', 					8),
			('LEADER_VV_BLANC_ULTRA', 	'FLAVOR_DIPLOMACY', 				3),
			('LEADER_VV_BLANC_ULTRA', 	'FLAVOR_SPACESHIP', 				6),
			('LEADER_VV_BLANC_ULTRA', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_VV_BLANC_ULTRA', 	'FLAVOR_NUKE', 						6),
			('LEADER_VV_BLANC_ULTRA', 	'FLAVOR_USE_NUKE', 					8),
			('LEADER_VV_BLANC_ULTRA', 	'FLAVOR_ESPIONAGE', 				4),
			('LEADER_VV_BLANC_ULTRA', 	'FLAVOR_ANTIAIR',	 				6),
			('LEADER_VV_BLANC_ULTRA', 	'FLAVOR_AIR_CARRIER', 				5),
			('LEADER_VV_BLANC_ULTRA', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_VV_BLANC_ULTRA', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_VV_BLANC_ULTRA', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_VV_BLANC_ULTRA', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_VV_BLANC_ULTRA', 	'FLAVOR_ARCHAEOLOGY', 				7),
			('LEADER_VV_BLANC_ULTRA', 	'FLAVOR_AIRLIFT', 					5);


--*******************************************************************
-- Trait Definition (Land of White Serenity) 
--*******************************************************************
INSERT INTO Traits
			(Type,						Description,				ShortDescription)
VALUES		('TRAIT_VV_BLANC_ULTRA',	'TXT_KEY_TRAIT_VV_BLANC',	'TXT_KEY_TRAIT_VV_BLANC_SHORT');

INSERT INTO Trait_VV_Shares_Terrain
			(TraitType,					TerrainType,		Shares)
VALUES		('TRAIT_VV_BLANC_ULTRA',	'TERRAIN_TUNDRA',	1),
			('TRAIT_VV_BLANC_ULTRA',	'TERRAIN_SNOW',		2);


--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 				TraitType)
VALUES		('LEADER_VV_BLANC_ULTRA', 	'TRAIT_VV_BLANC_ULTRA');




------------------------------------------------------------------------------------------------------------------------------------------------------------


--*******************************************************************
-- White Heart
--*******************************************************************

INSERT INTO Leaders 
			(Type, 						Description, 						Civilopedia, 						CivilopediaTag, 						ArtDefineTag,				
			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty,
			Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 						PortraitIndex,
			VV_LeaderSceneOverride,			VV_LeaderSceneOverrideFriendly,			VV_LeaderSceneOverrideGuarded,		VV_LeaderSceneOverrideHostile,
			VV_LeaderSceneOverrideAfraid,	VV_LeaderSceneOverrideDenouncing,		VV_LeaderSceneOverrideWar,				VV_LeaderSceneOverrideDefeat)
VALUES		('LEADER_VV_WHITE_HEART_ULTRA', 	'TXT_KEY_LEADER_VV_WHITE_HEART', 	'TXT_KEY_LEADER_VV_BLANC_ULTRA_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_VV_BLANC', 	'VVWhiteHeartScene.xml',
			5, 						4, 						4, 							9, 			4, 				3, 				8, 						3, 				7,
			6, 			3, 				6, 			12, 		'CIV_COLOR_ATLAS_VV_LOWEE_ULTRA', 	2,
			'VVWhiteHeartSceneDynamicUltra.dds',	'VVWhiteHeartSceneDynamicFriendlyUltra.dds',	'VVWhiteHeartSceneDynamicGuardedUltra.dds', 'VVWhiteHeartSceneDynamicHostileUltra.dds',
			'VVWhiteHeartSceneDynamicAfraidUltra.dds',	'VVWhiteHeartSceneDynamicDenouncingUltra.dds',	'VVWhiteHeartSceneDynamicWarUltra.dds', 'VVWhiteHeartSceneDynamicDefeatUltra.dds');


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 				MajorCivApproachType, 				Bias)
VALUES		('LEADER_VV_WHITE_HEART_ULTRA', 	'MAJOR_CIV_APPROACH_WAR', 			9),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'MAJOR_CIV_APPROACH_HOSTILE', 		8),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	2),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'MAJOR_CIV_APPROACH_GUARDED', 		2),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'MAJOR_CIV_APPROACH_AFRAID', 		2),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		6),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		3);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 				MinorCivApproachType, 				Bias)
VALUES		('LEADER_VV_WHITE_HEART_ULTRA', 	'MINOR_CIV_APPROACH_IGNORE', 		2),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'MINOR_CIV_APPROACH_FRIENDLY', 		5),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	4),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'MINOR_CIV_APPROACH_CONQUEST', 		5),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'MINOR_CIV_APPROACH_BULLY', 		6);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 				FlavorType, 						Flavor)
VALUES		('LEADER_VV_WHITE_HEART_ULTRA', 	'FLAVOR_OFFENSE', 					7),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'FLAVOR_DEFENSE', 					3),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'FLAVOR_CITY_DEFENSE', 				5),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'FLAVOR_MILITARY_TRAINING', 		4),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'FLAVOR_RECON', 					4),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'FLAVOR_RANGED', 					6),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'FLAVOR_MOBILE', 					5),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'FLAVOR_NAVAL', 					6),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'FLAVOR_NAVAL_RECON', 				4),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'FLAVOR_NAVAL_GROWTH', 				6),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'FLAVOR_AIR', 						6),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'FLAVOR_EXPANSION', 				7),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'FLAVOR_GROWTH', 					5),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'FLAVOR_TILE_IMPROVEMENT', 			8),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'FLAVOR_INFRASTRUCTURE', 			4),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'FLAVOR_PRODUCTION', 				5),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'FLAVOR_GOLD', 						5),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'FLAVOR_SCIENCE', 					4),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'FLAVOR_CULTURE', 					8),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'FLAVOR_HAPPINESS', 				7),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'FLAVOR_GREAT_PEOPLE', 				6),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'FLAVOR_WONDER', 					6),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'FLAVOR_RELIGION', 					7),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'FLAVOR_DIPLOMACY', 				3),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'FLAVOR_SPACESHIP', 				6),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'FLAVOR_NUKE', 						6),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'FLAVOR_USE_NUKE', 					8),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'FLAVOR_ESPIONAGE', 				4),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'FLAVOR_ANTIAIR',	 				6),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'FLAVOR_AIR_CARRIER', 				5),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'FLAVOR_ARCHAEOLOGY', 				7),
			('LEADER_VV_WHITE_HEART_ULTRA', 	'FLAVOR_AIRLIFT', 					5);


--*******************************************************************
-- Trait Definition (White Heart's Wrath) 
--*******************************************************************
INSERT INTO Traits
			(Type,							Description,						ShortDescription)
VALUES		('TRAIT_VV_WHITE_HEART_ULTRA',	'TXT_KEY_TRAIT_VV_WHITE_HEART_U',	'TXT_KEY_TRAIT_VV_WHITE_HEART_SHORT');



--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 						TraitType)
VALUES		('LEADER_VV_WHITE_HEART_ULTRA', 	'TRAIT_VV_WHITE_HEART_ULTRA');


--HDD Setup
INSERT INTO Trait_VV_HDDModes
			(NormalTraitType,			HDDTraitType,					NormalDummyPolicy,			HDDDummyPolicy,	
			ScriptName)
VALUES		('TRAIT_VV_BLANC_ULTRA',	'TRAIT_VV_WHITE_HEART_ULTRA',	'POLICY_VV_BLANC_DUMMY', 'POLICY_VV_WHITE_HEART_U_DUMMY',
			'BlancWhiteHeartTraitScript.lua');