-- LancerEvents
-- Author: Vicevirtuoso
-- DateCreated: 9/11/2014 4:48:02 PM
--------------------------------------------------------------

local iBuilding = GameInfoTypes.BUILDING_DECISIONS_LANCER_LOATHLY_LADY
local iPositiveDiplo = -20   --yes, negative numbers translate to positive diplomatic values with GetScenarioDiploModifier

--=======================================================================================================================
-- Event 1: Loathly Lady (Random, only happens once)
--=======================================================================================================================
local Event_LancerLoathlyLady = {}
	Event_LancerLoathlyLady.Name = "TXT_KEY_EVENT_LANCER_LOATHLY_LADY"
	Event_LancerLoathlyLady.Desc = "TXT_KEY_EVENT_LANCER_LOATHLY_LADY_DESC"
	Event_LancerLoathlyLady.Weight = 10
	Event_LancerLoathlyLady.Data1 = nil
	Event_LancerLoathlyLady.tValidCivs = 
	{
		["CIVILIZATION_IRELAND_FSN"]		= true
	}
	Event_LancerLoathlyLady.CanFunc = (
		function(pPlayer)

			if load(pPlayer, "Event_LancerLoathlyLady") then return false end

			for pCity in pPlayer:Cities() do
				if pCity:IsCoastal() then
					Event_LancerLoathlyLady.Data1 = pCity
					break
				end
			end
			
			
			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			return Event_LancerLoathlyLady.tValidCivs[sCivType]
		end
		)
	Event_LancerLoathlyLady.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_LancerLoathlyLady.Outcomes[1] = {}
	Event_LancerLoathlyLady.Outcomes[1].Name = "TXT_KEY_EVENT_LANCER_LOATHLY_LADY_OUTCOME_1"
	Event_LancerLoathlyLady.Outcomes[1].Desc = "TXT_KEY_EVENT_LANCER_LOATHLY_LADY_OUTCOME_1_RESULT"
	Event_LancerLoathlyLady.Outcomes[1].Weight = 5
	Event_LancerLoathlyLady.Outcomes[1].CanFunc = (
		function(pPlayer, pCity)

			local iGAPoints = math.ceil(400 * iMod)

			Event_LancerLoathlyLady.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_LANCER_LOATHLY_LADY_OUTCOME_1_RESULT", iGAPoints)

			return true
		end
		)
	Event_LancerLoathlyLady.Outcomes[1].DoFunc = (
		function(pPlayer, pCity) 

			local iGAPoints = math.ceil(400 * iMod)

			pPlayer:ChangeGoldenAgeProgressMeter(iGAPoints)

			save(pPlayer, "Event_LancerLoathlyLady", true)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_LANCER_LOATHLY_LADY_OUTCOME_RESULT_1_NOTIFICATION"), Locale.ConvertTextKey(Event_LancerLoathlyLady.Name))
		end
		)
		
	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_LancerLoathlyLady.Outcomes[2] = {}
	Event_LancerLoathlyLady.Outcomes[2].Name = "TXT_KEY_EVENT_LANCER_LOATHLY_LADY_OUTCOME_2"
	Event_LancerLoathlyLady.Outcomes[2].Desc = "TXT_KEY_EVENT_LANCER_LOATHLY_LADY_OUTCOME_2_RESULT"
	Event_LancerLoathlyLady.Outcomes[2].Weight = 5
	Event_LancerLoathlyLady.Outcomes[2].CanFunc = (
		function(pPlayer, pCity)	
		
			if not pCity then return false end

			local iGAPoints = math.ceil(400 * iMod)
			local sCityName = pCity:GetName()

			Event_LancerLoathlyLady.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_LANCER_LOATHLY_LADY_OUTCOME_2_RESULT", iGAPoints, sCityName)

			return true
		end
		)
	Event_LancerLoathlyLady.Outcomes[2].DoFunc = (
		function(pPlayer, pCity) 

			local iGAPoints = math.ceil(400 * iMod)

			pPlayer:ChangeGoldenAgeProgressMeter(-iGAPoints)

			pCity:SetNumRealBuilding(iBuilding, 1)

			save(pPlayer, "Event_LancerLoathlyLady", true)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_LANCER_LOATHLY_LADY_OUTCOME_RESULT_2_NOTIFICATION"), Locale.ConvertTextKey(Event_LancerLoathlyLady.Name))
		end
		)


for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_LancerLoathlyLady.tValidCivs[sCiv] then
			tEvents.Event_LancerLoathlyLady = Event_LancerLoathlyLady
			break
		end
	end
end


