-- RiderEvents
-- Author: Vicevirtuoso
-- DateCreated: 9/11/2014 4:48:02 PM
--------------------------------------------------------------

local iNegativeDiplo = 30
local iPositiveDiplo = -20   --yes, negative numbers translate to positive diplomatic values with GetScenarioDiploModifier

--=======================================================================================================================
-- Event 1: Rider vs. Alexander (Random with high Chance, only if both Rider and Firaxis's Alexander are present and have met)
--=======================================================================================================================
local Event_RiderVsAlexander = {}
	Event_RiderVsAlexander.Name = "TXT_KEY_EVENT_RIDER_VS_ALEXANDER"
	Event_RiderVsAlexander.Desc = "TXT_KEY_EVENT_RIDER_VS_ALEXANDER_DESC"
	Event_RiderVsAlexander.Weight = 30
	Event_RiderVsAlexander.Data1 = nil
	Event_RiderVsAlexander.tValidCivs = 
	{
		["CIVILIZATION_MACEDON_FSN"]		= true,
		["CIVILIZATION_GREECE"]		= true
	}
	Event_RiderVsAlexander.CanFunc = (
		function(pPlayer)

			if load(pPlayer, "Event_RiderVsAlexander") then return false end
			
			
			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			if not Event_RiderVsAlexander.tValidCivs[sCivType] then return false end

			for i = 0, GameDefines.MAX_MAJOR_CIVS -1, 1 do
				local pLoop = Players[i]
				if pLoop ~= pPlayer and pLoop:IsAlive() and Teams[pPlayer:GetTeam()]:IsHasMet(pLoop:GetTeam()) then
					if load(pLoop, "Event_RiderVsAlexander") then return false end
					local iCivType = pLoop:GetCivilizationType()
					for sCivTypeLoop, bool in pairs(Event_RiderVsAlexander.tValidCivs) do
						if GameInfoTypes[sCivTypeLoop] == iCivType then
							Event_RiderVsAlexander.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_RIDER_VS_ALEXANDER_DESC", pLoop:GetName())
							Event_RiderVsAlexander.Data1 = pLoop
							return true
						end
					end
				end
			end

			return false

		end
		)
	Event_RiderVsAlexander.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_RiderVsAlexander.Outcomes[1] = {}
	Event_RiderVsAlexander.Outcomes[1].Name = "TXT_KEY_EVENT_RIDER_VS_ALEXANDER_OUTCOME_1"
	Event_RiderVsAlexander.Outcomes[1].Desc = "TXT_KEY_EVENT_RIDER_VS_ALEXANDER_OUTCOME_1_RESULT"
	Event_RiderVsAlexander.Outcomes[1].Weight = 5
	Event_RiderVsAlexander.Outcomes[1].CanFunc = (
		function(pPlayer, pEnemyPlayer)
			local sEnemyPlayerName = pEnemyPlayer:GetName()
			local sEnemyPlayerCivName = pEnemyPlayer:GetCivilizationShortDescription()
			local sAbility = ""
			if pEnemyPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_MACEDON_FSN then
				sAbility = Locale.ConvertTextKey("TXT_KEY_RIDER_VS_ALEXANDER_TRAIT_IF_RIDER_DEFEATED")
			elseif pEnemyPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_MACEDON_FSN then
				sAbility = Locale.ConvertTextKey("TXT_KEY_RIDER_VS_ALEXANDER_TRAIT_IF_ALEXANDER_DEFEATED")
			end

			Event_RiderVsAlexander.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_RIDER_VS_ALEXANDER_OUTCOME_1_RESULT", sEnemyPlayerCivName, sEnemyPlayerName, sAbility)

			return true
		end
		)
	Event_RiderVsAlexander.Outcomes[1].DoFunc = (
		function(pPlayer, pEnemyPlayer) 

			save(pPlayer, "Event_RiderVsAlexander", iNegativeDiplo)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_RIDER_VS_ALEXANDER_OUTCOME_RESULT_1_NOTIFICATION"), Locale.ConvertTextKey(Event_RiderVsAlexander.Name))
			JFD_SendNotification(pEnemyPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_RIDER_VS_ALEXANDER_OUTCOME_RESULT_1_NOTIFICATION_ENEMY"), Locale.ConvertTextKey(Event_RiderVsAlexander.Name))
		end
		)

	Event_RiderVsAlexander.Outcomes[1].Monitors = {}
	Event_RiderVsAlexander.Outcomes[1].Monitors[GameEvents.CityCaptureComplete] = (
	function(iCapturedPlayer, bCapital, iX, iY, iCapturingPlayer, iPop, bConquest)
		if bConquest then
			local pPlayer1 = Players[iCapturingPlayer]
			local pPlayer2 = Players[iCapturedPlayer]
			if load(pPlayer1, "Event_RiderVsAlexander") == iNegativeDiplo or load(pPlayer2, "Event_RiderVsAlexander") == iNegativeDiplo then
				local sPlayer1Civ = GameInfo.Civilizations[pPlayer1:GetCivilizationType()].Type
				local sPlayer2Civ = GameInfo.Civilizations[pPlayer2:GetCivilizationType()].Type
				if Event_RiderVsAlexander.tValidCivs[sPlayer1Civ] and Event_RiderVsAlexander.tValidCivs[sPlayer2Civ] then
					if sPlayer2Civ == "CIVILIZATION_GREECE" then
						pPlayer1:SetNumFreePolicies(1)
						pPlayer1:SetNumFreePolicies(0)
						pPlayer1:SetHasPolicy(GameInfoTypes.POLICY_EVENTS_RIDER_VS_ALEXANDER, true)
					elseif sPlayer2Civ == "CIVILIZATION_MACEDON_FSN" then
						save(pPlayer1, "Event_RiderVsAlexander_Victory", 8)
						LuaEvents.FSNRiderUpdateHappinessFromUnits(iCapturingPlayer)
					end
				end
			end
		end
	end
	)

	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_RiderVsAlexander.Outcomes[2] = {}
	Event_RiderVsAlexander.Outcomes[2].Name = "TXT_KEY_EVENT_RIDER_VS_ALEXANDER_OUTCOME_2"
	Event_RiderVsAlexander.Outcomes[2].Desc = "TXT_KEY_EVENT_RIDER_VS_ALEXANDER_OUTCOME_2_RESULT"
	Event_RiderVsAlexander.Outcomes[2].Weight = 5
	Event_RiderVsAlexander.Outcomes[2].CanFunc = (
		function(pPlayer, pEnemyPlayer)	
		
			local sEnemyPlayerCivName = pEnemyPlayer:GetCivilizationShortDescription()		

			Event_RiderVsAlexander.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_RIDER_VS_ALEXANDER_OUTCOME_2_RESULT", sEnemyPlayerCivName)

			return true
		end
		)
	Event_RiderVsAlexander.Outcomes[2].DoFunc = (
		function(pPlayer, pEnemyPlayer) 

			save(pPlayer, "Event_RiderVsAlexander", iPositiveDiplo)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_RIDER_VS_ALEXANDER_OUTCOME_RESULT_2_NOTIFICATION"), Locale.ConvertTextKey(Event_RiderVsAlexander.Name))
			JFD_SendNotification(pEnemyPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_RIDER_VS_ALEXANDER_OUTCOME_RESULT_2_NOTIFICATION_ENEMY"), Locale.ConvertTextKey(Event_RiderVsAlexander.Name))
			
		end
		)


for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_RiderVsAlexander.tValidCivs[sCiv] then
			tEvents.Event_RiderVsAlexander = Event_RiderVsAlexander
			break
		end
	end
end


GameEvents.GetScenarioDiploModifier3.Add(function(iPlayer1, iPlayer2)
	local pPlayer1 = Players[iPlayer1]
	local pPlayer2 = Players[iPlayer2]
	if load(pPlayer1, "Event_RiderVsAlexander") or load(pPlayer2, "Event_RiderVsAlexander") then
		local iValue = load(pPlayer1, "Event_RiderVsAlexander")
		if not iValue then
			iValue = load(pPlayer2, "Event_RiderVsAlexander")
		end
		local sPlayer1Civ = GameInfo.Civilizations[pPlayer1:GetCivilizationType()].Type
		local sPlayer2Civ = GameInfo.Civilizations[pPlayer2:GetCivilizationType()].Type
		if Event_RiderVsAlexander.tValidCivs[sPlayer1Civ] and Event_RiderVsAlexander.tValidCivs[sPlayer2Civ] then
			return iValue
		end
	end
	return 0
end
)


function GetAlexanderVictory(pPlayer, ttable)
	local val = load(pPlayer, "Event_RiderVsAlexander_Victory")
	if ttable then
		ttable[0] = val
	end
	return val
end

LuaEvents.FSNRiderGetAlexanderVictory.Add(GetAlexanderVictory)