-- PMMMDemonHomuraDecisions
-- Author: TheBeast
-- DateCreated: 8/25/2014 2:02:02 PM
--------------------------------------------------------------

local iIncubatorSlave = GameInfoTypes.UNIT_PMMM_INCUBATOR_SLAVE
local iTurnsBetweenMin = math.ceil(15 * iMod)

--------------------------------------------------------------------------------------------------------------------------------------------
--Decision 1: Punish the Incubators
--Kill every Incubator Slave and permanently get +1 Happiness for it.
--Prevents building more for the rest of the Era.
--------------------------------------------------------------------------------------------------------------------------------------------

local Decisions_PunishIncubators = {}
	Decisions_PunishIncubators.Name = "TXT_KEY_DECISIONS_DEMON_HOMURA_KILL_INCUBATORS"
	Decisions_PunishIncubators.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_DEMON_HOMURA_KILL_INCUBATORS_DESC", iTurnsBetweenMin)
	HookDecisionCivilizationIcon(Decisions_PunishIncubators, "CIVILIZATION_DEMON_HOMURA")
	Decisions_PunishIncubators.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_DEMON_HOMURA) then
			return false, false
		end
		if not pPlayer:GetCapitalCity() then
			return false, false
		end
		local iEra = load(pPlayer, "Decisions_PunishIncubators")
		local iTurn = load(pPlayer, "Decisions_PunishIncubators_Turn")

		local iCurrentEra = pPlayer:GetCurrentEra()
		if iEra ~= nil then
			if iEra < iCurrentEra then
				save(pPlayer, "Decisions_PunishIncubators", nil)
			else
				Decisions_PunishIncubators.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_DEMON_HOMURA_KILL_INCUBATORS_ENACTED_DESC", iTurnsBetweenMin)
				return false, false, true
			end
		end

		if iTurn and Game:GetGameTurn() - iTurn >= iTurnsBetweenMin then
			save(pPlayer, "Decisions_PunishIncubators_Turn", nil)
		elseif iTurn then
			Decisions_PunishIncubators.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_DEMON_HOMURA_KILL_INCUBATORS_ENACTED_DESC", iTurnsBetweenMin)
			return false, false, true	
		end
		
		for pUnit in pPlayer:Units() do
			if pUnit:GetUnitType() == iIncubatorSlave then
				return true, true
			end
		end

		return true, false
	end
	)
	
	Decisions_PunishIncubators.DoFunc = (
	function(pPlayer)
		local pCapital = pPlayer:GetCapitalCity()
		local iNumKilled = 0
		for pUnit in pPlayer:Units() do
			if pUnit:GetUnitType() == iIncubatorSlave then
				pUnit:Kill(true)
				iNumKilled = iNumKilled + 1
			end
		end
		pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_DECISION_DEMON_HOMURA_INCUBATOR, pCapital:GetNumRealBuilding(GameInfoTypes.BUILDING_DECISION_DEMON_HOMURA_INCUBATOR) + iNumKilled)
		
		save(pPlayer, "Decisions_PunishIncubators", pPlayer:GetCurrentEra())
		save(pPlayer, "Decisions_PunishIncubators_Turn", Game:GetGameTurn())
	end
	)

	Decisions_PunishIncubators.Monitors = {}
	Decisions_PunishIncubators.Monitors[GameEvents.PlayerCanTrain] =  (
	function(iPlayer, iUnitType)
		if iUnitType == iIncubatorSlave then
			local pPlayer = Players[iPlayer]
			if load(pPlayer, "Decisions_PunishIncubators") then
				local iEra = pPlayer:GetCurrentEra()
				if iEra == load(pPlayer, "Decisions_PunishIncubators") then
					return false
				else
					local iTurn = load(pPlayer, "Decisions_PunishIncubators_Turn")
					if iTurn then
						if iTurn and Game:GetGameTurn() - iTurn >= iTurnsBetweenMin then
							return true
						else
							return false
						end
					else
						return true
					end
				end
			else
				return true
			end
		else
			return true
		end
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_DEMON_HOMURA, "Decisions_PunishIncubators", Decisions_PunishIncubators)

--------------------------------------------------------------------------------------------------------------------------------------------
--Decision 2: Pacify More of the World's People
--Gives every other Civ +1 Happiness and gives you +5% Yields.
--------------------------------------------------------------------------------------------------------------------------------------------
local Decisions_PacifyTheWorld = {}
	Decisions_PacifyTheWorld.Name = "TXT_KEY_DECISIONS_DEMON_HOMURA_PACIFICATION"
	Decisions_PacifyTheWorld.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_DEMON_HOMURA_PACIFICATION_DESC")
	HookDecisionCivilizationIcon(Decisions_PacifyTheWorld, "CIVILIZATION_DEMON_HOMURA")
	Decisions_PacifyTheWorld.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_DEMON_HOMURA) then
			return false, false
		end

		if pPlayer:IsAnarchy() then
			Decisions_PunishIncubators.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_DEMON_HOMURA_PACIFICATION_ENACTED_DESC")
			return false, false, true
		end

		local iAnarchyTurns = 1 * iMod;
		if load(pPlayer, "Decisions_PacifyTheWorld") then
			iAnarchyTurns = iAnarchyTurns + (load(pPlayer, "Decisions_PacifyTheWorld") * iMod)
		else
			save(pPlayer, "Decisions_PacifyTheWorld", 0)
		end

		Decisions_PacifyTheWorld.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_DEMON_HOMURA_PACIFICATION_DESC", iAnarchyTurns)
		
		for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
			local pLoopPlayer = Players[i]
			if pLoopPlayer:IsAlive() then
				if not Teams[pPlayer:GetTeam()]:IsHasMet(pLoopPlayer:GetTeam()) then
					return true, false
				end
			end
		end

		return true, true
	end
	)
	
	Decisions_PacifyTheWorld.DoFunc = (
	function(pPlayer)
		local iAnarchyTurns = 1 * iMod;
		local iValue; 
		if load(pPlayer, "Decisions_PacifyTheWorld") then
			iAnarchyTurns = iAnarchyTurns + (load(pPlayer, "Decisions_PacifyTheWorld") * iMod)
			iValue = load(pPlayer, "Decisions_PacifyTheWorld") + 1
		else
			iValue = 1
		end
		pPlayer:ChangeAnarchyNumTurns(iAnarchyTurns)
		local pCapital = pPlayer:GetCapitalCity()
		if pCapital then
			pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_DECISION_DEMON_HOMURA_PACIFY_SELF, iValue * 5)
		end
		for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
			local pLoopPlayer = Players[i]
			if pLoopPlayer:IsAlive() and pLoopPlayer ~= pPlayer then
				local pLoopCapital = pLoopPlayer:GetCapitalCity()
				if pLoopCapital then
					pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_DECISION_DEMON_HOMURA_PACIFY_OTHERS, iValue)
				end
			end
		end
		save(pPlayer, "Decisions_PacifyTheWorld", iValue)
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_DEMON_HOMURA, "Decisions_PacifyTheWorld", Decisions_PacifyTheWorld)

