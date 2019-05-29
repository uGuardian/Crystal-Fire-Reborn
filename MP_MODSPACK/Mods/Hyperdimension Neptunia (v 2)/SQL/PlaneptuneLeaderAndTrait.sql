--*******************************************************************
-- Neptune
--*******************************************************************

INSERT INTO Leaders 
			(Type, 					Description, 			Civilopedia, 						CivilopediaTag, 						ArtDefineTag,				
			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty,
			Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 								PortraitIndex,
			VV_LeaderSceneOverride,			VV_LeaderSceneOverrideFriendly,			VV_LeaderSceneOverrideGuarded,		VV_LeaderSceneOverrideHostile,
			VV_LeaderSceneOverrideDenouncing,		VV_LeaderSceneOverrideWar,				VV_LeaderSceneOverrideDefeat)
VALUES		('LEADER_VV_NEPTUNE', 	'TXT_KEY_LEADER_VV_NEPTUNE', 	'TXT_KEY_LEADER_VV_NEPTUNE_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_VV_NEPTUNE', 	'VVNeptuneScene.xml',
			7, 						1, 						4, 							4, 			7, 				8, 				6, 						10, 			9,
			10, 		7, 				10, 		5, 			'CIV_COLOR_ATLAS_VV_PLANEPTUNE', 	2,
			'VVNeptuneSceneDynamic.dds',	'VVNeptuneSceneDynamicFriendly.dds',	'VVNeptuneSceneDynamicGuarded.dds', 'VVNeptuneSceneDynamicHostile.dds',
			'VVNeptuneSceneDynamicDenouncing.dds',	'VVNeptuneSceneDynamicWar.dds',	'VVNeptuneSceneDynamicDefeat.dds');


UPDATE Leaders
SET VV_LeaderSceneOverride = 'VVNeptuneSceneDynamicAlt.dds',
VV_LeaderSceneOverrideFriendly = 'VVNeptuneSceneDynamicFriendlyAlt.dds', 
VV_LeaderSceneOverrideGuarded = 'VVNeptuneSceneDynamicGuardedAlt.dds', 
VV_LeaderSceneOverrideHostile = 'VVNeptuneSceneDynamicHostileAlt.dds',
VV_LeaderSceneOverrideDenouncing = 'VVNeptuneSceneDynamicDenouncingAlt.dds', 
VV_LeaderSceneOverrideWar = 'VVNeptuneSceneDynamicWarAlt.dds',
VV_LeaderSceneOverrideDefeat = 'VVNeptuneSceneDynamicDefeatAlt.dds',
PortraitIndex = 1
WHERE Type = 'LEADER_VV_NEPTUNE' AND EXISTS(SELECT * FROM VV_NeptuneModOptions WHERE Type = 'OUTFIT' AND Value = 2);


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 			MajorCivApproachType, 				Bias)
VALUES		('LEADER_VV_NEPTUNE', 	'MAJOR_CIV_APPROACH_WAR', 			4),
			('LEADER_VV_NEPTUNE', 	'MAJOR_CIV_APPROACH_HOSTILE', 		5),
			('LEADER_VV_NEPTUNE', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	1),
			('LEADER_VV_NEPTUNE', 	'MAJOR_CIV_APPROACH_GUARDED', 		5),
			('LEADER_VV_NEPTUNE', 	'MAJOR_CIV_APPROACH_AFRAID', 		4),
			('LEADER_VV_NEPTUNE', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		9),
			('LEADER_VV_NEPTUNE', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		6);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 			MinorCivApproachType, 				Bias)
VALUES		('LEADER_VV_NEPTUNE', 	'MINOR_CIV_APPROACH_IGNORE', 		3),
			('LEADER_VV_NEPTUNE', 	'MINOR_CIV_APPROACH_FRIENDLY', 		8),
			('LEADER_VV_NEPTUNE', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	7),
			('LEADER_VV_NEPTUNE', 	'MINOR_CIV_APPROACH_CONQUEST', 		2),
			('LEADER_VV_NEPTUNE', 	'MINOR_CIV_APPROACH_BULLY', 		4);

--*******************************************************************
-- Flavors
--*******************************************************************

INSERT INTO Leader_Flavors 
			(LeaderType, 			FlavorType, 						Flavor)
