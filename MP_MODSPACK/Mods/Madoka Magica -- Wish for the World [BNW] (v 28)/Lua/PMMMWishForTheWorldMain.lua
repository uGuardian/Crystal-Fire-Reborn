-- Wish for the World Main Script
-- Author: Vicevirtuoso
-- DateCreated: 6/17/2014 11:33:29 AM
--------------------------------------------------------------

MapModData.PMMM = {} --empty the table for loading
include("PMMMDefines.lua")
include("PMMMDataStorage.lua")
include("TableSaverLoader016.lua")
include("TSLSerializerV3PMMM.lua")


--set to true to enable print statements
bDebug = false
--supresses some of the louder debug statements
bDebugPlots = false


--variables useable everywhere
iMaxCivs = GameDefines.MAX_MAJOR_CIVS
iMaxCivsAndCS = GameDefines.MAX_CIV_PLAYERS

function dprint(...)
  if (bDebug) then
    print(string.format(...))
  end
end

function InitVariableTables()
	dprint("InitVariableTables called")
		--Cooldown time of Time Stop.
	if not PMMM.TimeStopCooldown[0] then
		dprint("Initialize PMMM.TimeStopCooldown")
		PMMM.TimeStopCooldown = {}
		for i = 0, iMaxCivs - 1, 1 do
			PMMM.TimeStopCooldown[i] = 0
		end
		dprint("TimeStopCooldown table values:")
		for k, v in pairs(PMMM.TimeStopCooldown) do
			dprint(k, v)
		end
	end
	
		--Current duration of Time Stop.
	if not PMMM.TimeStopDuration[0] then
		dprint("Initialize PMMM.TimeStopDuration")
		PMMM.TimeStopDuration = {}
		for i = 0, iMaxCivs - 1, 1 do
			PMMM.TimeStopDuration[i] = 0
		end
		dprint("TimeStopDuration table values:")
		for k, v in pairs(PMMM.TimeStopDuration) do
			dprint(k, v)
		end
	end
	
	if not PMMM.GriefSeeds[0] then
		for i = 0, iMaxCivs - 1, 1 do
			PMMM.GriefSeeds[i] = 0
		end
	end

	if not PMMM.UsedGenericMGNames[1] then
		for k, v in pairs(MapModData.gPMMMGenericMGNames) do
			PMMM.UsedGenericMGNames[k] = false
		end
	end

	if not PMMM.UsedGenericWitchNames[1] then
		for k, v in pairs(MapModData.gPMMMGenericWitchNames) do
			PMMM.UsedGenericWitchNames[k] = false
		end
	end
end

function OnModLoaded() --called from end of last mod file to load



	
	local bNewGame = not TableLoad(PMMM, "PMMMConversion")

	if bNewGame then
		InitVariableTables()
	end
	
	--LuaEvents.RefreshAllPMMMDefines()

	TableSave(PMMM, "PMMMConversion")  --before the initial autosave that runs for both new and loaded games

end

--Input handler for custom missions and saving
function InputHandler( uiMsg, wParam, lParam )
	if uiMsg == MouseEvents.LButtonUp then
			local pPlot = Map.GetPlot( UI.GetMouseOverHex() )
			if pPlot then
					local iX, iY = pPlot:GetX(), pPlot:GetY()
					if tMissionInfo.ValidTargetPlots then
							print("Map clicked with mission info")
							for k, v in pairs(tMissionInfo.ValidTargetPlots) do
								if k:GetX() == iX and k:GetY() == iY then
										print("Plot has a valid target, pushing mission type "..GameInfo.Missions[tMissionInfo.MissionID].Type)
										Game.SelectionListGameNetMessage(GameMessageTypes.GAMEMESSAGE_PUSH_MISSION, tMissionInfo.MissionID, -iX, -iY, 1, false, false) --has to use negatives of the coordinates to prevent it from making MGs run off to that plot, the functions unary-negate them
										ClearCustomMissionInfo()
										break
								end
							end
					end
			end
	end
end
ContextPtr:SetInputHandler(InputHandler)


OnModLoaded()



