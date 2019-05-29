INSERT INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_VV_BLANC'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_VV_BLANC_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response LIKE ('%GENERIC%');

INSERT OR IGNORE INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_VV_BLANC'),	ResponseType,	REPLACE(Response, 'TXT_KEY_', 'TXT_KEY_LEADER_VV_BLANC_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response NOT LIKE ('%LEADER_VV_BLANC%');


INSERT OR IGNORE INTO Diplomacy_Responses		
			(LeaderType, 		ResponseType, 				Response, 								Bias)
VALUES		('LEADER_VV_BLANC', 	'RESPONSE_DEFEATED', 		'TXT_KEY_LEADER_VV_BLANC_DEFEATED%', 	100),	
			('LEADER_VV_BLANC', 	'RESPONSE_FIRST_GREETING', 	'TXT_KEY_LEADER_VV_BLANC_FIRSTGREETING%',100);

------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO Diplomacy_Responses
			(LeaderType,				ResponseType,	Response,													Bias)
SELECT 		('LEADER_VV_WHITE_HEART'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_VV_WHITE_HEART_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response LIKE ('%GENERIC%');

INSERT OR IGNORE INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_VV_WHITE_HEART'),	ResponseType,	REPLACE(Response, 'TXT_KEY_', 'TXT_KEY_LEADER_VV_WHITE_HEART_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response NOT LIKE ('%LEADER_VV_WHITE_HEART%');



INSERT OR IGNORE INTO Diplomacy_Responses		
			(LeaderType, 				ResponseType, 				Response, 										Bias)
VALUES		('LEADER_VV_WHITE_HEART', 	'RESPONSE_DEFEATED', 		'TXT_KEY_LEADER_VV_WHITE_HEART_DEFEATED%',		100),	
			('LEADER_VV_WHITE_HEART', 	'RESPONSE_FIRST_GREETING', 	'TXT_KEY_LEADER_VV_WHITE_HEART_FIRSTGREETING%',	100);

------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_VV_BLANC_ULTRA'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_VV_BLANC_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response LIKE ('%GENERIC%');

INSERT OR IGNORE INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_VV_BLANC_ULTRA'),	ResponseType,	REPLACE(Response, 'TXT_KEY_', 'TXT_KEY_LEADER_VV_BLANC_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response NOT LIKE ('%LEADER_VV_BLANC%');


INSERT OR IGNORE INTO Diplomacy_Responses		
			(LeaderType, 		ResponseType, 				Response, 								Bias)
VALUES		('LEADER_VV_BLANC_ULTRA', 	'RESPONSE_DEFEATED', 		'TXT_KEY_LEADER_VV_BLANC_DEFEATED%', 	100),	
			('LEADER_VV_BLANC_ULTRA', 	'RESPONSE_FIRST_GREETING', 	'TXT_KEY_LEADER_VV_BLANC_FIRSTGREETING%',100);

------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO Diplomacy_Responses
			(LeaderType,				ResponseType,	Response,													Bias)
SELECT 		('LEADER_VV_WHITE_HEART_ULTRA'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_VV_WHITE_HEART_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response LIKE ('%GENERIC%');

INSERT OR IGNORE INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_VV_WHITE_HEART_ULTRA'),	ResponseType,	REPLACE(Response, 'TXT_KEY_', 'TXT_KEY_LEADER_VV_WHITE_HEART_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response NOT LIKE ('%LEADER_VV_WHITE_HEART%');



INSERT OR IGNORE INTO Diplomacy_Responses		
			(LeaderType, 				ResponseType, 				Response, 										Bias)
VALUES		('LEADER_VV_WHITE_HEART_ULTRA', 	'RESPONSE_DEFEATED', 		'TXT_KEY_LEADER_VV_WHITE_HEART_DEFEATED%',		100),	
			('LEADER_VV_WHITE_HEART_ULTRA', 	'RESPONSE_FIRST_GREETING', 	'TXT_KEY_LEADER_VV_WHITE_HEART_FIRSTGREETING%',	100);