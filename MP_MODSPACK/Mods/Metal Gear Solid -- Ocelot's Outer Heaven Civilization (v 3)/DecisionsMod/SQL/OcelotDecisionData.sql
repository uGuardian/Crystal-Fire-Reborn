INSERT INTO DecisionsAddin_Support		
			(FileName)
VALUES		('OcelotDecisions.lua');


INSERT INTO Policies
			(Type)
VALUES		('POLICY_DECISIONS_OCELOT_GESTURE');

UPDATE Policies
SET MinorGoldFriendshipMod = 20, MinorFriendshipDecayMod = 20
WHERE Type = 'POLICY_DECISIONS_OCELOT_GESTURE';