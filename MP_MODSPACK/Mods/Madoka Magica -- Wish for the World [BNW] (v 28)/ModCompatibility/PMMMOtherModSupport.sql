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
            (LeaderType,				TraitOne,					TraitTwo)
VALUES      ('LEADER_ORIGINAL_MADOKA',	'POLICY_PHILOSOPHICAL_X',	'POLICY_PROTECTIVE_X'),
			('LEADER_HOMURA',			'POLICY_INDUSTRIOUS_X',		'POLICY_PROTECTIVE_X'),
			('LEADER_MAMI',				'POLICY_CHARISMATIC_X',		'POLICY_DIPLOMATIC_X'),
			('LEADER_SAYAKA',			'POLICY_PHILOSOPHICAL_X',	'POLICY_AGGRESSIVE_X'),
			('LEADER_KYOUKO',			'POLICY_EXPANSIVE_X',		'POLICY_IMPERIALISTIC_X'),
			('LEADER_NAGISA',			'POLICY_CHARISMATIC_X',		'POLICY_EXPANSIVE_X'),
			('LEADER_MADOKA',			'POLICY_SPIRITUAL_X',		'POLICY_PHILOSOPHICAL_X'),
			('LEADER_DEMON_HOMURA',		'POLICY_IMPERIALISTIC_X',	'POLICY_PHILOSOPHICAL_X'),
			('LEADER_KAORU_UMIKA',		'POLICY_CREATIVE_X',		'POLICY_INVENTIVE_X'),
			('LEADER_ORIKO_KIRIKA',		'POLICY_AGGRESSIVE_X',		'POLICY_SPIRITUAL_X');
------------------------------	
-- Leaders
------------------------------	
UPDATE Language_en_US 
SET Text = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_AGGRESSIVE_X' )
	THEN 'Madoka Kaname [ICON_GREAT_PEOPLE][ICON_STRENGTH]'
	ELSE 'Madoka Kaname' END) 
WHERE Tag = 'TXT_KEY_LEADER_ORIGINAL_MADOKA';

UPDATE Language_en_US 
SET Text = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_AGGRESSIVE_X' )
	THEN 'Homura Akemi [ICON_PRODUCTION][ICON_STRENGTH]'
	ELSE 'Homura Akemi' END) 
WHERE Tag = 'TXT_KEY_LEADER_HOMURA';

UPDATE Language_en_US 
SET Text = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_AGGRESSIVE_X' )
	THEN 'Mami Tomoe [ICON_HAPPINESS_1][ICON_INFLUENCE]'
	ELSE 'Mami Tomoe' END) 
WHERE Tag = 'TXT_KEY_LEADER_MAMI';

UPDATE Language_en_US 
SET Text = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_AGGRESSIVE_X' )
	THEN 'Sayaka Miki [ICON_GREAT_PEOPLE][ICON_WAR]'
	ELSE 'Sayaka Miki' END) 
WHERE Tag = 'TXT_KEY_LEADER_SAYAKA';

UPDATE Language_en_US 
SET Text = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_AGGRESSIVE_X' )
	THEN 'Kyouko Sakura [ICON_FOOD][ICON_CITY_STATE]'
	ELSE 'Kyouko Sakura' END) 
WHERE Tag = 'TXT_KEY_LEADER_KYOUKO';

UPDATE Language_en_US 
SET Text = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_AGGRESSIVE_X' )
	THEN 'Nagisa Momoe [ICON_HAPPINESS_1][ICON_FOOD]'
	ELSE 'Nagisa Momoe' END) 
WHERE Tag = 'TXT_KEY_LEADER_NAGISA';

UPDATE Language_en_US 
SET Text = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_AGGRESSIVE_X' )
	THEN 'Ultimate Madoka [ICON_PEACE][ICON_GREAT_PEOPLE]'
	ELSE 'Ultimate Madoka' END) 
WHERE Tag = 'TXT_KEY_LEADER_MADOKA';

UPDATE Language_en_US 
SET Text = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_AGGRESSIVE_X' )
	THEN 'Demon Homura [ICON_CULTURE][ICON_GREAT_PEOPLE]'
	ELSE 'Demon Homura' END) 
WHERE Tag = 'TXT_KEY_LEADER_DEMON_HOMURA';

UPDATE Language_en_US 
SET Text = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_AGGRESSIVE_X' )
	THEN 'Kazumi [ICON_CITY_STATE][ICON_RESEARCH]'
	ELSE 'Kazumi' END) 
WHERE Tag = 'TXT_KEY_LEADER_KAORU_UMIKA';

UPDATE Language_en_US 
SET Text = (CASE WHEN EXISTS(SELECT Type FROM Policies WHERE Type = 'POLICY_AGGRESSIVE_X' )
	THEN 'Oriko and Kirika [ICON_WAR][ICON_PEACE]'
	ELSE 'Oriko and Kirika' END) 
WHERE Tag = 'TXT_KEY_LEADER_ORIKO_KIRIKA';


--==========================================================================================================================
-- BrutalSamurai's Ethnic Units/Gedemon's R.E.D.
--==========================================================================================================================

--This will, eventually, be a special unit group for all PMMM Civs which makes every unit model female. But that's a long, long way away...

