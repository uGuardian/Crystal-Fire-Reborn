--*******************************************************************
-- Nepgear
--*******************************************************************

INSERT INTO Leaders 
			(Type, 					Description, 			Civilopedia, 						CivilopediaTag, 						ArtDefineTag,				
			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty,
			Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 								PortraitIndex,
			VV_LeaderSceneOverride,			VV_LeaderSceneOverrideFriendly,			VV_LeaderSceneOverrideGuarded,		VV_LeaderSceneOverrideHostile,
			VV_LeaderSceneOverrideAfraid,	VV_LeaderSceneOverrideDenouncing,		VV_LeaderSceneOverrideWar,				VV_LeaderSceneOverrideDefeat)
VALUES		('LEADER_VV_NEPGEAR', 	'TXT_KEY_LEADER_VV_NEPGEAR', 	'TXT_KEY_LEADER_VV_NEPGEAR_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_VV_NEPGEAR', 	'VVNepgearLeaderScene.xml',
			3, 						4, 						6, 							2, 			6, 				8, 				5, 						10, 			9,
			9, 			5, 				6, 			3, 			'CIV_COLOR_ATLAS_VV_PLANEPTUNE_NG', 	1,
			'VVNepgearLeaderSceneDynamic.dds',	'VVNepgearLeaderSceneDynamicFriendly.dds',	'VVNepgearLeaderSceneDynamicGuarded.dds', 'VVNepgearLeaderSceneDynamicHostile.dds',
			'VVNepgearLeaderSceneDynamicAfraid.dds','VVNepgearLeaderSceneDynamicWarDenouncing.dds',	'VVNepgearLeaderSceneDynamicWarDenouncing.dds', 'VVNepgearLeaderSceneDynamicDefeat.dds');


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 			MajorCivApproachType, 				Bias)
VALUES		('LEADER_VV_NEPGEAR', 	'MAJOR_CIV_APPROACH_WAR', 			2),
			('LEADER_VV_NEPGEAR', 	'MAJOR_CIV_APPROACH_HOSTILE', 		2),
			('LEADER_VV_NEPGEAR', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	1),
			('LEADER_VV_NEPGEAR', 	'MAJOR_CIV_APPROACH_GUARDED', 		6),
			('LEADER_VV_NEPGEAR', 	'MAJOR_CIV_APPROACH_AFRAID', 		5),
			('LEADER_VV_NEPGEAR', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		10),
			('LEADER_VV_NEPGEAR', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		6);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 			MinorCivApproachType, 				Bias)
VALUES		('LEADER_VV_NEPGEAR', 	'MINOR_CIV_APPROACH_IGNORE', 		2),
			('LEADER_VV_NEPGEAR', 	'MINOR_CIV_APPROACH_FRIENDLY', 		8),
			('LEADER_VV_NEPGEAR', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	7),
			('LEADER_VV_NEPGEAR', 	'MINOR_CIV_APPROACH_CONQUEST', 		2),
			('LEADER_VV_NEPGEAR', 	'MINOR_CIV_APPROACH_BULLY', 		3);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 			FlavorType, 						Flavor)
