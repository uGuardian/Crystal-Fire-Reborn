-- GilgameshEvents
-- Author: Vicevirtuoso
-- DateCreated: 9/11/2014 4:48:02 PM
--------------------------------------------------------------


--=======================================================================================================================
-- Event 1: Death of Enkidu (Random, Low Weight)
--=======================================================================================================================
local Event_GilgameshDeathOfEnkidu = {}
	Event_GilgameshDeathOfEnkidu.Name = "TXT_KEY_EVENT_GILGAMESH_ENKIDU"
	Event_GilgameshDeathOfEnkidu.Desc = "TXT_KEY_EVENT_GILGAMESH_ENKIDU_DESC"
	Event_GilgameshDeathOfEnkidu.Weight = 5
	Event_GilgameshDeathOfEnkidu.Data1 = nil
	Event_GilgameshDeathOfEnkidu.tValidCivs = 
	{
		["CIVILIZATION_SUMER_FSN"]		= true,
	}
	Event_GilgameshDeathOfEnkidu.CanFunc = (
		function(pPlayer)
			if load(pPlayer, "Event_GilgameshDeathOfEnkidu") then return false end
			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			return Event_GilgameshDeathOfEnkidu.tValidCivs[sCivType]
		end
		)
	Event_GilgameshDeathOfEnkidu.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_GilgameshDeathOfEnkidu.Outcomes[1] = {}
	Event_GilgameshDeathOfEnkidu.Outcomes[1].Name = "TXT_KEY_EVENT_GILGAMESH_ENKIDU_OUTCOME_1"
	Event_GilgameshDeathOfEnkidu.Outcomes[1].Desc = "TXT_KEY_EVENT_GILGAMESH_ENKIDU_OUTCOME_1_RESULT"
	Event_GilgameshDeathOfEnkidu.Outcomes[1].Weight = 5
	Event_GilgameshDeathOfEnkidu.Outcomes[1].CanFunc = (
		function(pPlayer)
				return true
		end
		)
	Event_GilgameshDeathOfEnkidu.Outcomes[1].DoFunc = (
		function(pPlayer) 

			pPlayer:SetFaith(0)

			local pCapital = pPlayer:GetCapitalCity()

			if pCapital then
				pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_EVENTS_GILGAMESH_FSN_VENGEANCE, 1)
			end

			save(pPlayer, "Event_GilgameshDeathOfEnkidu", 1)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_GILGAMESH_ENKIDU_OUTCOME_RESULT_1_NOTIFICATION"), Locale.ConvertTextKey(Event_GilgameshDeathOfEnkidu.Name))
		end
		)

	Event_GilgameshDeathOfEnkidu.Outcomes[1].Monitors = {}
	Event_GilgameshDeathOfEnkidu.Outcomes[1].Monitors[GameEvents.PlayerDoTurn] = (
	function(iPlayer)
		local pPlayer = Players[iPlayer]
		if load(pPlayer, "Event_GilgameshDeathOfEnkidu") == 1 then
			for pUnit in pPlayer:Units() do
				local bNearHolyCity;
				for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
					if i ~= iPlayer then
						local pLoop = Players[i]
						for pCity in pPlayer:Cities() do
							if pCity:IsHolyCityAnyReligion() then
								if Map.PlotDistance(pUnit:GetX(), pUnit:GetY(), pCity:GetX(), pCity:GetY()) <= 2 then
									bNearHolyCity = true
									break
								end
							end
						end
						if bNearHolyCity then
							break
						end
					end
				end
				if bNearHolyCity then
					pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_EVENTS_GILGAMESH, true)
				else
					pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_EVENTS_GILGAMESH, false)
				end
			end
		end
	end
	)

	Event_GilgameshDeathOfEnkidu.Outcomes[1].Monitors[GameEvents.UnitSetXY] = (
	function(iPlayer, iUnit, iX, iY)
		if iX > 0 and iY > 0 then
			local pPlayer = Players[iPlayer]
			if load(pPlayer, "Event_GilgameshDeathOfEnkidu") == 1 then
				local pUnit = pPlayer:GetUnitByID(iUnit)
				local bNearHolyCity;
				for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
					if i ~= iPlayer then
						local pLoop = Players[i]
						for pCity in pPlayer:Cities() do
							if pCity:IsHolyCityAnyReligion() then
								if Map.PlotDistance(pUnit:GetX(), pUnit:GetY(), pCity:GetX(), pCity:GetY()) <= 2 then
									bNearHolyCity = true
									break
								end
							end
						end
						if bNearHolyCity then
							break
						end
					end
				end
				if bNearHolyCity then
					pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_EVENTS_GILGAMESH, true)
				else
					pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_EVENTS_GILGAMESH, false)
				end
			end
		end
	end
	)

	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_GilgameshDeathOfEnkidu.Outcomes[2] = {}
	Event_GilgameshDeathOfEnkidu.Outcomes[2].Name = "TXT_KEY_EVENT_GILGAMESH_ENKIDU_OUTCOME_2"
	Event_GilgameshDeathOfEnkidu.Outcomes[2].Desc = "TXT_KEY_EVENT_GILGAMESH_ENKIDU_OUTCOME_2_RESULT"
	Event_GilgameshDeathOfEnkidu.Outcomes[2].Weight = 5
	Event_GilgameshDeathOfEnkidu.Outcomes[2].CanFunc = (
		function(pPlayer)			
				return true
		end
		)
	Event_GilgameshDeathOfEnkidu.Outcomes[2].DoFunc = (
		function(pPlayer) 

			save(pPlayer, "Event_GilgameshDeathOfEnkidu", 2)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_GILGAMESH_ENKIDU_OUTCOME_RESULT_2_NOTIFICATION"), Locale.ConvertTextKey(Event_GilgameshDeathOfEnkidu.Name))
		end
		)




