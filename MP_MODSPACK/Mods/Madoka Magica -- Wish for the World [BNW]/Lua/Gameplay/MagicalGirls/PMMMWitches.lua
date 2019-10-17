------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PMMMWitches.lua
-- Author: Vicevirtuoso
-- DateCreated: 12/18/2014 12:37:00 PM
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local iWitchType = GameInfoTypes.UNIT_PMMM_WITCH
local iSeaWitchType = GameInfoTypes.UNIT_PMMM_SEA_WITCH
local iFamiliarType = GameInfoTypes.UNIT_PMMM_FAMILIAR
local iSeaFamiliarType = GameInfoTypes.UNIT_PMMM_SEA_FAMILIAR
local iIncubatorType = GameInfoTypes.UNIT_PMMM_INCUBATOR

local iMagicalGirlClass = GameInfoTypes.UNITCLASS_PMMM_MAGICAL_GIRL

local iRecluseVillain = GameInfoTypes.UNIT_RECLUSE_VILLAIN or -2 --Compatibility with Lord Recluse's Civ, value is -2 if it's not loaded

local iBarbCamp = GameInfoTypes.IMPROVEMENT_BARBARIAN_CAMP

local iIncubatorChance = GameDefines.INCUBATOR_SPAWN_CHANCE
local iImmuneToTruth = GameInfoTypes.PROMOTION_PMMM_IMMUNE_TO_TRUTH  --also used for Incubators to detect if they were created on a previous turn


local iTurnsNeededForWitch = math.floor(GameDefines.FAMILIAR_CONVERSION_TO_WITCH_TURNS * (GameInfo.GameSpeeds[PreGame:GetGameSpeed()].TrainPercent / 100))


