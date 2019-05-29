INSERT INTO DecisionsAddin_Support		
			(FileName)
VALUES		('LancerDecisions.lua');


INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_DECISIONS_LANCER'),		('TXT_KEY_PROMOTION_DECISIONS_LANCER'),		('TXT_KEY_PROMOTION_DECISIONS_LANCER_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_DECISIONS_LANCER')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_UNWELCOME_EVANGELIST');

UPDATE UnitPromotions
SET DefenseMod = -25
WHERE Type = 'PROMOTION_DECISIONS_LANCER';