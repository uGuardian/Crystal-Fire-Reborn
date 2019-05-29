CREATE TABLE IF NOT EXISTS COMMUNITY(Type, Value);

-- Mushroom Fiefdom should get bonuses from appropriate Ideological Tenets
INSERT INTO Policy_ImprovementYieldChanges
			(PolicyType,				ImprovementType,	YieldType,				Yield)
SELECT		('POLICY_URBANIZATION'),	Type,				('YIELD_FOOD'),			1
FROM Improvements WHERE Type LIKE('IMPROVEMENT_VV_LOWEE_MUSHROOM%') AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_POLICIES' AND Value= 1 );

INSERT INTO Policy_ImprovementYieldChanges
			(PolicyType,				ImprovementType,	YieldType,				Yield)
SELECT		('POLICY_MOBILIZATION'),	Type,				('YIELD_SCIENCE'),		1
FROM Improvements WHERE Type LIKE('IMPROVEMENT_VV_LOWEE_MUSHROOM%') AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_POLICIES' AND Value= 1 );

INSERT INTO Policy_ImprovementYieldChanges
			(PolicyType,				ImprovementType,	YieldType,				Yield)
SELECT		('POLICY_FIVE_YEAR_PLAN'),	Type,				('YIELD_PRODUCTION'),	1
FROM Improvements WHERE Type LIKE('IMPROVEMENT_VV_LOWEE_MUSHROOM%') AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_POLICIES' AND Value= 1 );