VALUES		('LEADER_VV_NEPGEAR', 	'FLAVOR_OFFENSE', 					3),
			('LEADER_VV_NEPGEAR', 	'FLAVOR_DEFENSE', 					5),
			('LEADER_VV_NEPGEAR', 	'FLAVOR_CITY_DEFENSE', 				6),
			('LEADER_VV_NEPGEAR', 	'FLAVOR_MILITARY_TRAINING', 		4),
			('LEADER_VV_NEPGEAR', 	'FLAVOR_RECON', 					3),
			('LEADER_VV_NEPGEAR', 	'FLAVOR_RANGED', 					4),
			('LEADER_VV_NEPGEAR', 	'FLAVOR_MOBILE', 					9),
			('LEADER_VV_NEPGEAR', 	'FLAVOR_NAVAL', 					7),
			('LEADER_VV_NEPGEAR', 	'FLAVOR_NAVAL_RECON', 				3),
			('LEADER_VV_NEPGEAR', 	'FLAVOR_NAVAL_GROWTH', 				6),
			('LEADER_VV_NEPGEAR', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
			('LEADER_VV_NEPGEAR', 	'FLAVOR_AIR', 						7),
			('LEADER_VV_NEPGEAR', 	'FLAVOR_EXPANSION', 				5),
			('LEADER_VV_NEPGEAR', 	'FLAVOR_GROWTH', 					7),
			('LEADER_VV_NEPGEAR', 	'FLAVOR_TILE_IMPROVEMENT', 			7),
			('LEADER_VV_NEPGEAR', 	'FLAVOR_INFRASTRUCTURE', 			6),
			('LEADER_VV_NEPGEAR', 	'FLAVOR_PRODUCTION', 				7),
			('LEADER_VV_NEPGEAR', 	'FLAVOR_GOLD', 						3),
			('LEADER_VV_NEPGEAR', 	'FLAVOR_SCIENCE', 					9),
			('LEADER_VV_NEPGEAR', 	'FLAVOR_CULTURE', 					4),
			('LEADER_VV_NEPGEAR', 	'FLAVOR_HAPPINESS', 				6),
			('LEADER_VV_NEPGEAR', 	'FLAVOR_GREAT_PEOPLE', 				3),
			('LEADER_VV_NEPGEAR', 	'FLAVOR_WONDER', 					6),
			('LEADER_VV_NEPGEAR', 	'FLAVOR_RELIGION', 					8),
			('LEADER_VV_NEPGEAR', 	'FLAVOR_DIPLOMACY', 				7),
			('LEADER_VV_NEPGEAR', 	'FLAVOR_SPACESHIP', 				8),
			('LEADER_VV_NEPGEAR', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_VV_NEPGEAR', 	'FLAVOR_NUKE', 						7),
			('LEADER_VV_NEPGEAR', 	'FLAVOR_USE_NUKE', 					2),
			('LEADER_VV_NEPGEAR', 	'FLAVOR_ESPIONAGE', 				3),
			('LEADER_VV_NEPGEAR', 	'FLAVOR_ANTIAIR',	 				4),
			('LEADER_VV_NEPGEAR', 	'FLAVOR_AIR_CARRIER', 				7),
			('LEADER_VV_NEPGEAR', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_VV_NEPGEAR', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_VV_NEPGEAR', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_VV_NEPGEAR', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_VV_NEPGEAR', 	'FLAVOR_ARCHAEOLOGY', 				4),
			('LEADER_VV_NEPGEAR', 	'FLAVOR_AIRLIFT', 					6);


--*******************************************************************
-- Trait Definition (Land of Purple Progress) 
--*******************************************************************
INSERT INTO Traits
			(Type,					Description,				ShortDescription,					VV_Shares_Friendships,	VV_Shares_CSAllies)
VALUES		('TRAIT_VV_NEPGEAR',	'TXT_KEY_TRAIT_VV_NEPGEAR',	'TXT_KEY_TRAIT_VV_NEPGEAR_SHORT',	4,						2);


--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 			TraitType)
VALUES		('LEADER_VV_NEPGEAR', 	'TRAIT_VV_NEPGEAR');




------------------------------------------------------------------------------------------------------------------------------------------------------------


--*******************************************************************
-- Purple Sister
--*******************************************************************

INSERT INTO Leaders 
			(Type, 						Description, 						Civilopedia, 						CivilopediaTag, 						ArtDefineTag,				
			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty,
			Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 						PortraitIndex,
			VV_LeaderSceneOverride,			VV_LeaderSceneOverrideFriendly,			VV_LeaderSceneOverrideGuarded,		VV_LeaderSceneOverrideHostile,
			VV_LeaderSceneOverrideAfraid,	VV_LeaderSceneOverrideDenouncing,		VV_LeaderSceneOverrideWar,				VV_LeaderSceneOverrideDefeat)
VALUES		('LEADER_VV_PURPLE_SISTER', 	'TXT_KEY_LEADER_VV_PURPLE_SISTER', 	'TXT_KEY_LEADER_VV_NEPGEAR_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_VV_NEPGEAR', 	'VVPurpleSisterLeaderScene.xml',
			3, 						4, 						6, 							2, 			6, 				8, 				5, 						10, 			9,
			9, 			5, 				6, 			3, 			'CIV_COLOR_ATLAS_VV_PLANEPTUNE_NG', 	2,
			'VVPurpleSisterLeaderSceneDynamic.dds',	'VVPurpleSisterLeaderSceneDynamicFriendly.dds',	'VVPurpleSisterLeaderSceneDynamicGuarded.dds', 'VVPurpleSisterLeaderSceneDynamicHostile.dds',
			'VVPurpleSisterLeaderSceneDynamicAfraid.dds',	'VVPurpleSisterLeaderSceneDynamicWarDenouncing.dds',	'VVPurpleSisterLeaderSceneDynamicWarDenouncing.dds', 'VVPurpleSisterLeaderSceneDynamicDefeat.dds');


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 					MajorCivApproachType, 				Bias)
VALUES		('LEADER_VV_PURPLE_SISTER', 	'MAJOR_CIV_APPROACH_WAR', 			2),
			('LEADER_VV_PURPLE_SISTER', 	'MAJOR_CIV_APPROACH_HOSTILE', 		2),
			('LEADER_VV_PURPLE_SISTER', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	1),
			('LEADER_VV_PURPLE_SISTER', 	'MAJOR_CIV_APPROACH_GUARDED', 		6),
			('LEADER_VV_PURPLE_SISTER', 	'MAJOR_CIV_APPROACH_AFRAID', 		5),
			('LEADER_VV_PURPLE_SISTER', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		10),
			('LEADER_VV_PURPLE_SISTER', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		6);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 					MinorCivApproachType, 				Bias)
