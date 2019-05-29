INSERT INTO Civilizations_YagemStartPosition
			(Type,										X,		Y,		AltX,	AltY)
VALUES		('CIVILIZATION_PARAGON',					158,	67,		null,	null), --Rhode Island
			('CIVILIZATION_ARACHNOS',					155,	47,		null,	null), --Haiti/Dominican Republic. The Rogue Isles were stated to be off the coast of the eastern USA.
			('CIVILIZATION_PRAETORIA',					163,	35,		null,	null), --Brazil, in an attempt to simulate the location of Praetoria (which was surrounded by jungle and had a river)
			('CIVILIZATION_NEMESIS',					29,		72,		null,	null), --Prussia
			('CIVILIZATION_RIKTI',						76,		33,		null,	null); --Kuala Lumpur, Malaysia...just because I found it amusing that it was one of their main attack targets



INSERT INTO Civilizations_YagemRequestedResource
			(Type, 										Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_PARAGON'),			Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE Type = 'CIVILIZATION_AMERICA';

INSERT INTO Civilizations_YagemRequestedResource
			(Type, 										Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_ARACHNOS'),			Req1, Yield1, Req2, Yield2, Req3, Yield3, ('RESOURCE_FISH'), 2
FROM Civilizations_YagemRequestedResource WHERE Type = 'CIVILIZATION_AZTEC';

INSERT INTO Civilizations_YagemRequestedResource
			(Type, 										Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_PRAETORIA'),			Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE Type = 'CIVILIZATION_BRAZIL';

INSERT INTO Civilizations_YagemRequestedResource
			(Type, 										Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_NEMESIS'),			Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE Type = 'CIVILIZATION_GERMANY';

INSERT INTO Civilizations_YagemRequestedResource
			(Type, 										Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4)
SELECT		('CIVILIZATION_RIKTI'),			Req1, Yield1, Req2, Yield2, Req3, Yield3, Req4, Yield4
FROM Civilizations_YagemRequestedResource WHERE Type = 'CIVILIZATION_INDIA';