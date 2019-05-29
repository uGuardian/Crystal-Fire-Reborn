--*******************************************************************
-- Plutia
--*******************************************************************

INSERT INTO Leaders 
			(Type, 					Description, 			Civilopedia, 						CivilopediaTag, 						ArtDefineTag,				
			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty,
			Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 								PortraitIndex,
			VV_LeaderSceneOverride,			VV_LeaderSceneOverrideFriendly,			VV_LeaderSceneOverrideGuarded,		VV_LeaderSceneOverrideHostile,
			VV_LeaderSceneOverrideDenouncing,		VV_LeaderSceneOverrideWar,				VV_LeaderSceneOverrideDefeat)
VALUES		('LEADER_VV_PLUTIA', 	'TXT_KEY_LEADER_VV_PLUTIA', 	'TXT_KEY_LEADER_VV_PLUTIA_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_VV_PLUTIA', 	'VVPlutiaScene.xml',
			7, 						1, 						4, 							4, 			7, 				8, 				6, 						10, 			9,
			10, 		7, 				10, 		5, 			'CIV_COLOR_ATLAS_VV_PLANEPTUNE_PL', 	1,
			'VVPlutiaSceneDynamic.dds',	'VVPlutiaSceneDynamicFriendly.dds',	'VVPlutiaSceneDynamicGuarded.dds', 'VVPlutiaSceneDynamicHostile.dds',
			'VVPlutiaSceneDynamicDenouncing.dds',	'VVPlutiaSceneDynamicWar.dds',	'VVPlutiaSceneDynamicDefeat.dds');


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 			MajorCivApproachType, 				Bias)
VALUES		('LEADER_VV_PLUTIA', 	'MAJOR_CIV_APPROACH_WAR', 			4),
			('LEADER_VV_PLUTIA', 	'MAJOR_CIV_APPROACH_HOSTILE', 		5),
			('LEADER_VV_PLUTIA', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	1),
			('LEADER_VV_PLUTIA', 	'MAJOR_CIV_APPROACH_GUARDED', 		5),
			('LEADER_VV_PLUTIA', 	'MAJOR_CIV_APPROACH_AFRAID', 		4),
			('LEADER_VV_PLUTIA', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		9),
			('LEADER_VV_PLUTIA', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		6);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 			MinorCivApproachType, 				Bias)
VALUES		('LEADER_VV_PLUTIA', 	'MINOR_CIV_APPROACH_IGNORE', 		3),
			('LEADER_VV_PLUTIA', 	'MINOR_CIV_APPROACH_FRIENDLY', 		8),
			('LEADER_VV_PLUTIA', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	7),
			('LEADER_VV_PLUTIA', 	'MINOR_CIV_APPROACH_CONQUEST', 		2),
			('LEADER_VV_PLUTIA', 	'MINOR_CIV_APPROACH_BULLY', 		4);

--*******************************************************************
-- Flavors
--*******************************************************************


INSERT INTO Leader_Flavors 
			(LeaderType, 			FlavorType, 						Flavor)