VALUES		('LEADER_VV_PURPLE_SISTER', 	'MINOR_CIV_APPROACH_IGNORE', 		2),
			('LEADER_VV_PURPLE_SISTER', 	'MINOR_CIV_APPROACH_FRIENDLY', 		8),
			('LEADER_VV_PURPLE_SISTER', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	7),
			('LEADER_VV_PURPLE_SISTER', 	'MINOR_CIV_APPROACH_CONQUEST', 		2),
			('LEADER_VV_PURPLE_SISTER', 	'MINOR_CIV_APPROACH_BULLY', 		3);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 					FlavorType, 						Flavor)
VALUES		('LEADER_VV_PURPLE_SISTER', 	'FLAVOR_OFFENSE', 					6),
			('LEADER_VV_PURPLE_SISTER', 	'FLAVOR_DEFENSE', 					8),
			('LEADER_VV_PURPLE_SISTER', 	'FLAVOR_CITY_DEFENSE', 				6),
			('LEADER_VV_PURPLE_SISTER', 	'FLAVOR_MILITARY_TRAINING', 		4),
			('LEADER_VV_PURPLE_SISTER', 	'FLAVOR_RECON', 					3),
			('LEADER_VV_PURPLE_SISTER', 	'FLAVOR_RANGED', 					4),
			('LEADER_VV_PURPLE_SISTER', 	'FLAVOR_MOBILE', 					9),
			('LEADER_VV_PURPLE_SISTER', 	'FLAVOR_NAVAL', 					7),
			('LEADER_VV_PURPLE_SISTER', 	'FLAVOR_NAVAL_RECON', 				3),
			('LEADER_VV_PURPLE_SISTER', 	'FLAVOR_NAVAL_GROWTH', 				6),
			('LEADER_VV_PURPLE_SISTER', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
			('LEADER_VV_PURPLE_SISTER', 	'FLAVOR_AIR', 						7),
			('LEADER_VV_PURPLE_SISTER', 	'FLAVOR_EXPANSION', 				5),
			('LEADER_VV_PURPLE_SISTER', 	'FLAVOR_GROWTH', 					7),
			('LEADER_VV_PURPLE_SISTER', 	'FLAVOR_TILE_IMPROVEMENT', 			7),
			('LEADER_VV_PURPLE_SISTER', 	'FLAVOR_INFRASTRUCTURE', 			6),
			('LEADER_VV_PURPLE_SISTER', 	'FLAVOR_PRODUCTION', 				7),
			('LEADER_VV_PURPLE_SISTER', 	'FLAVOR_GOLD', 						3),
			('LEADER_VV_PURPLE_SISTER', 	'FLAVOR_SCIENCE', 					9),
			('LEADER_VV_PURPLE_SISTER', 	'FLAVOR_CULTURE', 					4),
			('LEADER_VV_PURPLE_SISTER', 	'FLAVOR_HAPPINESS', 				6),
			('LEADER_VV_PURPLE_SISTER', 	'FLAVOR_GREAT_PEOPLE', 				3),
			('LEADER_VV_PURPLE_SISTER', 	'FLAVOR_WONDER', 					6),
			('LEADER_VV_PURPLE_SISTER', 	'FLAVOR_RELIGION', 					8),
			('LEADER_VV_PURPLE_SISTER', 	'FLAVOR_DIPLOMACY', 				7),
			('LEADER_VV_PURPLE_SISTER', 	'FLAVOR_SPACESHIP', 				8),
			('LEADER_VV_PURPLE_SISTER', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_VV_PURPLE_SISTER', 	'FLAVOR_NUKE', 						7),
			('LEADER_VV_PURPLE_SISTER', 	'FLAVOR_USE_NUKE', 					2),
			('LEADER_VV_PURPLE_SISTER', 	'FLAVOR_ESPIONAGE', 				3),
			('LEADER_VV_PURPLE_SISTER', 	'FLAVOR_ANTIAIR',	 				4),
			('LEADER_VV_PURPLE_SISTER', 	'FLAVOR_AIR_CARRIER', 				7),
			('LEADER_VV_PURPLE_SISTER', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_VV_PURPLE_SISTER', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_VV_PURPLE_SISTER', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_VV_PURPLE_SISTER', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_VV_PURPLE_SISTER', 	'FLAVOR_ARCHAEOLOGY', 				4),
			('LEADER_VV_PURPLE_SISTER', 	'FLAVOR_AIRLIFT', 					6);


--*******************************************************************
-- Trait Definition (Purple Sister's Passion) 
--*******************************************************************
INSERT INTO Traits
			(Type,						Description,						ShortDescription,						VV_Shares_HDDCostChange)
VALUES		('TRAIT_VV_PURPLE_SISTER',	'TXT_KEY_TRAIT_VV_PURPLE_SISTER',	'TXT_KEY_TRAIT_VV_PURPLE_SISTER_SHORT',	-50);



--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 				TraitType)
VALUES		('LEADER_VV_PURPLE_SISTER', 	'TRAIT_VV_PURPLE_SISTER');



--HDD Setup
INSERT INTO Trait_VV_HDDModes
			(NormalTraitType,		HDDTraitType,				NormalDummyBuilding,								HDDDummyBuilding,	
			ScriptName)
VALUES		('TRAIT_VV_NEPGEAR',	'TRAIT_VV_PURPLE_SISTER',	'BUILDING_VV_PLANEPTUNE_NG_DUMMY_BUILDING_NEPGEAR', 'BUILDING_VV_PLANEPTUNE_NG_DUMMY_BUILDING_PURPLE_SISTER',
			'NepgearPurpleSisterTraitScript.lua');



--*******************************************************************
-- Trait Dummy stuff (feature)
--*******************************************************************

INSERT INTO Features
			(Type,						Description,					Civilopedia)
VALUES		('FEATURE_VV_TECH_EXPO',	'TXT_KEY_FEATURE_VV_TECH_EXPO',	'TXT_KEY_FEATURE_VV_TECH_EXPO_PEDIA');