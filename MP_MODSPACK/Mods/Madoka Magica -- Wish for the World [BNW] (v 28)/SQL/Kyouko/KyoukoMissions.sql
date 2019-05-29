INSERT INTO Missions
			(Type,Description,Help,DisabledHelp,EntityEventType,Time,OrderPriority,Visible,IconIndex,IconAtlas)
SELECT		('MISSION_PMMM_KYOUKO_GIVE_FOOD'),('TXT_KEY_MISSION_PMMM_GIVE_FOOD'),('TXT_KEY_MISSION_PMMM_GIVE_FOOD_HELP'),('TXT_KEY_MISSION_PMMM_GIVE_FOOD_DISABLED'),EntityEventType,Time,OrderPriority,Visible,IconIndex,IconAtlas
FROM Missions WHERE Type = 'MISSION_SELL_EXOTIC_GOODS';

INSERT INTO Missions
			(Type,Description,Help,DisabledHelp,EntityEventType,Time,OrderPriority,Visible,IconIndex,IconAtlas)
SELECT		('MISSION_PMMM_KYOUKO_FOOD_HEAL'),('TXT_KEY_MISSION_PMMM_FOOD_HEAL'),('TXT_KEY_MISSION_PMMM_FOOD_HEAL_HELP'),('TXT_KEY_MISSION_PMMM_FOOD_HEAL_DISABLED'),EntityEventType,Time,OrderPriority,Visible,IconIndex,IconAtlas
FROM Missions WHERE Type = 'MISSION_SELL_EXOTIC_GOODS';