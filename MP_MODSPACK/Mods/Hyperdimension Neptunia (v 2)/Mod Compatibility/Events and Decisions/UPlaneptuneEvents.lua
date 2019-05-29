-- UPlaneptuneEvents
-- Author: Vice
--------------------------------------------------------------
local iPlutia		= GameInfoTypes.CIVILIZATION_VV_PLANEPTUNE_PL
local iIrisHeart	= GameInfoTypes.CIVILIZATION_VV_PLANEPTUNE_IH

local iCaptureShares = 3000
local sCaptureShares = string.format("%.2f%%", iCaptureShares / 100)
local iCaptureCulture = math.ceil(1000 * iMod)

print("Plutia Events Loading")



----------------------------------------------------------------------------------------------------------------------------
-- Venting Frustration
----------------------------------------------------------------------------------------------------------------------------
local Event_UPlaneptuneFrustration = {}
    Event_UPlaneptuneFrustration.Name = "TXT_KEY_EVENT_VV_PLANEPTUNE_PL_FRUSTRATION_DOLL"
	Event_UPlaneptuneFrustration.Desc = "TXT_KEY_EVENT_VV_PLANEPTUNE_PL_FRUSTRATION_DOLL_DESC"
	Event_UPlaneptuneFrustration.EventImage = 'Event_PlutiaFrustration.dds'
	Event_UPlaneptuneFrustration.tValidCivs = 
		{
		["CIVILIZATION_VV_PLANEPTUNE_PL"]	= true
		}
	Event_UPlaneptuneFrustration.Weight = 2
	Event_UPlaneptuneFrustration.CanFunc = (
		function(pPlayer)
			if pPlayer:GetNumCities() < 1 then return end
			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			if Event_UPlaneptuneFrustration.tValidCivs[sCivType] == true then
				return true
			end
			return false
		end
		)
	Event_UPlaneptuneFrustration.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_UPlaneptuneFrustration.Outcomes[1] = {}
	Event_UPlaneptuneFrustration.Outcomes[1].Name = "TXT_KEY_EVENT_VV_PLANEPTUNE_PL_FRUSTRATION_DOLL_OUTCOME_1"
	Event_UPlaneptuneFrustration.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_PL_FRUSTRATION_DOLL_OUTCOME_1_RESULT")
	Event_UPlaneptuneFrustration.Outcomes[1].CanFunc = (
		function(pPlayer)
			local iAnarchyTurns = math.ceil(2 * iMod)
			Event_UPlaneptuneFrustration.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_PL_FRUSTRATION_DOLL_OUTCOME_1_RESULT", iAnarchyTurns)
			return true
		end
		)
	Event_UPlaneptuneFrustration.Outcomes[1].DoFunc = (
		function(pPlayer)
			local iAnarchyTurns = math.ceil(2 * iMod)
			pPlayer:ChangeAnarchyNumTurns(iAnarchyTurns)
			LuaEvents.PlutiaAddNewDoll(pPlayer:GetID())
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_PL_FRUSTRATION_DOLL_OUTCOME_1_NOTIFICATION"), Locale.ConvertTextKey(Event_UPlaneptuneFrustration.Name))
		end
		)


