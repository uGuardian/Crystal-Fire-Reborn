-- LoweeDecisions
-- Author: Vice
-- DateCreated: 3/23/2015 9:50:59 PM
--------------------------------------------------------------


function split(str, pat)
   local t = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pat
   local last_end = 1
   local s, e, cap = str:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
	 table.insert(t,cap)
      end
      last_end = e+1
      s, e, cap = str:find(fpat, last_end)
   end
   if last_end <= #str then
      cap = str:sub(last_end)
      table.insert(t, cap)
   end
   return t
end


local iTurns = math.ceil(20 * iMod)

--------------------------------------------------------------------------------------------------------------------------------------------
--Decision 1: Host the Lowee Bash Tournament
--+20% [ICON_PRODUCTION] Production towards Military Units and new Military Units start with 10 XP for 20 turns (Standard)
--Enables certain Events
--------------------------------------------------------------------------------------------------------------------------------------------
local Decisions_LoweeBashTournament = {}
	Decisions_LoweeBashTournament.Name = "TXT_KEY_DECISIONS_VV_LOWEE_SMASH_BROTHERS"
	Decisions_LoweeBashTournament.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_VV_LOWEE_SMASH_BROTHERS_DESC")
	HookDecisionCivilizationIcon(Decisions_LoweeBashTournament, "CIVILIZATION_VV_LOWEE")
	Decisions_LoweeBashTournament.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_VV_LOWEE) and (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_VV_LOWEE_WH)
		and (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_VV_LOWEE_ULTRA) and (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_VV_LOWEE_WH_ULTRA) then
			return false, false
		end

		if load(pPlayer, "Decisions_LoweeBashTournament") then
			Decisions_LoweeBashTournament.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_VV_LOWEE_SMASH_BROTHERS_ENACTED_DESC", iTurns)
			return false, false, true
		end

		local iGold = math.ceil(300 * iMod)
		local iCityRequirement = 4;
		local iLevel4UnitRequirement = 4;
		if load(pPlayer, "Decisions_LoweeBashTournament_Times") then
			iCityRequirement = iCityRequirement + load(pPlayer, "Decisions_LoweeBashTournament_Times")
			iLevel4UnitRequirement = iLevel4UnitRequirement + load(pPlayer, "Decisions_LoweeBashTournament_Times")
		end

		Decisions_LoweeBashTournament.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_VV_LOWEE_SMASH_BROTHERS_DESC", iCityRequirement, iLevel4UnitRequirement, iGold, iTurns)

		if pPlayer:GetGold() < iGold then return true, false end
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end
		
		local iNumCities = 0
		for pCity in pPlayer:Cities() do
			if pCity:IsHasBuilding(GameInfoTypes.BUILDING_COLOSSEUM) then
				iNumCities = iNumCities + 1
				if iNumCities >= iCityRequirement then
					break
				end
			end
		end

		if iNumCities < iCityRequirement then return true, false end

		local iNumLevel4Units = 0
		for pUnit in pPlayer:Units() do
			if pUnit:GetLevel() >= 4 then
				iNumLevel4Units = iNumLevel4Units + 1
				if iNumLevel4Units >= iLevel4UnitRequirement then
					return true, true
				end
			end
		end

		return true, false

	end
	)

	Decisions_LoweeBashTournament.DoFunc = (
	function(pPlayer)
		local iCost = math.ceil(300 * iMod)
		pPlayer:ChangeGold(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
		pPlayer:SetNumFreePolicies(1)
		pPlayer:SetHasPolicy(GameInfoTypes.POLICY_DECISIONS_VV_LOWEE, true)
		pPlayer:SetNumFreePolicies(0)
		save(pPlayer, "Decisions_LoweeBashTournament", Game:GetGameTurn())
		if load(pPlayer, "Decisions_LoweeBashTournament_Times") then
			save(pPlayer, "Decisions_LoweeBashTournament_Times", load(pPlayer, "Decisions_LoweeBashTournament_Times") + 1)
		else
			save(pPlayer, "Decisions_LoweeBashTournament_Times", 1)
		end
	end
	)
	
	Decisions_LoweeBashTournament.Monitors = {}
	Decisions_LoweeBashTournament.Monitors[GameEvents.PlayerDoTurn] =  (
	function(iPlayer)
		if iPlayer < GameDefines.MAX_MAJOR_CIVS then
			local pPlayer = Players[iPlayer]
			if load(pPlayer, "Decisions_LoweeBashTournament") then
				if Game:GetGameTurn() - iTurns >= load(pPlayer, "Decisions_LoweeBashTournament") then
					save(pPlayer, "Decisions_LoweeBashTournament", nil)
					pPlayer:SetNumFreePolicies(1)
					pPlayer:SetHasPolicy(GameInfoTypes.POLICY_DECISIONS_VV_LOWEE, false)
					pPlayer:SetNumFreePolicies(0)
					for eEvent, fFunc in pairs(Decisions_LoweeBashTournament.Monitors) do
						eEvent.Remove(fFunc)
						eEvent.Add(fFunc)
					end
				end
			end
		end
	end
	)
	

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_VV_LOWEE, "Decisions_LoweeBashTournament", Decisions_LoweeBashTournament)
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_VV_LOWEE_WH, "Decisions_LoweeBashTournament", Decisions_LoweeBashTournament)
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_VV_LOWEE_ULTRA, "Decisions_LoweeBashTournament", Decisions_LoweeBashTournament)
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_VV_LOWEE_WH_ULTRA, "Decisions_LoweeBashTournament", Decisions_LoweeBashTournament)

