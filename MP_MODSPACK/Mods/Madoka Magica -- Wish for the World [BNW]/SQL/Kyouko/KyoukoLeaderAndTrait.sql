--All SQL Leader inserts were based off of SQL code from JFD's Civilizations.

--*******************************************************************
-- Kyouko Sakura
--*******************************************************************

INSERT INTO Leaders 
			(Type, 				Description, 				Civilopedia, 					CivilopediaTag, 						ArtDefineTag,		VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 					PortraitIndex)
VALUES		('LEADER_KYOUKO', 	'TXT_KEY_LEADER_KYOUKO', 	'TXT_KEY_LEADER_KYOUKO_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_KYOUKO', 	'KyoukoScene.xml',	6, 						3, 						5, 							7, 			2, 				3, 				4, 						3, 				8, 			3, 			2, 				3, 			8, 			'CIV_COLOR_ATLAS_KYOUKO', 	1);


--*******************************************************************
-- Attitudes toward Civilizations
--*******************************************************************
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 		MajorCivApproachType, 				Bias)
VALUES		('LEADER_KYOUKO', 	'MAJOR_CIV_APPROACH_WAR', 			6),
			('LEADER_KYOUKO', 	'MAJOR_CIV_APPROACH_HOSTILE', 		7),
			('LEADER_KYOUKO', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	6),
			('LEADER_KYOUKO', 	'MAJOR_CIV_APPROACH_GUARDED', 		6),
			('LEADER_KYOUKO', 	'MAJOR_CIV_APPROACH_AFRAID', 		2),
			('LEADER_KYOUKO', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		5),
			('LEADER_KYOUKO', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		5);

--*******************************************************************
-- Attitudes toward City-States
--*******************************************************************
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 		MinorCivApproachType, 				Bias)
VALUES		('LEADER_KYOUKO', 	'MINOR_CIV_APPROACH_IGNORE', 		4),
			('LEADER_KYOUKO', 	'MINOR_CIV_APPROACH_FRIENDLY', 		5),
			('LEADER_KYOUKO', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	4),
			('LEADER_KYOUKO', 	'MINOR_CIV_APPROACH_CONQUEST', 		5),
			('LEADER_KYOUKO', 	'MINOR_CIV_APPROACH_BULLY', 		8);

--*******************************************************************
-- Flavors
--*******************************************************************
INSERT INTO Leader_Flavors 
			(LeaderType, 		FlavorType, 						Flavor)
VALUES		('LEADER_KYOUKO', 	'FLAVOR_OFFENSE', 					6),
			('LEADER_KYOUKO', 	'FLAVOR_DEFENSE', 					5),
			('LEADER_KYOUKO', 	'FLAVOR_CITY_DEFENSE', 				4),
			('LEADER_KYOUKO', 	'FLAVOR_MILITARY_TRAINING', 		3),
			('LEADER_KYOUKO', 	'FLAVOR_RECON', 					7),
			('LEADER_KYOUKO', 	'FLAVOR_RANGED', 					5),
			('LEADER_KYOUKO', 	'FLAVOR_MOBILE', 					8),
			('LEADER_KYOUKO', 	'FLAVOR_NAVAL', 					6),
			('LEADER_KYOUKO', 	'FLAVOR_NAVAL_RECON', 				4),
			('LEADER_KYOUKO', 	'FLAVOR_NAVAL_GROWTH', 				4),
			('LEADER_KYOUKO', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	4),
			('LEADER_KYOUKO', 	'FLAVOR_AIR', 						5),
			('LEADER_KYOUKO', 	'FLAVOR_EXPANSION', 				8),
			('LEADER_KYOUKO', 	'FLAVOR_GROWTH', 					5),
			('LEADER_KYOUKO', 	'FLAVOR_TILE_IMPROVEMENT', 			4),
			('LEADER_KYOUKO', 	'FLAVOR_INFRASTRUCTURE', 			6),
			('LEADER_KYOUKO', 	'FLAVOR_PRODUCTION', 				4),
			('LEADER_KYOUKO', 	'FLAVOR_GOLD', 						7),
			('LEADER_KYOUKO', 	'FLAVOR_SCIENCE', 					4),
			('LEADER_KYOUKO', 	'FLAVOR_CULTURE', 					3),
			('LEADER_KYOUKO', 	'FLAVOR_HAPPINESS', 				5),
			('LEADER_KYOUKO', 	'FLAVOR_GREAT_PEOPLE', 				3),
			('LEADER_KYOUKO', 	'FLAVOR_WONDER', 					4),
			('LEADER_KYOUKO', 	'FLAVOR_RELIGION', 					7),
			('LEADER_KYOUKO', 	'FLAVOR_DIPLOMACY', 				3),
			('LEADER_KYOUKO', 	'FLAVOR_SPACESHIP', 				6),
			('LEADER_KYOUKO', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_KYOUKO', 	'FLAVOR_NUKE', 						6),
			('LEADER_KYOUKO', 	'FLAVOR_USE_NUKE', 					8),
			('LEADER_KYOUKO', 	'FLAVOR_ESPIONAGE', 				7),
			('LEADER_KYOUKO', 	'FLAVOR_ANTIAIR',	 				7),
			('LEADER_KYOUKO', 	'FLAVOR_AIR_CARRIER', 				4),
			('LEADER_KYOUKO', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_KYOUKO', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_KYOUKO', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_KYOUKO', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_KYOUKO', 	'FLAVOR_ARCHAEOLOGY', 				5),
			('LEADER_KYOUKO', 	'FLAVOR_AIRLIFT', 					5);


--*******************************************************************
-- Trait Definition (Feeding the Multitude)
--*******************************************************************
INSERT INTO Traits
			(Type,									Description,								ShortDescription,								  MaxStolenFood,	CaravanPillageStolenFood,	PopulationMoodBonus)
VALUES		('TRAIT_GROWTH_SPEED_FROM_RELIGION',	'TXT_KEY_TRAIT_GROWTH_SPEED_FROM_RELIGION', 'TXT_KEY_TRAIT_GROWTH_SPEED_FROM_RELIGION_SHORT', 100,				50,							2);


INSERT INTO Trait_PMMM_StolenFoodFromImprovement
			(TraitType,								ImprovementType,Amount)
SELECT		('TRAIT_GROWTH_SPEED_FROM_RELIGION'),	Type,		(20)
FROM Improvements WHERE (instr(Type, 'FARM') > 0 OR instr(Type, 'PLANTATION') > 0 OR instr(Type, 'FISHING_BOAT') > 0);

CREATE TRIGGER PMMMKyoukoImprovements
AFTER INSERT ON Improvements
WHEN (instr(NEW.Type, 'FARM') > 0 OR instr(NEW.Type, 'PLANTATION') > 0 OR instr(NEW.Type, 'FISHING_BOAT') > 0)
BEGIN
	INSERT INTO Trait_PMMM_StolenFoodFromImprovement
				(TraitType,								ImprovementType,Amount)
	VALUES		('TRAIT_GROWTH_SPEED_FROM_RELIGION',	NEW.Type,		20);
END;



--*******************************************************************
-- Trait Assignment
--*******************************************************************

INSERT INTO Leader_Traits 
			(LeaderType, 		TraitType)
VALUES		('LEADER_KYOUKO', 	'TRAIT_GROWTH_SPEED_FROM_RELIGION');