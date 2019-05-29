--*******************************************************************
-- CIA
--*******************************************************************

INSERT INTO Leaders 
			(Type, 					Description, 			Civilopedia, 						CivilopediaTag, 						ArtDefineTag,				
			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty,
			Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 						PortraitIndex)
VALUES		('LEADER_VV_BILL_WILSON', 	'TXT_KEY_LEADER_VV_BILL_WILSON', 	'TXT_KEY_LEADER_VV_BILL_WILSON_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_VV_BILL_WILSON', 	'VVCIAScene.xml',
			6, 						3, 						4, 							7, 			3, 				5, 				5, 						3, 				12,
			7, 			5, 				8, 			7, 			'CIV_COLOR_ATLAS_VV_CIA', 	1);


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 				MajorCivApproachType, 				Bias)
VALUES		('LEADER_VV_BILL_WILSON', 	'MAJOR_CIV_APPROACH_WAR', 			7),
			('LEADER_VV_BILL_WILSON', 	'MAJOR_CIV_APPROACH_HOSTILE', 		6),
			('LEADER_VV_BILL_WILSON', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	5),
			('LEADER_VV_BILL_WILSON', 	'MAJOR_CIV_APPROACH_GUARDED', 		6),
			('LEADER_VV_BILL_WILSON', 	'MAJOR_CIV_APPROACH_AFRAID', 		4),
			('LEADER_VV_BILL_WILSON', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		4),
			('LEADER_VV_BILL_WILSON', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		7);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 				MinorCivApproachType, 				Bias)
VALUES		('LEADER_VV_BILL_WILSON', 	'MINOR_CIV_APPROACH_IGNORE', 		3),
			('LEADER_VV_BILL_WILSON', 	'MINOR_CIV_APPROACH_FRIENDLY', 		7),
			('LEADER_VV_BILL_WILSON', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	5),
			('LEADER_VV_BILL_WILSON', 	'MINOR_CIV_APPROACH_CONQUEST', 		2),
			('LEADER_VV_BILL_WILSON', 	'MINOR_CIV_APPROACH_BULLY', 		3);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 				FlavorType, 						Flavor)
VALUES		('LEADER_VV_BILL_WILSON', 	'FLAVOR_OFFENSE', 					6),
			('LEADER_VV_BILL_WILSON', 	'FLAVOR_DEFENSE', 					4),
			('LEADER_VV_BILL_WILSON', 	'FLAVOR_CITY_DEFENSE', 				8),
			('LEADER_VV_BILL_WILSON', 	'FLAVOR_MILITARY_TRAINING', 		5),
			('LEADER_VV_BILL_WILSON', 	'FLAVOR_RECON', 					4),
			('LEADER_VV_BILL_WILSON', 	'FLAVOR_RANGED', 					4),
			('LEADER_VV_BILL_WILSON', 	'FLAVOR_MOBILE', 					6),
			('LEADER_VV_BILL_WILSON', 	'FLAVOR_NAVAL', 					5),
			('LEADER_VV_BILL_WILSON', 	'FLAVOR_NAVAL_RECON', 				4),
			('LEADER_VV_BILL_WILSON', 	'FLAVOR_NAVAL_GROWTH', 				5),
			('LEADER_VV_BILL_WILSON', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
			('LEADER_VV_BILL_WILSON', 	'FLAVOR_AIR', 						12),
			('LEADER_VV_BILL_WILSON', 	'FLAVOR_EXPANSION', 				7),
			('LEADER_VV_BILL_WILSON', 	'FLAVOR_GROWTH', 					4),
			('LEADER_VV_BILL_WILSON', 	'FLAVOR_TILE_IMPROVEMENT', 			8),
			('LEADER_VV_BILL_WILSON', 	'FLAVOR_INFRASTRUCTURE', 			6),
			('LEADER_VV_BILL_WILSON', 	'FLAVOR_PRODUCTION', 				4),
			('LEADER_VV_BILL_WILSON', 	'FLAVOR_GOLD', 						5),
			('LEADER_VV_BILL_WILSON', 	'FLAVOR_SCIENCE', 					8),
			('LEADER_VV_BILL_WILSON', 	'FLAVOR_CULTURE', 					3),
			('LEADER_VV_BILL_WILSON', 	'FLAVOR_HAPPINESS', 				4),
			('LEADER_VV_BILL_WILSON', 	'FLAVOR_GREAT_PEOPLE', 				4),
			('LEADER_VV_BILL_WILSON', 	'FLAVOR_WONDER', 					3),
			('LEADER_VV_BILL_WILSON', 	'FLAVOR_RELIGION', 					3),
			('LEADER_VV_BILL_WILSON', 	'FLAVOR_DIPLOMACY', 				2),
			('LEADER_VV_BILL_WILSON', 	'FLAVOR_SPACESHIP', 				8),
			('LEADER_VV_BILL_WILSON', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_VV_BILL_WILSON', 	'FLAVOR_NUKE', 						6),
			('LEADER_VV_BILL_WILSON', 	'FLAVOR_USE_NUKE', 					4),
			('LEADER_VV_BILL_WILSON', 	'FLAVOR_ESPIONAGE', 				10),
			('LEADER_VV_BILL_WILSON', 	'FLAVOR_ANTIAIR',	 				10),
			('LEADER_VV_BILL_WILSON', 	'FLAVOR_AIR_CARRIER', 				12),
			('LEADER_VV_BILL_WILSON', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_VV_BILL_WILSON', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_VV_BILL_WILSON', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_VV_BILL_WILSON', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_VV_BILL_WILSON', 	'FLAVOR_ARCHAEOLOGY', 				3),
			('LEADER_VV_BILL_WILSON', 	'FLAVOR_AIRLIFT', 					5);


--*******************************************************************
-- Trait Definition
--*******************************************************************
INSERT INTO Traits
			(Type,						Description,					ShortDescription,						FreeBuilding)
VALUES		('TRAIT_VV_BILL_WILSON',	'TXT_KEY_TRAIT_VV_BILL_WILSON',	'TXT_KEY_TRAIT_VV_BILL_WILSON_SHORT',	'BUILDING_VV_CIA_DUMMY_BUILDING');

INSERT INTO Trait_FreeResourceFirstXCities
			(TraitType,				ResourceType,	ResourceQuantity,	NumCities)
VALUES		('TRAIT_VV_BILL_WILSON','RESOURCE_OIL',	1,					4);

INSERT INTO Trait_FreePromotionUnitCombats
			(TraitType,					UnitCombatType,			PromotionType)
VALUES		('TRAIT_VV_BILL_WILSON',	'UNITCOMBAT_FIGHTER',	'PROMOTION_VV_BILL_WILSON'),
			('TRAIT_VV_BILL_WILSON',	'UNITCOMBAT_BOMBER',	'PROMOTION_VV_BILL_WILSON');


--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 				TraitType)
VALUES		('LEADER_VV_BILL_WILSON', 	'TRAIT_VV_BILL_WILSON');