-- Civilizations
------------------------------	
UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_BABYLON' )
	THEN '_BABYLON'
	ELSE '_MED' END) 
WHERE Type = 'CIVILIZATION_MADOKA';

UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_ASSYRIA' )
	THEN '_ASSYRIA'
	ELSE '_MED' END) 
WHERE Type = 'CIVILIZATION_DEMON_HOMURA';

UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_JAPAN' )
	THEN '_JAPAN'
	ELSE '_ASIA' END) 
WHERE Type = 'CIVILIZATION_ORIGINAL_MADOKA';

UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_KOREA' )
	THEN '_KOREA'
	ELSE '_ASIA' END) 
WHERE Type = 'CIVILIZATION_KYOUKO';

UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_CHINA' )
	THEN '_CHINA'
	ELSE '_ASIA' END) 
WHERE Type = 'CIVILIZATION_HOMURA';

UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_AUSTRIA' )
	THEN '_AUSTRIA'
	ELSE '_EURO' END) 
WHERE Type = 'CIVILIZATION_SAYAKA';

UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_SPAIN' )
	THEN '_SPAIN'
	ELSE '_ASIA' END) 
WHERE Type = 'CIVILIZATION_KAORU_UMIKA';

UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_EGYPT' )
	THEN '_EGYPT'
	ELSE '_ASIA' END) 
WHERE Type = 'CIVILIZATION_ORIKO_KIRIKA';

UPDATE Civilizations 
SET ArtStyleSuffix = (CASE WHEN EXISTS(SELECT ArtStyleSuffix FROM Civilizations WHERE ArtStyleSuffix = '_MONGOL' )
	THEN '_MONGOL'
	ELSE '_ASIA' END) 
WHERE Type = 'CIVILIZATION_NAGISA';

--==========================================================================================================================
-- Gedemon's YnAEMP
--==========================================================================================================================
-- Civilizations_YagemStartPosition (Earth Giant)
------------------------------------------------------------	

--This is the only one I care to make new start positions for; the others will just take directly from other Civs
CREATE TABLE IF NOT EXISTS Civilizations_YagemStartPosition(Type, X, Y, AltX, AltY);

