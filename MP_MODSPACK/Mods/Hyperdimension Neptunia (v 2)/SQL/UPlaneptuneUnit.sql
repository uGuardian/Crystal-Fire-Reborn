INSERT INTO UnitPromotions
			(Type,								Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry,
			FlankAttackModifier)
SELECT		('PROMOTION_VV_ANIMATED_DOLL'),		('TXT_KEY_PROMOTION_VV_ANIMATED_DOLL'),		('TXT_KEY_PROMOTION_VV_ANIMATED_DOLL_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_VV_ANIMATED_DOLL'),
			500

FROM UnitPromotions	WHERE (Type = 'PROMOTION_HOMELAND_GUARDIAN');



--==========================================================================================================================
-- Units
--==========================================================================================================================
INSERT INTO Units 	
			(Type,							Description,							Civilopedia,						Strategy,										Help,										
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange, Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,	Unhappiness,UnitArtInfo,UnitArtInfoCulturalVariation,UnitArtInfoEraVariation,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,UnitFlagIconOffset,PortraitIndex,IconAtlas,UnitFlagAtlas)
SELECT		('UNIT_VV_ANIMATED_DOLL'),	('TXT_KEY_UNIT_VV_ANIMATED_DOLL'),	('TXT_KEY_UNIT_VV_ANIMATED_DOLL_TEXT'),	('TXT_KEY_UNIT_VV_ANIMATED_DOLL_STRATEGY'),	('TXT_KEY_UNIT_VV_ANIMATED_DOLL_HELP'),
			Requirements, CAST((Combat * 0.5) AS INT), RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange,	Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, (SELECT PrereqTech FROM Units WHERE Type = 'UNIT_MUSKETMAN'), null, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,1,	Unhappiness,('ART_DEF_UNIT_PLUTIA_DOLL'),0,0,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,0,3,('CIV_COLOR_ATLAS_VV_PLANEPTUNE_PL'),('UNIT_FLAG_ATLAS_PLANEPTUNE_PL')
FROM Units WHERE (Type = 'UNIT_WARRIOR');

--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 					SelectionSound,	FirstSelectionSound)
SELECT		('UNIT_VV_ANIMATED_DOLL'),	SelectionSound,	FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_WARRIOR');
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================
INSERT INTO Unit_AITypes 	
			(UnitType, 					UnitAIType)
SELECT		('UNIT_VV_ANIMATED_DOLL'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_WARRIOR');
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================
INSERT INTO Unit_Flavors 	
			(UnitType, 					FlavorType, Flavor)
SELECT		('UNIT_VV_ANIMATED_DOLL'), 	FlavorType, Flavor + 5
FROM Unit_Flavors WHERE (UnitType = 'UNIT_WARRIOR');
--==========================================================================================================================
-- Unit_Builds
--==========================================================================================================================
INSERT INTO Unit_Builds 	
			(UnitType, 					BuildType)
SELECT		('UNIT_VV_ANIMATED_DOLL'),	BuildType
FROM Unit_Builds WHERE (UnitType = 'UNIT_WARRIOR');

--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions 	
			(UnitType, 					PromotionType)
SELECT		('UNIT_VV_ANIMATED_DOLL'), 	PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_WARRIOR');

INSERT INTO Unit_FreePromotions
			(UnitType, 					PromotionType)
VALUES		('UNIT_VV_ANIMATED_DOLL',	'PROMOTION_VV_ANIMATED_DOLL');

--==========================================================================================================================
-- Unit_Buildings
--==========================================================================================================================
INSERT INTO Unit_Buildings	
			(UnitType, 					BuildingType)
SELECT		('UNIT_VV_ANIMATED_DOLL'), 	BuildingType
FROM Unit_Buildings WHERE (UnitType = 'UNIT_WARRIOR');

--==========================================================================================================================
-- Unit_BuildingClassRequireds
--==========================================================================================================================
INSERT INTO Unit_BuildingClassRequireds	
			(UnitType, 					BuildingClassType)
SELECT		('UNIT_VV_ANIMATED_DOLL'), 	BuildingClassType
FROM Unit_BuildingClassRequireds WHERE (UnitType = 'UNIT_WARRIOR');

--==========================================================================================================================
-- Unit_ProductionModifierBuildings
--==========================================================================================================================
INSERT INTO Unit_ProductionModifierBuildings	
			(UnitType, 					BuildingType,	ProductionModifier)
SELECT		('UNIT_VV_ANIMATED_DOLL'), 	BuildingType,	ProductionModifier
FROM Unit_ProductionModifierBuildings WHERE (UnitType = 'UNIT_WARRIOR');

--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================
--Dolls can't upgrade.

/*INSERT INTO Unit_ClassUpgrades	
			(UnitType, 					UnitClassType)
SELECT		('UNIT_VV_ANIMATED_DOLL'), 	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_WARRIOR');*/


--==========================================================================================================================
-- Unit_GreatPersons
--==========================================================================================================================
INSERT INTO Unit_GreatPersons	
			(UnitType, 					GreatPersonType)
SELECT		('UNIT_VV_ANIMATED_DOLL'), 	GreatPersonType
FROM Unit_GreatPersons WHERE (UnitType = 'UNIT_WARRIOR');


--==========================================================================================================================
-- Unit_ResourceQuantityRequirements
--==========================================================================================================================
--none

--==========================================================================================================================
-- Unit_YieldFromKills
--==========================================================================================================================
INSERT INTO Unit_YieldFromKills	
			(UnitType, 					YieldType,	Yield)
SELECT		('UNIT_VV_ANIMATED_DOLL'), 	YieldType,	Yield
FROM Unit_YieldFromKills WHERE (UnitType = 'UNIT_WARRIOR');





--********************************************************************************************************************************************
-- DOLL PROMOTIONS
--********************************************************************************************************************************************

INSERT INTO UnitPromotions
			(Type,								Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry,
			AttackMod)
SELECT		('PROMOTION_PLUTIA_SD_GET_EVEN'),		('TXT_KEY_PROMOTION_PLUTIA_SD_GET_EVEN'),		('TXT_KEY_PROMOTION_PLUTIA_SD_GET_EVEN_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_PLUTIA_SD_GET_EVEN'),
			15

FROM UnitPromotions	WHERE (Type = 'PROMOTION_HOMELAND_GUARDIAN');


INSERT INTO UnitPromotions
			(Type,								Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry,
			CityAttack)
SELECT		('PROMOTION_PLUTIA_SD_SMASH'),		('TXT_KEY_PROMOTION_PLUTIA_SD_SMASH'),		('TXT_KEY_PROMOTION_PLUTIA_SD_SMASH_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_PLUTIA_SD_SMASH'),
			50

FROM UnitPromotions	WHERE (Type = 'PROMOTION_HOMELAND_GUARDIAN');


INSERT INTO UnitPromotions
			(Type,								Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry,
			ExperiencePercent)
SELECT		('PROMOTION_PLUTIA_SD_XP_MINUS'),		('TXT_KEY_PROMOTION_PLUTIA_SD_XP_MINUS'),		('TXT_KEY_PROMOTION_PLUTIA_SD_XP_MINUS_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_PLUTIA_SD_XP_MINUS'),
			-75

FROM UnitPromotions	WHERE (Type = 'PROMOTION_UNWELCOME_EVANGELIST');