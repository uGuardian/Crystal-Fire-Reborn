INSERT INTO Diplomacy_Responses
			(LeaderType,	ResponseType,	Response,	Bias)
SELECT 		('LEADER_NANOHA'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_NANOHA_'), 1
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC';

INSERT INTO Diplomacy_Responses 
			(LeaderType, 			ResponseType, 										Response, 															Bias)
VALUES		('LEADER_NANOHA', 	'RESPONSE_DEFEATED', 									'TXT_KEY_LEADER_NANOHA_DEFEATED%', 									1),	
			('LEADER_NANOHA', 	'RESPONSE_FIRST_GREETING', 								'TXT_KEY_LEADER_NANOHA_FIRSTGREETING%', 								1);