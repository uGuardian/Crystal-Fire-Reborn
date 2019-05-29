-- MagicalGirlMissionHandler
-- Author: Vicevirtuoso
-- DateCreated: 7/10/2014 4:52:46 PM
--------------------------------------------------------------


--This Lua file handles any missions which require a target selection.
--Anything that does NOT require a target selection (e.g. a mission which only buffs its user, Witch Hunting, etc.) should just be handled in the mission's CustomMissionStart call.

--...this really should be handled through WorldView with an actual InterfaceModeType, but I don't have the patience to work with a WorldView replacement yet until it's truly necessary.

include( "FLuaVector" )


tMissionInfo = {}

--tMissionInfo contains:
--tMissionInfo.MissionID -- ID from the Missions database table
--tMissionInfo.RangePlots -- plots which are within the range of the mission
--tMissionInfo.ValidTargetPlots -- plots which are actually valid targets
--tMissionInfo.ExecFunction -- **NOT USED ANYMORE** a string which corresponds to a function here, unique to each mission 

bMissionModeSelected = false

local iActive = GameInfoTypes.MGACTIONSTATE_ACTIVE


function SetCustomMissionInfo(iPlayer, iUnit, iMission)
	if bMissionModeSelected == false then
		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iUnit)
		tMissionInfo.MissionID = iMission
		tMissionInfo.RangePlots = FindMissionRange(iMission, iPlayer, pUnit:GetPlot(), pUnit)
		tMissionInfo.ValidTargetPlots = FindValidTargets(pPlayer, pUnit, GameInfo.Missions[iMission].PMMMTargetType)
		tMissionInfo.ExecFunction = GameInfo.Missions[iMission].PMMMMissionExec
		SetTargetHexHighlights()
		bMissionModeSelected = true
	else
		ClearAllHighlights()
		CleanMissionInfo()
		bMissionModeSelected = false
	end
end

function ClearCustomMissionInfo()
	ClearAllHighlights()
	CleanMissionInfo()
	bMissionModeSelected = false
end

function FindMissionRange(iMission, iPlayer, pPlot, pUnit)
	tMissionInfo.RangePlots = {}
	local tPlots = {}
	local pMission = GameInfo.Missions[iMission]
	local iTeam = Teams[Players[iPlayer]:GetTeam()]
	if pMission.PMMMMissionRange > 0 then
		local iX = pPlot:GetX()
		local iY = pPlot:GetY()
		--If hills, they get extra ability to shoot over obstacles, just like standard ranged attacks
		local iShootOver = 1
		if pUnit:IsRangeAttackIgnoreLOS() then
			iShootOver = 500
		elseif pPlot:IsHills() then
			iShootOver = 2
		elseif pPlot:IsMountain() then
			iShootOver = 3
		end
		for pAreaPlot in PlotAreaSpiralIterator(pPlot, pMission.PMMMMissionRange, 1, false, false, true) do
			local iAreaX = pAreaPlot:GetX()
			local iAreaY = pAreaPlot:GetY()
			local iAreaPlot = GetUnitSpecialID(iAreaX, iAreaY) --works even though the function says "unit"
			tPlots[iAreaPlot] = {}
			tPlots[iAreaPlot].Distance = Map.PlotDistance(iX, iY, iAreaX, iAreaY)
			if tPlots[iAreaPlot].Distance <= 1 then
				tPlots[iAreaPlot].ValidAttackTarget = true
				tPlots[iAreaPlot].X = iAreaX
				tPlots[iAreaPlot].Y = iAreaY
				if pAreaPlot:SeeThroughLevel(true) > iShootOver and tPlots[iAreaPlot].Distance > 0 then
					tPlots[iAreaPlot].BlocksNextPlot = true
				end
			else
				if pAreaPlot:IsVisible(iTeam) then
					local bPlotIsBlocked = true;
					for pTestBlockedPlots in PlotAreaSpiralIterator(pAreaPlot, 1, 1, false, false, false) do
						local iTestBlockedX = pTestBlockedPlots:GetX()
						local iTestBlockedY = pTestBlockedPlots:GetY()
						local iTestBlockedPlot = GetUnitSpecialID(iTestBlockedX, iTestBlockedY) --works even though the function says "unit"
						if tPlots[iTestBlockedPlot] then
							if tPlots[iTestBlockedPlot].Distance < tPlots[iAreaPlot].Distance then
								if tPlots[iTestBlockedPlot].BlocksNextPlot ~= true then
									tPlots[iAreaPlot].ValidAttackTarget = true
									tPlots[iAreaPlot].X = iAreaX
									tPlots[iAreaPlot].Y = iAreaY
									bPlotIsBlocked = false
									if pAreaPlot:SeeThroughLevel(true) > iShootOver then
										tPlots[iAreaPlot].BlocksNextPlot = true
									end
									break
								end
							end
						end
					end
					if bPlotIsBlocked then
						tPlots[iAreaPlot].ValidAttackTarget = false
						tPlots[iAreaPlot].BlocksNextPlot = true
					end
				else
					tPlots[iAreaPlot].ValidAttackTarget = false
				end
			end
		end
	end
	return tPlots
