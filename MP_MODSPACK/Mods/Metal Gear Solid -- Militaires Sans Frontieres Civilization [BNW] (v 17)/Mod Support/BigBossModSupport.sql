--=======================================================================================================================
-- Bingle's Civ IV Traits
--=======================================================================================================================
-- Leader_SharedTraits
------------------------------	
CREATE TABLE IF NOT EXISTS 
    Leader_SharedTraits (
    LeaderType          text    REFERENCES Leaders(Type)        default null,
    TraitOne            text    REFERENCES Policies(Type)       default null,
    TraitTwo            text    REFERENCES Policies(Type)       default null);
     
INSERT OR REPLACE INTO Leader_SharedTraits
            (LeaderType,			TraitOne,				TraitTwo)
VALUES      ('LEADER_BIGBOSS',		'POLICY_AGGRESSIVE_X',	'POLICY_FINANCIAL_X'),
			('LEADER_VENOM_SNAKE',	'POLICY_AGGRESSIVE_X',	'POLICY_FINANCIAL_X'),
			('LEADER_BIGBOSS_OH',	'POLICY_AGGRESSIVE_X',	'POLICY_FINANCIAL_X');
------------------------------	
-- Leaders
------------------------------	
UPDATE Language_en_US 
SET Text = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_AGGRESSIVE_X' )
	THEN 'Naked Snake [ICON_WAR][ICON_GOLD]'
	ELSE 'Naked Snake' END) 
WHERE Tag = 'TXT_KEY_LEADER_BIGBOSS';

UPDATE Language_en_US 
SET Text = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_AGGRESSIVE_X' )
	THEN 'Venom Snake [ICON_WAR][ICON_GOLD]'
	ELSE 'Venom Snake' END) 
WHERE Tag = 'TXT_KEY_LEADER_VENOM_SNAKE';

UPDATE Language_en_US 
SET Text = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_AGGRESSIVE_X' )
	THEN 'Big Boss [ICON_WAR][ICON_GOLD]'
	ELSE 'Big Boss' END) 
WHERE Tag = 'TXT_KEY_LEADER_BIGBOSS_OH';

--==========================================================================================================================
-- BrutalSamurai's Ethnic Units/Gedemon's R.E.D.
--==========================================================================================================================
-- Civilizations
------------------------------	
UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_AMERICA' )
	THEN '_AMERICA'
	ELSE '_EURO' END) 
WHERE Type IN ('CIVILIZATION_MSF', 'CIVILIZATION_DIAMOND_DOGS', 'CIVILIZATION_BB_OUTER_HEAVEN');

