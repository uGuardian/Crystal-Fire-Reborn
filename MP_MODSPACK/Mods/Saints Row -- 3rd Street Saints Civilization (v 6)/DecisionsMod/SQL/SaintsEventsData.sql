INSERT INTO EventsAddin_Support		
			(FileName)
VALUES		('SaintsEvents.lua');

INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_DECISIONS_SRTT_GANG'),		('TXT_KEY_PROMOTION_DECISIONS_SRTT_GANG'),		('TXT_KEY_PROMOTION_DECISIONS_SRTT_GANG_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_DECISIONS_SRTT_GANG')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_STEAM_POWERED');