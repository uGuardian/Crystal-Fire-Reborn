-- HrodtohzDecisions
-- Author: Vicevirtuoso
-- DateCreated: 8/25/2014 2:01:14 PM
--------------------------------------------------------------

local tPartyPolicies = {
	["POLICY_DECISIONS_HRODTOHZ_TRADITIONALISTS_1"] = GameInfoTypes.POLICY_DECISIONS_HRODTOHZ_TRADITIONALISTS_1,
	["POLICY_DECISIONS_HRODTOHZ_TRADITIONALISTS_2"] = GameInfoTypes.POLICY_DECISIONS_HRODTOHZ_TRADITIONALISTS_2,
	["POLICY_DECISIONS_HRODTOHZ_TRADITIONALISTS_3"] = GameInfoTypes.POLICY_DECISIONS_HRODTOHZ_TRADITIONALISTS_3,
	["POLICY_DECISIONS_HRODTOHZ_TRADITIONALISTS_4"] = GameInfoTypes.POLICY_DECISIONS_HRODTOHZ_TRADITIONALISTS_4,
	["POLICY_DECISIONS_HRODTOHZ_TRADITIONALISTS_5"] = GameInfoTypes.POLICY_DECISIONS_HRODTOHZ_TRADITIONALISTS_5,

	["POLICY_DECISIONS_HRODTOHZ_RESTRUCTURISTS_1"] = GameInfoTypes.POLICY_DECISIONS_HRODTOHZ_RESTRUCTURISTS_1,
	["POLICY_DECISIONS_HRODTOHZ_RESTRUCTURISTS_2"] = GameInfoTypes.POLICY_DECISIONS_HRODTOHZ_RESTRUCTURISTS_2,
	["POLICY_DECISIONS_HRODTOHZ_RESTRUCTURISTS_3"] = GameInfoTypes.POLICY_DECISIONS_HRODTOHZ_RESTRUCTURISTS_3,
	["POLICY_DECISIONS_HRODTOHZ_RESTRUCTURISTS_4"] = GameInfoTypes.POLICY_DECISIONS_HRODTOHZ_RESTRUCTURISTS_4,
	["POLICY_DECISIONS_HRODTOHZ_RESTRUCTURISTS_5"] = GameInfoTypes.POLICY_DECISIONS_HRODTOHZ_RESTRUCTURISTS_5,
}


local tUnitTypes = {
	[GameInfoTypes.ERA_ANCIENT] = GameInfoTypes.UNIT_WARRIOR,
	[GameInfoTypes.ERA_CLASSICAL] = GameInfoTypes.UNIT_SPEARMAN,
	[GameInfoTypes.ERA_MEDIEVAL] = GameInfoTypes.UNIT_PIKEMAN,
	[GameInfoTypes.ERA_RENAISSANCE] = GameInfoTypes.UNIT_MUSKETMAN,
	[GameInfoTypes.ERA_INDUSTRIAL] = GameInfoTypes.UNIT_RIFLEMAN,
	[GameInfoTypes.ERA_MODERN] = GameInfoTypes.UNIT_GREAT_WAR_INFANTRY,
	[GameInfoTypes.ERA_POSTMODERN] = GameInfoTypes.UNIT_INFANTRY,
	[GameInfoTypes.ERA_FUTURE] = GameInfoTypes.UNIT_MARINE
}


--Run this even before the decisions are made
function OnHrodtohzEveryTurn(iPlayer)
	if iPlayer < GameDefines.MAX_MAJOR_CIVS then
		local pPlayer = Players[iPlayer]
		if pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_RIKTI then
			for pCity in pPlayer:Cities() do
				pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_HRODTOHZ_DUMMY, 1)
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(OnHrodtohzEveryTurn)

