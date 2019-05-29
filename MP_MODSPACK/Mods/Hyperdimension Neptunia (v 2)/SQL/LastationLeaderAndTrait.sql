--*******************************************************************
-- Noire
--*******************************************************************

INSERT INTO Leaders 
			(Type, 					Description, 			Civilopedia, 						CivilopediaTag, 						ArtDefineTag,				
			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty,
			Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 						PortraitIndex,
			VV_LeaderSceneOverride,			VV_LeaderSceneOverrideFriendly,			VV_LeaderSceneOverrideGuarded,		VV_LeaderSceneOverrideHostile,
			VV_LeaderSceneOverrideAfraid,	VV_LeaderSceneOverrideDenouncing,		VV_LeaderSceneOverrideWar,				VV_LeaderSceneOverrideDefeat)
VALUES		('LEADER_VV_NOIRE', 	'TXT_KEY_LEADER_VV_NOIRE', 	'TXT_KEY_LEADER_VV_NOIRE_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_VV_NOIRE', 	'VVNoireScene.xml',
			7, 						9, 						2, 							6, 			4, 				3, 				7, 						2, 				7,
			2, 			2, 				2, 			7, 			'CIV_COLOR_ATLAS_VV_LASTATION', 	1,
			'VVNoireSceneDynamic.dds',	'VVNoireSceneDynamicFriendly.dds',	'VVNoireSceneDynamicGuarded.dds', 'VVNoireSceneDynamicHostile.dds',
			'VVNoireSceneDynamicAfraid.dds',	'VVNoireSceneDynamicDenouncing.dds',	'VVNoireSceneDynamicWar.dds', 'VVNoireSceneDynamicDefeat.dds');



--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 			MajorCivApproachType, 				Bias)
VALUES		('LEADER_VV_NOIRE', 	'MAJOR_CIV_APPROACH_WAR', 			7),
			('LEADER_VV_NOIRE', 	'MAJOR_CIV_APPROACH_HOSTILE', 		5),
			('LEADER_VV_NOIRE', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	4),
			('LEADER_VV_NOIRE', 	'MAJOR_CIV_APPROACH_GUARDED', 		8),
			('LEADER_VV_NOIRE', 	'MAJOR_CIV_APPROACH_AFRAID', 		5),
			('LEADER_VV_NOIRE', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		2),
			('LEADER_VV_NOIRE', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		6);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 			MinorCivApproachType, 				Bias)
VALUES		('LEADER_VV_NOIRE', 	'MINOR_CIV_APPROACH_IGNORE', 		5),
			('LEADER_VV_NOIRE', 	'MINOR_CIV_APPROACH_FRIENDLY', 		3),
			('LEADER_VV_NOIRE', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	3),
			('LEADER_VV_NOIRE', 	'MINOR_CIV_APPROACH_CONQUEST', 		5),
			('LEADER_VV_NOIRE', 	'MINOR_CIV_APPROACH_BULLY', 		6);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 				FlavorType, 						Flavor)