--------------------------------------------------------------------------------------------------------------------------------------------
--Decision 2: Pander to the Casual Audience
--If you send a Trade Route to a foreign City belonging to a Civilization with a higher Score than you,
 --it grants the originating City +10% Food and Gold. (This effect cannot stack multiple times on the same City.)
--------------------------------------------------------------------------------------------------------------------------------------------

local Decisions_LoweeCasualPandering = {}
	Decisions_LoweeCasualPandering.Name = "TXT_KEY_DECISIONS_VV_LOWEE_PANDER_CASUALS"
	Decisions_LoweeCasualPandering.Desc = "TXT_KEY_DECISIONS_VV_LOWEE_PANDER_CASUALS_DESC"
	HookDecisionCivilizationIcon(Decisions_LoweeCasualPandering, "CIVILIZATION_VV_LOWEE")
	Decisions_LoweeCasualPandering.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_VV_LOWEE) and (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_VV_LOWEE_WH)
		and (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_VV_LOWEE_ULTRA) and (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_VV_LOWEE_WH_ULTRA) then
			return false, false
		end

		if load(pPlayer, "Decisions_LoweeCasualPandering") == true then
			Decisions_LoweeCasualPandering.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_VV_LOWEE_PANDER_CASUALS_ENACTED_DESC")
			return false, false, true
		end

		local iGoldCost = math.ceil(700 * iMod)
		local iCultureCost = math.ceil(300 * iMod)
		Decisions_LoweeCasualPandering.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_VV_LOWEE_PANDER_CASUALS_DESC", iGoldCost, iCultureCost)
		
		if pPlayer:GetCurrentEra() < GameInfoTypes.ERA_RENAISSANCE then return true, false end
		if pPlayer:GetGold() < iGoldCost then return true, false end
		if pPlayer:GetJONSCulture() < iCultureCost then return true, false end
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end
		
		local pTeam = Teams[pPlayer:GetTeam()]
		local iAverageScore = 0
		local iNumCivs = 0
		for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
			local pLoop = Players[i]
			if pLoop:IsAlive() then
				if (pLoop ~= pPlayer and not pTeam:IsHasMet(pLoop:GetTeam())) then
					return true, false
				end
				iAverageScore = iAverageScore + pLoop:GetScore()
				iNumCivs = iNumCivs + 1
			end
		end
		iAverageScore = math.ceil(iAverageScore / iNumCivs)
		if pPlayer:GetScore() < iAverageScore then return true, true end

		return true, false
	end
	)

	Decisions_LoweeCasualPandering.DoFunc = (
	function(pPlayer)
		local iGoldCost = math.ceil(700 * iMod)
		local iCultureCost = math.ceil(300 * iMod)
		pPlayer:ChangeGold(-iGoldCost)
		pPlayer:ChangeJONSCulture(-iCultureCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
		save(pPlayer, "Decisions_LoweeCasualPandering", true)
	end
	)
	
	Decisions_LoweeCasualPandering.Monitors = {}
	Decisions_LoweeCasualPandering.Monitors[GameEvents.PlayerDoTurn] =  (
	function(iPlayer)
		if iPlayer < GameDefines.MAX_MAJOR_CIVS then
			local pPlayer = Players[iPlayer]
			if load(pPlayer, "Decisions_LoweeCasualPandering") == true then
				local tCitiesToSet = {}
				local tTradeRoutes = pPlayer:GetTradeRoutes()
				for k, v in pairs(tTradeRoutes) do
					if v.ToID ~= v.FromID then
						local pOtherPlayer = Players[v.ToID]
						if pOtherPlayer:GetScore() > pPlayer:GetScore() then
							tCitiesToSet[v.FromCity] = true
						end
					end
				end
				for pCity in pPlayer:Cities() do
					if tCitiesToSet[pCity] then
						pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_LOWEE_DUMMY, 1, true)
					else
						pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_LOWEE_DUMMY, 0)
					end
				end
			end
		end
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_VV_LOWEE, "Decisions_LoweeCasualPandering", Decisions_LoweeCasualPandering)
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_VV_LOWEE_WH, "Decisions_LoweeCasualPandering", Decisions_LoweeCasualPandering)
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_VV_LOWEE_ULTRA, "Decisions_LoweeCasualPandering", Decisions_LoweeCasualPandering)
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_VV_LOWEE_ULTRA_WH, "Decisions_LoweeCasualPandering", Decisions_LoweeCasualPandering)

