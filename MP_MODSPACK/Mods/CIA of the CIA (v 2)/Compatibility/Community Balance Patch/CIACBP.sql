CREATE TABLE IF NOT EXISTS COMMUNITY(Type, Value);

UPDATE Buildings
SET NationalPopRequired = (SELECT NationalPopRequired FROM Buildings WHERE Type = 'BUILDING_INTELLIGENCE_AGENCY')
WHERE Type = 'BUILDING_VV_CIA_AGENT_SEA' AND EXISTS (SELECT * FROM COMMUNITY WHERE Type='COMMUNITY_CORE_BALANCE_NATIONAL_WONDERS' AND Value= 1 );