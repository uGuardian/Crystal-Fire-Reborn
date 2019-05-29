--**********************************************************************************************
--Promotions for Unique Units (Magical Girl promotions in a separate file)
--**********************************************************************************************

--Define all promotions identically, then later in the file, add their effects.

INSERT INTO UnitPromotions
			(Type,											Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_INCUBATOR_SLAVE'),					('TXT_KEY_PROMOTION_INCUBATOR_SLAVE'),		('TXT_KEY_PROMOTION_INCUBATOR_SLAVE_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_INCUBATOR_SLAVE')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');

INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_IMMUNE_TO_DEMON_HOMURA_TRAIT'),		('TXT_KEY_PROMOTION_IMMUNE_TO_DEMON_HOMURA_TRAIT'),		('TXT_KEY_PROMOTION_IMMUNE_TO_DEMON_HOMURA_TRAIT_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_IMMUNE_TO_DEMON_HOMURA_TRAIT')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');

INSERT INTO UnitPromotions
			(Type,											Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_PMMM_CLARA_DOLL'),					('TXT_KEY_PROMOTION_PMMM_CLARA_DOLL'),		('TXT_KEY_PROMOTION_PMMM_CLARA_DOLL_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_PMMM_CLARA_DOLL')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');

INSERT INTO UnitPromotions
			(Type,											Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_PMMM_CLARA_DOLL_BUFF'),					('TXT_KEY_PROMOTION_PMMM_CLARA_DOLL_BUFF'),		('TXT_KEY_PROMOTION_PMMM_CLARA_DOLL_BUFF_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_PMMM_CLARA_DOLL')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');

INSERT INTO UnitPromotions
			(Type,										Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_DOES_NOT_BECOME_GMG'),			('TXT_KEY_PROMOTION_DOES_NOT_BECOME_GMG'),	('TXT_KEY_PROMOTION_DOES_NOT_BECOME_GMG_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_DOES_NOT_BECOME_GMG')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_UNWELCOME_EVANGELIST');

INSERT INTO UnitPromotions
			(Type,										Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_PMMM_CLOCKSTOPPER'),			('TXT_KEY_PROMOTION_PMMM_CLOCKSTOPPER'),	('TXT_KEY_PROMOTION_PMMM_CLOCKSTOPPER_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_PMMM_CLOCKSTOPPER')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');

INSERT INTO UnitPromotions
			(Type,										Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_PMMM_ARTIFICIAL_INCUBATOR'),	('TXT_KEY_PROMOTION_PMMM_ARTIFICIAL_INCUBATOR'), ('TXT_KEY_PROMOTION_PMMM_ARTIFICIAL_INCUBATOR_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_PMMM_ARTIFICIAL_INCUBATOR')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');

INSERT INTO UnitPromotions
			(Type,										Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_PMMM_CHAIN_LANCER'),			('TXT_KEY_PROMOTION_PMMM_CHAIN_LANCER'),	('TXT_KEY_PROMOTION_PMMM_CHAIN_LANCER_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_PMMM_CHAIN_LANCER')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');

INSERT INTO UnitPromotions
			(Type,										Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_PMMM_ROSEBOW_INFANTRY'),		('TXT_KEY_PROMOTION_PMMM_ROSEBOW_INFANTRY'),('TXT_KEY_PROMOTION_PMMM_ROSEBOW_INFANTRY_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_PMMM_ROSEBOW_INFANTRY')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');

INSERT INTO UnitPromotions
			(Type,										Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_PMMM_ROSEBOW_INFANTRY_BONUS'),		('TXT_KEY_PROMOTION_PMMM_ROSEBOW_INFANTRY_BONUS'),('TXT_KEY_PROMOTION_PMMM_ROSEBOW_INFANTRY_BONUS_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_PMMM_ROSEBOW_INFANTRY')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');

INSERT INTO UnitPromotions
			(Type,										Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_PMMM_ROSEBOW_INFANTRY_BONUS_IMPROVEMENT'),		('TXT_KEY_PROMOTION_PMMM_ROSEBOW_INFANTRY_BONUS'),('TXT_KEY_PROMOTION_PMMM_ROSEBOW_INFANTRY_BONUS_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_PMMM_ROSEBOW_INFANTRY')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');

INSERT INTO UnitPromotions
			(Type,										Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_PMMM_TIRO_MUSKETEER'),			('TXT_KEY_PROMOTION_PMMM_TIRO_MUSKETEER'),	('TXT_KEY_PROMOTION_PMMM_TIRO_MUSKETEER_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_PMMM_TIRO_MUSKETEER')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');

INSERT INTO UnitPromotions
			(Type,										Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_PMMM_BUBBLE_BOMBER'),			('TXT_KEY_PROMOTION_PMMM_BUBBLE_BOMBER'),	('TXT_KEY_PROMOTION_PMMM_BUBBLE_BOMBER_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_PMMM_BUBBLE_BOMBER')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');

