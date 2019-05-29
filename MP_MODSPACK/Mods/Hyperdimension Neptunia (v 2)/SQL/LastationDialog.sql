------------------------------------------------------------------------------------------------------------------------
-- Noire
------------------------------------------------------------------------------------------------------------------------
INSERT INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_VV_NOIRE'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_VV_NOIRE_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response LIKE ('%GENERIC%');

INSERT OR IGNORE INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_VV_NOIRE'),	ResponseType,	REPLACE(Response, 'TXT_KEY_', 'TXT_KEY_LEADER_VV_NOIRE_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response NOT LIKE ('%LEADER_VV_NOIRE%');

INSERT INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_VV_NOIRE'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_VV_HDNOIRE_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response LIKE ('%GENERIC%');

INSERT OR IGNORE INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_VV_NOIRE'),	ResponseType,	REPLACE(Response, 'TXT_KEY_', 'TXT_KEY_LEADER_VV_HDNOIRE_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response NOT LIKE ('%LEADER_VV_NOIRE%');


INSERT OR IGNORE INTO Diplomacy_Responses		
			(LeaderType, 			ResponseType, 				Response, 									Bias)
VALUES		('LEADER_VV_NOIRE', 	'RESPONSE_DEFEATED', 		'TXT_KEY_LEADER_VV_HDNOIRE_DEFEATED%', 		100),	
			('LEADER_VV_NOIRE', 	'RESPONSE_FIRST_GREETING', 	'TXT_KEY_LEADER_VV_HDNOIRE_FIRSTGREETING%',	100);

------------------------------------------------------------------------------------------------------------------------
-- Black Heart
------------------------------------------------------------------------------------------------------------------------

INSERT INTO Diplomacy_Responses
			(LeaderType,				ResponseType,	Response,													Bias)
SELECT 		('LEADER_VV_BLACK_HEART'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_VV_BLACK_HEART_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response LIKE ('%GENERIC%');

INSERT OR IGNORE INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_VV_BLACK_HEART'),	ResponseType,	REPLACE(Response, 'TXT_KEY_', 'TXT_KEY_LEADER_VV_BLACK_HEART_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response NOT LIKE ('%LEADER_VV_BLACK_HEART%');

INSERT INTO Diplomacy_Responses
			(LeaderType,				ResponseType,	Response,													Bias)
SELECT 		('LEADER_VV_BLACK_HEART'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_VV_HDBLACK_HEART_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response LIKE ('%GENERIC%');

INSERT OR IGNORE INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_VV_BLACK_HEART'),	ResponseType,	REPLACE(Response, 'TXT_KEY_', 'TXT_KEY_LEADER_VV_HDBLACK_HEART_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response NOT LIKE ('%LEADER_VV_BLACK_HEART%');

INSERT OR IGNORE INTO Diplomacy_Responses		
			(LeaderType, 				ResponseType, 				Response, 											Bias)
VALUES		('LEADER_VV_BLACK_HEART', 	'RESPONSE_DEFEATED', 		'TXT_KEY_LEADER_VV_HDBLACK_HEART_DEFEATED%',		100),	
			('LEADER_VV_BLACK_HEART', 	'RESPONSE_FIRST_GREETING', 	'TXT_KEY_LEADER_VV_HDBLACK_HEART_FIRSTGREETING%',	100);


------------------------------------------------------------------------------------------------------------------------
-- Noire (Ultradimension)
------------------------------------------------------------------------------------------------------------------------


INSERT INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_VV_NOIRE_ULTRA'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_VV_NOIRE_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response LIKE ('%GENERIC%');

INSERT OR IGNORE INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_VV_NOIRE_ULTRA'),	ResponseType,	REPLACE(Response, 'TXT_KEY_', 'TXT_KEY_LEADER_VV_NOIRE_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response NOT LIKE ('%LEADER_VV_NOIRE%');

INSERT INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_VV_NOIRE_ULTRA'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_VV_UDNOIRE_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response LIKE ('%GENERIC%');

INSERT OR IGNORE INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_VV_NOIRE_ULTRA'),	ResponseType,	REPLACE(Response, 'TXT_KEY_', 'TXT_KEY_LEADER_VV_UDNOIRE_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response NOT LIKE ('%LEADER_VV_NOIRE%');


INSERT OR IGNORE INTO Diplomacy_Responses		
			(LeaderType, 		ResponseType, 				Response, 								Bias)
VALUES		('LEADER_VV_NOIRE_ULTRA', 	'RESPONSE_DEFEATED', 		'TXT_KEY_LEADER_VV_UDNOIRE_DEFEATED%', 	100),	
			('LEADER_VV_NOIRE_ULTRA', 	'RESPONSE_FIRST_GREETING', 	'TXT_KEY_LEADER_VV_UDNOIRE_FIRSTGREETING%',100);

------------------------------------------------------------------------------------------------------------------------
-- Black Heart (Ultradimension)
------------------------------------------------------------------------------------------------------------------------

INSERT INTO Diplomacy_Responses
			(LeaderType,				ResponseType,	Response,													Bias)
SELECT 		('LEADER_VV_BLACK_HEART_ULTRA'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_VV_BLACK_HEART_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response LIKE ('%GENERIC%');

INSERT OR IGNORE INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_VV_BLACK_HEART_ULTRA'),	ResponseType,	REPLACE(Response, 'TXT_KEY_', 'TXT_KEY_LEADER_VV_BLACK_HEART_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response NOT LIKE ('%LEADER_VV_BLACK_HEART%');

INSERT INTO Diplomacy_Responses
			(LeaderType,				ResponseType,	Response,													Bias)
SELECT 		('LEADER_VV_BLACK_HEART_ULTRA'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_VV_UDBLACK_HEART_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response LIKE ('%GENERIC%');

INSERT OR IGNORE INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_VV_BLACK_HEART_ULTRA'),	ResponseType,	REPLACE(Response, 'TXT_KEY_', 'TXT_KEY_LEADER_VV_UDBLACK_HEART_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response NOT LIKE ('%LEADER_VV_BLACK_HEART%');

INSERT OR IGNORE INTO Diplomacy_Responses		
			(LeaderType, 				ResponseType, 				Response, 										Bias)
VALUES		('LEADER_VV_BLACK_HEART_ULTRA', 	'RESPONSE_DEFEATED', 		'TXT_KEY_LEADER_VV_UDBLACK_HEART_DEFEATED%',		100),	
			('LEADER_VV_BLACK_HEART_ULTRA', 	'RESPONSE_FIRST_GREETING', 	'TXT_KEY_LEADER_VV_UDBLACK_HEART_FIRSTGREETING%',	100);