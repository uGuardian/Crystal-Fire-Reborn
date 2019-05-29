INSERT INTO DecisionsAddin_Support
			(FileName)
VALUES		('ColeDecisions.lua');

INSERT INTO UnitPromotions
			(Type,											Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_DECISIONS_COLE_SEERS'),					('TXT_KEY_PROMOTION_DECISIONS_COLE_SEERS'),		('TXT_KEY_PROMOTION_DECISIONS_COLE_SEERS_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_DECISIONS_COLE_SEERS')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_STEAM_POWERED');

UPDATE UnitPromotions
SET RangedDefenseMod = 15, VisibilityChange = 1
WHERE Type = 'PROMOTION_DECISIONS_COLE_SEERS';


INSERT INTO UnitPromotions_UnitCombats
			(PromotionType,						UnitCombatType)
VALUES		('PROMOTION_DECISIONS_COLE_SEERS'),	UnitCombatType
FROM Trait_FreePromotionUnitCombats WHERE PromotionType = 'PROMOTION_SENTRY' AND TraitType = 'TRAIT_RIVER_EXPANSION';


INSERT INTO BuildingClasses
			(Type,												DefaultBuilding)
VALUES		('BUILDINGCLASS_DECISIONS_COLE_ENRICHE_CAPITAL',	'BUILDING_DECISIONS_COLE_ENRICHE_CAPITAL'),
			('BUILDINGCLASS_DECISIONS_COLE_ENRICHE_AQUEDUCT',	'BUILDING_DECISIONS_COLE_ENRICHE_AQUEDUCT'),
			('BUILDINGCLASS_DECISIONS_COLE_SEERS',				'BUILDING_DECISIONS_COLE_SEERS');


INSERT INTO Buildings
			(Type,										BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune)
VALUES		('BUILDING_DECISIONS_COLE_ENRICHE_CAPITAL',		'BUILDINGCLASS_DECISIONS_COLE_ENRICHE_CAPITAL',
			-1,		-1,			-1,				null,		1,				1),
			('BUILDING_DECISIONS_COLE_ENRICHE_AQUEDUCT',	'BUILDINGCLASS_DECISIONS_COLE_ENRICHE_AQUEDUCT',
			-1,		-1,			-1,				null,		1,				1),
			('BUILDING_DECISIONS_COLE_SEERS',				'BUILDINGCLASS_DECISIONS_COLE_SEERS',
			-1,		-1,			-1,				null,		1,				1);

UPDATE Buildings
SET PolicyCostModifier = -2
WHERE Type = 'BUILDING_DECISIONS_COLE_ENRICHE_AQUEDUCT';

UPDATE Buildings
SET FreePromotion = 'PROMOTION_DECISIONS_COLE_SEERS'
WHERE Type = 'BUILDING_DECISIONS_COLE_SEERS';

INSERT INTO Building_YieldChanges
			(BuildingType,									YieldType,		Yield)
VALUES		('BUILDING_DECISIONS_COLE_ENRICHE_AQUEDUCT',	'YIELD_GOLD',	-2);

INSERT INTO Building_BuildingClassHappiness
			(BuildingType,								BuildingClassType,			Happiness)
VALUES		('BUILDING_DECISIONS_COLE_ENRICHE_CAPITAL',	'BUILDINGCLASS_AQUEDUCT',	1);

INSERT INTO Building_BuildingClassYieldChanges
			(BuildingType,						BuildingClassType,				YieldType,			YieldChange)
VALUES		('BUILDING_DECISIONS_COLE_SEERS',	'BUILDINGCLASS_CONSTABLE',	'YIELD_SCIENCE',	1);