--Whole lotta includes
include("PMMMGeneralFunctions.lua")
include("PMMMUUBootstrapper.lua")
include("PMMMUBBootstrapper.lua")
include("PMMMTraitBootstrapper.lua")
include("PMMMFarsightOracle.lua")
include("PMMMLeaveMapFunctions.lua")
include("PMMMReturnMapFunctions.lua")
include("PMMMRouseMilitia.lua")
include("PMMMPurificationThroughHope.lua")
include("PMMMPolicyMovementBonus.lua")
include("PMMMMagicalGirls.lua")
include("PMMMWitches.lua")
include("MagicalGirlMissionHandler.lua")
include("PMMMCoreMoods.lua")
include("PMMMEntertainmentSystem.lua")
include("PMMMCityConnectionBuildings.lua")




--All GameEvents/Events calls should be run here.

---------PlayerDoTurn------------------------------------------------------------------------------
GameEvents.PlayerDoTurn.Add(DoActionStateTurnUpkeep)
GameEvents.PlayerDoTurn.Add(MagicalGirlUpkeep)
GameEvents.PlayerDoTurn.Add(RunUBScripts)
GameEvents.PlayerDoTurn.Add(OnDoTurnUUFunctions)
GameEvents.PlayerDoTurn.Add(OnDoTurnRunTraitScripts)
GameEvents.PlayerDoTurn.Add(OnTurnFarsightOracle)
GameEvents.PlayerDoTurn.Add(OnPlayerDoTurnVacationTurn)
GameEvents.PlayerDoTurn.Add(UpgradeFamiliarToWitch)
GameEvents.PlayerDoTurn.Add(HiddenWitchSpawn)
GameEvents.PlayerDoTurn.Add(AIRouseMilitiaHandler)
GameEvents.PlayerDoTurn.Add(OnTurnResetWarScore)
GameEvents.PlayerDoTurn.Add(SoulGemCriticalNotification)
GameEvents.PlayerDoTurn.Add(OnDoTurnCityConnectionBuildings)
GameEvents.PlayerDoTurn.Add(PushAIMissions)


---------Always run SavePMMMTable last!-----------------------------------------------------------
GameEvents.PlayerDoTurn.Add(SavePMMMTable)


---------UnitSetXY--------------------------------------------------------------------------------
GameEvents.UnitSetXY.Add(OnSetXYUUFunctions)
GameEvents.UnitSetXY.Add(OnSetXYRunTraitScripts)
GameEvents.UnitSetXY.Add(OnMoveFarsightOracle)
GameEvents.UnitSetXY.Add(CheckDestroyWitchBarrier)
GameEvents.UnitSetXY.Add(OnSetXYIsMGNearHomeCity)
GameEvents.UnitSetXY.Add(SocializingAILogic)
GameEvents.UnitSetXY.Add(DullPainAILogic)
GameEvents.UnitSetXY.Add(HomesickAILogic)
GameEvents.UnitSetXY.Add(OnUnitSetXYCheckEmotionalAbuse)


--------LoadScreenClose------------------------------------------------------------------------
Events.LoadScreenClose.Add(OnEnterGame)
Events.LoadScreenClose.Add(OnLoadScreenCloseRunTraitScripts)

--------UnitKilledInCombat------------------------------------------------------------------------
GameEvents.UnitKilledInCombat.Add(OnUnitKilledInCombatRunTraitScripts)
GameEvents.UnitKilledInCombat.Add(GetGriefSeed)
GameEvents.UnitKilledInCombat.Add(OnUnitKilledInCombatWarScore)
GameEvents.UnitKilledInCombat.Add(OnUnitKilledInCombatIterateUnitsEverKilled)

--------CityCaptureComplete------------------------------------------------------------------------
GameEvents.CityCaptureComplete.Add(OnCaptureCompleteUUFunctions)
GameEvents.CityCaptureComplete.Add(OnCityCaptureRunTraitScripts)
GameEvents.CityCaptureComplete.Add(OnCityCaptureHWB)
GameEvents.CityCaptureComplete.Add(OnCityCaptureCompleteWarScore)

-------- PlayerAdoptPolicy------------------------------------------------------------------------
GameEvents.PlayerAdoptPolicy.Add(MagicalGirlPolicyMovementBonus)

-------- PlayerCityFounded------------------------------------------------------------------------
GameEvents.PlayerCityFounded.Add(CreateFirstLeaderMagicalGirl)

--------UnitSelectionChanged------------------------------------------------------------------------
Events.UnitSelectionChanged.Add(CleanMissionInfo)

--------SerialEventMouseOverHex----------------------------------------------------------------------
Events.SerialEventMouseOverHex.Add(OnMouseOverHex)

--------InterfaceModeChanged----------------------------------------------------------------------
Events.InterfaceModeChanged.Add(CleanMissionInfo)

