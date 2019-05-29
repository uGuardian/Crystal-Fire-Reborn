UPDATE Traits
SET LeaderMGUniquePromotion = 'PROMOTION_SRTT_BOSS'
WHERE Type = 'TRAIT_SRTT_RESPECT_SYSTEM';



INSERT INTO MG_MoodModifiers
			(Type,							Description,							PositiveTooltip,						NegativeTooltip,	Value,		MaxValue,	Turns,	ExternalScript)
VALUES		('MGMOODMOD_SRTT_JOYRIDE',		'TXT_KEY_MGMOODMOD_SRTT_JOYRIDE',		'TXT_KEY_MGMOODMOD_SRTT_JOYRIDE_TT',	null,				50,			500,		10,		'SRTTJoyrideMood.lua');