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
            (LeaderType,					TraitOne,					TraitTwo)
SELECT     	('LEADER_VV_PLUTIA'),			('POLICY_CHARISMATIC_X'),	('POLICY_AGGRESSIVE_X')
WHERE EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_CHARISMATIC_X');

INSERT OR REPLACE INTO Leader_SharedTraits
            (LeaderType,					TraitOne,					TraitTwo)
SELECT     	('LEADER_VV_IRIS_HEART'),		('POLICY_CHARISMATIC_X'),	('POLICY_AGGRESSIVE_X')
WHERE EXISTS (SELECT * FROM Policies WHERE Type = 'POLICY_CHARISMATIC_X');

------------------------------	
-- Leaders
------------------------------	
UPDATE Language_en_US 
SET Text = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_CHARISMATIC_X' )
	THEN 'Plutia [ICON_HAPPINESS_1][ICON_WAR]'
	ELSE 'Plutia' END) 
WHERE Tag IN ('TXT_KEY_LEADER_VV_PLUTIA');

UPDATE Language_en_US 
SET Text = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_CHARISMATIC_X' )
	THEN 'Iris Heart [ICON_HAPPINESS_1][ICON_WAR]'
	ELSE 'Iris Heart' END) 
WHERE Tag IN ('TXT_KEY_LEADER_VV_IRIS_HEART');


--==========================================================================================================================
-- BrutalSamurai's Ethnic Units/Gedemon's R.E.D.
--==========================================================================================================================
-- Civilizations
------------------------------	
UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_JAPAN' )
	THEN '_JAPAN'
	ELSE '_ASIA' END) 
WHERE Type LIKE ('CIVILIZATION_VV_PLANEPTUNE_PL%');

--==========================================================================================================================
-- Gedemon's YnAEMP
--==========================================================================================================================
-- Civilizations_YagemStartPosition (Earth Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);
INSERT OR IGNORE INTO Civilizations_YagemStartPosition
			(Type,							X,	Y)
SELECT		(SELECT Type FROM Civilizations WHERE Type LIKE 'CIVILIZATION_VV_PLANEPTUNE_PL'),	X,	Y
FROM Civilizations_YagemStartPosition WHERE (Type = 'CIVILIZATION_JAPAN');
------------------------------------------------------------	
-- Civilizations_YahemStartPosition (Earth Huge)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT OR IGNORE INTO Civilizations_YahemStartPosition
			(Type,							X,	Y)
SELECT		(SELECT Type FROM Civilizations WHERE Type LIKE 'CIVILIZATION_VV_PLANEPTUNE_PL'),	X,	Y
FROM Civilizations_YahemStartPosition WHERE (Type = 'CIVILIZATION_JAPAN');
------------------------------------------------------------	
-- Civilizations_CordiformStartPosition (Earth Standard)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT OR IGNORE INTO Civilizations_CordiformStartPosition
			(Type,							X,	Y)
SELECT		(SELECT Type FROM Civilizations WHERE Type LIKE 'CIVILIZATION_VV_PLANEPTUNE_PL'),	X,	Y
FROM Civilizations_CordiformStartPosition WHERE (Type = 'CIVILIZATION_JAPAN');
------------------------------------------------------------	
-- Civilizations_GreatestEarthStartPosition (Earth Greatest)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT OR IGNORE INTO Civilizations_GreatestEarthStartPosition
			(Type,							X,	Y)
SELECT		(SELECT Type FROM Civilizations WHERE Type LIKE 'CIVILIZATION_VV_PLANEPTUNE_PL'),	X,	Y
FROM Civilizations_GreatestEarthStartPosition WHERE (Type = 'CIVILIZATION_JAPAN');
------------------------------------------------------------	
-- Civilizations_NorthAtlanticStartPosition (North Atlantic)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthAtlanticStartPosition(Type, X, Y, AltX, AltY);
INSERT OR IGNORE INTO Civilizations_NorthAtlanticStartPosition
			(Type,							X,	Y)