--==========================================================================================================================
-- Gedemon's YnAEMP
--==========================================================================================================================
-- Civilizations_YagemStartPosition (Earth Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YagemStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_MSF'),	X,	Y
FROM Civilizations_YagemStartPosition WHERE (Type = 'CIVILIZATION_AMERICA');
------------------------------------------------------------	
-- Civilizations_YahemStartPosition (Earth Huge)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_MSF'),	X,	Y
FROM Civilizations_YahemStartPosition WHERE (Type = 'CIVILIZATION_AMERICA');
------------------------------------------------------------	
-- Civilizations_CordiformStartPosition (Earth Standard)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_MSF'),	X,	Y
FROM Civilizations_CordiformStartPosition WHERE (Type = 'CIVILIZATION_AMERICA');
------------------------------------------------------------	
-- Civilizations_GreatestEarthStartPosition (Earth Greatest)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_MSF'),	X,	Y
FROM Civilizations_GreatestEarthStartPosition WHERE (Type = 'CIVILIZATION_AMERICA');
------------------------------------------------------------	
-- Civilizations_NorthAtlanticStartPosition (North Atlantic)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthAtlanticStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthAtlanticStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_MSF'),	X,	Y
FROM Civilizations_NorthAtlanticStartPosition WHERE (Type = 'CIVILIZATION_AMERICA');
------------------------------------------------------------	
-- Civilizations_AmericasStartPosition (Americas)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AmericasStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AmericasStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_MSF'),	X,	Y
FROM Civilizations_AmericasStartPosition WHERE (Type = 'CIVILIZATION_AMERICA');
------------------------------------------------------------	
-- Civilizations_YagemRequestedResource (Earth Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YagemRequestedResource
			(Type, 							Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_MSF'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE (Type = 'CIVILIZATION_AMERICA');
------------------------------------------------------------	
-- Civilizations_YahemRequestedResource (Earth Huge)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YahemRequestedResource
			(Type, 							Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_MSF'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE (Type = 'CIVILIZATION_AMERICA');
------------------------------------------------------------	
-- Civilizations_GreatestEarthRequestedResource (Earth Greatest)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_GreatestEarthRequestedResource
			(Type, 							Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_MSF'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_GreatestEarthRequestedResource WHERE (Type = 'CIVILIZATION_AMERICA');
------------------------------------------------------------	
-- Civilizations_AmericasRequestedResource (Americas)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AmericasRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AmericasRequestedResource
			(Type, 							Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_MSF'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AmericasRequestedResource WHERE (Type = 'CIVILIZATION_AMERICA');
------------------------------------------------------------	
-- Civilizations_NorthAtlanticRequestedResource (North Atlantic)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthAtlanticRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_NorthAtlanticRequestedResource
			(Type, 							Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_MSF'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_NorthAtlanticRequestedResource WHERE (Type = 'CIVILIZATION_AMERICA');

--==========================================================================================================================
-- Hazel's Map Labels
--==========================================================================================================================
-- ML_CivCultures
------------------------------	
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
			(CivType,						CultureType,				CultureEra)
VALUES		('CIVILIZATION_MSF',			'BRITISH',					'ANY'),
			('CIVILIZATION_MSF',			'FIRST_AMERICANS',			'ANY'),
			('CIVILIZATION_MSF',			'MOD_TP_SOUTH_AMERICAN',	'ANY'),
			('CIVILIZATION_MSF',			'MOD_TP_MESO_AMERICAN',		'ANY'),
			('CIVILIZATION_DIAMOND_DOGS',	'BRITISH',					'ANY'),
			('CIVILIZATION_DIAMOND_DOGS',	'FIRST_AMERICANS',			'ANY'),
			('CIVILIZATION_DIAMOND_DOGS',	'MOD_TP_SOUTH_AMERICAN',	'ANY'),
			('CIVILIZATION_DIAMOND_DOGS',	'MOD_TP_MESO_AMERICAN',		'ANY'),
			('CIVILIZATION_BB_OUTER_HEAVEN','BRITISH',					'ANY'),
			('CIVILIZATION_BB_OUTER_HEAVEN','FIRST_AMERICANS',			'ANY'),
			('CIVILIZATION_BB_OUTER_HEAVEN','MOD_TP_SOUTH_AMERICAN',	'ANY'),
			('CIVILIZATION_BB_OUTER_HEAVEN','MOD_TP_MESO_AMERICAN',		'ANY');

--==========================================================================================================================
-- JFD's Cultural Diversity
--==========================================================================================================================
-- Civilization_JFD_CultureTypes
------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_CultureTypes (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	CultureType 								text										default null,
	SplashScreenTag								text										default	null,
	SoundtrackTag								text										default	null);

INSERT OR REPLACE INTO Civilization_JFD_CultureTypes
			(CivilizationType,				CultureType,		SplashScreenTag)
VALUES		('CIVILIZATION_MSF',			'JFD_Colonial',		'JFD_MetalGear'),
			('CIVILIZATION_DIAMOND_DOGS',	'JFD_Totalitarian',	'JFD_MetalGear'),
			('CIVILIZATION_BB_OUTER_HEAVEN','JFD_Totalitarian',	'JFD_MetalGear');

--==========================================================================================================================
-- JFD's Exploration Continued Expanded
--==========================================================================================================================
-- Civilization_JFD_ColonialCityNames
------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_ColonialCityNames (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	ColonyName 									text										default null,
	LinguisticType								text										default	null,
	CultureType									text										default	null);

INSERT OR REPLACE INTO Civilization_JFD_ColonialCityNames
			(CivilizationType, 				ColonyName,			LinguisticType)
VALUES		('CIVILIZATION_MSF',			null,				'JFD_Germanic'),
			('CIVILIZATION_MSF',			null,				'JFD_Latinate');
			('CIVILIZATION_DIAMOND_DOGS',	null,				'JFD_Germanic'),
			('CIVILIZATION_DIAMOND_DOGS',	null,				'JFD_Latinate');
			('CIVILIZATION_BB_OUTER_HEAVEN',null,				'JFD_Germanic'),
			('CIVILIZATION_BB_OUTER_HEAVEN',null,				'JFD_Latinate');
------------------------------	
-- Civilization_JFD_RevolutionaryCivilizationsToSpawn
------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_RevolutionaryCivilizationsToSpawn (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	RevolutionaryCivilizationType 				text 	REFERENCES Civilizations(Type) 		default null);
	
INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,				RevolutionaryCivilizationType)
VALUES		('CIVILIZATION_AMERICA',		'CIVILIZATION_MSF'),
			('CIVILIZATION_AMERICA',		'CIVILIZATION_DIAMOND_DOGS'),
			('CIVILIZATION_AMERICA',		'CIVILIZATION_BB_OUTER_HEAVEN'),
			('CIVILIZATION_MSF',			'CIVILIZATION_AMERICA');

INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,						RevolutionaryCivilizationType)
SELECT		('CIVILIZATION_JFD_AMERICA_ROOSEVELT'),	('CIVILIZATION_MSF')
WHERE EXISTS (SELECT Type FROM Civilizations WHERE Type = 'CIVILIZATION_JFD_AMERICA_ROOSEVELT');

INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,							RevolutionaryCivilizationType)
SELECT		('CIVILIZATION_JFD_AMERICA_LINCOLN'),		('CIVILIZATION_MSF')
WHERE EXISTS (SELECT Type FROM Civilizations WHERE Type = 'CIVILIZATION_JFD_AMERICA_LINCOLN');

INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,			RevolutionaryCivilizationType)
SELECT		('CIVILIZATION_MSF'),		('CIVILIZATION_WORLD_MARSHAL')
WHERE EXISTS (SELECT Type FROM Civilizations WHERE Type = 'CIVILIZATION_WORLD_MARSHAL');

INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,					RevolutionaryCivilizationType)
SELECT		('CIVILIZATION_WORLD_MARSHAL'),		('CIVILIZATION_MSF')
WHERE EXISTS (SELECT Type FROM Civilizations WHERE Type = 'CIVILIZATION_WORLD_MARSHAL');

INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,					RevolutionaryCivilizationType)
SELECT		('CIVILIZATION_MSF'),				('CIVILIZATION_OUTER_HEAVEN')
WHERE EXISTS (SELECT Type FROM Civilizations WHERE Type = 'CIVILIZATION_OUTER_HEAVEN');

INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,					RevolutionaryCivilizationType)
SELECT		('CIVILIZATION_OUTER_HEAVEN'),		('CIVILIZATION_MSF')
WHERE EXISTS (SELECT Type FROM Civilizations WHERE Type = 'CIVILIZATION_OUTER_HEAVEN');

INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,					RevolutionaryCivilizationType)
SELECT		('CIVILIZATION_DIAMOND_DOGS'),		('CIVILIZATION_WORLD_MARSHAL')
WHERE EXISTS (SELECT Type FROM Civilizations WHERE Type = 'CIVILIZATION_WORLD_MARSHAL');

INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,					RevolutionaryCivilizationType)
SELECT		('CIVILIZATION_WORLD_MARSHAL'),		('CIVILIZATION_DIAMOND_DOGS')
WHERE EXISTS (SELECT Type FROM Civilizations WHERE Type = 'CIVILIZATION_WORLD_MARSHAL');

INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,					RevolutionaryCivilizationType)
SELECT		('CIVILIZATION_DIAMOND_DOGS'),		('CIVILIZATION_OUTER_HEAVEN')
WHERE EXISTS (SELECT Type FROM Civilizations WHERE Type = 'CIVILIZATION_OUTER_HEAVEN');

INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,					RevolutionaryCivilizationType)
SELECT		('CIVILIZATION_OUTER_HEAVEN'),		('CIVILIZATION_DIAMOND_DOGS')
WHERE EXISTS (SELECT Type FROM Civilizations WHERE Type = 'CIVILIZATION_OUTER_HEAVEN');

INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,					RevolutionaryCivilizationType)
SELECT		('CIVILIZATION_BB_OUTER_HEAVEN'),	('CIVILIZATION_WORLD_MARSHAL')
WHERE EXISTS (SELECT Type FROM Civilizations WHERE Type = 'CIVILIZATION_WORLD_MARSHAL');

INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,					RevolutionaryCivilizationType)
SELECT		('CIVILIZATION_WORLD_MARSHAL'),		('CIVILIZATION_BB_OUTER_HEAVEN')
WHERE EXISTS (SELECT Type FROM Civilizations WHERE Type = 'CIVILIZATION_WORLD_MARSHAL');

INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,					RevolutionaryCivilizationType)
SELECT		('CIVILIZATION_BB_OUTER_HEAVEN'),	('CIVILIZATION_OUTER_HEAVEN')
WHERE EXISTS (SELECT Type FROM Civilizations WHERE Type = 'CIVILIZATION_OUTER_HEAVEN');

INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,					RevolutionaryCivilizationType)
SELECT		('CIVILIZATION_OUTER_HEAVEN'),		('CIVILIZATION_BB_OUTER_HEAVEN')
WHERE EXISTS (SELECT Type FROM Civilizations WHERE Type = 'CIVILIZATION_OUTER_HEAVEN');

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
			(LeaderType,			FlavorType,							Flavor)
VALUES		('LEADER_BIGBOSS',		'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',	0),
			('LEADER_VENOM_SNAKE',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',	0),
			('LEADER_BIGBOSS_OH',	'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',	0);