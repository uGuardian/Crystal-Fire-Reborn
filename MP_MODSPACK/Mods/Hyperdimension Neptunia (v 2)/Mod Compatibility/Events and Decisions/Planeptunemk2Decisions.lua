-- Planeptunemk2Decisions
-- Author: Vice
-- DateCreated: 3/23/2015 9:50:59 PM
--------------------------------------------------------------


--Cache all policies in Exploration
local tPolicies = {}
local sPolicyBranch = "POLICY_BRANCH_EXPLORATION"
for policy in GameInfo.Policies() do
	if policy.PolicyBranchType == sPolicyBranch then
		tPolicies[policy.ID] = true
	end
end

--Compa and IF's strengths
local tCompaStrengths = {}
local tIFStrengths = {}

for era in GameInfo.Eras() do
	local iHighestStrength = 6
	for unit in GameInfo.Units() do
		if unit.PrereqTech and unit.PrereqTech ~= 'NONE' and unit.PrereqTech ~= 'NULL' then
			if GameInfo.Technologies("Type ='" ..unit.PrereqTech.. "'")() ~= 'NONE' and GameInfo.Technologies("Type ='" ..unit.PrereqTech.. "'")() ~= 'NULL' then --i don't know why 'NONE' is a valid PrereqTech, but it's there and causes problems
				if GameInfo.Technologies("Type ='" ..unit.PrereqTech.. "'")().Era then
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
								end
							end
						end
					end
				end
			end
		end
	end
	tCompaStrengths[era.ID] = math.floor(iHighestStrength * 0.75)
	tIFStrengths[era.ID] = math.floor(iHighestStrength * 0.9)
end

function VV_GetPercentOfMapExplored(iPlayer)
	local pPlayer = Players[iPlayer]
	local iDiscoveredPlots = 0
	local iTotalPlots = Map.GetNumPlots()
	local iTeam = pPlayer:GetTeam()
	for i = 0, iTotalPlots - 1, 1 do
		local pPlot = Map.GetPlotByIndex(i)
		if pPlot:IsRevealed(iTeam) then
			iDiscoveredPlots = iDiscoveredPlots + 1
		end
	end
	local iMultiplier = math.floor(iDiscoveredPlots / iTotalPlots * 10) -- 10% of the map needed for 1 point
	return iMultiplier
end

local iCompa = GameInfoTypes.UNIT_VV_DECISIONS_COMPA
local iIF = GameInfoTypes.UNIT_VV_DECISIONS_IF


--------------------------------------------------------------------------------------------------------------------------------------------
--Decision 1: Subsidize Public Healthcare (for Compa's sake)
--+1 Food/Science from Hospitals and gain Compa as a unit.
--------------------------------------------------------------------------------------------------------------------------------------------
local Decisions_Planeptunemk2Healthcare = {}
	Decisions_Planeptunemk2Healthcare.Name = "TXT_KEY_DECISIONS_VV_PLANEPTUNE_NG_SUBSIDIZE_HEALTHCARE"
	Decisions_Planeptunemk2Healthcare.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_VV_PLANEPTUNE_NG_SUBSIDIZE_HEALTHCARE_DESC")
	Decisions_Planeptunemk2Healthcare.Pedia = "TXT_KEY_UNIT_VV_DECISIONS_COMPA"
	HookDecisionCivilizationIcon(Decisions_Planeptunemk2Healthcare, "CIVILIZATION_VV_PLANEPTUNE_NG")
	Decisions_Planeptunemk2Healthcare.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_VV_PLANEPTUNE_NG) and (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_VV_PLANEPTUNE_PS) then
			return false, false
		end

		if load(pPlayer, "Decisions_Planeptunemk2Healthcare") then
			Decisions_Planeptunemk2Healthcare.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_VV_PLANEPTUNE_NG_SUBSIDIZE_HEALTHCARE_ENACTED_DESC")
			return false, false, true
		end

		local iGold = math.ceil(500 * iMod)

		Decisions_Planeptunemk2Healthcare.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_VV_PLANEPTUNE_NG_SUBSIDIZE_HEALTHCARE_DESC", iGold)

		if pPlayer:GetGold() < iGold then return true, false end
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end
		
		for pCity in pPlayer:Cities() do
			if not pCity:IsHasBuilding(GameInfoTypes.BUILDING_HOSPITAL) then
				return true, false
			elseif pCity:FoodDifference() < 10 then
				return true, false
			end
		end

		return true, true

	end
	)

	Decisions_Planeptunemk2Healthcare.DoFunc = (
	function(pPlayer)
		local pCapital = pPlayer:GetCapitalCity()
		if pCapital then
			local iCost = math.ceil(500 * iMod)
			pPlayer:ChangeGold(-iCost)
			pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
			pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_VV_PLANEPTUNE_NG_DUMMY_COMPA, 1, true)
			local tCompa = InitUnitFromCity(pCapital, iCompa, 1)
			tCompa[1]:SetName("TXT_KEY_UNIT_VV_DECISIONS_COMPA_NAME")
			tCompa[1]:JumpToNearestValidPlot()
			tCompa[1]:SetBaseCombatStrength(tCompaStrengths[pPlayer:GetCurrentEra()])
			save(pPlayer, "Decisions_Planeptunemk2Healthcare", true)
		end
	end
	)
	

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_VV_PLANEPTUNE_NG, "Decisions_Planeptunemk2Healthcare", Decisions_Planeptunemk2Healthcare)
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_VV_PLANEPTUNE_PS, "Decisions_Planeptunemk2Healthcare", Decisions_Planeptunemk2Healthcare)

