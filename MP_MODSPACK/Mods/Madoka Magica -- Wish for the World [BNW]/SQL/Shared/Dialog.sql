INSERT INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_MADOKA'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_MADOKA_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response LIKE ('%GENERIC%');

INSERT OR IGNORE INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_MADOKA'),	ResponseType,	REPLACE(Response, 'TXT_KEY_', 'TXT_KEY_LEADER_MADOKA_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response NOT LIKE ('%LEADER_MADOKA%');


INSERT OR IGNORE INTO Diplomacy_Responses		
			(LeaderType, 		ResponseType, 				Response, 								Bias)
VALUES		('LEADER_MADOKA', 	'RESPONSE_DEFEATED', 		'TXT_KEY_LEADER_MADOKA_DEFEATED%', 	100),	
			('LEADER_MADOKA', 	'RESPONSE_FIRST_GREETING', 	'TXT_KEY_LEADER_MADOKA_FIRSTGREETING%',100);

INSERT INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_HOMURA'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_HOMURA_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response LIKE ('%GENERIC%');

INSERT OR IGNORE INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_HOMURA'),	ResponseType,	REPLACE(Response, 'TXT_KEY_', 'TXT_KEY_LEADER_HOMURA_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response NOT LIKE ('%LEADER_HOMURA%');


INSERT OR IGNORE INTO Diplomacy_Responses		
			(LeaderType, 		ResponseType, 				Response, 								Bias)
VALUES		('LEADER_HOMURA', 	'RESPONSE_DEFEATED', 		'TXT_KEY_LEADER_HOMURA_DEFEATED%', 	100),	
			('LEADER_HOMURA', 	'RESPONSE_FIRST_GREETING', 	'TXT_KEY_LEADER_HOMURA_FIRSTGREETING%',100);


INSERT INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_ORIGINAL_MADOKA'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_ORIGINAL_MADOKA_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response LIKE ('%GENERIC%');

INSERT OR IGNORE INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_ORIGINAL_MADOKA'),	ResponseType,	REPLACE(Response, 'TXT_KEY_', 'TXT_KEY_LEADER_ORIGINAL_MADOKA_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response NOT LIKE ('%LEADER_ORIGINAL_MADOKA%');


INSERT OR IGNORE INTO Diplomacy_Responses		
			(LeaderType, 		ResponseType, 				Response, 								Bias)
VALUES		('LEADER_ORIGINAL_MADOKA', 	'RESPONSE_DEFEATED', 		'TXT_KEY_LEADER_ORIGINAL_MADOKA_DEFEATED%', 	100),	
			('LEADER_ORIGINAL_MADOKA', 	'RESPONSE_FIRST_GREETING', 	'TXT_KEY_LEADER_ORIGINAL_MADOKA_FIRSTGREETING%',100);



INSERT INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_SAYAKA'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_SAYAKA_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response LIKE ('%GENERIC%');

INSERT OR IGNORE INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_SAYAKA'),	ResponseType,	REPLACE(Response, 'TXT_KEY_', 'TXT_KEY_LEADER_SAYAKA_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response NOT LIKE ('%LEADER_SAYAKA%');


INSERT OR IGNORE INTO Diplomacy_Responses		
			(LeaderType, 		ResponseType, 				Response, 								Bias)
VALUES		('LEADER_SAYAKA', 	'RESPONSE_DEFEATED', 		'TXT_KEY_LEADER_SAYAKA_DEFEATED%', 	100),	
			('LEADER_SAYAKA', 	'RESPONSE_FIRST_GREETING', 	'TXT_KEY_LEADER_SAYAKA_FIRSTGREETING%',100);

			
INSERT INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_KYOUKO'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_KYOUKO_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response LIKE ('%GENERIC%');

INSERT OR IGNORE INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_KYOUKO'),	ResponseType,	REPLACE(Response, 'TXT_KEY_', 'TXT_KEY_LEADER_KYOUKO_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response NOT LIKE ('%LEADER_KYOUKO%');


INSERT OR IGNORE INTO Diplomacy_Responses		
			(LeaderType, 		ResponseType, 				Response, 								Bias)
VALUES		('LEADER_KYOUKO', 	'RESPONSE_DEFEATED', 		'TXT_KEY_LEADER_KYOUKO_DEFEATED%', 	100),	
			('LEADER_KYOUKO', 	'RESPONSE_FIRST_GREETING', 	'TXT_KEY_LEADER_KYOUKO_FIRSTGREETING%',100);



INSERT INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_MAMI'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_MAMI_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response LIKE ('%GENERIC%');