VALUES		('LEADER_VV_NOIRE', 	'FLAVOR_OFFENSE', 					7),
			('LEADER_VV_NOIRE', 	'FLAVOR_DEFENSE', 					6),
			('LEADER_VV_NOIRE', 	'FLAVOR_CITY_DEFENSE', 				4),
			('LEADER_VV_NOIRE', 	'FLAVOR_MILITARY_TRAINING', 		8),
			('LEADER_VV_NOIRE', 	'FLAVOR_RECON', 					4),
			('LEADER_VV_NOIRE', 	'FLAVOR_RANGED', 					5),
			('LEADER_VV_NOIRE', 	'FLAVOR_MOBILE', 					5),
			('LEADER_VV_NOIRE', 	'FLAVOR_NAVAL', 					7),
			('LEADER_VV_NOIRE', 	'FLAVOR_NAVAL_RECON', 				4),
			('LEADER_VV_NOIRE', 	'FLAVOR_NAVAL_GROWTH', 				5),
			('LEADER_VV_NOIRE', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	4),
			('LEADER_VV_NOIRE', 	'FLAVOR_AIR', 						6),
			('LEADER_VV_NOIRE', 	'FLAVOR_EXPANSION', 				8),
			('LEADER_VV_NOIRE', 	'FLAVOR_GROWTH', 					4),
			('LEADER_VV_NOIRE', 	'FLAVOR_TILE_IMPROVEMENT', 			7),
			('LEADER_VV_NOIRE', 	'FLAVOR_INFRASTRUCTURE', 			7),
			('LEADER_VV_NOIRE', 	'FLAVOR_PRODUCTION', 				8),
			('LEADER_VV_NOIRE', 	'FLAVOR_GOLD', 						4),
			('LEADER_VV_NOIRE', 	'FLAVOR_SCIENCE', 					8),
			('LEADER_VV_NOIRE', 	'FLAVOR_CULTURE', 					5),
			('LEADER_VV_NOIRE', 	'FLAVOR_HAPPINESS', 				3),
			('LEADER_VV_NOIRE', 	'FLAVOR_GREAT_PEOPLE', 				4),
			('LEADER_VV_NOIRE', 	'FLAVOR_WONDER', 					9),
			('LEADER_VV_NOIRE', 	'FLAVOR_RELIGION', 					6),
			('LEADER_VV_NOIRE', 	'FLAVOR_DIPLOMACY', 				1),
			('LEADER_VV_NOIRE', 	'FLAVOR_SPACESHIP', 				8),
			('LEADER_VV_NOIRE', 	'FLAVOR_WATER_CONNECTION', 			3),
			('LEADER_VV_NOIRE', 	'FLAVOR_NUKE', 						7),
			('LEADER_VV_NOIRE', 	'FLAVOR_USE_NUKE', 					5),
			('LEADER_VV_NOIRE', 	'FLAVOR_ESPIONAGE', 				3),
			('LEADER_VV_NOIRE', 	'FLAVOR_ANTIAIR',	 				5),
			('LEADER_VV_NOIRE', 	'FLAVOR_AIR_CARRIER', 				6),
			('LEADER_VV_NOIRE', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_VV_NOIRE', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_VV_NOIRE', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_VV_NOIRE', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_VV_NOIRE', 	'FLAVOR_ARCHAEOLOGY', 				2),
			('LEADER_VV_NOIRE', 	'FLAVOR_AIRLIFT', 					6);


--*******************************************************************
-- Trait Definition (Land of Black Regality) 
--*******************************************************************
INSERT INTO Traits
			(Type,				Description,				ShortDescription,				VV_Shares_Wonders)
VALUES		('TRAIT_VV_NOIRE',	'TXT_KEY_TRAIT_VV_NOIRE',	'TXT_KEY_TRAIT_VV_NOIRE_SHORT',	2);


--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 		TraitType)
VALUES		('LEADER_VV_NOIRE', 	'TRAIT_VV_NOIRE');




------------------------------------------------------------------------------------------------------------------------------------------------------------


--*******************************************************************
-- Black Heart
--*******************************************************************

INSERT INTO Leaders 
			(Type, 						Description, 						Civilopedia, 						CivilopediaTag, 						ArtDefineTag,				
			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty,
			Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 						PortraitIndex,
			VV_LeaderSceneOverride,			VV_LeaderSceneOverrideFriendly,			VV_LeaderSceneOverrideGuarded,		VV_LeaderSceneOverrideHostile,
			VV_LeaderSceneOverrideAfraid,	VV_LeaderSceneOverrideDenouncing,		VV_LeaderSceneOverrideWar,				VV_LeaderSceneOverrideDefeat)
VALUES		('LEADER_VV_BLACK_HEART', 	'TXT_KEY_LEADER_VV_BLACK_HEART', 	'TXT_KEY_LEADER_VV_NOIRE_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_VV_NOIRE', 	'VVNoireScene.xml',
			7, 						9, 						2, 							7, 			4, 				3, 				7, 						2, 				7,
			2, 			2, 				2, 			7, 			'CIV_COLOR_ATLAS_VV_LASTATION', 	2,
			'VVBlackHeartSceneDynamic.dds',	'VVBlackHeartSceneDynamicFriendly.dds',	'VVBlackHeartSceneDynamicGuarded.dds', 'VVBlackHeartSceneDynamicHostile.dds',
			'VVBlackHeartSceneDynamicAfraid.dds',	'VVBlackHeartSceneDynamicDenouncing.dds',	'VVBlackHeartSceneDynamicWar.dds', 'VVBlackHeartSceneDynamicDefeat.dds');


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 				MajorCivApproachType, Bias)
SELECT		('LEADER_VV_BLACK_HEART'), 	MajorCivApproachType, Bias
FROM Leader_MajorCivApproachBiases WHERE LeaderType = 'LEADER_VV_NOIRE';

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 				MinorCivApproachType, Bias)
SELECT		('LEADER_VV_BLACK_HEART'), 	MinorCivApproachType, Bias
FROM Leader_MinorCivApproachBiases WHERE LeaderType = 'LEADER_VV_NOIRE';

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 				FlavorType, Flavor)
SELECT		('LEADER_VV_BLACK_HEART'), 	FlavorType, Flavor
FROM Leader_Flavors WHERE LeaderType = 'LEADER_VV_NOIRE';


