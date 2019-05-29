INSERT OR IGNORE INTO MG_MoodModifiers
			(Type,							Description,						PositiveTooltip,					NegativeTooltip,	Value,		MaxValue,	Turns,	ExternalScript)
VALUES		('MGMOODMOD_HDN_SHARES',		'TXT_KEY_MGMOODMOD_HDN_SHARES',		'TXT_KEY_MGMOODMOD_HDN_SHARES_TT',	null,				2,			null,		null,	'HDNSharesMood.lua');

INSERT INTO Missions
			(Type,Description,Help,DisabledHelp,EntityEventType,Time,OrderPriority,Visible,IconIndex,IconAtlas,
			PMMMSoulGemCorruptionBase,	PMMMMissionRange,	PMMMTargetType)
SELECT		('MISSION_PMMM_HDN_GETTER_RAVINE'),('TXT_KEY_MISSION_PMMM_HDN_GETTER_RAVINE'),('TXT_KEY_MISSION_PMMM_HDN_GETTER_RAVINE_HELP'),('TXT_KEY_MISSION_PMMM_HDN_GETTER_RAVINE_DISABLED'),EntityEventType,Time,200,Visible,0,('CIV_ALPHA_ATLAS_VV_LOWEE'),
			30,							1,					('ENEMY')
FROM Missions WHERE Type = 'MISSION_RANGE_ATTACK';


UPDATE Traits
SET LeaderMGUniqueMission = 'MISSION_PMMM_HDN_GETTER_RAVINE', Description = 'TXT_KEY_TRAIT_VV_WHITE_HEART_WFTW'
WHERE Type = 'TRAIT_VV_WHITE_HEART';