for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_GilgameshDeathOfEnkidu.tValidCivs[sCiv] then
			tEvents.Event_GilgameshDeathOfEnkidu = Event_GilgameshDeathOfEnkidu
			break
		end
	end
end


--=======================================================================================================================
-- Event 2: Loss of Immortality (Random, Only after Outcome 2 of Event 1)
--=======================================================================================================================
local Event_GilgameshLossOfImmortality = {}
	Event_GilgameshLossOfImmortality.Name = "TXT_KEY_EVENT_GILGAMESH_IMMORTALITY_STOLEN"
	Event_GilgameshLossOfImmortality.Desc = "TXT_KEY_EVENT_GILGAMESH_IMMORTALITY_STOLEN_DESC"
	Event_GilgameshLossOfImmortality.Weight = 10
	Event_GilgameshLossOfImmortality.Data1 = nil
	Event_GilgameshLossOfImmortality.tValidCivs = 
	{
		["CIVILIZATION_SUMER_FSN"]		= true,
	}
	Event_GilgameshLossOfImmortality.CanFunc = (
		function(pPlayer)
			if load(pPlayer, "Event_GilgameshDeathOfEnkidu") ~= 2 then return false end
			if load(pPlayer, "Event_GilgameshLossOfImmortality") then return false end
			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			return Event_GilgameshLossOfImmortality.tValidCivs[sCivType]
		end
		)
	Event_GilgameshLossOfImmortality.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_GilgameshLossOfImmortality.Outcomes[1] = {}
	Event_GilgameshLossOfImmortality.Outcomes[1].Name = "TXT_KEY_EVENT_GILGAMESH_IMMORTALITY_STOLEN_OUTCOME"
	Event_GilgameshLossOfImmortality.Outcomes[1].Desc = "TXT_KEY_EVENT_GILGAMESH_IMMORTALITY_STOLEN_OUTCOME_RESULT"
	Event_GilgameshLossOfImmortality.Outcomes[1].Weight = 5
	Event_GilgameshLossOfImmortality.Outcomes[1].CanFunc = (
		function(pPlayer)
				return true
		end
		)
	Event_GilgameshLossOfImmortality.Outcomes[1].DoFunc = (
		function(pPlayer) 

			local pCapital = pPlayer:GetCapitalCity()

			if pCapital then
				pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_EVENTS_GILGAMESH_FSN_IMMORTALITY, 1)
			end

			save(pPlayer, "Event_GilgameshLossOfImmortality", true)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_GILGAMESH_IMMORTALITY_STOLEN_OUTCOME_RESULT_NOTIFICATION"), Locale.ConvertTextKey(Event_GilgameshLossOfImmortality.Name))
		end
		)

for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_GilgameshLossOfImmortality.tValidCivs[sCiv] then
			tEvents.Event_GilgameshLossOfImmortality = Event_GilgameshLossOfImmortality
			break
		end
	end
end