-- COHEvents
-- Author: Vicevirtuoso
-- DateCreated: 10/4/2014 4:19:49 PM
--------------------------------------------------------------


local Event_PocketD = {}
    Event_PocketD.Name = "TXT_KEY_EVENT_COH_POCKET_D"
	Event_PocketD.Desc = "TXT_KEY_EVENT_COH_POCKET_D_DESC"
	Event_PocketD.tValidCivs = 
		{
		["CIVILIZATION_PARAGON"]		= true,
		["CIVILIZATION_ARACHNOS"]		= true,
		["CIVILIZATION_PRAETORIA"]		= true,
		["CIVILIZATION_NEMESIS"]		= true,
		["CIVILIZATION_RIKTI"]			= true
		}
	Event_PocketD.Weight = 5
	Event_PocketD.CanFunc = (
		function(pPlayer)
			if pPlayer:GetCurrentEra() < GameInfoTypes.ERA_INDUSTRIAL then return false end

			local pCapital = pPlayer:GetCapitalCity() 
			
			if pCapital then
				if pCapital:IsHasBuilding(GameInfoTypes.BUILDING_EVENTS_POCKET_D) then
					return false
				end
			else
				return false
			end
			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			return Event_PocketD.tValidCivs[sCivType]
		end
		)
	Event_PocketD.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_PocketD.Outcomes[1] = {}
	Event_PocketD.Outcomes[1].Name = "TXT_KEY_EVENT_COH_POCKET_D_OUTCOME_1"
	Event_PocketD.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_COH_POCKET_D_OUTCOME_1_RESULT")
	Event_PocketD.Outcomes[1].CanFunc = (
		function(pPlayer)
			return true
		end
		)
	Event_PocketD.Outcomes[1].DoFunc = (
		function(pPlayer)
			local pCapital = pPlayer:GetCapitalCity() 
			pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_EVENTS_POCKET_D, 1)
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_COH_POCKET_D_OUTCOME_1_NOTIFICATION"), Locale.ConvertTextKey(Event_PocketD.Name))
		end
		)

for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_PocketD.tValidCivs[sCiv] then
			tEvents.Event_PocketD = Event_PocketD
			break
		end
	end
end