function ReplaceHostileUnits(iPlayer, iUnit, iUnitType)
	if iPlayer == iMaxCivsAndCS and iUnitType ~= iWitchType and iUnitType ~= iFamiliarType and iUnitType ~= iSeaWitchType and iUnitType ~= iSeaFamiliarType and iUnitType ~= iIncubatorType then
		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iUnit)
		if pUnit:IsCombatUnit() then
			if iRecluseVillain > -2 and pUnit:GetUnitType() == iRecluseVillain then return end --Recluse's villains aren't replaced in the COH Civpack
			local pPlot = pUnit:GetPlot()
			local iCurrentEra = Game:GetCurrentEra()
			local sPlotKey = pPlot:GetX()..":"..pPlot:GetY() --get a unique string from the plot's X and Y concatenated to use for the key in the global table (pPlot wouldn't work)
			local iStrengthMod
			local iNewUnitType
			--New units spawning inside a Witch's Labyrinth (aka a Camp) will instantly be Witches if the tile has not yet spawned a Witch in this way.
			if pPlot:GetImprovementType() == iBarbCamp and not PMMM.WitchBarrierSpawnedWitchPlots[sPlotKey] then
				iNewUnitType = iWitchType
				PMMM.WitchBarrierSpawnedWitchPlots[sPlotKey] = true
			else
				if pPlot:IsWater() then
					iNewUnitType = iSeaFamiliarType
				else
					--v21: chance the unit is an Incubator.
					if (Game.Rand(99, "PMMM Hostile Incubator Spawn Roll") + 1) <= iIncubatorChance then
						iNewUnitType = iIncubatorType
					else	
						iNewUnitType = iFamiliarType
					end
				end
			end
			pUnit:Kill(true)
			local pNewUnit = pPlayer:InitUnit(iNewUnitType, pPlot:GetX(), pPlot:GetY(), UNITAI_ATTACK)
			if iNewUnitType == iWitchType or iNewUnitType == iSeaWitchType then
				iStrengthMod = MapModData.gPMMMWitchEraStrengths[iCurrentEra]
			elseif iNewUnitType == iFamiliarType or iNewUnitType == iSeaFamiliarType then
				iStrengthMod = MapModData.gPMMMFamiliarEraStrengths[iCurrentEra]
			elseif iNewUnitType == iIncubatorType then
				iStrengthMod = MapModData.gPMMMIncubatorEraStrengths[iCurrentEra]
			end
			if iStrengthMod then
				pNewUnit:SetBaseCombatStrength(iStrengthMod)
			end
		end
	else
		--Handler for if a Witch or Familiar is given to a human player and their strength wasn't already set. Adjust strength accordingly.
		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iUnit)
		local iCurrentEra = pPlayer:GetCurrentEra()
		if (iUnitType == iWitchType or iUnitType == iSeaWitchType) and pUnit:GetBaseCombatStrength() < MapModData.gPMMMWitchEraStrengths[iCurrentEra] then
			pUnit:SetBaseCombatStrength(MapModData.gPMMMWitchEraStrengths[iCurrentEra])
		elseif (iUnitType == iFamiliarType or iUnitType == iSeaFamiliarType) and pUnit:GetBaseCombatStrength() < MapModData.gPMMMFamiliarEraStrengths[iCurrentEra] then
			pUnit:SetBaseCombatStrength(MapModData.gPMMMFamiliarEraStrengths[iCurrentEra])
		elseif iUnitType == iIncubatorType and iPlayer ~= iMaxCivsAndCS then
			--Players should never have Incubators.
			pUnit:Kill(true)
		elseif iUnitType == iIncubatorType or iUnitType == GameInfoTypes.UNIT_PMMM_ARTIFICIAL_INCUBATOR then
			pUnit:SetBaseCombatStrength(MapModData.gPMMMIncubatorEraStrengths[iCurrentEra])
		end

		--v25: Witches Get Named
		if (iUnitType == iWitchType or iUnitType == iSeaWitchType) and not pUnit:HasName() then
			local tNameTable = {}
			local tReverseTable = {} --to lookup the name that gets chosen so it can be set as in-use
			for k, v in pairs(MapModData.gPMMMGenericWitchNames) do
				if not PMMM.UsedGenericWitchNames[k] then
					tNameTable[#tNameTable + 1] = v
					tReverseTable[v] = k
				end
			end
			if #tNameTable > 0 then
				local iChosenName = Game.Rand(#tNameTable, "Random Witch Name Roll") + 1
				pUnit:SetName(tNameTable[iChosenName])
				local iTableKey = tReverseTable[tNameTable[iChosenName]]
				PMMM.UsedGenericWitchNames[iTableKey] = true
			end
		end
	end
end


--Loop over all Hostile units. If a Familiar has existed for 30 turns(Standard speed), it becomes a Witch.
--As of v20, will convert Civilians to new Witches if they start their turn in a Barrier
function UpgradeFamiliarToWitch(iPlayer)
	if not iPlayer then
		iPlayer = iMaxCivsAndCS
	end
	if iPlayer == iMaxCivsAndCS then
		local pPlayer = Players[iPlayer]
		for pUnit in pPlayer:Units() do
			local pPlot = pUnit:GetPlot()
			local iThisTurn = Game.GetGameTurn()
			local iX = pUnit:GetX()
			local iY = pUnit:GetY()
			--Familiar upgrading
			if pUnit:GetUnitType() == iFamiliarType or pUnit:GetUnitType() == iSeaFamiliarType then
				local iCreationTurn = pUnit:GetGameTurnCreated()
				if (iThisTurn - iCreationTurn) >= iTurnsNeededForWitch then
					local iCurrentEra = Game:GetCurrentEra()	
					pUnit:Kill(true)
					local iNewType;
					if pPlot:IsWater() then
						iNewType = iSeaWitchType
					else
						iNewType = iWitchType
					end
					pNewUnit = pPlayer:InitUnit(iNewType, iX, iY, UNITAI_ATTACK)
					pNewUnit:SetBaseCombatStrength(MapModData.gPMMMWitchEraStrengths[iCurrentEra])
				end
			end

			--Witch's Labyrinth tracking, since there isn't a "Barb Camp Cleared" event.
			if pPlot:GetImprovementType() == iBarbCamp then
				local sPlotKey = pPlot:GetX()..":"..pPlot:GetY()
				if not PMMM.WitchBarrierStartTracking[sPlotKey] then
					PMMM.WitchBarrierStartTracking[sPlotKey] = iThisTurn
					--v20: If there is a civilian unit captured by the Witches in the barrier, it turns into a new Witch!
					if not pUnit:IsCombatUnit() then
						local pCivilianWitch = pPlayer:InitUnit(iWitchType, pPlot:GetX(), pPlot:GetY(), UNITAI_ATTACK)
						pCivilianWitch:JumpToNearestValidPlot()
						pCivilianWitch:SetBaseCombatStrength(MapModData.gPMMMWitchEraStrengths[iCurrentEra])
						pUnit:Kill(true)
					end
				end
			end

			--v21:Incubators
			if pUnit:GetUnitType() == iIncubatorType then
				--Grant them the promotion to enable Emotional Abuse if they were not created this turn.
				if pUnit:GetGameTurnCreated() ~= Game:GetGameTurn() then
					pUnit:SetHasPromotion(iImmuneToTruth, true)
					--Check if they're near a MG, and if so, hit them with Emotional Abuse!
					for pAreaPlot in PlotAreaSpiralIterator(pUnit:GetPlot(), 1) do
						if pAreaPlot:IsUnit() then
							for i = 0, pAreaPlot:GetNumUnits() - 1 do
								local pEnemyUnit = pAreaPlot:GetUnit(i)
								if pEnemyUnit:GetOwner() ~= iPlayer and pEnemyUnit:GetUnitClassType() == iMagicalGirlClass then
									local iMGKey = GetMagicalGirlKey(pEnemyUnit:GetOwner(), pEnemyUnit:GetID())
									if iMGKey then
										DoIncubatorEmotionalAbuse(iPlayer, pUnit, pAreaPlot)
									end
								end
							end
						end	
					end
				end
			end
		end
	end
end

function OnUnitSetXYCheckEmotionalAbuse(iPlayer, iUnit, iX, iY)
	if iX > 0 and iY > 0 and iPlayer == iMaxCivsAndCS then 
		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iUnit)
		if pUnit:GetUnitType() == iIncubatorType and pUnit:GetMoves() > 0 and pUnit:IsHasPromotion(iImmuneToTruth) then
			for pAreaPlot in PlotAreaSpiralIterator(pUnit:GetPlot(), 1) do
				if pAreaPlot:IsUnit() then
					for i = 0, pAreaPlot:GetNumUnits() - 1 do
						local pEnemyUnit = pAreaPlot:GetUnit(i)
						if pEnemyUnit:GetOwner() ~= iPlayer and pEnemyUnit:GetUnitClassType() == iMagicalGirlClass then
							local iMGKey = GetMagicalGirlKey(pEnemyUnit:GetOwner(), pEnemyUnit:GetID())
							if iMGKey then
								DoIncubatorEmotionalAbuse(iPlayer, pUnit, pAreaPlot)
								return
							end
						end
					end
				end	
			end
		end
	end
end


--Time for QB to be a dick!
function DoIncubatorEmotionalAbuse(iPlayer, pIncubator, pPlot)
	dprint("DoIncubatorEmotionalAbuse")
	local iTurn = Game:GetGameTurn()
	for i = 0, pPlot:GetNumUnits() - 1 do
		local pUnit = pPlot:GetUnit(i)
		if pUnit:GetUnitClassType() == iMagicalGirlClass then
			dprint("Magical Girl")
			local iOwner = pUnit:GetOwner()
			local pOwner = Players[iOwner]
			local iMGKey = GetMagicalGirlKey(iOwner, pUnit:GetID())
			if iMGKey then
				dprint("MG Key "..iMGKey)
				if not MagicalGirls[iMGKey].EmotionalAbuses then MagicalGirls[iMGKey].EmotionalAbuses = {} end
				MagicalGirls[iMGKey].EmotionalAbuses[#MagicalGirls[iMGKey].EmotionalAbuses + 1] = Game:GetGameTurn()
				local bRevealedTruth = false
				if not pUnit:IsHasPromotion(GameInfoTypes.PROMOTION_PMMM_IMMUNE_TO_TRUTH) and PMMM.NumMGsTurnedToWitch[iOwner] and PMMM.NumMGsTurnedToWitch[iOwner] > 0 then
					local iThreshold = PMMM.NumMGsTurnedToWitch[iOwner] * GameDefines.INCUBATOR_CHANCE_OF_REVEALING_TRUTH
					if (Game.Rand(99, "PMMM Incubator Reveal Truth Roll") + 1) <= iThreshold then
						MagicalGirls[iMGKey].TruthDiscoveredTurn = iTurn
						bRevealedTruth = true
					end
				end
				local sTitle;
				local sText
				if bRevealedTruth then
					sTitle = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_REVEALED_TRUTH_TITLE")
					sText = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_INCUBATOR_REVEALED_TRUTH_TEXT", Locale.ConvertTextKey(MagicalGirls[iMGKey].Name))
				else
					sTitle = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_INCUBATOR_EMOTIONAL_ABUSE_TITLE")
					sText = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_INCUBATOR_EMOTIONAL_ABUSE_TEXT", Locale.ConvertTextKey(MagicalGirls[iMGKey].Name))
				end
				pOwner:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, sText, sTitle, pUnit:GetX(), pUnit:GetY())
				pIncubator:Kill(true)
				return
			end
		end
	end
end


--QBs deal no damage even if melee attacked. This is accomplished by healing it back.
--To save space, this also does the same thing when attacking Time-Frozen units
function OnCombatEndedRecoverQBDamage(iAttackingPlayer, iAttackingUnit, attackerDamage, attackerFinalDamage, attackerMaxHP, iDefendingPlayer, iDefendingUnit, defenderDamage, defenderFinalDamage, defenderMaxHP, iInterceptingPlayer, iInterceptingUnit, interceptorDamage, plotX, plotY)
	local pAttackingPlayer = Players[iAttackingPlayer]
	local pDefendingPlayer = Players[iDefendingPlayer]
	if pAttackingPlayer and pDefendingPlayer then
		local pAttackingUnit = pAttackingPlayer:GetUnitByID(iAttackingUnit)
		local pDefendingUnit = pDefendingPlayer:GetUnitByID(iDefendingUnit)
		if pAttackingUnit and pDefendingUnit then
			local sAttackingType = GameInfo.Units[pAttackingUnit:GetUnitType()].Type
			local sDefendingType = GameInfo.Units[pDefendingUnit:GetUnitType()].Type
			if (string.find(sAttackingType, "_PMMM_") and string.find(sAttackingType, "INCUBATOR")) or HasAnyTimeStopPromo(pAttackingUnit) then
				pDefendingUnit:ChangeDamage(-defenderDamage)
				if iDefendingPlayer == Game:GetActivePlayer() then
					Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_PMMM_ALERT_INCUBATOR_DAMAGE_HEALED"))
				end
			elseif (string.find(sDefendingType, "_PMMM_") and string.find(sDefendingType, "INCUBATOR")) or HasAnyTimeStopPromo(pDefendingUnit) then
				pAttackingUnit:ChangeDamage(-attackerDamage)
				if iAttackingPlayer == Game:GetActivePlayer() then
					Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_PMMM_ALERT_INCUBATOR_DAMAGE_HEALED"))
				end
			end
		end
	end
end

--Grant a Grief Seed to whomever kills a Witch
--Currently, this does not care about the Witch owner, so if a player kills a UMadoka Witch, they'll get one.
--This is currently WAI, but may be changed for balance later.
function GetGriefSeed(iKillerPlayer, iKilledPlayer, iKilledUnitType)
	if (iKilledUnitType == iWitchType or iKilledUnitType == iSeaWitchType) and iKillerPlayer < iMaxCivsAndCS then
		local pPlayer = Players[iKillerPlayer]
		--Demon Homura gets Golden Age points instead of Grief Seeds
		if MapModData.gPMMMTraits[iKillerPlayer] and (MapModData.gPMMMTraits[iKillerPlayer].NoMagicalGirls == true or MapModData.gPMMMTraits[iKillerPlayer].NoMagicalGirls == 1) then
			pPlayer:ChangeGoldenAgeProgressMeter(GameDefines.GOLDEN_AGE_POINTS_FROM_NO_WITCH_TRAIT_KILLING_WITCH)
			pPlayer:AddMessage(Locale.ConvertTextKey("TXT_KEY_PMMM_ALERT_KILLED_WITCH_DEMON_HOMURA", GameDefines.GOLDEN_AGE_POINTS_FROM_NO_WITCH_TRAIT_KILLING_WITCH))
			
			
		else
			if PMMM.GriefSeeds[iKillerPlayer] then
				PMMM.GriefSeeds[iKillerPlayer] = PMMM.GriefSeeds[iKillerPlayer] + 1
			else
				PMMM.GriefSeeds[iKillerPlayer] = 1
			end
			Players[iKillerPlayer]:AddMessage(Locale.ConvertTextKey("TXT_KEY_PMMM_ALERT_KILLED_WITCH"))
			LuaEvents.PMMMRefreshGriefSeedDisplay()
		end
		
		--v19: Halicarnassus grants gold from Witch corpses instead of its regular effect (mostly for flavor)
		if pPlayer:HasWonder(GameInfoTypes.BUILDING_MAUSOLEUM_HALICARNASSUS) then
			pPlayer:ChangeGold(iHalicarnassusGold)
		end
		
	end
end


--XP Bonus from Witch's Labyrinths
function CheckDestroyWitchBarrier(iPlayer, iUnit, iX, iY)
	if iPlayer < iMaxCivs then
		local sPlotKey = iX..":"..iY
		if PMMM.WitchBarrierStartTracking[sPlotKey] then
			local pPlayer = Players[iPlayer]
			local pUnit = pPlayer:GetUnitByID(iUnit)
			local iXPGained = MapModData.gPMMMWitchBarrierXP
			if MapModData.gPMMMTraits[iPlayer].WitchBarrierXPMultiplier then
				if MapModData.gPMMMTraits[iPlayer].WitchBarrierXPMultiplier ~= 0 then
					iXPGained = iXPGained * MapModData.gPMMMTraits[iPlayer].WitchBarrierXPMultiplier
				end
			end
			pUnit:ChangeExperience(iXPGained)
			--v23: Remove the Gold gained from clearing the Labyrinth. Can't set the gold to 0 in the DB, because that causes CTDs! :/
			pPlayer:ChangeGold(-1)
			--Bismarck trait
			if MapModData.gPMMMTraits[iPlayer].ConvertNearbyFamiliarRadius > 0 then
				local pPlot = pUnit:GetPlot()
				local bGotAnyFamiliars;
				for pAreaPlot in PlotAreaSpiralIterator(pPlot, MapModData.gPMMMTraits[iPlayer].ConvertNearbyFamiliarRadius, 1, false, false, false) do 
					if pAreaPlot:IsUnit() then
						for c = 0, pAreaPlot:GetNumUnits() - 1 do
							local pPlotUnit = pAreaPlot:GetUnit(c)
							if pPlotUnit then
								if pPlotUnit ~= pUnit and pPlotUnit:GetOwner() == iMaxCivsAndCS and pPlotUnit:GetUnitClassType() == GameInfoTypes.UNITCLASS_PMMM_FAMILIAR then
									local iStrength = pPlotUnit:GetBaseCombatStrength()
									local iType = pPlotUnit:GetUnitType()
									pPlotUnit:Kill(true)
									local eFamiliar = pPlayer:InitUnit(iType, pAreaPlot:GetX(), pAreaPlot:GetY(), UNITAI_ATTACK)
									if pAreaPlot:IsWater() and iType ~= iSeaFamiliarType then
										eFamiliar:Embark(pAreaPlot)
									end
									eFamiliar:SetBaseCombatStrength(iStrength)
									eFamiliar:SetMoves(0)
									bGotAnyFamiliars = true
								end
							end
						end
					end
				end
				if bGotAnyFamiliars then
					pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_CONVERTED_FAMILIARS_TEXT"), Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_CONVERTED_FAMILIARS_TITLE"), iX, iY)
				end
			end
			PMMM.WitchBarrierStartTracking[sPlotKey] = nil
		end
	end
