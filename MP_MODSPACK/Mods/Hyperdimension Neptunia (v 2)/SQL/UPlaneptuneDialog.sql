INSERT INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_VV_PLUTIA'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_VV_PLUTIA_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response LIKE ('%GENERIC%');

INSERT OR IGNORE INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_VV_PLUTIA'),	ResponseType,	REPLACE(Response, 'TXT_KEY_', 'TXT_KEY_LEADER_VV_PLUTIA_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response NOT LIKE ('%LEADER_VV_PLUTIA%') AND Response NOT LIKE ('%GENERIC%');


INSERT OR IGNORE INTO Diplomacy_Responses		
			(LeaderType, 		ResponseType, 				Response, 								Bias)
VALUES		('LEADER_VV_PLUTIA', 	'RESPONSE_DEFEATED', 		'TXT_KEY_LEADER_VV_PLUTIA_DEFEATED%', 	100),	
			('LEADER_VV_PLUTIA', 	'RESPONSE_FIRST_GREETING', 	'TXT_KEY_LEADER_VV_PLUTIA_FIRSTGREETING%',100);



INSERT INTO Diplomacy_Responses
			(LeaderType,				ResponseType,	Response,													Bias)
SELECT 		('LEADER_VV_IRIS_HEART'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_VV_IRIS_HEART_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response LIKE ('%GENERIC%');

INSERT OR IGNORE INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_VV_IRIS_HEART'),	ResponseType,	REPLACE(Response, 'TXT_KEY_', 'TXT_KEY_LEADER_VV_IRIS_HEART_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response NOT LIKE ('%LEADER_VV_IRIS_HEART%') AND Response NOT LIKE ('%GENERIC%');



INSERT OR IGNORE INTO Diplomacy_Responses		
			(LeaderType, 				ResponseType, 				Response, 										Bias)
VALUES		('LEADER_VV_IRIS_HEART', 	'RESPONSE_DEFEATED', 		'TXT_KEY_LEADER_VV_IRIS_HEART_DEFEATED%',		100),	
			('LEADER_VV_IRIS_HEART', 	'RESPONSE_FIRST_GREETING', 	'TXT_KEY_LEADER_VV_IRIS_HEART_FIRSTGREETING%',	100);