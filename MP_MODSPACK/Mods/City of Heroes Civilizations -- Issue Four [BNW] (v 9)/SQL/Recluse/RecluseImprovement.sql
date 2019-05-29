INSERT INTO Improvements
			(Type,									Description,								Civilopedia,
			Help,											ArtDefineTag,								PortraitIndex,	IconAtlas,
			PillageGold,	CultureBombRadius,	DefenseModifier,	InAdjacentFriendly, SpecificCivRequired,	CivilizationType)
VALUES		('IMPROVEMENT_ARACHNOS_BASE',	'TXT_KEY_IMPROVEMENT_ARACHNOS_BASE',	'TXT_KEY_IMPROVEMENT_ARACHNOS_BASE_PEDIA',
			'TXT_KEY_IMPROVEMENT_ARACHNOS_BASE_HELP','ART_DEF_IMPROVEMENT_ARACHNOS_BASE', 3,				'CIV_COLOR_ATLAS_ARACHNOS',
			50,				1,					50,					1,					1,						'CIVILIZATION_ARACHNOS');


INSERT INTO Improvement_Yields
			(ImprovementType,				YieldType,				Yield)
VALUES		('IMPROVEMENT_ARACHNOS_BASE',	'YIELD_SCIENCE',		2),
			('IMPROVEMENT_ARACHNOS_BASE',	'YIELD_PRODUCTION',		1);


INSERT INTO Improvement_TechYieldChanges
			(ImprovementType,				TechType,			YieldType,			Yield)
VALUES		('IMPROVEMENT_ARACHNOS_BASE',	'TECH_ECOLOGY',		'YIELD_SCIENCE',	1),
			('IMPROVEMENT_ARACHNOS_BASE',	'TECH_ECOLOGY',		'YIELD_PRODUCTION',	2);

INSERT INTO Improvement_ValidTerrains
			(ImprovementType,						TerrainType)
SELECT		('IMPROVEMENT_ARACHNOS_BASE'),	TerrainType
FROM Improvement_ValidTerrains WHERE (ImprovementType = 'IMPROVEMENT_FORT');

INSERT INTO Improvement_ResourceTypes
			(ImprovementType,					ResourceType)
SELECT		('IMPROVEMENT_ARACHNOS_BASE'),		Type
FROM Resources WHERE (ResourceClassType = 'RESOURCECLASS_MODERN');

CREATE TRIGGER ArachnosBaseNewModernStrats
AFTER INSERT ON Resources
WHEN ResourceClassType = 'RESOURCECLASS_MODERN'
BEGIN
	INSERT INTO Improvement_ResourceTypes
				(ImprovementType,					ResourceType)
	VALUES		('IMPROVEMENT_ARACHNOS_BASE',		NEW.Type);
END;



INSERT INTO Builds
			(Type,							PrereqTech,			Time,	ImprovementType,						Description,
			Help,											Recommendation,								EntityEvent,HotKey,OrderPriority,IconIndex,
			IconAtlas)
SELECT		('BUILD_ARACHNOS_BASE'),	('TECH_INDUSTRIALIZATION'),	Time,	('IMPROVEMENT_ARACHNOS_BASE'),	('TXT_KEY_BUILD_ARACHNOS_BASE'),
			('TXT_KEY_BUILD_ARACHNOS_BASE_HELP'),	null,	EntityEvent,HotKey,OrderPriority,0,
			('ARACHNOS_BUILD_ATLAS')
FROM Builds WHERE (Type = 'BUILD_CHATEAU');

INSERT INTO BuildFeatures
			(BuildType,					FeatureType,PrereqTech,Time,Remove)
SELECT		('BUILD_ARACHNOS_BASE'),	FeatureType,PrereqTech,Time,Remove
FROM BuildFeatures WHERE (BuildType = 'BUILD_FORT');


INSERT INTO Unit_Builds
			(UnitType,				BuildType)
SELECT		Type,					('BUILD_ARACHNOS_BASE')
FROM Units WHERE (Class = 'UNITCLASS_WORKER');



CREATE TRIGGER ArachnosBaseNewWorkerType
AFTER INSERT ON Units
WHEN NEW.Class = 'UNITCLASS_WORKER'
BEGIN
		INSERT INTO Unit_Builds
					(UnitType,				BuildType)
		SELECT		(NEW.Type,				'BUILD_ARACHNOS_BASE');
END;