--*******************************************************************
-- Trait Definition (Black Heart's Beauty) 
--*******************************************************************
INSERT INTO Traits
			(Type,						Description,					ShortDescription)
VALUES		('TRAIT_VV_BLACK_HEART',	'TXT_KEY_TRAIT_VV_BLACK_HEART',	'TXT_KEY_TRAIT_VV_BLACK_HEART_SHORT');



--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 				TraitType)
VALUES		('LEADER_VV_BLACK_HEART', 	'TRAIT_VV_BLACK_HEART');



--HDD Setup
INSERT INTO Trait_VV_HDDModes
			(NormalTraitType,		HDDTraitType,		NormalDummyBuilding,							HDDDummyBuilding,	
			ScriptName)
VALUES		('TRAIT_VV_NOIRE',	'TRAIT_VV_BLACK_HEART',	'BUILDING_VV_LASTATION_DUMMY_BUILDING_NOIRE',	'BUILDING_VV_LASTATION_DUMMY_BUILDING_BLACK_HEART',
			'NoireBlackHeartTraitScript.lua');



--*******************************************************************************************************************************************************************
-- ULTRADIMENSION
--*******************************************************************************************************************************************************************



--*******************************************************************
-- Noire
--*******************************************************************

INSERT INTO Leaders 
			(Type, 					Description, 			Civilopedia, 						CivilopediaTag, 						ArtDefineTag,				
			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty,
			Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 						PortraitIndex,
			VV_LeaderSceneOverride,			VV_LeaderSceneOverrideFriendly,			VV_LeaderSceneOverrideGuarded,		VV_LeaderSceneOverrideHostile,
			VV_LeaderSceneOverrideAfraid,	VV_LeaderSceneOverrideDenouncing,		VV_LeaderSceneOverrideWar,				VV_LeaderSceneOverrideDefeat)
VALUES		('LEADER_VV_NOIRE_ULTRA', 	'TXT_KEY_LEADER_VV_NOIRE', 	'TXT_KEY_LEADER_VV_NOIRE_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_VV_NOIRE', 	'VVNoireScene.xml',
			6, 						9, 						2, 							5, 			6, 				5, 				6, 						4, 				9,
			3, 			3, 				4, 			6, 			'CIV_COLOR_ATLAS_VV_LASTATION_ULTRA',1,
			'VVNoireSceneDynamicUltra.dds',	'VVNoireSceneDynamicFriendlyUltra.dds',	'VVNoireSceneDynamicGuardedUltra.dds', 'VVNoireSceneDynamicHostileUltra.dds',
			'VVNoireSceneDynamicAfraidUltra.dds',	'VVNoireSceneDynamicDenouncingUltra.dds',	'VVNoireSceneDynamicWarUltra.dds', 'VVNoireSceneDynamicDefeatUltra.dds');


--UD Noire is nicer than HD Noire (unlike UD Blanc and Vert with their HD counterparts).
--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 				MajorCivApproachType, 				Bias)
VALUES		('LEADER_VV_NOIRE_ULTRA', 	'MAJOR_CIV_APPROACH_WAR', 			5),
			('LEADER_VV_NOIRE_ULTRA', 	'MAJOR_CIV_APPROACH_HOSTILE', 		5),
			('LEADER_VV_NOIRE_ULTRA', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	4),
			('LEADER_VV_NOIRE_ULTRA', 	'MAJOR_CIV_APPROACH_GUARDED', 		7),
			('LEADER_VV_NOIRE_ULTRA', 	'MAJOR_CIV_APPROACH_AFRAID', 		4),
			('LEADER_VV_NOIRE_ULTRA', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		4),
			('LEADER_VV_NOIRE_ULTRA', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		6);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 				MinorCivApproachType, 				Bias)
