INSERT INTO DecisionsAddin_Support		
			(FileName)
VALUES		('SaberDecisions.lua');


INSERT INTO IconTextureAtlases 
			(Atlas, 							IconSize, 	Filename, 					IconsPerRow, 	IconsPerColumn)
VALUES		('CIV_COLOR_ATLAS_SABER_DECISIONS',	256,		'SaberLily256.dds',			1,				1),
			('CIV_COLOR_ATLAS_SABER_DECISIONS',	128,		'SaberLily128.dds',			1,				1),
			('CIV_COLOR_ATLAS_SABER_DECISIONS',	80,			'SaberLily80.dds',			1,				1),
			('CIV_COLOR_ATLAS_SABER_DECISIONS',	64,			'SaberLily64.dds',			1,				1),
			('CIV_COLOR_ATLAS_SABER_DECISIONS',	45,			'SaberLily45.dds',			1,				1),
			('CIV_COLOR_ATLAS_SABER_DECISIONS',	32,			'SaberLily32.dds',			1,				1);

INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_SABER_LILY_DECISION'),		('TXT_KEY_PROMOTION_SABER_LILY_DECISION'),		('TXT_KEY_PROMOTION_SABER_LILY_DECISION_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_SABER_LILY_DECISION')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_STEAM_POWERED');


--*******************************************************************
-- Arturia Pendragon, aka Saber
--*******************************************************************

INSERT INTO Leaders 
			(Type, 				Description, 				Civilopedia, 					CivilopediaTag, 						ArtDefineTag,			
			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness,
			Chattiness, Meanness, 	IconAtlas, 					PortraitIndex)
VALUES		('LEADER_SABER_LILY', 	'TXT_KEY_LEADER_SABER_LILY', 	'TXT_KEY_LEADER_SABER_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_SABER', 	'SaberLilyScene.xml',
			7, 						4, 						4, 							6, 			6, 				4, 				4, 						6, 				9, 			1, 			4,
			3, 			4, 			'CIV_COLOR_ATLAS_SABER_DECISIONS', 	0);


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 		MajorCivApproachType, 				Bias)
VALUES		('LEADER_SABER_LILY', 	'MAJOR_CIV_APPROACH_WAR', 			6),
			('LEADER_SABER_LILY', 	'MAJOR_CIV_APPROACH_HOSTILE', 		5),
			('LEADER_SABER_LILY', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	1),
			('LEADER_SABER_LILY', 	'MAJOR_CIV_APPROACH_GUARDED', 		6),
			('LEADER_SABER_LILY', 	'MAJOR_CIV_APPROACH_AFRAID', 		2),
			('LEADER_SABER_LILY', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		5),
			('LEADER_SABER_LILY', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		7);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 		MinorCivApproachType, 				Bias)
VALUES		('LEADER_SABER_LILY', 	'MINOR_CIV_APPROACH_IGNORE', 		6),
			('LEADER_SABER_LILY', 	'MINOR_CIV_APPROACH_FRIENDLY', 		7),
			('LEADER_SABER_LILY', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	5),
			('LEADER_SABER_LILY', 	'MINOR_CIV_APPROACH_CONQUEST', 		2),
			('LEADER_SABER_LILY', 	'MINOR_CIV_APPROACH_BULLY', 		4);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 		FlavorType, 						Flavor)
