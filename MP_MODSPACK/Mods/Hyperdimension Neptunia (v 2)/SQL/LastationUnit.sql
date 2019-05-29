--==========================================================================================================================
-- Promotion
--==========================================================================================================================

INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry,
			ExperiencePercent)
SELECT		('PROMOTION_VV_ARMAS'),		('TXT_KEY_PROMOTION_VV_ARMAS'),		('TXT_KEY_PROMOTION_VV_ARMAS_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_VV_ARMAS'),
			75
FROM UnitPromotions	WHERE (Type = 'PROMOTION_HOMELAND_GUARDIAN');


INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry,
			CombatPercent,		FriendlyHealChange,	EnemyHealChange,	NeutralHealChange)
SELECT		('PROMOTION_VV_ARMAS_L1'),		('TXT_KEY_PROMOTION_VV_ARMAS_L1'),		('TXT_KEY_PROMOTION_VV_ARMAS_L1_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_VV_ARMAS_L1'),
			5,					1,					1,					1
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');

INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry,
			CombatPercent,		FriendlyHealChange,	EnemyHealChange,	NeutralHealChange)
SELECT		('PROMOTION_VV_ARMAS_L2'),		('TXT_KEY_PROMOTION_VV_ARMAS_L2'),		('TXT_KEY_PROMOTION_VV_ARMAS_L2_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_VV_ARMAS_L2'),
			10,					2,					2,					2
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');

INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry,
			CombatPercent,		FriendlyHealChange,	EnemyHealChange,	NeutralHealChange)
SELECT		('PROMOTION_VV_ARMAS_L3'),		('TXT_KEY_PROMOTION_VV_ARMAS_L3'),		('TXT_KEY_PROMOTION_VV_ARMAS_L3_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_VV_ARMAS_L3'),
			15,					3,					3,					3
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');

INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry,
			CombatPercent,		FriendlyHealChange,	EnemyHealChange,	NeutralHealChange)
SELECT		('PROMOTION_VV_ARMAS_L4'),		('TXT_KEY_PROMOTION_VV_ARMAS_L4'),		('TXT_KEY_PROMOTION_VV_ARMAS_L4_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_VV_ARMAS_L4'),
			20,					4,					4,					4
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');

INSERT INTO UnitPromotions
			(Type,											Description,											Help,						
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	PediaEntry,
			CombatPercent,		FriendlyHealChange,	EnemyHealChange,	NeutralHealChange)
SELECT		('PROMOTION_VV_ARMAS_L5'),		('TXT_KEY_PROMOTION_VV_ARMAS_L5'),		('TXT_KEY_PROMOTION_VV_ARMAS_L5_HELP'),
			CannotBeChosen,		Sound,	PortraitIndex,	IconAtlas,	PediaType,	('TXT_KEY_PROMOTION_VV_ARMAS_L5'),
			25,					5,					5,					5
FROM UnitPromotions	WHERE (Type = 'PROMOTION_RIVAL_TERRITORY');


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
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,UnitArtInfo,UnitArtInfoCulturalVariation,UnitArtInfoEraVariation,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,UnitFlagIconOffset,PortraitIndex,IconAtlas,UnitFlagAtlas)
SELECT		('UNIT_VV_ARMAS'),	('TXT_KEY_UNIT_VV_ARMAS'),	('TXT_KEY_UNIT_VV_ARMAS_TEXT'),	('TXT_KEY_UNIT_VV_ARMAS_STRATEGY'),	('TXT_KEY_UNIT_VV_ARMAS_HELP'),
			Requirements, Combat, RangedCombat, Cost, FaithCost, RequiresFaithPurchaseEnabled, PurchaseOnly, MoveAfterPurchase, Moves, Immobile, Range, BaseSightRange,	Class, Special, Capture, CombatClass, Domain,
			CivilianAttackPriority, DefaultUnitAI, Food, NoBadGoodies, RivalTerritory, MilitarySupport, MilitaryProduction, Pillage, PillagePrereqTech, Found, FoundAbroad, CultureBombRadius, GoldenAgeTurns, FreePolicies,
			OneShotTourism, OneShotTourismPercentOthers, IgnoreBuildingDefense, PrereqResources, Mechanized, Suicide, CaptureWhileEmbarked, PrereqTech, (SELECT ObsoleteTech FROM Units WHERE Type = 'UNIT_MUSKETMAN'), GoodyHutUpgradeUnitClass, HurryCostModifier, AdvancedStartCost,
			MinAreaSize, AirInterceptRange, AirUnitCap, NukeDamageLevel, WorkRate, NumFreeTechs, BaseBeakersTurnsToCount, BaseCultureTurnsToCount, RushBuilding, BaseHurry, HurryMultiplier, BaseGold, NumGoldPerEra,
			SpreadReligion, RemoveHeresy,ReligionSpreads,ReligiousStrength,FoundReligion,RequiresEnhancedReligion,ProhibitsSpread,CanBuyCityState,CombatLimit,RangeAttackOnlyInDomain,RangeAttackIgnoreLOS,Trade,NumExoticGoods,
			PolicyType, RangedCombatLimit, XPValueAttack, XPValueDefense,SpecialCargo,DomainCargo,Conscription,ExtraMaintenanceCost,NoMaintenance,Unhappiness,('ART_DEF_UNIT_VV_ARMAS'),UnitArtInfoCulturalVariation,UnitArtInfoEraVariation,
			ProjectPrereq,SpaceshipProject,LeaderPromotion,LeaderExperience,DontShowYields,ShowInPedia,MoveRate,0,3,('CIV_COLOR_ATLAS_VV_LASTATION'),('UNIT_FLAG_ATLAS_ARMAS')