local Decisions_HrodtohzTraditionalists = {}
	Decisions_HrodtohzTraditionalists.Name = "TXT_KEY_DECISIONS_HRODTOHZ_TRADITIONALISTS"
	Decisions_HrodtohzTraditionalists.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_HRODTOHZ_TRADITIONALISTS_DESC")
	HookDecisionCivilizationIcon(Decisions_HrodtohzTraditionalists, "CIVILIZATION_RIKTI")
	Decisions_HrodtohzTraditionalists.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_RIKTI) then
			return false, false
		end

		local iBalance = load(pPlayer, "Decisions_HrodtohzParty") or 0

		local sParty;

		if iBalance == 0 then
			sParty = Locale.ConvertTextKey("TXT_KEY_DECISIONS_HRODTOHZ_NOPARTY")
		elseif iBalance > 0 then
			sParty = Locale.ConvertTextKey("TXT_KEY_DECISIONS_HRODTOHZ_TRADITIONALISTS_NAME")
		else
			sParty = Locale.ConvertTextKey("TXT_KEY_DECISIONS_HRODTOHZ_RESTRUCTURISTS_NAME")
		end

		if iBalance >= 5 then
			Decisions_HrodtohzTraditionalists.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_HRODTOHZ_TRADITIONALISTS_ENACTED_DESC", iBalance, sParty)
			return false, false, true
		end

		local iTurns = math.ceil(30 * iMod)
		
		local iCost = 1

		if iBalance >= 3 then
			iCost = 2
		elseif iBalance <= -3 then
			iCost = 0
		end
		
		Decisions_HrodtohzTraditionalists.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_HRODTOHZ_TRADITIONALISTS_DESC", iBalance, sParty, iTurns, iCost)
		
		if load(pPlayer, "Decisions_HrodtohzParty_Turn") and load(pPlayer, "Decisions_HrodtohzParty_Turn") > Game:GetGameTurn() then return true, false end
	
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < iCost) then return true, false end

		return true, true
	
	end
	)
	
	Decisions_HrodtohzTraditionalists.DoFunc = (
	function(pPlayer)
		local iBalance = load(pPlayer, "Decisions_HrodtohzParty") or 0
		local iCost = 1
		if iBalance >= 3 then
			iCost = 2
		elseif iBalance <= -3 then
			iCost = 0
		end
		pPlayer:ChangeNumResourceTotal(iMagistrate, -iCost)

		iBalance = iBalance + 1

		local sKey;
		if iBalance > 0 then
			sKey = "POLICY_DECISIONS_HRODTOHZ_TRADITIONALISTS_" ..tostring(iBalance)
		elseif iBalance < 0 then
			sKey = "POLICY_DECISIONS_HRODTOHZ_RESTRUCTURISTS_" ..tostring(-iBalance)
		end

		for key, ID in pairs(tPartyPolicies) do
			if sKey == key and not pPlayer:HasPolicy(ID) then
				pPlayer:SetNumFreePolicies(1)
				pPlayer:SetHasPolicy(ID, true)
				pPlayer:SetNumFreePolicies(0)
			elseif pPlayer:HasPolicy(ID) then
				pPlayer:SetNumFreePolicies(1)
				pPlayer:SetHasPolicy(ID, false)
				pPlayer:SetNumFreePolicies(0)
			end
		end

		local iTurns = math.ceil(30 * iMod)
		local iEndTurn = Game:GetGameTurn() + iTurns

		save(pPlayer, "Decisions_HrodtohzParty", iBalance)
		save(pPlayer, "Decisions_HrodtohzParty_Turn", iEndTurn)
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_RIKTI, "Decisions_HrodtohzTraditionalists", Decisions_HrodtohzTraditionalists)


local Decisions_HrodtohzRestructurists = {}
	Decisions_HrodtohzRestructurists.Name = "TXT_KEY_DECISIONS_HRODTOHZ_RESTRUCTURISTS"
	Decisions_HrodtohzRestructurists.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_HRODTOHZ_RESTRUCTURISTS_DESC")
	HookDecisionCivilizationIcon(Decisions_HrodtohzRestructurists, "CIVILIZATION_RIKTI")
	Decisions_HrodtohzRestructurists.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_RIKTI) then
			return false, false
		end

		local iBalance = load(pPlayer, "Decisions_HrodtohzParty") or 0

		local sParty;

		if iBalance == 0 then
			sParty = Locale.ConvertTextKey("TXT_KEY_DECISIONS_HRODTOHZ_NOPARTY")
		elseif iBalance > 0 then
			sParty = Locale.ConvertTextKey("TXT_KEY_DECISIONS_HRODTOHZ_TRADITIONALISTS_NAME")
		else
			sParty = Locale.ConvertTextKey("TXT_KEY_DECISIONS_HRODTOHZ_RESTRUCTURISTS_NAME")
		end

		if iBalance <= -5 then
			Decisions_HrodtohzRestructurists.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_HRODTOHZ_RESTRUCTURISTS_ENACTED_DESC", iBalance, sParty)
			return false, false, true
		end

		local iTurns = math.ceil(30 * iMod)
		
		local iCost = 1

		if iBalance >= 3 then
			iCost = 0
		elseif iBalance <= -3 then
			iCost = 2
		end
		
		Decisions_HrodtohzRestructurists.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_HRODTOHZ_RESTRUCTURISTS_DESC", iBalance, sParty, iTurns, iCost)
		
		if load(pPlayer, "Decisions_HrodtohzParty_Turn") and load(pPlayer, "Decisions_HrodtohzParty_Turn") > Game:GetGameTurn() then return true, false end
	
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < iCost) then return true, false end

		return true, true
	end
	)
	
	Decisions_HrodtohzRestructurists.DoFunc = (
	function(pPlayer)
		local iBalance = load(pPlayer, "Decisions_HrodtohzParty") or 0
		local iCost = 1
		if iBalance >= 3 then
			iCost = 0
		elseif iBalance <= -3 then
			iCost = 2
		end
		pPlayer:ChangeNumResourceTotal(iMagistrate, -iCost)

		iBalance = iBalance - 1

		local sKey;
		if iBalance > 0 then
			sKey = "POLICY_DECISIONS_HRODTOHZ_TRADITIONALISTS_" ..tostring(iBalance)
		elseif iBalance < 0 then
			sKey = "POLICY_DECISIONS_HRODTOHZ_RESTRUCTURISTS_" ..tostring(-iBalance)
		end

		for key, ID in pairs(tPartyPolicies) do
			if sKey == key and not pPlayer:HasPolicy(ID) then
				pPlayer:SetNumFreePolicies(1)
				pPlayer:SetHasPolicy(ID, true)
				pPlayer:SetNumFreePolicies(0)
			elseif pPlayer:HasPolicy(ID) then
				pPlayer:SetNumFreePolicies(1)
				pPlayer:SetHasPolicy(ID, false)
				pPlayer:SetNumFreePolicies(0)
			end
		end

		local iTurns = math.ceil(30 * iMod)
		local iEndTurn = Game:GetGameTurn() + iTurns

		save(pPlayer, "Decisions_HrodtohzParty", iBalance)
		save(pPlayer, "Decisions_HrodtohzParty_Turn", iEndTurn)
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_RIKTI, "Decisions_HrodtohzRestructurists", Decisions_HrodtohzRestructurists)


