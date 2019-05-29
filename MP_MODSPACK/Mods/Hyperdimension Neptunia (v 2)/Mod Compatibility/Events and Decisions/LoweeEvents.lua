-- LoweeEvents
-- Author: Vice
-- DateCreated: 3/23/2015 9:50:52 PM
--------------------------------------------------------------

local PRODUCTION_SPEED_MOD = GameInfo.GameSpeeds[PreGame.GetGameSpeed()].ConstructPercent / 100

local Event_LoweeShovelware = {}
    Event_LoweeShovelware.Name = "TXT_KEY_EVENT_VV_LOWEE_SEAL_OF_QUALITY"
	Event_LoweeShovelware.Desc = "TXT_KEY_EVENT_VV_LOWEE_SEAL_OF_QUALITY_DESC"
	Event_LoweeShovelware.tValidCivs = 
		{
		["CIVILIZATION_VV_LOWEE"]		= true,
		["CIVILIZATION_VV_LOWEE_WH"]	= true,
		["CIVILIZATION_VV_LOWEE_ULTRA"]		= true,
		["CIVILIZATION_VV_LOWEE_WH_ULTRA"]	= true
		}
	Event_LoweeShovelware.Weight = 20
	Event_LoweeShovelware.CanFunc = (
		function(pPlayer)
			if not pPlayer:GetCapitalCity() then return false end
			if load(pPlayer, "Event_LoweeShovelware") == true then return false end
			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			return Event_LoweeShovelware.tValidCivs[sCivType]
		end
		)
	Event_LoweeShovelware.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_LoweeShovelware.Outcomes[1] = {}
	Event_LoweeShovelware.Outcomes[1].Name = "TXT_KEY_EVENT_VV_LOWEE_SEAL_OF_QUALITY_OUTCOME_1"
	Event_LoweeShovelware.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_SEAL_OF_QUALITY_OUTCOME_1_RESULT")
	Event_LoweeShovelware.Outcomes[1].CanFunc = (
		function(pPlayer)
			return true
		end
		)
	Event_LoweeShovelware.Outcomes[1].DoFunc = (
		function(pPlayer)
			pPlayer:GetCapitalCity():SetNumRealBuilding(GameInfoTypes.BUILDING_EVENTS_LOWEE_SHOVELWARE_ALLOW, 1, true)
			save(pPlayer, "Event_LoweeShovelware", true)
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_SEAL_OF_QUALITY_OUTCOME_1_NOTIFICATION"), Locale.ConvertTextKey(Event_LoweeShovelware.Name))
		end
		)

	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_LoweeShovelware.Outcomes[2] = {}
	Event_LoweeShovelware.Outcomes[2].Name = "TXT_KEY_EVENT_VV_LOWEE_SEAL_OF_QUALITY_OUTCOME_2"
	Event_LoweeShovelware.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_SEAL_OF_QUALITY_OUTCOME_2_RESULT")
	Event_LoweeShovelware.Outcomes[2].CanFunc = (
		function(pPlayer)
			return true
		end
		)
	Event_LoweeShovelware.Outcomes[2].DoFunc = (
		function(pPlayer)
			pPlayer:GetCapitalCity():SetNumRealBuilding(GameInfoTypes.BUILDING_EVENTS_LOWEE_SHOVELWARE_DENY, 1, true)
			save(pPlayer, "Event_LoweeShovelware", true)
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_SEAL_OF_QUALITY_OUTCOME_2_NOTIFICATION"), Locale.ConvertTextKey(Event_LoweeShovelware.Name))
		end
		)

for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_LoweeShovelware.tValidCivs[sCiv] then
			tEvents.Event_LoweeShovelware = Event_LoweeShovelware
			break
		end
	end
end