INSERT INTO UnitPromotions
			(Type,										Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_PMMM_BUBBLE_BOMBER_BONUS'),			('TXT_KEY_PROMOTION_PMMM_BUBBLE_BOMBER_BONUS'),	('TXT_KEY_PROMOTION_PMMM_BUBBLE_BOMBER_BONUS_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_PMMM_BUBBLE_BOMBER')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');

INSERT INTO UnitPromotions
			(Type,										Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_PMMM_MAGICLAW'),				('TXT_KEY_PROMOTION_PMMM_MAGICLAW'),		('TXT_KEY_PROMOTION_PMMM_MAGICLAW_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_PMMM_MAGICLAW')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');

INSERT INTO UnitPromotions
			(Type,										Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_PMMM_MAGICLAW_DEBUFF'),				('TXT_KEY_PROMOTION_PMMM_MAGICLAW_DEBUFF'),		('TXT_KEY_PROMOTION_PMMM_MAGICLAW_DEBUFF_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_PMMM_MAGICLAW')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_UNWELCOME_EVANGELIST');

INSERT INTO UnitPromotions
			(Type,										Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_PMMM_CUTLASS_CONDUCTOR'),		('TXT_KEY_PROMOTION_PMMM_CUTLASS_CONDUCTOR'),('TXT_KEY_PROMOTION_PMMM_CUTLASS_CONDUCTOR_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_PMMM_CUTLASS_CONDUCTOR')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');

INSERT INTO UnitPromotions	
			(Type,										Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_PMMM_HERALD_OF_MADOKA'),		('TXT_KEY_PROMOTION_PMMM_HERALD_OF_MADOKA'),('TXT_KEY_PROMOTION_PMMM_HERALD_OF_MADOKA_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_PMMM_HERALD_OF_MADOKA')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');


INSERT INTO UnitPromotions	
			(Type,										Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_PMMM_FARSIGHT_ORACLE'),		('TXT_KEY_PROMOTION_PMMM_FARSIGHT_ORACLE'),('TXT_KEY_PROMOTION_PMMM_FARSIGHT_ORACLE_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_PMMM_FARSIGHT_ORACLE')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');

INSERT INTO UnitPromotions	
			(Type,										Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_PMMM_TIRO_MUSKETEER_DEBUFF'),		('TXT_KEY_PROMOTION_PMMM_TIRO_MUSKETEER_DEBUFF'),('TXT_KEY_PROMOTION_PMMM_TIRO_MUSKETEER_DEBUFF_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_PMMM_TIRO_MUSKETEER_DEBUFF')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_UNWELCOME_EVANGELIST');

INSERT INTO UnitPromotions	
			(Type,										Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_PMMM_BROKEN_PSYCHE'),		('TXT_KEY_PROMOTION_PMMM_BROKEN_PSYCHE'),('TXT_KEY_PROMOTION_PMMM_BROKEN_PSYCHE_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_PMMM_BROKEN_PSYCHE')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_UNWELCOME_EVANGELIST');

INSERT INTO UnitPromotions	
			(Type,										Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_PMMM_WITCH_NO_XP'),		('TXT_KEY_PROMOTION_PMMM_WITCH_NO_XP'),('TXT_KEY_PROMOTION_PMMM_WITCH_NO_XP_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_PMMM_WITCH_NO_XP')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_UNWELCOME_EVANGELIST');

/* -----------------------------------------------------
						Clara Doll
   --------------------------------------------------- */

INSERT INTO Promotion_PMMM_GrantAdjacentAllyPromotion
			(PromotionType,Radius,AllyPromotionType)
VALUES		('PROMOTION_PMMM_CLARA_DOLL',0,'PROMOTION_PMMM_CLARA_DOLL_BUFF');

INSERT INTO UnitPromotions_UnitClasses
			(PromotionType,UnitClassType,Modifier,PediaType)
VALUES		('PROMOTION_PMMM_CLARA_DOLL_BUFF','UNITCLASS_PMMM_MAGICAL_GIRL',50,'PEDIA_ATTRIBUTES');


/* -----------------------------------------------------
						Artificial Incubator
   --------------------------------------------------- */

UPDATE UnitPromotions
SET ExtraWithdrawal=80,SoulGemPolishPercent=3
WHERE Type = 'PROMOTION_PMMM_ARTIFICIAL_INCUBATOR';

/* -----------------------------------------------------
						Thief of Time
   --------------------------------------------------- */

UPDATE UnitPromotions
SET ObtainUniqueUnitPromotionOnCityCapture=1
WHERE Type = 'PROMOTION_PMMM_CLOCKSTOPPER';

/* -----------------------------------------------------
						Chain Lancer
   --------------------------------------------------- */

UPDATE UnitPromotions
SET FlankAttackModifier=50
WHERE Type = 'PROMOTION_PMMM_CHAIN_LANCER';

