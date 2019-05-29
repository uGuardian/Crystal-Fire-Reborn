INSERT INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_BIGBOSS'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_BIGBOSS_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC';

INSERT INTO Diplomacy_Responses		
			(LeaderType, 		ResponseType, 					Response, 													Bias)
VALUES		('LEADER_BIGBOSS', 	'RESPONSE_DEFEATED', 			'TXT_KEY_LEADER_BIGBOSS_DEFEATED%', 						100),	
			('LEADER_BIGBOSS', 	'RESPONSE_FIRST_GREETING', 		'TXT_KEY_LEADER_BIGBOSS_FIRSTGREETING%', 					100);


INSERT INTO Diplomacy_Responses
			(LeaderType,			ResponseType,	Response,											Bias)
SELECT 		('LEADER_VENOM_SNAKE'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_BIGBOSS_'),	1
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC';

INSERT INTO Diplomacy_Responses		
			(LeaderType, 		ResponseType, 					Response, 													Bias)
VALUES		('LEADER_VENOM_SNAKE', 	'RESPONSE_DEFEATED', 			'TXT_KEY_LEADER_BIGBOSS_DEFEATED%', 					100),	
			('LEADER_VENOM_SNAKE', 	'RESPONSE_FIRST_GREETING', 		'TXT_KEY_LEADER_BIGBOSS_FIRSTGREETING%', 				100);


INSERT INTO Diplomacy_Responses
			(LeaderType,			ResponseType,	Response,											Bias)
SELECT 		('LEADER_BIGBOSS_OH'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_BIGBOSS_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC';

INSERT INTO Diplomacy_Responses		
			(LeaderType, 		ResponseType, 					Response, 													Bias)
VALUES		('LEADER_BIGBOSS_OH', 	'RESPONSE_DEFEATED', 			'TXT_KEY_LEADER_BIGBOSS_DEFEATED%', 					100),	
			('LEADER_BIGBOSS_OH', 	'RESPONSE_FIRST_GREETING', 		'TXT_KEY_LEADER_BIGBOSS_FIRSTGREETING%', 				100);