end

function FindValidTargets(pPlayer, pUnit, sTargetType)
	local tTable = {}
	for key, v in pairs(tMissionInfo.RangePlots) do
		local k = ReturnPlotFromSpecialID(key)
		if k then
			if sTargetType == "ENEMY" then --Enemy Units
				if k:IsUnit() then
					local pTeam = Teams[pPlayer:GetTeam()]
					for i = 0, k:GetNumUnits() - 1 do
						local pEnemyUnit = k:GetUnit(i)
						if pTeam:IsAtWar(Players[pEnemyUnit:GetOwner()]:GetTeam()) then
							tTable[k] = true
							break
						end
					end
				end
			elseif sTargetType == "FRIENDLY_NOT_SELF" then --Friendly units other than the unit itself
				if k:IsUnit() then
					for i = 0, k:GetNumUnits() - 1 do
						local pAllyUnit = k:GetUnit(i)
						if pAllyUnit:GetOwner() == pPlayer:GetID() and pAllyUnit:GetPlot() ~= pUnit:GetPlot() then
							tTable[k] = true
							break
						end
					end
				end
			elseif sTargetType == "FRIENDLY" then --Friendly units INCLUDING the unit using the ability
				if k:IsUnit() then
					for i = 0, k:GetNumUnits() - 1 do
						local pAllyUnit = k:GetUnit(i)
						if pAllyUnit:GetOwner() == pPlayer:GetID() then
							tTable[k] = true
							break
						end
					end
				end
			elseif sTargetType == "FRIENDLY_MAGICAL_GIRL" then --Friendly Magical Girl Units
				if k:IsUnit() then
					for i = 0, k:GetNumUnits() - 1 do
						local pAllyUnit = k:GetUnit(i)
						local iOwner = pAllyUnit:GetOwner()
						if iOwner == pPlayer:GetID() then
							local iMGKey = GetMagicalGirlKey(iOwner, pAllyUnit:GetID())
							if iMGKey then
								tTable[k] = true
								break
							end
						end
					end
				end
			elseif sTargetType == "SPARRING" then --Special targeting for Sparring
				if k:IsUnit() then
					for i = 0, k:GetNumUnits() - 1 do
						local pAllyUnit = k:GetUnit(i)
						if pAllyUnit:GetMoves() > 0 then
							local iOwner = pAllyUnit:GetOwner()
							if iOwner == pPlayer:GetID() and pAllyUnit:GetDamage() == 0 then
								local iMGKey = GetMagicalGirlKey(iOwner, pAllyUnit:GetID())
								if iMGKey then
									if (not MagicalGirls[iMGKey].SparringCooldown) or (Game:GetGameTurn() - MagicalGirls[iMGKey].SparringCooldown >= GameDefines.MG_SPARRING_COOLDOWN) then
										tTable[k] = true
										break
									end
								end
							end
						end
					end
				end
			elseif sTargetType == "NON_ENEMY_MAGICAL_GIRL" then --Friendly and Neutral Magical Girl Units
				if k:IsUnit() then
					for i = 0, k:GetNumUnits() - 1 do
						local pAllyUnit = k:GetUnit(i)
						if pAllyUnit ~= pUnit then
							local iOwner = pAllyUnit:GetOwner()
							if iOwner == pPlayer:GetID() or pPlayer:IsAtWarWith(iOwner) == false then
								local iMGKey = GetMagicalGirlKey(iOwner, pAllyUnit:GetID())
								if iMGKey then
									tTable[k] = true
									break
								end
							end
						end
					end
				end
			elseif sTargetType == "ENEMY_CITY" then --Enemy cities within range
				if k:IsCity() then
					local pCity = k:GetPlotCity()
					if pCity:GetOwner() ~= pUnit:GetOwner() then
						tTable[k] = true
					end
				end
			elseif sTargetType == "ENEMY_CRITICAL_MAGICAL_GIRL" then --Enemy Magical Girls whose Soul Gems are in Critical Condition (basically just for Herald of Madoka)
				if k:IsUnit() then
					for i = 0, k:GetNumUnits() - 1 do
						local pTeam = Teams[pPlayer:GetTeam()]
						local pEnemyUnit = k:GetUnit(i)
						if pTeam:IsAtWar(Players[pEnemyUnit:GetOwner()]:GetTeam()) and pEnemyUnit:GetUnitClassType() == GameInfoTypes.UNITCLASS_PMMM_MAGICAL_GIRL then
							local iMGKey = GetMagicalGirlKey(pEnemyUnit:GetOwner(), pEnemyUnit:GetID())
							if iMGKey then
								if MagicalGirls[iMGKey].SoulGemState == GameInfoTypes.PMMM_SGSTATE_CRITICAL then
									tTable[k] = true
									break
								end
							end
						end
					end
				end		
			elseif sTargetType == "EMPTY_PLOT" then --Plots without any units, cities, mountains, or water
				if not k:IsUnit() and not k:IsCity() and not k:IsImpassable() and not k:IsMountain() and not k:IsWater() then
					local iOwner = k:GetOwner()
					local pTeam = Teams[pPlayer:GetTeam()]
					if iOwner == pUnit:GetOwner() or iOwner < 0 then
						tTable[k] = true
					elseif pTeam:IsAtWar(Players[iOwner]:GetTeam()) or pPlayer:IsPlayerHasOpenBorders(iOwner) then
						tTable[k] = true
					end
				end
			end
		end
	end
	return tTable
