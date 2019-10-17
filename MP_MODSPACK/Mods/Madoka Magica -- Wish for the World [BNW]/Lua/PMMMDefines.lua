-- Defines For WFTW Global Table
-- Author: Vicevirtuoso
-- DateCreated: 6/17/2014 12:53:41 PM
--------------------------------------------------------------


-------------------------------------------------------------------------------------------
--This contains all of the defines for the global table used to store this mod's data.
--It needs to be included in any file which wants to make changes to Magical Girls, etc.
-------------------------------------------------------------------------------------------


MapModData.PMMM = MapModData.PMMM or {};
--Localize down to "PMMM" and "MagicalGirls" for significant ease of use
PMMM = MapModData.PMMM;
PMMM.MagicalGirls = PMMM.MagicalGirls or {}
MagicalGirls = PMMM.MagicalGirls


--All stuff not directly related to Magical Girl Stats
PMMM.TimeStopCooldown = PMMM.TimeStopCooldown or {}									--Cooldown time before Time Stop use (per Civ; if multiple MGs who can stop time exist in the same Civ, they share cooldown)
PMMM.TimeStopDuration = PMMM.TimeStopDuration or {}									--How long Time Stop is currently active (if for some insane reason you want it to be more than 1 turn)
PMMM.Harmony = PMMM.Harmony or {}													--Cutlass Conductor
PMMM.StolenFood = PMMM.StolenFood or {}												--Kyouko trait
PMMM.StolenFoodPlots = PMMM.StolenFoodPlots or {}									--Prevent Kyouko from pillage-repair-pillage until 100 food
PMMM.WitchBarrierSpawnedWitchPlots = PMMM.WitchBarrierSpawnedWitchPlots or {}		--Which Barriers have spawned Witches before (if so, new units are familiars)
PMMM.WitchBarrierStartTracking = PMMM.WitchBarrierStartTracking or {}				--Cache Barrier locations
PMMM.GriefSeeds = PMMM.GriefSeeds or {}												--Self-explanatory
PMMM.UsedGenericMGNames = PMMM.UsedGenericMGNames or {}								--Store which generic MG pool names are used already (no duplicates)
PMMM.UsedGenericWitchNames = PMMM.UsedGenericWitchNames or {}						--Store which generic Witch pool names are used already (no duplicates)
PMMM.CurrentHiddenWitches = PMMM.CurrentHiddenWitches or {}							--Hidden witch existence
PMMM.HiddenWitchPlots = PMMM.HiddenWitchPlots or {}									--Plots for Hidden Witches to be uncovered
PMMM.HiddenWitchCities = PMMM.HiddenWitchCities or {}								--Cities which Hidden Witches eat from
PMMM.WitchHuntDiploPenalties = PMMM.WitchHuntDiploPenalties or {}					--AI will get pissy if you start hunting on their turf
PMMM.AIAssignedWitchHunters = PMMM.AIAssignedWitchHunters or {}						--Which units has the AI assigned to start witch hunting?
PMMM.FreezerSuccesses = PMMM.FreezerSuccesses or {}									--How many times have Kaoru/Umika not fucked up their science project?
PMMM.Subjugations = PMMM.Subjugations or {}											--How many MGs Demon Homura has subjugated
PMMM.GPHomeCities = PMMM.GPHomeCities or {}											--Home City for a Prodigy, to be passed to the MG
PMMM.WarScore = PMMM.WarScore or {}													--War score for Moods
PMMM.UnitsEverKilled = PMMM.UnitsEverKilled or {}									--Permanently keep track of how many units of a specific Civ have been killed by a specific other Civ
PMMM.NumMGsTurnedToWitch = PMMM.NumMGsTurnedToWitch or {}							--Total number of MGs allowed to become Witches by each Civ
PMMM.WitchBombings = PMMM.WitchBombings or {}										--Tracking "Witch Bombings", aka a tactic of dropping a despairing MG into someone else's territory to make them learn The Truth (harsh diplo penalty)
PMMM.SparringCities = PMMM.SparringCities or {}										--Which cities are currently hosting a Sparring session
PMMM.PlayerLastGotFreeIntrigueTurn = PMMM.PlayerLastGotFreeIntrigueTurn or {}		--Cooldown time between new Intrigue from v27 Shirome trait

