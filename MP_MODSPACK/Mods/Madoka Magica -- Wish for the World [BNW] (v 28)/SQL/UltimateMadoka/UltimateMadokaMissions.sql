INSERT INTO Missions
			(Type,Description,Help,DisabledHelp,EntityEventType,Time,OrderPriority,Visible,IconIndex,IconAtlas,
			PMMMMissionRange,PMMMTargetType,PMMMMissionExec)
SELECT		('MISSION_PMMM_LEAD_AWAY'),('TXT_KEY_MISSION_PMMM_LEAD_AWAY'),('TXT_KEY_MISSION_PMMM_LEAD_AWAY_HELP'),('TXT_KEY_MISSION_PMMM_LEAD_AWAY_DISABLED'),EntityEventType,Time,200,Visible,13,('UNIT_ACTION_ATLAS'),
			1,('ENEMY_CRITICAL_MAGICAL_GIRL'),('LAW_OF_CYCLES')
FROM Missions WHERE Type = 'MISSION_RANGE_ATTACK';

INSERT INTO Missions
			(Type,Description,Help,DisabledHelp,EntityEventType,Time,OrderPriority,Visible,IconIndex,IconAtlas,
			PMMMMissionRange,PMMMTargetType,PMMMMissionExec)
SELECT		('MISSION_PMMM_SUMMON_WITCH'),('TXT_KEY_MISSION_PMMM_SUMMON_WITCH'),('TXT_KEY_MISSION_PMMM_SUMMON_WITCH_HELP'),('TXT_KEY_MISSION_PMMM_SUMMON_WITCH_DISABLED'),EntityEventType,Time,200,Visible,9,('UNIT_ACTION_ATLAS'),
			1,('EMPTY_PLOT'),('SUMMON_WITCH')
FROM Missions WHERE Type = 'MISSION_RANGE_ATTACK';

INSERT INTO Missions
			(Type,Description,Help,DisabledHelp,EntityEventType,Time,OrderPriority,Visible,IconIndex,IconAtlas)
SELECT		('MISSION_PMMM_DISMISS_WITCH'),('TXT_KEY_MISSION_PMMM_DISMISS_WITCH'),('TXT_KEY_MISSION_PMMM_DISMISS_WITCH_HELP'),('TXT_KEY_MISSION_PMMM_DISMISS_WITCH_DISABLED'),EntityEventType,Time,75,Visible,11,('UNIT_ACTION_ATLAS')
FROM Missions WHERE Type = 'MISSION_RANGE_ATTACK';