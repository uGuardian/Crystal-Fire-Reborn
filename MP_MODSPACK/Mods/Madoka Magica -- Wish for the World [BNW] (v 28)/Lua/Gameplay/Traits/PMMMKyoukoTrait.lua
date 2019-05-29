-- Kyouko Trait
-- Author: Vicevirtuoso
-- DateCreated: 6/14/2014 1:56:55 PM
--------------------------------------------------------------


include('PMMMGeneralFunctions.lua');

local iMissionType1 = GameInfoTypes.MISSION_PMMM_KYOUKO_GIVE_FOOD
local iMissionType2 = GameInfoTypes.MISSION_PMMM_KYOUKO_FOOD_HEAL

local iMelee = GameInfoTypes.UNITCOMBAT_MELEE
local iGun = GameInfoTypes.UNITCOMBAT_GUN
local iMounted = GameInfoTypes.UNITCOMBAT_MOUNTED
local iNavalMelee = GameInfoTypes.UNITCOMBAT_NAVALMELEE
local iMGClass = GameInfoTypes.UNITCLASS_MAGICAL_GIRL

function AddStolenFoodFromImprovement(iPlotX, iPlotY, iOwner, iOldImprovement, iNewImprovement, bPillaged)
	if not bPillaged then return end
	dprint("Improvement pillaged")
	local pPlot = Map.GetPlot(iPlotX, iPlotY)
	dprint("Plot pointer at " ..iPlotX.. ", " ..iPlotY)
	if pPlot:IsUnit() then
		dprint("Plot contains unit(s)")
		for i = 0, pPlot:GetNumUnits() - 1 do
			local bBreak
			dprint("Looping through " ..pPlot:GetNumUnits().. " units.")
			local pUnit = pPlot:GetUnit(i)
			if pUnit:GetUnitCombatType() == iMelee or pUnit:GetUnitCombatType() == iGun or pUnit:GetUnitCombatType() == iMounted or pUnit:GetUnitCombatType() == iNavalMelee and pUnit:GetUnitClassType() ~= iMGClass then
				dprint("Checking a " ..pUnit:GetName().. ".")
				local iUnitOwner = pUnit:GetOwner()
				for k, v in pairs(PMMM.StolenFoodPlots) do
					if v.X == iPlotX and v.Y == iPlotY then
						if iUnitOwner == Game:GetActivePlayer() then
							Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_ALERT_KYOUKO_PILLAGE_STOLEN_FOOD_TOO_SOON", pUnit:GetName()))
						end
						return
					end
				end
				dprint("Owner ID: " ..iUnitOwner)
				local pUnitOwner = Players[iUnitOwner]
				local iUnit = pUnit:GetID()
				if MapModData.gPMMMTraits[iUnitOwner] and MapModData.gPMMMTraits[iUnitOwner].MaxStolenFood > 0 then
					dprint("Max Stolen Food is greater than 0.")
					for k in pairs(MapModData.gPMMMStolenFoodAmounts[iUnitOwner]) do
						dprint("Check improvement type " ..MapModData.gPMMMStolenFoodAmounts[iUnitOwner][k].ImprovementType.. " with food value of "..MapModData.gPMMMStolenFoodAmounts[iUnitOwner][k].Amount)
						if iNewImprovement == MapModData.gPMMMStolenFoodAmounts[iUnitOwner][k].ImprovementType then
							bBreak = true
							dprint("Improvement matches.")
							local iCurFood;
							local iSpecialID = GetUnitSpecialID(iUnitOwner, iUnit)
							if PMMM.StolenFood[iSpecialID] then
								iCurFood = PMMM.StolenFood[iSpecialID]
							else
								iCurFood = 0
							end
							PMMM.StolenFood[iSpecialID] = math.min((iCurFood + MapModData.gPMMMStolenFoodAmounts[iUnitOwner][k].Amount), MapModData.gPMMMTraits[iUnitOwner].MaxStolenFood)
							dprint("Current food for unit: " ..PMMM.StolenFood[iSpecialID])
							PMMM.StolenFoodPlots[#PMMM.StolenFoodPlots + 1] = {
								["X"] = iPlotX,
								["Y"] = iPlotY,
								["Turn"] = Game:GetGameTurn()
							}
							if iUnitOwner == Game:GetActivePlayer() then
								Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_ALERT_KYOUKO_PILLAGE_STOLEN_FOOD", pUnit:GetName(), MapModData.gPMMMStolenFoodAmounts[iUnitOwner][k].Amount, Locale.ConvertTextKey(GameInfo.Improvements[MapModData.gPMMMStolenFoodAmounts[iUnitOwner][k].ImprovementType].Description)))
							end
							break
						end
					end
				end
			end
			if bBreak then break end
		end
	end
