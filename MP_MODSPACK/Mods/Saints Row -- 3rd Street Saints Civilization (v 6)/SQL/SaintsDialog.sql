INSERT INTO Diplomacy_Responses
			(LeaderType,					ResponseType,	Response,														Bias)
SELECT 		('LEADER_PIERCE_WASHINGTON'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_PIERCE_WASHINGTON_'),	1
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC';

INSERT INTO Diplomacy_Responses		
			(LeaderType, 					ResponseType, 											Response, 																Bias)
VALUES		('LEADER_PIERCE_WASHINGTON', 	'RESPONSE_DEFEATED', 									'TXT_KEY_LEADER_PIERCE_WASHINGTON_DEFEATED%', 							1),	
			('LEADER_PIERCE_WASHINGTON', 	'RESPONSE_FIRST_GREETING', 								'TXT_KEY_LEADER_PIERCE_WASHINGTON_FIRSTGREETING%', 						1);