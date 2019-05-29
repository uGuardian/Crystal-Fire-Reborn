--*******************************************************************
-- Vert
--*******************************************************************

INSERT INTO Leaders 
			(Type, 					Description, 			Civilopedia, 						CivilopediaTag, 						ArtDefineTag,				
			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty,
			Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 						PortraitIndex,
			VV_LeaderSceneOverride,			VV_LeaderSceneOverrideFriendly,			VV_LeaderSceneOverrideGuarded,		VV_LeaderSceneOverrideHostile,
			VV_LeaderSceneOverrideAfraid,	VV_LeaderSceneOverrideDenouncing,		VV_LeaderSceneOverrideWar,				VV_LeaderSceneOverrideDefeat)
VALUES		('LEADER_VV_VERT', 	'TXT_KEY_LEADER_VV_VERT', 	'TXT_KEY_LEADER_VV_VERT_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_VV_VERT', 	'VVVertScene.xml',
			3, 						6, 						4, 							3, 			6, 				5, 				5, 						8, 				6,
			7, 			5, 				8, 			7, 			'CIV_COLOR_ATLAS_VV_LEANBOX', 	1,
			'VVVertSceneDynamic.dds',	'VVVertSceneDynamicFriendly.dds',	'VVVertSceneDynamicGuarded.dds', 'VVVertSceneDynamicHostile.dds',
			'VVVertSceneDynamicAfraid.dds',	'VVVertSceneDynamicDenouncing.dds',	'VVVertSceneDynamicWar.dds', 'VVVertSceneDynamicDefeat.dds');


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 		MajorCivApproachType, 				Bias)
VALUES		('LEADER_VV_VERT', 	'MAJOR_CIV_APPROACH_WAR', 			3),
			('LEADER_VV_VERT', 	'MAJOR_CIV_APPROACH_HOSTILE', 		3),
			('LEADER_VV_VERT', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	4),
			('LEADER_VV_VERT', 	'MAJOR_CIV_APPROACH_GUARDED', 		6),
			('LEADER_VV_VERT', 	'MAJOR_CIV_APPROACH_AFRAID', 		4),
			('LEADER_VV_VERT', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		8),
			('LEADER_VV_VERT', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		8);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 		MinorCivApproachType, 				Bias)
VALUES		('LEADER_VV_VERT', 	'MINOR_CIV_APPROACH_IGNORE', 		3),
			('LEADER_VV_VERT', 	'MINOR_CIV_APPROACH_FRIENDLY', 		7),
			('LEADER_VV_VERT', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	5),
			('LEADER_VV_VERT', 	'MINOR_CIV_APPROACH_CONQUEST', 		2),
			('LEADER_VV_VERT', 	'MINOR_CIV_APPROACH_BULLY', 		3);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 		FlavorType, 						Flavor)
