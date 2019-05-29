INSERT INTO ArtDefine_Landmarks(Era, State, Scale, ImprovementType, LayoutHandler, ResourceType, Model, TerrainContour)
SELECT 'Any', 'UnderConstruction', 0.8,  'ART_DEF_IMPROVEMENT_RUNE_HENGE_FSN', 'SNAPSHOT', 'ART_DEF_RESOURCE_ALL', 'RuneHenge_HB.fxsxml', 1 UNION ALL
SELECT 'Any', 'Constructed', 0.8,  'ART_DEF_IMPROVEMENT_RUNE_HENGE_FSN', 'SNAPSHOT', 'ART_DEF_RESOURCE_ALL', 'RuneHenge_B.fxsxml', 1 UNION ALL
SELECT 'Any', 'Pillaged', 0.6,  'ART_DEF_IMPROVEMENT_RUNE_HENGE_FSN', 'SNAPSHOT', 'ART_DEF_RESOURCE_ALL', 'RuneHenge_PL.fxsxml', 1;


INSERT INTO ArtDefine_StrategicView(StrategicViewType, TileType, Asset)
SELECT 'ART_DEF_IMPROVEMENT_RUNE_HENGE_FSN', 'Improvement', 'SV_RuneHenge.dds';


INSERT INTO Improvements
			(Type,									Description,								Civilopedia,
			Help,											ArtDefineTag,								PortraitIndex,	IconAtlas,
			PillageGold,	RequiresFlatlands,	RequiresFlatlandsOrFreshWater,	SpecificCivRequired,	CivilizationType)
VALUES		('IMPROVEMENT_RUNE_HENGE_FSN',	'TXT_KEY_IMPROVEMENT_RUNE_HENGE_FSN',	'TXT_KEY_IMPROVEMENT_RUNE_HENGE_FSN_PEDIA',
			'TXT_KEY_IMPROVEMENT_RUNE_HENGE_FSN_HELP','ART_DEF_IMPROVEMENT_RUNE_HENGE_FSN', 3,				'CIV_COLOR_ATLAS_LANCER_FSN',
			12,				1,					1,								1,						'CIVILIZATION_IRELAND_FSN');


INSERT INTO Improvement_Yields
			(ImprovementType,				YieldType,			Yield)
VALUES		('IMPROVEMENT_RUNE_HENGE_FSN',	'YIELD_FAITH',		1),
			('IMPROVEMENT_RUNE_HENGE_FSN',	'YIELD_CULTURE',	1),
			('IMPROVEMENT_RUNE_HENGE_FSN',	'YIELD_PRODUCTION',-1);
			
INSERT INTO Improvement_TechYieldCHanges
			(ImprovementType,				TechType,			YieldType,			Yield)
VALUES		('IMPROVEMENT_RUNE_HENGE_FSN',	'TECH_ARCHAEOLOGY',	'YIELD_CULTURE',	2),
			('IMPROVEMENT_RUNE_HENGE_FSN',	'TECH_ARCHAEOLOGY',	'YIELD_GOLD',		1);
			
INSERT INTO Improvement_ResourceTypes
			(ImprovementType,				ResourceType)
SELECT		('IMPROVEMENT_RUNE_HENGE_FSN'),	ResourceType
FROM Improvement_ResourceTypes 	WHERE ImprovementType = 'IMPROVEMENT_QUARRY';

CREATE TRIGGER RuneHengeNewResources
AFTER INSERT ON Improvement_ResourceTypes
WHEN NEW.ImprovementType = 'IMPROVEMENT_QUARRY'
BEGIN
	INSERT INTO Improvement_ResourceTypes
				(ImprovementType,				ResourceType)
	VALUES		('IMPROVEMENT_RUNE_HENGE_FSN',	NEW.ResourceType);
END;

INSERT INTO Belief_ImprovementYieldChanges
			(BeliefType,		ImprovementType,				YieldType,		Yield)
SELECT		BeliefType,			('IMPROVEMENT_RUNE_HENGE_FSN'),	YieldType,		Yield
FROM Belief_ImprovementYieldChanges 	WHERE ImprovementType = 'IMPROVEMENT_QUARRY';

CREATE TRIGGER RuneHengeNewBeliefs
AFTER INSERT ON Belief_ImprovementYieldChanges
WHEN NEW.ImprovementType = 'IMPROVEMENT_QUARRY'
BEGIN
	INSERT INTO Belief_ImprovementYieldChanges
				(BeliefType,		ImprovementType,				YieldType,		Yield)
	VALUES		(NEW.BeliefType,	'IMPROVEMENT_RUNE_HENGE_FSN',	NEW.YieldType,	NEW.Yield);
END;


INSERT INTO Builds
			(Type,						PrereqTech,			Time,	ImprovementType,						Description,
			Help,										EntityEvent,HotKey,OrderPriority,IconIndex,
			IconAtlas)
SELECT		('BUILD_RUNE_HENGE_FSN'),	('TECH_CALENDAR'),	Time,	('IMPROVEMENT_RUNE_HENGE_FSN'),	('TXT_KEY_BUILD_RUNE_HENGE_FSN'),
			('TXT_KEY_BUILD_RUNE_HENGE_FSN_HELP'),	EntityEvent,HotKey,OrderPriority,0,
			('LANCER_FSN_BUILD_ATLAS')
FROM Builds WHERE (Type = 'BUILD_QUARRY');

INSERT INTO BuildFeatures
			(BuildType,						FeatureType,PrereqTech,Time,Remove)
SELECT		('BUILD_RUNE_HENGE_FSN'),	FeatureType,PrereqTech,Time,Remove
FROM BuildFeatures WHERE (BuildType = 'BUILD_QUARRY');


INSERT INTO Unit_Builds
			(UnitType,				BuildType)
SELECT		Type,					('BUILD_RUNE_HENGE_FSN')
FROM Units WHERE (Class = 'UNITCLASS_WORKER');

CREATE TRIGGER RuneHengeNewWorkerType
AFTER INSERT ON Units
WHEN NEW.Class = 'UNITCLASS_WORKER'
BEGIN
		INSERT INTO Unit_Builds
					(UnitType,				BuildType)
		SELECT		(NEW.Type,				'BUILD_RUNE_HENGE_FSN');
END;