VALUES		('LEADER_VV_NOIRE_ULTRA', 	'MINOR_CIV_APPROACH_IGNORE', 		5),
			('LEADER_VV_NOIRE_ULTRA', 	'MINOR_CIV_APPROACH_FRIENDLY', 		5),
			('LEADER_VV_NOIRE_ULTRA', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	4),
			('LEADER_VV_NOIRE_ULTRA', 	'MINOR_CIV_APPROACH_CONQUEST', 		2),
			('LEADER_VV_NOIRE_ULTRA', 	'MINOR_CIV_APPROACH_BULLY', 		5);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 				FlavorType, 						Flavor)
VALUES		('LEADER_VV_NOIRE_ULTRA', 	'FLAVOR_OFFENSE', 					6),
			('LEADER_VV_NOIRE_ULTRA', 	'FLAVOR_DEFENSE', 					4),
			('LEADER_VV_NOIRE_ULTRA', 	'FLAVOR_CITY_DEFENSE', 				4),
			('LEADER_VV_NOIRE_ULTRA', 	'FLAVOR_MILITARY_TRAINING', 		7),
			('LEADER_VV_NOIRE_ULTRA', 	'FLAVOR_RECON', 					5),
			('LEADER_VV_NOIRE_ULTRA', 	'FLAVOR_RANGED', 					4),
			('LEADER_VV_NOIRE_ULTRA', 	'FLAVOR_MOBILE', 					6),
			('LEADER_VV_NOIRE_ULTRA', 	'FLAVOR_NAVAL', 					6),
			('LEADER_VV_NOIRE_ULTRA', 	'FLAVOR_NAVAL_RECON', 				4),
			('LEADER_VV_NOIRE_ULTRA', 	'FLAVOR_NAVAL_GROWTH', 				5),
			('LEADER_VV_NOIRE_ULTRA', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	4),
			('LEADER_VV_NOIRE_ULTRA', 	'FLAVOR_AIR', 						6),
			('LEADER_VV_NOIRE_ULTRA', 	'FLAVOR_EXPANSION', 				6),
			('LEADER_VV_NOIRE_ULTRA', 	'FLAVOR_GROWTH', 					5),
			('LEADER_VV_NOIRE_ULTRA', 	'FLAVOR_TILE_IMPROVEMENT', 			7),
			('LEADER_VV_NOIRE_ULTRA', 	'FLAVOR_INFRASTRUCTURE', 			7),
			('LEADER_VV_NOIRE_ULTRA', 	'FLAVOR_PRODUCTION', 				7),
			('LEADER_VV_NOIRE_ULTRA', 	'FLAVOR_GOLD', 						4),
			('LEADER_VV_NOIRE_ULTRA', 	'FLAVOR_SCIENCE', 					9),
			('LEADER_VV_NOIRE_ULTRA', 	'FLAVOR_CULTURE', 					6),
			('LEADER_VV_NOIRE_ULTRA', 	'FLAVOR_HAPPINESS', 				3),
			('LEADER_VV_NOIRE_ULTRA', 	'FLAVOR_GREAT_PEOPLE', 				4),
			('LEADER_VV_NOIRE_ULTRA', 	'FLAVOR_WONDER', 					10),
			('LEADER_VV_NOIRE_ULTRA', 	'FLAVOR_RELIGION', 					5),
			('LEADER_VV_NOIRE_ULTRA', 	'FLAVOR_DIPLOMACY', 				3),
			('LEADER_VV_NOIRE_ULTRA', 	'FLAVOR_SPACESHIP', 				9),
			('LEADER_VV_NOIRE_ULTRA', 	'FLAVOR_WATER_CONNECTION', 			3),
			('LEADER_VV_NOIRE_ULTRA', 	'FLAVOR_NUKE', 						5),
			('LEADER_VV_NOIRE_ULTRA', 	'FLAVOR_USE_NUKE', 					3),
			('LEADER_VV_NOIRE_ULTRA', 	'FLAVOR_ESPIONAGE', 				3),
			('LEADER_VV_NOIRE_ULTRA', 	'FLAVOR_ANTIAIR',	 				5),
			('LEADER_VV_NOIRE_ULTRA', 	'FLAVOR_AIR_CARRIER', 				6),
			('LEADER_VV_NOIRE_ULTRA', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_VV_NOIRE_ULTRA', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_VV_NOIRE_ULTRA', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_VV_NOIRE_ULTRA', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_VV_NOIRE_ULTRA', 	'FLAVOR_ARCHAEOLOGY', 				2),
			('LEADER_VV_NOIRE_ULTRA', 	'FLAVOR_AIRLIFT', 					6);



