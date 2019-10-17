
--Gustavus UA promotion (granted by Lua upon being near the correct number of other-combat-type units)
INSERT INTO UnitPromotions	
			(Type,										Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry,
			CombatPercent)
SELECT		('PROMOTION_PMMM_GUSTAVUS_TRAIT'),		('TXT_KEY_PROMOTION_PMMM_GUSTAVUS_TRAIT'),('TXT_KEY_PROMOTION_PMMM_GUSTAVUS_TRAIT_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_PMMM_GUSTAVUS_TRAIT'),
			20
FROM UnitPromotions	WHERE (Type = 'PROMOTION_HEAVY_CHARGE');