--------------------------------------------------------------------------------------------------------------------------------------------
--Decision 2: Establish the Adventurer's Guild
--+1 to all Yields in the Palace for every 10% of the Map discovered, and gain IF as a unit.
--Costs are affected by how many Exploration tree policies you have. Without any, this is a rather expensive Decision to enact.
--------------------------------------------------------------------------------------------------------------------------------------------

local Decisions_Planeptunemk2Guild = {}
	Decisions_Planeptunemk2Guild.Name = "TXT_KEY_DECISIONS_VV_PLANEPTUNE_NG_ADVENTURERS_GUILD"
	Decisions_Planeptunemk2Guild.Desc = "TXT_KEY_DECISIONS_VV_PLANEPTUNE_NG_ADVENTURERS_GUILD_DESC"
	Decisions_Planeptunemk2Guild.Pedia = "TXT_KEY_UNIT_VV_DECISIONS_IF"
	HookDecisionCivilizationIcon(Decisions_Planeptunemk2Guild, "CIVILIZATION_VV_PLANEPTUNE_NG")
	Decisions_Planeptunemk2Guild.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_VV_PLANEPTUNE_NG) and (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_VV_PLANEPTUNE_PS) then
			return false, false
		end

		if load(pPlayer, "Decisions_Planeptunemk2Guild") == true then
			Decisions_Planeptunemk2Guild.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_VV_PLANEPTUNE_NG_ADVENTURERS_GUILD_ENACTED_DESC")
			return false, false, true
		end

		local iNumExploPolicies = 0
		if pPlayer:IsPolicyBranchUnlocked(GameInfoTypes.POLICY_BRANCH_EXPLORATION) then iNumExploPolicies = iNumExploPolicies + 1 end
		for k, v in pairs(tPolicies) do
			if pPlayer:HasPolicy(k) then
				iNumExploPolicies = iNumExploPolicies + 1
			end
		end
		local iExploModifier = 300 * iNumExploPolicies
		local iExploMagistrateModifier = math.floor(iNumExploPolicies / 2)

		local iGoldCost = math.ceil((2400 - iExploModifier)  * iMod)
		local iCultureCost = math.ceil((1800 - iExploModifier) * iMod)
		local iMagistrateCost = 3 - iExploMagistrateModifier

		Decisions_Planeptunemk2Guild.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_VV_PLANEPTUNE_NG_ADVENTURERS_GUILD_DESC", iGoldCost, iCultureCost, iMagistrateCost)
		
		if pPlayer:GetCurrentEra() < GameInfoTypes.ERA_RENAISSANCE then return true, false end
		if pPlayer:GetGold() < iGoldCost then return true, false end
		if pPlayer:GetJONSCulture() < iCultureCost then return true, false end
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < iMagistrateCost) then return true, false end

		return true, true
	end
	)

	Decisions_Planeptunemk2Guild.DoFunc = (
	function(pPlayer)
		local pCapital = pPlayer:GetCapitalCity()
		if pCapital then
			local iNumExploPolicies = 0
			if pPlayer:IsPolicyBranchUnlocked(GameInfoTypes.POLICY_BRANCH_EXPLORATION) then iNumExploPolicies = iNumExploPolicies + 1 end
			for k, v in pairs(tPolicies) do
				if pPlayer:HasPolicy(k) then
					iNumExploPolicies = iNumExploPolicies + 1
				end
			end
			local iExploModifier = 300 * iNumExploPolicies
			local iExploMagistrateModifier = math.floor(iNumExploPolicies / 2)
			local iGoldCost = math.ceil((2400 - iExploModifier)  * iMod)
			local iCultureCost = math.ceil((1800 - iExploModifier) * iMod)
			local iMagistrateCost = 3 - iExploMagistrateModifier

			pPlayer:ChangeGold(-iGoldCost)
			pPlayer:ChangeJONSCulture(-iCultureCost)
			pPlayer:ChangeNumResourceTotal(iMagistrate, -iMagistrateCost)

			local iNumBuildings = VV_GetPercentOfMapExplored(pPlayer:GetID())
			pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_VV_PLANEPTUNE_NG_DUMMY_IF, iNumBuildings, true)
			local tIF = InitUnitFromCity(pCapital, iIF, 1)
			tIF[1]:SetName("TXT_KEY_UNIT_VV_DECISIONS_IF_NAME")
			tIF[1]:JumpToNearestValidPlot()
			tIF[1]:SetBaseCombatStrength(tIFStrengths[pPlayer:GetCurrentEra()])
			save(pPlayer, "Decisions_Planeptunemk2Guild", true)
		end
	end
	)
	
	Decisions_Planeptunemk2Guild.Monitors = {}
	Decisions_Planeptunemk2Guild.Monitors[GameEvents.PlayerDoTurn] =  (
	function(iPlayer)
		if iPlayer < GameDefines.MAX_MAJOR_CIVS then
			local pPlayer = Players[iPlayer]
			if load(pPlayer, "Decisions_Planeptunemk2Guild") == true then
				local pCapital = pPlayer:GetCapitalCity()
				if pCapital then
					local iNumBuildings = VV_GetPercentOfMapExplored(iPlayer)
					pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_VV_PLANEPTUNE_NG_DUMMY_IF, iNumBuildings, true)
				end
			end
		end
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_VV_PLANEPTUNE_NG, "Decisions_Planeptunemk2Guild", Decisions_Planeptunemk2Guild)
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_VV_PLANEPTUNE_PS, "Decisions_Planeptunemk2Guild", Decisions_Planeptunemk2Guild)


