-- PlaneptuneDecisions
-- Author: Vice
-- DateCreated: 3/23/2015 9:50:59 PM
--------------------------------------------------------------

local tEraBarbarians = {}
for era in GameInfo.Eras() do
	local iHighestStrength = 1
	local iHighestStrengthUnit;
	for unit in GameInfo.Units() do
		if unit.PrereqTech then
			if GameInfo.Technologies("Type ='" ..unit.PrereqTech.. "'")() and GameInfo.Technologies("Type ='" ..unit.PrereqTech.. "'")().Era then
				if GameInfo.Technologies("Type ='" ..unit.PrereqTech.. "'")().Era == era.Type then
					if unit.CombatClass == 'UNITCOMBAT_MELEE' or unit.CombatClass == 'UNITCOMBAT_GUN' then
						if unit.Combat > iHighestStrength then
							local bIsUnique;
							for uniqueunit in GameInfo.Civilization_UnitClassOverrides() do
								if uniqueunit.UnitType == unit.Type then
									bIsUnique = true
									break
								end
							end
							if not bIsUnique then
								iHighestStrength = unit.Combat
								iHighestStrengthUnit = unit.ID
							end
						end
					end
				end
			end
		end
	end
	tEraBarbarians[era.ID] = iHighestStrengthUnit or GameInfoTypes.UNIT_WARRIOR
end

