INSERT INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_VV_NEPTUNE'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_VV_NEPTUNE_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response LIKE ('%GENERIC%');

INSERT OR IGNORE INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_VV_NEPTUNE'),	ResponseType,	REPLACE(Response, 'TXT_KEY_', 'TXT_KEY_LEADER_VV_NEPTUNE_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response NOT LIKE ('%LEADER_VV_NEPTUNE%') AND Response NOT LIKE ('%GENERIC%');


INSERT OR IGNORE INTO Diplomacy_Responses		
			(LeaderType, 		ResponseType, 				Response, 								Bias)
VALUES		('LEADER_VV_NEPTUNE', 	'RESPONSE_DEFEATED', 		'TXT_KEY_LEADER_VV_NEPTUNE_DEFEATED%', 	100),	
			('LEADER_VV_NEPTUNE', 	'RESPONSE_FIRST_GREETING', 	'TXT_KEY_LEADER_VV_NEPTUNE_FIRSTGREETING%',100);



INSERT INTO Diplomacy_Responses
			(LeaderType,				ResponseType,	Response,													Bias)
SELECT 		('LEADER_VV_PURPLE_HEART'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_VV_PURPLE_HEART_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response LIKE ('%GENERIC%');

INSERT OR IGNORE INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_VV_PURPLE_HEART'),	ResponseType,	REPLACE(Response, 'TXT_KEY_', 'TXT_KEY_LEADER_VV_PURPLE_HEART_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response NOT LIKE ('%LEADER_VV_PURPLE_HEART%') AND Response NOT LIKE ('%GENERIC%');



INSERT OR IGNORE INTO Diplomacy_Responses		
			(LeaderType, 				ResponseType, 				Response, 										Bias)
VALUES		('LEADER_VV_PURPLE_HEART', 	'RESPONSE_DEFEATED', 		'TXT_KEY_LEADER_VV_PURPLE_HEART_DEFEATED%',		100),	
			('LEADER_VV_PURPLE_HEART', 	'RESPONSE_FIRST_GREETING', 	'TXT_KEY_LEADER_VV_PURPLE_HEART_FIRSTGREETING%',	100);