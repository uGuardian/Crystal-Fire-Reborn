INSERT INTO DecisionsAddin_Support
			(FileName)
VALUES		('HrodtohzDecisions.lua');

INSERT INTO Policies
			(Type)
VALUES		('POLICY_DECISIONS_HRODTOHZ_TRADITIONALISTS_1'),
			('POLICY_DECISIONS_HRODTOHZ_TRADITIONALISTS_2'),
			('POLICY_DECISIONS_HRODTOHZ_TRADITIONALISTS_3'),
			('POLICY_DECISIONS_HRODTOHZ_TRADITIONALISTS_4'),
			('POLICY_DECISIONS_HRODTOHZ_TRADITIONALISTS_5'),
			('POLICY_DECISIONS_HRODTOHZ_RESTRUCTURISTS_1'),
			('POLICY_DECISIONS_HRODTOHZ_RESTRUCTURISTS_2'),
			('POLICY_DECISIONS_HRODTOHZ_RESTRUCTURISTS_3'),
			('POLICY_DECISIONS_HRODTOHZ_RESTRUCTURISTS_4'),
			('POLICY_DECISIONS_HRODTOHZ_RESTRUCTURISTS_5');

INSERT INTO BuildingClasses
			(Type,										DefaultBuilding,						Description)
VALUES		('BUILDINGCLASS_DECISIONS_HRODTOHZ_DUMMY',	'BUILDING_DECISIONS_HRODTOHZ_DUMMY',	'TXT_KEY_BUILDING_DECISIONS_HRODTOHZ_DUMMY');

INSERT INTO Buildings
			(Type,										BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune)
VALUES		('BUILDING_DECISIONS_HRODTOHZ_DUMMY',		'BUILDINGCLASS_DECISIONS_HRODTOHZ_DUMMY',
			-1,		-1,			-1,				null,		1,				1);


UPDATE Policies
SET MinorFriendshipMinimum = 3, MinorGoldFriendshipMod = 7, MilitaryProductionModifier = -5, UnitGoldMaintenanceMod = 7, ExpModifier = -10
WHERE Type = 'POLICY_DECISIONS_HRODTOHZ_TRADITIONALISTS_1';

UPDATE Policies
SET MinorFriendshipMinimum = 6, MinorGoldFriendshipMod = 14, MilitaryProductionModifier = -10, UnitGoldMaintenanceMod = 14, ExpModifier = -20
WHERE Type = 'POLICY_DECISIONS_HRODTOHZ_TRADITIONALISTS_2';

UPDATE Policies
SET MinorFriendshipMinimum = 9, MinorGoldFriendshipMod = 21, MilitaryProductionModifier = -15, UnitGoldMaintenanceMod = 21, ExpModifier = -30
WHERE Type = 'POLICY_DECISIONS_HRODTOHZ_TRADITIONALISTS_3';

UPDATE Policies
SET MinorFriendshipMinimum = 12, MinorGoldFriendshipMod = 28, MilitaryProductionModifier = -20, UnitGoldMaintenanceMod = 28, ExpModifier = -40
WHERE Type = 'POLICY_DECISIONS_HRODTOHZ_TRADITIONALISTS_4';

UPDATE Policies
SET MinorFriendshipMinimum = 15, MinorGoldFriendshipMod = 35, MilitaryProductionModifier = -25, UnitGoldMaintenanceMod = 35, ExpModifier = -50, GreatWriterRateModifier = 50, GreatArtistRateModifier = 50, GreatMusicianRateModifier = 50
WHERE Type = 'POLICY_DECISIONS_HRODTOHZ_TRADITIONALISTS_5';


UPDATE Policies
SET MinorFriendshipMinimum = -3, MinorGoldFriendshipMod = -7, MilitaryProductionModifier = 5, UnitGoldMaintenanceMod = -7, ExpModifier = 10
WHERE Type = 'POLICY_DECISIONS_HRODTOHZ_RESTRUCTURISTS_1';

UPDATE Policies
SET MinorFriendshipMinimum = -6, MinorGoldFriendshipMod = -14, MilitaryProductionModifier = 10, UnitGoldMaintenanceMod = -14, ExpModifier = 20
WHERE Type = 'POLICY_DECISIONS_HRODTOHZ_RESTRUCTURISTS_2';

