INSERT INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_VV_NEPGEAR'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_VV_NEPGEAR_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response LIKE ('%GENERIC%');

INSERT OR IGNORE INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_VV_NEPGEAR'),	ResponseType,	REPLACE(Response, 'TXT_KEY_', 'TXT_KEY_LEADER_VV_NEPGEAR_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response NOT LIKE ('%LEADER_VV_NEPGEAR%') AND Response NOT LIKE ('%GENERIC%');


INSERT OR IGNORE INTO Diplomacy_Responses		
			(LeaderType, 		ResponseType, 				Response, 								Bias)
VALUES		('LEADER_VV_NEPGEAR', 	'RESPONSE_DEFEATED', 		'TXT_KEY_LEADER_VV_NEPGEAR_DEFEATED%', 	100),	
			('LEADER_VV_NEPGEAR', 	'RESPONSE_FIRST_GREETING', 	'TXT_KEY_LEADER_VV_NEPGEAR_FIRSTGREETING%',100);



INSERT INTO Diplomacy_Responses
			(LeaderType,				ResponseType,	Response,													Bias)
SELECT 		('LEADER_VV_PURPLE_SISTER'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_VV_NEPGEAR_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response LIKE ('%GENERIC%');

INSERT OR IGNORE INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_VV_PURPLE_SISTER'),	ResponseType,	REPLACE(Response, 'TXT_KEY_', 'TXT_KEY_LEADER_VV_NEPGEAR_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response NOT LIKE ('%LEADER_VV_PURPLE_SISTER%') AND Response NOT LIKE ('%GENERIC%');



INSERT OR IGNORE INTO Diplomacy_Responses		
			(LeaderType, 				ResponseType, 				Response, 										Bias)
VALUES		('LEADER_VV_PURPLE_SISTER', 	'RESPONSE_DEFEATED', 		'TXT_KEY_LEADER_VV_NEPGEAR_DEFEATED%',		100),	
			('LEADER_VV_PURPLE_SISTER', 	'RESPONSE_FIRST_GREETING', 	'TXT_KEY_LEADER_VV_NEPGEAR_FIRSTGREETING%',	100);