end


function OnKyoukoCustomMission1Possible(iPlayer, iUnit, iMission, iData1, iData2, _, _, iPlotX, iPlotY, bTestVisible)
	if iPlayer < iMaxCivs then
		if MapModData.gPMMMTraits[iPlayer].MaxStolenFood > 0 then
			local pPlayer = Players[iPlayer]
			local pUnit = pPlayer:GetUnitByID(iUnit)
			local iSpecialID = GetUnitSpecialID(iPlayer, iUnit)
			if PMMM.StolenFood[iSpecialID] then
				if PMMM.StolenFood[iSpecialID] > 0 and iMission == iMissionType1 then
					if pUnit:GetPlot():GetPlotCity() then
						return true
					end
				elseif PMMM.StolenFood[iSpecialID] > 1 and iMission == iMissionType2 then
					if pUnit:GetDamage() > 0 then
						return true
					end
				end
			end
		end
	end
	return false
end

function OnKyoukoCustomMission1Start(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	if iPlayer < iMaxCivs then
		if MapModData.gPMMMTraits[iPlayer].MaxStolenFood > 0 then
			local pPlayer = Players[iPlayer]
			local pUnit = pPlayer:GetUnitByID(iUnit)
			local iSpecialID = GetUnitSpecialID(iPlayer, iUnit)
			if PMMM.StolenFood[iSpecialID] then
				if PMMM.StolenFood[iSpecialID] > 0 and iMission == iMissionType1 then
					if pUnit:GetPlot():GetPlotCity() then
						pCity = pUnit:GetPlot():GetPlotCity()
						pUnit:AddMessage(Locale.ConvertTextKey("TXT_KEY_ALERT_PMMM_GIVE_FOOD", pUnit:GetName(), pCity:GetName(), PMMM.StolenFood[iSpecialID]), iPlayer)
						pCity:ChangeFood(PMMM.StolenFood[iSpecialID])
						PMMM.StolenFood[iSpecialID] = 0
						pUnit:ChangeMoves(-1 * GameDefines.MOVE_DENOMINATOR)
						Events.SerialEventCityInfoDirty.CallImmediate()
					end
				elseif PMMM.StolenFood[iSpecialID] > 1 and iMission == iMissionType2 then
					if pUnit:GetDamage() > 0 then
						local iCurDamage = pUnit:GetDamage()
						local iMaxHeal = math.floor(PMMM.StolenFood[iSpecialID] / 2)
						local iActualHeal = math.min(iCurDamage, iMaxHeal)
						local iRemovedFood = iActualHeal * 2
						pUnit:AddMessage(Locale.ConvertTextKey("TXT_KEY_ALERT_PMMM_FOOD_HEAL", pUnit:GetName(), iActualHeal), iPlayer)
						PMMM.StolenFood[iSpecialID] = math.max(PMMM.StolenFood[iSpecialID] - iRemovedFood, 0)
						pUnit:ChangeDamage(-1 * iActualHeal)
						pUnit:ChangeMoves(-1 * GameDefines.MOVE_DENOMINATOR)
					end
				end
			end
		end
	end
	return 0
end

function OnKyoukoCustomMissionCompleted(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	if iMission == iMissionType1 or iMission == iMissionType2 then
		return true
	end
	return false
end


function AddStolenFoodFromSacking(iPlayer, iUnit)
	if iPlayer < iMaxCivs and MapModData.gPMMMTraits[iPlayer].CaravanPillageStolenFood > 0 then
		dprint("A trade route was pillaged by a Civ which gets Stolen Food from doing so.")
		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iUnit)
		local iCurFood;
		local iSpecialID = GetUnitSpecialID(iPlayer, iUnit)
		if PMMM.StolenFood[iSpecialID] then
			iCurFood = PMMM.StolenFood[iSpecialID]
		else
			iCurFood = 0
		end
		PMMM.StolenFood[iSpecialID] = math.min((iCurFood + MapModData.gPMMMTraits[iPlayer].CaravanPillageStolenFood), MapModData.gPMMMTraits[iPlayer].MaxStolenFood)
		dprint("Current food for unit: " ..PMMM.StolenFood[iSpecialID])
		pUnit:AddMessage(Locale.ConvertTextKey("TXT_KEY_ALERT_PMMM_KYOUKO_CARAVAN_SACK", pUnit:GetName(), MapModData.gPMMMTraits[iPlayer].CaravanPillageStolenFood))
	end
end


function AIStolenFoodCheck(iPlayer)
	local pPlayer = Players[iPlayer]
	for pUnit in pPlayer:Units() do
		local iUnit = pUnit:GetID()
		local iSpecialID = GetUnitSpecialID(iPlayer, iUnit)
		if PMMM.StolenFood[iSpecialID] then
			--Use it only if the unit is at half health or lower. This will be prioritized over dropping the food in the City.
			if pUnit:GetDamage() >= 50 then
				local iCurDamage = pUnit:GetDamage()
				local iMaxHeal = math.floor(PMMM.StolenFood[iSpecialID] / 2)
				local iActualHeal = math.min(iCurDamage, iMaxHeal)
				local iRemovedFood = iActualHeal * 2
				PMMM.StolenFood[iSpecialID] = math.max(PMMM.StolenFood[iSpecialID] - iRemovedFood, 0)
				pUnit:ChangeDamage(-1 * iActualHeal)
				pUnit:ChangeMoves(-1 * GameDefines.MOVE_DENOMINATOR)
			--If unit is above half health and in a city, dump the food in it
			elseif pUnit:GetPlot():GetPlotCity() then
				pCity = pUnit:GetPlot():GetPlotCity()
				pCity:ChangeFood(PMMM.StolenFood[iSpecialID])
				PMMM.StolenFood[iSpecialID] = 0
				pUnit:ChangeMoves(-1 * GameDefines.MOVE_DENOMINATOR)
			end
		end

		--v19: Force Kyouko's AI to pillage if it has sustained at least 25 damage
		if pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_KYOUKO and pUnit:CanStartMission(GameInfoTypes.MISSION_PILLAGE) and pUnit:GetDamage() >= 25 then
			pUnit:PopMission()
			pUnit:PushMission(GameInfoTypes.MISSION_PILLAGE)
		end
	end
end



--v19: Upkeep on recently pillaged plots
function OnDoTurnStolenFoodPillageUpkeep(iPlayer)
	--Only do this on player 0's turn
	local tToRemove = {}
	if iPlayer == 0 then
		for k, v in pairs(PMMM.StolenFoodPlots) do
			if v.Turn + GameDefines.STOLEN_FOOD_SAME_TILE_TURNS_BETWEEN >= Game:GetGameTurn() then
				tToRemove[k] = true
			end
		end
	end
	for i = #PMMM.StolenFoodPlots, 1, -1 do
		if tToRemove[i] then
			table.remove(PMMM.StolenFoodPlots, i)
		end
	end
end
