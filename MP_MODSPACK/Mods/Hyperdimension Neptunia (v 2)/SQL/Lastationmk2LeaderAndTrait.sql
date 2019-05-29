--*******************************************************************
-- Uni
--*******************************************************************

INSERT INTO Leaders 
			(Type, 					Description, 			Civilopedia, 						CivilopediaTag, 						ArtDefineTag,				
			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty,
			Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 								PortraitIndex,
			VV_LeaderSceneOverride,			VV_LeaderSceneOverrideFriendly,			VV_LeaderSceneOverrideGuarded,		VV_LeaderSceneOverrideHostile,
			VV_LeaderSceneOverrideAfraid,	VV_LeaderSceneOverrideDenouncing,		VV_LeaderSceneOverrideWar,				VV_LeaderSceneOverrideDefeat)
VALUES		('LEADER_VV_UNI', 	'TXT_KEY_LEADER_VV_UNI', 	'TXT_KEY_LEADER_VV_UNI_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_VV_UNI', 	'VVUniLeaderScene.xml',
			10, 						7, 						3, 							6, 			3, 				4, 				6, 						4, 				9,
			2, 			4, 				4, 			6, 			'CIV_COLOR_ATLAS_VV_LASTATION_UN', 	1,
			'VVUniLeaderSceneDynamic.dds',	'VVUniLeaderSceneDynamicFriendly.dds',	'VVUniLeaderSceneDynamicGuarded.dds', 'VVUniLeaderSceneDynamicHostile.dds',
			'VVUniLeaderSceneDynamicAfraid.dds', 'VVUniLeaderSceneDynamicHostile.dds', 'VVUniLeaderSceneDynamicHostile.dds', 'VVUniLeaderSceneDynamicDefeat.dds');


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 		MajorCivApproachType, 				Bias)
VALUES		('LEADER_VV_UNI', 	'MAJOR_CIV_APPROACH_WAR', 			6),
			('LEADER_VV_UNI', 	'MAJOR_CIV_APPROACH_HOSTILE', 		7),
			('LEADER_VV_UNI', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	4),
			('LEADER_VV_UNI', 	'MAJOR_CIV_APPROACH_GUARDED', 		4),
			('LEADER_VV_UNI', 	'MAJOR_CIV_APPROACH_AFRAID', 		4),
			('LEADER_VV_UNI', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		6),
			('LEADER_VV_UNI', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		8);
--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 		MinorCivApproachType, 				Bias)
VALUES		('LEADER_VV_UNI', 	'MINOR_CIV_APPROACH_IGNORE', 		3),
			('LEADER_VV_UNI', 	'MINOR_CIV_APPROACH_FRIENDLY', 		6),
			('LEADER_VV_UNI', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	5),
			('LEADER_VV_UNI', 	'MINOR_CIV_APPROACH_CONQUEST', 		3),
			('LEADER_VV_UNI', 	'MINOR_CIV_APPROACH_BULLY', 		4);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 		FlavorType, 						Flavor)
