-- HDNSharedEvents
-- Author: Vice
-- DateCreated: 4/2/2015 4:47:01 PM
--------------------------------------------------------------

local PRODUCTION_SPEED_MOD = GameInfo.GameSpeeds[PreGame.GetGameSpeed()].ConstructPercent / 100

--[[local Events_ConsoleWar = {}
    Events_ConsoleWar.Name = "TXT_KEY_EVENT_HDN_CONSOLE_WAR"
	Events_ConsoleWar.Desc = "TXT_KEY_EVENT_HDN_CONSOLE_WAR_DESC"
	Events_ConsoleWar.tValidCivs = 
		{
		["CIVILIZATION_VV_LEANBOX"]		= true,
		["CIVILIZATION_VV_LEANBOX_GH"]	= true,
		["CIVILIZATION_VV_LOWEE"]		= true,
		["CIVILIZATION_VV_LOWEE_WH"]	= true,
		["CIVILIZATION_VV_PLANEPTUNE"]	= true,
		["CIVILIZATION_VV_PLANEPTUNE_PH"]= true,
		["CIVILIZATION_VV_LASTATION"]	= true,
		["CIVILIZATION_VV_LASTATION_BH"]= true,
		["CIVILIZATION_VV_PLANEPTUNE_NG"]= true,
		["CIVILIZATION_VV_PLANEPTUNE_PS"]= true,
		["CIVILIZATION_VV_PLANEPTUNE_PT"]= true,
		["CIVILIZATION_VV_PLANEPTUNE_IH"]= true,
		["CIVILIZATION_VV_LASTATION_UN"]= true,
		["CIVILIZATION_VV_LASTATION_BS"]= true,
		["CIVILIZATION_VV_LOWEE_RR"]	= true,
		["CIVILIZATION_VV_LOWEE_WS"]	= true,
		["CIVILIZATION_PLANEPTUNE"]		= true, --Mogarane's Planeptune
		["CIVILIZATION_LASTATION"]		= true, --Mogarane's Lastation
		}
	Events_ConsoleWar.Weight = 100
	Events_ConsoleWar.CanFunc = (
		function(pPlayer)
			if load("GAME", "Events_ConsoleWar") == true then return end
			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			if Events_ConsoleWar.tValidCivs[sCivType] == true then
				local pTeam = Teams[pPlayer:GetTeam()]
				local iPlayer = pPlayer:GetID()
				local bAtWar = false
				for i = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
					if i ~= iPlayer then
						local pLoop = Players[i]
						if pTeam:IsAtWar(pLoop:GetTeam()) and pLoop:IsAlive() then
							local sTheirCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
							if Events_ConsoleWar.tValidCivs[sTheirCivType] == true then
								return true
							end
						end
					end
				end
			end
			return false
		end
		)
	Events_ConsoleWar.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Events_ConsoleWar.Outcomes[1] = {}
	Events_ConsoleWar.Outcomes[1].Name = "TXT_KEY_EVENT_HDN_CONSOLE_WAR_OUTCOME_1"
	Events_ConsoleWar.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_HDN_CONSOLE_WAR_OUTCOME_1_RESULT")
	Events_ConsoleWar.Outcomes[1].CanFunc = (
		function(pPlayer)
			return true
		end
		)
	Events_ConsoleWar.Outcomes[1].DoFunc = (
		function(pPlayer)
			save("GAME", "Events_ConsoleWar", true)
			
			for iLoop, pLoop in pairs(Players) do
				JFD_SendNotification(pLoop:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_HDN_CONSOLE_WAR_OUTCOME_1_NOTIFICATION"), Locale.ConvertTextKey(Events_ConsoleWar.Name))
			end
		end
		)
		
	Events_ConsoleWar.Outcomes[1].Monitors = {}
	Events_ConsoleWar.Outcomes[1].Monitors[GameEvents.UnitKilledInCombat] = (
		function(iKiller, iKilled, iUnitType)
			if load("GAME", "Events_ConsoleWar") == true then
				local pKiller = Players[iKiller]
				local pKilled = Players[iKilled]
				
				local sKillerType = GameInfo.Civilizations[pKiller:GetCivilizationType()].Type
				local sKilledType = GameInfo.Civilizations[pKilled:GetCivilizationType()].Type
				
				if Events_ConsoleWar.tValidCivs[sKillerType] == true and Events_ConsoleWar.tValidCivs[sKilledType] == true then
					local iFaith = GameInfo.Units[iUnitType].Combat
					if iFaith then
						pKiller:ChangeFaith(iFaith)
						if pKiller:GetID() == Game:GetActivePlayer() then
							Events.GameplayAlertMessage.Add(Locale.ConvertTextKey("TXT_KEY_EVENT_HDN_CONSOLE_WAR_ALERT", iFaith))
						end
					end
				end
			end
		end
	)
		

for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Events_ConsoleWar.tValidCivs[sCiv] then
			tEvents.Events_ConsoleWar = Events_ConsoleWar
			break
		end
	end
end]]




local Events_HDNBasilicom = {}
    Events_HDNBasilicom.Name = "TXT_KEY_EVENT_VV_BASILICOM_GATHERING"
	Events_HDNBasilicom.Desc = "TXT_KEY_EVENT_VV_BASILICOM_GATHERING_DESC"
	Events_HDNBasilicom.tValidCivs = 
		{
		["CIVILIZATION_VV_LEANBOX"]		= true,
		["CIVILIZATION_VV_LEANBOX_GH"]	= true,
		["CIVILIZATION_VV_LEANBOX_ULTRA"]		= true,
		["CIVILIZATION_VV_LEANBOX_GH_ULTRA"]	= true,
		["CIVILIZATION_VV_LOWEE_ULTRA"]		= true,
		["CIVILIZATION_VV_LOWEE_WH_ULTRA"]	= true,
		["CIVILIZATION_VV_LOWEE"]		= true,
		["CIVILIZATION_VV_LOWEE_WH"]	= true,
		["CIVILIZATION_VV_PLANEPTUNE"]	= true,
		["CIVILIZATION_VV_PLANEPTUNE_PH"]= true,
		["CIVILIZATION_VV_LASTATION"]	= true,
		["CIVILIZATION_VV_LASTATION_BH"]= true,
		["CIVILIZATION_VV_LASTATION_ULTRA"]	= true,
		["CIVILIZATION_VV_LASTATION_BH_ULTRA"]= true,
		["CIVILIZATION_VV_PLANEPTUNE_NG"]= true,
		["CIVILIZATION_VV_PLANEPTUNE_PS"]= true,
		["CIVILIZATION_VV_PLANEPTUNE_PT"]= true,
		["CIVILIZATION_VV_PLANEPTUNE_IH"]= true,
		["CIVILIZATION_VV_LASTATION_UN"]= true,
		["CIVILIZATION_VV_LASTATION_BS"]= true,
		["CIVILIZATION_VV_LOWEE_RR"]	= true,
		["CIVILIZATION_VV_LOWEE_WS"]	= true
		}
	Events_HDNBasilicom.Weight = 5
	Events_HDNBasilicom.CanFunc = (
		function(pPlayer)
			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			return Events_HDNBasilicom.tValidCivs[sCivType]
		end
		)
	Events_HDNBasilicom.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Events_HDNBasilicom.Outcomes[1] = {}
	Events_HDNBasilicom.Outcomes[1].Name = "TXT_KEY_EVENT_VV_BASILICOM_GATHERING_OUTCOME_1"
	Events_HDNBasilicom.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_BASILICOM_GATHERING_OUTCOME_1_RESULT")
	Events_HDNBasilicom.Outcomes[1].CanFunc = (
		function(pPlayer)
			return true
		end
		)
	Events_HDNBasilicom.Outcomes[1].DoFunc = (
		function(pPlayer)
		
			LuaEvents.HDNChangeShares(pPlayer:GetID(), 500)
			
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_BASILICOM_GATHERING_OUTCOME_1_NOTIFICATION"), Locale.ConvertTextKey(Events_HDNBasilicom.Name))
		end
		)

for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Events_HDNBasilicom.tValidCivs[sCiv] then
			tEvents.Events_HDNBasilicom = Events_HDNBasilicom
			break
		end
	end
end