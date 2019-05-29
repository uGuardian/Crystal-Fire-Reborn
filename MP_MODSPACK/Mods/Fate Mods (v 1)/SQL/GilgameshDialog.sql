INSERT INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_GILGAMESH_FSN'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_GILGAMESH_FSN_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC';

INSERT INTO Diplomacy_Responses		
			(LeaderType, 		ResponseType, 					Response, 													Bias)
VALUES		('LEADER_GILGAMESH_FSN', 	'RESPONSE_DEFEATED', 			'TXT_KEY_LEADER_GILGAMESH_FSN_DEFEATED%', 							1),	
			('LEADER_GILGAMESH_FSN', 	'RESPONSE_FIRST_GREETING', 		'TXT_KEY_LEADER_GILGAMESH_FSN_FIRSTGREETING%', 					1);