VALUES		('LEADER_VV_VERT', 	'FLAVOR_OFFENSE', 					3),
			('LEADER_VV_VERT', 	'FLAVOR_DEFENSE', 					6),
			('LEADER_VV_VERT', 	'FLAVOR_CITY_DEFENSE', 				8),
			('LEADER_VV_VERT', 	'FLAVOR_MILITARY_TRAINING', 		4),
			('LEADER_VV_VERT', 	'FLAVOR_RECON', 					5),
			('LEADER_VV_VERT', 	'FLAVOR_RANGED', 					7),
			('LEADER_VV_VERT', 	'FLAVOR_MOBILE', 					3),
			('LEADER_VV_VERT', 	'FLAVOR_NAVAL', 					5),
			('LEADER_VV_VERT', 	'FLAVOR_NAVAL_RECON', 				4),
			('LEADER_VV_VERT', 	'FLAVOR_NAVAL_GROWTH', 				5),
			('LEADER_VV_VERT', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
			('LEADER_VV_VERT', 	'FLAVOR_AIR', 						6),
			('LEADER_VV_VERT', 	'FLAVOR_EXPANSION', 				4),
			('LEADER_VV_VERT', 	'FLAVOR_GROWTH', 					7),
			('LEADER_VV_VERT', 	'FLAVOR_TILE_IMPROVEMENT', 			8),
			('LEADER_VV_VERT', 	'FLAVOR_INFRASTRUCTURE', 			6),
			('LEADER_VV_VERT', 	'FLAVOR_PRODUCTION', 				4),
			('LEADER_VV_VERT', 	'FLAVOR_GOLD', 						3),
			('LEADER_VV_VERT', 	'FLAVOR_SCIENCE', 					6),
			('LEADER_VV_VERT', 	'FLAVOR_CULTURE', 					8),
			('LEADER_VV_VERT', 	'FLAVOR_HAPPINESS', 				6),
			('LEADER_VV_VERT', 	'FLAVOR_GREAT_PEOPLE', 				7),
			('LEADER_VV_VERT', 	'FLAVOR_WONDER', 					6),
			('LEADER_VV_VERT', 	'FLAVOR_RELIGION', 					7),
			('LEADER_VV_VERT', 	'FLAVOR_DIPLOMACY', 				7),
			('LEADER_VV_VERT', 	'FLAVOR_SPACESHIP', 				4),
			('LEADER_VV_VERT', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_VV_VERT', 	'FLAVOR_NUKE', 						5),
			('LEADER_VV_VERT', 	'FLAVOR_USE_NUKE', 					2),
			('LEADER_VV_VERT', 	'FLAVOR_ESPIONAGE', 				3),
			('LEADER_VV_VERT', 	'FLAVOR_ANTIAIR',	 				7),
			('LEADER_VV_VERT', 	'FLAVOR_AIR_CARRIER', 				5),
			('LEADER_VV_VERT', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_VV_VERT', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_VV_VERT', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_VV_VERT', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_VV_VERT', 	'FLAVOR_ARCHAEOLOGY', 				7),
			('LEADER_VV_VERT', 	'FLAVOR_AIRLIFT', 					5);


--*******************************************************************
-- Trait Definition (Land of Green Pastures) 
--*******************************************************************
INSERT INTO Traits
			(Type,				Description,				ShortDescription,				VV_Shares_GreatWorks)
VALUES		('TRAIT_VV_VERT',	'TXT_KEY_TRAIT_VV_VERT',	'TXT_KEY_TRAIT_VV_VERT_SHORT',	3);


--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 		TraitType)
VALUES		('LEADER_VV_VERT', 	'TRAIT_VV_VERT');




------------------------------------------------------------------------------------------------------------------------------------------------------------


--*******************************************************************
-- Green Heart
--*******************************************************************

INSERT INTO Leaders 
			(Type, 						Description, 						Civilopedia, 						CivilopediaTag, 						ArtDefineTag,				
			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty,
			Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 						PortraitIndex,
			VV_LeaderSceneOverride,			VV_LeaderSceneOverrideFriendly,			VV_LeaderSceneOverrideGuarded,		VV_LeaderSceneOverrideHostile,
			VV_LeaderSceneOverrideAfraid,	VV_LeaderSceneOverrideDenouncing,		VV_LeaderSceneOverrideWar,				VV_LeaderSceneOverrideDefeat)
VALUES		('LEADER_VV_GREEN_HEART', 	'TXT_KEY_LEADER_VV_GREEN_HEART', 	'TXT_KEY_LEADER_VV_VERT_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_VV_VERT', 	'VVGreenHeartScene.xml',
			3, 						6, 						4, 							3, 			6, 				5, 				5, 						8, 				6,
			7, 			5, 				8, 			7, 			'CIV_COLOR_ATLAS_VV_LEANBOX', 	2,
			'VVGreenHeartSceneDynamic.dds',	'VVGreenHeartSceneDynamicFriendly.dds',	'VVGreenHeartSceneDynamicGuarded.dds', 'VVGreenHeartSceneDynamicHostile.dds',
			'VVGreenHeartSceneDynamicAfraid.dds',	'VVGreenHeartSceneDynamicDenouncing.dds',	'VVGreenHeartSceneDynamicWar.dds', 'VVGreenHeartSceneDynamicDefeat.dds');


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 				MajorCivApproachType, 				Bias)
VALUES		('LEADER_VV_GREEN_HEART', 	'MAJOR_CIV_APPROACH_WAR', 			3),
			('LEADER_VV_GREEN_HEART', 	'MAJOR_CIV_APPROACH_HOSTILE', 		3),
			('LEADER_VV_GREEN_HEART', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	4),
			('LEADER_VV_GREEN_HEART', 	'MAJOR_CIV_APPROACH_GUARDED', 		6),
			('LEADER_VV_GREEN_HEART', 	'MAJOR_CIV_APPROACH_AFRAID', 		4),
			('LEADER_VV_GREEN_HEART', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		8),
			('LEADER_VV_GREEN_HEART', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		8);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 				MinorCivApproachType, 				Bias)