VALUES		('LEADER_VV_UNI', 	'FLAVOR_OFFENSE', 					3),
			('LEADER_VV_UNI', 	'FLAVOR_DEFENSE', 					7),
			('LEADER_VV_UNI', 	'FLAVOR_CITY_DEFENSE', 				7),
			('LEADER_VV_UNI', 	'FLAVOR_MILITARY_TRAINING', 		5),
			('LEADER_VV_UNI', 	'FLAVOR_RECON', 					3),
			('LEADER_VV_UNI', 	'FLAVOR_RANGED', 					8),
			('LEADER_VV_UNI', 	'FLAVOR_MOBILE', 					3),
			('LEADER_VV_UNI', 	'FLAVOR_NAVAL', 					6),
			('LEADER_VV_UNI', 	'FLAVOR_NAVAL_RECON', 				3),
			('LEADER_VV_UNI', 	'FLAVOR_NAVAL_GROWTH', 				5),
			('LEADER_VV_UNI', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
			('LEADER_VV_UNI', 	'FLAVOR_AIR', 						6),
			('LEADER_VV_UNI', 	'FLAVOR_EXPANSION', 				4),
			('LEADER_VV_UNI', 	'FLAVOR_GROWTH', 					8),
			('LEADER_VV_UNI', 	'FLAVOR_TILE_IMPROVEMENT', 			8),
			('LEADER_VV_UNI', 	'FLAVOR_INFRASTRUCTURE', 			6),
			('LEADER_VV_UNI', 	'FLAVOR_PRODUCTION', 				8),
			('LEADER_VV_UNI', 	'FLAVOR_GOLD', 						3),
			('LEADER_VV_UNI', 	'FLAVOR_SCIENCE', 					8),
			('LEADER_VV_UNI', 	'FLAVOR_CULTURE', 					5),
			('LEADER_VV_UNI', 	'FLAVOR_HAPPINESS', 				4),
			('LEADER_VV_UNI', 	'FLAVOR_GREAT_PEOPLE', 				4),
			('LEADER_VV_UNI', 	'FLAVOR_WONDER', 					3),
			('LEADER_VV_UNI', 	'FLAVOR_RELIGION', 					8),
			('LEADER_VV_UNI', 	'FLAVOR_DIPLOMACY', 				3),
			('LEADER_VV_UNI', 	'FLAVOR_SPACESHIP', 				9),
			('LEADER_VV_UNI', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_VV_UNI', 	'FLAVOR_NUKE', 						7),
			('LEADER_VV_UNI', 	'FLAVOR_USE_NUKE', 					5),
			('LEADER_VV_UNI', 	'FLAVOR_ESPIONAGE', 				9),
			('LEADER_VV_UNI', 	'FLAVOR_ANTIAIR',	 				6),
			('LEADER_VV_UNI', 	'FLAVOR_AIR_CARRIER', 				5),
			('LEADER_VV_UNI', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_VV_UNI', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_VV_UNI', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_VV_UNI', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_VV_UNI', 	'FLAVOR_ARCHAEOLOGY', 				4),
			('LEADER_VV_UNI', 	'FLAVOR_AIRLIFT', 					6);


--*******************************************************************
-- Trait Definition (Land of Black Regality) 
--*******************************************************************
INSERT INTO Traits
			(Type,				Description,			ShortDescription,				VV_Shares_Counterspies)
VALUES		('TRAIT_VV_UNI',	'TXT_KEY_TRAIT_VV_UNI',	'TXT_KEY_TRAIT_VV_UNI_SHORT',	8);


--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 		TraitType)
VALUES		('LEADER_VV_UNI', 	'TRAIT_VV_UNI');




------------------------------------------------------------------------------------------------------------------------------------------------------------


--*******************************************************************
-- Black Sister
--*******************************************************************

INSERT INTO Leaders 
			(Type, 						Description, 						Civilopedia, 						CivilopediaTag, 						ArtDefineTag,				
			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty,
			Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 						PortraitIndex,
			VV_LeaderSceneOverride,			VV_LeaderSceneOverrideFriendly,			VV_LeaderSceneOverrideGuarded,		VV_LeaderSceneOverrideHostile,
			VV_LeaderSceneOverrideAfraid,	VV_LeaderSceneOverrideDenouncing,		VV_LeaderSceneOverrideWar,				VV_LeaderSceneOverrideDefeat)
VALUES		('LEADER_VV_BLACK_SISTER', 	'TXT_KEY_LEADER_VV_BLACK_SISTER', 	'TXT_KEY_LEADER_VV_UNI_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_VV_UNI', 	'VVBlackSisterLeaderScene.xml',
			10, 						7, 						3, 							6, 			3, 				4, 				6, 						4, 				9,
			2, 			4, 				4, 			6, 			'CIV_COLOR_ATLAS_VV_LASTATION_UN', 	2,
			'VVBlackSisterLeaderSceneDynamic.dds',	'VVBlackSisterLeaderSceneDynamicFriendly.dds',	'VVBlackSisterLeaderSceneDynamicGuarded.dds', 'VVBlackSisterLeaderSceneDynamicHostile.dds',
			'VVBlackSisterLeaderSceneDynamicAfraid.dds', 'VVBlackSisterLeaderSceneDynamicWarDenouncing.dds', 'VVBlackSisterLeaderSceneDynamicWarDenouncing.dds', 'VVBlackSisterLeaderSceneDynamicDefeat.dds');


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 				MajorCivApproachType, 				Bias)
VALUES		('LEADER_VV_BLACK_SISTER', 	'MAJOR_CIV_APPROACH_WAR', 			6),
			('LEADER_VV_BLACK_SISTER', 	'MAJOR_CIV_APPROACH_HOSTILE', 		7),
			('LEADER_VV_BLACK_SISTER', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	4),
			('LEADER_VV_BLACK_SISTER', 	'MAJOR_CIV_APPROACH_GUARDED', 		4),
			('LEADER_VV_BLACK_SISTER', 	'MAJOR_CIV_APPROACH_AFRAID', 		4),
			('LEADER_VV_BLACK_SISTER', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		6),
			('LEADER_VV_BLACK_SISTER', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		8);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 				MinorCivApproachType, 				Bias)
VALUES		('LEADER_VV_BLACK_SISTER', 	'MINOR_CIV_APPROACH_IGNORE', 		3),
			('LEADER_VV_BLACK_SISTER', 	'MINOR_CIV_APPROACH_FRIENDLY', 		6),
			('LEADER_VV_BLACK_SISTER', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	5),
			('LEADER_VV_BLACK_SISTER', 	'MINOR_CIV_APPROACH_CONQUEST', 		3),
			('LEADER_VV_BLACK_SISTER', 	'MINOR_CIV_APPROACH_BULLY', 		4);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 				FlavorType, 						Flavor)