--------GameplaySetActivePlayer----------------------------------------------------------------------
Events.GameplaySetActivePlayer.Add(CleanMissionInfo)

--------CityCanConstruct-----------------------------------------------------------------------------
GameEvents.CityCanConstruct.Add(OnCityCanConstructLakeBuildings)
GameEvents.CityCanConstruct.Add(OnCityCanConstructLandmassBuildings)

--------GreatPersonExpended (added by DVMC)----------------------------------------------------------
GameEvents.GreatPersonExpended.Add(MadokaInitMagicalGirl)

--------UnitPromoted (added by DVMC)----------------------------------------------------------------
GameEvents.UnitPromoted.Add(OnUnitPromotedUUFunctions)
GameEvents.UnitPromoted.Add(OnPromotedRunTraitScripts)

--------UnitCreated (added by DVMC)----------------------------------------------------------------
GameEvents.UnitCreated.Add(ReplaceHostileUnits)
GameEvents.UnitCreated.Add(GiveGPAName)
GameEvents.UnitCreated.Add(OnCreatedMagicalGirl)
GameEvents.UnitCreated.Add(RemoveGeneralAdmiralBonusFromProdigies)

--------TileImprovementChanged (added by DVMC)--------------------------------------------------------
GameEvents.TileImprovementChanged.Add(AddStolenFoodFromImprovement)
GameEvents.TileImprovementChanged.Add(OnFamiliarPillagedImprovement)

--------TeamSetEra (added by DVMC)------------------------------------------------------------------
GameEvents.TeamSetEra.Add(UpdateMGStrengthOnEra)

--------CustomMissionPossible (added by DVMC)--------------------------------------------------------
GameEvents.CustomMissionPossible.Add(OnCustomMissionPossibleRunTraitScripts)
GameEvents.CustomMissionPossible.Add(OnCustomMissionPossibleUUFunctions)
GameEvents.CustomMissionPossible.Add(WitchHuntCustomMissionPossible)
GameEvents.CustomMissionPossible.Add(RouseMilitiaCustomMissionPossible)
GameEvents.CustomMissionPossible.Add(PurificationThroughHopeCustomMissionPossible)
GameEvents.CustomMissionPossible.Add(HiddenCustomMissionPossible)
GameEvents.CustomMissionPossible.Add(SocializationCustomMissionPossible)
GameEvents.CustomMissionPossible.Add(AutoSocializationCustomMissionPossible)
GameEvents.CustomMissionPossible.Add(DullPainCustomMissionPossible)
GameEvents.CustomMissionPossible.Add(VacationCustomMissionPossible)
GameEvents.CustomMissionPossible.Add(ContactHomeCustomMissionPossible)
GameEvents.CustomMissionPossible.Add(SparringCustomMissionPossible)
--------CustomMissionStart (added by DVMC)--------------------------------------------------------
GameEvents.CustomMissionStart.Add(OnCustomMissionStartRunTraitScripts)
GameEvents.CustomMissionStart.Add(OnCustomMissionStartUUFunctions)
GameEvents.CustomMissionStart.Add(WitchHuntCustomMissionStart)
GameEvents.CustomMissionStart.Add(RouseMilitiaCustomMissionStart)
GameEvents.CustomMissionStart.Add(PurificationThroughHopeCustomMissionStart)
GameEvents.CustomMissionStart.Add(GriefSeedCustomMissionStart)
GameEvents.CustomMissionStart.Add(SocializationCustomMissionStart)
GameEvents.CustomMissionStart.Add(AutoSocializationCustomMissionStart)
GameEvents.CustomMissionStart.Add(DullPainCustomMissionStart)
GameEvents.CustomMissionStart.Add(VacationCustomMissionStart)
GameEvents.CustomMissionStart.Add(ContactHomeCustomMissionStart)
GameEvents.CustomMissionStart.Add(SparringCustomMissionStart)
--------CustomMissionCompleted (added by DVMC)--------------------------------------------------------
GameEvents.CustomMissionCompleted.Add(OnCustomMissionCompletedRunTraitScripts)
GameEvents.CustomMissionCompleted.Add(OnCustomMissionCompletedUUFunctions)
GameEvents.CustomMissionCompleted.Add(WitchHuntCustomMissionCompleted)
GameEvents.CustomMissionCompleted.Add(RouseMilitiaCustomMissionCompleted)
GameEvents.CustomMissionCompleted.Add(PurificationThroughHopeCustomMissionCompleted)
GameEvents.CustomMissionCompleted.Add(HiddenCustomMissionCompleted)
GameEvents.CustomMissionCompleted.Add(SocializationCustomMissionCompleted)
GameEvents.CustomMissionCompleted.Add(AutoSocializationCustomMissionCompleted)
GameEvents.CustomMissionCompleted.Add(DullPainCustomMissionCompleted)
GameEvents.CustomMissionCompleted.Add(VacationCustomMissionCompleted)
GameEvents.CustomMissionCompleted.Add(ContactHomeCustomMissionCompleted)
GameEvents.CustomMissionCompleted.Add(SparringCustomMissionCompleted)

