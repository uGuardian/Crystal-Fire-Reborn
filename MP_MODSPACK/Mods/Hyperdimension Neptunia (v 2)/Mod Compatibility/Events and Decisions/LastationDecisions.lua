-- LastationDecisions
-- Author: Vice
--------------------------------------------------------------


local CELL_POLICY = GameInfoTypes.POLICY_DECISION_LASTATION_CELL
local CD_POLICY = GameInfoTypes.POLICY_DECISION_LASTATION_CDMEMORY
local PLUS_POLICY = GameInfoTypes.POLICY_DECISION_LASTATION_PLUS
local BUILD_CULTURE_MULTIPLIER = 0.05
--------------------------------------------------------------------------------------------------------------------------------------------
--Decision 1: Develop Cell Architecture (Hyperdimension Only)
--------------------------------------------------------------------------------------------------------------------------------------------
local Decisions_LastationCell = {}
	Decisions_LastationCell.Name = "TXT_KEY_DECISIONS_VV_LASTATION_CELL"
	Decisions_LastationCell.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_VV_LASTATION_CELL_DESC")
	HookDecisionCivilizationIcon(Decisions_LastationCell, "CIVILIZATION_VV_LASTATION")
	Decisions_LastationCell.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_VV_LASTATION) and (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_VV_LASTATION_BH) then
			return false, false
		end

		if load(pPlayer, "Decisions_LastationCell") == true then
			Decisions_LastationCell.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_VV_LASTATION_CELL_ENACTED_DESC")
			return false, false, true
		end

		local iGoldCost = math.ceil(500 * iMod)
		local iCultureCost = math.ceil(200 * iMod)
		Decisions_LastationCell.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_VV_LASTATION_CELL_DESC", iGoldCost, iCultureCost)
		
		if pPlayer:GetGold() < iGoldCost then return true, false end
		if pPlayer:GetJONSCulture() < iCultureCost then return true, false end
		
		local pTeam = Teams[pPlayer:GetTeam()]
		local pTeamTechs = pTeam:GetTeamTechs()
		
		if pTeamTechs:HasTech(GameInfoTypes.TECH_ARCHITECTURE) then 
			for pUnit in pPlayer:Units() do
				if pUnit:GetUnitClassType() == GameInfoTypes.UNITCLASS_ENGINEER then
					return true, true
				end
			end
			return true, false
		else
			return true, false
		end
	end
	)

	Decisions_LastationCell.DoFunc = (
	function(pPlayer)
		local iGoldCost = math.ceil(500 * iMod)
		local iCultureCost = math.ceil(200 * iMod)
		pPlayer:ChangeGold(-iGoldCost)
		pPlayer:ChangeJONSCulture(-iCultureCost)

		local iUnit;
		local iUnitType;
		local iX;
		local iY
		for pUnit in pPlayer:Units() do
			if pUnit:GetUnitClassType() == GameInfoTypes.UNITCLASS_ENGINEER then
				iUnit, iUnitType, iX, iY = pUnit:GetID(), pUnit:GetUnitType(), pUnit:GetX(), pUnit:GetY()
				pUnit:Kill(true)
			end
		end

		local bIsDVMC = false

		if GameInfo.CustomModOptions then
			for row in GameInfo.CustomModOptions() do
				if row.Name == "EVENTS_GREAT_PEOPLE" and row.Value == 1 then
					bIsDVMC = true
				end
			end
		end
		if bIsDVMC then
			GameEvents.GreatPersonExpended.Call(pPlayer:GetID(), iUnit, iUnitType, iX, iY)
		else
			GameEvents.GreatPersonExpended.Call(pPlayer:GetID(), iUnitType)
		end

		pPlayer:SetNumFreePolicies(1)
		pPlayer:SetNumFreePolicies(0)
		pPlayer:SetHasPolicy(CELL_POLICY, true)

		save(pPlayer, "Decisions_LastationCell", true)
	end
	)
	
	Decisions_LastationCell.Monitors = {}
	Decisions_LastationCell.Monitors[GameEvents.CityConstructed] =  (
	function(iPlayer, iCity, iBuildingType, bGold, bFaithOrCulture)
		if not bGold and iPlayer < GameDefines.MAX_MAJOR_CIVS then
			local pPlayer = Players[iPlayer]
			if load(pPlayer, "Decisions_LastationCell") then
				local building = GameInfo.Buildings[iBuildingType]
				local class = GameInfo.BuildingClasses[building.BuildingClass]
				if class.MaxGlobalInstances == -1 and class.MaxPlayerInstances == -1 and class.MaxTeamInstances == -1 then
					local cost = pPlayer:GetBuildingProductionNeeded(iBuildingType)
					if cost and cost > 0 then
						local culture = math.floor(cost * BUILD_CULTURE_MULTIPLIER)
						pPlayer:ChangeJONSCulture(culture)
						if culture > 0 and iPlayer == Game:GetActivePlayer() then
							Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_ALERT_NOIRE_DECISIONS_CELL", building.Description, culture))
						end
					end
				end
			end
		end
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_VV_LASTATION, "Decisions_LastationCell", Decisions_LastationCell)
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_VV_LASTATION_BH, "Decisions_LastationCell", Decisions_LastationCell)