local Event_LancerLoveSpot = {}
	Event_LancerLoveSpot.Name = "TXT_KEY_EVENT_LANCER_LOVE_SPOT"
	Event_LancerLoveSpot.Desc = "TXT_KEY_EVENT_LANCER_LOVE_SPOT_DESC"
	Event_LancerLoveSpot.Weight = 10
	Event_LancerLoveSpot.Data1 = nil
	Event_LancerLoveSpot.tValidCivs = 
	{
		["CIVILIZATION_IRELAND_FSN"]		= true,
	}
	Event_LancerLoveSpot.CanFunc = (
		function(pPlayer)

			if load(pPlayer, "Event_LancerLoveSpot") then return false end

			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			if Event_LancerLoveSpot.tValidCivs[sCivType] ~= true then return false end
			
			local tPossibleCivs = {}

			for i = 0, GameDefines.MAX_MAJOR_CIVS -1 , 1 do
				local pLoop = Players[i]
				if pLoop:IsAlive() then
					if (Locale.ConvertTextKey("{@1: gender feminine?yes; other?no}", pLoop:GetNameKey()) == "yes") and pLoop:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_BRITAIN_FSN then
						if pPlayer:IsDoF(i) then
							tPossibleCivs[#tPossibleCivs + 1] = pLoop
						end
					end
				end
			end

			if #tPossibleCivs <= 0 then return false end

			Event_LancerLoveSpot.Data1 = tPossibleCivs[Game.Rand(#tPossibleCivs - 1, "Lancer Event Roll") + 1]

			if Event_LancerLoveSpot.Data1 then
				Event_LancerLoveSpot.Name = Locale.ConvertTextKey("TXT_KEY_EVENT_LANCER_LOVE_SPOT", Event_LancerLoveSpot.Data1:GetName())
				Event_LancerLoveSpot.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_LANCER_LOVE_SPOT_DESC", pPlayer:GetCivilizationShortDescription(), Event_LancerLoveSpot.Data1:GetCivilizationShortDescription(), Event_LancerLoveSpot.Data1:GetName())
				return true
			else
				return false
			end
		end
		)
	Event_LancerLoveSpot.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_LancerLoveSpot.Outcomes[1] = {}
	Event_LancerLoveSpot.Outcomes[1].Name = "TXT_KEY_EVENT_LANCER_LOVE_SPOT_OUTCOME_1"
	Event_LancerLoveSpot.Outcomes[1].Desc = "TXT_KEY_EVENT_LANCER_LOVE_SPOT_OUTCOME_1_RESULT"
	Event_LancerLoveSpot.Outcomes[1].Weight = 5
	Event_LancerLoveSpot.Outcomes[1].CanFunc = (
		function(pPlayer, pEnemyPlayer)
		
			local iAnarchyTurns = math.ceil(3 * iMod)

			Event_LancerLoveSpot.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_LANCER_LOVE_SPOT_OUTCOME_1_RESULT", iAnarchyTurns)

			return true
		end
		)
	Event_LancerLoveSpot.Outcomes[1].DoFunc = (
		function(pPlayer, pEnemyPlayer) 

			local iAnarchyTurns = math.ceil(3 * iMod)

			pPlayer:ChangeAnarchyNumTurns(iAnarchyTurns)

			save(pPlayer, "Event_LancerLoveSpot", true)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_LANCER_LOVE_SPOT_OUTCOME_RESULT_1_NOTIFICATION", pEnemyPlayer:GetName()), Locale.ConvertTextKey(Event_LancerLoveSpot.Name, pEnemyPlayer:GetName()))
		end
		)

	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_LancerLoveSpot.Outcomes[2] = {}
	Event_LancerLoveSpot.Outcomes[2].Name = "TXT_KEY_EVENT_LANCER_LOVE_SPOT_OUTCOME_2"
	Event_LancerLoveSpot.Outcomes[2].Desc = "TXT_KEY_EVENT_LANCER_LOVE_SPOT_OUTCOME_2_RESULT"
	Event_LancerLoveSpot.Outcomes[2].Weight = 0  --this one probably shouldn't be enacted by the AI
	Event_LancerLoveSpot.Outcomes[2].CanFunc = (
		function(pPlayer, pEnemyPlayer)	
		
			Event_LancerLoveSpot.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_LANCER_LOVE_SPOT_OUTCOME_2_RESULT", pEnemyPlayer:GetCivilizationShortDescription())		

			return true
		end
		)
	Event_LancerLoveSpot.Outcomes[2].DoFunc = (
		function(pPlayer, pEnemyPlayer) 

			pPlayer:ChangeGoldenAgeTurns(pPlayer:GetGoldenAgeLength())
			pEnemyPlayer:ChangeGoldenAgeTurns(pEnemyPlayer:GetGoldenAgeLength())

			Teams[pPlayer:GetTeam()]:SetPermanentWarPeace(pEnemyPlayer:GetTeam(), true)

			save(pPlayer, "Event_LancerLoveSpot", true)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_LANCER_LOVE_SPOT_OUTCOME_RESULT_2_NOTIFICATION", pEnemyPlayer:GetName()), Locale.ConvertTextKey(Event_LancerLoveSpot.Name, pEnemyPlayer:GetName()))
			JFD_SendNotification(pEnemyPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_LANCER_LOVE_SPOT_OUTCOME_RESULT_2_NOTIFICATION_ENEMY", pPlayer:GetName()), Locale.ConvertTextKey(Event_LancerLoveSpot.Name, pEnemyPlayer:GetName()))

		end
		)


for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_LancerLoveSpot.tValidCivs[sCiv] then
			tEvents.Event_LancerLoveSpot = Event_LancerLoveSpot
			break
		end
	end
end