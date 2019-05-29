-- PMMMHomuraDecisions
-- Author: Vicevirtuoso
-- DateCreated: 8/22/2014 1:02:29 PM
--------------------------------------------------------------

include("PMMMDefines.lua")

--------------------------------------------------------------------------------------------------------------------------------------------
--Decision 1: Devote to Madoka
--If either Madoka is present, gain an exorbitant diplomatic bonus with them at the cost of a diplomatic penalty with everyone else.
--If neither are present, gain the Madoka Memorial which gives +2 Faith from Monuments but increases Unhappiness by 10%
--------------------------------------------------------------------------------------------------------------------------------------------
local tMadokaPlayers = {}
local bAnyMadokaPlayers;

for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
	local pPlayer = Players[i]
	if pPlayer:IsEverAlive() then
		if pPlayer:GetLeaderType() == GameInfoTypes.LEADER_MADOKA or pPlayer:GetLeaderType() == GameInfoTypes.LEADER_ORIGINAL_MADOKA then
			tMadokaPlayers[i] = true
			bAnyMadokaPlayers = true
		end
	end
end

local Decisions_DevoteToMadoka = {}
	Decisions_DevoteToMadoka.Name = "TXT_KEY_DECISIONS_HOMURA_DEVOTE_MADOKA"
	Decisions_DevoteToMadoka.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_HOMURA_DEVOTE_MADOKA_DESC")
	HookDecisionCivilizationIcon(Decisions_DevoteToMadoka, "CIVILIZATION_HOMURA")
	Decisions_DevoteToMadoka.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_HOMURA) then
			return false, false
		end
		if load(pPlayer, "Decisions_DevoteToMadoka") == true then
			Decisions_DevoteToMadoka.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_HOMURA_DEVOTE_MADOKA_ENACTED_DESC")
			return false, false, true
		end
		
		local iCost = math.ceil(250 * iMod)
		Decisions_DevoteToMadoka.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_HOMURA_DEVOTE_MADOKA_DESC", iCost)
		
		if pPlayer:GetGold() < iCost then return true, false end
		
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end

		if pPlayer:GetCurrentEra() < GameInfoTypes.ERA_CLASSICAL then return true, false else return true, true end
	
	end
	)
	
	Decisions_DevoteToMadoka.DoFunc = (
	function(pPlayer)
		local iCost = math.ceil(250 * iMod)
		pPlayer:ChangeGold(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
		if bAnyMadokaPlayers then
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetNumFreePolicies(0)
			pPlayer:SetHasPolicy(GameInfoTypes.POLICY_DECISIONS_HOMURA_DEVOTE_MADOKA, true)
		else
			pPlayer:GetCapitalCity():SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_HOMURA_DEVOTE_MADOKA, 1)
		end
		save(pPlayer, "Decisions_DevoteToMadoka", true)
	end
	)

	Decisions_DevoteToMadoka.Monitors = {}
	Decisions_DevoteToMadoka.Monitors[GameEvents.GetDiploModifier] =  (
	function(iEvent, iFromPlayer, iToPlayer)
		local pFromPlayer = Players[iFromPlayer]
		local pToPlayer = Players[iToPlayer]
		if (load(pFromPlayer, "Decisions_DevoteToMadoka") or load(pToPlayer, "Decisions_DevoteToMadoka")) and bAnyMadokaPlayers then
			if iEvent == GameInfoTypes.DIPLOMODIFIER_PMMM_DECISIONS_HOMURA_POSITIVE_TO_HOMURA then
				if tMadokaPlayers[iFromPlayer] and pToPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_HOMURA then
					return -150
				else
					return 0 
				end
			elseif iEvent == GameInfoTypes.DIPLOMODIFIER_PMMM_DECISIONS_HOMURA_POSITIVE_TO_MADOKA then
				if tMadokaPlayers[iToPlayer] and pFromPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_HOMURA then
					return -150
				else
					return 0 
				end
			elseif iEvent == GameInfoTypes.DIPLOMODIFIER_PMMM_DECISIONS_HOMURA_NEGATIVE_TO_HOMURA then
				if not tMadokaPlayers[iFromPlayer] and pToPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_HOMURA then
					return 20
				else
					return 0 
				end
			end
		else
			return 0
		end
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_HOMURA, "Decisions_DevoteToMadoka", Decisions_DevoteToMadoka)






--------------------------------------------------------------------------------------------------------------------------------------------
--Decision 2: Draw Mana Into Your Shield
--Reduce the cooldown of Time Stop by 10 turns (not permanent) at the cost of GP points in your Capital
--------------------------------------------------------------------------------------------------------------------------------------------
local Decisions_DrawSandIntoShield = {}
	Decisions_DrawSandIntoShield.Name = "TXT_KEY_DECISIONS_HOMURA_SAND_SHIELD"
	Decisions_DrawSandIntoShield.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_HOMURA_SAND_SHIELD_DESC")
	HookDecisionCivilizationIcon(Decisions_DrawSandIntoShield, "CIVILIZATION_HOMURA")
	Decisions_DrawSandIntoShield.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_HOMURA) then
			return false, false
		end
		local iEra = load(pPlayer, "Decisions_DrawSandIntoShield")
		local iCurrentEra = pPlayer:GetCurrentEra()
		if iEra ~= nil then
			if iEra < iCurrentEra then
				save(pPlayer, "Decisions_DrawSandIntoShield", nil)
			else
				Decisions_DrawSandIntoShield.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_HOMURA_SAND_SHIELD_ENACTED_DESC")
				return false, false, true
			end
		end
		
		if PMMM.TimeStopCooldown[pPlayer:GetID()] then
			if PMMM.TimeStopCooldown[pPlayer:GetID()] <= 0 then
				return true, false
			end
		else
			return true, false
		end
		
		local pCapital = pPlayer:GetCapitalCity()
		if pCapital then
			local iTotalGPProgress = 0
			for pSpecialistInfo in GameInfo.Specialists() do
				local iSpecialistIndex = pSpecialistInfo.ID;			
				local iProgress = pCapital:GetSpecialistGreatPersonProgress(iSpecialistIndex)
				iTotalGPProgress = iTotalGPProgress + iProgress
				if iTotalGPProgress >= 100 then
					return true, true
				end
			end
			return true, false
		else
			return true, false
		end
	end
	)
	
	Decisions_DrawSandIntoShield.DoFunc = (
	function(pPlayer)
		local pCapital = pPlayer:GetCapitalCity()
			for pSpecialistInfo in GameInfo.Specialists() do
				local iSpecialistIndex = pSpecialistInfo.ID;	
				local iReduceValue = 2500
				local iCurrentValue = pCapital:GetSpecialistGreatPersonProgressTimes100(iSpecialistIndex)
				if iCurrentValue < iReduceValue then
					iReduceValue = iCurrentValue
				end
				pCapital:ChangeSpecialistGreatPersonProgressTimes100(iSpecialistIndex, -1 * iReduceValue)
			end
		
		PMMM.TimeStopCooldown[pPlayer:GetID()] = math.max(PMMM.TimeStopCooldown[pPlayer:GetID()] - 10, 0)
		Events.SerialEventCityInfoDirty()
		Events.SerialEventUnitInfoDirty()
		save(pPlayer, "Decisions_DrawSandIntoShield", pPlayer:GetCurrentEra())
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_HOMURA, "Decisions_DrawSandIntoShield", Decisions_DrawSandIntoShield)

