CREATE TABLE IF NOT EXISTS COMMUNITY(Type, Value);

-- Madoka's Middle School should reduce Illiteracy
UPDATE Buildings
SET IlliteracyHappinessChange = (SELECT IlliteracyHappinessChange FROM Buildings WHERE Type = 'BUILDING_PUBLIC_SCHOOL')
WHERE Type = 'BUILDING_PMMM_MIDDLE_SCHOOL' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

-- Kyouko's Sakura Church should reduce Religious Strife
UPDATE Buildings
SET MinorityHappinessChange = (SELECT MinorityHappinessChange FROM Buildings WHERE Type = 'BUILDING_TEMPLE')
WHERE Type = 'BUILDING_PMMM_SAKURA_CHURCH' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );

--Change Building Help texts.
UPDATE Buildings
SET Help = Help||'_CBP'
WHERE Type LIKE ('BUILDING_PMMM_%') AND EXISTS (SELECT * FROM Civilization_BuildingClassOverrides WHERE Type = BuildingType);


--Madoka's trait grants Trapping instead of Archery ("Military Training" in CBP)
UPDATE Civilization_FreeTechs
SET TechType = 'TECH_TRAPPING'
WHERE CivilizationType = 'CIVILIZATION_ORIGINAL_MADOKA' AND TechType = 'TECH_ARCHERY' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_BUILDINGS' AND Value= 1 );


-- Farsight Oracle should get bonuses from appropriate Ideological Tenets
INSERT INTO Policy_ImprovementYieldChanges
			(PolicyType,			ImprovementType,						YieldType,		Yield)
SELECT		('POLICY_URBANIZATION'),('IMPROVEMENT_PMMM_FARSIGHT_ORACLE'),	('YIELD_FOOD'),	1
WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_POLICIES' AND Value= 1 );

INSERT INTO Policy_ImprovementYieldChanges
			(PolicyType,			ImprovementType,						YieldType,			Yield)
SELECT		('POLICY_MOBILIZATION'),('IMPROVEMENT_PMMM_FARSIGHT_ORACLE'),	('YIELD_SCIENCE'),	1
WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_POLICIES' AND Value= 1 );

INSERT INTO Policy_ImprovementYieldChanges
			(PolicyType,				ImprovementType,						YieldType,				Yield)
SELECT		('POLICY_FIVE_YEAR_PLAN'),	('IMPROVEMENT_PMMM_FARSIGHT_ORACLE'),	('YIELD_PRODUCTION'),	1
WHERE EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_POLICIES' AND Value= 1 );


--None of that Barb gold stealing for Witches
UPDATE COMMUNITY
SET Value = 0
WHERE Type LIKE('COMMUNITY_CORE_BARBARIAN_THEFT');

--WFTW setting overrides CBP setting for Witches healing
UPDATE COMMUNITY
SET Value = (SELECT Value FROM WishForTheWorldOptions WHERE Type = 'CBPWitchHealOverride')
WHERE Type LIKE('BARBARIAN_HEAL');

--Delete the CBP Barbarian promotions
DELETE FROM UnitPromotions
WHERE Type IN ('PROMOTION_MARSH_WALKER', 'PROMOTION_WHITE_WALKER');




--Fix Heathen Conversion
UPDATE Beliefs
SET Description = (CASE WHEN EXISTS(SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_RELIGION' AND Value= 1 )
	THEN 'TXT_KEY_BELIEF_HEATHEN_CONVERSION_PMMM_CBP'
	ELSE 'TXT_KEY_BELIEF_HEATHEN_CONVERSION_PMMM' END)
WHERE Type = 'BELIEF_HEATHEN_CONVERSION';

UPDATE Beliefs
SET	ShortDescription =
	(CASE WHEN EXISTS(SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_RELIGION' AND Value= 1 ) THEN
		'TXT_KEY_BELIEF_HEATHEN_CONVERSION_SHORT_PMMM_CBP'
	ELSE
		'TXT_KEY_BELIEF_HEATHEN_CONVERSION_SHORT_PMMM'
	END)
WHERE Type = 'BELIEF_HEATHEN_CONVERSION';


--CBP Pocatello Encampment should still be "Encampment"
--UPDATE: For some reason this doesn't work, but fixing it will come later (CBP is changing too frequently for me to keep up with)
UPDATE Language_en_US
SET Text = replace(Text, 'Labyrinth', 'Encampment')
WHERE Tag LIKE ('TXT_KEY_BUILD_ENCAMPMENT%');

UPDATE Language_en_US
SET Text = replace(Text, 'labyrinth', 'encampment')
WHERE Tag LIKE ('TXT_KEY_BUILD_ENCAMPMENT%');


--Fix Reliquary
UPDATE Beliefs
SET	ShortDescription =
	(CASE WHEN EXISTS(SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_RELIGION' AND Value= 1 ) THEN
		'TXT_KEY_BELIEF_RELIQUARY_SHORT'
	ELSE
		'TXT_KEY_BELIEF_RELIQUARY_SHORT_PMMM'
	END)
WHERE Type = 'BELIEF_RELIQUARY';


UPDATE Beliefs
SET	ShortDescription =
	(CASE WHEN EXISTS(SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_RELIGION' AND Value= 1 ) THEN
		'TXT_KEY_BELIEF_RELIQUARY_SHORT'
	ELSE
		'TXT_KEY_BELIEF_RELIQUARY_SHORT_PMMM'
	END)
WHERE Type = 'BELIEF_RELIQUARY';


--Update text of WFTW Beliefs
UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_PMMM_YURIJI_CBP'
WHERE Type = 'BELIEF_PMMM_YURIJI' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_RELIGION' AND Value= 1 );

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_PMMM_YOUTH_CAMPS_CBP'
WHERE Type = 'BELIEF_PMMM_YOUTH_CAMPS' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_RELIGION' AND Value= 1 );




--Newer versions of CBP buff specialists, so Entertainers will follow suit.
INSERT INTO Tech_SpecialistYieldChanges
			(TechType,			SpecialistType,					YieldType,			Yield)
VALUES		('TECH_INTERNET',	'SPECIALIST_PMMM_ENTERTAINER',	'YIELD_TOURISM',	2),
			('TECH_GUILDS',		'SPECIALIST_PMMM_ENTERTAINER',	'YIELD_GOLD',		3),
			('TECH_ACOUSTICS',	'SPECIALIST_PMMM_ENTERTAINER',	'YIELD_CULTURE',	3),
			('TECH_RADIO',		'SPECIALIST_PMMM_ENTERTAINER',	'YIELD_CULTURE',	3);

UPDATE Features
SET SpawnLocationUnitFreePromotion = null
WHERE (IsBarbarianOnly = 'true');