--*******************************************************************
-- Trait Definition (Land of Black Regality) 
--*******************************************************************
INSERT INTO Traits
			(Type,						Description,				ShortDescription,				VV_Shares_Wonders)
VALUES		('TRAIT_VV_NOIRE_ULTRA',	'TXT_KEY_TRAIT_VV_NOIRE_U',	'TXT_KEY_TRAIT_VV_NOIRE_SHORT',	2);


--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 				TraitType)
VALUES		('LEADER_VV_NOIRE_ULTRA', 	'TRAIT_VV_NOIRE_ULTRA');




------------------------------------------------------------------------------------------------------------------------------------------------------------


--*******************************************************************
-- Black Heart
--*******************************************************************

INSERT INTO Leaders 
			(Type, 						Description, 						Civilopedia, 						CivilopediaTag, 						ArtDefineTag,				
			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty,
			Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 						PortraitIndex,
			VV_LeaderSceneOverride,			VV_LeaderSceneOverrideFriendly,			VV_LeaderSceneOverrideGuarded,		VV_LeaderSceneOverrideHostile,
			VV_LeaderSceneOverrideAfraid,	VV_LeaderSceneOverrideDenouncing,		VV_LeaderSceneOverrideWar,				VV_LeaderSceneOverrideDefeat)
VALUES		('LEADER_VV_BLACK_HEART_ULTRA', 	'TXT_KEY_LEADER_VV_BLACK_HEART', 	'TXT_KEY_LEADER_VV_NOIRE_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_VV_NOIRE', 	'VVNoireScene.xml',
			6, 						9, 						2, 							5, 			6, 				5, 				6, 						4, 				9,
			3, 			3, 				4, 			6, 			'CIV_COLOR_ATLAS_VV_LASTATION_ULTRA',2,
			'VVBlackHeartSceneDynamicUltra.dds',	'VVBlackHeartSceneDynamicFriendlyUltra.dds',	'VVBlackHeartSceneDynamicGuardedUltra.dds', 'VVBlackHeartSceneDynamicHostileUltra.dds',
			'VVBlackHeartSceneDynamicAfraidUltra.dds',	'VVBlackHeartSceneDynamicDenouncingUltra.dds',	'VVBlackHeartSceneDynamicWarUltra.dds', 'VVBlackHeartSceneDynamicDefeatUltra.dds');


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 						MajorCivApproachType, Bias)
SELECT		('LEADER_VV_BLACK_HEART_ULTRA'), 	MajorCivApproachType, Bias
FROM Leader_MajorCivApproachBiases WHERE LeaderType = 'LEADER_VV_NOIRE_ULTRA';

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 						MinorCivApproachType, Bias)
SELECT		('LEADER_VV_BLACK_HEART_ULTRA'), 	MinorCivApproachType, Bias
FROM Leader_MinorCivApproachBiases WHERE LeaderType = 'LEADER_VV_NOIRE_ULTRA';

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 						FlavorType, Flavor)
SELECT		('LEADER_VV_BLACK_HEART_ULTRA'), 	FlavorType, Flavor
FROM Leader_Flavors WHERE LeaderType = 'LEADER_VV_NOIRE_ULTRA';


--*******************************************************************
-- Trait Definition (Black Heart's Beauty) 
--*******************************************************************
INSERT INTO Traits
			(Type,							Description,						ShortDescription)
VALUES		('TRAIT_VV_BLACK_HEART_ULTRA',	'TXT_KEY_TRAIT_VV_BLACK_HEART_U',	'TXT_KEY_TRAIT_VV_BLACK_HEART_SHORT');



--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 						TraitType)
VALUES		('LEADER_VV_BLACK_HEART_ULTRA', 	'TRAIT_VV_BLACK_HEART_ULTRA');



--HDD Setup
INSERT INTO Trait_VV_HDDModes
			(NormalTraitType,			HDDTraitType,					NormalDummyBuilding,						HDDDummyBuilding,	
			ScriptName)
VALUES		('TRAIT_VV_NOIRE_ULTRA',	'TRAIT_VV_BLACK_HEART_ULTRA',	'BUILDING_VV_LASTATION_DUMMY_BUILDING_NOIRE', 'BUILDING_VV_LASTATION_DUMMY_BUILDING_BLACK_HEART_U',
			'NoireBlackHeartTraitScript.lua');
			

			