end


--Depreciated, but still here just in case
function ExecuteMapClickCustomMission(pPlot)
	if tMissionInfo.ExecFunction == 'TIRO_FINALE' then
		DoTiroFinale(Game:GetActivePlayer(), UI.GetHeadSelectedUnit(), pPlot)
	elseif tMissionInfo.ExecFunction == 'LAW_OF_CYCLES' then
		DoLawOfCyclesMission(Game:GetActivePlayer(), UI.GetHeadSelectedUnit(), pPlot)
	elseif tMissionInfo.ExecFunction == 'SUMMON_WITCH' then
		DoSummonWitch(Game:GetActivePlayer(), UI.GetHeadSelectedUnit(), pPlot)
	elseif tMissionInfo.ExecFunction == 'POLISH' then
		DoPolish(Game:GetActivePlayer(), UI.GetHeadSelectedUnit(), pPlot)
	elseif tMissionInfo.ExecFunction == 'SOCIALIZE' then
		DoSocialize(Game:GetActivePlayer(), UI.GetHeadSelectedUnit(), pPlot)
	end
	CleanMissionInfo()
	ClearAllHighlights()
end

function SetTargetHexHighlights()
	if tMissionInfo.MissionID then
		UI.SetInterfaceMode(InterfaceModeTypes.INTERFACEMODE_SELECTION)
		for k, v in pairs(tMissionInfo.RangePlots) do
			if v.ValidAttackTarget == true then
				Events.SerialEventHexHighlight(ToHexFromGrid(Vector2(v.X, v.Y)), true, Vector4( 1.0, 1.0, 0.0, 1 ), "FireRangeBorder")
				local plot = ReturnPlotFromSpecialID(k)
				if tMissionInfo.ValidTargetPlots[plot] then
					Events.SerialEventHexHighlight(ToHexFromGrid(Vector2(v.X, v.Y)), true, Vector4( 1.0, 1.0, 0.0, 1 ), "ValidFireTargetBorder")
				end
			end
		end
	end
end

function OnMouseOverHex(iX, iY)
	if not tMissionInfo.MissionID then return end
	local iSpecialID = GetUnitSpecialID(iX, iY)
	Events.RemoveAllArrowsEvent()
	if tMissionInfo.RangePlots[iSpecialID] then
		if tMissionInfo.RangePlots[iSpecialID].ValidAttackTarget == true then
			local plot = ReturnPlotFromSpecialID(iSpecialID)
			if tMissionInfo.ValidTargetPlots[plot] then
				Events.SpawnArrowEvent(UI.GetHeadSelectedUnit():GetX(), UI.GetHeadSelectedUnit():GetY(), iX, iY)
			end
		end
	end