for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if sCiv == "CIVILIZATION_VV_PLANEPTUNE_IH" or sCiv == "CIVILIZATION_VV_PLANEPTUNE_PL" then
			tEvents.Event_UPlaneptuneFrustration = Event_UPlaneptuneFrustration
			break
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- Lost Child!
----------------------------------------------------------------------------------------------------------------------------
local Event_UPlaneptuneLostChild = {}
    Event_UPlaneptuneLostChild.Name = "TXT_KEY_EVENT_VV_PLANEPTUNE_PL_LOST_CHILD"
	Event_UPlaneptuneLostChild.Desc = "TXT_KEY_EVENT_VV_PLANEPTUNE_PL_LOST_CHILD_DESC"
	Event_UPlaneptuneLostChild.tValidCivs = 
		{
		["CIVILIZATION_VV_PLANEPTUNE_PL"]		= true,
		["CIVILIZATION_VV_PLANEPTUNE_IH"]		= true,
		}
	Event_UPlaneptuneLostChild.Weight = 10
	Event_UPlaneptuneLostChild.EventImage = 'Event_PlutiaLostChild.dds'
	Event_UPlaneptuneLostChild.Data1 = nil
	Event_UPlaneptuneLostChild.CanFunc = (
		function(pPlayer)
			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			if Event_UPlaneptuneLostChild.tValidCivs[sCivType] == true then
				for pCity in pPlayer:Cities() do
					local tPossibleCities = {}
					if not pCity:IsCapital() and pCity:IsHasBuilding(GameInfoTypes.BUILDING_VV_DAYCARE) then
						tPossibleCities[#tPossibleCities + 1] = pCity
					end
					Event_UPlaneptuneLostChild.Data1 = tPossibleCities[GetRandom(1, #tPossibleCities)]
					if Event_UPlaneptuneLostChild.Data1 then
						Event_UPlaneptuneLostChild.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_PL_LOST_CHILD_DESC", Event_UPlaneptuneLostChild.Data1:GetName())
						return true
					end
				end
			end
			return false
		end
		)
	Event_UPlaneptuneLostChild.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_UPlaneptuneLostChild.Outcomes[1] = {}
	Event_UPlaneptuneLostChild.Outcomes[1].Name = "TXT_KEY_EVENT_VV_PLANEPTUNE_PL_LOST_CHILD_OUTCOME_1"
	Event_UPlaneptuneLostChild.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_PL_LOST_CHILD_OUTCOME_1_RESULT")
	Event_UPlaneptuneLostChild.Outcomes[1].CanFunc = (
		function(pPlayer, pCity)
			if pPlayer:GetCivilizationType() == iIrisHeart then
				Event_UPlaneptuneLostChild.Outcomes[1].Name = "TXT_KEY_EVENT_VV_PLANEPTUNE_PL_LOST_CHILD_OUTCOME_1_IRIS"
			end
			local iCulture = 3 * pCity:GetPopulation() * math.max(pPlayer:GetCurrentEra(), 1) * iMod
			local iShares = 10 * pCity:GetPopulation() * math.max(pPlayer:GetCurrentEra(), 1)
			local sShares = string.format("%.2f%%", iShares / 100)
			Event_UPlaneptuneLostChild.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_PL_LOST_CHILD_OUTCOME_1_RESULT", iCulture, sShares)
			if iCulture > pPlayer:GetJONSCulture() then return false end
			return true
		end
		)
	Event_UPlaneptuneLostChild.Outcomes[1].DoFunc = (
		function(pPlayer, pCity)
			local iCulture = 3 * pCity:GetPopulation() * math.max(pPlayer:GetCurrentEra(), 1)
			local iShares = 10 * pCity:GetPopulation() * math.max(pPlayer:GetCurrentEra(), 1)
			pPlayer:ChangeJONSCulture(-iCulture)
			LuaEvents.HDNChangeShares(pPlayer:GetID(), iShares)
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_PL_LOST_CHILD_OUTCOME_1_NOTIFICATION"), Locale.ConvertTextKey(Event_UPlaneptuneLostChild.Name))
		end
		)

	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_UPlaneptuneLostChild.Outcomes[2] = {}
	Event_UPlaneptuneLostChild.Outcomes[2].Name = "TXT_KEY_EVENT_VV_PLANEPTUNE_PL_LOST_CHILD_OUTCOME_2"
	Event_UPlaneptuneLostChild.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_PL_LOST_CHILD_OUTCOME_2_RESULT")
	Event_UPlaneptuneLostChild.Outcomes[2].CanFunc = (
		function(pPlayer, pCity)
			if pPlayer:GetCivilizationType() == iIrisHeart then
				Event_UPlaneptuneLostChild.Outcomes[2].Name = "TXT_KEY_EVENT_VV_PLANEPTUNE_PL_LOST_CHILD_OUTCOME_2_IRIS"
			end
			local iResistance = math.ceil(2 * iMod)
			local iCulture = 2 * pCity:GetPopulation() * math.max(pPlayer:GetCurrentEra(), 1) * iMod
			Event_UPlaneptuneLostChild.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_PL_LOST_CHILD_OUTCOME_2_RESULT", pCity:GetName(), iResistance, iCulture)
			return true
		end
		)
	Event_UPlaneptuneLostChild.Outcomes[2].DoFunc = (
		function(pPlayer, pCity)
			local iResistance = math.ceil(2 * iMod)
			local iCulture = 2 * pCity:GetPopulation() * math.max(pPlayer:GetCurrentEra(), 1) * iMod

			pCity:ChangeResistanceTurns(iResistance)
			pPlayer:ChangeJONSCulture(iCulture)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_PL_LOST_CHILD_OUTCOME_2_NOTIFICATION"), Locale.ConvertTextKey(Event_UPlaneptuneLostChild.Name))
		end
		)

for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if sCiv == "CIVILIZATION_VV_PLANEPTUNE_IH" or sCiv == "CIVILIZATION_VV_PLANEPTUNE_PL" then
			tEvents.Event_UPlaneptuneLostChild = Event_UPlaneptuneLostChild
			break
		end
	end
end
----------------------------------------------------------------------------------------------------------------------------
-- "Oh my, did I just hear backtalk...?"
----------------------------------------------------------------------------------------------------------------------------
local Event_UPlaneptuneBacktalk = {}
    Event_UPlaneptuneBacktalk.Name = "TXT_KEY_EVENT_VV_PLANEPTUNE_IH_BULLY"
	Event_UPlaneptuneBacktalk.Desc = "TXT_KEY_EVENT_VV_PLANEPTUNE_IH_BULLY_DESC"
	Event_UPlaneptuneBacktalk.tValidCivs = 
		{
		["CIVILIZATION_VV_PLANEPTUNE_IH"]		= true
		}
	Event_UPlaneptuneBacktalk.EventImage = 'Event_IrisBacktalk.dds'
	Event_UPlaneptuneBacktalk.Weight = 10
	Event_UPlaneptuneBacktalk.Data1 = nil
	Event_UPlaneptuneBacktalk.CanFunc = (
		function(pPlayer)
			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			if Event_UPlaneptuneBacktalk.tValidCivs[sCivType] == true then
				Event_UPlaneptuneLostChild.Data1 = {}
				local pTeam = Teams[pPlayer:GetTeam()]
				local iPlayer = pPlayer:GetID()
				local tPossibleCS = {}
				for iCS, pCS in pairs(Players) do
					if (pCS:IsAlive() and pCS:IsMinorCiv() and Teams[pPlayer:GetTeam()]:IsHasMet(pCS:GetTeam()) and not(pTeam:IsAtWar(pCS:GetTeam())) and pCS:CanMajorBullyGold(iPlayer)) then
						tPossibleCS[#tPossibleCS + 1] = pCS
					end
				end
				Event_UPlaneptuneBacktalk.Data1 = tPossibleCS[GetRandom(1, #tPossibleCS)]
				if Event_UPlaneptuneBacktalk.Data1 then
					Event_UPlaneptuneBacktalk.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_IH_BULLY_DESC", Event_UPlaneptuneBacktalk.Data1:GetCivilizationShortDescription())
					return true
				end
			end
			return false
		end
		)
	Event_UPlaneptuneBacktalk.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_UPlaneptuneBacktalk.Outcomes[1] = {}
	Event_UPlaneptuneBacktalk.Outcomes[1].Name = "TXT_KEY_EVENT_VV_PLANEPTUNE_IH_BULLY_OUTCOME_1"
	Event_UPlaneptuneBacktalk.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_IH_BULLY_OUTCOME_1_RESULT")
	Event_UPlaneptuneBacktalk.Outcomes[1].CanFunc = (
		function(pPlayer, pCS)
			local iInfluence = 20
			local iShares = 100 * math.max(pPlayer:GetCurrentEra(), 1)
			local sShares = string.format("%.2f%%", iShares / 100)
			Event_UPlaneptuneBacktalk.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_IH_BULLY_OUTCOME_1_RESULT", iInfluence, pCS:GetCivilizationShortDescription(), sShares)
			return true
		end
		)
	Event_UPlaneptuneBacktalk.Outcomes[1].DoFunc = (
		function(pPlayer, pCS)
			local iInfluence = 20
			local iShares = 100 * math.max(pPlayer:GetCurrentEra(), 1)

			pCS:ChangeMinorCivFriendshipWithMajor(pPlayer:GetID(), -iInfluence)
			LuaEvents.HDNChangeShares(pPlayer:GetID(), iShares)

			save(pPlayer, "Event_UPlaneptuneBacktalk", true)
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_IH_BULLY_OUTCOME_1_NOTIFICATION"), Locale.ConvertTextKey(Event_UPlaneptuneBacktalk.Name))
		end
		)

	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_UPlaneptuneBacktalk.Outcomes[2] = {}
	Event_UPlaneptuneBacktalk.Outcomes[2].Name = "TXT_KEY_EVENT_VV_PLANEPTUNE_IH_BULLY_OUTCOME_2"
	Event_UPlaneptuneBacktalk.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_IH_BULLY_OUTCOME_2_RESULT")
	Event_UPlaneptuneBacktalk.Outcomes[2].CanFunc = (
		function(pPlayer, pCS)
			local iInfluence = 60
			local iOthersInfluence = 10
			local iShares = 200 * math.max(pPlayer:GetCurrentEra(), 1)
			local sShares = string.format("%.2f%%", iShares / 100)

			Event_UPlaneptuneBacktalk.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_IH_BULLY_OUTCOME_2_RESULT", pCS:GetCivilizationShortDescription(), iInfluence, sShares, iOthersInfluence)
			return true
		end
		)
	Event_UPlaneptuneBacktalk.Outcomes[2].DoFunc = (
		function(pPlayer, pCS)
			print(pPlayer:GetID(), pCS:GetID())
			Game.DoMinorBullyGold(pPlayer:GetID(), pCS:GetID())
			print("Attempted Game.DoMinorBullyGold")
			
			local iInfluence = 60
			local iOthersInfluence = 10
			local iShares = 200 * math.max(pPlayer:GetCurrentEra(), 1)
			pCS:ChangeMinorCivFriendshipWithMajor(pPlayer:GetID(), -iInfluence)
			LuaEvents.HDNChangeShares(pPlayer:GetID(), iShares)
			for iCS2, pCS2 in pairs(Players) do
				if (pCS ~= pCS2 and pCS2:IsAlive() and pCS2:IsMinorCiv() and Teams[pPlayer:GetTeam()]:IsHasMet(pCS2:GetTeam()) and not(pTeam:IsAtWar(pCS2:GetTeam()))) then
					pCS2:ChangeMinorCivFriendshipWithMajor(pPlayer:GetID(), iOthersInfluence)
				end
			end

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_IH_BULLY_OUTCOME_2_NOTIFICATION", pCS:GetCivilizationShortDescription()), Locale.ConvertTextKey(Event_UPlaneptuneBacktalk.Name))
		end
		)

	--=========================================================
	-- Outcome 3
	--=========================================================
	Event_UPlaneptuneBacktalk.Outcomes[3] = {}
	Event_UPlaneptuneBacktalk.Outcomes[3].Name = "TXT_KEY_EVENT_VV_PLANEPTUNE_IH_BULLY_OUTCOME_3"
	Event_UPlaneptuneBacktalk.Outcomes[3].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_IH_BULLY_OUTCOME_3_RESULT")
	Event_UPlaneptuneBacktalk.Outcomes[3].CanFunc = (
		function(pPlayer, pCS)
			Event_UPlaneptuneBacktalk.Outcomes[3].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_IH_BULLY_OUTCOME_3_RESULT", pCS:GetCivilizationShortDescription(), sCaptureShares, iCaptureCulture)
			return true
		end
		)
	Event_UPlaneptuneBacktalk.Outcomes[3].DoFunc = (
		function(pPlayer, pCS)
			local pTeam = Teams[pPlayer:GetTeam()]
			local iTheirTeam = pCS:GetTeam()
			if not pTeam:IsAtWar(iTheirTeam) then pTeam:DeclareWar(iTheirTeam) end
			pTeam:SetPermanentWarPeace(iTheirTeam, true)

			save(pPlayer, "Event_UPlaneptuneBacktalk", true)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_IH_BULLY_OUTCOME_3_NOTIFICATION",  pCS:GetCivilizationShortDescription()), Locale.ConvertTextKey(Event_UPlaneptuneBacktalk.Name))
		end
		)

	Event_UPlaneptuneBacktalk.Outcomes[3].Monitors = {}
	Event_UPlaneptuneBacktalk.Outcomes[3].Monitors[GameEvents.CityCaptureComplete] = (function(iOldOwner, bIsCapital, iX, iY, iNewOwner, iPop, bConquest)
		if bConquest and bIsCapital and iOldOwner >= GameDefines.MAX_MAJOR_CIVS then
			local pPlayer = Players[iNewOwner]	
			if load(pPlayer, "Event_UPlaneptuneBacktalk") then
				local pCS = Players[iOldOwner]
				if Teams[pPlayer:GetTeam()]:IsPermanentWarPeace(pCS:GetTeam()) then
					LuaEvents.HDNChangeShares(iNewOwner, iCaptureShares)
					pPlayer:ChangeJONSCulture(iCaptureCulture)
				end
			end
		end
	end)


for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if sCiv == "CIVILIZATION_VV_PLANEPTUNE_IH" or sCiv == "CIVILIZATION_VV_PLANEPTUNE_PL" then
			tEvents.Event_UPlaneptuneBacktalk = Event_UPlaneptuneBacktalk
			break
		end
	end
end

print("Plutia Events Load Complete")