UPDATE Policies
SET MinorFriendshipMinimum = -9, MinorGoldFriendshipMod = -21, MilitaryProductionModifier = 15, UnitGoldMaintenanceMod = -21, ExpModifier = 30
WHERE Type = 'POLICY_DECISIONS_HRODTOHZ_RESTRUCTURISTS_3';

UPDATE Policies
SET MinorFriendshipMinimum = -12, MinorGoldFriendshipMod = -28, MilitaryProductionModifier = 20, UnitGoldMaintenanceMod = -28, ExpModifier = 40
WHERE Type = 'POLICY_DECISIONS_HRODTOHZ_RESTRUCTURISTS_4';

UPDATE Policies
SET MinorFriendshipMinimum = -15, MinorGoldFriendshipMod = -35, MilitaryProductionModifier = 25, UnitGoldMaintenanceMod = -35, ExpModifier = 50, GreatWriterRateModifier = 50, GreatArtistRateModifier = 50, GreatMusicianRateModifier = 50
WHERE Type = 'POLICY_DECISIONS_HRODTOHZ_RESTRUCTURISTS_5';


INSERT INTO Policy_FreePromotions
			(PolicyType,									PromotionType)
VALUES		('POLICY_DECISIONS_HRODTOHZ_RESTRUCTURISTS_5',	'PROMOTION_DECISIONS_HRODTOHZ_RESTRUCTURISTS');


INSERT INTO Policy_BuildingClassTourismModifiers
			(PolicyType,									BuildingClassType,							TourismModifier)
VALUES		('POLICY_DECISIONS_HRODTOHZ_TRADITIONALISTS_1',	'BUILDINGCLASS_DECISION_HRODTOHZ_DUMMY',	10),
			('POLICY_DECISIONS_HRODTOHZ_TRADITIONALISTS_2',	'BUILDINGCLASS_DECISION_HRODTOHZ_DUMMY',	20),
			('POLICY_DECISIONS_HRODTOHZ_TRADITIONALISTS_3',	'BUILDINGCLASS_DECISION_HRODTOHZ_DUMMY',	30),
			('POLICY_DECISIONS_HRODTOHZ_TRADITIONALISTS_4',	'BUILDINGCLASS_DECISION_HRODTOHZ_DUMMY',	40),
			('POLICY_DECISIONS_HRODTOHZ_TRADITIONALISTS_5',	'BUILDINGCLASS_DECISION_HRODTOHZ_DUMMY',	50),

			('POLICY_DECISIONS_HRODTOHZ_RESTRUCTURISTS_1',	'BUILDINGCLASS_DECISION_HRODTOHZ_DUMMY',	-10),
			('POLICY_DECISIONS_HRODTOHZ_RESTRUCTURISTS_1',	'BUILDINGCLASS_DECISION_HRODTOHZ_DUMMY',	-20),
			('POLICY_DECISIONS_HRODTOHZ_RESTRUCTURISTS_1',	'BUILDINGCLASS_DECISION_HRODTOHZ_DUMMY',	-30),
			('POLICY_DECISIONS_HRODTOHZ_RESTRUCTURISTS_1',	'BUILDINGCLASS_DECISION_HRODTOHZ_DUMMY',	-40),
			('POLICY_DECISIONS_HRODTOHZ_RESTRUCTURISTS_1',	'BUILDINGCLASS_DECISION_HRODTOHZ_DUMMY',	-50);



INSERT INTO UnitPromotions
			(Type,											Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_DECISIONS_HRODTOHZ_RESTRUCTURISTS'),					('TXT_KEY_PROMOTION_DECISIONS_HRODTOHZ_RESTRUCTURISTS'),		('TXT_KEY_PROMOTION_DECISIONS_HRODTOHZ_RESTRUCTURISTS_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_DECISIONS_HRODTOHZ_RESTRUCTURISTS')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_STEAM_POWERED');

UPDATE UnitPromotions
SET OutsideFriendlyLandsModifier = 20
WHERE Type = 'PROMOTION_DECISIONS_HRODTOHZ_RESTRUCTURISTS';


INSERT INTO UnitPromotions_UnitCombats
			(PromotionType,										UnitCombatType)
VALUES		('PROMOTION_DECISIONS_HRODTOHZ_RESTRUCTURISTS'),	UnitCombatType
FROM UnitPromotions_UnitCombats WHERE PromotionType = 'PROMOTION_INSTA_HEAL';