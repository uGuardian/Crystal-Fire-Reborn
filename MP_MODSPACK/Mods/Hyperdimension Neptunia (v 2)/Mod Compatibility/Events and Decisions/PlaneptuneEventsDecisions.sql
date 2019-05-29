INSERT INTO DecisionsAddin_Support
			(FileName)
VALUES		('Planeptune_Decisions.lua');

INSERT INTO EventsAddin_Support
			(FileName)
VALUES		('Planeptune_Events.lua');


--Eggplant dummy building
INSERT INTO BuildingClasses
			(Type,											DefaultBuilding)
VALUES		('BUILDINGCLASS_DECISION_PLANEPTUNE_EGGPLANT', 'BUILDING_DECISION_PLANEPTUNE_EGGPLANT');

INSERT INTO Buildings
			(Type,											BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune)
VALUES		('BUILDING_DECISION_PLANEPTUNE_EGGPLANT',		'BUILDINGCLASS_DECISION_PLANEPTUNE_EGGPLANT',
			-1,		-1,			-1,				null,		1,				1);

INSERT INTO Building_YieldModifiers
			(BuildingType,								YieldType,		Yield)
VALUES		('BUILDING_DECISION_PLANEPTUNE_EGGPLANT',	'YIELD_FOOD',	1);



--Nep Bull promotion
INSERT INTO UnitPromotions	
			(Type,									Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry,
			HealOnPillage)
SELECT		('PROMOTION_DECISION_NEP_BULL'),		('TXT_KEY_PROMOTION_DECISION_NEP_BULL'),('TXT_KEY_PROMOTION_DECISION_NEP_BULL_HELP'),
			1,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_DECISION_NEP_BULL'),
			1
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');


INSERT OR IGNORE INTO UnitPromotions_UnitCombats
			(PromotionType,						UnitCombatType)
SELECT		('PROMOTION_DECISION_NEP_BULL'),	CombatClass
FROM Units WHERE Domain = 'DOMAIN_LAND';


--Nep Bull policy
INSERT INTO Policies
			(Type,							Description)
VALUES		('POLICY_DECISION_NEP_BULL',	'TXT_KEY_DECISIONS_VV_PLANEPTUNE_NEP_BULL');

INSERT INTO Policy_FreePromotions
			(PolicyType,					PromotionType)
VALUES		('POLICY_DECISION_NEP_BULL',	'PROMOTION_DECISION_NEP_BULL');


--Nep Bull building
INSERT INTO BuildingClasses
			(Type,											DefaultBuilding)
VALUES		('BUILDINGCLASS_DECISION_PLANEPTUNE_NEP_BULL', 'BUILDING_DECISION_PLANEPTUNE_NEP_BULL');

INSERT INTO Buildings
			(Type,											BuildingClass,	
			Cost,	FaithCost,	GreatWorkCount, PrereqTech, NeverCapture,	NukeImmune)
VALUES		('BUILDING_DECISION_PLANEPTUNE_NEP_BULL',		'BUILDINGCLASS_DECISION_PLANEPTUNE_NEP_BULL',
			-1,		-1,			-1,				null,		1,				1);

INSERT INTO Building_YieldChanges
			(BuildingType,								YieldType,		Yield)
VALUES		('BUILDING_DECISION_PLANEPTUNE_NEP_BULL',	'YIELD_GOLD',	1);




--Pissty target promotion
INSERT INTO UnitPromotions	
			(Type,									Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_VV_PLANEPTUNE_EVENT'),		('TXT_KEY_PROMOTION_VV_PLANEPTUNE_EVENT'),('TXT_KEY_PROMOTION_VV_PLANEPTUNE_EVENT_HELP'),
			1,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_VV_PLANEPTUNE_EVENT')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');


--Ababababa sound
INSERT INTO  Audio_Sounds (SoundID,			Filename,					LoadType)
VALUES		('SND_VV_HISTY_ABABABA',		'VVAbabababa',				'DynamicResident');

INSERT INTO Audio_2DSounds
			(ScriptID,						SoundID,						SoundType,			MaxVolume,	MinVolume)
VALUES		('AS2D_VV_HISTY_ABABABA',		'SND_VV_HISTY_ABABABA',			'GAME_SFX',			50,			50);



--Orange Slime Puddle
INSERT INTO ArtDefine_StrategicView(StrategicViewType, TileType, Asset)
SELECT 'ART_DEF_IMPROVEMENT_VV_DOGOO_SLIME_ORANGE', 'Improvement', 'SV_VV_NeptuneImprovement.dds';


INSERT INTO Improvements
			(Type,								Description,						Civilopedia,
			Help,											ArtDefineTag,								PortraitIndex,	IconAtlas,
			PillageGold, 	DestroyedWhenPillaged)
VALUES		('IMPROVEMENT_VV_ORANGE_SLIME_PUDDLE',	'TXT_KEY_IMPROVEMENT_VV_ORANGE_SLIME_PUDDLE',	'TXT_KEY_IMPROVEMENT_VV_ORANGE_SLIME_PUDDLE_TEXT',
			'TXT_KEY_IMPROVEMENT_VV_ORANGE_SLIME_PUDDLE_HELP','ART_DEF_IMPROVEMENT_VV_DOGOO_SLIME_ORANGE', 7,			'CIV_COLOR_ATLAS_VV_PLANEPTUNE',
			0,				1);

INSERT INTO Improvement_Yields
			(ImprovementType,						YieldType,		Yield)
VALUES		('IMPROVEMENT_VV_ORANGE_SLIME_PUDDLE',	'YIELD_FOOD',	6);



--Segata policies
INSERT INTO Policies
			(Type,								Description,								ExpModifier)
VALUES		('POLICY_DECISIONS_VV_SEGATA_A',	'TXT_KEY_DECISIONS_VV_PLANEPTUNE_NEP_BULL',	0),
			('POLICY_DECISIONS_VV_SEGATA_B',	'TXT_KEY_DECISIONS_VV_PLANEPTUNE_NEP_BULL',	25);

INSERT INTO Policy_BuildingClassTourismModifiers
			(PolicyType,						BuildingClassType,			TourismModifier)
VALUES		('POLICY_DECISIONS_VV_SEGATA_A',	'BUILDINGCLASS_BARRACKS',	10);