VALUES		('LEADER_VV_NEPTUNE', 	'FLAVOR_OFFENSE', 					6),
			('LEADER_VV_NEPTUNE', 	'FLAVOR_DEFENSE', 					8), 
			('LEADER_VV_NEPTUNE', 	'FLAVOR_CITY_DEFENSE', 				6),
			('LEADER_VV_NEPTUNE', 	'FLAVOR_MILITARY_TRAINING', 		3),
			('LEADER_VV_NEPTUNE', 	'FLAVOR_RECON', 					5),
			('LEADER_VV_NEPTUNE', 	'FLAVOR_RANGED', 					4),
			('LEADER_VV_NEPTUNE', 	'FLAVOR_MOBILE', 					9),
			('LEADER_VV_NEPTUNE', 	'FLAVOR_NAVAL', 					7),
			('LEADER_VV_NEPTUNE', 	'FLAVOR_NAVAL_RECON', 				3),
			('LEADER_VV_NEPTUNE', 	'FLAVOR_NAVAL_GROWTH', 				6),
			('LEADER_VV_NEPTUNE', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
			('LEADER_VV_NEPTUNE', 	'FLAVOR_AIR', 						7),
			('LEADER_VV_NEPTUNE', 	'FLAVOR_EXPANSION', 				7),
			('LEADER_VV_NEPTUNE', 	'FLAVOR_GROWTH', 					4),
			('LEADER_VV_NEPTUNE', 	'FLAVOR_TILE_IMPROVEMENT', 			7),
			('LEADER_VV_NEPTUNE', 	'FLAVOR_INFRASTRUCTURE', 			6),
			('LEADER_VV_NEPTUNE', 	'FLAVOR_PRODUCTION', 				7),
			('LEADER_VV_NEPTUNE', 	'FLAVOR_GOLD', 						3),
			('LEADER_VV_NEPTUNE', 	'FLAVOR_SCIENCE', 					8),
			('LEADER_VV_NEPTUNE', 	'FLAVOR_CULTURE', 					4),
			('LEADER_VV_NEPTUNE', 	'FLAVOR_HAPPINESS', 				6),
			('LEADER_VV_NEPTUNE', 	'FLAVOR_GREAT_PEOPLE', 				3),
			('LEADER_VV_NEPTUNE', 	'FLAVOR_WONDER', 					5),
			('LEADER_VV_NEPTUNE', 	'FLAVOR_RELIGION', 					8),
			('LEADER_VV_NEPTUNE', 	'FLAVOR_DIPLOMACY', 				7),
			('LEADER_VV_NEPTUNE', 	'FLAVOR_SPACESHIP', 				8),
			('LEADER_VV_NEPTUNE', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_VV_NEPTUNE', 	'FLAVOR_NUKE', 						4),
			('LEADER_VV_NEPTUNE', 	'FLAVOR_USE_NUKE', 					2),
			('LEADER_VV_NEPTUNE', 	'FLAVOR_ESPIONAGE', 				3),
			('LEADER_VV_NEPTUNE', 	'FLAVOR_ANTIAIR',	 				4),
			('LEADER_VV_NEPTUNE', 	'FLAVOR_AIR_CARRIER', 				7),
			('LEADER_VV_NEPTUNE', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_VV_NEPTUNE', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_VV_NEPTUNE', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_VV_NEPTUNE', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_VV_NEPTUNE', 	'FLAVOR_ARCHAEOLOGY', 				4),
			('LEADER_VV_NEPTUNE', 	'FLAVOR_AIRLIFT', 					6);


--*******************************************************************
-- Trait Definition (Land of Purple Progress) 
--*******************************************************************
INSERT INTO Traits
			(Type,					Description,				ShortDescription,					NoAnnexing,	PrereqTech,					ObsoleteTech,
			VV_Shares_AnnexedPopulationTimes100)
VALUES		('TRAIT_VV_NEPTUNE',	'TXT_KEY_TRAIT_VV_NEPTUNE',	'TXT_KEY_TRAIT_VV_NEPTUNE_SHORT',	1,			'TECH_VV_NEPTUNE_DUMMY_ON',	'TECH_VV_NEPTUNE_DUMMY_OFF',
			33);

--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 			TraitType)
VALUES		('LEADER_VV_NEPTUNE', 	'TRAIT_VV_NEPTUNE');




------------------------------------------------------------------------------------------------------------------------------------------------------------


--*******************************************************************
-- Purple Heart
--*******************************************************************

INSERT INTO Leaders 
			(Type, 						Description, 						Civilopedia, 						CivilopediaTag, 						ArtDefineTag,				
			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty,
			Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 						PortraitIndex,
			VV_LeaderSceneOverride,			VV_LeaderSceneOverrideFriendly,			VV_LeaderSceneOverrideGuarded,		VV_LeaderSceneOverrideHostile,
			VV_LeaderSceneOverrideDenouncing,		VV_LeaderSceneOverrideWar,				VV_LeaderSceneOverrideDefeat)
VALUES		('LEADER_VV_PURPLE_HEART', 	'TXT_KEY_LEADER_VV_PURPLE_HEART', 	'TXT_KEY_LEADER_VV_NEPTUNE_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_VV_NEPTUNE', 	'VVPurpleHeartScene.xml',
			7, 						1, 						4, 							4, 			7, 				8, 				6, 						10, 			9,
			10, 		7, 				10, 		5, 			'CIV_COLOR_ATLAS_VV_PLANEPTUNE', 	3,
			'VVPurpleHeartSceneDynamic.dds',	'VVPurpleHeartSceneDynamicFriendly.dds',	'VVPurpleHeartSceneDynamicGuarded.dds', 'VVPurpleHeartSceneDynamicHostile.dds',
			'VVPurpleHeartSceneDynamicDenouncing.dds',	'VVPurpleHeartSceneDynamicWar.dds',	'VVPurpleHeartSceneDynamicDefeat.dds');


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 				MajorCivApproachType, 				Bias)
VALUES		('LEADER_VV_PURPLE_HEART', 	'MAJOR_CIV_APPROACH_WAR', 			4),
			('LEADER_VV_PURPLE_HEART', 	'MAJOR_CIV_APPROACH_HOSTILE', 		5),
			('LEADER_VV_PURPLE_HEART', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	1),
			('LEADER_VV_PURPLE_HEART', 	'MAJOR_CIV_APPROACH_GUARDED', 		5),
			('LEADER_VV_PURPLE_HEART', 	'MAJOR_CIV_APPROACH_AFRAID', 		4),
			('LEADER_VV_PURPLE_HEART', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		9),
			('LEADER_VV_PURPLE_HEART', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		6);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 				MinorCivApproachType, 				Bias)
