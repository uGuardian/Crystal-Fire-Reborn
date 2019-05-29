--**********************************************************************************************
--**********************************************************************************************
-----------------Adjustments to existing Tables (Traits, UnitPromotions)------------------------
--**********************************************************************************************
--**********************************************************************************************



--**********************************************************************************************
--Traits
--**********************************************************************************************
ALTER TABLE Traits ADD COLUMN 'MagicalGirlOnGreatPersonUse' BOOLEAN DEFAULT true NOT NULL; --now defaults to true! Only Demon Homura will have this as "false."
ALTER TABLE Traits ADD COLUMN 'CityStateCombatStrengthModTimes100' INTEGER DEFAULT 0; --Amount of Strength granted to Gun
ALTER TABLE Traits ADD COLUMN 'GreatPersonProgressFromKills' TEXT DEFAULT NULL REFERENCES Specialists(Type); --Sayaka's trait
ALTER TABLE Traits ADD COLUMN 'CombatBonusFromTourismInfluence' BOOLEAN DEFAULT false NOT NULL; --Sayaka's trait. Is a boolean since it uses specific promotions.
ALTER TABLE Traits ADD COLUMN 'ExtraRangedAttackInCityOrCitadel' BOOLEAN DEFAULT false NOT NULL; --Madoka's trait
ALTER TABLE Traits ADD COLUMN 'NoWitches' BOOLEAN DEFAULT false NOT NULL; --UMadoka's new trait: whenever a Magical Girl would become a Witch, it instead just disappears for 5 turns and comes back at 50% Corruption
ALTER TABLE Traits ADD COLUMN 'CanSummonWitches' BOOLEAN DEFAULT false NOT NULL; --UMadoka: Can MGs summon Witches?
ALTER TABLE Traits ADD COLUMN 'NoMagicalGirls' BOOLEAN DEFAULT false NOT NULL; --DHomura
ALTER TABLE Traits ADD COLUMN 'SoulGemCorruptionModifier' INTEGER DEFAULT 0; --UMadoka's new trait: Reduce Soul Gem corruption
ALTER TABLE Traits ADD COLUMN 'StealGriefSeedOnCityCapture' BOOLEAN DEFAULT false NOT NULL; --Kyouko's new trait: Get a Grief Seed upon city capture
ALTER TABLE Traits ADD COLUMN 'MagicalGirlRelationshipModifier' INTEGER DEFAULT 0; --Mami's new trait: Modifier for Magical Girl Relationship points. Can be positive or negative
ALTER TABLE Traits ADD COLUMN 'StartWithTruthKnown' BOOLEAN DEFAULT false NOT NULL; --OriKiri trait: All MGs know The Truth as soon as they are born
ALTER TABLE Traits ADD COLUMN 'TruthMoodModifier' INTEGER DEFAULT 0; --OriKiri trait: Increase/decrease mood modifier from knowing The Truth. Can be positive or negative. -100% completely negates it, like with OriKiri trait
ALTER TABLE Traits ADD COLUMN 'CapitalBonusPerKilledMagicalGirl' INTEGER DEFAULT 0; --DHomura: How many +1% all-yields dummy buildings granted to Capital for killed Magical Girls
ALTER TABLE Traits ADD COLUMN 'MagicalGirlAttrition' INTEGER DEFAULT 0; --DHomura: Damage taken per turn by enemy Magical Girls in her territory (unless they have the level 5 promotion)
ALTER TABLE Traits ADD COLUMN 'TimeStopDuration' INTEGER DEFAULT 0; --Homura: how many turns time stop lasts (more than 1 will probably be super-broke, but adding the functionality to increase it regardless)
ALTER TABLE Traits ADD COLUMN 'TimeStopCooldown' INTEGER DEFAULT 0; --Homura: cooldown turns after time stop finishes before it can be used again
ALTER TABLE Traits ADD COLUMN 'MaxStolenFood' INTEGER DEFAULT 0; --Kyouko: maximum carriable Stolen Food (100 for Kyouko by default)
ALTER TABLE Traits ADD COLUMN 'CaravanPillageStolenFood' INTEGER DEFAULT 0; --Kyouko: how much Food to steal from a Caravan (not Cargo Ships)
ALTER TABLE Traits ADD COLUMN 'PromotionDifferentUnitCombats' TEXT DEFAULT NULL; --Gustavus: promotion to give to units which satisfy the next field
ALTER TABLE Traits ADD COLUMN 'AdjacentDifferenUnitCombatsRequired' INTEGER DEFAULT 0; --Gustavus: how many adjacent units of a different combat type you need to get previous field's promotion
ALTER TABLE Traits ADD COLUMN 'WitchBarrierXPMultiplier' INTEGER DEFAULT 0; --Askia
ALTER TABLE Traits ADD COLUMN 'ConvertNearbyFamiliarRadius' INTEGER DEFAULT 0; --Bismarck
ALTER TABLE Traits ADD COLUMN 'EnableFreezerSystem' BOOLEAN DEFAULT false NOT NULL; --Pleiades freezer system