VALUES		('LEADER_SABER_LILY', 	'FLAVOR_OFFENSE', 					7),
			('LEADER_SABER_LILY', 	'FLAVOR_DEFENSE', 					5),
			('LEADER_SABER_LILY', 	'FLAVOR_CITY_DEFENSE', 				8),
			('LEADER_SABER_LILY', 	'FLAVOR_MILITARY_TRAINING', 		6),
			('LEADER_SABER_LILY', 	'FLAVOR_RECON', 					3),
			('LEADER_SABER_LILY', 	'FLAVOR_RANGED', 					4),
			('LEADER_SABER_LILY', 	'FLAVOR_MOBILE', 					7),
			('LEADER_SABER_LILY', 	'FLAVOR_NAVAL', 					6),
			('LEADER_SABER_LILY', 	'FLAVOR_NAVAL_RECON', 				4),
			('LEADER_SABER_LILY', 	'FLAVOR_NAVAL_GROWTH', 				7),
			('LEADER_SABER_LILY', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	6),
			('LEADER_SABER_LILY', 	'FLAVOR_AIR', 						6),
			('LEADER_SABER_LILY', 	'FLAVOR_EXPANSION', 				7),
			('LEADER_SABER_LILY', 	'FLAVOR_GROWTH', 					4),
			('LEADER_SABER_LILY', 	'FLAVOR_TILE_IMPROVEMENT', 			5),
			('LEADER_SABER_LILY', 	'FLAVOR_INFRASTRUCTURE', 			5),
			('LEADER_SABER_LILY', 	'FLAVOR_PRODUCTION', 				6),
			('LEADER_SABER_LILY', 	'FLAVOR_GOLD', 						4),
			('LEADER_SABER_LILY', 	'FLAVOR_SCIENCE', 					5),
			('LEADER_SABER_LILY', 	'FLAVOR_CULTURE', 					6),
			('LEADER_SABER_LILY', 	'FLAVOR_HAPPINESS', 				8),
			('LEADER_SABER_LILY', 	'FLAVOR_GREAT_PEOPLE', 				3),
			('LEADER_SABER_LILY', 	'FLAVOR_WONDER', 					3),
			('LEADER_SABER_LILY', 	'FLAVOR_RELIGION', 					4),
			('LEADER_SABER_LILY', 	'FLAVOR_DIPLOMACY', 				3),
			('LEADER_SABER_LILY', 	'FLAVOR_SPACESHIP', 				6),
			('LEADER_SABER_LILY', 	'FLAVOR_WATER_CONNECTION', 			7),
			('LEADER_SABER_LILY', 	'FLAVOR_NUKE', 						8),
			('LEADER_SABER_LILY', 	'FLAVOR_USE_NUKE', 					2),
			('LEADER_SABER_LILY', 	'FLAVOR_ESPIONAGE', 				2),
			('LEADER_SABER_LILY', 	'FLAVOR_ANTIAIR',	 				7),
			('LEADER_SABER_LILY', 	'FLAVOR_AIR_CARRIER', 				6),
			('LEADER_SABER_LILY', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_SABER_LILY', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_SABER_LILY', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_SABER_LILY', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_SABER_LILY', 	'FLAVOR_ARCHAEOLOGY', 				5),
			('LEADER_SABER_LILY', 	'FLAVOR_AIRLIFT', 					5);


--*******************************************************************
-- Trait Definition (Sword of Promised Victory)
--*******************************************************************
INSERT INTO Traits
			(Type,							Description,							ShortDescription)
VALUES		('TRAIT_SABER_LILY_DECISION',	'TXT_KEY_TRAIT_SABER_LILY_DECISION',	'TXT_KEY_TRAIT_SABER_LILY_DECISION_SHORT');

INSERT INTO Trait_FreeResourceFirstXCities
			(TraitType,						ResourceType,		ResourceQuantity,	NumCities)
VALUES		('TRAIT_SABER_LILY_DECISION',	'RESOURCE_IRON',	2,					3);

--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 		TraitType)
VALUES		('LEADER_SABER_LILY', 	'TRAIT_SABER_LILY_DECISION');


INSERT INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_SABER_LILY'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_SABER_'),	1
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC';

INSERT INTO Diplomacy_Responses		
			(LeaderType, 		ResponseType, 					Response, 													Bias)
VALUES		('LEADER_SABER_LILY', 	'RESPONSE_DEFEATED', 			'TXT_KEY_LEADER_SABER_DEFEATED%', 							1),	
			('LEADER_SABER_LILY', 	'RESPONSE_FIRST_GREETING', 		'TXT_KEY_LEADER_SABER_FIRSTGREETING%', 					1);



INSERT INTO BuildingClasses
			(Type,													DefaultBuilding,								NoLimit)
