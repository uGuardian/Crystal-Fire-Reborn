--All SQL Leader inserts were based off of SQL code from JFD's Civilizations.

--*******************************************************************
-- Diarmuid of the Love Spot
--*******************************************************************

INSERT INTO Leaders 
			(Type, 					Description, 					Civilopedia, 						CivilopediaTag, 							ArtDefineTag,			
			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness,
			Chattiness, Meanness, 	IconAtlas, 					PortraitIndex)
VALUES		('LEADER_LANCER_FSN', 	'TXT_KEY_LEADER_LANCER_FSN', 	'TXT_KEY_LEADER_LANCER_FSN_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_LANCER_FSN', 	'LancerScene.xml',
			4, 						2, 						4, 							7, 			4, 				2, 				6, 						5, 				9, 			2, 			3,
			4, 			5, 			'CIV_COLOR_ATLAS_LANCER_FSN', 	1);


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 			MajorCivApproachType, 				Bias)
VALUES		('LEADER_LANCER_FSN', 	'MAJOR_CIV_APPROACH_WAR', 			6),
			('LEADER_LANCER_FSN', 	'MAJOR_CIV_APPROACH_HOSTILE', 		4),
			('LEADER_LANCER_FSN', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	1),
			('LEADER_LANCER_FSN', 	'MAJOR_CIV_APPROACH_GUARDED', 		8),
			('LEADER_LANCER_FSN', 	'MAJOR_CIV_APPROACH_AFRAID', 		2),
			('LEADER_LANCER_FSN', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		6),
			('LEADER_LANCER_FSN', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		6);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 		MinorCivApproachType, 				Bias)
VALUES		('LEADER_LANCER_FSN', 	'MINOR_CIV_APPROACH_IGNORE', 		5),
			('LEADER_LANCER_FSN', 	'MINOR_CIV_APPROACH_FRIENDLY', 		6),
			('LEADER_LANCER_FSN', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	5),
			('LEADER_LANCER_FSN', 	'MINOR_CIV_APPROACH_CONQUEST', 		2),
			('LEADER_LANCER_FSN', 	'MINOR_CIV_APPROACH_BULLY', 		5);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 		FlavorType, 						Flavor)
VALUES		('LEADER_LANCER_FSN', 	'FLAVOR_OFFENSE', 					7),
			('LEADER_LANCER_FSN', 	'FLAVOR_DEFENSE', 					7),
			('LEADER_LANCER_FSN', 	'FLAVOR_CITY_DEFENSE', 				4),
			('LEADER_LANCER_FSN', 	'FLAVOR_MILITARY_TRAINING', 		6),
			('LEADER_LANCER_FSN', 	'FLAVOR_RECON', 					4),
			('LEADER_LANCER_FSN', 	'FLAVOR_RANGED', 					4),
			('LEADER_LANCER_FSN', 	'FLAVOR_MOBILE', 					5),
			('LEADER_LANCER_FSN', 	'FLAVOR_NAVAL', 					4),
			('LEADER_LANCER_FSN', 	'FLAVOR_NAVAL_RECON', 				5),
			('LEADER_LANCER_FSN', 	'FLAVOR_NAVAL_GROWTH', 				5),
			('LEADER_LANCER_FSN', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
			('LEADER_LANCER_FSN', 	'FLAVOR_AIR', 						6),
			('LEADER_LANCER_FSN', 	'FLAVOR_EXPANSION', 				7),
			('LEADER_LANCER_FSN', 	'FLAVOR_GROWTH', 					5),
			('LEADER_LANCER_FSN', 	'FLAVOR_TILE_IMPROVEMENT', 			6),
			('LEADER_LANCER_FSN', 	'FLAVOR_INFRASTRUCTURE', 			3),
			('LEADER_LANCER_FSN', 	'FLAVOR_PRODUCTION', 				5),
			('LEADER_LANCER_FSN', 	'FLAVOR_GOLD', 						5),
			('LEADER_LANCER_FSN', 	'FLAVOR_SCIENCE', 					4),
			('LEADER_LANCER_FSN', 	'FLAVOR_CULTURE', 					6),
			('LEADER_LANCER_FSN', 	'FLAVOR_HAPPINESS', 				6),
			('LEADER_LANCER_FSN', 	'FLAVOR_GREAT_PEOPLE', 				4),
			('LEADER_LANCER_FSN', 	'FLAVOR_WONDER', 					5),
			('LEADER_LANCER_FSN', 	'FLAVOR_RELIGION', 					7),
			('LEADER_LANCER_FSN', 	'FLAVOR_DIPLOMACY', 				4),
			('LEADER_LANCER_FSN', 	'FLAVOR_SPACESHIP', 				7),
			('LEADER_LANCER_FSN', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_LANCER_FSN', 	'FLAVOR_NUKE', 						6),
			('LEADER_LANCER_FSN', 	'FLAVOR_USE_NUKE', 					4),
			('LEADER_LANCER_FSN', 	'FLAVOR_ESPIONAGE', 				3),
			('LEADER_LANCER_FSN', 	'FLAVOR_ANTIAIR',	 				7),
			('LEADER_LANCER_FSN', 	'FLAVOR_AIR_CARRIER', 				4),
			('LEADER_LANCER_FSN', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_LANCER_FSN', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_LANCER_FSN', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_LANCER_FSN', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_LANCER_FSN', 	'FLAVOR_ARCHAEOLOGY', 				5),
			('LEADER_LANCER_FSN', 	'FLAVOR_AIRLIFT', 					5);


--*******************************************************************
-- Trait Definition (Golden Rule)
--*******************************************************************
INSERT INTO Traits
			(Type,													Description,													ShortDescription)
VALUES		('TRAIT_FEMALE_LEADERS_RELATIONS_GENERAL_HEAL_DEBUFF',	'TXT_KEY_TRAIT_FEMALE_LEADERS_RELATIONS_GENERAL_HEAL_DEBUFF',	'TXT_KEY_TRAIT_FEMALE_LEADERS_RELATIONS_GENERAL_HEAL_DEBUFF_SHORT');

--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 			TraitType)
VALUES		('LEADER_LANCER_FSN', 	'TRAIT_FEMALE_LEADERS_RELATIONS_GENERAL_HEAL_DEBUFF');


--Promotion


INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_LANCER_GREAT_GENERAL'),		('TXT_KEY_PROMOTION_LANCER_GREAT_GENERAL'),		('TXT_KEY_PROMOTION_LANCER_GREAT_GENERAL_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_LANCER_GREAT_GENERAL')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_STEAM_POWERED');

INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_GAE_BUIDHE_CURSE_10'),		('TXT_KEY_PROMOTION_GAE_BUIDHE_CURSE_10'),		('TXT_KEY_PROMOTION_GAE_BUIDHE_CURSE_10_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_GAE_BUIDHE_CURSE_10')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_UNWELCOME_EVANGELIST');

UPDATE UnitPromotions
SET	EnemyHealChange = -10, NeutralHealChange = -10, FriendlyHealChange = -10, DefenseMod = -10
WHERE Type = 'PROMOTION_GAE_BUIDHE_CURSE_10';