INSERT INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_SABER'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_SABER_'),	1
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC';

INSERT INTO Diplomacy_Responses		
			(LeaderType, 		ResponseType, 					Response, 													Bias)
VALUES		('LEADER_SABER', 	'RESPONSE_DEFEATED', 			'TXT_KEY_LEADER_SABER_DEFEATED%', 							1),	
			('LEADER_SABER', 	'RESPONSE_FIRST_GREETING', 		'TXT_KEY_LEADER_SABER_FIRSTGREETING%', 					1);