FROM Units WHERE (Type = 'UNIT_LONGSWORDSMAN');

--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 						SelectionSound, FirstSelectionSound)
SELECT		('UNIT_VV_ARMAS'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_LONGSWORDSMAN');	
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================
INSERT INTO Unit_AITypes 	
			(UnitType, 						UnitAIType)
SELECT		('UNIT_VV_ARMAS'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_LONGSWORDSMAN');
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================
INSERT INTO Unit_Flavors 	
			(UnitType, 						FlavorType, Flavor)
SELECT		('UNIT_VV_ARMAS'), 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_LONGSWORDSMAN');
--==========================================================================================================================
-- Unit_Builds
--==========================================================================================================================
INSERT INTO Unit_Builds 	
			(UnitType, 					BuildType)
SELECT		('UNIT_VV_ARMAS'), BuildType
FROM Unit_Builds WHERE (UnitType = 'UNIT_LONGSWORDSMAN');

--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions 	
			(UnitType, 				PromotionType)
SELECT		('UNIT_VV_ARMAS'), 	PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_LONGSWORDSMAN');

INSERT INTO Unit_FreePromotions 	
			(UnitType, 			PromotionType)
VALUES		('UNIT_VV_ARMAS', 	'PROMOTION_VV_ARMAS');

--==========================================================================================================================
-- Unit_Buildings
--==========================================================================================================================
INSERT INTO Unit_Buildings	
			(UnitType, 						BuildingType)
SELECT		('UNIT_VV_ARMAS'), 	BuildingType
FROM Unit_Buildings WHERE (UnitType = 'UNIT_LONGSWORDSMAN');

--==========================================================================================================================
-- Unit_BuildingClassRequireds
--==========================================================================================================================
INSERT INTO Unit_BuildingClassRequireds	
			(UnitType, 						BuildingClassType)
SELECT		('UNIT_VV_ARMAS'), 	BuildingClassType
FROM Unit_BuildingClassRequireds WHERE (UnitType = 'UNIT_LONGSWORDSMAN');

--==========================================================================================================================
-- Unit_ProductionModifierBuildings
--==========================================================================================================================
INSERT INTO Unit_ProductionModifierBuildings	
			(UnitType, 						BuildingType,	ProductionModifier)
SELECT		('UNIT_VV_ARMAS'), 	BuildingType,	ProductionModifier
FROM Unit_ProductionModifierBuildings WHERE (UnitType = 'UNIT_LONGSWORDSMAN');

--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================
INSERT INTO Unit_ClassUpgrades	
			(UnitType, 			UnitClassType)
SELECT		('UNIT_VV_ARMAS'), 	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_MUSKETMAN');

--==========================================================================================================================
-- Unit_GreatPersons
--==========================================================================================================================
INSERT INTO Unit_GreatPersons	
			(UnitType, 						GreatPersonType)
SELECT		('UNIT_VV_ARMAS'), 	GreatPersonType
FROM Unit_GreatPersons WHERE (UnitType = 'UNIT_LONGSWORDSMAN');


--==========================================================================================================================
-- Unit_ResourceQuantityRequirements
--==========================================================================================================================
INSERT INTO Unit_ResourceQuantityRequirements	
			(UnitType, 			ResourceType,		Cost)
SELECT		('UNIT_VV_ARMAS'), 	ResourceType,		Cost
FROM Unit_ResourceQuantityRequirements WHERE (UnitType = 'UNIT_LONGSWORDSMAN');

--==========================================================================================================================
-- Unit_YieldFromKills
--==========================================================================================================================
INSERT INTO Unit_YieldFromKills	
			(UnitType, 				YieldType,	Yield)
SELECT		('UNIT_VV_ARMAS'), 	YieldType,	Yield
FROM Unit_YieldFromKills WHERE (UnitType = 'UNIT_LONGSWORDSMAN');
