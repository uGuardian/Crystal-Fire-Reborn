--==========================================================================================================================
-- Sukritact's Decisions
--==========================================================================================================================
-- DecisionsAddin_Support
----------------------------------------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS DecisionsAddin_Support(FileName);
INSERT INTO DecisionsAddin_Support (FileName) VALUES ('ClocheDecisions.lua');

------------------------------------------------------------------------------------------------------------------------------------------------------------
--Buildings
-------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO BuildingClasses
			(Type,													DefaultBuilding,								NoLimit)
VALUES		('BUILDINGCLASS_DECISIONS_CLOCHE_DUMMY',					'BUILDING_DECISIONS_CLOCHE_DUMMY',				0);

INSERT INTO Buildings
			(Type,										BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune)
VALUES		('BUILDING_DECISIONS_CLOCHE_DUMMY',		'BUILDINGCLASS_DECISIONS_CLOCHE_DUMMY',
			-1,		-1,			-1,				null,		1,				1);
------------------------------------------------------------------------------------------------------------------------------------------------------------
--Dummy Policies
------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policies
			(Type,										Description)
VALUES		('POLICY_DECISIONS_CLOCHE_HOLY_MAIDEN',			'TXT_KEY_DECISIONS_CLOCHE_HOLY_MAIDEN'),
			('POLICY_DECISIONS_CLOCHE_MAIDEN_OF_AQUA',			'TXT_KEY_DECISIONS_CLOCHE_MAIDEN_OF_AQUA');

UPDATE Policies
SET GreatWriterRateModifier = 25, GreatArtistRateModifier = 25, GreatMusicianRateModifier = 25
WHERE Type = 'POLICY_DECISIONS_CLOCHE_MAIDEN_OF_AQUA';

UPDATE Policies
SET GreatWriterRateModifier = -25, GreatArtistRateModifier = -25, GreatMusicianRateModifier = -25
WHERE Type = 'POLICY_DECISIONS_CLOCHE_HOLY_MAIDEN';

INSERT INTO Policy_BuildingClassTourismModifiers	
			(PolicyType,						BuildingClassType,						TourismModifier)
VALUES		('POLICY_DECISIONS_CLOCHE_HOLY_MAIDEN',	'BUILDINGCLASS_DECISIONS_CLOCHE_DUMMY',	-20),
			('POLICY_DECISIONS_CLOCHE_MAIDEN_OF_AQUA',	'BUILDINGCLASS_DECISIONS_CLOCHE_DUMMY',	20);


INSERT INTO Policy_YieldModifiers
			(PolicyType,						YieldType,			Yield)
VALUES		('POLICY_DECISIONS_CLOCHE_HOLY_MAIDEN',	'YIELD_SCIENCE',	10),
			('POLICY_DECISIONS_CLOCHE_HOLY_MAIDEN',	'YIELD_CULTURE',	-20),
			('POLICY_DECISIONS_CLOCHE_MAIDEN_OF_AQUA',	'YIELD_SCIENCE',	-10),
			('POLICY_DECISIONS_CLOCHE_MAIDEN_OF_AQUA',	'YIELD_CULTURE',	20);

INSERT INTO Policy_SpecialistExtraYields
			(PolicyType,						YieldType,			Yield)
VALUES		('POLICY_DECISIONS_CLOCHE_HOLY_MAIDEN',	'YIELD_PRODUCTION',	1),
			('POLICY_DECISIONS_CLOCHE_MAIDEN_OF_AQUA',	'YIELD_CULTURE',	1);


------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Policy_UnitCombatProductionModifiers
------------------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_UnitCombatProductionModifiers
			(PolicyType, 								UnitCombatType,				ProductionModifier)
VALUES		('POLICY_DECISIONS_CLOCHE_HOLY_MAIDEN', 		'UNITCOMBAT_MELEE',	33),
			('POLICY_DECISIONS_CLOCHE_HOLY_MAIDEN', 		'UNITCOMBAT_ARCHER',	33),
			('POLICY_DECISIONS_CLOCHE_HOLY_MAIDEN', 		'UNITCOMBAT_RECON',		33),
			('POLICY_DECISIONS_CLOCHE_HOLY_MAIDEN', 		'UNITCOMBAT_MOUNTED',		33),
			('POLICY_DECISIONS_CLOCHE_HOLY_MAIDEN', 		'UNITCOMBAT_SIEGE',		33),
			('POLICY_DECISIONS_CLOCHE_HOLY_MAIDEN', 		'UNITCOMBAT_GUN',		33),
			('POLICY_DECISIONS_CLOCHE_HOLY_MAIDEN', 		'UNITCOMBAT_ARMOR',		33),
			('POLICY_DECISIONS_CLOCHE_MAIDEN_OF_AQUA', 		'UNITCOMBAT_MELEE',	-33),
			('POLICY_DECISIONS_CLOCHE_MAIDEN_OF_AQUA', 		'UNITCOMBAT_ARCHER',	-33),
			('POLICY_DECISIONS_CLOCHE_MAIDEN_OF_AQUA', 		'UNITCOMBAT_RECON',		-33),
			('POLICY_DECISIONS_CLOCHE_MAIDEN_OF_AQUA', 		'UNITCOMBAT_MOUNTED',		-33),
			('POLICY_DECISIONS_CLOCHE_MAIDEN_OF_AQUA', 		'UNITCOMBAT_SIEGE',		-33),
			('POLICY_DECISIONS_CLOCHE_MAIDEN_OF_AQUA', 		'UNITCOMBAT_GUN',		-33),
			('POLICY_DECISIONS_CLOCHE_MAIDEN_OF_AQUA', 		'UNITCOMBAT_ARMOR',		-33);

--==========================================================================================================================	
-- JFD's Piety & Prestige
--==========================================================================================================================			
-- Flavors
------------------------------	
INSERT OR REPLACE INTO Flavors 
			(Type)
VALUES		('FLAVOR_JFD_RELIGIOUS_INTOLERANCE');
------------------------------
-- Leader_Flavors
------------------------------
INSERT INTO Leader_Flavors
			(LeaderType,				FlavorType,							Flavor)
VALUES		('LEADER_CLOCHE',			'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',	8);

--==========================================================================================================================
-- Civilization_JFD_CultureTypes
--==========================================================================================================================
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_CultureTypes (
    CivilizationType                            text    REFERENCES Civilizations(Type)      default null,
    CultureType                                 text                                        default null,
    SplashScreenTag                             text                                        default null,
    SoundtrackTag                               text                                        default null);
 
INSERT INTO Civilization_JFD_CultureTypes
            (CivilizationType,          CultureType,    SplashScreenTag)
VALUES      ('CIVILIZATION_PASTALIA', 'JFD_Western', 'JFD_Western');
 
			
			