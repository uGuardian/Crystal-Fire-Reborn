INSERT INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_VV_VERT'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_VV_VERT_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response LIKE ('%GENERIC%');

INSERT OR IGNORE INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_VV_VERT'),	ResponseType,	REPLACE(Response, 'TXT_KEY_', 'TXT_KEY_LEADER_VV_VERT_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response NOT LIKE ('%LEADER_VV_VERT%');


INSERT OR IGNORE INTO Diplomacy_Responses		
			(LeaderType, 		ResponseType, 				Response, 								Bias)
VALUES		('LEADER_VV_VERT', 	'RESPONSE_DEFEATED', 		'TXT_KEY_LEADER_VV_VERT_DEFEATED%', 	100),	
			('LEADER_VV_VERT', 	'RESPONSE_FIRST_GREETING', 	'TXT_KEY_LEADER_VV_VERT_FIRSTGREETING%',100);



INSERT INTO Diplomacy_Responses
			(LeaderType,				ResponseType,	Response,													Bias)
SELECT 		('LEADER_VV_GREEN_HEART'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_VV_GREEN_HEART_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response LIKE ('%GENERIC%');

INSERT OR IGNORE INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_VV_GREEN_HEART'),	ResponseType,	REPLACE(Response, 'TXT_KEY_', 'TXT_KEY_LEADER_VV_GREEN_HEART_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response NOT LIKE ('%LEADER_VV_GREEN_HEART%');



INSERT OR IGNORE INTO Diplomacy_Responses		
			(LeaderType, 				ResponseType, 				Response, 										Bias)
VALUES		('LEADER_VV_GREEN_HEART', 	'RESPONSE_DEFEATED', 		'TXT_KEY_LEADER_VV_GREEN_HEART_DEFEATED%',		100),	
			('LEADER_VV_GREEN_HEART', 	'RESPONSE_FIRST_GREETING', 	'TXT_KEY_LEADER_VV_GREEN_HEART_FIRSTGREETING%',	100);





INSERT INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_VV_VERT_ULTRA'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_VV_VERT_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response LIKE ('%GENERIC%');

INSERT OR IGNORE INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_VV_VERT_ULTRA'),	ResponseType,	REPLACE(Response, 'TXT_KEY_', 'TXT_KEY_LEADER_VV_VERT_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response NOT LIKE ('%LEADER_VV_VERT%');


INSERT OR IGNORE INTO Diplomacy_Responses		
			(LeaderType, 		ResponseType, 				Response, 								Bias)
VALUES		('LEADER_VV_VERT_ULTRA', 	'RESPONSE_DEFEATED', 		'TXT_KEY_LEADER_VV_VERT_DEFEATED%', 	100),	
			('LEADER_VV_VERT_ULTRA', 	'RESPONSE_FIRST_GREETING', 	'TXT_KEY_LEADER_VV_VERT_FIRSTGREETING%',100);



INSERT INTO Diplomacy_Responses
			(LeaderType,				ResponseType,	Response,													Bias)
SELECT 		('LEADER_VV_GREEN_HEART_ULTRA'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_VV_GREEN_HEART_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response LIKE ('%GENERIC%');

INSERT OR IGNORE INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_VV_GREEN_HEART_ULTRA'),	ResponseType,	REPLACE(Response, 'TXT_KEY_', 'TXT_KEY_LEADER_VV_GREEN_HEART_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response NOT LIKE ('%LEADER_VV_GREEN_HEART%');



INSERT OR IGNORE INTO Diplomacy_Responses		
			(LeaderType, 				ResponseType, 				Response, 										Bias)
VALUES		('LEADER_VV_GREEN_HEART_ULTRA', 	'RESPONSE_DEFEATED', 		'TXT_KEY_LEADER_VV_GREEN_HEART_DEFEATED%',		100),	
			('LEADER_VV_GREEN_HEART_ULTRA', 	'RESPONSE_FIRST_GREETING', 	'TXT_KEY_LEADER_VV_GREEN_HEART_FIRSTGREETING%',	100);