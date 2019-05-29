-- NanohaDecisions
-- Author: Vicevirtuoso
-- DateCreated: 8/25/2014 2:01:53 PM
--------------------------------------------------------------

local iSiegeType = GameInfoTypes.UNITCOMBAT_SIEGE
local iPromotion = GameInfoTypes.PROMOTION_CITY_SIEGE

local Decisions_ZenryokuZenkai = {}
	Decisions_ZenryokuZenkai.Name = "TXT_KEY_DECISIONS_NANOHA_ZENRYOKU_ZENKAI"
	Decisions_ZenryokuZenkai.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_NANOHA_ZENRYOKU_ZENKAI_DESC")
	HookDecisionCivilizationIcon(Decisions_ZenryokuZenkai, "CIVILIZATION_TSAB")
	Decisions_ZenryokuZenkai.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_TSAB) then
			return false, false
		end

		if load(pPlayer, "Decisions_ZenryokuZenkai") == true then
			Decisions_ZenryokuZenkai.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_NANOHA_ZENRYOKU_ZENKAI_ENACTED_DESC")
			return false, false, true
		end
		
		local iGoldCost = math.ceil(400 * iMod)
		local iCultureCost = math.ceil(400 * iMod)

		Decisions_ZenryokuZenkai.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_NANOHA_ZENRYOKU_ZENKAI_DESC", iGoldCost, iCultureCost)
		
		if pPlayer:GetGold() < iGoldCost then return true, false end
		if pPlayer:GetJONSCulture() < iCultureCost then return true, false end

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end

		local pTeam = Teams[pPlayer:GetTeam()]
		local pTeamTechs = pTeam:GetTeamTechs()
		
		if not pTeamTechs:HasTech(GameInfoTypes.TECH_MATHEMATICS) then return true, false end

		for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
			local pLoop = Players[i]
			if pLoop:IsAlive() then
				if Teams[pPlayer:GetTeam()]:IsAtWar(pLoop:GetTeam()) then
					return true, true
				end
			end
		end

		return true, false
	
	end
	)
	
	Decisions_ZenryokuZenkai.DoFunc = (
	function(pPlayer)
		local iGoldCost = math.ceil(400 * iMod)
		local iCultureCost = math.ceil(400 * iMod)
		pPlayer:ChangeGold(-iGoldCost)
		pPlayer:ChangeJONSCulture(-iCultureCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		for pUnit in pPlayer:Units() do
			if pUnit:GetUnitCombatType() == iSiegeType then
				pUnit:SetHasPromotion(iPromotion, true)
			end
		end
		save(pPlayer, "Decisions_ZenryokuZenkai", true)
	end
	)

	Decisions_ZenryokuZenkai.Monitors = {}
	Decisions_ZenryokuZenkai.Monitors[LuaEvents.DecisionsNanohaTest] =  (
	function(iPlayer, table)
		local pPlayer = Players[iPlayer]
		table[0] = load(pPlayer, "Decisions_ZenryokuZenkai")
		return load(pPlayer, "Decisions_ZenryokuZenkai")
	end)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_TSAB, "Decisions_ZenryokuZenkai", Decisions_ZenryokuZenkai)

local Decisions_SellTSABVessel = {}
	Decisions_SellTSABVessel.Name = "TXT_KEY_DECISIONS_NANOHA_SELL_WRECKAGE"
	Decisions_SellTSABVessel.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_NANOHA_SELL_WRECKAGE_DESC")
	HookDecisionCivilizationIcon(Decisions_SellTSABVessel, "CIVILIZATION_TSAB")
	Decisions_SellTSABVessel.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_TSAB) then
			return false, false
		end
		local tTable = {}
		tTable.Science = pPlayer:GetScience()
		tTable.Gold = tTable.Science * 4
		for iCityState, pCityState in pairs(Players) do
			if pCityState:IsEverAlive() and pCityState:IsMinorCiv() and pCityState:IsAlive() and (Teams[pPlayer:GetTeam()]:IsHasMet(pCityState:GetTeam())) then
			
				local sKey = "Decisions_SellTSABVessel" .. iCityState
				local sName = pCityState:GetName()
				
				tTempDecisions[sKey] = {}
				tTempDecisions[sKey].Name = Locale.ConvertTextKey("TXT_KEY_DECISIONS_NANOHA_SELL_WRECKAGE", sName)
				tTempDecisions[sKey].Desc = "TXT_KEY_DECISIONS_NANOHA_SELL_WRECKAGE_DESC"
				tTempDecisions[sKey].Data1 = pCityState
				tTempDecisions[sKey].Data2 = tTable
				tTempDecisions[sKey].Weight = 0
				tTempDecisions[sKey].Type = "Civilization"
				HookDecisionCivilizationIcon(tTempDecisions[sKey], "CIVILIZATION_TSAB")
				tTempDecisions[sKey].CanFunc = (
				function(pPlayer, pCityState, tTable)
					local sKey = "Decisions_SellTSABVessel" .. pCityState:GetID()
					local sName = pCityState:GetName()

					if load(pPlayer, sKey) == true then
						tTempDecisions[sKey].Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_NANOHA_SELL_WRECKAGE_ENACTED_DESC", tTable.Gold)
						return false, false, true
					end
	
					tTempDecisions[sKey].Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_NANOHA_SELL_WRECKAGE_DESC", tTable.Science, tTable.Gold)

					local pTeamTechs = Teams[pPlayer:GetTeam()]:GetTeamTechs()
					local iProgressThisTech = pTeamTechs:GetResearchProgress(pPlayer:GetCurrentResearch())

					if iProgressThisTech < tTable.Science then
						return true, false
					else
						return true, true
					end
				end
				)
				
				tTempDecisions[sKey].DoFunc = (
				function(pPlayer, pCityState, tTable)
					local sKey = "Decisions_SellTSABVessel" .. pCityState:GetID()

					local pTeamTechs = Teams[pPlayer:GetTeam()]:GetTeamTechs()
					pTeamTechs:ChangeResearchProgress(pPlayer:GetCurrentResearch(), -1 * tTable.Science, pPlayer:GetID())

					pPlayer:ChangeGold(tTable.Gold)
							
					save(pPlayer, sKey, true)
				end
				)
			end
		end
	end
	)
	
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_TSAB, "Decisions_SellTSABVessel", Decisions_SellTSABVessel)