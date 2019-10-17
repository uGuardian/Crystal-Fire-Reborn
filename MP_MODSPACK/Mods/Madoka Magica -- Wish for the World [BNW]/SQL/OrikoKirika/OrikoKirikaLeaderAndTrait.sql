--All SQL Leader inserts were based off of SQL code from JFD's Civilizations.

--*******************************************************************
-- Oriko Mikuni and Kirika Kure (co-leaders)
--*******************************************************************

INSERT INTO Leaders 
			(Type, 						Description, 					Civilopedia, 							CivilopediaTag, 								ArtDefineTag,				VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 							PortraitIndex)
VALUES		('LEADER_ORIKO_KIRIKA', 	'TXT_KEY_LEADER_ORIKO_KIRIKA', 	'TXT_KEY_LEADER_ORIKO_KIRIKA_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_ORIKO_KIRIKA', 	'OrikoKirikaScene.xml',		6, 						5, 						4, 							6, 			6, 				4, 				7, 						3, 				2, 			5, 			6, 				4, 			3, 			'CIV_COLOR_ATLAS_ORIKO_KIRIKA', 	1);


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 			MajorCivApproachType, 				Bias)
VALUES		('LEADER_ORIKO_KIRIKA', 	'MAJOR_CIV_APPROACH_WAR', 			6),
			('LEADER_ORIKO_KIRIKA', 	'MAJOR_CIV_APPROACH_HOSTILE', 		6),
			('LEADER_ORIKO_KIRIKA', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	9),
			('LEADER_ORIKO_KIRIKA', 	'MAJOR_CIV_APPROACH_GUARDED', 		4),
			('LEADER_ORIKO_KIRIKA', 	'MAJOR_CIV_APPROACH_AFRAID', 		4),
			('LEADER_ORIKO_KIRIKA', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		3),
			('LEADER_ORIKO_KIRIKA', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		6);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 			MinorCivApproachType, 				Bias)
VALUES		('LEADER_ORIKO_KIRIKA', 	'MINOR_CIV_APPROACH_IGNORE', 		3),
			('LEADER_ORIKO_KIRIKA', 	'MINOR_CIV_APPROACH_FRIENDLY', 		5),
			('LEADER_ORIKO_KIRIKA', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	5),
			('LEADER_ORIKO_KIRIKA', 	'MINOR_CIV_APPROACH_CONQUEST', 		3),
			('LEADER_ORIKO_KIRIKA', 	'MINOR_CIV_APPROACH_BULLY', 		4);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 			FlavorType, 						Flavor)
VALUES		('LEADER_ORIKO_KIRIKA', 	'FLAVOR_OFFENSE', 					6),
			('LEADER_ORIKO_KIRIKA', 	'FLAVOR_DEFENSE', 					4),
			('LEADER_ORIKO_KIRIKA', 	'FLAVOR_CITY_DEFENSE', 				5),
			('LEADER_ORIKO_KIRIKA', 	'FLAVOR_MILITARY_TRAINING', 		4),
			('LEADER_ORIKO_KIRIKA', 	'FLAVOR_RECON', 					7),
			('LEADER_ORIKO_KIRIKA', 	'FLAVOR_RANGED', 					7),
			('LEADER_ORIKO_KIRIKA', 	'FLAVOR_MOBILE', 					4),
			('LEADER_ORIKO_KIRIKA', 	'FLAVOR_NAVAL', 					5),
			('LEADER_ORIKO_KIRIKA', 	'FLAVOR_NAVAL_RECON', 				5),
			('LEADER_ORIKO_KIRIKA', 	'FLAVOR_NAVAL_GROWTH', 				4),
			('LEADER_ORIKO_KIRIKA', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
			('LEADER_ORIKO_KIRIKA', 	'FLAVOR_AIR', 						6),
			('LEADER_ORIKO_KIRIKA', 	'FLAVOR_EXPANSION', 				6),
			('LEADER_ORIKO_KIRIKA', 	'FLAVOR_GROWTH', 					4),
			('LEADER_ORIKO_KIRIKA', 	'FLAVOR_TILE_IMPROVEMENT', 			6),
			('LEADER_ORIKO_KIRIKA', 	'FLAVOR_INFRASTRUCTURE', 			5),
			('LEADER_ORIKO_KIRIKA', 	'FLAVOR_PRODUCTION', 				4),
			('LEADER_ORIKO_KIRIKA', 	'FLAVOR_GOLD', 						7),
			('LEADER_ORIKO_KIRIKA', 	'FLAVOR_SCIENCE', 					8),
			('LEADER_ORIKO_KIRIKA', 	'FLAVOR_CULTURE', 					6),
			('LEADER_ORIKO_KIRIKA', 	'FLAVOR_HAPPINESS', 				4),
			('LEADER_ORIKO_KIRIKA', 	'FLAVOR_GREAT_PEOPLE', 				5),
			('LEADER_ORIKO_KIRIKA', 	'FLAVOR_WONDER', 					4),
			('LEADER_ORIKO_KIRIKA', 	'FLAVOR_RELIGION', 					8),
			('LEADER_ORIKO_KIRIKA', 	'FLAVOR_DIPLOMACY', 				7),
			('LEADER_ORIKO_KIRIKA', 	'FLAVOR_SPACESHIP', 				6),
			('LEADER_ORIKO_KIRIKA', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_ORIKO_KIRIKA', 	'FLAVOR_NUKE', 						7),
			('LEADER_ORIKO_KIRIKA', 	'FLAVOR_USE_NUKE', 					4),
			('LEADER_ORIKO_KIRIKA', 	'FLAVOR_ESPIONAGE', 				8),
			('LEADER_ORIKO_KIRIKA', 	'FLAVOR_ANTIAIR',	 				6),
			('LEADER_ORIKO_KIRIKA', 	'FLAVOR_AIR_CARRIER', 				5),
			('LEADER_ORIKO_KIRIKA', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_ORIKO_KIRIKA', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_ORIKO_KIRIKA', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_ORIKO_KIRIKA', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_ORIKO_KIRIKA', 	'FLAVOR_ARCHAEOLOGY', 				5),
			('LEADER_ORIKO_KIRIKA', 	'FLAVOR_AIRLIFT', 					5);


--*******************************************************************
-- Trait Definition (Future Sight)
--*******************************************************************
INSERT INTO Traits
			(Type,								 Description,									ShortDescription,	
			ExtraLeaderMG,	ExtraLeaderMGName,										ExtraLeaderMGPortraitIndexOverride,	ExtraLeaderMGIconAtlasOverride,	ExtraLeaderMGUniquePromotion,
			LeaderMGIntrigueTurns,	RevealCivLocations)

VALUES		('TRAIT_FREE_SPIES_IMMUNE_TO_TRUTH', 'TXT_KEY_TRAIT_FREE_SPIES_IMMUNE_TO_TRUTH',	'TXT_KEY_TRAIT_FREE_SPIES_IMMUNE_TO_TRUTH_SHORT',
			1,				'TXT_KEY_PMMM_EXTRA_LEADER_MG_NAME_ORIKO_KIRIKA',		1,									'PMMM_LEADER_OVERRIDE_ATLAS',	'PROMOTION_PMMM_MAGICLAW',
			5,						1);
			

--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 			TraitType)
VALUES		('LEADER_ORIKO_KIRIKA', 	'TRAIT_FREE_SPIES_IMMUNE_TO_TRUTH');








