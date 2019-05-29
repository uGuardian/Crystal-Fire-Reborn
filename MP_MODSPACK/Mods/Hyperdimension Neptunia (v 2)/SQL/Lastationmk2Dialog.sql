INSERT INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_VV_UNI'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_VV_UNI_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response LIKE ('%GENERIC%');

INSERT OR IGNORE INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_VV_UNI'),	ResponseType,	REPLACE(Response, 'TXT_KEY_', 'TXT_KEY_LEADER_VV_UNI_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response NOT LIKE ('%LEADER_VV_UNI%') AND Response NOT LIKE ('%GENERIC%');


INSERT OR IGNORE INTO Diplomacy_Responses		
			(LeaderType, 		ResponseType, 				Response, 								Bias)
VALUES		('LEADER_VV_UNI', 	'RESPONSE_DEFEATED', 		'TXT_KEY_LEADER_VV_UNI_DEFEATED%', 	100),	
			('LEADER_VV_UNI', 	'RESPONSE_FIRST_GREETING', 	'TXT_KEY_LEADER_VV_UNI_FIRSTGREETING%',100);



INSERT INTO Diplomacy_Responses
			(LeaderType,				ResponseType,	Response,													Bias)
SELECT 		('LEADER_VV_BLACK_SISTER'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_VV_BLACK_SISTER_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response LIKE ('%GENERIC%');

INSERT OR IGNORE INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_VV_BLACK_SISTER'),	ResponseType,	REPLACE(Response, 'TXT_KEY_', 'TXT_KEY_LEADER_VV_BLACK_SISTER_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response NOT LIKE ('%LEADER_VV_BLACK_SISTER%') AND Response NOT LIKE ('%GENERIC%');



INSERT OR IGNORE INTO Diplomacy_Responses		
			(LeaderType, 				ResponseType, 				Response, 											Bias)
VALUES		('LEADER_VV_BLACK_SISTER', 	'RESPONSE_DEFEATED', 		'TXT_KEY_LEADER_VV_BLACK_SISTER_DEFEATED%',			100),	
			('LEADER_VV_BLACK_SISTER', 	'RESPONSE_FIRST_GREETING', 	'TXT_KEY_LEADER_VV_BLACK_SISTER_FIRSTGREETING%',	100);