--==========================================================================================================================
-- Units
--==========================================================================================================================
INSERT INTO Units 	
			(Class, Type, 					PrereqTech, Combat, Cost, 	FaithCost, 	RequiresFaithPurchaseEnabled, Moves, HurryCostModifier,	CombatClass, Domain, DefaultUnitAI, Description, 					Civilopedia, 					Strategy, 							Help, 							MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, XPValueAttack, XPValueDefense, Conscription, UnitArtInfo, 					UnitFlagAtlas, 							UnitFlagIconOffset, PortraitIndex, 	IconAtlas, 						MoveRate)
SELECT		Class,  ('UNIT_ELMA-DS'), PrereqTech, Combat, Cost, 	FaithCost, 	RequiresFaithPurchaseEnabled, 5, HurryCostModifier,	CombatClass, Domain, DefaultUnitAI, ('TXT_KEY_ELMA-DS_DESC'), ('TXT_KEY_ELMA-DS_TEXT'), ('TXT_KEY_ELMA-DS_STRATEGY'), ('TXT_KEY_ELMA-DS_HELP'),	MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, XPValueAttack, XPValueDefense, Conscription, ('ART_DEF_UNIT_ELMA-DS'), UnitFlagAtlas, 	0,					0, 				('ELMADS_ICON_ATLAS'), 	MoveRate
FROM Units WHERE (Type = 'UNIT_RIFLEMAN');

INSERT INTO Units 	
			(Class, Type, 				ShowInPedia,	Special, PrereqTech, Combat, Cost, 	FaithCost, 	RequiresFaithPurchaseEnabled, Moves, HurryCostModifier, BaseBeakersTurnsToCount, WorkRate, Domain, DefaultUnitAI,			Description,				Civilopedia,				Strategy, Help, MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, XPValueAttack, XPValueDefense, Conscription, UnitArtInfoEraVariation,	UnitArtInfo, UnitFlagAtlas, UnitFlagIconOffset, PortraitIndex, 	IconAtlas, 					MoveRate)
SELECT		Class, 	('UNIT_ROUGE_REAYVATEIL'), 	0,				Special, PrereqTech, Combat, Cost, 	FaithCost, 	RequiresFaithPurchaseEnabled, Moves, HurryCostModifier, 8,						  WorkRate, Domain, ('UNITAI_SCIENTIST'),	('TXT_KEY_UNIT_GREAT_GENERAL'),	('TXT_KEY_UNIT_GREAT_GENERAL_STRATEGY'),	Strategy, Help, MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, XPValueAttack, XPValueDefense, Conscription, UnitArtInfoEraVariation,	UnitArtInfo, UnitFlagAtlas, UnitFlagIconOffset,	3, 				('UNIT_ATLAS_2'), MoveRate
FROM Units WHERE (Type = 'UNIT_GREAT_GENERAL');
--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================	
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 					SelectionSound, FirstSelectionSound)
SELECT		('UNIT_ELMA-DS'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_RIFLEMAN');	

INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 			SelectionSound, FirstSelectionSound)
SELECT		('UNIT_ROUGE_REAYVATEIL'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_GREAT_GENERAL');	
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================	
INSERT INTO Unit_AITypes 	
			(UnitType, 				UnitAIType)
SELECT		('UNIT_ELMA-DS'), UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_RIFLEMAN');	

INSERT INTO Unit_AITypes 	
			(UnitType, 				UnitAIType)
SELECT		('UNIT_ROUGE_REAYVATEIL'), 		UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_SCIENTIST');	
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================	
INSERT INTO Unit_Flavors 	
			(UnitType, 				FlavorType,	Flavor)
SELECT		('UNIT_ELMA-DS'), FlavorType,	Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_RIFLEMAN');	

INSERT INTO Unit_Flavors 	
			(UnitType, 				FlavorType,	Flavor)
SELECT		('UNIT_ROUGE_REAYVATEIL'), 		FlavorType,	Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_GREAT_GENERAL');	
--==========================================================================================================================
-- Unit_Builds
--==========================================================================================================================	
INSERT INTO Unit_Builds 	
			(UnitType, 				BuildType)
SELECT		('UNIT_ROUGE_REAYVATEIL'), 		BuildType
FROM Unit_Builds WHERE (UnitType = 'UNIT_GREAT_GENERAL');	
--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================	
INSERT INTO Unit_FreePromotions 	
			(UnitType, 				PromotionType)
SELECT		('UNIT_ROUGE_REAYVATEIL'), 		PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_GREAT_GENERAL');	
	
INSERT OR REPLACE INTO Unit_FreePromotions 
			(UnitType, 				PromotionType)
VALUES		('UNIT_ELMA-DS', 	'PROMOTION_VIRUS'),
			('UNIT_ELMA-DS', 	'PROMOTION_BLITZ'),
			
--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================	
INSERT INTO Unit_ClassUpgrades 	
			(UnitType, 				UnitClassType)
SELECT		('UNIT_ELMA-DS'), UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_RIFLEMAN');	
