INSERT INTO Diplomacy_Responses
			(LeaderType,			ResponseType,	Response,											Bias)
SELECT 		('LEADER_RIDER_FSN'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_RIDER_FSN_'),	1
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC';

INSERT INTO Diplomacy_Responses		
			(LeaderType, 			ResponseType, 					Response, 													Bias)
VALUES		('LEADER_RIDER_FSN', 	'RESPONSE_DEFEATED', 			'TXT_KEY_LEADER_RIDER_FSN_DEFEATED%', 						1),	
			('LEADER_RIDER_FSN', 	'RESPONSE_FIRST_GREETING', 		'TXT_KEY_LEADER_RIDER_FSN_FIRSTGREETING%', 					1);