INSERT INTO Missions
			(Type,Description,Help,DisabledHelp,EntityEventType,Time,OrderPriority,Visible,IconIndex,IconAtlas,PMMMMissionRange,PMMMTargetType,PMMMMissionExec)
SELECT		('MISSION_PMMM_TIRO_FINALE'),('TXT_KEY_MISSION_PMMM_TIRO_FINALE'),('TXT_KEY_MISSION_PMMM_TIRO_FINALE_HELP'),('TXT_KEY_MISSION_PMMM_TIRO_FINALE_DISABLED'),EntityEventType,Time,200,Visible,17,('UNIT_ACTION_ATLAS'),2,
			('ENEMY'),('TIRO_FINALE')
FROM Missions WHERE Type = 'MISSION_RANGE_ATTACK';