/* -----------------------------------------------------
						Rosebow Infantry
   --------------------------------------------------- */

INSERT INTO Promotion_PMMM_GrantNewPromotionOnImprovement
			(PromotionType,ImprovementType,NewPromotionType)
VALUES		('PROMOTION_PMMM_ROSEBOW_INFANTRY','IMPROVEMENT_CITADEL','PROMOTION_PMMM_ROSEBOW_INFANTRY_BONUS_IMPROVEMENT');

UPDATE UnitPromotions
SET NewPromotionInCity='PROMOTION_PMMM_ROSEBOW_INFANTRY_BONUS'
WHERE Type = 'PROMOTION_PMMM_ROSEBOW_INFANTRY';

UPDATE UnitPromotions
SET ExtraAttacks=1,CanMoveAfterAttacking=1
WHERE Type = 'PROMOTION_PMMM_ROSEBOW_INFANTRY_BONUS';

UPDATE UnitPromotions
SET ExtraAttacks=1,CanMoveAfterAttacking=1
WHERE Type = 'PROMOTION_PMMM_ROSEBOW_INFANTRY_BONUS_IMPROVEMENT';


/* -----------------------------------------------------
						Cutlass Conductor
   --------------------------------------------------- */

UPDATE UnitPromotions
SET HarmonyGainedPerLevel=1
WHERE Type = 'PROMOTION_PMMM_CUTLASS_CONDUCTOR';

/* -----------------------------------------------------
						Tiro Musketeer
   --------------------------------------------------- */

UPDATE UnitPromotions
SET TiroFinaleStrength=50
WHERE Type = 'PROMOTION_PMMM_TIRO_MUSKETEER';

UPDATE UnitPromotions
SET DefenseMod=-20
WHERE Type = 'PROMOTION_PMMM_TIRO_MUSKETEER_DEBUFF';

/* -----------------------------------------------------
						Bubble Bomber
   --------------------------------------------------- */

UPDATE UnitPromotions
SET CityAttack=50, AttackFortifiedMod=50
WHERE Type = 'PROMOTION_PMMM_BUBBLE_BOMBER';

UPDATE UnitPromotions
SET RangedAttackModifier=33
WHERE Type = 'PROMOTION_PMMM_BUBBLE_BOMBER_BONUS';

INSERT INTO Promotion_PMMM_GrantNewPromotionNearEnemy
			(PromotionType,Radius,NewPromotionType)
VALUES		('PROMOTION_PMMM_BUBBLE_BOMBER',2,'PROMOTION_PMMM_BUBBLE_BOMBER_BONUS');


/* -----------------------------------------------------
						Magiclaw
   --------------------------------------------------- */

UPDATE UnitPromotions
SET AttackMod=15, DefenseMod=-15
WHERE Type = 'PROMOTION_PMMM_MAGICLAW';

INSERT INTO Promotion_PMMM_GrantAdjacentEnemyPromotion
			(PromotionType,Radius,EnemyPromotionType)
VALUES		('PROMOTION_PMMM_MAGICLAW',1,'PROMOTION_PMMM_MAGICLAW_DEBUFF');

UPDATE UnitPromotions
SET MovesChange=-1
WHERE Type = 'PROMOTION_PMMM_MAGICLAW_DEBUFF';

/* -----------------------------------------------------
						Herald of Madoka
   --------------------------------------------------- */


UPDATE UnitPromotions
SET MovesChange=1, CanStealCriticalMagicalGirl=1
WHERE Type = 'PROMOTION_PMMM_HERALD_OF_MADOKA';



/* -----------------------------------------------------
						Farsight Oracle Promotion
   --------------------------------------------------- */


UPDATE UnitPromotions
SET RangeAttackIgnoreLOS=1, Recon=1
WHERE Type = 'PROMOTION_PMMM_FARSIGHT_ORACLE';



--Add "do not become GMG" to any GPs which have combat strength

INSERT INTO Unit_FreePromotions
			(UnitType, 		PromotionType)
SELECT		Type,			('PROMOTION_DOES_NOT_BECOME_GMG')
FROM Units WHERE Special='SPECIALUNIT_PEOPLE' AND Combat > 0;


CREATE TRIGGER DoNotBecomeGMGUnits
AFTER INSERT ON Units
WHEN NEW.Special='SPECIALUNIT_PEOPLE' AND NEW.Combat > 0
BEGIN
	INSERT INTO Unit_FreePromotions
			(UnitType, 		PromotionType)
	VALUES	(NEW.Type,		'PROMOTION_DOES_NOT_BECOME_GMG');
END;






--Broken Psyche
UPDATE UnitPromotions
SET CombatPercent=-50
WHERE Type = 'PROMOTION_PMMM_BROKEN_PSYCHE';


--Witch No XP
UPDATE UnitPromotions
SET ExperiencePercent=-9999999
WHERE Type = 'PROMOTION_PMMM_WITCH_NO_XP';