VALUES		('LEADER_VV_GREEN_HEART', 	'MINOR_CIV_APPROACH_IGNORE', 		3),
			('LEADER_VV_GREEN_HEART', 	'MINOR_CIV_APPROACH_FRIENDLY', 		7),
			('LEADER_VV_GREEN_HEART', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	5),
			('LEADER_VV_GREEN_HEART', 	'MINOR_CIV_APPROACH_CONQUEST', 		2),
			('LEADER_VV_GREEN_HEART', 	'MINOR_CIV_APPROACH_BULLY', 		3);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 				FlavorType, 						Flavor)
VALUES		('LEADER_VV_GREEN_HEART', 	'FLAVOR_OFFENSE', 					3),
			('LEADER_VV_GREEN_HEART', 	'FLAVOR_DEFENSE', 					6),
			('LEADER_VV_GREEN_HEART', 	'FLAVOR_CITY_DEFENSE', 				8),
			('LEADER_VV_GREEN_HEART', 	'FLAVOR_MILITARY_TRAINING', 		4),
			('LEADER_VV_GREEN_HEART', 	'FLAVOR_RECON', 					5),
			('LEADER_VV_GREEN_HEART', 	'FLAVOR_RANGED', 					7),
			('LEADER_VV_GREEN_HEART', 	'FLAVOR_MOBILE', 					3),
			('LEADER_VV_GREEN_HEART', 	'FLAVOR_NAVAL', 					5),
			('LEADER_VV_GREEN_HEART', 	'FLAVOR_NAVAL_RECON', 				4),
			('LEADER_VV_GREEN_HEART', 	'FLAVOR_NAVAL_GROWTH', 				5),
			('LEADER_VV_GREEN_HEART', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
			('LEADER_VV_GREEN_HEART', 	'FLAVOR_AIR', 						6),
			('LEADER_VV_GREEN_HEART', 	'FLAVOR_EXPANSION', 				4),
			('LEADER_VV_GREEN_HEART', 	'FLAVOR_GROWTH', 					7),
			('LEADER_VV_GREEN_HEART', 	'FLAVOR_TILE_IMPROVEMENT', 			8),
			('LEADER_VV_GREEN_HEART', 	'FLAVOR_INFRASTRUCTURE', 			6),
			('LEADER_VV_GREEN_HEART', 	'FLAVOR_PRODUCTION', 				4),
			('LEADER_VV_GREEN_HEART', 	'FLAVOR_GOLD', 						3),
			('LEADER_VV_GREEN_HEART', 	'FLAVOR_SCIENCE', 					6),
			('LEADER_VV_GREEN_HEART', 	'FLAVOR_CULTURE', 					8),
			('LEADER_VV_GREEN_HEART', 	'FLAVOR_HAPPINESS', 				6),
			('LEADER_VV_GREEN_HEART', 	'FLAVOR_GREAT_PEOPLE', 				7),
			('LEADER_VV_GREEN_HEART', 	'FLAVOR_WONDER', 					6),
			('LEADER_VV_GREEN_HEART', 	'FLAVOR_RELIGION', 					7),
			('LEADER_VV_GREEN_HEART', 	'FLAVOR_DIPLOMACY', 				7),
			('LEADER_VV_GREEN_HEART', 	'FLAVOR_SPACESHIP', 				4),
			('LEADER_VV_GREEN_HEART', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_VV_GREEN_HEART', 	'FLAVOR_NUKE', 						5),
			('LEADER_VV_GREEN_HEART', 	'FLAVOR_USE_NUKE', 					2),
			('LEADER_VV_GREEN_HEART', 	'FLAVOR_ESPIONAGE', 				3),
			('LEADER_VV_GREEN_HEART', 	'FLAVOR_ANTIAIR',	 				7),
			('LEADER_VV_GREEN_HEART', 	'FLAVOR_AIR_CARRIER', 				5),
			('LEADER_VV_GREEN_HEART', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_VV_GREEN_HEART', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_VV_GREEN_HEART', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_VV_GREEN_HEART', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_VV_GREEN_HEART', 	'FLAVOR_ARCHAEOLOGY', 				7),
			('LEADER_VV_GREEN_HEART', 	'FLAVOR_AIRLIFT', 					5);


--*******************************************************************
-- Trait Definition (Green Heart's Grace) 
--*******************************************************************
INSERT INTO Traits
			(Type,						Description,					ShortDescription)
VALUES		('TRAIT_VV_GREEN_HEART',	'TXT_KEY_TRAIT_VV_GREEN_HEART',	'TXT_KEY_TRAIT_VV_GREEN_HEART_SHORT');



--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 				TraitType)
VALUES		('LEADER_VV_GREEN_HEART', 	'TRAIT_VV_GREEN_HEART');



--HDD Setup
INSERT INTO Trait_VV_HDDModes
			(NormalTraitType,		HDDTraitType,				NormalDummyBuilding,								HDDDummyBuilding,	
			ScriptName)
VALUES		('TRAIT_VV_VERT',	'TRAIT_VV_GREEN_HEART',	'BUILDING_VV_LEANBOX_DUMMY_BUILDING_VERT', 'BUILDING_VV_LEANBOX_DUMMY_BUILDING_GREEN_HEART',
			'VertGreenHeartTraitScript.lua');



--*******************************************************************************************************************************************************************
-- ULTRADIMENSION
--*******************************************************************************************************************************************************************



--*******************************************************************
-- Vert
--*******************************************************************

INSERT INTO Leaders 
			(Type, 					Description, 			Civilopedia, 						CivilopediaTag, 						ArtDefineTag,				
			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty,
			Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 						PortraitIndex,
			VV_LeaderSceneOverride,			VV_LeaderSceneOverrideFriendly,			VV_LeaderSceneOverrideGuarded,		VV_LeaderSceneOverrideHostile,
			VV_LeaderSceneOverrideAfraid,	VV_LeaderSceneOverrideDenouncing,		VV_LeaderSceneOverrideWar,				VV_LeaderSceneOverrideDefeat)
VALUES		('LEADER_VV_VERT_ULTRA', 	'TXT_KEY_LEADER_VV_VERT', 	'TXT_KEY_LEADER_VV_VERT_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_VV_VERT', 	'VVVertScene.xml',
			5, 						4, 						4, 							5, 			5, 				3, 				6, 						8, 				5,
			7, 			5, 				8, 			7, 			'CIV_COLOR_ATLAS_VV_LEANBOX_ULTRA', 	1,
			'VVVertSceneDynamicUltra.dds',	'VVVertSceneDynamicFriendlyUltra.dds',	'VVVertSceneDynamicGuardedUltra.dds', 'VVVertSceneDynamicHostileUltra.dds',
			'VVVertSceneDynamicAfraidUltra.dds',	'VVVertSceneDynamicDenouncingUltra.dds',	'VVVertSceneDynamicWarUltra.dds', 'VVVertSceneDynamicDefeatUltra.dds');


--UD Vert is a little less friendly and a lot more predisposed to war.

--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 		MajorCivApproachType, 				Bias)
VALUES		('LEADER_VV_VERT_ULTRA', 	'MAJOR_CIV_APPROACH_WAR', 			5),
			('LEADER_VV_VERT_ULTRA', 	'MAJOR_CIV_APPROACH_HOSTILE', 		4),
			('LEADER_VV_VERT_ULTRA', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	4),
			('LEADER_VV_VERT_ULTRA', 	'MAJOR_CIV_APPROACH_GUARDED', 		5),
			('LEADER_VV_VERT_ULTRA', 	'MAJOR_CIV_APPROACH_AFRAID', 		3),
			('LEADER_VV_VERT_ULTRA', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		8),
			('LEADER_VV_VERT_ULTRA', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		7);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 		MinorCivApproachType, 				Bias)
