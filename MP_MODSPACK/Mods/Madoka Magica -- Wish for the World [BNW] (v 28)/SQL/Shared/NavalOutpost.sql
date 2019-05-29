UPDATE Units
SET WorkRate = 1, CanRepairFleet = 1, CanChangePort = 1
WHERE Class = 'UNITCLASS_GREAT_ADMIRAL';


CREATE TRIGGER NewAdmiralsSetWorkRate
AFTER INSERT ON Units
WHEN NEW.Class = 'UNITCLASS_GREAT_ADMIRAL'
BEGIN
	UPDATE Units
	SET WorkRate = 1, CanRepairFleet = 1, CanChangePort = 1
	WHERE Type = NEW.Type;
END;

INSERT INTO Improvements
			(Type,								Description,								Civilopedia,	
			ArtDefineTag,	BuildableOnResources,	DefenseModifier,	CultureBombRadius,	CreatedByGreatPerson,	NearbyEnemyDamage,	PortraitIndex,	IconAtlas,
			OutsideBorders, Water,	DestroyedWhenPillaged)
SELECT		('IMPROVEMENT_PMMM_NAVAL_OUTPOST'),	('TXT_KEY_IMPROVEMENT_PMMM_NAVAL_OUTPOST'),	('TXT_KEY_IMPROVEMENT_PMMM_NAVAL_OUTPOST_HELP'),	
			ArtDefineTag,	BuildableOnResources,	DefenseModifier,	CultureBombRadius,	CreatedByGreatPerson,	NearbyEnemyDamage,	PortraitIndex,	IconAtlas,
			1,				1,		1
FROM Improvements WHERE Type = 'IMPROVEMENT_CITADEL';


INSERT INTO Builds
			(Type,										ImprovementType,					Description,							Help,	
			Recommendation,	Kill,	EntityEvent,	HotKey,	OrderPriority,	CtrlDown,	IconIndex,	IconAtlas,
			Water)
SELECT		('BUILD_IMPROVEMENT_PMMM_NAVAL_OUTPOST'),	('IMPROVEMENT_PMMM_NAVAL_OUTPOST'),	('TXT_KEY_BUILD_PMMM_NAVAL_OUTPOST'),	('TXT_KEY_BUILD_PMMM_NAVAL_OUTPOST_HELP'),
			Recommendation,	Kill,	EntityEvent,	HotKey,	OrderPriority,	CtrlDown,	IconIndex,	IconAtlas,
			1
FROM Builds WHERE Type = 'BUILD_CITADEL';


INSERT INTO Improvement_ResourceTypes
			(ImprovementType,					ResourceType)
VALUES		('IMPROVEMENT_PMMM_NAVAL_OUTPOST',	'RESOURCE_OIL');

INSERT INTO Improvement_ValidTerrains
			(ImprovementType,					TerrainType)
VALUES		('IMPROVEMENT_PMMM_NAVAL_OUTPOST',	'TERRAIN_COAST');



INSERT INTO Unit_Builds
			(UnitType,				BuildType)
VALUES		('UNIT_GREAT_ADMIRAL',	'BUILD_IMPROVEMENT_PMMM_NAVAL_OUTPOST');


CREATE TRIGGER NewAdmiralsBuildNavalOutpost
AFTER INSERT ON Units
WHEN NEW.Class = 'UNITCLASS_GREAT_ADMIRAL'
BEGIN
	INSERT OR IGNORE INTO Unit_Builds
				(UnitType,	BuildType)
	VALUES		(NEW.Type,	'BUILD_IMPROVEMENT_PMMM_NAVAL_OUTPOST');
END;