local Decisions_RiktiLost = {}
	Decisions_RiktiLost.Name = "TXT_KEY_DECISIONS_HRODTOHZ_LOST"
	Decisions_RiktiLost.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_HRODTOHZ_LOST_DESC")
	HookDecisionCivilizationIcon(Decisions_RiktiLost, "CIVILIZATION_RIKTI")
	Decisions_RiktiLost.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_RIKTI) then
			return false, false
		end

		local tTable = {}
		tTable.GoldCost = math.ceil((300 + (150 * pPlayer:GetCurrentEra())) * iMod)
		tTable.ScienceCost = math.ceil((100 + (50 * pPlayer:GetCurrentEra())) * iMod)


		for pCity in pPlayer:Cities() do

			if pCity:IsRazing() then
				local sKey = "Decisions_RiktiLost" .. CompileCityID(pCity)
				local sName = pCity:GetName()
			
				tTempDecisions[sKey] = {}
				tTempDecisions[sKey].Name = Locale.ConvertTextKey("TXT_KEY_DECISIONS_HRODTOHZ_LOST", sName)
				tTempDecisions[sKey].Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_HRODTOHZ_LOST_DESC")
				tTempDecisions[sKey].Data1 = pCity
				tTempDecisions[sKey].Data2 = tTable
				tTempDecisions[sKey].Weight = 0
				tTempDecisions[sKey].Type = "Civilization"
				HookDecisionCivilizationIcon(tTempDecisions[sKey], "CIVILIZATION_RIKTI")
				tTempDecisions[sKey].CanFunc = (
				function(pPlayer, pCity, tTable)
					local sKey = "Decisions_RiktiLost" .. CompileCityID(pCity)
					local sName = pCity:GetName()

					if load(pPlayer, sKey) == true then
						tTempDecisions[sKey].Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_HRODTOHZ_LOST_ENACTED_DESC", sName)
						return false, false, true
					end
				
					tTempDecisions[sKey].Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_HRODTOHZ_LOST_DESC", sName, tTable.GoldCost, tTable.ScienceCost)

					if pPlayer:GetGold() < tTable.GoldCost then return true, false end

					local pTeamTechs = Teams[pPlayer:GetTeam()]:GetTeamTechs()
					local iProgressThisTech = pTeamTechs:GetResearchProgress(pPlayer:GetCurrentResearch())
					if iProgressThisTech < tTable.ScienceCost then return true, false end
			
					return true, true
				end
				)
			
				tTempDecisions[sKey].DoFunc = (
				function(pPlayer, pCity, tTable)
					local sKey = "Decisions_RiktiLost" .. CompileCityID(pCity)
					pPlayer:ChangeGold(-tTable.GoldCost)
					LuaEvents.Sukritact_ChangeResearchProgress(pPlayer:GetID(), -tTable.ScienceCost)
					local iPopMinusOne = pCity:GetPopulation() - 1
					local iNumUnits = math.floor(iPopMinusOne / 2)
					local tTable = InitUnitFromCity(pPlayer:GetCapitalCity(), tUnitTypes[pPlayer:GetCurrentEra()], iNumUnits)
					for k, v in pairs(tTable) do
						v:SetMoves(0)
					end
					pCity:SetPopulation(1, true)
					save(pPlayer, sKey, true)
				end
				)
			end
		end
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_RIKTI, "Decisions_RiktiLost", Decisions_RiktiLost)