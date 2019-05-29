INSERT INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_SENATOR_ARMSTRONG'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_SENATOR_ARMSTRONG_'),	1
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC';

INSERT INTO Diplomacy_Responses		
			(LeaderType, 		ResponseType, 					Response, 													Bias)
VALUES		('LEADER_SENATOR_ARMSTRONG', 	'RESPONSE_DEFEATED', 			'TXT_KEY_LEADER_SENATOR_ARMSTRONG_DEFEATED%', 							1),	
			('LEADER_SENATOR_ARMSTRONG', 	'RESPONSE_FIRST_GREETING', 		'TXT_KEY_LEADER_SENATOR_ARMSTRONG_FIRSTGREETING%', 					1);