function VV_Nepgear_Decisions_OnSetXY(iPlayer, iUnit, iX, iY)
	if iX > 0 and iY > 0 and iPlayer < GameDefines.MAX_MAJOR_CIVS then
		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iUnit)
		if pUnit:GetUnitType() == iCompa and (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_VV_PLANEPTUNE_NG and pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_VV_PLANEPTUNE_PS) then
			local pReplacement = pPlayer:InitUnit(GameInfoTypes.UNIT_GREAT_GENERAL, pUnit:GetX(), pUnit:GetY(), UNITAI_GREAT_GENERAL)
			pUnit:Kill(true)
		elseif pUnit:GetUnitType() == iIF then
			if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_VV_PLANEPTUNE_NG and pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_VV_PLANEPTUNE_PS) then
				local pReplacement = pPlayer:InitUnit(GameInfoTypes.UNIT_GREAT_GENERAL, pUnit:GetX(), pUnit:GetY(), UNITAI_GREAT_GENERAL)
				pUnit:Kill(true)
			else
				for i = 0, GameDefines.MAX_MAJOR_CIVS -1 , 1 do
					if i ~= iPlayer then
						local pLoop = Players[i]
						for pCity in pPlayer:Cities() do
							if Map.PlotDistance(pCity:GetX(), pCity:GetY(), pUnit:GetX(), pUnit:GetY()) <= 2 then
								pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_VV_IF_ESPIONAGE, 1, true)
							else
								pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_VV_IF_ESPIONAGE, 0)
							end
						end
					end
				end
			end
		end
	end
end


GameEvents.UnitSetXY.Add(VV_Nepgear_Decisions_OnSetXY)


function VV_Nepgear_Decisions_OnTeamSetEra(iTeam, iEra)
	for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
		local pPlayer = Players[i]
		if pPlayer:IsAlive() and pPlayer:GetTeam() == iTeam then
			for pUnit in pPlayer:Units() do
				if pUnit:GetUnitType() == iCompa then
					pUnit:SetBaseCombatStrength(tCompaStrengths[iEra])
				elseif pUnit:GetUnitType() == iIF then
					pUnit:SetBaseCombatStrength(tIFStrengths[iEra])
				end
			end
		end
	end
end

GameEvents.TeamSetEra.Add(VV_Nepgear_Decisions_OnTeamSetEra)