local Event_LoweeStreaming = {}
    Event_LoweeStreaming.Name = "TXT_KEY_EVENT_VV_LOWEE_STREAMING"
	Event_LoweeStreaming.Desc = "TXT_KEY_EVENT_VV_LOWEE_STREAMING_DESC"
	Event_LoweeStreaming.Data1 = {}
	Event_LoweeStreaming.Data2 = nil
	Event_LoweeStreaming.Data3 = nil
	Event_LoweeStreaming.tValidCivs = 
		{
		["CIVILIZATION_VV_LOWEE"]		= true,
		["CIVILIZATION_VV_LOWEE_WH"]	= true,
		["CIVILIZATION_VV_LOWEE_ULTRA"]		= true,
		["CIVILIZATION_VV_LOWEE_WH_ULTRA"]	= true
		}
	Event_LoweeStreaming.Weight = 20
	Event_LoweeStreaming.CanFunc = (
		function(pPlayer)
			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			if Event_LoweeStreaming.tValidCivs[sCivType] then
				Event_LoweeStreaming.Data1 = {}
				for iCS, pCS in pairs(Players) do
					if (pCS:IsAlive() and pCS:IsMinorCiv() and Teams[pPlayer:GetTeam()]:IsHasMet(pCS:GetTeam()) and not(Teams[pPlayer:GetTeam()]:IsAtWar(pCS:GetTeam()))) then
						table.insert(Event_LoweeStreaming.Data1, pCS)
					end
				end
				if #Event_LoweeStreaming.Data1 < 1 then return false end
			
				Event_LoweeStreaming.Data2 = Event_LoweeStreaming.Data1[GetRandom(1, #Event_LoweeStreaming.Data1)]
				Event_LoweeStreaming.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_STREAMING_DESC", Event_LoweeStreaming.Data2:GetCivilizationAdjectiveKey())
				return true
			end
		end
		)
	Event_LoweeStreaming.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_LoweeStreaming.Outcomes[1] = {}
	Event_LoweeStreaming.Outcomes[1].Name = "TXT_KEY_EVENT_VV_LOWEE_STREAMING_OUTCOME_1"
	Event_LoweeStreaming.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_STREAMING_OUTCOME_1_RESULT")
	Event_LoweeStreaming.Outcomes[1].CanFunc = (
		function(pPlayer, _, pMinor)
			local iCulture = 50 * math.max(1, pPlayer:GetCurrentEra())
			Event_LoweeStreaming.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_STREAMING_OUTCOME_1_RESULT", iCulture, pMinor:GetName())
			return true
		end
		)
	Event_LoweeStreaming.Outcomes[1].DoFunc = (
		function(pPlayer, _, pMinor)
			local iCulture = 50 * math.max(1, pPlayer:GetCurrentEra())
			pPlayer:ChangeJONSCulture(iCulture)
			pMinor:ChangeMinorCivFriendshipWithMajor(pPlayer:GetID(), -30)
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_STREAMING_OUTCOME_1_NOTIFICATION", pMinor:GetName()), Locale.ConvertTextKey(Event_LoweeStreaming.Name))
		end
		)
	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_LoweeStreaming.Outcomes[2] = {}
	Event_LoweeStreaming.Outcomes[2].Name = "TXT_KEY_EVENT_VV_LOWEE_STREAMING_OUTCOME_2"
	Event_LoweeStreaming.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_STREAMING_OUTCOME_2_RESULT")
	Event_LoweeStreaming.Outcomes[2].CanFunc = (
		function(pPlayer, _, pMinor)
			Event_LoweeStreaming.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_STREAMING_OUTCOME_2_RESULT", pMinor:GetName())
			return true
		end
		)
	Event_LoweeStreaming.Outcomes[2].DoFunc = (
		function(pPlayer, _, pMinor)
			pMinor:ChangeMinorCivFriendshipWithMajor(pPlayer:GetID(), 20)
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_STREAMING_OUTCOME_2_NOTIFICATION", pMinor:GetName()), Locale.ConvertTextKey(Event_LoweeStreaming.Name))
		end
		)

	--=========================================================
	-- Outcome 3
	--=========================================================
	Event_LoweeStreaming.Outcomes[3] = {}
	Event_LoweeStreaming.Outcomes[3].Name = "TXT_KEY_EVENT_VV_LOWEE_STREAMING_OUTCOME_3"
	Event_LoweeStreaming.Outcomes[3].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_STREAMING_OUTCOME_3_RESULT")
	Event_LoweeStreaming.Outcomes[3].CanFunc = (
		function(pPlayer, _, pMinor)
			local iGold = 70 * math.max(1, pPlayer:GetCurrentEra())
			Event_LoweeStreaming.Outcomes[3].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_STREAMING_OUTCOME_3_RESULT", iGold, pMinor:GetName())
			return true
		end
		)
	Event_LoweeStreaming.Outcomes[3].DoFunc = (
		function(pPlayer, _, pMinor)
			local iGold = 70 * math.max(1, pPlayer:GetCurrentEra())
			pPlayer:ChangeGold(iGold)
			pMinor:ChangeMinorCivFriendshipWithMajor(pPlayer:GetID(), -10)
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_STREAMING_OUTCOME_3_NOTIFICATION", pMinor:GetName()), Locale.ConvertTextKey(Event_LoweeStreaming.Name))
		end
		)


for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_LoweeStreaming.tValidCivs[sCiv] then
			tEvents.Event_LoweeStreaming = Event_LoweeStreaming
			break
		end
	end
end



local Event_LoweeTemperTantrum = {}
    Event_LoweeTemperTantrum.Name = "TXT_KEY_EVENT_VV_LOWEE_TEMPER_TANTRUM"
	Event_LoweeTemperTantrum.Desc = "TXT_KEY_EVENT_VV_LOWEE_TEMPER_TANTRUM_DESC"
	Event_LoweeTemperTantrum.tValidCivs = 
		{
		["CIVILIZATION_VV_LOWEE"]		= true,
		["CIVILIZATION_VV_LOWEE_WH"]	= true,
		["CIVILIZATION_VV_LOWEE_ULTRA"]		= true,
		["CIVILIZATION_VV_LOWEE_WH_ULTRA"]	= true
		}
	Event_LoweeTemperTantrum.Weight = 20
	Event_LoweeTemperTantrum.CanFunc = (
		function(pPlayer)
			local pCapital = pPlayer:GetCapitalCity()
			if pCapital and pCapital:GetPopulation() > 1 then
				local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
				return Event_LoweeTemperTantrum.tValidCivs[sCivType]
			end
			return false
		end
		)
	Event_LoweeTemperTantrum.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_LoweeTemperTantrum.Outcomes[1] = {}
	Event_LoweeTemperTantrum.Outcomes[1].Name = "TXT_KEY_EVENT_VV_LOWEE_TEMPER_TANTRUM_OUTCOME_1"
	Event_LoweeTemperTantrum.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_TEMPER_TANTRUM_OUTCOME_1_RESULT")
	Event_LoweeTemperTantrum.Outcomes[1].CanFunc = (
		function(pPlayer)
			return true
		end
		)
	Event_LoweeTemperTantrum.Outcomes[1].DoFunc = (
		function(pPlayer, pCity)
			local pCapital = pPlayer:GetCapitalCity()
			pCapital:ChangeDamage(50)
			pCapital:ChangePopulation(-1, true)
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_TEMPER_TANTRUM_OUTCOME_1_NOTIFICATION"), Locale.ConvertTextKey(Event_LoweeTemperTantrum.Name))
		end
		)

for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_LoweeTemperTantrum.tValidCivs[sCiv] then
			tEvents.Event_LoweeTemperTantrum = Event_LoweeTemperTantrum
			break
		end
	end
end







local Event_LoweeBashTripped = {}
    Event_LoweeBashTripped.Name = "TXT_KEY_EVENT_VV_LOWEE_TRIPPED"
	Event_LoweeBashTripped.Desc = "TXT_KEY_EVENT_VV_LOWEE_TRIPPED_DESC"
	Event_LoweeBashTripped.tValidCivs = 
		{
		["CIVILIZATION_VV_LOWEE"]		= true,
		["CIVILIZATION_VV_LOWEE_WH"]	= true,
		["CIVILIZATION_VV_LOWEE_ULTRA"]		= true,
		["CIVILIZATION_VV_LOWEE_WH_ULTRA"]	= true
		}
	Event_LoweeBashTripped.Weight = 500
	Event_LoweeBashTripped.CanFunc = (
		function(pPlayer)
			if pPlayer:GetNumCities() < 1 then return end
			if not load(pPlayer, "Decisions_LoweeBashTournament") then return end
			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			return Event_LoweeBashTripped.tValidCivs[sCivType]
		end
		)
	Event_LoweeBashTripped.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_LoweeBashTripped.Outcomes[1] = {}
	Event_LoweeBashTripped.Outcomes[1].Name = "TXT_KEY_EVENT_VV_LOWEE_TRIPPED_OUTCOME_1"
	Event_LoweeBashTripped.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_TRIPPED_OUTCOME_1_RESULT")
	Event_LoweeBashTripped.Outcomes[1].CanFunc = (
		function(pPlayer)
			local iTurns = math.ceil(1 * iMod)
			Event_LoweeBashTripped.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_TRIPPED_OUTCOME_1_RESULT", iTurns)
			return true
		end
		)
	Event_LoweeBashTripped.Outcomes[1].DoFunc = (
		function(pPlayer)
			local pCapital = pPlayer:GetCapitalCity() 
			local iTurns = math.ceil(1 * iMod)
			pCapital:ChangeResistanceTurns(iTurns)			
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_TRIPPED_OUTCOME_1_NOTIFICATION"), Locale.ConvertTextKey(Event_LoweeBashTripped.Name))
		end
		)

for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_LoweeBashTripped.tValidCivs[sCiv] then
			tEvents.Event_LoweeBashTripped = Event_LoweeBashTripped
			break
		end
	end
end


local Event_LoweeGuestFighter = {}
    Event_LoweeGuestFighter.Name = "TXT_KEY_EVENT_VV_LOWEE_GUEST_FIGHTER"
	Event_LoweeGuestFighter.Desc = "TXT_KEY_EVENT_VV_LOWEE_GUEST_FIGHTER_DESC"
	Event_LoweeGuestFighter.Data1 = nil
	Event_LoweeGuestFighter.Data2 = nil
	Event_LoweeGuestFighter.Data3 = nil
	Event_LoweeGuestFighter.tValidCivs = 
		{
		["CIVILIZATION_VV_LOWEE"]		= true,
		["CIVILIZATION_VV_LOWEE_WH"]	= true,
		["CIVILIZATION_VV_LOWEE_ULTRA"]		= true,
		["CIVILIZATION_VV_LOWEE_WH_ULTRA"]	= true
		}
	Event_LoweeGuestFighter.Weight = 500
	Event_LoweeGuestFighter.CanFunc = (
		function(pPlayer)
			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			if Event_LoweeGuestFighter.tValidCivs[sCivType] == true then
				print("Event_LoweeGuestFighter")
				if load(pPlayer, "Decisions_LoweeBashTournament") == nil then return end
				if load(pPlayer, "Event_LoweeGuestFighter") then return end
				local tCivs = {}
				for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
					print("Looping over civ slot #"..i)
					local pLoop = Players[i]
					if pLoop ~= pPlayer then
						if pLoop:IsAlive() and pPlayer:IsDoF(i) then
							print("Adding "..pLoop:GetName().." to the civs table.")
							tCivs[#tCivs + 1] = pLoop
						end
					end
				end
				if #tCivs == 0 then print("No valid civs") return false end
				print(#tCivs)
				local iKey = GetRandom(1, #tCivs)
				print(iKey)
				Event_LoweeGuestFighter.Data1 = tCivs[iKey]
				print(Event_LoweeGuestFighter.Data1:GetName())
				table.remove(tCivs, iKey)
				if #tCivs > 0 then
					local iKey2 = GetRandom(1, #tCivs)
					Event_LoweeGuestFighter.Data2 = tCivs[iKey2]
					table.remove(tCivs, iKey2)
				end
				if #tCivs > 0 then
					local iKey3 = GetRandom(1, #tCivs)
					Event_LoweeGuestFighter.Data3 = tCivs[iKey3]
					table.remove(tCivs, iKey3)
				end
				return true
			end
		end
		)
	Event_LoweeGuestFighter.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_LoweeGuestFighter.Outcomes[1] = {}
	Event_LoweeGuestFighter.Outcomes[1].Name = "TXT_KEY_EVENT_VV_LOWEE_GUEST_FIGHTER_OUTCOME_1"
	Event_LoweeGuestFighter.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_GUEST_FIGHTER_OUTCOME_RESULT")
	Event_LoweeGuestFighter.Outcomes[1].CanFunc = (
		function(pPlayer, pCiv1, pCiv2, pCiv3)
			if pCiv1 then
				Event_LoweeGuestFighter.Outcomes[1].Name = pCiv1:GetName().."!"
				local iTurns = math.floor(20 * iMod)
				Event_LoweeGuestFighter.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_GUEST_FIGHTER_OUTCOME_RESULT", iTurns)
				return true
			end
		end
		)
	Event_LoweeGuestFighter.Outcomes[1].DoFunc = (
		function(pPlayer, pCiv1, pCiv2, pCiv3)
			local iTurns = math.floor(20 * iMod)
			for pCity in pPlayer:Cities() do
				pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_EVENTS_LOWEE_GUEST_FIGHTER, 1, true)
			end
			for pCity in pCiv1:Cities() do
				pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_EVENTS_LOWEE_GUEST_FIGHTER, 1, true)
			end
			save(pPlayer, "Event_LoweeGuestFighter", pCiv1:GetID())
			save(pPlayer, "Event_LoweeGuestFighter_Turn", Game:GetGameTurn())
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_GUEST_FIGHTER_OUTCOME_NOTIFICATION", pCiv1:GetName()), Locale.ConvertTextKey(Event_LoweeGuestFighter.Name))
			JFD_SendNotification(pCiv1:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_GUEST_FIGHTER_OUTCOME_NOTIFICATION_OTHER", pPlayer:GetName(), iTurns), Locale.ConvertTextKey(Event_LoweeGuestFighter.Name))
		end
		)
	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_LoweeGuestFighter.Outcomes[2] = {}
	Event_LoweeGuestFighter.Outcomes[2].Name = "TXT_KEY_EVENT_VV_LOWEE_GUEST_FIGHTER_OUTCOME_2"
	Event_LoweeGuestFighter.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_GUEST_FIGHTER_OUTCOME_RESULT")
	Event_LoweeGuestFighter.Outcomes[2].CanFunc = (
		function(pPlayer, pCiv1, pCiv2, pCiv3)
			if pCiv2 then
				Event_LoweeGuestFighter.Outcomes[2].Name = pCiv2:GetName().."!"
				local iTurns = math.floor(20 * iMod)
				Event_LoweeGuestFighter.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_GUEST_FIGHTER_OUTCOME_RESULT", iTurns)
				return true
			end
		end
		)
	Event_LoweeGuestFighter.Outcomes[2].DoFunc = (
		function(pPlayer, pCiv1, pCiv2, pCiv3)
			local iTurns = math.floor(20 * iMod)
			for pCity in pPlayer:Cities() do
				pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_EVENTS_LOWEE_GUEST_FIGHTER, 1, true)
			end
			for pCity in pCiv2:Cities() do
				pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_EVENTS_LOWEE_GUEST_FIGHTER, 1, true)
			end
			save(pPlayer, "Event_LoweeGuestFighter", pCiv2:GetID())
			save(pPlayer, "Event_LoweeGuestFighter_Turn", Game:GetGameTurn())
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_GUEST_FIGHTER_OUTCOME_NOTIFICATION", pCiv2:GetName()), Locale.ConvertTextKey(Event_LoweeGuestFighter.Name))
			JFD_SendNotification(pCiv2:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_GUEST_FIGHTER_OUTCOME_NOTIFICATION_OTHER", pPlayer:GetName(), iTurns), Locale.ConvertTextKey(Event_LoweeGuestFighter.Name))
		end
		)

	--=========================================================
	-- Outcome 3
	--=========================================================
	Event_LoweeGuestFighter.Outcomes[3] = {}
	Event_LoweeGuestFighter.Outcomes[3].Name = "TXT_KEY_EVENT_VV_LOWEE_GUEST_FIGHTER_OUTCOME_3"
	Event_LoweeGuestFighter.Outcomes[3].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_GUEST_FIGHTER_OUTCOME_RESULT")
	Event_LoweeGuestFighter.Outcomes[3].CanFunc = (
		function(pPlayer, pCiv1, pCiv2, pCiv3)
			if pCiv3 then
				Event_LoweeGuestFighter.Outcomes[3].Name = pCiv3:GetName().."!"
				local iTurns = math.floor(20 * iMod)
				Event_LoweeGuestFighter.Outcomes[3].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_GUEST_FIGHTER_OUTCOME_RESULT", iTurns)
				return true
			end
		end
		)
	Event_LoweeGuestFighter.Outcomes[3].DoFunc = (
		function(pPlayer, pCiv1, pCiv2, pCiv3)
			local iTurns = math.floor(20 * iMod)
			for pCity in pPlayer:Cities() do
				pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_EVENTS_LOWEE_GUEST_FIGHTER, 1, true)
			end
			for pCity in pCiv3:Cities() do
				pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_EVENTS_LOWEE_GUEST_FIGHTER, 1, true)
			end
			save(pPlayer, "Event_LoweeGuestFighter", pCiv3:GetID())
			save(pPlayer, "Event_LoweeGuestFighter_Turn", Game:GetGameTurn())
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_GUEST_FIGHTER_OUTCOME_NOTIFICATION", pCiv3:GetName()), Locale.ConvertTextKey(Event_LoweeGuestFighter.Name))
			JFD_SendNotification(pCiv3:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_GUEST_FIGHTER_OUTCOME_NOTIFICATION_OTHER", pPlayer:GetName(), iTurns), Locale.ConvertTextKey(Event_LoweeGuestFighter.Name))
		end
		)

for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_LoweeGuestFighter.tValidCivs[sCiv] then
			tEvents.Event_LoweeGuestFighter = Event_LoweeGuestFighter
			break
		end
	end
end




local Event_LoweeStar = {}
    Event_LoweeStar.Name = "TXT_KEY_EVENT_VV_LOWEE_STAR"
	Event_LoweeStar.Desc = "TXT_KEY_EVENT_VV_LOWEE_STAR_DESC"
	Event_LoweeStar.tValidCivs = 
		{
		["CIVILIZATION_VV_LOWEE"]		= true,
		["CIVILIZATION_VV_LOWEE_WH"]	= true,
		["CIVILIZATION_VV_LOWEE_ULTRA"]		= true,
		["CIVILIZATION_VV_LOWEE_WH_ULTRA"]	= true
		}
	Event_LoweeStar.Weight = 250
	Event_LoweeStar.CanFunc = (
		function(pPlayer)
			if not load(pPlayer, "Decisions_LoweeBashTournament") then return end
			if load(pPlayer, "Event_LoweeStar") then return end
			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			return Event_LoweeStar.tValidCivs[sCivType]
		end
		)
	Event_LoweeStar.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_LoweeStar.Outcomes[1] = {}
	Event_LoweeStar.Outcomes[1].Name = "TXT_KEY_EVENT_VV_LOWEE_STAR_OUTCOME_1"
	Event_LoweeStar.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_STAR_OUTCOME_1_RESULT")
	Event_LoweeStar.Outcomes[1].CanFunc = (
		function(pPlayer)
			return true
		end
		)
	Event_LoweeStar.Outcomes[1].DoFunc = (
		function(pPlayer)
			for pUnit in pPlayer:Units() do
				pUnit:SetDamage(0)
			end
			for pCity in pPlayer:Cities() do
				pCity:SetDamage(0)
			end
			Events.AudioPlay2DSound("AS2D_EVENTS_VV_LOWEE_STAR")
			save(pPlayer, "Event_LoweeStar", Game:GetGameTurn())
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_STAR_OUTCOME_1_NOTIFICATION"), Locale.ConvertTextKey(Event_LoweeStar.Name))
		end
		)

for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_LoweeStar.tValidCivs[sCiv] then
			tEvents.Event_LoweeStar = Event_LoweeStar
			break
		end
	end
end


local Event_LoweeSubspace = {}
    Event_LoweeSubspace.Name = "TXT_KEY_EVENT_VV_LOWEE_SUBSPACE"
	Event_LoweeSubspace.Desc = "TXT_KEY_EVENT_VV_LOWEE_SUBSPACE_DESC"
	Event_LoweeSubspace.tValidCivs = 
		{
		["CIVILIZATION_VV_LOWEE"]		= true,
		["CIVILIZATION_VV_LOWEE_WH"]	= true,
		["CIVILIZATION_VV_LOWEE_ULTRA"]		= true,
		["CIVILIZATION_VV_LOWEE_WH_ULTRA"]	= true
		}
	Event_LoweeSubspace.Weight = 250
	Event_LoweeSubspace.CanFunc = (
		function(pPlayer)
			if not load(pPlayer, "Decisions_LoweeBashTournament") then return end
			if load(pPlayer, "Event_LoweeSubspace") then return end
			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			return Event_LoweeStar.tValidCivs[sCivType]
		end
		)
	Event_LoweeSubspace.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_LoweeSubspace.Outcomes[1] = {}
	Event_LoweeSubspace.Outcomes[1].Name = "TXT_KEY_EVENT_VV_LOWEE_SUBSPACE_OUTCOME_1"
	Event_LoweeSubspace.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_SUBSPACE_OUTCOME_1_RESULT")
	Event_LoweeSubspace.Outcomes[1].CanFunc = (
		function(pPlayer)
			return true
		end
		)
	Event_LoweeSubspace.Outcomes[1].DoFunc = (
		function(pPlayer)
			local iTurns = pPlayer:GetGoldenAgeLength() * 3
			pPlayer:ChangeGoldenAgeTurns(iTurns)
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_SUBSPACE_OUTCOME_1_NOTIFICATION"), Locale.ConvertTextKey(Event_LoweeSubspace.Name))
		end
		)

for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_LoweeSubspace.tValidCivs[sCiv] then
			tEvents.Event_LoweeSubspace = Event_LoweeSubspace
			break
		end
	end
end


-------------END LOWEE BASH EVENTS---------------------------------------------------

local Event_LoweeBlog = {}
    Event_LoweeBlog.Name = "TXT_KEY_EVENT_VV_LOWEE_BLOG"
	Event_LoweeBlog.Desc = "TXT_KEY_EVENT_VV_LOWEE_BLOG_DESC"
	Event_LoweeBlog.tValidCivs = 
		{
		["CIVILIZATION_VV_LOWEE"]		= true,
		["CIVILIZATION_VV_LOWEE_WH"]	= true,
		["CIVILIZATION_VV_LOWEE_ULTRA"]		= true,
		["CIVILIZATION_VV_LOWEE_WH_ULTRA"]	= true
		}
	Event_LoweeBlog.Weight = 250
	Event_LoweeBlog.CanFunc = (
		function(pPlayer)
			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			if Event_LoweeBlog.tValidCivs[sCivType] == true then
				local iPlayer = pPlayer:GetID()
				local iTimes = load(pPlayer, "Event_LoweeBlog")
				if not iTimes then iTimes = 0 end
				if iTimes >= 5 then return false end
				if iTimes >= 1 then
					Event_LoweeBlog.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_BLOG_REPEAT_DESC")
				end
				local iShareReqs = 1500 * PRODUCTION_SPEED_MOD * (iTimes + 1)
				if MapModData.HDNMod.Shares[iPlayer] and MapModData.HDNMod.Shares[iPlayer] >= iShareReqs then
					return true
				end
			end
			return false
		end
		)
	Event_LoweeBlog.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_LoweeBlog.Outcomes[1] = {}
	Event_LoweeBlog.Outcomes[1].Name = "TXT_KEY_EVENT_VV_LOWEE_BLOG_OUTCOME_1"
	Event_LoweeBlog.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_BLOG_OUTCOME_1_RESULT")
	Event_LoweeBlog.Outcomes[1].CanFunc = (
		function(pPlayer)
			if load(pPlayer, "Event_LoweeBlog1") == nil then
				local iCulture = math.ceil(10 * iMod)
				Event_LoweeBlog.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_BLOG_OUTCOME_1_RESULT", iCulture)
				return true
			end
		end
		)
	Event_LoweeBlog.Outcomes[1].DoFunc = (
		function(pPlayer)
		
			local iCulture = math.ceil(10 * iMod)
			pPlayer:ChangeJONSCulture(iCulture * pPlayer:GetTotalPopulation())
			
			save(pPlayer, "Event_LoweeBlog1", true)
			local iTimes = load(pPlayer, "Event_LoweeBlog")
			if not iTimes then
				save(pPlayer, "Event_LoweeBlog", 1)
			else
				save(pPlayer, "Event_LoweeBlog", iTimes + 1)
			end
			
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_BLOG_OUTCOME_NOTIFICATION"), Locale.ConvertTextKey(Event_LoweeBlog.Name))
		end
		)
		
	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_LoweeBlog.Outcomes[2] = {}
	Event_LoweeBlog.Outcomes[2].Name = "TXT_KEY_EVENT_VV_LOWEE_BLOG_OUTCOME_2"
	Event_LoweeBlog.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_BLOG_OUTCOME_2_RESULT")
	Event_LoweeBlog.Outcomes[2].CanFunc = (
		function(pPlayer)
			if load(pPlayer, "Event_LoweeBlog2") == nil then
				local iCulture = math.ceil(5 * iMod)
				Event_LoweeBlog.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_BLOG_OUTCOME_2_RESULT", iCulture)
				return true
			end
		end
		)
	Event_LoweeBlog.Outcomes[2].DoFunc = (
		function(pPlayer)
		
			local iCulture = math.ceil(8 * iMod)
			local iTotalCulture = 0
			local iPlayer = pPlayer:GetID()
			
			for pCity in pPlayer:Cities() do
				local iNumPlots = pCity:GetNumCityPlots();
				for iPlot = 0, iNumPlots - 1 do
					local pPlot = pCity:GetCityIndexPlot(iPlot)
					if pPlot and pPlot:GetOwner() == iPlayer then
						if pPlot:GetTerrainType() == GameInfoTypes.TERRAIN_SNOW or pPlot:GetTerrainType() == GameInfoTypes.TERRAIN_TUNDRA then
							iTotalCulture = iTotalCulture + iCulture
						end
					end
				end
			end
			
			pPlayer:ChangeJONSCulture(iTotalCulture)
			
			save(pPlayer, "Event_LoweeBlog2", true)
			local iTimes = load(pPlayer, "Event_LoweeBlog")
			if not iTimes then
				save(pPlayer, "Event_LoweeBlog", 1)
			else
				save(pPlayer, "Event_LoweeBlog", iTimes + 1)
			end
			
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_BLOG_OUTCOME_NOTIFICATION"), Locale.ConvertTextKey(Event_LoweeBlog.Name))
		end
		)
		
	--=========================================================
	-- Outcome 3
	--=========================================================
	Event_LoweeBlog.Outcomes[3] = {}
	Event_LoweeBlog.Outcomes[3].Name = "TXT_KEY_EVENT_VV_LOWEE_BLOG_OUTCOME_3"
	Event_LoweeBlog.Outcomes[3].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_BLOG_OUTCOME_3_RESULT")
	Event_LoweeBlog.Outcomes[3].CanFunc = (
		function(pPlayer)
			if load(pPlayer, "Event_LoweeBlog3") == nil then
				local iGold = math.ceil(100 * iMod)
				Event_LoweeBlog.Outcomes[3].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_BLOG_OUTCOME_3_RESULT", iGold)
				return true
			end
		end
		)
	Event_LoweeBlog.Outcomes[3].DoFunc = (
		function(pPlayer)
	
			pPlayer:ChangeNumFreeGreatPeople(1)
			
			save(pPlayer, "Event_LoweeBlog3", true)
			local iTimes = load(pPlayer, "Event_LoweeBlog")
			if not iTimes then
				save(pPlayer, "Event_LoweeBlog", 1)
			else
				save(pPlayer, "Event_LoweeBlog", iTimes + 1)
			end
			
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_BLOG_OUTCOME_NOTIFICATION"), Locale.ConvertTextKey(Event_LoweeBlog.Name))
		end
		)
		
	--=========================================================
	-- Outcome 4
	--=========================================================
	Event_LoweeBlog.Outcomes[4] = {}
	Event_LoweeBlog.Outcomes[4].Name = "TXT_KEY_EVENT_VV_LOWEE_BLOG_OUTCOME_4"
	Event_LoweeBlog.Outcomes[4].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_BLOG_OUTCOME_4_RESULT")
	Event_LoweeBlog.Outcomes[4].CanFunc = (
		function(pPlayer)
			if load(pPlayer, "Event_LoweeBlog4") == nil then
				return true
			end
		end
		)
	Event_LoweeBlog.Outcomes[4].DoFunc = (
		function(pPlayer)
		
			for pUnit in pPlayer:Units() do
				if pUnit:IsCombatUnit() or pUnit:GetDomainType() == DomainTypes.DOMAIN_AIR then
					pUnit:ChangeExperience(10)
				end
			end

			save(pPlayer, "Event_LoweeBlog4", true)
			local iTimes = load(pPlayer, "Event_LoweeBlog")
			if not iTimes then
				save(pPlayer, "Event_LoweeBlog", 1)
			else
				save(pPlayer, "Event_LoweeBlog", iTimes + 1)
			end
			
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_BLOG_OUTCOME_NOTIFICATION"), Locale.ConvertTextKey(Event_LoweeBlog.Name))
		end
		)
		
		
	--=========================================================
	-- Outcome 5
	--=========================================================
	Event_LoweeBlog.Outcomes[5] = {}
	Event_LoweeBlog.Outcomes[5].Name = "TXT_KEY_EVENT_VV_LOWEE_BLOG_OUTCOME_5"
	Event_LoweeBlog.Outcomes[5].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_BLOG_OUTCOME_5_RESULT")
	Event_LoweeBlog.Outcomes[5].CanFunc = (
		function(pPlayer)
			if load(pPlayer, "Event_LoweeBlog5") == nil then
				return true
			end
		end
		)
	Event_LoweeBlog.Outcomes[5].DoFunc = (
		function(pPlayer)
		
			pPlayer:ChangeGoldenAgeTurns(pPlayer:GetGoldenAgeLength())

			save(pPlayer, "Event_LoweeBlog5", true)
			local iTimes = load(pPlayer, "Event_LoweeBlog")
			if not iTimes then
				save(pPlayer, "Event_LoweeBlog", 1)
			else
				save(pPlayer, "Event_LoweeBlog", iTimes + 1)
			end
			
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LOWEE_BLOG_OUTCOME_NOTIFICATION"), Locale.ConvertTextKey(Event_LoweeBlog.Name))
		end
		)

for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_LoweeBlog.tValidCivs[sCiv] then
			tEvents.Event_LoweeBlog = Event_LoweeBlog
			break
		end
	end
end



function LoweeOnDoTurnEventListener(iPlayer)
	local pPlayer = Players[iPlayer]
	if load(pPlayer, "Event_LoweeGuestFighter") then
		local iOtherPlayer = load(pPlayer, "Event_LoweeGuestFighter")
		local pOtherPlayer = Players[iOtherPlayer]
		if Game:GetGameTurn() - load(pPlayer, "Event_LoweeGuestFighter_Turn") >= math.floor(20 * iMod) then
			for pCity in pPlayer:Cities() do
				pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_EVENTS_LOWEE_GUEST_FIGHTER, 0)
			end
			for pCity in pOtherPlayer:Cities() do
				pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_EVENTS_LOWEE_GUEST_FIGHTER, 0)
			end
			save(pPlayer, "Event_LoweeGuestFighter", nil)
			save(pPlayer, "Event_LoweeGuestFighter_Turn", nil)
		end
	end
	if load(pPlayer, "Event_LoweeStar") then
		local iTurn = load(pPlayer, "Event_LoweeStar")
		if Game:GetGameTurn() - iTurn >= 3 then
			save(pPlayer, "Event_LoweeStar", nil) 
		end
		for pUnit in pPlayer:Units() do
			pUnit:SetDamage(0)
		end
		for pCity in pPlayer:Cities() do
			pCity:SetDamage(0)
		end
	end
end


function LoweeDiplomacyEventHandler(iPlayer1, iPlayer2)
	local pPlayer1 = Players[iPlayer1]
	local pPlayer2 = Players[iPlayer2]
	if (load(pPlayer1, "Event_LoweeGuestFighter") and load(pPlayer1, "Event_LoweeGuestFighter") == iPlayer2) or (load(pPlayer2, "Decisions_DevoteToMadoka") and load(pPlayer2, "Event_LoweeGuestFighter") == iPlayer1) then
		return -35
	else
		return 0
	end
end

GameEvents.PlayerDoTurn.Add(LoweeOnDoTurnEventListener)