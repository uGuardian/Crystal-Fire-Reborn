INSERT INTO DecisionsAddin_Support
			(FileName)
VALUES		('PMMMSayakaDecisions.lua');

INSERT INTO UnitPromotions	
			(Type,										Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_DECISIONS_SAYAKA'),		('TXT_KEY_PROMOTION_DECISIONS_SAYAKA'),('TXT_KEY_PROMOTION_DECISIONS_SAYAKA_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_DECISIONS_SAYAKA')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');

UPDATE UnitPromotions
SET ExtraAttacks = 1, AttackMod = 15
WHERE Type = 'PROMOTION_DECISIONS_SAYAKA';

INSERT INTO BuildingClasses
			(Type,	DefaultBuilding)
VALUES		('BUILDINGCLASS_DECISION_SAYAKA_DUMMY', 'BUILDING_DECISION_SAYAKA_DUMMY');

INSERT INTO Buildings
			(Type,										BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune,
			LandmarksTourismPercent, GreatWorksTourismModifier)
VALUES		('BUILDING_DECISION_SAYAKA_DUMMY',		'BUILDINGCLASS_DECISION_SAYAKA_DUMMY',
			-1,		-1,			-1,				null,		1,				1,
			100, 100);