VALUES		('LEADER_VV_VERT_ULTRA', 	'MINOR_CIV_APPROACH_IGNORE', 		3),
			('LEADER_VV_VERT_ULTRA', 	'MINOR_CIV_APPROACH_FRIENDLY', 		7),
			('LEADER_VV_VERT_ULTRA', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	5),
			('LEADER_VV_VERT_ULTRA', 	'MINOR_CIV_APPROACH_CONQUEST', 		3),
			('LEADER_VV_VERT_ULTRA', 	'MINOR_CIV_APPROACH_BULLY', 		4);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 		FlavorType, 						Flavor)
VALUES		('LEADER_VV_VERT_ULTRA', 	'FLAVOR_OFFENSE', 					5),
			('LEADER_VV_VERT_ULTRA', 	'FLAVOR_DEFENSE', 					7),
			('LEADER_VV_VERT_ULTRA', 	'FLAVOR_CITY_DEFENSE', 				4),
			('LEADER_VV_VERT_ULTRA', 	'FLAVOR_MILITARY_TRAINING', 		6),
			('LEADER_VV_VERT_ULTRA', 	'FLAVOR_RECON', 					4),
			('LEADER_VV_VERT_ULTRA', 	'FLAVOR_RANGED', 					7),
			('LEADER_VV_VERT_ULTRA', 	'FLAVOR_MOBILE', 					6),
			('LEADER_VV_VERT_ULTRA', 	'FLAVOR_NAVAL', 					6),
			('LEADER_VV_VERT_ULTRA', 	'FLAVOR_NAVAL_RECON', 				4),
			('LEADER_VV_VERT_ULTRA', 	'FLAVOR_NAVAL_GROWTH', 				5),
			('LEADER_VV_VERT_ULTRA', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
			('LEADER_VV_VERT_ULTRA', 	'FLAVOR_AIR', 						5),
			('LEADER_VV_VERT_ULTRA', 	'FLAVOR_EXPANSION', 				7),
			('LEADER_VV_VERT_ULTRA', 	'FLAVOR_GROWTH', 					4),
			('LEADER_VV_VERT_ULTRA', 	'FLAVOR_TILE_IMPROVEMENT', 			8),
			('LEADER_VV_VERT_ULTRA', 	'FLAVOR_INFRASTRUCTURE', 			6),
			('LEADER_VV_VERT_ULTRA', 	'FLAVOR_PRODUCTION', 				4),
			('LEADER_VV_VERT_ULTRA', 	'FLAVOR_GOLD', 						3),
			('LEADER_VV_VERT_ULTRA', 	'FLAVOR_SCIENCE', 					8),
			('LEADER_VV_VERT_ULTRA', 	'FLAVOR_CULTURE', 					7),
			('LEADER_VV_VERT_ULTRA', 	'FLAVOR_HAPPINESS', 				6),
			('LEADER_VV_VERT_ULTRA', 	'FLAVOR_GREAT_PEOPLE', 				7),
			('LEADER_VV_VERT_ULTRA', 	'FLAVOR_WONDER', 					6),
			('LEADER_VV_VERT_ULTRA', 	'FLAVOR_RELIGION', 					7),
			('LEADER_VV_VERT_ULTRA', 	'FLAVOR_DIPLOMACY', 				7),
			('LEADER_VV_VERT_ULTRA', 	'FLAVOR_SPACESHIP', 				4),
			('LEADER_VV_VERT_ULTRA', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_VV_VERT_ULTRA', 	'FLAVOR_NUKE', 						5),
			('LEADER_VV_VERT_ULTRA', 	'FLAVOR_USE_NUKE', 					4),
			('LEADER_VV_VERT_ULTRA', 	'FLAVOR_ESPIONAGE', 				3),
			('LEADER_VV_VERT_ULTRA', 	'FLAVOR_ANTIAIR',	 				7),
			('LEADER_VV_VERT_ULTRA', 	'FLAVOR_AIR_CARRIER', 				5),
			('LEADER_VV_VERT_ULTRA', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_VV_VERT_ULTRA', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_VV_VERT_ULTRA', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_VV_VERT_ULTRA', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_VV_VERT_ULTRA', 	'FLAVOR_ARCHAEOLOGY', 				5),
			('LEADER_VV_VERT_ULTRA', 	'FLAVOR_AIRLIFT', 					5);


--*******************************************************************
-- Trait Definition (Land of Green Pastures) 
--*******************************************************************
INSERT INTO Traits
			(Type,					Description,				ShortDescription,				VV_Shares_GreatWorks)
VALUES		('TRAIT_VV_VERT_ULTRA',	'TXT_KEY_TRAIT_VV_VERT',	'TXT_KEY_TRAIT_VV_VERT_SHORT',	3);


--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 				TraitType)
VALUES		('LEADER_VV_VERT_ULTRA', 	'TRAIT_VV_VERT_ULTRA');




------------------------------------------------------------------------------------------------------------------------------------------------------------


--*******************************************************************
-- Green Heart
--*******************************************************************

INSERT INTO Leaders 
			(Type, 						Description, 						Civilopedia, 						CivilopediaTag, 						ArtDefineTag,				
			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty,
			Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 						PortraitIndex,
			VV_LeaderSceneOverride,			VV_LeaderSceneOverrideFriendly,			VV_LeaderSceneOverrideGuarded,		VV_LeaderSceneOverrideHostile,
			VV_LeaderSceneOverrideAfraid,	VV_LeaderSceneOverrideDenouncing,		VV_LeaderSceneOverrideWar,				VV_LeaderSceneOverrideDefeat)
VALUES		('LEADER_VV_GREEN_HEART_ULTRA', 	'TXT_KEY_LEADER_VV_GREEN_HEART', 	'TXT_KEY_LEADER_VV_VERT_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_VV_VERT', 	'VVGreenHeartScene.xml',
			3, 						6, 						4, 							3, 			6, 				5, 				5, 						8, 				6,
			7, 			5, 				8, 			7, 			'CIV_COLOR_ATLAS_VV_LEANBOX_ULTRA', 	2,
			'VVGreenHeartSceneDynamicUltra.dds',	'VVGreenHeartSceneDynamicFriendlyUltra.dds',	'VVGreenHeartSceneDynamicGuardedUltra.dds', 'VVGreenHeartSceneDynamicHostileUltra.dds',
			'VVGreenHeartSceneDynamicAfraidUltra.dds',	'VVGreenHeartSceneDynamicDenouncingUltra.dds',	'VVGreenHeartSceneDynamicWarUltra.dds', 'VVGreenHeartSceneDynamicDefeatUltra.dds');


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 				MajorCivApproachType, 				Bias)
VALUES		('LEADER_VV_GREEN_HEART_ULTRA', 	'MAJOR_CIV_APPROACH_WAR', 			3),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'MAJOR_CIV_APPROACH_HOSTILE', 		3),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	4),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'MAJOR_CIV_APPROACH_GUARDED', 		6),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'MAJOR_CIV_APPROACH_AFRAID', 		4),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		8),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		8);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 				MinorCivApproachType, 				Bias)
VALUES		('LEADER_VV_GREEN_HEART_ULTRA', 	'MINOR_CIV_APPROACH_IGNORE', 		3),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'MINOR_CIV_APPROACH_FRIENDLY', 		7),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	5),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'MINOR_CIV_APPROACH_CONQUEST', 		2),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'MINOR_CIV_APPROACH_BULLY', 		3);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 				FlavorType, 						Flavor)
VALUES		('LEADER_VV_GREEN_HEART_ULTRA', 	'FLAVOR_OFFENSE', 					3),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'FLAVOR_DEFENSE', 					6),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'FLAVOR_CITY_DEFENSE', 				8),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'FLAVOR_MILITARY_TRAINING', 		4),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'FLAVOR_RECON', 					5),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'FLAVOR_RANGED', 					7),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'FLAVOR_MOBILE', 					3),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'FLAVOR_NAVAL', 					5),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'FLAVOR_NAVAL_RECON', 				4),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'FLAVOR_NAVAL_GROWTH', 				5),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'FLAVOR_AIR', 						6),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'FLAVOR_EXPANSION', 				4),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'FLAVOR_GROWTH', 					7),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'FLAVOR_TILE_IMPROVEMENT', 			8),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'FLAVOR_INFRASTRUCTURE', 			6),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'FLAVOR_PRODUCTION', 				4),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'FLAVOR_GOLD', 						3),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'FLAVOR_SCIENCE', 					6),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'FLAVOR_CULTURE', 					8),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'FLAVOR_HAPPINESS', 				6),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'FLAVOR_GREAT_PEOPLE', 				7),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'FLAVOR_WONDER', 					6),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'FLAVOR_RELIGION', 					7),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'FLAVOR_DIPLOMACY', 				7),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'FLAVOR_SPACESHIP', 				4),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'FLAVOR_NUKE', 						5),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'FLAVOR_USE_NUKE', 					2),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'FLAVOR_ESPIONAGE', 				3),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'FLAVOR_ANTIAIR',	 				7),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'FLAVOR_AIR_CARRIER', 				5),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'FLAVOR_ARCHAEOLOGY', 				7),
			('LEADER_VV_GREEN_HEART_ULTRA', 	'FLAVOR_AIRLIFT', 					5);