INSERT INTO Civilizations_YagemStartPosition
			(Type,										X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_MADOKA',						35,		51,		null,	null), --Jerusalem (symbolism!)
			('CIVILIZATION_HOMURA',						91,		56,		null,	null), --southwestern Honshu, where Kyushu should be
			('CIVILIZATION_SAYAKA',						24,		65,		null,	null), --Vienna
			('CIVILIZATION_MAMI',						21,		58,		null,	null), --Rome
			('CIVILIZATION_KYOUKO',						97,		68,		null,	null), --Hokkaido
			('CIVILIZATION_NAGISA',						68,		62,		null,	null), --western end of China, near present-day Kyrgystan. Why? So they can be a steppe tribe of cheese hoarders!
			('CIVILIZATION_ORIGINAL_MADOKA',			98,		63,		null,	null), --northern Honshu
			('CIVILIZATION_DEMON_HOMURA',				33,		56,		null,	null),
			('CIVILIZATION_KAORU_UMIKA',				97,		68,		null,	null),
			('CIVILIZATION_ORIKO_KIRIKA',				91,		56,		null,	null);


------------------------------------------------------------	
-- Civilizations_YahemStartPosition (Earth Huge)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_MADOKA'),	X,	Y
FROM Civilizations_YahemStartPosition WHERE (Type = 'CIVILIZATION_OTTOMAN');

CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_HOMURA'),	X,	Y
FROM Civilizations_YahemStartPosition WHERE (Type = 'CIVILIZATION_CHINA');

CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_SAYAKA'),	X,	Y
FROM Civilizations_YahemStartPosition WHERE (Type = 'CIVILIZATION_AUSTRIA');

CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_MAMI'),	X,	Y
FROM Civilizations_YahemStartPosition WHERE (Type = 'CIVILIZATION_ROME');

CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_KYOUKO'),	X,	Y
FROM Civilizations_YahemStartPosition WHERE (Type = 'CIVILIZATION_KOREA');

CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_NAGISA'),	X,	Y
FROM Civilizations_YahemStartPosition WHERE (Type = 'CIVILIZATION_MONGOL');

CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_ORIGINAL_MADOKA'),	X,	Y
FROM Civilizations_YahemStartPosition WHERE (Type = 'CIVILIZATION_JAPAN');

CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_DEMON_HOMURA'),	X,	Y
FROM Civilizations_YahemStartPosition WHERE (Type = 'CIVILIZATION_ASSYRIA');

CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_KAORU_UMIKA'),	X,	Y
FROM Civilizations_YahemStartPosition WHERE (Type = 'CIVILIZATION_SPAIN'); --because soccer

CREATE TABLE IF NOT EXISTS Civilizations_YahemStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_YahemStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_ORIKO_KIRIKA'),	X,	Y
FROM Civilizations_YahemStartPosition WHERE (Type = 'CIVILIZATION_EGYPT'); --just because
------------------------------------------------------------	
-- Civilizations_CordiformStartPosition (Earth Standard)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_MADOKA'),	X,	Y
FROM Civilizations_CordiformStartPosition WHERE (Type = 'CIVILIZATION_OTTOMAN');

CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_HOMURA'),	X,	Y
FROM Civilizations_CordiformStartPosition WHERE (Type = 'CIVILIZATION_CHINA');

CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_SAYAKA'),	X,	Y
FROM Civilizations_CordiformStartPosition WHERE (Type = 'CIVILIZATION_AUSTRIA');

CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_MAMI'),	X,	Y
FROM Civilizations_CordiformStartPosition WHERE (Type = 'CIVILIZATION_ROME');

CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_KYOUKO'),	X,	Y
FROM Civilizations_CordiformStartPosition WHERE (Type = 'CIVILIZATION_KOREA');

CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_NAGISA'),	X,	Y
FROM Civilizations_CordiformStartPosition WHERE (Type = 'CIVILIZATION_MONGOL');

CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_ORIGINAL_MADOKA'),	X,	Y
FROM Civilizations_CordiformStartPosition WHERE (Type = 'CIVILIZATION_JAPAN');

CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_DEMON_HOMURA'),	X,	Y
FROM Civilizations_CordiformStartPosition WHERE (Type = 'CIVILIZATION_ASSYRIA');

CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_KAORU_UMIKA'),	X,	Y
FROM Civilizations_CordiformStartPosition WHERE (Type = 'CIVILIZATION_SPAIN'); --because soccer

CREATE TABLE IF NOT EXISTS Civilizations_CordiformStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_CordiformStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_ORIKO_KIRIKA'),	X,	Y
FROM Civilizations_CordiformStartPosition WHERE (Type = 'CIVILIZATION_EGYPT'); --just because
------------------------------------------------------------	
-- Civilizations_GreatestEarthStartPosition (Earth Greatest)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_MADOKA'),	X,	Y
FROM Civilizations_GreatestEarthStartPosition WHERE (Type = 'CIVILIZATION_OTTOMAN');

CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_HOMURA'),	X,	Y
FROM Civilizations_GreatestEarthStartPosition WHERE (Type = 'CIVILIZATION_CHINA');

CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_SAYAKA'),	X,	Y
FROM Civilizations_GreatestEarthStartPosition WHERE (Type = 'CIVILIZATION_AUSTRIA');

CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_MAMI'),	X,	Y
FROM Civilizations_GreatestEarthStartPosition WHERE (Type = 'CIVILIZATION_ROME');

CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_KYOUKO'),	X,	Y
FROM Civilizations_GreatestEarthStartPosition WHERE (Type = 'CIVILIZATION_KOREA');

CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_NAGISA'),	X,	Y
FROM Civilizations_GreatestEarthStartPosition WHERE (Type = 'CIVILIZATION_MONGOL');

CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_ORIGINAL_MADOKA'),	X,	Y
FROM Civilizations_GreatestEarthStartPosition WHERE (Type = 'CIVILIZATION_JAPAN');

CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_DEMON_HOMURA'),	X,	Y
FROM Civilizations_GreatestEarthStartPosition WHERE (Type = 'CIVILIZATION_ASSYRIA');

CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_KAORU_UMIKA'),	X,	Y
FROM Civilizations_GreatestEarthStartPosition WHERE (Type = 'CIVILIZATION_SPAIN'); --because soccer

CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_GreatestEarthStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_ORIKO_KIRIKA'),	X,	Y
FROM Civilizations_GreatestEarthStartPosition WHERE (Type = 'CIVILIZATION_EGYPT'); --just because
------------------------------------------------------------	
-- Civilizations_NorthAtlanticStartPosition (North Atlantic)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthAtlanticStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthAtlanticStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_MADOKA'),	X,	Y
FROM Civilizations_NorthAtlanticStartPosition WHERE (Type = 'CIVILIZATION_OTTOMAN');

CREATE TABLE IF NOT EXISTS Civilizations_NorthAtlanticStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthAtlanticStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_HOMURA'),	X,	Y
FROM Civilizations_NorthAtlanticStartPosition WHERE (Type = 'CIVILIZATION_CHINA');

CREATE TABLE IF NOT EXISTS Civilizations_NorthAtlanticStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthAtlanticStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_SAYAKA'),	X,	Y
FROM Civilizations_NorthAtlanticStartPosition WHERE (Type = 'CIVILIZATION_AUSTRIA');

CREATE TABLE IF NOT EXISTS Civilizations_NorthAtlanticStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthAtlanticStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_MAMI'),	X,	Y
FROM Civilizations_NorthAtlanticStartPosition WHERE (Type = 'CIVILIZATION_ROME');

CREATE TABLE IF NOT EXISTS Civilizations_NorthAtlanticStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthAtlanticStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_KYOUKO'),	X,	Y
FROM Civilizations_NorthAtlanticStartPosition WHERE (Type = 'CIVILIZATION_KOREA');

CREATE TABLE IF NOT EXISTS Civilizations_NorthAtlanticStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthAtlanticStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_NAGISA'),	X,	Y
FROM Civilizations_NorthAtlanticStartPosition WHERE (Type = 'CIVILIZATION_MONGOL');

CREATE TABLE IF NOT EXISTS Civilizations_NorthAtlanticStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthAtlanticStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_ORIGINAL_MADOKA'),	X,	Y
FROM Civilizations_NorthAtlanticStartPosition WHERE (Type = 'CIVILIZATION_JAPAN');

CREATE TABLE IF NOT EXISTS Civilizations_NorthAtlanticStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthAtlanticStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_DEMON_HOMURA'),	X,	Y
FROM Civilizations_NorthAtlanticStartPosition WHERE (Type = 'CIVILIZATION_ASSYRIA');

CREATE TABLE IF NOT EXISTS Civilizations_NorthAtlanticStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthAtlanticStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_KAORU_UMIKA'),	X,	Y
FROM Civilizations_NorthAtlanticStartPosition WHERE (Type = 'CIVILIZATION_SPAIN'); --because soccer

CREATE TABLE IF NOT EXISTS Civilizations_NorthAtlanticStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_NorthAtlanticStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_ORIKO_KIRIKA'),	X,	Y
FROM Civilizations_NorthAtlanticStartPosition WHERE (Type = 'CIVILIZATION_EGYPT'); --just because
------------------------------------------------------------	
-- Civilizations_AmericasStartPosition (Americas)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AmericasStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AmericasStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_MADOKA'),	X,	Y
FROM Civilizations_AmericasStartPosition WHERE (Type = 'CIVILIZATION_OTTOMAN');

CREATE TABLE IF NOT EXISTS Civilizations_AmericasStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AmericasStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_HOMURA'),	X,	Y
FROM Civilizations_AmericasStartPosition WHERE (Type = 'CIVILIZATION_CHINA');

CREATE TABLE IF NOT EXISTS Civilizations_AmericasStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AmericasStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_SAYAKA'),	X,	Y
FROM Civilizations_AmericasStartPosition WHERE (Type = 'CIVILIZATION_AUSTRIA');

CREATE TABLE IF NOT EXISTS Civilizations_AmericasStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AmericasStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_MAMI'),	X,	Y
FROM Civilizations_AmericasStartPosition WHERE (Type = 'CIVILIZATION_ROME');

CREATE TABLE IF NOT EXISTS Civilizations_AmericasStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AmericasStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_KYOUKO'),	X,	Y
FROM Civilizations_AmericasStartPosition WHERE (Type = 'CIVILIZATION_KOREA');

CREATE TABLE IF NOT EXISTS Civilizations_AmericasStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AmericasStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_NAGISA'),	X,	Y
FROM Civilizations_AmericasStartPosition WHERE (Type = 'CIVILIZATION_MONGOL');

CREATE TABLE IF NOT EXISTS Civilizations_AmericasStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AmericasStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_ORIGINAL_MADOKA'),	X,	Y
FROM Civilizations_AmericasStartPosition WHERE (Type = 'CIVILIZATION_JAPAN');

CREATE TABLE IF NOT EXISTS Civilizations_AmericasStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AmericasStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_DEMON_HOMURA'),	X,	Y
FROM Civilizations_AmericasStartPosition WHERE (Type = 'CIVILIZATION_ASSYRIA');

CREATE TABLE IF NOT EXISTS Civilizations_AmericasStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AmericasStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_KAORU_UMIKA'),	X,	Y
FROM Civilizations_AmericasStartPosition WHERE (Type = 'CIVILIZATION_SPAIN'); --because soccer

CREATE TABLE IF NOT EXISTS Civilizations_AmericasStartPosition(Type, X, Y, AltX, AltY);
INSERT INTO Civilizations_AmericasStartPosition
			(Type,							X,	Y)
SELECT		('CIVILIZATION_ORIKO_KIRIKA'),	X,	Y
FROM Civilizations_AmericasStartPosition WHERE (Type = 'CIVILIZATION_EGYPT'); --just because
------------------------------------------------------------	
-- Civilizations_YagemRequestedResource (Earth Giant)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YagemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YagemRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_MADOKA'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE (Type = 'CIVILIZATION_OTTOMAN');

INSERT INTO Civilizations_YagemRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_HOMURA'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE (Type = 'CIVILIZATION_CHINA');

INSERT INTO Civilizations_YagemRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_SAYAKA'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE (Type = 'CIVILIZATION_AUSTRIA');

INSERT INTO Civilizations_YagemRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_MAMI'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE (Type = 'CIVILIZATION_ROME');

INSERT INTO Civilizations_YagemRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_KYOUKO'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE (Type = 'CIVILIZATION_KOREA');

INSERT INTO Civilizations_YagemRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_NAGISA'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE (Type = 'CIVILIZATION_MONGOL');

INSERT INTO Civilizations_YagemRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_ORIGINAL_MADOKA'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE (Type = 'CIVILIZATION_JAPAN');

INSERT INTO Civilizations_YagemRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_DEMON_HOMURA'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE (Type = 'CIVILIZATION_ASSYRIA');

INSERT INTO Civilizations_YagemRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_KAORU_UMIKA'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE (Type = 'CIVILIZATION_SPAIN');

INSERT INTO Civilizations_YagemRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_ORIKO_KIRIKA'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE (Type = 'CIVILIZATION_EGYPT');

------------------------------------------------------------	
-- Civilizations_YahemRequestedResource (Earth Huge)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_YahemRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_YahemRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_MADOKA'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE (Type = 'CIVILIZATION_OTTOMAN');

INSERT INTO Civilizations_YahemRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_HOMURA'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE (Type = 'CIVILIZATION_CHINA');

INSERT INTO Civilizations_YahemRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_SAYAKA'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE (Type = 'CIVILIZATION_AUSTRIA');

INSERT INTO Civilizations_YahemRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_MAMI'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE (Type = 'CIVILIZATION_ROME');

INSERT INTO Civilizations_YahemRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_KYOUKO'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE (Type = 'CIVILIZATION_KOREA');

INSERT INTO Civilizations_YahemRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_NAGISA'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE (Type = 'CIVILIZATION_MONGOL');

INSERT INTO Civilizations_YahemRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_ORIGINAL_MADOKA'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE (Type = 'CIVILIZATION_JAPAN');

INSERT INTO Civilizations_YahemRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_DEMON_HOMURA'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE (Type = 'CIVILIZATION_ASSYRIA');

INSERT INTO Civilizations_YahemRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_KAORU_UMIKA'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE (Type = 'CIVILIZATION_SPAIN');

INSERT INTO Civilizations_YahemRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_ORIKO_KIRIKA'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YahemRequestedResource WHERE (Type = 'CIVILIZATION_EGYPT');
------------------------------------------------------------	
-- Civilizations_GreatestEarthRequestedResource (Earth Greatest)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_GreatestEarthRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_GreatestEarthRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_MADOKA'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_GreatestEarthRequestedResource WHERE (Type = 'CIVILIZATION_OTTOMAN');

INSERT INTO Civilizations_GreatestEarthRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_HOMURA'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_GreatestEarthRequestedResource WHERE (Type = 'CIVILIZATION_CHINA');

INSERT INTO Civilizations_GreatestEarthRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_SAYAKA'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_GreatestEarthRequestedResource WHERE (Type = 'CIVILIZATION_AUSTRIA');

INSERT INTO Civilizations_GreatestEarthRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_MAMI'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_GreatestEarthRequestedResource WHERE (Type = 'CIVILIZATION_ROME');

INSERT INTO Civilizations_GreatestEarthRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_KYOUKO'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_GreatestEarthRequestedResource WHERE (Type = 'CIVILIZATION_KOREA');

INSERT INTO Civilizations_GreatestEarthRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_NAGISA'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_GreatestEarthRequestedResource WHERE (Type = 'CIVILIZATION_MONGOL');

INSERT INTO Civilizations_GreatestEarthRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_ORIGINAL_MADOKA'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_GreatestEarthRequestedResource WHERE (Type = 'CIVILIZATION_JAPAN');

INSERT INTO Civilizations_GreatestEarthRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_DEMON_HOMURA'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_GreatestEarthRequestedResource WHERE (Type = 'CIVILIZATION_ASSYRIA');

INSERT INTO Civilizations_GreatestEarthRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_KAORU_UMIKA'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_GreatestEarthRequestedResource WHERE (Type = 'CIVILIZATION_SPAIN');

INSERT INTO Civilizations_GreatestEarthRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_ORIKO_KIRIKA'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_GreatestEarthRequestedResource WHERE (Type = 'CIVILIZATION_EGYPT');
------------------------------------------------------------	
-- Civilizations_AmericasRequestedResource (Americas)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_AmericasRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_AmericasRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_MADOKA'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AmericasRequestedResource WHERE (Type = 'CIVILIZATION_OTTOMAN');

INSERT INTO Civilizations_AmericasRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_HOMURA'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AmericasRequestedResource WHERE (Type = 'CIVILIZATION_CHINA');

INSERT INTO Civilizations_AmericasRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_SAYAKA'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AmericasRequestedResource WHERE (Type = 'CIVILIZATION_AUSTRIA');

INSERT INTO Civilizations_AmericasRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_MAMI'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AmericasRequestedResource WHERE (Type = 'CIVILIZATION_ROME');

INSERT INTO Civilizations_AmericasRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_KYOUKO'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AmericasRequestedResource WHERE (Type = 'CIVILIZATION_KOREA');

INSERT INTO Civilizations_AmericasRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_NAGISA'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AmericasRequestedResource WHERE (Type = 'CIVILIZATION_MONGOL');

INSERT INTO Civilizations_AmericasRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_ORIGINAL_MADOKA'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AmericasRequestedResource WHERE (Type = 'CIVILIZATION_JAPAN');

INSERT INTO Civilizations_AmericasRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_DEMON_HOMURA'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AmericasRequestedResource WHERE (Type = 'CIVILIZATION_ASSYRIA');

INSERT INTO Civilizations_AmericasRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_KAORU_UMIKA'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AmericasRequestedResource WHERE (Type = 'CIVILIZATION_SPAIN');

INSERT INTO Civilizations_AmericasRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_ORIKO_KIRIKA'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_AmericasRequestedResource WHERE (Type = 'CIVILIZATION_EGYPT');
------------------------------------------------------------	
-- Civilizations_NorthAtlanticRequestedResource (North Atlantic)
------------------------------------------------------------	
CREATE TABLE IF NOT EXISTS Civilizations_NorthAtlanticRequestedResource(Type, Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4);
INSERT INTO Civilizations_NorthAtlanticRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_MADOKA'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_NorthAtlanticRequestedResource WHERE (Type = 'CIVILIZATION_OTTOMAN');

INSERT INTO Civilizations_NorthAtlanticRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_HOMURA'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_NorthAtlanticRequestedResource WHERE (Type = 'CIVILIZATION_CHINA');

INSERT INTO Civilizations_NorthAtlanticRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_SAYAKA'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_NorthAtlanticRequestedResource WHERE (Type = 'CIVILIZATION_AUSTRIA');

INSERT INTO Civilizations_NorthAtlanticRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_MAMI'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_NorthAtlanticRequestedResource WHERE (Type = 'CIVILIZATION_ROME');

INSERT INTO Civilizations_NorthAtlanticRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_KYOUKO'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_NorthAtlanticRequestedResource WHERE (Type = 'CIVILIZATION_KOREA');

INSERT INTO Civilizations_NorthAtlanticRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_NAGISA'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_NorthAtlanticRequestedResource WHERE (Type = 'CIVILIZATION_MONGOL');

INSERT INTO Civilizations_NorthAtlanticRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_ORIGINAL_MADOKA'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_NorthAtlanticRequestedResource WHERE (Type = 'CIVILIZATION_JAPAN');

INSERT INTO Civilizations_NorthAtlanticRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_DEMON_HOMURA'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_NorthAtlanticRequestedResource WHERE (Type = 'CIVILIZATION_ASSYRIA');

INSERT INTO Civilizations_NorthAtlanticRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_KAORU_UMIKA'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_NorthAtlanticRequestedResource WHERE (Type = 'CIVILIZATION_SPAIN');

INSERT INTO Civilizations_NorthAtlanticRequestedResource
			(Type, 						Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_ORIKO_KIRIKA'),	Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_NorthAtlanticRequestedResource WHERE (Type = 'CIVILIZATION_EGYPT');
--==========================================================================================================================
-- Hazel's Map Labels
--==========================================================================================================================
-- ML_CivCultures
------------------------------	
CREATE TABLE IF NOT EXISTS ML_CivCultures (ID INTEGER PRIMARY KEY AUTOINCREMENT, CivType TEXT, CultureType TEXT, CultureEra TEXT DEFAULT 'ANY');
INSERT INTO ML_CivCultures
			(CivType,							CultureType,		CultureEra)
VALUES		('CIVILIZATION_ORIGINAL_MADOKA',	'PACIFIC',			'ANY'),
			('CIVILIZATION_HOMURA',				'PACIFIC',			'ANY'),
			('CIVILIZATION_MAMI',				'MEDITERRANEAN',	'ANY'),
			('CIVILIZATION_SAYAKA',				'GERMANIC',			'ANY'),
			('CIVILIZATION_KYOUKO',				'PACIFIC',			'ANY'),
			('CIVILIZATION_NAGISA',				'SLAVIC',			'ANY'),
			('CIVILIZATION_MADOKA',				'ARABIAN',			'ANY'),
			('CIVILIZATION_DEMON_HOMURA',		'ARABIAN',			'ANY'),
			('CIVILIZATION_KAORU_UMIKA',		'PACIFIC',			'ANY'),
			('CIVILIZATION_ORIKO_KIRIKA',		'PACIFIC',			'ANY');

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
			(CivilizationType,					CultureType,		SplashScreenTag)
VALUES		('CIVILIZATION_MADOKA',				'JFD_Madoka',		'JFD_Madoka'),
			('CIVILIZATION_HOMURA',				'JFD_Madoka',		'JFD_Madoka'),
			('CIVILIZATION_MAMI',				'JFD_Madoka',		'JFD_Madoka'),
			('CIVILIZATION_SAYAKA',				'JFD_Madoka',		'JFD_Madoka'),
			('CIVILIZATION_KYOUKO',				'JFD_Madoka',		'JFD_Madoka'),
			('CIVILIZATION_NAGISA',				'JFD_Madoka',		'JFD_Madoka'),
			('CIVILIZATION_ORIGINAL_MADOKA',	'JFD_Madoka',		'JFD_Madoka'),
			('CIVILIZATION_KAORU_UMIKA',		'JFD_Madoka',		'JFD_Madoka'),
			('CIVILIZATION_ORIKO_KIRIKA',		'JFD_Madoka',		'JFD_Madoka'),

			--None of the other girls like DH and thus she's in a separate CultureType
			('CIVILIZATION_DEMON_HOMURA',		'JFD_Totalitarian',	'JFD_Madoka');


--the soundtrack is handled by the soundtrack mod!



--==========================================================================================================================
-- JFD's Exploration Continued Expanded
--==========================================================================================================================

/*  We'll do this later when the Colonial system is actually in place.
-- Civilization_JFD_ColonialCityNames
------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_ColonialCityNames (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	ColonyName 									text										default null,
	LinguisticType								text										default	null,
	CultureType									text										default	null);

INSERT OR REPLACE INTO Civilization_JFD_ColonialCityNames
			(CivilizationType, 				ColonyName,								LinguisticType)
VALUES		('CIVILIZATION_JJBA_AMERICA',	null,									'JFD_Germanic'),
			('CIVILIZATION_JJBA_AMERICA',	null,									'JFD_Latinate');  */

------------------------------	
-- Civilization_JFD_RevolutionaryCivilizationsToSpawn
------------------------------	
CREATE TABLE IF NOT EXISTS 
Civilization_JFD_RevolutionaryCivilizationsToSpawn (
	CivilizationType 							text 	REFERENCES Civilizations(Type) 		default null,
	RevolutionaryCivilizationType 				text 	REFERENCES Civilizations(Type) 		default null);
	
INSERT INTO Civilization_JFD_RevolutionaryCivilizationsToSpawn
			(CivilizationType,					RevolutionaryCivilizationType)
VALUES		('CIVILIZATION_MADOKA',				'CIVILIZATION_DEMON_HOMURA'),
			('CIVILIZATION_DEMON_HOMURA',		'CIVILIZATION_MADOKA'),

			('CIVILIZATION_ORIGINAL_MADOKA',	'CIVILIZATION_HOMURA'),
			('CIVILIZATION_ORIGINAL_MADOKA',	'CIVILIZATION_MAMI'),
			('CIVILIZATION_ORIGINAL_MADOKA',	'CIVILIZATION_SAYAKA'),
			('CIVILIZATION_ORIGINAL_MADOKA',	'CIVILIZATION_KYOUKO'),
			('CIVILIZATION_ORIGINAL_MADOKA',	'CIVILIZATION_NAGISA'),
			('CIVILIZATION_ORIGINAL_MADOKA',	'CIVILIZATION_KAORU_UMIKA'),
			('CIVILIZATION_ORIGINAL_MADOKA',	'CIVILIZATION_ORIKO_KIRIKA'),

			('CIVILIZATION_HOMURA',				'CIVILIZATION_ORIGINAL_MADOKA'),
			('CIVILIZATION_HOMURA',				'CIVILIZATION_MAMI'),
			('CIVILIZATION_HOMURA',				'CIVILIZATION_SAYAKA'),
			('CIVILIZATION_HOMURA',				'CIVILIZATION_KYOUKO'),
			('CIVILIZATION_HOMURA',				'CIVILIZATION_NAGISA'),
			('CIVILIZATION_HOMURA',				'CIVILIZATION_KAORU_UMIKA'),
			('CIVILIZATION_HOMURA',				'CIVILIZATION_ORIKO_KIRIKA'),

			('CIVILIZATION_MAMI',				'CIVILIZATION_ORIGINAL_MADOKA'),
			('CIVILIZATION_MAMI',				'CIVILIZATION_HOMURA'),
			('CIVILIZATION_MAMI',				'CIVILIZATION_SAYAKA'),
			('CIVILIZATION_MAMI',				'CIVILIZATION_KYOUKO'),
			('CIVILIZATION_MAMI',				'CIVILIZATION_NAGISA'),
			('CIVILIZATION_MAMI',				'CIVILIZATION_KAORU_UMIKA'),
			('CIVILIZATION_MAMI',				'CIVILIZATION_ORIKO_KIRIKA'),

			('CIVILIZATION_SAYAKA',				'CIVILIZATION_ORIGINAL_MADOKA'),
			('CIVILIZATION_SAYAKA',				'CIVILIZATION_HOMURA'),
			('CIVILIZATION_SAYAKA',				'CIVILIZATION_MAMI'),
			('CIVILIZATION_SAYAKA',				'CIVILIZATION_KYOUKO'),
			('CIVILIZATION_SAYAKA',				'CIVILIZATION_NAGISA'),
			('CIVILIZATION_SAYAKA',				'CIVILIZATION_KAORU_UMIKA'),
			('CIVILIZATION_SAYAKA',				'CIVILIZATION_ORIKO_KIRIKA'),

			('CIVILIZATION_KYOUKO',				'CIVILIZATION_ORIGINAL_MADOKA'),
			('CIVILIZATION_KYOUKO',				'CIVILIZATION_HOMURA'),
			('CIVILIZATION_KYOUKO',				'CIVILIZATION_MAMI'),
			('CIVILIZATION_KYOUKO',				'CIVILIZATION_SAYAKA'),
			('CIVILIZATION_KYOUKO',				'CIVILIZATION_NAGISA'),
			('CIVILIZATION_KYOUKO',				'CIVILIZATION_KAORU_UMIKA'),
			('CIVILIZATION_KYOUKO',				'CIVILIZATION_ORIKO_KIRIKA'),

			('CIVILIZATION_NAGISA',				'CIVILIZATION_ORIGINAL_MADOKA'),
			('CIVILIZATION_NAGISA',				'CIVILIZATION_HOMURA'),
			('CIVILIZATION_NAGISA',				'CIVILIZATION_MAMI'),
			('CIVILIZATION_NAGISA',				'CIVILIZATION_SAYAKA'),
			('CIVILIZATION_NAGISA',				'CIVILIZATION_KYOUKO'),
			('CIVILIZATION_NAGISA',				'CIVILIZATION_KAORU_UMIKA'),
			('CIVILIZATION_NAGISA',				'CIVILIZATION_ORIKO_KIRIKA'),

			('CIVILIZATION_KAORU_UMIKA',		'CIVILIZATION_ORIGINAL_MADOKA'),
			('CIVILIZATION_KAORU_UMIKA',		'CIVILIZATION_HOMURA'),
			('CIVILIZATION_KAORU_UMIKA',		'CIVILIZATION_MAMI'),
			('CIVILIZATION_KAORU_UMIKA',		'CIVILIZATION_SAYAKA'),
			('CIVILIZATION_KAORU_UMIKA',		'CIVILIZATION_KYOUKO'),
			('CIVILIZATION_KAORU_UMIKA',		'CIVILIZATION_NAGISA'),
			('CIVILIZATION_KAORU_UMIKA',		'CIVILIZATION_ORIKO_KIRIKA'),

			('CIVILIZATION_ORIKO_KIRIKA',		'CIVILIZATION_ORIGINAL_MADOKA'),
			('CIVILIZATION_ORIKO_KIRIKA',		'CIVILIZATION_HOMURA'),
			('CIVILIZATION_ORIKO_KIRIKA',		'CIVILIZATION_MAMI'),
			('CIVILIZATION_ORIKO_KIRIKA',		'CIVILIZATION_SAYAKA'),
			('CIVILIZATION_ORIKO_KIRIKA',		'CIVILIZATION_KYOUKO'),
			('CIVILIZATION_ORIKO_KIRIKA',		'CIVILIZATION_NAGISA'),
			('CIVILIZATION_ORIKO_KIRIKA',		'CIVILIZATION_KAORU_UMIKA');

--MGs, Witches, Familiars, and Incubators should ignore the attrition system
INSERT INTO Unit_FreePromotions
			(UnitType,					PromotionType)
SELECT		('UNIT_PMMM_MAGICAL_GIRL'),	('PROMOTION_JFD_IMMUNITY')
FROM Unit_FreePromotions WHERE EXISTS (SELECT * FROM UnitPromotions WHERE Type = 'PROMOTION_JFD_IMMUNITY');

INSERT INTO Unit_FreePromotions
			(UnitType,					PromotionType)
SELECT		('UNIT_PMMM_FAMILIAR'),		('PROMOTION_JFD_IMMUNITY')
FROM Unit_FreePromotions WHERE EXISTS (SELECT * FROM UnitPromotions WHERE Type = 'PROMOTION_JFD_IMMUNITY');

INSERT INTO Unit_FreePromotions
			(UnitType,					PromotionType)
SELECT		('UNIT_PMMM_WITCH'),		('PROMOTION_JFD_IMMUNITY')
FROM Unit_FreePromotions WHERE EXISTS (SELECT * FROM UnitPromotions WHERE Type = 'PROMOTION_JFD_IMMUNITY');

INSERT INTO Unit_FreePromotions
			(UnitType,					PromotionType)
SELECT		('UNIT_PMMM_INCUBATOR'),	('PROMOTION_JFD_IMMUNITY')
FROM Unit_FreePromotions WHERE EXISTS (SELECT * FROM UnitPromotions WHERE Type = 'PROMOTION_JFD_IMMUNITY');

INSERT INTO Unit_FreePromotions
			(UnitType,					PromotionType)
SELECT		('UNIT_PMMM_SEA_FAMILIAR'),	('PROMOTION_JFD_IMMUNITY')
FROM Unit_FreePromotions WHERE EXISTS (SELECT * FROM UnitPromotions WHERE Type = 'PROMOTION_JFD_IMMUNITY');

INSERT INTO Unit_FreePromotions
			(UnitType,					PromotionType)
SELECT		('UNIT_PMMM_SEA_WITCH'),	('PROMOTION_JFD_IMMUNITY')
FROM Unit_FreePromotions WHERE EXISTS (SELECT * FROM UnitPromotions WHERE Type = 'PROMOTION_JFD_IMMUNITY');


--Clara Dolls shouldn't have Scurvy
DELETE FROM Unit_FreePromotions
WHERE UnitType = 'UNIT_PMMM_CLARA_DOLL' AND PromotionType = 'PROMOTION_JFD_SCURVY';


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
VALUES		('LEADER_MADOKA',			'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',	0),
			('LEADER_HOMURA',			'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',	2),
			('LEADER_MAMI',				'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',	0),
			('LEADER_SAYAKA',			'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',	1),
			('LEADER_KYOUKO',			'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',	4),
			('LEADER_NAGISA',			'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',	0),
			('LEADER_MADOKA',			'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',	10),
			('LEADER_DEMON_HOMURA',		'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',	12),
			('LEADER_KAORU_UMIKA',		'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',	0),
			('LEADER_ORIKO_KIRIKA',		'FLAVOR_JFD_RELIGIOUS_INTOLERANCE',	6);