local FARM = GameInfoTypes.IMPROVEMENT_FARM
function GetFarms(pPlayer, bPillaged, bWorking)
	local tFarmPlots = {}
	for pCity in pPlayer:Cities() do
		local iNumPlots = pCity:GetNumCityPlots();
		for iPlot = 0, iNumPlots - 1 do
			local pPlot = pCity:GetCityIndexPlot(iPlot)
			if pPlot then
				--Improvements
				local iImprovement = pPlot:GetImprovementType()
				if iImprovement == FARM and pPlot:GetOwner() == pPlayer:GetID() then
					if (not bPillaged) or (bPillaged and not pPlot:IsImprovementPillaged()) then
						if (not bWorking) or (bWorking and pCity:IsWorkingPlot(pPlot)) then
							tFarmPlots[#tFarmPlots + 1] = pPlot
						end
					end
				end
			end
		end
	end
	return tFarmPlots
end

function GetCityWorkedFarms(pPlayer, pCity)
	local iWorkedFarms = 0
	for pCity in pPlayer:Cities() do
		local iNumPlots = pCity:GetNumCityPlots();
		for iPlot = 0, iNumPlots - 1 do
			local pPlot = pCity:GetCityIndexPlot(iPlot)
			if pPlot then
				--Improvements
				local iImprovement = pPlot:GetImprovementType()
				if iImprovement == FARM and not pPlot:IsImprovementPillaged() and pCity:IsWorkingPlot(pPlot) then
					iWorkedFarms = iWorkedFarms + 1
				end
			end
		end
	end
	return iWorkedFarms
end

local EGGPLANT = GameInfoTypes.BUILDING_DECISION_PLANEPTUNE_EGGPLANT
local NEP_BULL_POLICY = GameInfoTypes.POLICY_DECISION_NEP_BULL
local NEP_BULL_BUILDING = GameInfoTypes.BUILDING_DECISION_PLANEPTUNE_NEP_BULL

--------------------------------------------------------------------------------------------------------------------------------------------
--Decision 1: Pass the Stop Eggplant Growing Act
--------------------------------------------------------------------------------------------------------------------------------------------
local Decisions_PlaneptuneEggplants = {}
	Decisions_PlaneptuneEggplants.Name = "TXT_KEY_DECISIONS_VV_PLANEPTUNE_BAN_EGGPLANTS"
	Decisions_PlaneptuneEggplants.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_VV_PLANEPTUNE_BAN_EGGPLANTS_DESC")
	HookDecisionCivilizationIcon(Decisions_PlaneptuneEggplants, "CIVILIZATION_VV_PLANEPTUNE")
	Decisions_PlaneptuneEggplants.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_VV_PLANEPTUNE) and (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_VV_PLANEPTUNE_PH) then
			return false, false
		end

		if load(pPlayer, "Decisions_PlaneptuneEggplants") then
			Decisions_PlaneptuneEggplants.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_VV_PLANEPTUNE_BAN_EGGPLANTS_ENACTED_DESC")
			return false, false, true
		end

		local iGoldPer = math.ceil(20 * iMod)
		local iCulturePer = math.ceil(10 * iMod)

		local tFarms = GetFarms(pPlayer, false, false)

		local iGoldTotal = iGoldPer * #tFarms
		local iCultureTotal = iCulturePer * #tFarms

		Decisions_PlaneptuneEggplants.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_VV_PLANEPTUNE_BAN_EGGPLANTS_DESC", iGoldTotal, iCultureTotal)

		if #tFarms < 5 then return true, false end
		if pPlayer:GetGold() < iGoldTotal then return true, false end
		if pPlayer:GetJONSCulture() < iCultureTotal then return true, false end
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end

		local pTeam = Teams[pPlayer:GetTeam()]
		if pTeam:IsHasTech(GameInfoTypes.TECH_CIVIL_SERVICE) then
			return true, true
		else
			return true, false
		end
	end
	)

	Decisions_PlaneptuneEggplants.DoFunc = (
	function(pPlayer)
		local pCapital = pPlayer:GetCapitalCity()
		if pCapital then
			local iGoldPer = math.ceil(20 * iMod)
			local iCulturePer = math.ceil(10 * iMod)
			local tFarms = GetFarms(pPlayer, false, false)
			local iGoldTotal = iGoldPer * #tFarms
			local iCultureTotal = iCulturePer * #tFarms
			pPlayer:ChangeGold(-iGoldTotal)
			pPlayer:ChangeGold(-iCultureTotal)
			pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
			local iEra = Game:GetCurrentEra()
			local iCount = 1
			for k, v in pairs(tFarms) do
				iCount = iCount - 1
				if iCount <= 0 then
					Players[63]:InitUnit(tEraBarbarians[iEra], v:GetX(), v:GetY(), UNITAI_ATTACK)
					iCount = 5
				end
			end

			for pCity in pPlayer:Cities() do
				local iWorkedFarms = GetCityWorkedFarms(pPlayer, pCity)
				pCity:SetNumRealBuilding(EGGPLANT, iWorkedFarms, true)
			end
			save(pPlayer, "Decisions_PlaneptuneEggplants", true)
		end
	end

	)
	Decisions_PlaneptuneEggplants.Monitors = {}
	Decisions_PlaneptuneEggplants.Monitors[GameEvents.PlayerDoTurn] =  (
	function(iPlayer)
		if iPlayer < GameDefines.MAX_MAJOR_CIVS then
			local pPlayer = Players[iPlayer]
			if load(pPlayer, "Decisions_PlaneptuneEggplants") == true then

				local iEra = Game:GetCurrentEra()
				local tFarms = GetFarms(pPlayer, false, false)
				for k, v in pairs(tFarms) do
					if Game.Rand(100, "Planeptune Decision Barbarian Roll") == 0 then
						Players[63]:InitUnit(tEraBarbarians[iEra], v:GetX(), v:GetY(), UNITAI_ATTACK)
					end
				end

				for pCity in pPlayer:Cities() do
					local iWorkedFarms = GetCityWorkedFarms(pPlayer, pCity)
					pCity:SetNumRealBuilding(EGGPLANT, iWorkedFarms, true)
				end
			end
		end
	end
	)
	

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_VV_PLANEPTUNE, "Decisions_PlaneptuneEggplants", Decisions_PlaneptuneEggplants)
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_VV_PLANEPTUNE_PH, "Decisions_PlaneptuneEggplants", Decisions_PlaneptuneEggplants)

