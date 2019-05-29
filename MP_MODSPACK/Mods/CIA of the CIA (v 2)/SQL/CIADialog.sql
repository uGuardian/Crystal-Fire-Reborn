INSERT INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_VV_BILL_WILSON'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_VV_BILL_WILSON_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response LIKE ('%GENERIC%');

INSERT OR IGNORE INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_VV_BILL_WILSON'),	ResponseType,	REPLACE(Response, 'TXT_KEY_', 'TXT_KEY_LEADER_VV_BILL_WILSON_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response NOT LIKE ('%LEADER_VV_BILL_WILSON%');


INSERT OR IGNORE INTO Diplomacy_Responses		
			(LeaderType, 		ResponseType, 				Response, 								Bias)
VALUES		('LEADER_VV_BILL_WILSON', 	'RESPONSE_DEFEATED', 		'TXT_KEY_LEADER_VV_BILL_WILSON_DEFEATED%', 	100),	
			('LEADER_VV_BILL_WILSON', 	'RESPONSE_FIRST_GREETING', 	'TXT_KEY_LEADER_VV_BILL_WILSON_FIRSTGREETING%',100);