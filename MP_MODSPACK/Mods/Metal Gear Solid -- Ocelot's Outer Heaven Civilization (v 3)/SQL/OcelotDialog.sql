INSERT INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_OCELOT'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_OCELOT_'),	1
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC';

INSERT INTO Diplomacy_Responses		
			(LeaderType, 		ResponseType, 					Response, 													Bias)
VALUES		('LEADER_OCELOT', 	'RESPONSE_DEFEATED', 			'TXT_KEY_LEADER_OCELOT_DEFEATED%', 							1),	
			('LEADER_OCELOT', 	'RESPONSE_FIRST_GREETING', 		'TXT_KEY_LEADER_OCELOT_FIRSTGREETING%', 					1);