end


--Handles the Hidden Witch spawns and their effects.

local iNeededEra =  GameInfo.Eras("Type ='" ..GameDefines.HIDDEN_WITCH_START_SPAWNING_ERA.. "'")().ID
local bIsNoBarbarians = Game.IsOption(GameOptionTypes.GAMEOPTION_NO_BARBARIANS)
local iTurnsBetween = GameDefines.TURNS_BETWEEN_HIDDEN_WITCH_SPAWNS
local iWitchHuntMission = GameInfoTypes.MISSION_PMMM_WITCH_HUNT

function HiddenWitchSpawn(iPlayer)

	local pPlayer = Players[iPlayer]
	
	if not PMMM.CurrentHiddenWitches[iPlayer] then
		PMMM.CurrentHiddenWitches[iPlayer] = 0
	end
	
	--Every turn, subtract Food Storage from every City which is being harassed by a HW
	if PMMM.CurrentHiddenWitches[iPlayer] > 0 then
		dprint("Player " ..iPlayer.. " has a Hidden Witch, hurt the city near it")
		for k, v in pairs(PMMM.HiddenWitchCities) do
			local pPlot = ReturnPlotFromSpecialID(k)
			local pCity = pPlot:GetPlotCity()
			if pCity then
				if pCity:GetOwner() == iPlayer then
					local iFoodReduction = pCity:GrowthThreshold() * (GameDefines.HIDDEN_WITCH_GROWTH_PROGRESS_REMOVED_PER_TURN / 100)
					--Will loop as long as the iFoodReduction is greater than 0, to allow for multiple Citizens to be killed off at once
					local bFirstLoop = true;
					while iFoodReduction > 0 do
						pCity:ChangeFood(-1 * iFoodReduction)
						if bFirstLoop then
							pCity:AddMessage(Locale.ConvertTextKey("TXT_KEY_PMMM_ALERT_HW_FOOD_REDUCTION", pCity:GetName(), iFoodReduction), iPlayer)
						end
						iFoodReduction = 0
						--If the growth is now negative, adjust it to kill off a Citizen
						if pCity:GetFood() < 0 then
							--If the city only has 1 Pop, just set it to 0 and stop the loop
							if pCity:GetPopulation() <= 1 then
								pCity:SetFood(0)
								break
							else
								iFoodReduction = -1 * pCity:GetFood()
								pCity:ChangePopulation(-1, true)
								pCity:SetFood(pCity:GrowthThreshold())
								pCity:AddMessage(Locale.ConvertTextKey("TXT_KEY_PMMM_ALERT_HW_CITIZEN_KILLED", pCity:GetName()), iPlayer)
							end
						end
						bFirstLoop = false
					end
				end
			end
		end
	end
	
	--Clean up any Cities which aren't there anymore
	for k, v in pairs(PMMM.HiddenWitchCities) do
		local pPlot = ReturnPlotFromSpecialID(k)
		local pCity = pPlot:GetPlotCity()
		if not pCity then
			PMMM.HiddenWitchPlots[v] = nil
			PMMM.HiddenWitchCities[k] = nil
		end
	end

	--Only do the rest every number of turns equal to the TURNS_BETWEEN_HIDDEN_WITCH_SPAWNS define.
	if Game:GetGameTurn() % iTurnsBetween == 0 then
		
		if PMMM.IsSpawningHiddenWitches then
			--Find out how many hidden witches they already have, and compare it to the maximum they should have.
			local iMaximumHWs = 0;
			if not pPlayer:IsMinorCiv() and iPlayer ~= GameDefines.MAX_CIV_PLAYERS then
				if MapModData.gPMMMTraits[iPlayer].NoWitches == true or MapModData.gPMMMTraits[iPlayer].NoWitches == 1 or MapModData.gPMMMTraits[iPlayer].NoWitches == 1 or MapModData.gPMMMTraits[iPlayer].NoMagicalGirls == true or MapModData.gPMMMTraits[iPlayer].NoMagicalGirls == 1 then
					iMaximumHWs = 0
				else
					iMaximumHWs = GameDefines.HIDDEN_WITCH_SPAWN_MINIMUM_NUMBER_OF_WITCHES_PER_MAJOR_PLAYER + math.floor(pPlayer:GetNumCities() / GameDefines.HIDDEN_WITCH_SPAWN_NUMBER_OF_CITIES_NEEDED_PER_EXTRA_WITCH)
				end
			elseif iPlayer ~= GameDefines.MAX_CIV_PLAYERS then
				iMaximumHWs = GameDefines.HIDDEN_WITCH_SPAWN_MAXIMUM_NUMBER_OF_WITCHES_PER_MINOR_PLAYER
			end
			

			if PMMM.CurrentHiddenWitches[iPlayer] < iMaximumHWs then
				if not pPlayer:IsMinorCiv() then
					--For majors: loop through a player's Cities to see if a hidden Witch will spawn near it.
					for pCity in pPlayer:Cities() do
						--Don't spawn a second one if the City is already being harassed by a HW
						local iSpecialID = GetUnitSpecialID(pCity:GetX(), pCity:GetY())
						if not PMMM.HiddenWitchCities[iSpecialID] then
							local iChance = Game.Rand(99, "Hidden Witch Chance Roll") + 1
							print("Spawn roll: "..iChance..", needs to be less than or equal to " ..GameDefines.HIDDEN_WITCH_SPAWN_CHANCE_PERCENT_PER_CITY)
							if iChance <= GameDefines.HIDDEN_WITCH_SPAWN_CHANCE_PERCENT_PER_CITY then
								--Hidden Barriers are always on passable land plots. If, for whatever reason, the City has no plots in its range which meet that criteria, just don't spawn it.

								local iNumPlots = pCity:GetNumCityPlots();
								local ValidPlots = {}
								for iPlot = 0, iNumPlots - 1 do
									local pPlot = pCity:GetCityIndexPlot(iPlot)
									--Update 8/11/2014: Do not spawn the HWB in other players' territories; it must either be in the City owner's territory or in neutral territory
									if pPlot:GetOwner() == iPlayer or pPlot:GetOwner() < 0 then
										if not pPlot:IsImpassable() and not pPlot:IsMountain() and not pPlot:IsWater() and not pPlot:IsCity() then
											--Also don't make it one that happens to already be a HW plot (can easily happen due to city radius overlap)
											local iPlotSpecialID = GetUnitSpecialID(pPlot:GetX(), pPlot:GetY())
											if not PMMM.HiddenWitchPlots[iPlotSpecialID] then
												ValidPlots[#ValidPlots + 1] = pPlot
											end
										end
									end
								end
								if #ValidPlots > 0 then
									local iChosenPlot = Game.Rand(#ValidPlots, "Hidden Witch Plot Roll") + 1
									local pSpawnPlot = ValidPlots[iChosenPlot]
									local iPlotSpecialID = GetUnitSpecialID(pSpawnPlot:GetX(), pSpawnPlot:GetY())
									PMMM.HiddenWitchPlots[iPlotSpecialID] = iSpecialID
									PMMM.HiddenWitchCities[iSpecialID] = iPlotSpecialID
									PMMM.CurrentHiddenWitches[iPlayer] = PMMM.CurrentHiddenWitches[iPlayer] + 1

									local sText = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_HIDDEN_WITCH_SPAWNED_TEXT", pCity:GetName(), GameDefines.HIDDEN_WITCH_GROWTH_PROGRESS_REMOVED_PER_TURN)
									local sTitle = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_HIDDEN_WITCH_SPAWNED_TITLE", pCity:GetName())
									pPlayer:AddNotification(NotificationTypes.NOTIFICATION_ENEMY_IN_TERRITORY, sText, sTitle, pCity:GetX(), pCity:GetY(), iWitch)
								end
							end
						end
					end
				else
					--For minors: Only test for the Minor's Capital (usually their only City, but they are certainly capable of having more). Also send a notification to Majors.
					local pCity = pPlayer:GetCapitalCity()
					if pCity then
						local iSpecialID = GetUnitSpecialID(pCity:GetX(), pCity:GetY())
						if not PMMM.HiddenWitchCities[iSpecialID] then
							local iChance = Game.Rand(99, "Hidden Witch Chance Roll") + 1
							if iChance <= GameDefines.HIDDEN_WITCH_SPAWN_CHANCE_PERCENT_CITY_STATE then
								--Hidden Barriers are always on passable land plots. If, for whatever reason, the City has no plots in its range which meet that criteria, just don't spawn it.

								local iNumPlots = pCity:GetNumCityPlots();
								local ValidPlots = {}
								for iPlot = 0, iNumPlots - 1 do
									local pPlot = pCity:GetCityIndexPlot(iPlot)
									--Update 8/11/2014: Do not spawn the HWB in other players' territories; it must either be in the City owner's territory or in neutral territory
									if pPlot:GetOwner() == iPlayer or pPlot:GetOwner() < 0 then
										if not pPlot:IsImpassable() and not pPlot:IsWater() and not pPlot:IsCity() then
											--Also don't make it one that happens to already be a HW plot (can easily happen due to city radius overlap)
											local iPlotSpecialID = GetUnitSpecialID(pPlot:GetX(), pPlot:GetY())
											if not PMMM.HiddenWitchPlots[iPlotSpecialID] then
												ValidPlots[#ValidPlots + 1] = pPlot
											end
										end
									end
								end
								if #ValidPlots > 0 then
									local iChosenPlot = Game.Rand(#ValidPlots, "Hidden Witch Plot Roll") + 1
									local pSpawnPlot = ValidPlots[iChosenPlot]
									local iPlotSpecialID = GetUnitSpecialID(pSpawnPlot:GetX(), pSpawnPlot:GetY())
									--The HiddenWitchPlots and HiddenWitchCities contain values for the IDs of the City and Plot respectively for easy cross-referencing
									PMMM.HiddenWitchPlots[iPlotSpecialID] = iSpecialID
									PMMM.HiddenWitchCities[iSpecialID] = iPlotSpecialID
									PMMM.CurrentHiddenWitches[iPlayer] = PMMM.CurrentHiddenWitches[iPlayer] + 1

									local sText = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_HIDDEN_WITCH_SPAWNED_CITY_STATE_TEXT", pPlayer:GetCivilizationShortDescription())
									local sTitle = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_HIDDEN_WITCH_SPAWNED_CITY_STATE_TITLE", pPlayer:GetCivilizationShortDescription())
									for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
										local pNotifyPlayer = Players[i]
										local pNotifyTeam = Teams[pNotifyPlayer:GetTeam()]
										if pNotifyTeam:IsHasMet(pPlayer:GetTeam()) then
											pNotifyPlayer:AddNotification(NotificationTypes.NOTIFICATION_MINOR_QUEST, sText, sTitle, pCity:GetX(), pCity:GetY())
										end
									end
								end
							end
						end
					end
				end
			end

		--If the "HWs are On" flag is not active, then determine if we should turn it on.
		--This will only begin to trigger past the Renaissance Era (by default, can be changed in Defines), OR it will trigger always if No Barbarians is on.
		elseif Game:GetCurrentEra() >= iNeededEra or bIsNoBarbarians then
			
			--Once the game era is in the defined Era when No Barbarians is NOT on, we will need to count up how many Witch's Labyrinths are on the map and compare it to the map size.
			if not bIsNoBarbarians then
				--Rather than iterate over every plot, we will just use the Witch's Labyrinth tracking table to see how many are there.
				local iNumBarriers = 0;
				for k, v in pairs(PMMM.WitchBarrierStartTracking) do
					iNumBarriers = iNumBarriers + 1
				end
				--The threshold for number of barriers is equal to 0.1% of the total number of plots on the map by default.
				--If the existing barriers are less than the threshold, begin spawning hidden witches.
				--Or, always start it if there are less than 1000 plots on the map (i.e. the threshold is 0).
				local iBarrierThreshold = math.floor(Map:GetNumPlots() * (GameDefines.HIDDEN_WITCH_START_SPAWNING_BARRIER_THRESHOLD_X1000 / 1000))
				if (iNumBarriers < iBarrierThreshold) or (iBarrierThreshold <= 0) then
					sText = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_HIDDEN_WITCHES_STARTING_TEXT")
					sTitle = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_HIDDEN_WITCHES_STARTING_TITLE")
					pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, sText, sTitle, -1, -1)
					PMMM.IsSpawningHiddenWitches = true
				end
			else --No Barbarians is on, so have Hidden Witches spawning from the beginning, and don't bother with the notification
				PMMM.IsSpawningHiddenWitches = true
			end
		end
	end

	--v21: If spawning hidden witches, then Incubators can randomly spawn.
	if PMMM.IsSpawningHiddenWitches then
		if (Game.Rand(99, "PMMM Hostile Incubator Spawn Roll") + 1) <= iIncubatorChance then
			--for speed, just use the player's starting plot
			local pPlot = pPlayer:GetStartingPlot()
			local iRadius = 8 - (Game.Rand(4, "PMMM Hostile Incubator Plot Roll") - 2)
			if pPlot then
				local tPlots = {}
				for pAreaPlot in PlotRingIterator(pPlot, iRadius) do
					if not pAreaPlot:IsUnit() and not pAreaPlot:IsCity() and not pAreaPlot:IsImpassable() and not pAreaPlot:IsMountain() and not pAreaPlot:IsWater() then
						tPlots[#tPlots + 1] = pAreaPlot
					end
				end
				local pSpawnPlot = tPlots[Game.Rand(#tPlots, "PMMM Hostile Incubator Plot Roll") + 1]
				Players[63]:InitUnit(iIncubatorType, pSpawnPlot:GetX(), pSpawnPlot:GetY(), UNITAI_ATTACK)
			end
		end
	end
	
	--AI Logic
	if PMMM.IsSpawningHiddenWitches and not pPlayer:IsHuman() and not pPlayer:IsMinorCiv() and pPlayer:IsAlive() and iPlayer ~= GameDefines.MAX_CIV_PLAYERS then
		dprint("AI Logic check for Witch Hunt")
		local iImportance = 0
		--If the AI has a HWB in its own territory, it will designate up to 3 Magical Girls to go hunt it down. Only do this if they haven't already done it in a previous turn.
		if PMMM.CurrentHiddenWitches[iPlayer] > 0 and not PMMM.AIAssignedWitchHunters[iPlayer] then
			iImportance = 2
		--If there are no HWBs in their territory, they'll look through the minors to see if any of them have HWBs, then head after them.
		elseif not PMMM.AIAssignedWitchHunters[iPlayer] then
			iImportance = 1
		end
		
		if iImportance > 0 then
			local iNumGirlsChosen = 0;
			local pCity;
			local ValidPlots = {}
			--It will only choose the first City in the table for simplicity, if it has more than one city with a HWB.
			for k, v in pairs(PMMM.HiddenWitchCities) do
				local pCityPlot = ReturnPlotFromSpecialID(k)
				local pTestCity = pCityPlot:GetPlotCity()
				if iImportance == 2 then
					if pTestCity:GetOwner() == iPlayer then
						pCity = pTestCity
						break
					end
				elseif iImportance == 1 then
					if pTestCity:GetOwner() >= GameDefines.MAX_MAJOR_CIVS and pTestCity:GetOwner() < GameDefines.MAX_CIV_PLAYERS then
						pCity = pTestCity
						break
					end
				end
			end
			if pCity then
				dprint("Found a city for Player "..iPlayer.." to target for Witch Hunting: " ..pCity:GetName())
				local iNumPlots = pCity:GetNumCityPlots();
				for iPlot = 0, iNumPlots - 1 do
					local pPlot = pCity:GetCityIndexPlot(iPlot)
					if not pPlot:IsImpassable() and not pPlot:IsWater() and not pPlot:IsCity() then
						ValidPlots[#ValidPlots + 1] = pPlot
					end
				end
				-- if #ValidPlots > 0 then
					-- local iChosenPlot = Game.Rand(#ValidPlots - 1, "AI Witch Hunt Plot Roll") + 1
					-- local pMissionPlot = ValidPlots[iChosenPlot]
				-- end
			end
			dprint("Number of valid target plots: " ..#ValidPlots)
			if #ValidPlots > 0 then
				dprint("Determining plot to target")
				for k, v in pairs(MagicalGirls) do
					--Don't assign MGs to do this if they already have a mission to do
					if v.Owner == iPlayer and not v.AIMoveToTarget and not v.AIMissionAfterReachingTarget then
						dprint("Using Magical Girl #" ..k)
						local iChosenPlot = Game.Rand(#ValidPlots, "AI Witch Hunt Plot Roll") + 1
						local pMissionPlot = ValidPlots[iChosenPlot]
						dprint("Chosen plot at " ..pMissionPlot:GetX().. ", "..pMissionPlot:GetY())
						v.AIMoveToTarget = GetUnitSpecialID(pMissionPlot:GetX(), pMissionPlot:GetY())
						v.AIMissionAfterReachingTarget = iWitchHuntMission
						iNumGirlsChosen = iNumGirlsChosen + 1
						PMMM.AIAssignedWitchHunters[iPlayer] = true
						if iNumGirlsChosen >= 3 then
							break
						end
					end
				end
			end
		end
	end
end


--Handle the ownership change of a City with an HWB if it's captured
function OnCityCaptureHWB(iCapturedPlayer, bCapital, iX, iY, iCapturingPlayer, bConquest)
	local iSpecialID = GetUnitSpecialID(iX, iY)
	if PMMM.HiddenWitchCities[iSpecialID] then
		if MapModData.gPMMMTraits[iCapturingPlayer] and (MapModData.gPMMMTraits[iCapturingPlayer].NoMagicalGirls == true or MapModData.gPMMMTraits[iCapturingPlayer].NoMagicalGirls == 1)
		or (MapModData.gPMMMTraits[iCapturingPlayer].NoWitches == true or MapModData.gPMMMTraits[iCapturingPlayer].NoWitches == 1) then
			--The HWB disappears if UM or DH captures a city
			PMMM.HiddenWitchCities[iSpecialID] = nil
		else
			PMMM.CurrentHiddenWitches[iCapturingPlayer] = PMMM.CurrentHiddenWitches[iCapturingPlayer] + 1
		end
		PMMM.CurrentHiddenWitches[iCapturedPlayer] = math.max((PMMM.CurrentHiddenWitches[iCapturedPlayer] - 1), 0)
	end
end



--v20: Familiars turn into Witches if they pillage an improvement
function OnFamiliarPillagedImprovement(iPlotX, iPlotY, iOwner, iOldImprovement, iNewImprovement, bPillaged)
	if not bPillaged then return end
	local pPlot = Map.GetPlot(iPlotX, iPlotY)
	if pPlot:IsUnit() then
		for i = 0, pPlot:GetNumUnits() - 1 do
			local pUnit = pPlot:GetUnit(i)
			if pUnit:GetOwner() == iMaxCivsAndCS and (pUnit:GetUnitType() == iFamiliarType or pUnit:GetUnitType() == iSeaFamiliarType) then
				local iNewUnitType = iWitchType
				if pUnit:GetUnitType() == iSeaFamiliarType then
					iNewUnitType = iSeaWitchType
				end
				local pWitch = Players[iMaxCivsAndCS]:InitUnit(iNewUnitType, iPlotX, iPlotY, UNITAI_ATTACK)
				pWitch:SetBaseCombatStrength(MapModData.gPMMMWitchEraStrengths[Game:GetCurrentEra()])
				pUnit:Kill(true)
				if iOwner == Game:GetActivePlayer() then
					Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_PMMM_ALERT_FAMILIAR_BECAME_WITCH_PILLAGE"))
				end
				break
			end
		end
	end
end