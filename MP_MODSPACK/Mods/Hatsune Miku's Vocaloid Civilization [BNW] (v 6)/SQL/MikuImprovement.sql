INSERT INTO ArtDefine_Landmarks(Era, State, Scale, ImprovementType, LayoutHandler, ResourceType, Model, TerrainContour)
SELECT 'Any', 'UnderConstruction', 0.8,  'ART_DEF_IMPROVEMENT_SPRING_ONION_FARM', 'SNAPSHOT', 'ART_DEF_RESOURCE_ALL', 'hb_plantation_ind_flax.fxsxml', 1 UNION ALL
SELECT 'Any', 'Constructed', 0.8,  'ART_DEF_IMPROVEMENT_SPRING_ONION_FARM', 'SNAPSHOT', 'ART_DEF_RESOURCE_ALL', 'plantation_ind_flax.fxsxml', 1 UNION ALL
SELECT 'Any', 'Pillaged', 0.6,  'ART_DEF_IMPROVEMENT_SPRING_ONION_FARM', 'SNAPSHOT', 'ART_DEF_RESOURCE_ALL', 'pl_plantation_ind_flax.fxsxml', 1;


INSERT INTO ArtDefine_StrategicView(StrategicViewType, TileType, Asset)
SELECT 'ART_DEF_IMPROVEMENT_SPRING_ONION_FARM', 'Improvement', 'SV_SOFarm.dds';


INSERT INTO Improvements
			(Type,									Description,								Civilopedia,
			Help,											ArtDefineTag,								PortraitIndex,	IconAtlas,
			PillageGold,	RequiresFlatlands,	RequiresFlatlandsOrFreshWater,	SpecificCivRequired,	CivilizationType)
VALUES		('IMPROVEMENT_SPRING_ONION_FARM',	'TXT_KEY_IMPROVEMENT_SPRING_ONION_FARM',	'TXT_KEY_IMPROVEMENT_SPRING_ONION_FARM_PEDIA',
			'TXT_KEY_IMPROVEMENT_SPRING_ONION_FARM_HELP','ART_DEF_IMPROVEMENT_SPRING_ONION_FARM', 3,				'CIV_COLOR_ATLAS_MIKU',
			15,				1,					1,								1,						'CIVILIZATION_VOCALOID');


INSERT INTO Improvement_Yields
			(ImprovementType,						YieldType,		Yield)
VALUES		('IMPROVEMENT_SPRING_ONION_FARM',	'YIELD_CULTURE',	2);


INSERT INTO Improvement_TechFreshWaterYieldChanges
			(ImprovementType,						TechType,			YieldType,		Yield)
VALUES		('IMPROVEMENT_SPRING_ONION_FARM',	'TECH_CIVIL_SERVICE',	'YIELD_FOOD',	2),
			('IMPROVEMENT_SPRING_ONION_FARM',	'TECH_FERTILIZER',		'YIELD_FOOD',	1);

INSERT INTO Improvement_ValidTerrains
			(ImprovementType,						TerrainType)
VALUES		('IMPROVEMENT_SPRING_ONION_FARM',	'TERRAIN_GRASS');




INSERT INTO Builds
			(Type,							PrereqTech,			Time,	ImprovementType,						Description,
			Help,										EntityEvent,HotKey,OrderPriority,IconIndex,
			IconAtlas)
SELECT		('BUILD_SPRING_ONION_FARM'),	('TECH_CIVIL_SERVICE'),	Time,	('IMPROVEMENT_SPRING_ONION_FARM'),	('TXT_KEY_BUILD_SPRING_ONION_FARM'),
			('TXT_KEY_BUILD_SPRING_ONION_FARM_HELP'),	EntityEvent,HotKey,OrderPriority,0,
			('VOCALOID_BUILD_ATLAS')
FROM Builds WHERE (Type = 'BUILD_CHATEAU');

INSERT INTO BuildFeatures
			(BuildType,						FeatureType,PrereqTech,Time,Remove)
SELECT		('BUILD_SPRING_ONION_FARM'),	FeatureType,PrereqTech,Time,Remove
FROM BuildFeatures WHERE (BuildType = 'BUILD_FARM');


INSERT INTO Unit_Builds
			(UnitType,				BuildType)
SELECT		Type,					('BUILD_SPRING_ONION_FARM')
FROM Units WHERE (Class = 'UNITCLASS_WORKER');

