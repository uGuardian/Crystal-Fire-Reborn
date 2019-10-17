-- Data Storage Lua for PMMM Mod
-- Author: Vicevirtuoso
-- DateCreated: 6/12/2014 12:34:19 PM
--------------------------------------------------------------

--This Lua file caches and maintains several tables and other types of data.

iMaxCivs = GameDefines.MAX_MAJOR_CIVS
iMaxCivsAndCS = GameDefines.MAX_CIV_PLAYERS


--Global table
PMMM.ConversionDataInit = PMMM.ConversionDataInit or false;

if not PMMM.ConversionDataInit then
	print("Initializing tables for first load.")
	----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------------CONSTANT TABLES------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	--Get each player's trait table and store it here.
	-- MapModData.gPMMMTraits = {}

	-- for i = 0, iMaxCivs - 1, 1 do
		-- local pPlayer = Players[i]
		-- if pPlayer:IsEverAlive() then
			-- leaderType = GameInfo.Leaders[pPlayer:GetLeaderType()].Type
			-- traitType = GameInfo.Leader_Traits("LeaderType ='" .. leaderType .. "'")().TraitType
			-- MapModData.gPMMMTraits[i] = GameInfo.Traits[traitType]
		-- end
	-- end
	
	MapModData.gPMMMTraits = {}

	for i = 0, iMaxCivs - 1, 1 do
		local pPlayer = Players[i]
		if pPlayer:IsEverAlive() then
			leaderType = GameInfo.Leaders[pPlayer:GetLeaderType()].Type
			traitType = GameInfo.Leader_Traits("LeaderType ='" .. leaderType .. "'")().TraitType
			trait = GameInfo.Traits[traitType]
			MapModData.gPMMMTraits[i] = {}
			MapModData.gPMMMTraits[i].Type = trait.Type
			MapModData.gPMMMTraits[i].CityStateCombatStrengthModTimes100 = trait.CityStateCombatStrengthModTimes100
			MapModData.gPMMMTraits[i].GreatPersonProgressFromKills = trait.GreatPersonProgressFromKills
			MapModData.gPMMMTraits[i].CombatBonusFromTourismInfluence = trait.CombatBonusFromTourismInfluence
			MapModData.gPMMMTraits[i].ExtraRangedAttackInCityOrCitadel = trait.ExtraRangedAttackInCityOrCitadel
			MapModData.gPMMMTraits[i].NoWitches = trait.NoWitches
			MapModData.gPMMMTraits[i].CanSummonWitches = trait.CanSummonWitches
			MapModData.gPMMMTraits[i].NoMagicalGirls = trait.NoMagicalGirls
			MapModData.gPMMMTraits[i].SoulGemCorruptionModifier = trait.SoulGemCorruptionModifier
			MapModData.gPMMMTraits[i].StealGriefSeedOnCityCapture = trait.StealGriefSeedOnCityCapture
			MapModData.gPMMMTraits[i].MagicalGirlRelationshipModifier = trait.MagicalGirlRelationshipModifier
			MapModData.gPMMMTraits[i].StartWithTruthKnown = trait.StartWithTruthKnown
			MapModData.gPMMMTraits[i].TruthMoodModifier = trait.TruthMoodModifier
			MapModData.gPMMMTraits[i].CapitalBonusPerKilledMagicalGirl = trait.CapitalBonusPerKilledMagicalGirl
			MapModData.gPMMMTraits[i].MagicalGirlAttrition = trait.MagicalGirlAttrition
			MapModData.gPMMMTraits[i].TimeStopDuration = trait.TimeStopDuration
			MapModData.gPMMMTraits[i].TimeStopCooldown = trait.TimeStopCooldown
			MapModData.gPMMMTraits[i].MaxStolenFood = trait.MaxStolenFood
			MapModData.gPMMMTraits[i].CaravanPillageStolenFood = trait.CaravanPillageStolenFood
			MapModData.gPMMMTraits[i].PromotionDifferentUnitCombats = trait.PromotionDifferentUnitCombats
			MapModData.gPMMMTraits[i].AdjacentDifferenUnitCombatsRequired = trait.AdjacentDifferenUnitCombatsRequired
			MapModData.gPMMMTraits[i].WitchBarrierXPMultiplier = trait.WitchBarrierXPMultiplier
			MapModData.gPMMMTraits[i].ConvertNearbyFamiliarRadius = trait.ConvertNearbyFamiliarRadius
			MapModData.gPMMMTraits[i].EnableFreezerSystem = trait.EnableFreezerSystem

			--v19
			MapModData.gPMMMTraits[i].LeaderMGUniqueMission = trait.LeaderMGUniqueMission
			MapModData.gPMMMTraits[i].LeaderMGUniquePromotion = trait.LeaderMGUniquePromotion
			MapModData.gPMMMTraits[i].ExtraLeaderMG = trait.ExtraLeaderMG
			MapModData.gPMMMTraits[i].ExtraLeaderMGName = trait.ExtraLeaderMGName
			MapModData.gPMMMTraits[i].ExtraLeaderMGPortraitIndexOverride = trait.ExtraLeaderMGPortraitIndexOverride
			MapModData.gPMMMTraits[i].ExtraLeaderMGIconAtlasOverride = trait.ExtraLeaderMGIconAtlasOverride
			MapModData.gPMMMTraits[i].ExtraLeaderMGUniquePromotion = trait.ExtraLeaderMGUniquePromotion
			MapModData.gPMMMTraits[i].ExtraLeaderMGUniqueMission = trait.ExtraLeaderMGUniqueMission
			MapModData.gPMMMTraits[i].LeaderMGRespawnTimeModifier = trait.LeaderMGRespawnTimeModifier
			
			--v21
			MapModData.gPMMMTraits[i].MGMoodBonus = trait.MGMoodBonus
			MapModData.gPMMMTraits[i].PopulationMoodBonus = trait.PopulationMoodBonus

			--v23
			MapModData.gPMMMTraits[i].FightWellDamaged = trait.FightWellDamaged  --this is a default game trait! (i.e. Japan's trait)

			--v27
			MapModData.gPMMMTraits[i].LeaderMGIntrigueTurns = trait.LeaderMGIntrigueTurns
			MapModData.gPMMMTraits[i].RevealCivLocations = trait.RevealCivLocations
			MapModData.gPMMMTraits[i].MaximumMetEraMGStrength = trait.MaximumMetEraMGStrength
		end
	end

	--Get UBs from this mod.
	MapModData.gPMMMUniqueBuildings = {}
	
	for i = 0, iMaxCivs - 1, 1 do
		local pPlayer = Players[i]
		if pPlayer:IsEverAlive() then
			for row in GameInfo.Civilization_BuildingClassOverrides() do
				if row.CivilizationType == GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type then
					if string.find(row.BuildingType, "_PMMM_") then
						MapModData.gPMMMUniqueBuildings[i] = GameInfo.Buildings("Type ='" ..row.BuildingType.. "'")().ID
					end
				end
			end
		end
	end
	
	--For Traits which utilize Stolen Food, find how much to get from every pillaged Improvement which gives it.
	MapModData.gPMMMStolenFoodAmounts = {}
	
	for k, v in pairs(MapModData.gPMMMTraits) do
		if v.MaxStolenFood > 0 then
			MapModData.gPMMMStolenFoodAmounts[k] = {}
			for	row in GameInfo.Trait_PMMM_StolenFoodFromImprovement() do
				if row.TraitType == v.Type then
					table.insert(MapModData.gPMMMStolenFoodAmounts[k], {
						["ImprovementType"] = GameInfo.Improvements("Type = '" ..row.ImprovementType.. "'")().ID,
						["Amount"] = row.Amount
					})
				end
			end
		end
	end
	
	--Which promotions give Harmony, and how much per level?
	MapModData.gPMMMHarmonyPromotions = {}

	for promotion in GameInfo.UnitPromotions() do
		if promotion.HarmonyGainedPerLevel > 0 then
			MapModData.gPMMMHarmonyPromotions[promotion.ID] = promotion.HarmonyGainedPerLevel
		end
	end
	--Which promotions grant a new promotion when on a specific Improvement?
	MapModData.gPMMMOnImprovementPromotions = {}

	for promotion in GameInfo.Promotion_PMMM_GrantNewPromotionOnImprovement() do
		local promotionType = GameInfo.UnitPromotions("Type ='" ..promotion.PromotionType.. "'")().ID
		MapModData.gPMMMOnImprovementPromotions[promotionType] =	{
				["ImprovementType"] = GameInfo.Improvements("Type ='" ..promotion.ImprovementType.. "'")().ID,
				["NewPromotionType"] = GameInfo.UnitPromotions("Type ='" ..promotion.NewPromotionType.. "'")().ID
		}
	end

	--Which promotions grant a new promotion when in a City?
	MapModData.gPMMMInCityPromotions = {}

	for promotion in GameInfo.UnitPromotions() do
		if promotion.NewPromotionInCity ~= nil then
			MapModData.gPMMMInCityPromotions[promotion.ID] = GameInfo.UnitPromotions("Type ='" ..promotion.NewPromotionInCity.. "'")().ID
		end
	end


	--Which promotions grant debuffs to enemies within distance?
	MapModData.gPMMMAdjacentEnemyDebuffs = {}

	for row in GameInfo.Promotion_PMMM_GrantAdjacentEnemyPromotion() do
		local promotionType = GameInfo.UnitPromotions("Type ='" ..row.PromotionType.. "'")().ID
		MapModData.gPMMMAdjacentEnemyDebuffs[promotionType] =	{
				["Radius"] = row.Radius,
				["EnemyPromotionType"] = GameInfo.UnitPromotions("Type ='" ..row.EnemyPromotionType.. "'")().ID
		}
	end

	--Which promotions grant buffs to allies within distance?
	MapModData.gPMMMAdjacentAllyBuffs = {}

	for row in GameInfo.Promotion_PMMM_GrantAdjacentAllyPromotion() do
		local promotionType = GameInfo.UnitPromotions("Type ='" ..row.PromotionType.. "'")().ID
		MapModData.gPMMMAdjacentAllyBuffs[promotionType] =	{
				["Radius"] = row.Radius,
				["NewPromotionType"] = GameInfo.UnitPromotions("Type ='" ..row.AllyPromotionType.. "'")().ID
		}
	end

	--Which promotions grant a new promotion when an enemy is near?
	MapModData.gPMMMAdjacentEnemyBuffs = {}

	for row in GameInfo.Promotion_PMMM_GrantNewPromotionNearEnemy() do
		local promotionType = GameInfo.UnitPromotions("Type ='" ..row.PromotionType.. "'")().ID
		MapModData.gPMMMAdjacentEnemyBuffs[promotionType] =	{
				["Radius"] = row.Radius,
				["NewPromotionType"] = GameInfo.UnitPromotions("Type ='" ..row.NewPromotionType.. "'")().ID
		}
	end

	--Which promotions allow stealing other UU's promotions on city capture?
	MapModData.gPMMMStealUUPromotions = {}

	for row in GameInfo.UnitPromotions() do
		if row.ObtainUniqueUnitPromotionOnCityCapture == 1 then
			table.insert(MapModData.gPMMMStealUUPromotions, row.ID)
		end
	end


	--Which traits can have resources automatically spread during a Golden Age?
	MapModData.gPMMMGoldenAgeResources = {}

	for k, v in pairs(MapModData.gPMMMTraits) do
		local bIsTrait = false
		for row in GameInfo.Trait_PMMM_GoldenAgeResourceSpread() do
			if row.TraitType == v.Type then
				MapModData.gPMMMGoldenAgeResources[k] = {}
				bIsTrait = true
				break
			end
		end
		if bIsTrait then
			for row in GameInfo.Trait_PMMM_GoldenAgeResourceSpread() do 
				if row.TraitType == v.Type then
					table.insert(MapModData.gPMMMGoldenAgeResources[k], {["ResourceType"] = GameInfo.Resources("Type = '" ..row.ResourceType.. "'")().ID,
					["ProbabilityPerTurn"] = row.ProbabilityPerTurn	})
				end
			end
		end
	end

	--Which traits grant MGs unique missions?
	MapModData.gPMMMTraitMagicalGirlMissions = {}

	for k, v in pairs(MapModData.gPMMMTraits) do
		for row in GameInfo.Trait_PMMM_MagicalGirlExtraAbility() do
			if row.TraitType == v.Type then
				MapModData.gPMMMTraitMagicalGirlMissions[k] = {}
				bIsTrait = true
				break
			end
		end
		if bIsTrait then
			for row in GameInfo.Trait_PMMM_MagicalGirlExtraAbility() do 
				if row.TraitType == v.Type then
					table.insert(MapModData.gPMMMTraitMagicalGirlMissions[k], GameInfo.Missions("Type = '" ..row.MissionType.. "'")().ID)
				end
			end
		end
	end


	--v21: Which traits boost moodlets?
	MapModData.gPMMMTraitMoodBoosts = {}

	for k, v in pairs(MapModData.gPMMMTraits) do
		local bIsTrait = false
		for row in GameInfo.Trait_MoodModChanges() do
			if row.TraitType == v.Type then
				MapModData.gPMMMTraitMoodBoosts[k] = {}
				bIsTrait = true
				break
			end
		end
		if bIsTrait then
			for row in GameInfo.Trait_MoodModChanges() do 
				if row.TraitType == v.Type then
					table.insert(MapModData.gPMMMTraitMoodBoosts[k], {
						["Type"] = GameInfo.MG_MoodModifiers("Type = '" ..row.MoodModType.. "'")().ID,
						["Value"] = row.Modifier
					})
				end
			end
		end
	end


	--Which traits gain promotions for having enough adjacent differen unit combats?
	MapModData.gPMMMAdjacentUnitCombats = {}

	for k, v in pairs(MapModData.gPMMMTraits) do
		local bIsTrait = false
		for row in GameInfo.Trait_PMMM_PromotionAdjacentUnitCombats() do
			if row.TraitType == v.Type then
				MapModData.gPMMMAdjacentUnitCombats[k] = {}
				bIsTrait = true
				break
			end
		end
		if bIsTrait then
			for row in GameInfo.Trait_PMMM_PromotionAdjacentUnitCombats() do 
				if row.TraitType == v.Type then
					table.insert(MapModData.gPMMMAdjacentUnitCombats[k], {["AdjacentDifferentUnitCombatsRequired"] = row.AdjacentDifferentUnitCombatsRequired,
					["PromotionType"] = GameInfo.UnitPromotions("Type ='" ..row.PromotionType.. "'")().ID	})
				end
			end
		end
	end


	--What are the MG action states?
	MapModData.gPMMMActionStates = {}

	for row in GameInfo.MG_ActionStates() do
		MapModData.gPMMMActionStates[row.ID] = {
			["Type"] = row.Type,
			["Description"] = row.Description,
			["Turns"] = row.Turns
		}
	end

	--v27: Which promotions can reduce Soul Gem Corruption?
	MapModData.gPMMMSoulGemCorruptionPromotions = {}
	for row in GameInfo.UnitPromotions() do
		if row.SoulGemCorruptionMod ~= 0 then
			MapModData.gPMMMSoulGemCorruptionPromotions[row.ID] = row.SoulGemCorruptionMod
		end
	end


	--How much combat strength do Magical Girls, Witches, and Familiars have in each era? We find out by multiplying the strength of that era's strongest Melee/Gunpowder non-unique Unit
	--by 0.67/1.2/0.5 respectively, then rounding down to the nearest integer.
	MapModData.gPMMMMagicalGirlEraStrengths = {}
	MapModData.gPMMMWitchEraStrengths = {}
	MapModData.gPMMMFamiliarEraStrengths = {}
	MapModData.gPMMMIncubatorEraStrengths = {}


	for era in GameInfo.Eras() do
		local iHighestStrength = 1
		for unit in GameInfo.Units() do
			if unit.PrereqTech and unit.PrereqTech ~= 'NONE' and unit.PrereqTech ~= 'NULL' then
				if GameInfo.Technologies("Type ='" ..unit.PrereqTech.. "'")() ~= 'NONE' and GameInfo.Technologies("Type ='" ..unit.PrereqTech.. "'")() ~= 'NULL' then --i don't know why 'NONE' is a valid PrereqTech, but it's there and causes problems
					if GameInfo.Technologies("Type ='" ..unit.PrereqTech.. "'")().Era then
						if GameInfo.Technologies("Type ='" ..unit.PrereqTech.. "'")().Era == era.Type then
							if unit.CombatClass == 'UNITCOMBAT_MELEE' or unit.CombatClass == 'UNITCOMBAT_GUN' then
								if unit.Combat > iHighestStrength then
									local bIsUnique;
									for uniqueunit in GameInfo.Civilization_UnitClassOverrides() do
										if uniqueunit.UnitType == unit.Type then
											bIsUnique = true
											break
										end
									end
									if not bIsUnique then
										iHighestStrength = unit.Combat
									end
								end
							end
						end
					end
				end
			end
		end
		MapModData.gPMMMMagicalGirlEraStrengths[era.ID] = math.floor(iHighestStrength * (GameDefines.MAGICAL_GIRL_STRENGTH_PERCENT / 100))
		MapModData.gPMMMWitchEraStrengths[era.ID] = math.floor(iHighestStrength * (GameDefines.WITCH_STRENGTH_PERCENT / 100))
		MapModData.gPMMMFamiliarEraStrengths[era.ID] = math.floor(iHighestStrength * (GameDefines.FAMILIAR_STRENGTH_PERCENT / 100))
		MapModData.gPMMMIncubatorEraStrengths[era.ID] = math.floor(iHighestStrength * (GameDefines.INCUBATOR_STRENGTH_PERCENT / 100))
	end

	--What are all of the Soul Gem States?
	MapModData.gPMMMSoulGemStates = {}

	for state in GameInfo.MG_SoulGemStates() do
		MapModData.gPMMMSoulGemStates[state.ID] = {
			["Description"] = state.Description,
			["MinPercent"] = state.MinPercent,
			["MaxPercent"] = state.MaxPercent,
			["Promotion"] = GameInfo.UnitPromotions("Type ='" ..state.Promotion.. "'")().ID,
			["CanBecomeWitch"] = state.CanBecomeWitch
		}
	end

	--How much of a percentage is recovered from a Grief Seed?
	--Starts at 40%, and varies by game speed and game options.
	local iStartingGriefSeedAmount = GameDefines.BASE_GRIEF_SEED_RECOVER_AMOUNT
	local iBarbMultiplier = GameInfo.GameSpeeds[Game.GetGameSpeedType()].BarbPercent / 100
	local bIsRagingBarbs = Game.IsOption(GameOptionTypes.GAMEOPTION_RAGING_BARBARIANS)
	local bIsNoBarbs = Game.IsOption(GameOptionTypes.GAMEOPTION_NO_BARBARIANS)
	local iRagingBarbMultiplier
	local iNoBarbsMultiplier
	if bIsRagingBarbs then
		iRagingBarbMultiplier = GameDefines.GRIEF_SEED_RAGING_BARBS_PERCENT / 100
	else
		iRagingBarbMultiplier = 1
	end
	if bIsNoBarbs then
		iNoBarbsMultiplier = GameDefines.GRIEF_SEED_NO_BARBS_PERCENT / 100
	else
		iNoBarbsMultiplier = 1
	end
	MapModData.gPMMMGriefSeedRecoverAmount = math.min(math.floor(iStartingGriefSeedAmount * iBarbMultiplier * iRagingBarbMultiplier * iNoBarbsMultiplier), 100)

	--How much XP from Witch's Labyrinths?
	MapModData.gPMMMWitchBarrierXP = GameDefines.WITCH_BARRIER_XP_GAIN

	--How many turns does it take for the Law of Cycles to rebirth a Magical Girl? (1/3 of the Deal Duration, rounded up)
	MapModData.gPMMMLawOfCyclesTurns = math.ceil(GameInfo.GameSpeeds[Game.GetGameSpeedType()].DealDuration * (GameDefines.LAW_OF_CYCLES_DEAL_DURATION_PERCENT / 100))


	--Generic Magical Girl name list to give to GPs which spawn without a name
	MapModData.gPMMMGenericMGNames = {}

	for row in GameInfo.MG_GenericNames() do
		MapModData.gPMMMGenericMGNames[row.ID] = row.TextKey
	end


	--Witch Names
	MapModData.gPMMMGenericWitchNames = {}

	for row in GameInfo.Witch_GenericNames() do
		MapModData.gPMMMGenericWitchNames[row.ID] = row.TextKey
	end


	-- MG Icon Builder: Default Icon to use if there is an error with the icon builder
	MapModData.gPMMMDefaultMGOverrideIcon = {"CIV_COLOR_ATLAS_MADOKA", 6}

	-- Background image for Icon Builder
	MapModData.gPMMMIconBuilderBackground = {"PMMM_ICON_BUILDER_BACKGROUND_ATLAS", 0}


	--Variable to state whether all of the above values have been cached already. When set to true, this function will not run a second time regardless of whether or not the game is reloaded
	PMMM.ConversionDataInit = true
end