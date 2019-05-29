--------------------------------------------------------------------------------------------------------------
-- MAGICAL GIRL MISSIONS
---------------------------------------------------------------------------------------------------------------

--Witch Hunt
INSERT INTO Missions
			(Type,Description,Help,DisabledHelp,EntityEventType,Time,OrderPriority,Visible,IconIndex,IconAtlas)
SELECT		('MISSION_PMMM_WITCH_HUNT'),('TXT_KEY_MISSION_PMMM_WITCH_HUNT'),('TXT_KEY_MISSION_PMMM_WITCH_HUNT_HELP'),('TXT_KEY_MISSION_PMMM_WITCH_HUNT_DISABLED'),EntityEventType,Time,200,Visible,1,('PMMM_MISSION_ATLAS')
FROM Missions WHERE Type = 'MISSION_RANGE_ATTACK';


--Socialize
INSERT INTO Missions
			(Type,Description,Help,DisabledHelp,EntityEventType,Time,OrderPriority,Visible,IconIndex,IconAtlas,
			PMMMMissionRange,PMMMTargetType,			PMMMMissionExec)
SELECT		('MISSION_PMMM_SOCIALIZE'),('TXT_KEY_MISSION_PMMM_SOCIALIZE'),('TXT_KEY_MISSION_PMMM_SOCIALIZE_HELP'),('TXT_KEY_MISSION_PMMM_SOCIALIZE_DISABLED'),EntityEventType,Time,200,Visible,0,('PMMM_MISSION_ATLAS'),
			1,				('NON_ENEMY_MAGICAL_GIRL'),	('SOCIALIZE')
FROM Missions WHERE Type = 'MISSION_RANGE_ATTACK';

--Automated Socialize
INSERT INTO Missions
			(Type,Description,Help,DisabledHelp,EntityEventType,Time,OrderPriority,Visible,IconIndex,IconAtlas)
SELECT		('MISSION_PMMM_SOCIALIZE_AUTO'),('TXT_KEY_MISSION_PMMM_SOCIALIZE_AUTO'),('TXT_KEY_MISSION_PMMM_SOCIALIZE_AUTO_HELP'),('TXT_KEY_MISSION_PMMM_SOCIALIZE_AUTO_DISABLED'),EntityEventType,Time,30,Visible,8,('PMMM_MISSION_ATLAS')
FROM Missions WHERE Type = 'MISSION_RANGE_ATTACK';


--Dull Pain
INSERT INTO Missions
			(Type,Description,Help,DisabledHelp,EntityEventType,Time,OrderPriority,Visible,IconIndex,IconAtlas)
SELECT		('MISSION_PMMM_DULL_PAIN'),('TXT_KEY_MISSION_PMMM_DULL_PAIN'),('TXT_KEY_MISSION_PMMM_DULL_PAIN_HELP'),('TXT_KEY_MISSION_PMMM_DULL_PAIN_DISABLED'),EntityEventType,Time,200,Visible,2,('PMMM_MISSION_ATLAS')
FROM Missions WHERE Type = 'MISSION_RANGE_ATTACK';


--Vacation
INSERT INTO Missions
			(Type,Description,Help,DisabledHelp,EntityEventType,Time,OrderPriority,Visible,IconIndex,IconAtlas)
SELECT		('MISSION_PMMM_VACATION'),('TXT_KEY_MISSION_PMMM_VACATION'),('TXT_KEY_MISSION_PMMM_VACATION_HELP'),('TXT_KEY_MISSION_PMMM_VACATION_DISABLED'),EntityEventType,Time,200,Visible,4,('PMMM_MISSION_ATLAS')
FROM Missions WHERE Type = 'MISSION_RANGE_ATTACK';


--Write Home
INSERT INTO Missions
			(Type,Description,Help,DisabledHelp,EntityEventType,Time,OrderPriority,Visible,IconIndex,IconAtlas)
SELECT		('MISSION_PMMM_WRITE_HOME'),('TXT_KEY_MISSION_PMMM_WRITE_HOME'),('TXT_KEY_MISSION_PMMM_WRITE_HOME_HELP'),('TXT_KEY_MISSION_PMMM_WRITE_HOME_DISABLED'),EntityEventType,Time,200,Visible,5,('PMMM_MISSION_ATLAS')
FROM Missions WHERE Type = 'MISSION_RANGE_ATTACK';


--Phone Home
INSERT INTO Missions
			(Type,Description,Help,DisabledHelp,EntityEventType,Time,OrderPriority,Visible,IconIndex,IconAtlas)
SELECT		('MISSION_PMMM_PHONE_HOME'),('TXT_KEY_MISSION_PMMM_PHONE_HOME'),('TXT_KEY_MISSION_PMMM_PHONE_HOME_HELP'),('TXT_KEY_MISSION_PMMM_PHONE_HOME_DISABLED'),EntityEventType,Time,200,Visible,6,('PMMM_MISSION_ATLAS')
FROM Missions WHERE Type = 'MISSION_RANGE_ATTACK';

--Spar
INSERT INTO Missions
			(Type,Description,Help,DisabledHelp,EntityEventType,Time,OrderPriority,Visible,IconIndex,IconAtlas,
			PMMMMissionRange,PMMMTargetType,			PMMMMissionExec)
