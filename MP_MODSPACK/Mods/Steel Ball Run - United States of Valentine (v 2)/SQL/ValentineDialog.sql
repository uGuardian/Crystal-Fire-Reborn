INSERT INTO Diplomacy_Responses
			(LeaderType,				ResponseType,	Response,													Bias)
SELECT 		('LEADER_FUNNY_VALENTINE'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_FUNNY_VALENTINE_'),	100


FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC';

INSERT INTO Diplomacy_Responses		
			(LeaderType, 				ResponseType, 				Response, 										Bias)
VALUES		('LEADER_FUNNY_VALENTINE', 	'RESPONSE_DEFEATED', 		'TXT_KEY_LEADER_FUNNY_VALENTINE_DEFEATED%', 	100),	
			('LEADER_FUNNY_VALENTINE', 	'RESPONSE_FIRST_GREETING', 	'TXT_KEY_LEADER_FUNNY_VALENTINE_FIRSTGREETING%',100);