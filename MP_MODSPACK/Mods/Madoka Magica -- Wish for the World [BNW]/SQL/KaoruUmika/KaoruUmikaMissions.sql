INSERT INTO Missions
			(Type,Description,Help,DisabledHelp,EntityEventType,Time,OrderPriority,Visible,IconIndex,IconAtlas,PMMMPolishAmount,PMMMMissionRange,PMMMTargetType,PMMMMissionExec)
SELECT		('MISSION_PMMM_POLISH'),('TXT_KEY_MISSION_PMMM_POLISH'),('TXT_KEY_MISSION_PMMM_POLISH_HELP'),('TXT_KEY_MISSION_PMMM_POLISH_DISABLED'),EntityEventType,Time,200,Visible,54,('UNIT_ACTION_ATLAS'),3,1,('FRIENDLY_MAGICAL_GIRL'),('POLISH')
FROM Missions WHERE Type = 'MISSION_RANGE_ATTACK';