end


--taken from WorldView.lua
function ClearAllHighlights()
	--Events.ClearHexHighlights(); other systems might be using these!
	Events.ClearHexHighlightStyle("FireRangeBorder");
	Events.ClearHexHighlightStyle("ValidFireTargetBorder");
end


function CleanMissionInfo()
	Events.RemoveAllArrowsEvent()
	--ClearAllHighlights()  --commented out since it prevents other Interfacetypes from showing their ranges
	tMissionInfo = {}
end


function PushAIMissions(iPlayer)
	if iPlayer < GameDefines.MAX_CIV_PLAYERS then
		local pPlayer = Players[iPlayer]

		if not pPlayer:IsHuman() then
			for k, v in pairs(MagicalGirls) do
				if v.AIMoveToTarget and v.Owner == iPlayer and v.Status == iActive then
					local _, pUnit = RetrieveMGPointers(k)
					local pTargetPlot = ReturnPlotFromSpecialID(v.AIMoveToTarget)
					if pUnit and pUnit:GetPlot() == pTargetPlot then
						v.AIMoveToTarget = nil
					elseif pUnit and pUnit:GetMoves() > 0 then
						pUnit:PopMission()
						pUnit:PushMission(MissionTypes.MISSION_MOVE_TO, pTargetPlot:GetX(), pTargetPlot:GetY(), 0, 0, 1, MissionTypes.MISSION_MOVE_TO, pUnit:GetPlot(), pUnit)

						--Now check again if the unit is on the plot
						if pUnit:GetPlot() == pTargetPlot then
							v.AIMoveToTarget = nil
						end
					end
				end
			end

			for k, v in pairs(MagicalGirls) do
				if v.AIMissionAfterReachingTarget and v.Owner == iPlayer then
					--Only push the mission when their move-to target is nil -- meaning they are at the location
					if not v.AIMoveToTarget and v.Status == iActive then
						print("Found a MG with a mission but no mission target plot. Attempt to push mission")
						local _, pUnit = RetrieveMGPointers(k)
						print("pUnit location: "..pUnit:GetX()..", "..pUnit:GetY())
						pUnit:PopMission()
						pUnit:PushMission(v.AIMissionAfterReachingTarget, pUnit:GetX(), pUnit:GetY())
						
						--extra logic for Witch Hunting as it's done in groups. Set the "currently hunting Witches" tag to false if no others are doing it.
						if v.AIMissionAfterReachingTarget == GameInfoTypes.MISSION_PMMM_WITCH_HUNT then
							local bAnyWitchHuntersLeft;
							for k2, v2 in pairs(MagicalGirls) do
								if v2.AIMissionAfterReachingTarget and k2 ~= k and MagicalGirls[k2].Owner == iPlayer and v2 == GameInfoTypes.MISSION_PMMM_WITCH_HUNT then
									bAnyWitchHuntersLeft = true
									break
								end
							end
							if not bAnyWitchHuntersLeft then
								PMMM.AIAssignedWitchHunters[iPlayer] = false
							end
						end
						
						v.AIMissionAfterReachingTarget = nil

					end
				end
			end

		end
	end
end

local tHiddenMissions = {}

for mission in GameInfo.Missions() do
	if mission.Visible == 0 or mission.Visible == false and string.find(mission.Type, "_PMMM_") then
		tHiddenMissions[mission.ID] = true
	end
end

-- All Hidden missions should return true all the time
function HiddenCustomMissionPossible(iPlayer, iUnit, iMission, iData1, iData2, _, _, iPlotX, iPlotY, bTestVisible)
	if tHiddenMissions[iMission] then
		return true
	end
	return false
end



function HiddenCustomMissionCompleted(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	if tHiddenMissions[iMission] then
		return true
	end
	return false
end



--v21: Grief Seeds now handled through a Custom Mission (multiplayer compatibility)

local iGriefSeedMission = MissionTypes.MISSION_PMMM_GRIEF_SEED

function GriefSeedCustomMissionStart(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	if iMission == iGriefSeedMission then
		UseGriefSeed(iUnit, iPlayer)
	end
	return 0
end