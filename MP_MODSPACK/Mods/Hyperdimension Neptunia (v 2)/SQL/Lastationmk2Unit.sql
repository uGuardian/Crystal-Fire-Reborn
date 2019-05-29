INSERT INTO UnitPromotions
			(Type,								Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry,
			ExtraWithdrawal)
SELECT		('PROMOTION_VV_XMB_ARTILLERY'),		('TXT_KEY_PROMOTION_VV_XMB_ARTILLERY'),		('TXT_KEY_PROMOTION_VV_XMB_ARTILLERY_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_VV_XMB_ARTILLERY'),
			33
FROM UnitPromotions	WHERE (Type = 'PROMOTION_HOMELAND_GUARDIAN');


INSERT INTO UnitPromotions
			(Type,								Description,								Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,							PediaType,	PediaEntry,
			ExtraAttacks,	CanMoveAfterAttacking)
SELECT		('PROMOTION_VV_XMB_ARTILLERY_BONUS'),		('TXT_KEY_PROMOTION_VV_XMB_ARTILLERY_BONUS'),		('TXT_KEY_PROMOTION_VV_XMB_ARTILLERY_BONUS_HELP'),
			CannotBeChosen,		Sound,	3,				('KRIS_SWORDSMAN_PROMOTION_ATLAS'),	PediaType,	('TXT_KEY_PROMOTION_VV_XMB_ARTILLERY'),
			1,				1
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
SELECT		('UNIT_VV_XMB_ARTILLERY'),	('TXT_KEY_UNIT_VV_XMB_ARTILLERY'),	('TXT_KEY_UNIT_VV_XMB_ARTILLERY_TEXT'),	('TXT_KEY_UNIT_VV_XMB_ARTILLERY_STRATEGY'),	('TXT_KEY_UNIT_VV_XMB_ARTILLERY_HELP'),
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange,	Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, ObsoleteTech, GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,	Unhappiness,('ART_DEF_UNIT_XMB_INFANTRY'),0,0,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,0,3,('CIV_COLOR_ATLAS_VV_LASTATION_UN'),('UNIT_FLAG_ATLAS_LASTATION_UN')
FROM Units WHERE (Type = 'UNIT_ARTILLERY');

--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 					SelectionSound,	FirstSelectionSound)
SELECT		('UNIT_VV_XMB_ARTILLERY'),	SelectionSound,	FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_ARTILLERY');
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================
INSERT INTO Unit_AITypes 	
			(UnitType, 					UnitAIType)
SELECT		('UNIT_VV_XMB_ARTILLERY'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_ARTILLERY');
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================
INSERT INTO Unit_Flavors 	
			(UnitType, 					FlavorType, Flavor)
SELECT		('UNIT_VV_XMB_ARTILLERY'), 	FlavorType, Flavor + 5
FROM Unit_Flavors WHERE (UnitType = 'UNIT_ARTILLERY');
--==========================================================================================================================
-- Unit_Builds
--==========================================================================================================================
INSERT INTO Unit_Builds 	
			(UnitType, 					BuildType)
SELECT		('UNIT_VV_XMB_ARTILLERY'),	BuildType
FROM Unit_Builds WHERE (UnitType = 'UNIT_ARTILLERY');

--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions 	
			(UnitType, 					PromotionType)
SELECT		('UNIT_VV_XMB_ARTILLERY'), 	PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_ARTILLERY');

INSERT INTO Unit_FreePromotions 	
			(UnitType, 					PromotionType)
VALUES		('UNIT_VV_XMB_ARTILLERY',	'PROMOTION_VV_XMB_ARTILLERY');

--==========================================================================================================================
-- Unit_Buildings
--==========================================================================================================================
INSERT INTO Unit_Buildings	
			(UnitType, 					BuildingType)
SELECT		('UNIT_VV_XMB_ARTILLERY'), 	BuildingType
FROM Unit_Buildings WHERE (UnitType = 'UNIT_ARTILLERY');

--==========================================================================================================================
-- Unit_BuildingClassRequireds
--==========================================================================================================================
INSERT INTO Unit_BuildingClassRequireds	
			(UnitType, 					BuildingClassType)
SELECT		('UNIT_VV_XMB_ARTILLERY'), 	BuildingClassType
FROM Unit_BuildingClassRequireds WHERE (UnitType = 'UNIT_ARTILLERY');

--==========================================================================================================================
-- Unit_ProductionModifierBuildings
--==========================================================================================================================
INSERT INTO Unit_ProductionModifierBuildings	
			(UnitType, 					BuildingType,	ProductionModifier)
SELECT		('UNIT_VV_XMB_ARTILLERY'), 	BuildingType,	ProductionModifier
FROM Unit_ProductionModifierBuildings WHERE (UnitType = 'UNIT_ARTILLERY');

--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================
INSERT INTO Unit_ClassUpgrades	
			(UnitType, 					UnitClassType)
SELECT		('UNIT_VV_XMB_ARTILLERY'), 	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_ARTILLERY');


--==========================================================================================================================
-- Unit_GreatPersons
--==========================================================================================================================
INSERT INTO Unit_GreatPersons	
			(UnitType, 					GreatPersonType)
SELECT		('UNIT_VV_XMB_ARTILLERY'), 	GreatPersonType
FROM Unit_GreatPersons WHERE (UnitType = 'UNIT_ARTILLERY');


--==========================================================================================================================
-- Unit_ResourceQuantityRequirements
--==========================================================================================================================
INSERT INTO Unit_ResourceQuantityRequirements	
			(UnitType, 					ResourceType,		Cost)
SELECT		('UNIT_VV_XMB_ARTILLERY'), 	ResourceType,		Cost
FROM Unit_ResourceQuantityRequirements WHERE (UnitType = 'UNIT_ARTILLERY');

--==========================================================================================================================
-- Unit_YieldFromKills
--==========================================================================================================================
INSERT INTO Unit_YieldFromKills	
			(UnitType, 					YieldType,	Yield)
SELECT		('UNIT_VV_XMB_ARTILLERY'), 	YieldType,	Yield
FROM Unit_YieldFromKills WHERE (UnitType = 'UNIT_ARTILLERY');