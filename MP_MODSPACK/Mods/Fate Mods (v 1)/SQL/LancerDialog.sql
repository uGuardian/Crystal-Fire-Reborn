INSERT INTO Diplomacy_Responses
			(LeaderType,			ResponseType,	Response,											Bias)
SELECT 		('LEADER_LANCER_FSN'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_LANCER_FSN_'),	1
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC';

INSERT INTO Diplomacy_Responses		
			(LeaderType, 			ResponseType, 					Response, 													Bias)
VALUES		('LEADER_LANCER_FSN', 	'RESPONSE_DEFEATED', 			'TXT_KEY_LEADER_LANCER_FSN_DEFEATED%', 						1),	
			('LEADER_LANCER_FSN', 	'RESPONSE_FIRST_GREETING', 		'TXT_KEY_LEADER_LANCER_FSN_FIRSTGREETING%', 				1);