local Event_ArchitectEntertainment = {}
    Event_ArchitectEntertainment.Name = "TXT_KEY_EVENT_COH_ARCHITECT"
	Event_ArchitectEntertainment.Desc = "TXT_KEY_EVENT_COH_ARCHITECT_DESC"
	Event_ArchitectEntertainment.tValidCivs = 
		{
		["CIVILIZATION_PARAGON"]		= true,
		["CIVILIZATION_ARACHNOS"]		= true,
		["CIVILIZATION_PRAETORIA"]		= true,
		["CIVILIZATION_NEMESIS"]		= true,
		["CIVILIZATION_RIKTI"]			= true
		}
	Event_ArchitectEntertainment.Weight = 10
	Event_ArchitectEntertainment.CanFunc = (
		function(pPlayer)
			if pPlayer:GetCurrentEra() < GameInfoTypes.ERA_MODERN then return false end

			local tCities = {}
			for pCity in pPlayer:Cities() do
				if not pCity:IsHasBuilding(GameInfoTypes.BUILDING_EVENTS_ARCHITECT_ENTERTAINMENT) then
					tCities[#tCities + 1] = pCity
				end
			end

			if #tCities <= 0 then return false end

			local iRand = Game.Rand(#tCities - 1, "COH Architect Event Roll") + 1

			Event_ArchitectEntertainment.Data1 = tCities[iRand]

			if Event_ArchitectEntertainment.Data1 then
				Event_ArchitectEntertainment.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_COH_ARCHITECT_DESC", tCities[iRand]:GetName())
				local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
				return Event_ArchitectEntertainment.tValidCivs[sCivType]
			else
				return false
			end
		end
		)
	Event_ArchitectEntertainment.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_ArchitectEntertainment.Outcomes[1] = {}
	Event_ArchitectEntertainment.Outcomes[1].Name = "TXT_KEY_EVENT_COH_ARCHITECT_OUTCOME_1"
	Event_ArchitectEntertainment.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_COH_ARCHITECT_OUTCOME_1_RESULT")
	Event_ArchitectEntertainment.Outcomes[1].CanFunc = (
		function(pPlayer, pCity)
			local sName = pCity:GetName()

			Event_ArchitectEntertainment.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_COH_ARCHITECT_OUTCOME_1_RESULT", sName)

			return true
		end
		)
	Event_ArchitectEntertainment.Outcomes[1].DoFunc = (
		function(pPlayer, pCity)
			pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_EVENTS_ARCHITECT_ENTERTAINMENT, 1)
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_COH_ARCHITECT_OUTCOME_1_NOTIFICATION"), Locale.ConvertTextKey(Event_ArchitectEntertainment.Name))
		end
		)


	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_ArchitectEntertainment.Outcomes[2] = {}
	Event_ArchitectEntertainment.Outcomes[2].Name = "TXT_KEY_EVENT_COH_ARCHITECT_OUTCOME_2"
	Event_ArchitectEntertainment.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_COH_ARCHITECT_OUTCOME_2_RESULT")
	Event_ArchitectEntertainment.Outcomes[2].CanFunc = (
		function(pPlayer)
			return true
		end
		)
	Event_ArchitectEntertainment.Outcomes[2].DoFunc = (
		function(pPlayer)
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_COH_ARCHITECT_OUTCOME_2_NOTIFICATION"), Locale.ConvertTextKey(Event_ArchitectEntertainment.Name))
		end
		)

for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_ArchitectEntertainment.tValidCivs[sCiv] then
			tEvents.Event_ArchitectEntertainment = Event_ArchitectEntertainment
			break
		end
	end
end


local Event_LostConnectionToMapserver = {}
    Event_LostConnectionToMapserver.Name = "TXT_KEY_EVENT_COH_MAPSERVER"
	Event_LostConnectionToMapserver.Desc = "TXT_KEY_EVENT_COH_MAPSERVER_DESC"
	Event_LostConnectionToMapserver.tValidCivs = 
		{
		["CIVILIZATION_PARAGON"]		= true,
		["CIVILIZATION_ARACHNOS"]		= true,
		["CIVILIZATION_PRAETORIA"]		= true,
		["CIVILIZATION_NEMESIS"]		= true,
		["CIVILIZATION_RIKTI"]			= true
		}
	Event_LostConnectionToMapserver.Weight = 10
	Event_LostConnectionToMapserver.CanFunc = (
		function(pPlayer)
			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			return Event_LostConnectionToMapserver.tValidCivs[sCivType]
		end
		)
	Event_LostConnectionToMapserver.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_LostConnectionToMapserver.Outcomes[1] = {}
	Event_LostConnectionToMapserver.Outcomes[1].Name = "TXT_KEY_EVENT_COH_MAPSERVER_OUTCOME_1"
	Event_LostConnectionToMapserver.Outcomes[1].Desc = "TXT_KEY_EVENT_COH_MAPSERVER_OUTCOME_1_RESULT"
	Event_LostConnectionToMapserver.Outcomes[1].CanFunc = (
		function(pPlayer)
			local iTurns = math.ceil(1 * iMod)
			Event_LostConnectionToMapserver.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_COH_MAPSERVER_OUTCOME_1_DESC", iTurns)

			return true
		end
		)
	Event_LostConnectionToMapserver.Outcomes[1].DoFunc = (
		function(pPlayer)
			local iTurns = math.ceil(1 * iMod)
			pPlayer:ChangeAnarchyNumTurns(iTurns)
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_COH_MAPSERVER_OUTCOME_1_NOTIFICATION"), Locale.ConvertTextKey(Event_LostConnectionToMapserver.Name))
		end
		)

for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_LostConnectionToMapserver.tValidCivs[sCiv] then
			tEvents.Event_LostConnectionToMapserver = Event_LostConnectionToMapserver
			break
		end
	end
end