INSERT OR IGNORE INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_MAMI'),	ResponseType,	REPLACE(Response, 'TXT_KEY_', 'TXT_KEY_LEADER_MAMI_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response NOT LIKE ('%LEADER_MAMI%');


INSERT OR IGNORE INTO Diplomacy_Responses		
			(LeaderType, 		ResponseType, 				Response, 								Bias)
VALUES		('LEADER_MAMI', 	'RESPONSE_DEFEATED', 		'TXT_KEY_LEADER_MAMI_DEFEATED%', 	100),	
			('LEADER_MAMI', 	'RESPONSE_FIRST_GREETING', 	'TXT_KEY_LEADER_MAMI_FIRSTGREETING%',100);



INSERT INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_NAGISA'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_NAGISA_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response LIKE ('%GENERIC%');

INSERT OR IGNORE INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_NAGISA'),	ResponseType,	REPLACE(Response, 'TXT_KEY_', 'TXT_KEY_LEADER_NAGISA_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response NOT LIKE ('%LEADER_NAGISA%');


INSERT OR IGNORE INTO Diplomacy_Responses		
			(LeaderType, 		ResponseType, 				Response, 								Bias)
VALUES		('LEADER_NAGISA', 	'RESPONSE_DEFEATED', 		'TXT_KEY_LEADER_NAGISA_DEFEATED%', 	100),	
			('LEADER_NAGISA', 	'RESPONSE_FIRST_GREETING', 	'TXT_KEY_LEADER_NAGISA_FIRSTGREETING%',100);


INSERT INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_DEMON_HOMURA'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_DEMON_HOMURA_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response LIKE ('%GENERIC%');

INSERT OR IGNORE INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_DEMON_HOMURA'),	ResponseType,	REPLACE(Response, 'TXT_KEY_', 'TXT_KEY_LEADER_DEMON_HOMURA_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response NOT LIKE ('%LEADER_DEMON_HOMURA%');


INSERT OR IGNORE INTO Diplomacy_Responses		
			(LeaderType, 		ResponseType, 				Response, 								Bias)
VALUES		('LEADER_DEMON_HOMURA', 	'RESPONSE_DEFEATED', 		'TXT_KEY_LEADER_DEMON_HOMURA_DEFEATED%', 	100),	
			('LEADER_DEMON_HOMURA', 	'RESPONSE_FIRST_GREETING', 	'TXT_KEY_LEADER_DEMON_HOMURA_FIRSTGREETING%',100);



INSERT INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_ORIKO_KIRIKA'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_ORIKO_KIRIKA_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response LIKE ('%GENERIC%');

INSERT OR IGNORE INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_ORIKO_KIRIKA'),	ResponseType,	REPLACE(Response, 'TXT_KEY_', 'TXT_KEY_LEADER_ORIKO_KIRIKA_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response NOT LIKE ('%LEADER_ORIKO_KIRIKA%');


INSERT OR IGNORE INTO Diplomacy_Responses		
			(LeaderType, 		ResponseType, 				Response, 								Bias)
VALUES		('LEADER_ORIKO_KIRIKA', 	'RESPONSE_DEFEATED', 		'TXT_KEY_LEADER_ORIKO_KIRIKA_DEFEATED%', 	100),	
			('LEADER_ORIKO_KIRIKA', 	'RESPONSE_FIRST_GREETING', 	'TXT_KEY_LEADER_ORIKO_KIRIKA_FIRSTGREETING%',100);


INSERT INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_KAORU_UMIKA'),	ResponseType,	REPLACE(Response, '_GENERIC_', '_LEADER_KAORU_UMIKA_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response LIKE ('%GENERIC%');

INSERT OR IGNORE INTO Diplomacy_Responses
			(LeaderType,		ResponseType,	Response,											Bias)
SELECT 		('LEADER_KAORU_UMIKA'),	ResponseType,	REPLACE(Response, 'TXT_KEY_', 'TXT_KEY_LEADER_KAORU_UMIKA_'),	100
FROM Diplomacy_Responses WHERE LeaderType = 'GENERIC' AND Response NOT LIKE ('%LEADER_KAORU_UMIKA%');


INSERT OR IGNORE INTO Diplomacy_Responses		
			(LeaderType, 		ResponseType, 				Response, 								Bias)
VALUES		('LEADER_KAORU_UMIKA', 	'RESPONSE_DEFEATED', 		'TXT_KEY_LEADER_KAORU_UMIKA_DEFEATED%', 	100),	
			('LEADER_KAORU_UMIKA', 	'RESPONSE_FIRST_GREETING', 	'TXT_KEY_LEADER_KAORU_UMIKA_FIRSTGREETING%',100);