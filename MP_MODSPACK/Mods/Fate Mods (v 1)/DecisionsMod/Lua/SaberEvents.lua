-- OcelotEvents
-- Author: Vicevirtuoso
-- DateCreated: 9/11/2014 4:48:02 PM
--------------------------------------------------------------


--=======================================================================================================================
-- Event 1: Merlin's Mischief (Random)
--=======================================================================================================================
local Event_SaberMerlinMischief = {}
	Event_SaberMerlinMischief.Name = "TXT_KEY_EVENT_SABER_MERLIN"
	Event_SaberMerlinMischief.Desc = "TXT_KEY_EVENT_SABER_MERLIN_DESC"
	Event_SaberMerlinMischief.Weight = 10
	Event_SaberMerlinMischief.Data1 = nil
	Event_SaberMerlinMischief.tValidCivs = 
	{
		["CIVILIZATION_BRITAIN_FSN"]		= true,
	}
	Event_SaberMerlinMischief.CanFunc = (
		function(pPlayer)
			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			return Event_SaberMerlinMischief.tValidCivs[sCivType]
		end
		)
	Event_SaberMerlinMischief.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_SaberMerlinMischief.Outcomes[1] = {}
	Event_SaberMerlinMischief.Outcomes[1].Name = "TXT_KEY_EVENT_SABER_MERLIN_OUTCOME_1"
	Event_SaberMerlinMischief.Outcomes[1].Desc = "TXT_KEY_EVENT_SABER_MERLIN_OUTCOME_1_RESULT"
	Event_SaberMerlinMischief.Outcomes[1].Weight = 5
	Event_SaberMerlinMischief.Outcomes[1].CanFunc = (
		function(pPlayer)
		
			local iNumWorkers = 0

			for pUnit in pPlayer:Units() do
				if pUnit:GetUnitClassType() == GameInfoTypes.UNITCLASS_WORKER then
					if iNumWorkers == 0 then
						if pUnit:GetPlot():GetResourceType() < 0 then
							iNumWorkers = iNumWorkers + 1
						end
					else
						iNumWorkers = iNumWorkers + 1
					end
					if iNumWorkers >= 2 then return true end
				end
			end
			
			return false
		end
		)
	Event_SaberMerlinMischief.Outcomes[1].DoFunc = (
		function(pPlayer) 

			local iNumWorkers = 0

			for pUnit in pPlayer:Units() do
				if pUnit:GetUnitClassType() == GameInfoTypes.UNITCLASS_WORKER then
					if iNumWorkers == 0 then
						if pUnit:GetPlot():GetResourceType() < 0 then
							pUnit:GetPlot():SetResourceType(GameInfoTypes.RESOURCE_SHEEP, 1)
							pUnit:Kill(true)
							iNumWorkers = iNumWorkers + 1
						end
					else
						pUnit:Kill(true)
						iNumWorkers = iNumWorkers + 1
					end
					if iNumWorkers >= 2 then break end
				end
			end

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_SABER_MERLIN_OUTCOME_RESULT_1_NOTIFICATION"), Locale.ConvertTextKey(Event_SaberMerlinMischief.Name))
		end
		)

	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_SaberMerlinMischief.Outcomes[2] = {}
	Event_SaberMerlinMischief.Outcomes[2].Name = "TXT_KEY_EVENT_SABER_MERLIN_OUTCOME_2"
	Event_SaberMerlinMischief.Outcomes[2].Desc = "TXT_KEY_EVENT_SABER_MERLIN_OUTCOME_2_RESULT"
	Event_SaberMerlinMischief.Outcomes[2].Weight = 5
	Event_SaberMerlinMischief.Outcomes[2].CanFunc = (
		function(pPlayer)			
			for pCity in pPlayer:Cities() do
				if pCity:IsHasBuilding(GameInfoTypes.BUILDING_ARTHURIAN_COURT) and not pCity:IsCapital() then
					return true
				end
			end

			return false
		end
		)
	Event_SaberMerlinMischief.Outcomes[2].DoFunc = (
		function(pPlayer) 

			for pCity in pPlayer:Cities() do
				if pCity:IsHasBuilding(GameInfoTypes.BUILDING_ARTHURIAN_COURT) and not pCity:IsCapital() then
					pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_ARTHURIAN_COURT, 0)
					break
				end
			end

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_SABER_MERLIN_OUTCOME_RESULT_2_NOTIFICATION"), Locale.ConvertTextKey(Event_SaberMerlinMischief.Name))
		end
		)

	--=========================================================
	-- Outcome 3
	--=========================================================
	Event_SaberMerlinMischief.Outcomes[3] = {}
	Event_SaberMerlinMischief.Outcomes[3].Name = "TXT_KEY_EVENT_SABER_MERLIN_OUTCOME_3"
	Event_SaberMerlinMischief.Outcomes[3].Desc = "TXT_KEY_EVENT_SABER_MERLIN_OUTCOME_3_RESULT"
	Event_SaberMerlinMischief.Outcomes[3].Weight = 5
	Event_SaberMerlinMischief.Outcomes[3].CanFunc = (
		function(pPlayer)
		
			local iProduction = math.ceil(25 * iMod)
			
			Event_SaberMerlinMischief.Outcomes[3].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_SABER_MERLIN_OUTCOME_3_RESULT", iProduction)
				
			for pCity in pPlayer:Cities() do
				if pCity:IsHasBuilding(GameInfoTypes.BUILDING_AQUEDUCT) then
					return true
				end
			end

			return false
		end
		)
	Event_SaberMerlinMischief.Outcomes[3].DoFunc = (
		function(pPlayer)
		
			local iProduction = math.ceil(25 * iMod) 

			for pCity in pPlayer:Cities() do
				if pCity:IsHasBuilding(GameInfoTypes.BUILDING_AQUEDUCT) then
					pCity:ChangeProduction(-iProduction)
				end
			end

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_SABER_MERLIN_OUTCOME_RESULT_3_NOTIFICATION"), Locale.ConvertTextKey(Event_SaberMerlinMischief.Name))
		end
		)

	--=========================================================
	-- Outcome 4
	--=========================================================
	Event_SaberMerlinMischief.Outcomes[4] = {}
	Event_SaberMerlinMischief.Outcomes[4].Name = "TXT_KEY_EVENT_SABER_MERLIN_OUTCOME_4"
	Event_SaberMerlinMischief.Outcomes[4].Desc = "TXT_KEY_EVENT_SABER_MERLIN_OUTCOME_4_RESULT"
	Event_SaberMerlinMischief.Outcomes[4].Weight = 5
	Event_SaberMerlinMischief.Outcomes[4].CanFunc = (
		function(pPlayer)
		
			local iDelta = math.ceil(100 * iMod)
			Event_SaberMerlinMischief.Outcomes[4].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_SABER_MERLIN_OUTCOME_4_RESULT", iDelta)
				
			return true
		end
		)
	Event_SaberMerlinMischief.Outcomes[4].DoFunc = (
		function(pPlayer)
			pPlayer:ChangeGoldenAgeProgressMeter(math.ceil(-100 * iMod))
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_SABER_MERLIN_OUTCOME_RESULT_4_NOTIFICATION"), Locale.ConvertTextKey(Event_SaberMerlinMischief.Name))
		end
		)

	--=========================================================
	-- Outcome 5
	--=========================================================
	Event_SaberMerlinMischief.Outcomes[5] = {}
	Event_SaberMerlinMischief.Outcomes[5].Name = "TXT_KEY_EVENT_SABER_MERLIN_OUTCOME_5"
	Event_SaberMerlinMischief.Outcomes[5].Desc = "TXT_KEY_EVENT_SABER_MERLIN_OUTCOME_5_RESULT"
	Event_SaberMerlinMischief.Outcomes[5].Weight = 10
	Event_SaberMerlinMischief.Outcomes[5].CanFunc = (
		function(pPlayer)
		
			if load(pPlayer, "Event_SaberMerlinMischief") == true then return false end

			local iResistTurns = math.ceil(5 * iMod)
			Event_SaberMerlinMischief.Outcomes[5].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_SABER_MERLIN_OUTCOME_5_RESULT", iResistTurns)
				
			return true
		end
		)
	Event_SaberMerlinMischief.Outcomes[5].DoFunc = (
		function(pPlayer)
			local pCapital = pPlayer:GetCapitalCity()

			pCapital:ChangeResistanceTurns(math.ceil(5 * iMod))

			local pPlot = pCapital:Plot()
			local pMordred = pPlayer:InitUnit(GameInfoTypes.UNIT_KOTR_FSN, pPlot:GetX(), pPlot:GetY(), UNITAI_ATTACK)
			pMordred:SetName("TXT_KEY_GREAT_PERSON_KOTR_FSN_MORDRED")
			pMordred:SetHasPromotion(GameInfoTypes.PROMOTION_MORALE, true)

			save(pPlayer, "Event_SaberMerlinMischief", true)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_SABER_MERLIN_OUTCOME_RESULT_5_NOTIFICATION"), Locale.ConvertTextKey(Event_SaberMerlinMischief.Name))
		end
		)



for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_SaberMerlinMischief.tValidCivs[sCiv] then
			tEvents.Event_SaberMerlinMischief = Event_SaberMerlinMischief
			break
		end
	end
end