SELECT		('MISSION_PMMM_SPAR'),('TXT_KEY_MISSION_PMMM_SPAR'),('TXT_KEY_MISSION_PMMM_SPAR_HELP'),('TXT_KEY_MISSION_PMMM_SPAR_DISABLED'),EntityEventType,Time,200,Visible,7,('PMMM_MISSION_ATLAS'),
			1,				('SPARRING'),	('SPAR')
FROM Missions WHERE Type = 'MISSION_RANGE_ATTACK';


--Grief Seed Use (not shown as a typical Unit Panel action, but triggered through clicking the Grief Seed value on the unit stats)
INSERT INTO Missions
			(Type,Description,Help,DisabledHelp,EntityEventType,Time,OrderPriority,Visible,IconIndex,IconAtlas)
SELECT		('MISSION_PMMM_GRIEF_SEED'),('TXT_KEY_MISSION_PMMM_WITCH_HUNT'),('TXT_KEY_MISSION_PMMM_WITCH_HUNT_HELP'),('TXT_KEY_MISSION_PMMM_WITCH_HUNT_DISABLED'),EntityEventType,Time,200,0,16,('UNIT_ACTION_ATLAS')
FROM Missions WHERE Type = 'MISSION_RANGE_ATTACK';


---------------------------------------------------------------------------------------------------------------
-- MISCELLANEOUS MISSIONS
---------------------------------------------------------------------------------------------------------------

--Rouse Militia GrGen action
INSERT INTO Missions
			(Type,Description,Help,DisabledHelp,EntityEventType,Time,OrderPriority,Visible,IconIndex,IconAtlas)
SELECT		('MISSION_PMMM_ROUSE_MILITIA'),('TXT_KEY_MISSION_PMMM_ROUSE_MILITIA'),('TXT_KEY_MISSION_PMMM_ROUSE_MILITIA_HELP'),('TXT_KEY_MISSION_PMMM_ROUSE_MILITIA_DISABLED'),EntityEventType,Time,200,Visible,3,('UNIT_ACTION_ATLAS_RELIGION')
FROM Missions WHERE Type = 'MISSION_TRADE';

--Purification through Hope (Missionaries cleaning SGs Reformation)
INSERT INTO Missions
			(Type,Description,Help,DisabledHelp,EntityEventType,Time,OrderPriority,Visible,IconIndex,IconAtlas)
SELECT		('MISSION_PMMM_PURIFICATION_THROUGH_HOPE'),('TXT_KEY_MISSION_PMMM_PURIFICATION_THROUGH_HOPE'),('TXT_KEY_MISSION_PMMM_PURIFICATION_THROUGH_HOPE_HELP'),('TXT_KEY_MISSION_PMMM_PURIFICATION_THROUGH_HOPE_DISABLED'),EntityEventType,Time,200,Visible,IconIndex,IconAtlas
FROM Missions WHERE Type = 'MISSION_FOUND_RELIGION';



---------------------------------------------------------------------------------------------------------------
-- MULTIPLAYER COMPATIBILITY MISSIONS
---------------------------------------------------------------------------------------------------------------

--Multiplayer Use: dummy invisible mission to push MG icon updates to other players
INSERT INTO Missions
			(Type,Description,Help,DisabledHelp,EntityEventType,Time,OrderPriority,Visible,IconIndex,IconAtlas)
SELECT		('MISSION_PMMM_APPEARANCE_UPDATE'),('TXT_KEY_MISSION_PMMM_ROUSE_MILITIA'),('TXT_KEY_MISSION_PMMM_ROUSE_MILITIA_HELP'),('TXT_KEY_MISSION_PMMM_ROUSE_MILITIA_DISABLED'),EntityEventType,Time,200,0,3,('UNIT_ACTION_ATLAS_RELIGION')
FROM Missions WHERE Type = 'MISSION_TRADE';

--Another dummy mission to push the Pleiades Freezer experiments. A unit is spawned, selected, pushed the mission, then killed. Whether or not this works must be tested.
INSERT INTO Missions
			(Type,Description,Help,DisabledHelp,EntityEventType,Time,OrderPriority,Visible,IconIndex,IconAtlas)
SELECT		('MISSION_PMMM_PLEIADES_FREEZER'),('TXT_KEY_MISSION_PMMM_ROUSE_MILITIA'),('TXT_KEY_MISSION_PMMM_ROUSE_MILITIA_HELP'),('TXT_KEY_MISSION_PMMM_ROUSE_MILITIA_DISABLED'),EntityEventType,Time,200,0,3,('UNIT_ACTION_ATLAS_RELIGION')
FROM Missions WHERE Type = 'MISSION_TRADE';

--Another dummy mission to push the Pleiades Freezer Grief Seed use.
INSERT INTO Missions
			(Type,Description,Help,DisabledHelp,EntityEventType,Time,OrderPriority,Visible,IconIndex,IconAtlas)
SELECT		('MISSION_PMMM_PLEIADES_FREEZER_GRIEF_SEED'),('TXT_KEY_MISSION_PMMM_ROUSE_MILITIA'),('TXT_KEY_MISSION_PMMM_ROUSE_MILITIA_HELP'),('TXT_KEY_MISSION_PMMM_ROUSE_MILITIA_DISABLED'),EntityEventType,Time,200,0,3,('UNIT_ACTION_ATLAS_RELIGION')
FROM Missions WHERE Type = 'MISSION_TRADE';