VALUES		('LEADER_VV_PLUTIA', 	'FLAVOR_OFFENSE', 					9),
			('LEADER_VV_PLUTIA', 	'FLAVOR_DEFENSE', 					9), 
			('LEADER_VV_PLUTIA', 	'FLAVOR_CITY_DEFENSE', 				6),
			('LEADER_VV_PLUTIA', 	'FLAVOR_MILITARY_TRAINING', 		3),
			('LEADER_VV_PLUTIA', 	'FLAVOR_RECON', 					5),
			('LEADER_VV_PLUTIA', 	'FLAVOR_RANGED', 					4),
			('LEADER_VV_PLUTIA', 	'FLAVOR_MOBILE', 					9),
			('LEADER_VV_PLUTIA', 	'FLAVOR_NAVAL', 					7),
			('LEADER_VV_PLUTIA', 	'FLAVOR_NAVAL_RECON', 				3),
			('LEADER_VV_PLUTIA', 	'FLAVOR_NAVAL_GROWTH', 				6),
			('LEADER_VV_PLUTIA', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
			('LEADER_VV_PLUTIA', 	'FLAVOR_AIR', 						7),
			('LEADER_VV_PLUTIA', 	'FLAVOR_EXPANSION', 				10),
			('LEADER_VV_PLUTIA', 	'FLAVOR_GROWTH', 					4),
			('LEADER_VV_PLUTIA', 	'FLAVOR_TILE_IMPROVEMENT', 			7),
			('LEADER_VV_PLUTIA', 	'FLAVOR_INFRASTRUCTURE', 			6),
			('LEADER_VV_PLUTIA', 	'FLAVOR_PRODUCTION', 				7),
			('LEADER_VV_PLUTIA', 	'FLAVOR_GOLD', 						3),
			('LEADER_VV_PLUTIA', 	'FLAVOR_SCIENCE', 					8),
			('LEADER_VV_PLUTIA', 	'FLAVOR_CULTURE', 					4),
			('LEADER_VV_PLUTIA', 	'FLAVOR_HAPPINESS', 				6),
			('LEADER_VV_PLUTIA', 	'FLAVOR_GREAT_PEOPLE', 				3),
			('LEADER_VV_PLUTIA', 	'FLAVOR_WONDER', 					8),
			('LEADER_VV_PLUTIA', 	'FLAVOR_RELIGION', 					8),
			('LEADER_VV_PLUTIA', 	'FLAVOR_DIPLOMACY', 				7),
			('LEADER_VV_PLUTIA', 	'FLAVOR_SPACESHIP', 				8),
			('LEADER_VV_PLUTIA', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_VV_PLUTIA', 	'FLAVOR_NUKE', 						4),
			('LEADER_VV_PLUTIA', 	'FLAVOR_USE_NUKE', 					2),
			('LEADER_VV_PLUTIA', 	'FLAVOR_ESPIONAGE', 				3),
			('LEADER_VV_PLUTIA', 	'FLAVOR_ANTIAIR',	 				4),
			('LEADER_VV_PLUTIA', 	'FLAVOR_AIR_CARRIER', 				7),
			('LEADER_VV_PLUTIA', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_VV_PLUTIA', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_VV_PLUTIA', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_VV_PLUTIA', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_VV_PLUTIA', 	'FLAVOR_ARCHAEOLOGY', 				4),
			('LEADER_VV_PLUTIA', 	'FLAVOR_AIRLIFT', 					6);


--*******************************************************************
-- Trait Definition (Classic Land of Purple Progress) 
--*******************************************************************
INSERT INTO Traits
			(Type,					Description,			ShortDescription,					PlutiaDollSystem,	PlutiaNapTurns,	PlutiaTurnsUntilNap, 	VV_Shares_AfraidCS,	VV_Shares_AfraidCivs)
VALUES		('TRAIT_VV_PLUTIA',	'TXT_KEY_TRAIT_VV_PLUTIA',	'TXT_KEY_TRAIT_VV_PLUTIA_SHORT',	1,					1,				10,						3,					5);

--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 			TraitType)
VALUES		('LEADER_VV_PLUTIA', 	'TRAIT_VV_PLUTIA');




------------------------------------------------------------------------------------------------------------------------------------------------------------


--*******************************************************************
-- Iris Heart
--*******************************************************************

INSERT INTO Leaders 
			(Type, 						Description, 						Civilopedia, 						CivilopediaTag, 						ArtDefineTag,				
			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty,
			Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 						PortraitIndex,
			VV_LeaderSceneOverride,			VV_LeaderSceneOverrideFriendly,			VV_LeaderSceneOverrideGuarded,		VV_LeaderSceneOverrideHostile,
			VV_LeaderSceneOverrideDenouncing,		VV_LeaderSceneOverrideWar,				VV_LeaderSceneOverrideDefeat)
VALUES		('LEADER_VV_IRIS_HEART', 	'TXT_KEY_LEADER_VV_IRIS_HEART', 	'TXT_KEY_LEADER_VV_PLUTIA_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_VV_PLUTIA', 	'VVIrisHeartScene.xml',
			7, 						1, 						4, 							8, 			7, 				3, 				10, 					10, 			4,
			10, 		7, 				10, 		5, 			'CIV_COLOR_ATLAS_VV_PLANEPTUNE_PL', 	2,
			'VVIrisHeartSceneDynamic.dds',	'VVIrisHeartSceneDynamicFriendly.dds',	'VVIrisHeartSceneDynamicGuarded.dds', 'VVIrisHeartSceneDynamicHostile.dds',
			'VVIrisHeartSceneDynamicDenouncing.dds',	'VVIrisHeartSceneDynamicWar.dds',	'VVIrisHeartSceneDynamicDefeat.dds');


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 				MajorCivApproachType, 				Bias)
VALUES		('LEADER_VV_IRIS_HEART', 	'MAJOR_CIV_APPROACH_WAR', 			9),
			('LEADER_VV_IRIS_HEART', 	'MAJOR_CIV_APPROACH_HOSTILE', 		6),
			('LEADER_VV_IRIS_HEART', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	7),
			('LEADER_VV_IRIS_HEART', 	'MAJOR_CIV_APPROACH_GUARDED', 		2),
			('LEADER_VV_IRIS_HEART', 	'MAJOR_CIV_APPROACH_AFRAID', 		1),
			('LEADER_VV_IRIS_HEART', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		8),
			('LEADER_VV_IRIS_HEART', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		3);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 				MinorCivApproachType, 				Bias)
