--All SQL Leader inserts were based off of SQL code from JFD's Civilizations.

--*******************************************************************
-- Nagisa Momoe
--*******************************************************************

INSERT INTO Leaders 
			(Type, 						Description, 						Civilopedia, 								CivilopediaTag, 								ArtDefineTag,				VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 							PortraitIndex)
VALUES		('LEADER_NAGISA', 			'TXT_KEY_LEADER_NAGISA', 			'TXT_KEY_LEADER_NAGISA_PEDIA',				'TXT_KEY_CIVILOPEDIA_LEADERS_NAGISA', 			'NagisaScene.xml',			2, 						4, 						7, 							3, 			6, 				4, 				5, 						7,				7, 			6, 			6, 				5, 			3, 			'CIV_COLOR_ATLAS_NAGISA', 			1);


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 			MajorCivApproachType, 				Bias)
VALUES		('LEADER_NAGISA', 	'MAJOR_CIV_APPROACH_WAR', 			3),
			('LEADER_NAGISA', 	'MAJOR_CIV_APPROACH_HOSTILE', 		3),
			('LEADER_NAGISA', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	3),
			('LEADER_NAGISA', 	'MAJOR_CIV_APPROACH_GUARDED', 		5),
			('LEADER_NAGISA', 	'MAJOR_CIV_APPROACH_AFRAID', 		5),
			('LEADER_NAGISA', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		7),
			('LEADER_NAGISA', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		6);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 			MinorCivApproachType, 				Bias)
VALUES		('LEADER_NAGISA', 	'MINOR_CIV_APPROACH_IGNORE', 		3),
			('LEADER_NAGISA', 	'MINOR_CIV_APPROACH_FRIENDLY', 		7),
			('LEADER_NAGISA', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	8),
			('LEADER_NAGISA', 	'MINOR_CIV_APPROACH_CONQUEST', 		2),
			('LEADER_NAGISA', 	'MINOR_CIV_APPROACH_BULLY', 		3);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 			FlavorType, 					Flavor)
VALUES		('LEADER_NAGISA', 	'FLAVOR_OFFENSE', 					3),
			('LEADER_NAGISA', 	'FLAVOR_DEFENSE', 					6),
			('LEADER_NAGISA', 	'FLAVOR_CITY_DEFENSE', 				6),
			('LEADER_NAGISA', 	'FLAVOR_MILITARY_TRAINING', 		3),
			('LEADER_NAGISA', 	'FLAVOR_RECON', 					8),
			('LEADER_NAGISA', 	'FLAVOR_RANGED', 					6),
			('LEADER_NAGISA', 	'FLAVOR_MOBILE', 					6),
			('LEADER_NAGISA', 	'FLAVOR_NAVAL', 					6),
			('LEADER_NAGISA', 	'FLAVOR_NAVAL_RECON', 				5),
			('LEADER_NAGISA', 	'FLAVOR_NAVAL_GROWTH', 				3),
			('LEADER_NAGISA', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	3),
			('LEADER_NAGISA', 	'FLAVOR_AIR', 						5),
			('LEADER_NAGISA', 	'FLAVOR_EXPANSION', 				7),
			('LEADER_NAGISA', 	'FLAVOR_GROWTH', 					4),
			('LEADER_NAGISA', 	'FLAVOR_TILE_IMPROVEMENT', 			7),
			('LEADER_NAGISA', 	'FLAVOR_INFRASTRUCTURE', 			5),
			('LEADER_NAGISA', 	'FLAVOR_PRODUCTION', 				4),
			('LEADER_NAGISA', 	'FLAVOR_GOLD', 						8),
			('LEADER_NAGISA', 	'FLAVOR_SCIENCE', 					6),
			('LEADER_NAGISA', 	'FLAVOR_CULTURE', 					4),
			('LEADER_NAGISA', 	'FLAVOR_HAPPINESS', 				5),
			('LEADER_NAGISA', 	'FLAVOR_GREAT_PEOPLE', 				5),
			('LEADER_NAGISA', 	'FLAVOR_WONDER', 					5),
			('LEADER_NAGISA', 	'FLAVOR_RELIGION', 					3),
			('LEADER_NAGISA', 	'FLAVOR_DIPLOMACY', 				8),
			('LEADER_NAGISA', 	'FLAVOR_SPACESHIP', 				5),
			('LEADER_NAGISA', 	'FLAVOR_WATER_CONNECTION', 			4),
			('LEADER_NAGISA', 	'FLAVOR_NUKE', 						3),
			('LEADER_NAGISA', 	'FLAVOR_USE_NUKE', 					3),
			('LEADER_NAGISA', 	'FLAVOR_ESPIONAGE', 				7),
			('LEADER_NAGISA', 	'FLAVOR_ANTIAIR',	 				7),
			('LEADER_NAGISA', 	'FLAVOR_AIR_CARRIER', 				5),
			('LEADER_NAGISA', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_NAGISA', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_NAGISA', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_NAGISA', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_NAGISA', 	'FLAVOR_ARCHAEOLOGY', 				5),
			('LEADER_NAGISA', 	'FLAVOR_AIRLIFT', 					5);



--*******************************************************************
-- Trait Definition (Cheese!)
--*******************************************************************
INSERT INTO Traits
			(Type,										 Description,										 ShortDescription)
VALUES		('TRAIT_CATTLE_BONUS_MERCHANT_PLANT_CATTLE', 'TXT_KEY_TRAIT_CATTLE_BONUS_MERCHANT_PLANT_CATTLE', 'TXT_KEY_TRAIT_CATTLE_BONUS_MERCHANT_PLANT_CATTLE_SHORT');


INSERT INTO Trait_ImprovementYieldChanges
			(TraitType,										ImprovementType,		YieldType,			Yield)
VALUES		('TRAIT_CATTLE_BONUS_MERCHANT_PLANT_CATTLE',	'IMPROVEMENT_PASTURE',	'YIELD_CULTURE',	1);

INSERT INTO Trait_PMMM_GoldenAgeResourceSpread
			(TraitType,										ResourceType,		ProbabilityPerTurn)
VALUES		('TRAIT_CATTLE_BONUS_MERCHANT_PLANT_CATTLE',	'RESOURCE_COW',		2),
			('TRAIT_CATTLE_BONUS_MERCHANT_PLANT_CATTLE',	'RESOURCE_SHEEP',	2);



--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 			TraitType)
VALUES		('LEADER_NAGISA',		'TRAIT_CATTLE_BONUS_MERCHANT_PLANT_CATTLE');