--v19
ALTER TABLE Traits ADD COLUMN 'LeaderMGUniqueMission' TEXT DEFAULT NULL; --Special ability for this Civ's leader MG
ALTER TABLE Traits ADD COLUMN 'LeaderMGUniquePromotion' TEXT DEFAULT NULL; --Special promotion for this Civ's leader MG
ALTER TABLE Traits ADD COLUMN 'ExtraLeaderMG' BOOLEAN DEFAULT false NOT NULL; 
ALTER TABLE Traits ADD COLUMN 'ExtraLeaderMGName' TEXT DEFAULT NULL;
ALTER TABLE Traits ADD COLUMN 'ExtraLeaderMGPortraitIndexOverride' INTEGER DEFAULT -1;
ALTER TABLE Traits ADD COLUMN 'ExtraLeaderMGIconAtlasOverride' TEXT DEFAULT NULL;
ALTER TABLE Traits ADD COLUMN 'ExtraLeaderMGUniquePromotion' TEXT DEFAULT NULL;
ALTER TABLE Traits ADD COLUMN 'ExtraLeaderMGUniqueMission' TEXT DEFAULT NULL;
ALTER TABLE Traits ADD COLUMN 'LeaderMGRespawnTimeModifier' INTEGER DEFAULT 0;  --Homura

--v21
ALTER TABLE Traits ADD COLUMN 'MGMoodBonus' INTEGER DEFAULT 0;
ALTER TABLE Traits ADD COLUMN 'PopulationMoodBonus' INTEGER DEFAULT 0;

--v27
ALTER TABLE Traits ADD COLUMN 'LeaderMGIntrigueTurns' INTEGER DEFAULT 0;
ALTER TABLE Traits ADD COLUMN 'RevealCivLocations' BOOLEAN DEFAULT false NOT NULL;
ALTER TABLE Traits ADD COLUMN 'MaximumMetEraMGStrength' BOOLEAN DEFAULT false NOT NULL;


--**********************************************************************************************
--UnitPromotions
--**********************************************************************************************
ALTER TABLE UnitPromotions ADD COLUMN 'ShowInUnitPanel' BOOLEAN DEFAULT true NOT NULL; --General purpose field to prevent a promotion from showing up in the Unit Panel.
ALTER TABLE UnitPromotions ADD COLUMN 'ShowInPedia' BOOLEAN DEFAULT true NOT NULL; --General purpose field to prevent a promotion from showing up in the Civilopedia.
ALTER TABLE UnitPromotions ADD COLUMN 'ObtainUniqueUnitPromotionOnCityCapture' BOOLEAN DEFAULT false NOT NULL; -- this unit gets a random promotion from the enemy Civ's UU(s) upon city capture
ALTER TABLE UnitPromotions ADD COLUMN 'SoulGemPolishPercent' INTEGER DEFAULT 0; --this unit can use "Polish Soul Gem" on a Magical Girl; value is amount of Polish granted
ALTER TABLE UnitPromotions ADD COLUMN 'HarmonyGainedPerLevel' INTEGER DEFAULT 0;--this unit earns Harmony upon gaining a level, when garrisoned, Harmony doubles Tourism output of the city. This is multiplied by the Level, so if it is, say, 2, and the unit gets to Level 3, it gets 6 Harmony
ALTER TABLE UnitPromotions ADD COLUMN 'TiroFinaleStrength' INTEGER DEFAULT 0; -- amount to multiply Melee Strength to determine its Tiro Finale strength. 100 = identical to Melee Strength.
ALTER TABLE UnitPromotions ADD COLUMN 'CanStealCriticalMagicalGirl' BOOLEAN DEFAULT false NOT NULL; --this unit can steal a GMG from an enemy if that GMG's Soul Gem is Critical
ALTER TABLE UnitPromotions ADD COLUMN 'AdjacentCommanderMovement' INTEGER DEFAULT 0;--Any promotion with GreatGeneralReceivesMovement set to true will get this instead. Gives adjacent Commander MGs +1 Movement at start of turn
ALTER TABLE UnitPromotions ADD COLUMN 'NewPromotionInCity' TEXT DEFAULT NULL; --Rosebow Infantry

--v25 New MG Promos
ALTER TABLE UnitPromotions ADD COLUMN 'MGLikeDislikeSpreadBonus' INTEGER DEFAULT 0;
ALTER TABLE UnitPromotions ADD COLUMN 'MGSocializeBonus' INTEGER DEFAULT 0;
ALTER TABLE UnitPromotions ADD COLUMN 'MGSparringPartnerBonus' INTEGER DEFAULT 0;
ALTER TABLE UnitPromotions ADD COLUMN 'MGSparringCooldownReduction' INTEGER DEFAULT 0;
ALTER TABLE UnitPromotions ADD COLUMN 'MGSocializingXPGrantedToPartner' INTEGER DEFAULT 0;
ALTER TABLE UnitPromotions ADD COLUMN 'MGSocializingLoyaltyGrantedToPartner' INTEGER DEFAULT 0;

--v27
ALTER TABLE UnitPromotions ADD COLUMN 'SoulGemCorruptionMod' INTEGER DEFAULT 0;

