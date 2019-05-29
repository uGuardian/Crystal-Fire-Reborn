INSERT INTO DecisionsAddin_Support		
			(FileName)
VALUES		('RiderDecisions.lua');


INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_RIDER_TSHIRT_DECISION'),		('TXT_KEY_PROMOTION_RIDER_TSHIRT_DECISION'),		('TXT_KEY_PROMOTION_RIDER_TSHIRT_DECISION_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_RIDER_TSHIRT_DECISION')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_UNWELCOME_EVANGELIST');

INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_RIDER_DIADOCHI_DECISION'),		('TXT_KEY_PROMOTION_RIDER_DIADOCHI_DECISION'),		('TXT_KEY_PROMOTION_RIDER_DIADOCHI_DECISION_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_RIDER_DIADOCHI_DECISION')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_STEAM_POWERED');

UPDATE UnitPromotions
SET CombatPercent = -15
WHERE Type = 'PROMOTION_RIDER_TSHIRT_DECISION';

INSERT INTO BuildingClasses
			(Type,											DefaultBuilding)
VALUES		('BUILDINGCLASS_DECISIONS_RIDER_DIADOCHI',		'BUILDING_DECISIONS_RIDER_DIADOCHI');

INSERT INTO Buildings
			(Type,								BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune,
			CultureRateModifier)
VALUES		('BUILDING_DECISIONS_RIDER_DIADOCHI',		'BUILDINGCLASS_DECISIONS_RIDER_DIADOCHI',
			-1,		-1,			-1,				null,		1,				1,
			25);

INSERT INTO Building_YieldModifiers
			(BuildingType,							YieldType,			Yield)
VALUES		('BUILDING_DECISIONS_RIDER_DIADOCHI',	'YIELD_PRODUCTION',	15);


INSERT INTO Policies
			(Type,								MinorFriendshipDecayMod)
VALUES		('POLICY_DECISIONS_RIDER_TSHIRT',	-25);

INSERT INTO Policies
			(Type,								PolicyCostModifier)
VALUES		('POLICY_DECISIONS_RIDER_DIADOCHI',	-10);