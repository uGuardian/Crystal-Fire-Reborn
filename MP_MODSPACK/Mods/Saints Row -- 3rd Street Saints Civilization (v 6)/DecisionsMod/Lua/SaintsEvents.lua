-- SaintsEvents
-- Author: Vicevirtuoso
-- DateCreated: 9/11/2014 12:09:21 AM
--------------------------------------------------------------

--=======================================================================================================================
-- Event 1: Gang Attack (Random)
--=======================================================================================================================
local Event_SaintsGangAttack = {}
	Event_SaintsGangAttack.Name = "TXT_KEY_EVENT_SRTT_GANG_ATTACK"
	Event_SaintsGangAttack.Desc = "TXT_KEY_EVENT_SRTT_GANG_ATTACK_DESC"
	Event_SaintsGangAttack.Weight = 10
	Event_SaintsGangAttack.Data1 = nil
	Event_SaintsGangAttack.Data2 = nil
	Event_SaintsGangAttack.tValidCivs = 
	{
		["CIVILIZATION_THIRD_STREET_SAINTS"]		= true,
	}
	Event_SaintsGangAttack.CanFunc = (
		function(pPlayer)		
			local iNumCities = pPlayer:GetNumCities()
				if iNumCities > 0 then
					iChosenCity = Game.Rand(iNumCities - 1, "Saints Gang City Roll")
					for pCity in pPlayer:Cities() do
						if iChosenCity <= 0 and pCity:GetPopulation() > 1 then
							Event_SaintsGangAttack.Data1 = pCity
							break
						else
							iChosenCity = iChosenCity - 1
						end
					end
					if not pCity then
						pCity = pPlayer:GetCapitalCity()
						if not pCity then
							return false
						end
					end
				else
					return false
				end

			local iRandomValue = Game.Rand(8, "Saints Gang Type Roll") + 1
			
			Event_SaintsGangAttack.Data2 = Locale.ConvertTextKey("TXT_KEY_SRTT_GANG_ATTACK_GANGNAME_"..tostring(iRandomValue))

			Event_SaintsGangAttack.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_SRTT_GANG_ATTACK_DESC", Event_SaintsGangAttack.Data1:GetName(), Event_SaintsGangAttack.Data2)
			
			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			return Event_SaintsGangAttack.tValidCivs[sCivType]
		end
		)
	Event_SaintsGangAttack.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_SaintsGangAttack.Outcomes[1] = {}
	Event_SaintsGangAttack.Outcomes[1].Name = "TXT_KEY_EVENT_SRTT_GANG_ATTACK_OUTCOME_1"
	Event_SaintsGangAttack.Outcomes[1].Desc = "TXT_KEY_EVENT_SRTT_GANG_ATTACK_OUTCOME_RESULT_1"
	Event_SaintsGangAttack.Outcomes[1].Weight = 5
	Event_SaintsGangAttack.Outcomes[1].CanFunc = (
		function(pPlayer)			
			return true
		end
		)
	Event_SaintsGangAttack.Outcomes[1].DoFunc = (
		function(pPlayer, pCity, sGangName) 
			local pBarbarian = Players[GameDefines.MAX_CIV_PLAYERS]
			local pPlot = pCity:Plot()
			local sName = sGangName.." "..Locale.ConvertTextKey("TXT_KEY_SRTT_GANG_ATTACK_GANGNAME_APPEND")

			local tUnitTypes = {
				[GameInfoTypes.ERA_ANCIENT] = GameInfoTypes.UNIT_WARRIOR,
				[GameInfoTypes.ERA_CLASSICAL] = GameInfoTypes.UNIT_SPEARMAN,
				[GameInfoTypes.ERA_MEDIEVAL] = GameInfoTypes.UNIT_PIKEMAN,
				[GameInfoTypes.ERA_RENAISSANCE] = GameInfoTypes.UNIT_MUSKETMAN,
				[GameInfoTypes.ERA_INDUSTRIAL] = GameInfoTypes.UNIT_RIFLEMAN,
				[GameInfoTypes.ERA_MODERN] = GameInfoTypes.UNIT_GREAT_WAR_INFANTRY,
				[GameInfoTypes.ERA_POSTMODERN] = GameInfoTypes.UNIT_INFANTRY,
				[GameInfoTypes.ERA_FUTURE] = GameInfoTypes.UNIT_MECHANIZED_INFANTRY
				}

			local iChosenUnitType = tUnitTypes[pPlayer:GetCurrentEra()]

			local tPlotRandoms = {}
			for pAreaPlot in PlotRingIterator(pPlot, 2, 1, false) do
				if not pAreaPlot:IsUnit() and not pAreaPlot:IsImpassable() then
					tPlotRandoms[#tPlotRandoms + 1] = pAreaPlot
				end
			end
			--No unitless plots to spawn on = spawn on the first plot given by PlotRingIterator even if there IS a unit on it
			if #tPlotRandoms == 0 then
				for pAreaPlot in PlotRingIterator(pPlot, 2, 1, false) do
					tPlotRandoms[1] = pAreaPlot
					break
				end
			end


			for i = 0, 2, 1 do
				local pSpawnPlot = tPlotRandoms[Game.Rand(#tPlotRandoms - 1, "Saints Event Spawn Plot Roll") + 1]
				local pNewUnit = pBarbarian:InitUnit(iChosenUnitType, pSpawnPlot:GetX(), pSpawnPlot:GetY(), UNITAI_ATTACK)
				pNewUnit:SetName(sName)
				pNewUnit:SetHasPromotion(GameInfoTypes.PROMOTION_DECISIONS_SRTT_GANG, true)
				if pNewUnit:GetPlot():IsWater() then
					pNewUnit:Embark(pNewUnit:GetPlot())
				end
			end

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_SRTT_GANG_ATTACK_OUTCOME_RESULT_1_NOTIFICATION", pCity:GetName(), sGangName), Locale.ConvertTextKey(Event_SaintsGangAttack.Name))
		end
		)



for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_SaintsGangAttack.tValidCivs[sCiv] then
			tEvents.Event_SaintsGangAttack = Event_SaintsGangAttack
			break
		end
	end
end

--Variables stored between the following two functions.
local bGetRespect;
local pKilledPlot;
local iPromotionID = GameInfoTypes.PROMOTION_DECISIONS_SRTT_GANG

--When a unit dies, find out if it had promotions which grant respect on death.
function OnKilledGangMember(iPlayer, iUnitID)
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnitID)
	if pUnit:IsHasPromotion(iPromotionID) then
		bGetRespect = true
		pKilledPlot = pUnit:GetPlot()
	end
end

GameEvents.CanSaveUnit.Add(OnKilledGangMember)


--Now we make the unit actually grant the respect. Only works if the above function gave proper values to the variables.
function OnUnitKilledInCombatGangMember(iKiller, iPlayer, iUnitType)
	if bGetRespect then
		local pPlayer = Players[iKiller]
		local ttable = {}
		LuaEvents.SRTTIsActivePlayerSaints(iKiller, ttable)
		if ttable[0] then
			local iRespect = 50 + (25 * pPlayer:GetCurrentEra())
			LuaEvents.SRTTDoAddRespect(iKiller, iRespect, pKilledPlot)
		end
	end
	bGetRespect = false
	pKilledPlot = nil
end

GameEvents.UnitKilledInCombat.Add(OnUnitKilledInCombatGangMember)



--=======================================================================================================================
-- Event 2: Julius Returns (Scheduled for 2006)
--=======================================================================================================================

local Event_SaintsJuliusReturns = {}
	Event_SaintsJuliusReturns.Name = "TXT_KEY_EVENT_SRTT_JULIUS_RETURNS"
	Event_SaintsJuliusReturns.Desc = "TXT_KEY_EVENT_SRTT_JULIUS_RETURNS_DESC"
	Event_SaintsJuliusReturns.Weight = 0
	Event_SaintsJuliusReturns.CanFunc = (
		function(pPlayer)			
			Event_SaintsJuliusReturns.Desc = "TXT_KEY_EVENT_SRTT_JULIUS_RETURNS_DESC"
			if not pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_THIRD_STREET_SAINTS then return false end

			return true
		end
		)
	Event_SaintsJuliusReturns.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_SaintsJuliusReturns.Outcomes[1] = {}
	Event_SaintsJuliusReturns.Outcomes[1].Name = "TXT_KEY_EVENT_SRTT_JULIUS_RETURNS_OUTCOME_1"
	Event_SaintsJuliusReturns.Outcomes[1].Desc = "TXT_KEY_EVENT_SRTT_JULIUS_RETURNS_OUTCOME_RESULT_1"
	Event_SaintsJuliusReturns.Outcomes[1].CanFunc = (
		function(pPlayer)			
			return true
		end
		)
	Event_SaintsJuliusReturns.Outcomes[1].DoFunc = (
		function(pPlayer) 
			local iPlayer = pPlayer:GetID()
			local SRTT = MapModData.SRTT
			SRTT.Respect[iPlayer] = 0
			SRTT.RespectLevel[iPlayer] = math.max((SRTT.RespectLevel[iPlayer] - 3), 0)
			LuaEvents.SRTTRefreshRespectDisplay()

			for i = GameDefines.MAX_MAJOR_CIVS, GameDefines.MAX_CIV_PLAYERS - 1, 1 do
				local pCityState = Players[i]
				if Teams[pPlayer:GetTeam()]:IsHasMet(pCityState:GetTeam()) then
					pCityState:ChangeMinorCivFriendshipWithMajor(iPlayer, 30)
				end
			end

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_SRTT_JULIUS_RETURNS_OUTCOME_RESULT_1_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_SRTT_JULIUS_RETURNS"))
		end)
	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_SaintsJuliusReturns.Outcomes[2] = {}
	Event_SaintsJuliusReturns.Outcomes[2].Name = "TXT_KEY_EVENT_SRTT_JULIUS_RETURNS_OUTCOME_2"
	Event_SaintsJuliusReturns.Outcomes[2].Desc = "TXT_KEY_EVENT_SRTT_JULIUS_RETURNS_OUTCOME_RESULT_2"
	Event_SaintsJuliusReturns.Outcomes[2].CanFunc = (
		function(pPlayer)			
			return true
		end
		)
	Event_SaintsJuliusReturns.Outcomes[2].DoFunc = (
		function(pPlayer) 
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_SRTT_JULIUS_RETURNS_OUTCOME_RESULT_2_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_SRTT_JULIUS_RETURNS"))
		end)


	Event_SaintsJuliusReturns.Outcomes[3] = {}
	Event_SaintsJuliusReturns.Outcomes[3].Name = "TXT_KEY_EVENT_SRTT_JULIUS_RETURNS_OUTCOME_3"
	Event_SaintsJuliusReturns.Outcomes[3].Desc = "TXT_KEY_EVENT_SRTT_JULIUS_RETURNS_OUTCOME_RESULT_3"
	Event_SaintsJuliusReturns.Outcomes[3].CanFunc = (
		function(pPlayer)			
			return true
		end
		)
	Event_SaintsJuliusReturns.Outcomes[3].DoFunc = (
		function(pPlayer)
			local iPlayer = pPlayer:GetID()
			local gT = MapModData.gT
			SRTT.RespectLevel[iPlayer] = math.min((SRTT.RespectLevel[iPlayer] + 3), 25)
			LuaEvents.SRTTRefreshRespectDisplay()

			pPlayer:ChangeAnarchyNumTurns(3)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_SRTT_JULIUS_RETURNS_OUTCOME_RESULT_3_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_SRTT_JULIUS_RETURNS"))
		end)
	
Events_AddCivilisationSpecificScheduled(GameInfoTypes["CIVILIZATION_THIRD_STREET_SAINTS"], "Event_SaintsJuliusReturns", Event_SaintsJuliusReturns, 2006, true)