--All SQL Leader inserts were based off of SQL code from JFD's Civilizations.

INSERT INTO Leaders 
			(Type, 				Description, 				Civilopedia, 					CivilopediaTag, 						ArtDefineTag,		VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 					PortraitIndex)
VALUES		('LEADER_HOMURA', 	'TXT_KEY_LEADER_HOMURA', 	'TXT_KEY_LEADER_HOMURA_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_HOMURA', 	'HomuraScene.xml',	8, 						3, 						2, 							6, 			3, 				3, 				4, 						3, 				5, 			3, 			2, 				1, 			2, 			'CIV_COLOR_ATLAS_HOMURA', 	1);


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 		MajorCivApproachType, 				Bias)
VALUES		('LEADER_HOMURA', 	'MAJOR_CIV_APPROACH_WAR', 			6),
			('LEADER_HOMURA', 	'MAJOR_CIV_APPROACH_HOSTILE', 		6),
			('LEADER_HOMURA', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	6),
			('LEADER_HOMURA', 	'MAJOR_CIV_APPROACH_GUARDED', 		9),
			('LEADER_HOMURA', 	'MAJOR_CIV_APPROACH_AFRAID', 		3),
			('LEADER_HOMURA', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		4),
			('LEADER_HOMURA', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		7);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 		MinorCivApproachType, 				Bias)
VALUES		('LEADER_HOMURA', 	'MINOR_CIV_APPROACH_IGNORE', 		4),
			('LEADER_HOMURA', 	'MINOR_CIV_APPROACH_FRIENDLY', 		4),
			('LEADER_HOMURA', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	4),
			('LEADER_HOMURA', 	'MINOR_CIV_APPROACH_CONQUEST', 		5),
			('LEADER_HOMURA', 	'MINOR_CIV_APPROACH_BULLY', 		8);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 		FlavorType, 						Flavor)
VALUES		('LEADER_HOMURA', 	'FLAVOR_OFFENSE', 					5),
			('LEADER_HOMURA', 	'FLAVOR_DEFENSE', 					7),
			('LEADER_HOMURA', 	'FLAVOR_CITY_DEFENSE', 				6),
			('LEADER_HOMURA', 	'FLAVOR_MILITARY_TRAINING', 		7),
			('LEADER_HOMURA', 	'FLAVOR_RECON', 					3),
			('LEADER_HOMURA', 	'FLAVOR_RANGED', 					8),
			('LEADER_HOMURA', 	'FLAVOR_MOBILE', 					3),
			('LEADER_HOMURA', 	'FLAVOR_NAVAL', 					7),
			('LEADER_HOMURA', 	'FLAVOR_NAVAL_RECON', 				4),
			('LEADER_HOMURA', 	'FLAVOR_NAVAL_GROWTH', 				4),
			('LEADER_HOMURA', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
			('LEADER_HOMURA', 	'FLAVOR_AIR', 						8),
			('LEADER_HOMURA', 	'FLAVOR_EXPANSION', 				7),
			('LEADER_HOMURA', 	'FLAVOR_GROWTH', 					4),
			('LEADER_HOMURA', 	'FLAVOR_TILE_IMPROVEMENT', 			4),
			('LEADER_HOMURA', 	'FLAVOR_INFRASTRUCTURE', 			6),
			('LEADER_HOMURA', 	'FLAVOR_PRODUCTION', 				7),
			('LEADER_HOMURA', 	'FLAVOR_GOLD', 						4),
			('LEADER_HOMURA', 	'FLAVOR_SCIENCE', 					9),
			('LEADER_HOMURA', 	'FLAVOR_CULTURE', 					3),
			('LEADER_HOMURA', 	'FLAVOR_HAPPINESS', 				3),
			('LEADER_HOMURA', 	'FLAVOR_GREAT_PEOPLE', 				4),
			('LEADER_HOMURA', 	'FLAVOR_WONDER', 					3),
			('LEADER_HOMURA', 	'FLAVOR_RELIGION', 					2),
			('LEADER_HOMURA', 	'FLAVOR_DIPLOMACY', 				2),
			('LEADER_HOMURA', 	'FLAVOR_SPACESHIP', 				7),
			('LEADER_HOMURA', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_HOMURA', 	'FLAVOR_NUKE', 						8),
			('LEADER_HOMURA', 	'FLAVOR_USE_NUKE', 					8),
			('LEADER_HOMURA', 	'FLAVOR_ESPIONAGE', 				9),
			('LEADER_HOMURA', 	'FLAVOR_ANTIAIR',	 				6),
			('LEADER_HOMURA', 	'FLAVOR_AIR_CARRIER', 				5),
			('LEADER_HOMURA', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_HOMURA', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_HOMURA', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_HOMURA', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_HOMURA', 	'FLAVOR_ARCHAEOLOGY', 				5),
			('LEADER_HOMURA', 	'FLAVOR_AIRLIFT', 					5);



--*******************************************************************
-- Trait Definition (Time Bandit)
--*******************************************************************
INSERT INTO Traits
			(Type,									 Description,									ShortDescription,										
			LeaderMGUniquePromotion,		LeaderMGRespawnTimeModifier,	MaximumMetEraMGStrength)
VALUES		('TRAIT_STEAL_ENEMY_UNIQUE_ON_CONQUEST', 'TXT_KEY_TRAIT_STEAL_ENEMY_UNIQUE_ON_CONQUEST', 'TXT_KEY_TRAIT_STEAL_ENEMY_UNIQUE_ON_CONQUEST_SHORT',
			'PROMOTION_PMMM_HOMURA_TRAIT',	-75,							1);

--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 			TraitType)
VALUES		('LEADER_HOMURA', 	'TRAIT_STEAL_ENEMY_UNIQUE_ON_CONQUEST');




INSERT INTO UnitPromotions
			(Type,											Description,							Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry,
			SoulGemCorruptionMod)
SELECT		('PROMOTION_PMMM_HOMURA_TRAIT'),				('TXT_KEY_PROMOTION_PMMM_HOMURA_TRAIT'),('TXT_KEY_PROMOTION_PMMM_HOMURA_TRAIT_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_PMMM_HOMURA_TRAIT'),
			-3
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');