VALUES		('LEADER_VV_BLACK_SISTER', 	'FLAVOR_OFFENSE', 					3),
			('LEADER_VV_BLACK_SISTER', 	'FLAVOR_DEFENSE', 					7),
			('LEADER_VV_BLACK_SISTER', 	'FLAVOR_CITY_DEFENSE', 				7),
			('LEADER_VV_BLACK_SISTER', 	'FLAVOR_MILITARY_TRAINING', 		5),
			('LEADER_VV_BLACK_SISTER', 	'FLAVOR_RECON', 					3),
			('LEADER_VV_BLACK_SISTER', 	'FLAVOR_RANGED', 					11),
			('LEADER_VV_BLACK_SISTER', 	'FLAVOR_MOBILE', 					3),
			('LEADER_VV_BLACK_SISTER', 	'FLAVOR_NAVAL', 					6),
			('LEADER_VV_BLACK_SISTER', 	'FLAVOR_NAVAL_RECON', 				3),
			('LEADER_VV_BLACK_SISTER', 	'FLAVOR_NAVAL_GROWTH', 				5),
			('LEADER_VV_BLACK_SISTER', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
			('LEADER_VV_BLACK_SISTER', 	'FLAVOR_AIR', 						6),
			('LEADER_VV_BLACK_SISTER', 	'FLAVOR_EXPANSION', 				4),
			('LEADER_VV_BLACK_SISTER', 	'FLAVOR_GROWTH', 					8),
			('LEADER_VV_BLACK_SISTER', 	'FLAVOR_TILE_IMPROVEMENT', 			8),
			('LEADER_VV_BLACK_SISTER', 	'FLAVOR_INFRASTRUCTURE', 			6),
			('LEADER_VV_BLACK_SISTER', 	'FLAVOR_PRODUCTION', 				8),
			('LEADER_VV_BLACK_SISTER', 	'FLAVOR_GOLD', 						3),
			('LEADER_VV_BLACK_SISTER', 	'FLAVOR_SCIENCE', 					8),
			('LEADER_VV_BLACK_SISTER', 	'FLAVOR_CULTURE', 					5),
			('LEADER_VV_BLACK_SISTER', 	'FLAVOR_HAPPINESS', 				4),
			('LEADER_VV_BLACK_SISTER', 	'FLAVOR_GREAT_PEOPLE', 				4),
			('LEADER_VV_BLACK_SISTER', 	'FLAVOR_WONDER', 					3),
			('LEADER_VV_BLACK_SISTER', 	'FLAVOR_RELIGION', 					8),
			('LEADER_VV_BLACK_SISTER', 	'FLAVOR_DIPLOMACY', 				3),
			('LEADER_VV_BLACK_SISTER', 	'FLAVOR_SPACESHIP', 				9),
			('LEADER_VV_BLACK_SISTER', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_VV_BLACK_SISTER', 	'FLAVOR_NUKE', 						7),
			('LEADER_VV_BLACK_SISTER', 	'FLAVOR_USE_NUKE', 					5),
			('LEADER_VV_BLACK_SISTER', 	'FLAVOR_ESPIONAGE', 				9),
			('LEADER_VV_BLACK_SISTER', 	'FLAVOR_ANTIAIR',	 				6),
			('LEADER_VV_BLACK_SISTER', 	'FLAVOR_AIR_CARRIER', 				5),
			('LEADER_VV_BLACK_SISTER', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_VV_BLACK_SISTER', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_VV_BLACK_SISTER', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_VV_BLACK_SISTER', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_VV_BLACK_SISTER', 	'FLAVOR_ARCHAEOLOGY', 				4),
			('LEADER_VV_BLACK_SISTER', 	'FLAVOR_AIRLIFT', 					6);


--*******************************************************************
-- Trait Definition (Black Sister's Beauty) 
--*******************************************************************
INSERT INTO Traits
			(Type,						Description,						ShortDescription)
VALUES		('TRAIT_VV_BLACK_SISTER',	'TXT_KEY_TRAIT_VV_BLACK_SISTER',	'TXT_KEY_TRAIT_VV_BLACK_SISTER_SHORT');

INSERT INTO Trait_MaintenanceModifierUnitCombats
			(TraitType,					UnitCombatType,			MaintenanceModifier)
VALUES		('TRAIT_VV_BLACK_SISTER',	'UNITCOMBAT_ARCHER',	-50),
			('TRAIT_VV_BLACK_SISTER',	'UNITCOMBAT_SIEGE',		-50);


--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 				TraitType)
VALUES		('LEADER_VV_BLACK_SISTER', 	'TRAIT_VV_BLACK_SISTER');



--HDD Setup
INSERT INTO Trait_VV_HDDModes
			(NormalTraitType,	HDDTraitType,		NormalDummyBuilding,					HDDDummyBuilding,	
			ScriptName)
VALUES		('TRAIT_VV_UNI',	'TRAIT_VV_BLACK_SISTER',	'BUILDING_VV_LASTATION_UN_DUMMY_BUILDING_UNI', 'BUILDING_VV_LASTATION_UN_DUMMY_BUILDING_BLACK_SISTER',
			'UniBlackSisterTraitScript.lua');