--**********************************************************************************************
--Missions
--**********************************************************************************************

ALTER TABLE Missions ADD COLUMN 'PMMMMissionRange' INTEGER DEFAULT 0; --If greater than 0, clicking a mission will enable target selection
ALTER TABLE Missions ADD COLUMN 'PMMMTargetType' TEXT DEFAULT NULL; --Will either be "ALLY", "ENEMY", "EMPTY_PLOT", or various other things
ALTER TABLE Missions ADD COLUMN 'PMMMMissionExec' TEXT DEFAULT NULL; --Corresponds to the mission, will be coded into Lua and is not XML extensible
ALTER TABLE Missions ADD COLUMN 'PMMMSoulGemCorruptionBase' INTEGER DEFAULT 0; --Base amount of Soul Gem corruption which is then affected by modifiers
ALTER TABLE Missions ADD COLUMN 'PMMMPolishAmount' INTEGER DEFAULT 0;



--**********************************************************************************************
--Civilizations
--**********************************************************************************************

ALTER TABLE Civilizations ADD COLUMN 'DefaultMagicalGirlColor' INTEGER DEFAULT -1;
ALTER TABLE Civilizations ADD COLUMN 'LeaderMagicalGirlIconAtlasOverride' TEXT DEFAULT NULL;
ALTER TABLE Civilizations ADD COLUMN 'LeaderMagicalGirlPortraitIndexOverride' INTEGER DEFAULT -1;


--**********************************************************************************************
--Buildings
--**********************************************************************************************

ALTER TABLE Buildings ADD COLUMN 'GoldFromKillingWitches' INTEGER DEFAULT 0;
ALTER TABLE Buildings ADD COLUMN 'PMMMMoodBonus' INTEGER DEFAULT 0;
ALTER TABLE Buildings ADD COLUMN 'PMMMEntertainment' INTEGER DEFAULT 0;
ALTER TABLE Buildings ADD COLUMN 'PMMMEntertainmentModifier' INTEGER DEFAULT 0;
ALTER TABLE Buildings ADD COLUMN 'PMMMEntertainmentCitizenModifier' INTEGER DEFAULT 0;
ALTER TABLE Buildings ADD COLUMN 'PMMMEntertainmentSpecialistModifier' INTEGER DEFAULT 0;
ALTER TABLE Buildings ADD COLUMN 'PMMMEntertainmentConnectionModifier' INTEGER DEFAULT 0;
ALTER TABLE Buildings ADD COLUMN 'PMMMMaxLandAreaSize' INTEGER DEFAULT 0;
ALTER TABLE Buildings ADD COLUMN 'PMMMRequiresAdjacentLake' BOOLEAN DEFAULT FALSE;


--**********************************************************************************************
--Beliefs
--**********************************************************************************************

ALTER TABLE Beliefs ADD COLUMN 'AllowMissionarySGPurification' BOOLEAN DEFAULT false NOT NULL;
ALTER TABLE Beliefs ADD COLUMN 'PMMMMoodBonusPerFollowingCity' INTEGER DEFAULT 0;
ALTER TABLE Beliefs ADD COLUMN 'PMMMMoodBonusPerFollower' INTEGER DEFAULT 0;


--**********************************************************************************************
-- Policies
--**********************************************************************************************

ALTER TABLE Policies ADD COLUMN 'PMMMMoodBonusPerCapitalPop' INTEGER DEFAULT 0;
ALTER TABLE Policies ADD COLUMN 'PMMMMoodBonusPerCity' INTEGER DEFAULT 0;
ALTER TABLE Policies ADD COLUMN 'PMMMMoodBonusPerNonMGMilitaryUnit' INTEGER DEFAULT 0;
ALTER TABLE Policies ADD COLUMN 'PMMMMoodBonusPerReligiousFollower' INTEGER DEFAULT 0;
ALTER TABLE Policies ADD COLUMN 'PMMMMoodBonusPerMinorCivAlly' INTEGER DEFAULT 0;
ALTER TABLE Policies ADD COLUMN 'PMMMMoodBonusPerGreatWork' INTEGER DEFAULT 0;
ALTER TABLE Policies ADD COLUMN 'PMMMMoodBonusPerLuxury' INTEGER DEFAULT 0;
ALTER TABLE Policies ADD COLUMN 'PMMMMoodBonusPerMapPercent' INTEGER DEFAULT 0;
ALTER TABLE Policies ADD COLUMN 'PMMMMoodBonusPerTech' INTEGER DEFAULT 0;
ALTER TABLE Policies ADD COLUMN 'PMMMMoodBonusPerSpecialist' INTEGER DEFAULT 0;
ALTER TABLE Policies ADD COLUMN 'PMMMMoodBonusPerProductionTimes100' INTEGER DEFAULT 0;
ALTER TABLE Policies ADD COLUMN 'PMMMMoodBonusPerScoreTimes100' INTEGER DEFAULT 0;


--**********************************************************************************************
-- Specialists
--**********************************************************************************************

ALTER TABLE Specialists ADD COLUMN 'PMMMEntertainment' INTEGER DEFAULT 0;