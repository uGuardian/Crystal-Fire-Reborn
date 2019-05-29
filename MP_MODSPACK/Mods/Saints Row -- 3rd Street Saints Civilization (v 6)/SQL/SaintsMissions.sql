INSERT INTO Missions
			(Type,Description,Help,DisabledHelp,EntityEventType,Time,OrderPriority,Visible,IconIndex,IconAtlas)
SELECT		('MISSION_SRTT_RIM_JOBS'),('TXT_KEY_SRTT_RJ_BUTTON_TITLE'),('TXT_KEY_SRTT_RJ_BUTTON_TEXT'),('TXT_KEY_SRTT_RJ_BUTTON_DISABLED_TEXT'),EntityEventType,Time,200,Visible,20,('UNIT_ACTION_ATLAS')
FROM Missions WHERE Type = 'MISSION_RANGE_ATTACK';


INSERT INTO Missions
			(Type,Description,Help,DisabledHelp,EntityEventType,Time,OrderPriority,Visible,IconIndex,IconAtlas)
SELECT		('MISSION_SRTT_JOYRIDE'),('TXT_KEY_SRTT_JOYRIDE_BUTTON_TITLE'),('TXT_KEY_SRTT_JOYRIDE_BUTTON_TEXT'),('TXT_KEY_SRTT_JOYRIDE_BUTTON_DISABLED_DVMC_TEXT'),EntityEventType,Time,200,Visible,36,('UNIT_ACTION_ATLAS')
FROM Missions WHERE Type = 'MISSION_RANGE_ATTACK';

INSERT INTO Missions
			(Type,Description,Help,DisabledHelp,EntityEventType,Time,OrderPriority,Visible,IconIndex,IconAtlas)
SELECT		('MISSION_SRTT_NITROUS'),('TXT_KEY_SRTT_NITROUS_BUTTON_TITLE'),('TXT_KEY_SRTT_NITROUS_BUTTON_TEXT'),('TXT_KEY_SRTT_NITROUS_BUTTON_DISABLED_DVMC_TEXT'),EntityEventType,Time,200,Visible,23,('UNIT_ACTION_ATLAS')
FROM Missions WHERE Type = 'MISSION_RANGE_ATTACK';