------------------------DUMMY BUILDINGS----------------------------------------

INSERT INTO BuildingClasses
			(Type,												DefaultBuilding)
VALUES		('BUILDINGCLASS_VV_LASTATION_PRODUCTION_DUMMY',		'BUILDING_VV_LASTATION_PRODUCTION_DUMMY'),
			('BUILDINGCLASS_VV_LASTATION_PRODUCTION_DUMMY_U',	'BUILDING_VV_LASTATION_PRODUCTION_DUMMY_U'),
			('BUILDINGCLASS_VV_LASTATION_SCIENCE_DUMMY',		'BUILDING_VV_LASTATION_SCIENCE_DUMMY'),
			('BUILDINGCLASS_VV_LASTATION_SCIENCE_DUMMY_U',		'BUILDING_VV_LASTATION_SCIENCE_DUMMY_U'),
			('BUILDINGCLASS_VV_LASTATION_NOFRIEND_BONUS',		'BUILDING_VV_LASTATION_NOFRIEND_BONUS'),
			('BUILDINGCLASS_VV_LASTATION_NOFRIEND_BONUS_U',		'BUILDING_VV_LASTATION_NOFRIEND_BONUS_U'),
			('BUILDINGCLASS_VV_LASTATION_WONDER_BONUS',			'BUILDING_VV_LASTATION_WONDER_BONUS');



INSERT INTO Buildings
			(Type,											BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune,
			MilitaryProductionModifier)
VALUES		('BUILDING_VV_LASTATION_PRODUCTION_DUMMY',		'BUILDINGCLASS_VV_LASTATION_PRODUCTION_DUMMY',
			-1,		-1,			-1,				null,		1,				1,
			3);

INSERT INTO Buildings
			(Type,											BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune,
			BuildingProductionModifier)
VALUES		('BUILDING_VV_LASTATION_PRODUCTION_DUMMY_U',		'BUILDINGCLASS_VV_LASTATION_PRODUCTION_DUMMY_U',
			-1,		-1,			-1,				null,		1,				1,
			3);

INSERT INTO Buildings
			(Type,											BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune)
VALUES		('BUILDING_VV_LASTATION_SCIENCE_DUMMY',		'BUILDINGCLASS_VV_LASTATION_SCIENCE_DUMMY',
			-1,		-1,			-1,				null,		1,				1);

INSERT INTO Buildings
			(Type,											BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune)
VALUES		('BUILDING_VV_LASTATION_SCIENCE_DUMMY_U',		'BUILDINGCLASS_VV_LASTATION_SCIENCE_DUMMY_U',
			-1,		-1,			-1,				null,		1,				1);

INSERT INTO Buildings
			(Type,											BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune,
			UnhappinessModifier)
VALUES		('BUILDING_VV_LASTATION_NOFRIEND_BONUS',		'BUILDINGCLASS_VV_LASTATION_NOFRIEND_BONUS',
			-1,		-1,			-1,				null,		1,				1,
			15);

INSERT INTO Buildings
			(Type,											BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune,
			UnhappinessModifier)
VALUES		('BUILDING_VV_LASTATION_NOFRIEND_BONUS_U',		'BUILDINGCLASS_VV_LASTATION_NOFRIEND_BONUS_U',
			-1,		-1,			-1,				null,		1,				1,
			20);

INSERT INTO Buildings
			(Type,											BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune,
			WonderProductionModifier)
VALUES		('BUILDING_VV_LASTATION_WONDER_BONUS',		'BUILDINGCLASS_VV_LASTATION_WONDER_BONUS',
			-1,		-1,			-1,				null,		1,				1,
			1);


INSERT INTO Building_GlobalYieldModifiers
			(BuildingType,									YieldType,			Yield)
VALUES		('BUILDING_VV_LASTATION_SCIENCE_DUMMY_U',		'YIELD_SCIENCE',	3),
			('BUILDING_VV_LASTATION_SCIENCE_DUMMY',			'YIELD_SCIENCE',	3),
			('BUILDING_VV_LASTATION_NOFRIEND_BONUS',		'YIELD_PRODUCTION',	20),
			('BUILDING_VV_LASTATION_NOFRIEND_BONUS_U',		'YIELD_PRODUCTION',	30);