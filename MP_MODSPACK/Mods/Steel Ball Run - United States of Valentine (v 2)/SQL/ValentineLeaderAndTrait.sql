--*******************************************************************
-- Funny Valentine
--*******************************************************************

INSERT INTO Leaders 
			(Type, 						Description, 						Civilopedia, 								CivilopediaTag, 								ArtDefineTag,				
			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty,
			Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 							PortraitIndex)
VALUES		('LEADER_FUNNY_VALENTINE', 	'TXT_KEY_LEADER_FUNNY_VALENTINE', 	'TXT_KEY_LEADER_FUNNY_VALENTINE_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_FUNNY_VALENTINE', 	'FunnyValentineScene.xml',
			8, 						3, 						5, 							7, 			4, 				3, 				5, 						5, 				3,
			5, 			3, 				7, 			7, 			'CIV_COLOR_ATLAS_JJBA_AMERICA', 	1);


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 				MajorCivApproachType, 				Bias)
VALUES		('LEADER_FUNNY_VALENTINE', 	'MAJOR_CIV_APPROACH_WAR', 			7),
			('LEADER_FUNNY_VALENTINE', 	'MAJOR_CIV_APPROACH_HOSTILE', 		6),
			('LEADER_FUNNY_VALENTINE', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	7),
			('LEADER_FUNNY_VALENTINE', 	'MAJOR_CIV_APPROACH_GUARDED', 		7),
			('LEADER_FUNNY_VALENTINE', 	'MAJOR_CIV_APPROACH_AFRAID', 		3),
			('LEADER_FUNNY_VALENTINE', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		5),
			('LEADER_FUNNY_VALENTINE', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		6);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 				MinorCivApproachType, 				Bias)
VALUES		('LEADER_FUNNY_VALENTINE', 	'MINOR_CIV_APPROACH_IGNORE', 		3),
			('LEADER_FUNNY_VALENTINE', 	'MINOR_CIV_APPROACH_FRIENDLY', 		5),
			('LEADER_FUNNY_VALENTINE', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	5),
			('LEADER_FUNNY_VALENTINE', 	'MINOR_CIV_APPROACH_CONQUEST', 		4),
			('LEADER_FUNNY_VALENTINE', 	'MINOR_CIV_APPROACH_BULLY', 		7);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 				FlavorType, 						Flavor)
VALUES		('LEADER_FUNNY_VALENTINE', 	'FLAVOR_OFFENSE', 					7),
			('LEADER_FUNNY_VALENTINE', 	'FLAVOR_DEFENSE', 					4),
			('LEADER_FUNNY_VALENTINE', 	'FLAVOR_CITY_DEFENSE', 				3),
			('LEADER_FUNNY_VALENTINE', 	'FLAVOR_MILITARY_TRAINING', 		7),
			('LEADER_FUNNY_VALENTINE', 	'FLAVOR_RECON', 					4),
			('LEADER_FUNNY_VALENTINE', 	'FLAVOR_RANGED', 					6),
			('LEADER_FUNNY_VALENTINE', 	'FLAVOR_MOBILE', 					4),
			('LEADER_FUNNY_VALENTINE', 	'FLAVOR_NAVAL', 					6),
			('LEADER_FUNNY_VALENTINE', 	'FLAVOR_NAVAL_RECON', 				5),
			('LEADER_FUNNY_VALENTINE', 	'FLAVOR_NAVAL_GROWTH', 				5),
			('LEADER_FUNNY_VALENTINE', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
			('LEADER_FUNNY_VALENTINE', 	'FLAVOR_AIR', 						7),
			('LEADER_FUNNY_VALENTINE', 	'FLAVOR_EXPANSION', 				6),
			('LEADER_FUNNY_VALENTINE', 	'FLAVOR_GROWTH', 					5),
			('LEADER_FUNNY_VALENTINE', 	'FLAVOR_TILE_IMPROVEMENT', 			4),
			('LEADER_FUNNY_VALENTINE', 	'FLAVOR_INFRASTRUCTURE', 			6),
			('LEADER_FUNNY_VALENTINE', 	'FLAVOR_PRODUCTION', 				4),
			('LEADER_FUNNY_VALENTINE', 	'FLAVOR_GOLD', 						4),
			('LEADER_FUNNY_VALENTINE', 	'FLAVOR_SCIENCE', 					7),
			('LEADER_FUNNY_VALENTINE', 	'FLAVOR_CULTURE', 					4),
			('LEADER_FUNNY_VALENTINE', 	'FLAVOR_HAPPINESS', 				4),
			('LEADER_FUNNY_VALENTINE', 	'FLAVOR_GREAT_PEOPLE', 				4),
			('LEADER_FUNNY_VALENTINE', 	'FLAVOR_WONDER', 					3),
			('LEADER_FUNNY_VALENTINE', 	'FLAVOR_RELIGION', 					6),
			('LEADER_FUNNY_VALENTINE', 	'FLAVOR_DIPLOMACY', 				5),
			('LEADER_FUNNY_VALENTINE', 	'FLAVOR_SPACESHIP', 				5),
			('LEADER_FUNNY_VALENTINE', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_FUNNY_VALENTINE', 	'FLAVOR_NUKE', 						8),
			('LEADER_FUNNY_VALENTINE', 	'FLAVOR_USE_NUKE', 					8),
			('LEADER_FUNNY_VALENTINE', 	'FLAVOR_ESPIONAGE', 				6),
			('LEADER_FUNNY_VALENTINE', 	'FLAVOR_ANTIAIR',	 				6),
			('LEADER_FUNNY_VALENTINE', 	'FLAVOR_AIR_CARRIER', 				5),
			('LEADER_FUNNY_VALENTINE', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_FUNNY_VALENTINE', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_FUNNY_VALENTINE', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_FUNNY_VALENTINE', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_FUNNY_VALENTINE', 	'FLAVOR_ARCHAEOLOGY', 				5),
			('LEADER_FUNNY_VALENTINE', 	'FLAVOR_AIRLIFT', 					5);


--*******************************************************************
-- Trait Definition (Dirty Deeds Done Dirt Cheap) 
--*******************************************************************
INSERT INTO Traits
			(Type,			Description,			ShortDescription,			EnableD4CSystem,	FreeUnit,			FreeUnitPrereqTech)
VALUES		('TRAIT_D4C',	'TXT_KEY_TRAIT_D4C',	'TXT_KEY_TRAIT_D4C_SHORT',	1,					'UNITCLASS_PROPHET','TECH_HORSEBACK_RIDING');

INSERT INTO Trait_MaintenanceModifierUnitCombats
			(TraitType,		UnitCombatType,			MaintenanceModifier)
VALUES		('TRAIT_D4C',	'UNITCOMBAT_MOUNTED',	-50);



--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 				TraitType)
VALUES		('LEADER_FUNNY_VALENTINE', 	'TRAIT_D4C');





