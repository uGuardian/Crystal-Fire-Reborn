--==========================================================================================================================
-- Promotion
--==========================================================================================================================

INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry)
SELECT		('PROMOTION_VV_LOWEE_SOLDIER'),		('TXT_KEY_PROMOTION_VV_LOWEE_SOLDIER'),		('TXT_KEY_PROMOTION_VV_LOWEE_SOLDIER_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_VV_LOWEE_SOLDIER')
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');

INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry,
			DefenseMod)
SELECT		('PROMOTION_VV_LOWEE_SOLDIER_BUFF'),		('TXT_KEY_PROMOTION_VV_LOWEE_SOLDIER_BUFF'),		('TXT_KEY_PROMOTION_VV_LOWEE_SOLDIER_HELP_BUFF'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_VV_LOWEE_SOLDIER_BUFF'),
			10
FROM UnitPromotions	WHERE (Type = 'PROMOTION_HOMELAND_GUARDIAN');

INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry,
			CityAttack)
SELECT		('PROMOTION_VV_WHITE_HEART_DENOUNCE_BONUS'),		('TXT_KEY_PROMOTION_VV_WHITE_HEART_DENOUNCE_BONUS'),		('TXT_KEY_PROMOTION_VV_WHITE_HEART_DENOUNCE_BONUS_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_VV_WHITE_HEART_DENOUNCE_BONUS'),
			33
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
SELECT		('UNIT_VV_LOWEE_SOLDIER'),	('TXT_KEY_UNIT_VV_LOWEE_SOLDIER'),	('TXT_KEY_UNIT_VV_LOWEE_SOLDIER_TEXT'),	('TXT_KEY_UNIT_VV_LOWEE_SOLDIER_STRATEGY'),	('TXT_KEY_UNIT_VV_LOWEE_SOLDIER_HELP'),
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange,	Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,	Unhappiness,('ART_DEF_UNIT_LOWEE_SOLDIER'),0,0,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,0,3,('CIV_COLOR_ATLAS_VV_LOWEE'),('CIV_ALPHA_ATLAS_VV_LOWEE')
FROM Units WHERE (Type = 'UNIT_RIFLEMAN');

--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 					SelectionSound,						FirstSelectionSound)
VALUES		('UNIT_VV_LOWEE_SOLDIER',	'AS2D_UNIT_SELECT_LOWEE_SOLDIER',	'AS2D_UNIT_SELECT_LOWEE_SOLDIER');
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================
INSERT INTO Unit_AITypes 	
			(UnitType, 						UnitAIType)
SELECT		('UNIT_VV_LOWEE_SOLDIER'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_RIFLEMAN');
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================
INSERT INTO Unit_Flavors 	
			(UnitType, 						FlavorType, Flavor)
SELECT		('UNIT_VV_LOWEE_SOLDIER'), 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_RIFLEMAN');
--==========================================================================================================================
-- Unit_Builds
--==========================================================================================================================
INSERT INTO Unit_Builds 	
			(UnitType, 					BuildType)
SELECT		('UNIT_VV_LOWEE_SOLDIER'), BuildType
FROM Unit_Builds WHERE (UnitType = 'UNIT_RIFLEMAN');

--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions 	
			(UnitType, 				PromotionType)
SELECT		('UNIT_VV_LOWEE_SOLDIER'), 	PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_RIFLEMAN');

--Add this in Lua to avoid the issue I'm having with GameEvents.UnitTrained
/*INSERT INTO Unit_FreePromotions 	
			(UnitType, 			PromotionType)
VALUES		('UNIT_VV_LOWEE_SOLDIER', 	'PROMOTION_VV_LOWEE_SOLDIER'); */

--==========================================================================================================================
-- Unit_Buildings
--==========================================================================================================================
INSERT INTO Unit_Buildings	
			(UnitType, 						BuildingType)
SELECT		('UNIT_VV_LOWEE_SOLDIER'), 	BuildingType
FROM Unit_Buildings WHERE (UnitType = 'UNIT_RIFLEMAN');

--==========================================================================================================================
-- Unit_BuildingClassRequireds
--==========================================================================================================================
INSERT INTO Unit_BuildingClassRequireds	
			(UnitType, 						BuildingClassType)
SELECT		('UNIT_VV_LOWEE_SOLDIER'), 	BuildingClassType
FROM Unit_BuildingClassRequireds WHERE (UnitType = 'UNIT_RIFLEMAN');

--==========================================================================================================================
-- Unit_ProductionModifierBuildings
--==========================================================================================================================
INSERT INTO Unit_ProductionModifierBuildings	
			(UnitType, 						BuildingType,	ProductionModifier)
SELECT		('UNIT_VV_LOWEE_SOLDIER'), 	BuildingType,	ProductionModifier
FROM Unit_ProductionModifierBuildings WHERE (UnitType = 'UNIT_RIFLEMAN');

--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================
INSERT INTO Unit_ClassUpgrades	
			(UnitType, 					UnitClassType)
SELECT		('UNIT_VV_LOWEE_SOLDIER'), 	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_RIFLEMAN');

--==========================================================================================================================
-- Unit_GreatPersons
--==========================================================================================================================
INSERT INTO Unit_GreatPersons	
			(UnitType, 						GreatPersonType)
SELECT		('UNIT_VV_LOWEE_SOLDIER'), 	GreatPersonType
FROM Unit_GreatPersons WHERE (UnitType = 'UNIT_RIFLEMAN');


--==========================================================================================================================
-- Unit_ResourceQuantityRequirements
--==========================================================================================================================
INSERT INTO Unit_ResourceQuantityRequirements	
			(UnitType, 					ResourceType,		Cost)
SELECT		('UNIT_VV_LOWEE_SOLDIER'),		ResourceType,		Cost
FROM Unit_ResourceQuantityRequirements WHERE (UnitType = 'UNIT_RIFLEMAN');

--==========================================================================================================================
-- Unit_YieldFromKills
--==========================================================================================================================
INSERT INTO Unit_YieldFromKills	
			(UnitType, 						YieldType,	Yield)
SELECT		('UNIT_VV_LOWEE_SOLDIER'), 	YieldType,	Yield
FROM Unit_YieldFromKills WHERE (UnitType = 'UNIT_RIFLEMAN');