VALUES		('LEADER_VV_PURPLE_HEART', 	'MINOR_CIV_APPROACH_IGNORE', 		3),
			('LEADER_VV_PURPLE_HEART', 	'MINOR_CIV_APPROACH_FRIENDLY', 		8),
			('LEADER_VV_PURPLE_HEART', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	7),
			('LEADER_VV_PURPLE_HEART', 	'MINOR_CIV_APPROACH_CONQUEST', 		2),
			('LEADER_VV_PURPLE_HEART', 	'MINOR_CIV_APPROACH_BULLY', 		4);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 					FlavorType, 						Flavor)
VALUES		('LEADER_VV_PURPLE_HEART', 	'FLAVOR_OFFENSE', 					6),
			('LEADER_VV_PURPLE_HEART', 	'FLAVOR_DEFENSE', 					8),
			('LEADER_VV_PURPLE_HEART', 	'FLAVOR_CITY_DEFENSE', 				6),
			('LEADER_VV_PURPLE_HEART', 	'FLAVOR_MILITARY_TRAINING', 		4),
			('LEADER_VV_PURPLE_HEART', 	'FLAVOR_RECON', 					3),
			('LEADER_VV_PURPLE_HEART', 	'FLAVOR_RANGED', 					4),
			('LEADER_VV_PURPLE_HEART', 	'FLAVOR_MOBILE', 					9),
			('LEADER_VV_PURPLE_HEART', 	'FLAVOR_NAVAL', 					7),
			('LEADER_VV_PURPLE_HEART', 	'FLAVOR_NAVAL_RECON', 				3),
			('LEADER_VV_PURPLE_HEART', 	'FLAVOR_NAVAL_GROWTH', 				6),
			('LEADER_VV_PURPLE_HEART', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
			('LEADER_VV_PURPLE_HEART', 	'FLAVOR_AIR', 						7),
			('LEADER_VV_PURPLE_HEART', 	'FLAVOR_EXPANSION', 				8),
			('LEADER_VV_PURPLE_HEART', 	'FLAVOR_GROWTH', 					7),
			('LEADER_VV_PURPLE_HEART', 	'FLAVOR_TILE_IMPROVEMENT', 			7),
			('LEADER_VV_PURPLE_HEART', 	'FLAVOR_INFRASTRUCTURE', 			6),
			('LEADER_VV_PURPLE_HEART', 	'FLAVOR_PRODUCTION', 				7),
			('LEADER_VV_PURPLE_HEART', 	'FLAVOR_GOLD', 						3),
			('LEADER_VV_PURPLE_HEART', 	'FLAVOR_SCIENCE', 					9),
			('LEADER_VV_PURPLE_HEART', 	'FLAVOR_CULTURE', 					4),
			('LEADER_VV_PURPLE_HEART', 	'FLAVOR_HAPPINESS', 				6),
			('LEADER_VV_PURPLE_HEART', 	'FLAVOR_GREAT_PEOPLE', 				3),
			('LEADER_VV_PURPLE_HEART', 	'FLAVOR_WONDER', 					6),
			('LEADER_VV_PURPLE_HEART', 	'FLAVOR_RELIGION', 					8),
			('LEADER_VV_PURPLE_HEART', 	'FLAVOR_DIPLOMACY', 				7),
			('LEADER_VV_PURPLE_HEART', 	'FLAVOR_SPACESHIP', 				8),
			('LEADER_VV_PURPLE_HEART', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_VV_PURPLE_HEART', 	'FLAVOR_NUKE', 						7),
			('LEADER_VV_PURPLE_HEART', 	'FLAVOR_USE_NUKE', 					2),
			('LEADER_VV_PURPLE_HEART', 	'FLAVOR_ESPIONAGE', 				3),
			('LEADER_VV_PURPLE_HEART', 	'FLAVOR_ANTIAIR',	 				4),
			('LEADER_VV_PURPLE_HEART', 	'FLAVOR_AIR_CARRIER', 				7),
			('LEADER_VV_PURPLE_HEART', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_VV_PURPLE_HEART', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_VV_PURPLE_HEART', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_VV_PURPLE_HEART', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_VV_PURPLE_HEART', 	'FLAVOR_ARCHAEOLOGY', 				4),
			('LEADER_VV_PURPLE_HEART', 	'FLAVOR_AIRLIFT', 					6);


--*******************************************************************
-- Trait Definition (Purple Heart's Power) 
--*******************************************************************
INSERT INTO Traits
			(Type,						Description,						ShortDescription,						NoAnnexing,	PrereqTech,					ObsoleteTech)
VALUES		('TRAIT_VV_PURPLE_HEART',	'TXT_KEY_TRAIT_VV_PURPLE_HEART',	'TXT_KEY_TRAIT_VV_PURPLE_HEART_SHORT',	1,			'TECH_VV_NEPTUNE_DUMMY_ON',	'TECH_VV_NEPTUNE_DUMMY_OFF');


--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 				TraitType)
VALUES		('LEADER_VV_PURPLE_HEART', 	'TRAIT_VV_PURPLE_HEART');



--HDD Setup
INSERT INTO Trait_VV_HDDModes
			(NormalTraitType,		HDDTraitType,				NormalDummyBuilding,								HDDDummyBuilding,	
			ScriptName)
VALUES		('TRAIT_VV_NEPTUNE',	'TRAIT_VV_PURPLE_HEART',	null, null,
			'NeptunePurpleHeartTraitScript.lua');





-- Dummy Techs
INSERT INTO Technologies
			(Type,							Description,							Help,										Civilopedia,								Quote,
			Trade,	GoodyTech,	Disable,	GridX,	GridY,	Cost,	Era)
VALUES		('TECH_VV_NEPTUNE_DUMMY_ON',	'TXT_KEY_TECH_VV_NEPTUNE_DUMMY_ON',		'TXT_KEY_TECH_VV_NEPTUNE_DUMMY_ON_PEDIA',	'TXT_KEY_TECH_VV_NEPTUNE_DUMMY_ON_PEDIA',	'TXT_KEY_TECH_VV_NEPTUNE_DUMMY_ON_QUOTE',
			0,		0,			1,			0,		50,		-1,		'ERA_ANCIENT'),
			('TECH_VV_NEPTUNE_DUMMY_OFF',	'TXT_KEY_TECH_VV_NEPTUNE_DUMMY_OFF',	'TXT_KEY_TECH_VV_NEPTUNE_DUMMY_OFF_PEDIA',	'TXT_KEY_TECH_VV_NEPTUNE_DUMMY_OFF_PEDIA',	'TXT_KEY_TECH_VV_NEPTUNE_DUMMY_OFF_QUOTE',
			0,		0,			1,			0,		50,		-1,		'ERA_ANCIENT');