--*******************************************************************
-- Trait Definition (Green Heart's Grace) 
--*******************************************************************
INSERT INTO Traits
			(Type,							Description,						ShortDescription)
VALUES		('TRAIT_VV_GREEN_HEART_ULTRA',	'TXT_KEY_TRAIT_VV_GREEN_HEART_U',	'TXT_KEY_TRAIT_VV_GREEN_HEART_SHORT');



--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 						TraitType)
VALUES		('LEADER_VV_GREEN_HEART_ULTRA', 	'TRAIT_VV_GREEN_HEART_ULTRA');



--HDD Setup
INSERT INTO Trait_VV_HDDModes
			(NormalTraitType,		HDDTraitType,					NormalDummyBuilding,						HDDDummyBuilding,	
			ScriptName)
VALUES		('TRAIT_VV_VERT_ULTRA',	'TRAIT_VV_GREEN_HEART_ULTRA',	'BUILDING_VV_LEANBOX_DUMMY_BUILDING_VERT', 'BUILDING_VV_LEANBOX_DUMMY_BUILDING_GREEN_HEART_U',
			'VertGreenHeartTraitScript.lua');
			

			
------------------------DUMMY BUILDING----------------------------------------

INSERT INTO BuildingClasses
			(Type,													DefaultBuilding,							NoLimit)
VALUES		('BUILDINGCLASS_VV_LEANBOX_DUMMY_BUILDING_TRAIT',		'BUILDING_VV_LEANBOX_DUMMY_BUILDING_TRAIT',	1);



INSERT INTO Buildings
			(Type,											BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune,
			ExtraCityHitPoints)
VALUES		('BUILDING_VV_LEANBOX_DUMMY_BUILDING_TRAIT',		'BUILDINGCLASS_VV_LEANBOX_DUMMY_BUILDING_TRAIT',
			-1,		-1,			-1,				null,		1,				1,
			10);