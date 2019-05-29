INSERT INTO EventsAddin_Support		
			(FileName)
VALUES		('BigBossEvents.lua');


INSERT INTO BuildingClasses
			(Type,										DefaultBuilding)
VALUES		('BUILDINGCLASS_DECISION_BIGBOSS',			'BUILDING_DECISION_BIGBOSS'),
			('BUILDINGCLASS_DECISIONS_BIGBOSS_SPEEDBALL', 'BUILDING_DECISIONS_BIGBOSS_SPEEDBALL');


INSERT INTO Buildings
			(Type,								BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune,
			EnhancedYieldTech,	TechEnhancedTourism)
VALUES		('BUILDING_DECISION_BIGBOSS',		'BUILDINGCLASS_DECISION_BIGBOSS',
			-1,		-1,			-1,				null,		1,				1,
			'TECH_AGRICULTURE',	8);

INSERT INTO Buildings
			(Type,								BuildingClass,	
			Cost,	PrereqTech, NeverCapture,	NukeImmune,
			FreePolicies, PolicyCostModifier)
VALUES		('BUILDING_DECISIONS_BIGBOSS_SPEEDBALL',		'BUILDINGCLASS_DECISIONS_BIGBOSS_SPEEDBALL',
			-1,		null,		1,				1,
			3,	-10);

UPDATE Buildings
SET Description = 'TXT_KEY_' || Type, Civilopedia = 'TXT_KEY_' || Type || '_TEXT', Help = 'TXT_KEY_' || Type || '_HELP'
WHERE Type = 'BUILDING_DECISIONS_BIGBOSS_SPEEDBALL';

UPDATE Buildings
SET IconAtlas = 'CIV_COLOR_ATLAS_MSF', PortraitIndex = 4
WHERE Type = 'BUILDING_DECISIONS_BIGBOSS_SPEEDBALL';


INSERT INTO UnitPromotions	
			(Type,										Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_DECISIONS_BIGBOSS'),		('TXT_KEY_PROMOTION_DECISIONS_BIGBOSS'),('TXT_KEY_PROMOTION_DECISIONS_BIGBOSS_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_DECISIONS_BIGBOSS')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');

UPDATE UnitPromotions
SET CombatPercent = 20
WHERE Type = 'PROMOTION_DECISIONS_BIGBOSS';