VALUES		('BUILDINGCLASS_DECISIONS_SABER_CULTURE',				'BUILDING_DECISIONS_SABER_CULTURE',				1),
			('BUILDINGCLASS_DECISIONS_SABER_TOURISM_1',				'BUILDING_DECISIONS_SABER_TOURISM_1',			0),
			('BUILDINGCLASS_DECISIONS_SABER_TOURISM_2',				'BUILDING_DECISIONS_SABER_TOURISM_2',			0),
			('BUILDINGCLASS_DECISIONS_SABER_TOURISM_4',				'BUILDING_DECISIONS_SABER_TOURISM_4',			0),
			('BUILDINGCLASS_DECISIONS_SABER_TOURISM_8',				'BUILDING_DECISIONS_SABER_TOURISM_8',			0),
			('BUILDINGCLASS_DECISIONS_SABER_TOURISM_16',			'BUILDING_DECISIONS_SABER_TOURISM_16',			0),
			('BUILDINGCLASS_DECISIONS_SABER_TOURISM_32',			'BUILDING_DECISIONS_SABER_TOURISM_32',			0),
			('BUILDINGCLASS_DECISIONS_SABER_TOURISM_64',			'BUILDING_DECISIONS_SABER_TOURISM_64',			0),
			('BUILDINGCLASS_DECISIONS_SABER_TOURISM_128',			'BUILDING_DECISIONS_SABER_TOURISM_128',			0);

INSERT INTO Buildings
			(Type,								BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune)
VALUES		('BUILDING_DECISIONS_SABER_CULTURE',		'BUILDINGCLASS_DECISIONS_SABER_CULTURE',
			-1,		-1,			-1,				null,		1,				1);

INSERT INTO Building_YieldChanges
			(BuildingType,						YieldType,		Yield)
VALUES		('BUILDING_DECISIONS_SABER_CULTURE','YIELD_CULTURE',1);

INSERT INTO Buildings
			(Type,								BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune,
			EnhancedYieldTech,	TechEnhancedTourism)
VALUES		('BUILDING_DECISIONS_SABER_TOURISM_1',		'BUILDINGCLASS_DECISIONS_SABER_TOURISM_1',
			-1,		-1,			-1,				null,		1,				1,
			'TECH_AGRICULTURE',	1),
			('BUILDING_DECISIONS_SABER_TOURISM_2',		'BUILDINGCLASS_DECISIONS_SABER_TOURISM_2',
			-1,		-1,			-1,				null,		1,				1,
			'TECH_AGRICULTURE',	2),
			('BUILDING_DECISIONS_SABER_TOURISM_4',		'BUILDINGCLASS_DECISIONS_SABER_TOURISM_4',
			-1,		-1,			-1,				null,		1,				1,
			'TECH_AGRICULTURE',	4),
			('BUILDING_DECISIONS_SABER_TOURISM_8',		'BUILDINGCLASS_DECISIONS_SABER_TOURISM_8',
			-1,		-1,			-1,				null,		1,				1,
			'TECH_AGRICULTURE',	8),
			('BUILDING_DECISIONS_SABER_TOURISM_16',		'BUILDINGCLASS_DECISIONS_SABER_TOURISM_16',
			-1,		-1,			-1,				null,		1,				1,
			'TECH_AGRICULTURE',	16),
			('BUILDING_DECISIONS_SABER_TOURISM_32',		'BUILDINGCLASS_DECISIONS_SABER_TOURISM_32',
			-1,		-1,			-1,				null,		1,				1,
			'TECH_AGRICULTURE',	32),
			('BUILDING_DECISIONS_SABER_TOURISM_64',		'BUILDINGCLASS_DECISIONS_SABER_TOURISM_64',
			-1,		-1,			-1,				null,		1,				1,
			'TECH_AGRICULTURE',	64),
			('BUILDING_DECISIONS_SABER_TOURISM_128',		'BUILDINGCLASS_DECISIONS_SABER_TOURISM_128',
			-1,		-1,			-1,				null,		1,				1,
			'TECH_AGRICULTURE',	128);