--v21: Are hidden witches spawning? Used to use the root of MapModData, but that was an oversight and is now properly in the gT
--This clause is for previous versions' savegame compatibility
PMMM.IsSpawningHiddenWitches = PMMM.IsSpawningHiddenWitches or MapModData.gPMMMIsSpawningHiddenWitches
if not PMMM.IsSpawningHiddenWitches then
	PMMM.IsSpawningHiddenWitches = false
end


function RefreshAllPMMMDefines()
	MapModData.PMMM = MapModData.PMMM or {};
	--Localize down to "PMMM" and "MagicalGirls" for significant ease of use
	PMMM = MapModData.PMMM;
	PMMM.MagicalGirls = PMMM.MagicalGirls or {}
	MagicalGirls = PMMM.MagicalGirls


	--All stuff not directly related to Magical Girl Stats
	PMMM.TimeStopCooldown = PMMM.TimeStopCooldown or {}									--Cooldown time before Time Stop use (per Civ; if multiple MGs who can stop time exist in the same Civ, they share cooldown)
	PMMM.TimeStopDuration = PMMM.TimeStopDuration or {}									--How long Time Stop is currently active (if for some insane reason you want it to be more than 1 turn)
	PMMM.Harmony = PMMM.Harmony or {}													--Cutlass Conductor
	PMMM.StolenFood = PMMM.StolenFood or {}												--Kyouko trait
	PMMM.StolenFoodPlots = PMMM.StolenFoodPlots or {}									--Prevent Kyouko from pillage-repair-pillage until 100 food
	PMMM.WitchBarrierSpawnedWitchPlots = PMMM.WitchBarrierSpawnedWitchPlots or {}		--Which Barriers have spawned Witches before (if so, new units are familiars)
	PMMM.WitchBarrierStartTracking = PMMM.WitchBarrierStartTracking or {}				--Cache Barrier locations
	PMMM.GriefSeeds = PMMM.GriefSeeds or {}												--Self-explanatory
	PMMM.UsedGenericMGNames = PMMM.UsedGenericMGNames or {}								--Store which generic MG pool names are used already (no duplicates)
	PMMM.CurrentHiddenWitches = PMMM.CurrentHiddenWitches or {}							--Hidden witch existence
	PMMM.HiddenWitchPlots = PMMM.HiddenWitchPlots or {}									--Plots for Hidden Witches to be uncovered
	PMMM.HiddenWitchCities = PMMM.HiddenWitchCities or {}								--Cities which Hidden Witches eat from
	PMMM.WitchHuntDiploPenalties = PMMM.WitchHuntDiploPenalties or {}					--AI will get pissy if you start hunting on their turf
	PMMM.AIAssignedWitchHunters = PMMM.AIAssignedWitchHunters or {}						--Which units has the AI assigned to start witch hunting?
	PMMM.FreezerSuccesses = PMMM.FreezerSuccesses or {}									--How many times have Kaoru/Umika not fucked up their science project?
	PMMM.Subjugations = PMMM.Subjugations or {}											--How many MGs Demon Homura has subjugated
	PMMM.GPHomeCities = PMMM.GPHomeCities or {}											--Home City for a Prodigy, to be passed to the MG
	PMMM.WarScore = PMMM.WarScore or {}													--War score for Moods
	PMMM.UnitsEverKilled = PMMM.UnitsEverKilled or {}									--Permanently keep track of how many units of a specific Civ have been killed by a specific other Civ
	PMMM.NumMGsTurnedToWitch = PMMM.NumMGsTurnedToWitch or {}							--Total number of MGs allowed to become Witches by each Civ


	--v21: Are hidden witches spawning? Used to use the root of MapModData, but that was an oversight and is now properly in the gT
	--This clause is for previous versions' savegame compatibility
	PMMM.IsSpawningHiddenWitches = PMMM.IsSpawningHiddenWitches or MapModData.gPMMMIsSpawningHiddenWitches
	if not PMMM.IsSpawningHiddenWitches then
		PMMM.IsSpawningHiddenWitches = false
	end
end

LuaEvents.RefreshAllPMMMDefines.Add(RefreshAllPMMMDefines)