--------Prekill (added by DVMC)----------------------------------------------------------------------
GameEvents.UnitPrekill.Add(OnPrekillRunTraitScripts)
GameEvents.UnitPrekill.Add(UpdateMagicalGirlToDead)
GameEvents.UnitPrekill.Add(OnUnitPreKillNearbyMGMood)

--------PlayerPlunderedTradeRoute (added by DVMC v.52)-------------------------------------------------
GameEvents.PlayerPlunderedTradeRoute.Add(OnPlayerPlunderedTradeRouteRunTraitScripts)

--------CanDoCommand(added by DVMC)--------------------------------------------------------------------
GameEvents.CanDoCommand.Add(PreventDeletePMMMUnits)

--------GetDiploModifier (added by DVMC)---------------------------------------------------------------
GameEvents.GetDiploModifier.Add(DiploPenaltyForWitchHunt)
GameEvents.GetDiploModifier.Add(DiploPenaltyForWitchBombing)

--------CombatEnded (added by DVMC from Gedemon's DLL)-------------------------------------------------
GameEvents.CombatEnded.Add(OnCombatEndedRunTraitScripts)
GameEvents.CombatEnded.Add(OnCombatEndedDidMGKillWitch)
GameEvents.CombatEnded.Add(OnCombatEndedDidMGFightNearLeader)
GameEvents.CombatEnded.Add(OnCombatEndedRecoverQBDamage)

--------MakePeace--------------------------------------------------------------------------------------
GameEvents.MakePeace.Add(OnPeaceResetWarScore)




--------EVENTS-----------------------------------------------------------------------------------
Events.UnitSelectionChanged.Add(OnUnitSelectionChangedUpdateMood)
Events.UnitSelectionChanged.Add(ClearCustomMissionInfo)
Events.SerialEventUnitInfoDirty.Add(OnUnitInfoDirtyUpdateMood)



--------UI LuaEvents-----------------------------------------------------------------------------------
LuaEvents.PMMMGetUnitHarmony.Add(GetUnitHarmony)
LuaEvents.PMMMGetUnitStolenFood.Add(GetUnitStolenFood)
LuaEvents.PMMMGetLeaderMaxStolenFood.Add(GetLeaderMaxStolenFood)
LuaEvents.PMMMGetSoulGemCorruption.Add(GetSoulGemCorruption)
LuaEvents.PMMMGetSoulGemPolish.Add(GetSoulGemPolish)
LuaEvents.PMMMGetSoulGemStateStringAndDanger.Add(GetSoulGemStateStringAndDanger)
LuaEvents.PMMMGetGriefSeeds.Add(GetGriefSeeds)
LuaEvents.PMMMGetLeaderTimeStopDuration.Add(GetLeaderTimeStopDuration)
LuaEvents.PMMMGetLeaderTimeStopCooldown.Add(GetLeaderTimeStopCooldown)
LuaEvents.PMMMGetBarbarianCampXP.Add(GetBarbarianCampXP)
LuaEvents.PMMMLoadPMMMTable.Add(LoadPMMMTable)
LuaEvents.PMMMSavePMMMTable.Add(SavePMMMTable)
LuaEvents.PMMMUseGriefSeed.Add(UseGriefSeed)
LuaEvents.PMMMRandomizeMagicalGirlPortrait.Add(RandomizeMagicalGirlPortrait)
LuaEvents.PMMMSetCustomMissionInfo.Add(SetCustomMissionInfo)
LuaEvents.CityInfoStackDataRefresh.Add(EntertainmentCityInfoStackDataRefresh)
LuaEvents.CityInfoStackDirty.Add(EntertainmentCityInfoStackDirty)
LuaEvents.RequestCityInfoStackDataRefresh()