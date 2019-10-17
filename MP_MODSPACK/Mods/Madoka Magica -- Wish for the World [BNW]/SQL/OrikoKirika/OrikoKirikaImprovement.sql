INSERT INTO ArtDefine_Landmarks(Era, State, Scale, ImprovementType, LayoutHandler, ResourceType, Model, TerrainContour)
SELECT 'Any', 'UnderConstruction', 0.75,  'ART_DEF_IMPROVEMENT_PMMM_FARSIGHT_ORACLE', 'SNAPSHOT', 'ART_DEF_RESOURCE_NONE', 'PMMM_Oracle_HB.fxsxml', 1 UNION ALL
SELECT 'Any', 'Constructed', 0.75,  'ART_DEF_IMPROVEMENT_PMMM_FARSIGHT_ORACLE', 'SNAPSHOT', 'ART_DEF_RESOURCE_NONE', 'PMMM_Oracle_B.fxsxml', 1 UNION ALL
SELECT 'Any', 'Pillaged', 0.6,  'ART_DEF_IMPROVEMENT_PMMM_FARSIGHT_ORACLE', 'SNAPSHOT', 'ART_DEF_RESOURCE_NONE', 'PMMM_Oracle_PL.fxsxml', 1;



INSERT INTO Improvements
			(Type,									Description,								Civilopedia,
			Help,											ArtDefineTag,								PortraitIndex,	IconAtlas,
			PillageGold,	NoTwoAdjacent,	AdjacentLuxury,	SpecificCivRequired,	CivilizationType)
VALUES		('IMPROVEMENT_PMMM_FARSIGHT_ORACLE',	'TXT_KEY_IMPROVEMENT_PMMM_FARSIGHT_ORACLE',	'TXT_KEY_IMPROVEMENT_PMMM_FARSIGHT_ORACLE_TEXT',
			'TXT_KEY_IMPROVEMENT_PMMM_FARSIGHT_ORACLE_HELP','ART_DEF_IMPROVEMENT_PMMM_FARSIGHT_ORACLE', 3,				'CIV_COLOR_ATLAS_ORIKO_KIRIKA',
			20,				1,				1,				1,						'CIVILIZATION_ORIKO_KIRIKA');


INSERT INTO Improvement_Yields
			(ImprovementType,						YieldType,		Yield)
VALUES		('IMPROVEMENT_PMMM_FARSIGHT_ORACLE',	'YIELD_FAITH',	2),
			('IMPROVEMENT_PMMM_FARSIGHT_ORACLE',	'YIELD_CULTURE',1);


INSERT INTO Improvement_TechYieldChanges
			(ImprovementType,						TechType,			YieldType,		Yield)
VALUES		('IMPROVEMENT_PMMM_FARSIGHT_ORACLE',	'TECH_RADIO',		'YIELD_FAITH',	1),
			('IMPROVEMENT_PMMM_FARSIGHT_ORACLE',	'TECH_RADIO',		'YIELD_CULTURE',2);

INSERT INTO Improvement_ValidTerrains
			(ImprovementType,						TerrainType)
SELECT		('IMPROVEMENT_PMMM_FARSIGHT_ORACLE'),	TerrainType
FROM Improvement_ValidTerrains WHERE (ImprovementType = 'IMPROVEMENT_CHATEAU');




INSERT INTO Builds
			(Type,							PrereqTech,			Time,	ImprovementType,						Description,
			Help,											Recommendation,								EntityEvent,HotKey,OrderPriority,IconIndex,
			IconAtlas)
SELECT		('BUILD_PMMM_FARSIGHT_ORACLE'),	('TECH_THEOLOGY'),	Time,	('IMPROVEMENT_PMMM_FARSIGHT_ORACLE'),	('TXT_KEY_BUILD_PMMM_FARSIGHT_ORACLE'),
			('TXT_KEY_BUILD_PMMM_FARSIGHT_ORACLE_HELP'),	('TXT_KEY_BUILD_PMMM_FARSIGHT_ORACLE_REC'),	EntityEvent,HotKey,OrderPriority,0,
			('BUILD_ATLAS_PMMM_FARSIGHT_ORACLE')
FROM Builds WHERE (Type = 'BUILD_CHATEAU');

INSERT INTO BuildFeatures
			(BuildType,						FeatureType,PrereqTech,Time,Remove)
SELECT		('BUILD_PMMM_FARSIGHT_ORACLE'),	FeatureType,PrereqTech,Time,Remove
FROM BuildFeatures WHERE (BuildType = 'BUILD_CHATEAU');


INSERT INTO Unit_Builds
			(UnitType,				BuildType)
SELECT		Type,					('BUILD_PMMM_FARSIGHT_ORACLE')
FROM Units WHERE (Class = 'UNITCLASS_WORKER');