SELECT		(SELECT Type FROM Civilizations WHERE Type LIKE 'CIVILIZATION_VV_PLANEPTUNE_PL'),	X,	Y
FROM Civilizations_NorthAtlanticStartPosition WHERE (Type = 'CIVILIZATION_JAPAN');
------------------------------------------------------------	
-- Civilizations_AmericasStartPosition (Americas)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AmericasStartPosition(Type, X, Y, AltX, AltY);
INSERT OR IGNORE INTO Civilizations_AmericasStartPosition
			(Type,							X,	Y)
SELECT		(SELECT Type FROM Civilizations WHERE Type LIKE 'CIVILIZATION_VV_PLANEPTUNE_PL'),	X,	Y
FROM Civilizations_AmericasStartPosition WHERE (Type = 'CIVILIZATION_JAPAN');
------------------------------------------------------------	
-- Civilizations_YagemRequestedResource (Earth Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT OR IGNORE INTO Civilizations_YagemRequestedResource
			(Type, 							Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		(SELECT Type FROM Civilizations WHERE Type LIKE 'CIVILIZATION_VV_PLANEPTUNE_PL'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE (Type = 'CIVILIZATION_JAPAN');
------------------------------------------------------------	
-- Civilizations_YahemRequestedResource (Earth Huge)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT OR IGNORE INTO Civilizations_YahemRequestedResource
			(Type, 							Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		(SELECT Type FROM Civilizations WHERE Type LIKE 'CIVILIZATION_VV_PLANEPTUNE_PL'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE (Type = 'CIVILIZATION_JAPAN');
------------------------------------------------------------	
-- Civilizations_GreatestEarthRequestedResource (Earth Greatest)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT OR IGNORE INTO Civilizations_GreatestEarthRequestedResource
			(Type, 							Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		(SELECT Type FROM Civilizations WHERE Type LIKE 'CIVILIZATION_VV_PLANEPTUNE_PL'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_GreatestEarthRequestedResource WHERE (Type = 'CIVILIZATION_JAPAN');
------------------------------------------------------------	
-- Civilizations_AmericasRequestedResource (Americas)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AmericasRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT OR IGNORE INTO Civilizations_AmericasRequestedResource
			(Type, 							Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		(SELECT Type FROM Civilizations WHERE Type LIKE 'CIVILIZATION_VV_PLANEPTUNE_PL'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AmericasRequestedResource WHERE (Type = 'CIVILIZATION_JAPAN');
------------------------------------------------------------	
-- Civilizations_NorthAtlanticRequestedResource (North Atlantic)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthAtlanticRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT OR IGNORE INTO Civilizations_NorthAtlanticRequestedResource
			(Type, 							Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		(SELECT Type FROM Civilizations WHERE Type LIKE 'CIVILIZATION_VV_PLANEPTUNE_PL'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_NorthAtlanticRequestedResource WHERE (Type = 'CIVILIZATION_JAPAN');

--==========================================================================================================================
-- Hazel's Map Labels
--==========================================================================================================================
-- ML_CivCultures
------------------------------	
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT OR IGNORE INTO ML_CivCultures
			(CivType,																CultureType,		CultureEra)
SELECT		(SELECT Type FROM Civilizations WHERE Type LIKE 'CIVILIZATION_VV_PLANEPTUNE_PL'),CultureType,		CultureEra
FROM ML_CivCultures WHERE (CivType = 'CIVILIZATION_JAPAN');

--==========================================================================================================================
-- JFD's Cultural Diversity
--==========================================================================================================================
-- Civilization_JFD_CultureTypes
------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_CultureTypes(
	CivilizationType 							text 	REFERENCES Civilizations(Type) 			default null,
	CultureType 								text											default null,
	ArtDefineTag								text											default	null,
	SplashScreenTag								text											default	null,
	SoundtrackTag								text											default	null,
	UnitDialogueTag								text											default null);

INSERT INTO Civilization_JFD_CultureTypes
			(CivilizationType,						CultureType)
VALUES		('CIVILIZATION_VV_PLANEPTUNE_PL',		'JFD_Gamindustri'),
			('CIVILIZATION_VV_PLANEPTUNE_IH',		'JFD_Gamindustri');

			
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
			(CivilizationType, 														ColonyName,	LinguisticType, CultureType)
SELECT		(SELECT Type FROM Civilizations WHERE Type LIKE 'CIVILIZATION_VV_PLANEPTUNE_PL'),ColonyName,	LinguisticType, CultureType
FROM Civilization_JFD_ColonialCityNames WHERE (CivilizationType = 'CIVILIZATION_JAPAN');

------------------------------	
-- Civilization_JFD_RevolutionaryCivilizationsToSpawn
------------------------------	

-- will fix later


-- CREATE TABLE IF NOT EXISTS 
-- Civilization_JFD_RevolutionaryCivilizationsToSpawn (
	-- CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	-- RevolutionaryCivilizationType 				text 	REFERENCES Civilizations(Type) 		default null);
	
-- INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			-- (CivilizationType,				RevolutionaryCivilizationType)
-- VALUES		('CIVILIZATION_JAPAN',		'CIVILIZATION_VV_PLANEPTUNE_PL'),
			-- ('CIVILIZATION_VV_PLANEPTUNE_PL',		'CIVILIZATION_JAPAN'),
			-- ('CIVILIZATION_AMERICA',		'CIVILIZATION_VV_PLANEPTUNE_PL'),
			-- ('CIVILIZATION_VV_PLANEPTUNE_PL',		'CIVILIZATION_AMERICA');

-- INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			-- (CivilizationType,				RevolutionaryCivilizationType)
-- SELECT		('CIVILIZATION_VV_PLANEPTUNE_PL'),	('CIVILIZATION_PLANEPTUNE_PL')
-- WHERE EXISTS (SELECT Type FROM Civilizations WHERE Type = 'CIVILIZATION_PLANEPTUNE_PL');

-- INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			-- (CivilizationType,					RevolutionaryCivilizationType)
-- SELECT		('CIVILIZATION_PLANEPTUNE_PL'),		('CIVILIZATION_VV_PLANEPTUNE_PL')
-- WHERE EXISTS (SELECT Type FROM Civilizations WHERE Type = 'CIVILIZATION_JFD_GREAT_BRITAIN');

-- INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			-- (CivilizationType,				RevolutionaryCivilizationType)
-- SELECT		('CIVILIZATION_PLANEPTUNE_PL'),		('CIVILIZATION_VV_PLANEPTUNE_PL')
-- WHERE EXISTS (SELECT Type FROM Civilizations WHERE Type = 'CIVILIZATION_JFD_AMERICA_HENRY');

-- INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			-- (CivilizationType,					RevolutionaryCivilizationType)
-- SELECT		('CIVILIZATION_VV_PLANEPTUNE_PL'),		('CIVILIZATION_PLANEPTUNE_PL')
-- WHERE EXISTS (SELECT Type FROM Civilizations WHERE Type = 'CIVILIZATION_JFD_AMERICA_LINCOLN');

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
			(LeaderType,					FlavorType,							Flavor)
VALUES		('LEADER_VV_PLUTIA',			'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',	7),
			('LEADER_VV_IRIS_HEART',		'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',	15);

--==========================================================================================================================	
-- JFD's AND POUAKAI's MERCENARIES (a19351c5-c0b3-4b07-8695-4affaa199949)
--==========================================================================================================================
-- Flavors
------------------------------------------------------------	
INSERT OR REPLACE INTO Flavors 
		(Type)
VALUES	('FLAVOR_JFD_MERCENARY');
------------------------------------------------------------
-- Leader_Flavors
------------------------------------------------------------	
INSERT INTO Leader_Flavors
			(LeaderType,					FlavorType,				Flavor)
VALUES		('LEADER_VV_PLUTIA',			'FLAVOR_JFD_MERCENARY',	4),
			('LEADER_VV_IRIS_HEART',		'FLAVOR_JFD_MERCENARY',	1);