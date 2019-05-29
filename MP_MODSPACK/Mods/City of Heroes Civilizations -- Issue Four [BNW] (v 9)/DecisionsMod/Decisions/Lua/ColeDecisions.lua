-- ColeDecisions
-- Author: Vicevirtuoso
-- DateCreated: 8/25/2014 11:24:14 AM
--------------------------------------------------------------


local iEnricheCapital = GameInfoTypes.BUILDING_DECISIONS_COLE_ENRICHE_CAPITAL
local iEnricheAqueduct = GameInfoTypes.BUILDING_DECISIONS_COLE_ENRICHE_AQUEDUCT
local iSeers = GameInfoTypes.BUILDING_DECISIONS_COLE_SEERS

local Decisions_ColeEnriche = {}
	Decisions_ColeEnriche.Name = "TXT_KEY_DECISIONS_COLE_ENRICHE"
	Decisions_ColeEnriche.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_COLE_ENRICHE_DESC")
	HookDecisionCivilizationIcon(Decisions_ColeEnriche, "CIVILIZATION_PRAETORIA")
	Decisions_ColeEnriche.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_PRAETORIA) then
			return false, false
		end
		if load(pPlayer, "Decisions_ColeEnriche") == true then
			Decisions_ColeEnriche.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_COLE_ENRICHE_ENACTED_DESC")
			return false, false, true
		end
		
		local iCost = math.ceil(600 * iMod)

		Decisions_ColeEnriche.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_COLE_ENRICHE_DESC", iCost)
		
		if pPlayer:GetGold() < iCost then return true, false end

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end

		local pTeam = Teams[pPlayer:GetTeam()]
		local pTeamTechs = pTeam:GetTeamTechs()
		
		if pTeamTechs:HasTech(GameInfoTypes.TECH_BIOLOGY) then
			return true, true
		else
			return true, false
		end
	end
	)
	


	Decisions_ColeEnriche.DoFunc = (
	function(pPlayer)
		local iCost = math.ceil(600 * iMod)
		pPlayer:ChangeGold(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		for pCity in pPlayer:Cities() do
			if pCity:IsHasBuilding(GameInfoTypes.BUILDING_AQUEDUCT) then
				pCity:SetNumRealBuilding(iEnricheAqueduct, 1)
			else
				pCity:SetNumRealBuilding(iEnricheAqueduct, 0)
			end
			if pCity:IsCapital() then
				pCity:SetNumRealBuilding(iEnricheCapital, 1)
			else
				pCity:SetNumRealBuilding(iEnricheCapital, 0)
			end
		end
		save(pPlayer, "Decisions_ColeEnriche", true)
	end
	)

	Decisions_ColeEnriche.Monitors = {}
	Decisions_ColeEnriche.Monitors[GameEvents.PlayerDoTurn] =  (
	function(iPlayer)
		local pPlayer = Players[iPlayer]
		if load(pPlayer, "Decisions_ColeEnriche") == true then
			for pCity in pPlayer:Cities() do
				if pCity:IsHasBuilding(GameInfoTypes.BUILDING_AQUEDUCT) then
					pCity:SetNumRealBuilding(iEnricheAqueduct, 1)
				else
					pCity:SetNumRealBuilding(iEnricheAqueduct, 0)
				end
				if pCity:IsCapital() then
					pCity:SetNumRealBuilding(iEnricheCapital, 1)
				else
					pCity:SetNumRealBuilding(iEnricheCapital, 0)
				end
			end	
		end
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_PRAETORIA, "Decisions_ColeEnriche", Decisions_ColeEnriche)




local Decisions_ColeSeers = {}
	Decisions_ColeSeers.Name = "TXT_KEY_DECISIONS_COLE_SEERS"
	Decisions_ColeSeers.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_COLE_SEERS_DESC")
	HookDecisionCivilizationIcon(Decisions_ColeSeers, "CIVILIZATION_PRAETORIA")
	Decisions_ColeSeers.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_PRAETORIA) then
			return false, false
		end

		if load(pPlayer, "Decisions_ColeSeers") == true then
			Decisions_ColeSeers.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_COLE_SEERS_ENACTED_DESC")
			return false, false, true
		end

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end
		
		local iBAFs = 0
		for pCity in pPlayer:Cities() do
			if pCity:IsHasBuilding(GameInfoTypes.BUILDING_PRAETORIA_BAF) then
				iBAFs = iBAFs + 1
				if iBAFs >= 6 then
					return true, true
				end
			end
		end
		
		return true, false
	end
	)
	
	Decisions_ColeSeers.DoFunc = (
	function(pPlayer)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		pPlayer:GetCapitalCity():SetNumRealBuilding(iSeers, 1)
		save(pPlayer, "Decisions_ColeSeers", true)
	end
	)

	Decisions_ColeSeers.Monitors = {}
	Decisions_ColeSeers.Monitors[GameEvents.PlayerDoTurn] =  (
	function(iPlayer)
		local pPlayer = Players[iPlayer]
		if load(pPlayer, "Decisions_ColeSeers") == true and pPlayer:IsAlive() then
			pPlayer:GetCapitalCity():SetNumRealBuilding(iSeers, 1)
		end
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_PRAETORIA, "Decisions_ColeSeers", Decisions_ColeSeers)