VALUES		('LEADER_VV_IRIS_HEART', 	'MINOR_CIV_APPROACH_IGNORE', 		3),
			('LEADER_VV_IRIS_HEART', 	'MINOR_CIV_APPROACH_FRIENDLY', 		7),
			('LEADER_VV_IRIS_HEART', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	6),
			('LEADER_VV_IRIS_HEART', 	'MINOR_CIV_APPROACH_CONQUEST', 		2),
			('LEADER_VV_IRIS_HEART', 	'MINOR_CIV_APPROACH_BULLY', 		11);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 					FlavorType, 						Flavor)
VALUES		('LEADER_VV_IRIS_HEART', 	'FLAVOR_OFFENSE', 					6),
			('LEADER_VV_IRIS_HEART', 	'FLAVOR_DEFENSE', 					8),
			('LEADER_VV_IRIS_HEART', 	'FLAVOR_CITY_DEFENSE', 				6),
			('LEADER_VV_IRIS_HEART', 	'FLAVOR_MILITARY_TRAINING', 		4),
			('LEADER_VV_IRIS_HEART', 	'FLAVOR_RECON', 					3),
			('LEADER_VV_IRIS_HEART', 	'FLAVOR_RANGED', 					4),
			('LEADER_VV_IRIS_HEART', 	'FLAVOR_MOBILE', 					9),
			('LEADER_VV_IRIS_HEART', 	'FLAVOR_NAVAL', 					7),
			('LEADER_VV_IRIS_HEART', 	'FLAVOR_NAVAL_RECON', 				3),
			('LEADER_VV_IRIS_HEART', 	'FLAVOR_NAVAL_GROWTH', 				6),
			('LEADER_VV_IRIS_HEART', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
			('LEADER_VV_IRIS_HEART', 	'FLAVOR_AIR', 						7),
			('LEADER_VV_IRIS_HEART', 	'FLAVOR_EXPANSION', 				10),
			('LEADER_VV_IRIS_HEART', 	'FLAVOR_GROWTH', 					7),
			('LEADER_VV_IRIS_HEART', 	'FLAVOR_TILE_IMPROVEMENT', 			7),
			('LEADER_VV_IRIS_HEART', 	'FLAVOR_INFRASTRUCTURE', 			6),
			('LEADER_VV_IRIS_HEART', 	'FLAVOR_PRODUCTION', 				7),
			('LEADER_VV_IRIS_HEART', 	'FLAVOR_GOLD', 						3),
			('LEADER_VV_IRIS_HEART', 	'FLAVOR_SCIENCE', 					9),
			('LEADER_VV_IRIS_HEART', 	'FLAVOR_CULTURE', 					4),
			('LEADER_VV_IRIS_HEART', 	'FLAVOR_HAPPINESS', 				6),
			('LEADER_VV_IRIS_HEART', 	'FLAVOR_GREAT_PEOPLE', 				3),
			('LEADER_VV_IRIS_HEART', 	'FLAVOR_WONDER', 					6),
			('LEADER_VV_IRIS_HEART', 	'FLAVOR_RELIGION', 					8),
			('LEADER_VV_IRIS_HEART', 	'FLAVOR_DIPLOMACY', 				7),
			('LEADER_VV_IRIS_HEART', 	'FLAVOR_SPACESHIP', 				8),
			('LEADER_VV_IRIS_HEART', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_VV_IRIS_HEART', 	'FLAVOR_NUKE', 						7),
			('LEADER_VV_IRIS_HEART', 	'FLAVOR_USE_NUKE', 					2),
			('LEADER_VV_IRIS_HEART', 	'FLAVOR_ESPIONAGE', 				3),
			('LEADER_VV_IRIS_HEART', 	'FLAVOR_ANTIAIR',	 				4),
			('LEADER_VV_IRIS_HEART', 	'FLAVOR_AIR_CARRIER', 				7),
			('LEADER_VV_IRIS_HEART', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_VV_IRIS_HEART', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_VV_IRIS_HEART', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_VV_IRIS_HEART', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_VV_IRIS_HEART', 	'FLAVOR_ARCHAEOLOGY', 				4),
			('LEADER_VV_IRIS_HEART', 	'FLAVOR_AIRLIFT', 					6);


--*******************************************************************
-- Trait Definition (Iris Heart's Power) 
--*******************************************************************
INSERT INTO Traits
			(Type,					Description,					ShortDescription,					PlutiaDollSystemUseOnly,	CityStateBullyInfluenceShares,	KillsPerHappinessPersistsOnRevert)
VALUES		('TRAIT_VV_IRIS_HEART',	'TXT_KEY_TRAIT_VV_IRIS_HEART',	'TXT_KEY_TRAIT_VV_IRIS_HEART_SHORT',1,							1000,							10);


--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 				TraitType)
VALUES		('LEADER_VV_IRIS_HEART', 	'TRAIT_VV_IRIS_HEART');



--HDD Setup
INSERT INTO Trait_VV_HDDModes
			(NormalTraitType,	HDDTraitType,			NormalDummyBuilding,		HDDDummyBuilding,				ScriptName)
VALUES		('TRAIT_VV_PLUTIA',	'TRAIT_VV_IRIS_HEART',	'BUILDING_VV_PLUTIA_DUMMY',	'BUILDING_VV_IRIS_HEART_DUMMY',	'PlutiaIrisHeartTraitScript.lua');


INSERT INTO Trait_VV_HDD_PersistentPolicies
			(TraitType,				Policy,							DisabledPolicy,							TurnsNeeded)
VALUES		('TRAIT_VV_IRIS_HEART',	'POLICY_VV_IRIS_PERSISTENT',	'POLICY_VV_IRIS_PERSISTENT_DISABLED',	3);



--Dummy Policy
INSERT INTO Policies	
			(Type,									Description,						MinorBullyScoreModifier)
VALUES		('POLICY_VV_IRIS_PERSISTENT',			'TXT_KEY_TRAIT_VV_IRIS_HEART',		100),
			('POLICY_VV_IRIS_PERSISTENT_DISABLED',	'TXT_KEY_TRAIT_VV_IRIS_HEART',		0);