--------------------------------------------------------------------------------------------------------------------------------------------
--Decision 1: Introduce CDs and Memory Cards (Ultradimension Only)
--------------------------------------------------------------------------------------------------------------------------------------------

local Decisions_LastationCDMemory = {}
	Decisions_LastationCDMemory.Name = "TXT_KEY_DECISIONS_VV_LASTATION_CDMEMORY"
	Decisions_LastationCDMemory.Desc = "TXT_KEY_DECISIONS_VV_LASTATION_CDMEMORY_DESC"
	HookDecisionCivilizationIcon(Decisions_LastationCDMemory, "CIVILIZATION_VV_LASTATION")
	Decisions_LastationCDMemory.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_VV_LASTATION_ULTRA) and (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_VV_LASTATION_BH_ULTRA) then
			return false, false
		end

		if load(pPlayer, "Decisions_LastationCDMemory") == true then
			Decisions_LastationCDMemory.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_VV_LASTATION_CDMEMORY_ENACTED_DESC")
			return false, false, true
		end

		local iGoldCost = math.ceil(600 * iMod)
		local iShareThreshold = 3000
		local iShareCost = 1500
		local sShareThreshold = string.format("%.2f%%", iShareThreshold / 100)
		local sShareCost = string.format("%.2f%%", iShareCost / 100)
		Decisions_LastationCDMemory.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_VV_LASTATION_CDMEMORY_DESC", iGoldCost, sShareThreshold, sShareCost)
		
		if pPlayer:GetGold() < iGoldCost then return true, false end
		if MapModData.HDNMod.Shares[pPlayer:GetID()] < iShareThreshold then return true, false end

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end
		
		return true, true
	end
	)

	Decisions_LastationCDMemory.DoFunc = (
	function(pPlayer)
		local iGoldCost = math.ceil(600 * iMod)
		local iShareCost = 1500
		pPlayer:ChangeGold(-iGoldCost)
		LuaEvents.HDNChangeShares(pPlayer:GetID(), -iShareCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)

		pPlayer:SetNumFreePolicies(1)
		pPlayer:SetNumFreePolicies(0)
		pPlayer:SetHasPolicy(CD_POLICY, true)

		save(pPlayer, "Decisions_LastationCDMemory", true)
	end
	)
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_VV_LASTATION_ULTRA, "Decisions_LastationCDMemory", Decisions_LastationCDMemory)
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_VV_LASTATION_BH_ULTRA, "Decisions_LastationCDMemory", Decisions_LastationCDMemory)




--------------------------------------------------------------------------------------------------------------------------------------------
--Decision 2: Implement Lastation Plus
--------------------------------------------------------------------------------------------------------------------------------------------

local Decisions_LastationPlus = {}
	Decisions_LastationPlus.Name = "TXT_KEY_DECISIONS_VV_LASTATION_PLUS"
	Decisions_LastationPlus.Desc = "TXT_KEY_DECISIONS_VV_LASTATION_PLUS_DESC"
	HookDecisionCivilizationIcon(Decisions_LastationPlus, "CIVILIZATION_VV_LASTATION")
	Decisions_LastationPlus.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_VV_LASTATION) and (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_VV_LASTATION_BH)
		and (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_VV_LASTATION_ULTRA) and (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_VV_LASTATION_BH_ULTRA) then
			return false, false
		end

		if load(pPlayer, "Decisions_LastationPlus") == true then
			Decisions_LastationPlus.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_VV_LASTATION_PLUS_ENACTED_DESC")
			return false, false, true
		end

		local iCost = math.ceil(500 * iMod)
		Decisions_LastationPlus.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_VV_LASTATION_PLUS_DESC", iCost)
		
		if pPlayer:GetJONSCulture() < iCost then return true, false end
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end
		
		local pCapital = pPlayer:GetCapitalCity()
		if pCapital and pCapital:GetPopulation() >= 20 then
			return true, true
		end
		return true, false
	end
	)

	Decisions_LastationPlus.DoFunc = (
	function(pPlayer)
		local iCost = math.ceil(500 * iMod)
		pPlayer:ChangeJONSCulture(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)

		pPlayer:SetNumFreePolicies(1)
		pPlayer:SetNumFreePolicies(0)
		pPlayer:SetHasPolicy(PLUS_POLICY, true)
		save(pPlayer, "Decisions_LastationPlus", true)
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_VV_LASTATION, "Decisions_LastationPlus", Decisions_LastationPlus)
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_VV_LASTATION_BH, "Decisions_LastationPlus", Decisions_LastationPlus)
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_VV_LASTATION_ULTRA, "Decisions_LastationPlus", Decisions_LastationPlus)
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_VV_LASTATION_BH_ULTRA, "Decisions_LastationPlus", Decisions_LastationPlus)