--------------------------------------------------------------------------------------------------------------------------------------------
--Decision 2: Formulate Nep Bull
--------------------------------------------------------------------------------------------------------------------------------------------

local Decisions_PlaneptuneNepBull = {}
	Decisions_PlaneptuneNepBull.Name = "TXT_KEY_DECISIONS_VV_PLANEPTUNE_NEP_BULL"
	Decisions_PlaneptuneNepBull.Desc = "TXT_KEY_DECISIONS_VV_PLANEPTUNE_NEP_BULL_DESC"
	HookDecisionCivilizationIcon(Decisions_PlaneptuneNepBull, "CIVILIZATION_VV_PLANEPTUNE")
	Decisions_PlaneptuneNepBull.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_VV_PLANEPTUNE) and (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_VV_PLANEPTUNE_PH) then
			return false, false
		end

		if load(pPlayer, "Decisions_PlaneptuneNepBull") == true then
			Decisions_PlaneptuneNepBull.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_VV_PLANEPTUNE_NEP_BULL_ENACTED_DESC")
			return false, false, true
		end

		local iGoldCost = math.ceil(800  * iMod)
		local iMagistrateCost = 2

		Decisions_PlaneptuneNepBull.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_VV_PLANEPTUNE_NEP_BULL_DESC", iGoldCost)
		
		if pPlayer:GetGold() < iGoldCost then return true, false end
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < iMagistrateCost) then return true, false end

		local pTeam = Teams[pPlayer:GetTeam()]
		if not pTeam:IsHasTech(GameInfoTypes.TECH_INDUSTRIALISM) then
			return true, false
		end

		for pUnit in pPlayer:Units() do
			if pUnit:GetUnitClassType() == GameInfoTypes.UNITCLASS_SCIENTIST then
				return true, true
			end
		end

		return true, false
	end
	)

	Decisions_PlaneptuneNepBull.DoFunc = (
	function(pPlayer)
		local pCapital = pPlayer:GetCapitalCity()
		if pCapital then
			local iGoldCost = math.ceil(800  * iMod)
			local iMagistrateCost = 2
			pPlayer:ChangeGold(-iGoldCost)
			pPlayer:ChangeNumResourceTotal(iMagistrate, -iMagistrateCost)

			local iUnit;
			local iUnitType;
			local iX;
			local iY
			for pUnit in pPlayer:Units() do
				if pUnit:GetUnitClassType() == GameInfoTypes.UNITCLASS_SCIENTIST then
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

			local iNumBuildings = Game:GetNumCities()
			pCapital:SetNumRealBuilding(NEP_BULL_BUILDING, iNumBuildings, true)
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetNumFreePolicies(0)
			pPlayer:SetHasPolicy(NEP_BULL_POLICY, true)
			save(pPlayer, "Decisions_PlaneptuneNepBull", true)
		end
	end
	)
	
	Decisions_PlaneptuneNepBull.Monitors = {}
	Decisions_PlaneptuneNepBull.Monitors[GameEvents.PlayerDoTurn] =  (
	function(iPlayer)
		if iPlayer < GameDefines.MAX_MAJOR_CIVS then
			local pPlayer = Players[iPlayer]
			if load(pPlayer, "Decisions_PlaneptuneNepBull") == true then
				local pCapital = pPlayer:GetCapitalCity()
				if pCapital then
					local iNumBuildings = Game:GetNumCities()
					pCapital:SetNumRealBuilding(NEP_BULL_BUILDING, iNumBuildings, true)
				end
			end
		end
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_VV_PLANEPTUNE, "Decisions_PlaneptuneNepBull", Decisions_PlaneptuneNepBull)
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_VV_PLANEPTUNE_PH, "Decisions_PlaneptuneNepBull", Decisions_PlaneptuneNepBull)