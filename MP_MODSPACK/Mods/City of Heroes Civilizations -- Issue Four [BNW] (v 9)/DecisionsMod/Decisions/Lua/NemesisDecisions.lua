-- NemesisDecisions
-- Author: Vicevirtuoso
-- DateCreated: 8/24/2014 6:37:08 PM
--------------------------------------------------------------

local Decisions_NemesisWeather = {}
	Decisions_NemesisWeather.Name = "TXT_KEY_DECISIONS_NEMESIS_WEATHER_MACHINE"
	Decisions_NemesisWeather.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_NEMESIS_WEATHER_MACHINE_DESC")
	HookDecisionCivilizationIcon(Decisions_NemesisWeather, "CIVILIZATION_NEMESIS")
	Decisions_NemesisWeather.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_NEMESIS) then
			return false, false
		end

		local pTeam = Teams[pPlayer:GetTeam()]
		local pTeamTechs = pTeam:GetTeamTechs()
		
		if not pTeamTechs:HasTech(GameInfoTypes.TECH_STEAM_POWER) then return false, false end


		local tTable = {}
		tTable.GoldCost = math.ceil(1000 * iMod)
		tTable.ScienceCost = math.ceil(250 * iMod)

		for pCity in pPlayer:Cities() do

			if not pCity:IsPuppet() and not pCity:IsRazing() then
				local sKey = "Decisions_NemesisWeather" .. CompileCityID(pCity)
				local sName = pCity:GetName()
			
				tTempDecisions[sKey] = {}
				tTempDecisions[sKey].Name = Locale.ConvertTextKey("TXT_KEY_DECISIONS_NEMESIS_WEATHER_MACHINE", sName)
				tTempDecisions[sKey].Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_NEMESIS_WEATHER_MACHINE_DESC")
				tTempDecisions[sKey].Data1 = pCity
				tTempDecisions[sKey].Data2 = tTable
				tTempDecisions[sKey].Weight = 0
				tTempDecisions[sKey].Type = "Civilization"
				HookDecisionCivilizationIcon(tTempDecisions[sKey], "CIVILIZATION_NEMESIS")
				tTempDecisions[sKey].CanFunc = (
				function(pPlayer, pCity, tTable)
					local sKey = "Decisions_NemesisWeather" .. CompileCityID(pCity)
					local sName = pCity:GetName()

					if load(pPlayer, sKey) == true then
						tTempDecisions[sKey].Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_NEMESIS_WEATHER_MACHINE_ENACTED_DESC", sName)
						return false, false, true
					end
				
					tTempDecisions[sKey].Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_NEMESIS_WEATHER_MACHINE_DESC", sName, tTable.GoldCost, tTable.ScienceCost)

					if pPlayer:GetGold() < tTable.GoldCost then return true, false end

					local pTeamTechs = Teams[pPlayer:GetTeam()]:GetTeamTechs()
					local iProgressThisTech = pTeamTechs:GetResearchProgress(pPlayer:GetCurrentResearch())
					if iProgressThisTech < tTable.ScienceCost then return true, false end
			
					return true, true
				end
				)
			
				tTempDecisions[sKey].DoFunc = (
				function(pPlayer, pCity, tTable)
					local sKey = "Decisions_NemesisWeather" .. CompileCityID(pCity)
					pPlayer:ChangeGold(-tTable.GoldCost)
					LuaEvents.Sukritact_ChangeResearchProgress(pPlayer:GetID(), -tTable.ScienceCost)
					pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_NEMESIS_FREE_GARDEN, 1)
					pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_NEMESIS_FREE_WINDMILL, 1)
					save(pPlayer, sKey, true)
				end
				)
			end
		end
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_NEMESIS, "Decisions_NemesisWeather", Decisions_NemesisWeather)



local Decisions_NemesisAutomatons = {}
	Decisions_NemesisAutomatons.Name = "TXT_KEY_DECISIONS_NEMESIS_AUTOMATONS"
	Decisions_NemesisAutomatons.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_NEMESIS_AUTOMATONS_DESC")
	HookDecisionCivilizationIcon(Decisions_NemesisAutomatons, "CIVILIZATION_NEMESIS")
	Decisions_NemesisAutomatons.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_NEMESIS) then
			return false, false
		end
		if load(pPlayer, "Decisions_NemesisAutomatons") == true then
			Decisions_NemesisAutomatons.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_NEMESIS_AUTOMATONS_ENACTED_DESC")
			return false, false, true
		end

		local iCost = math.ceil(1000 * iMod)
		Decisions_NemesisAutomatons.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_NEMESIS_AUTOMATONS_DESC", iCost)
		
		if pPlayer:GetGold() < iCost then return true, false end

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end
		
		local pTeam = Teams[pPlayer:GetTeam()]
		local pTeamTechs = pTeam:GetTeamTechs()
		
		if not pTeamTechs:HasTech(GameInfoTypes.TECH_STEAM_POWER) then return true, false end

		return true, true
	end
	)
	
	Decisions_NemesisAutomatons.DoFunc = (
	function(pPlayer)
		local iCost = math.ceil(1000 * iMod)
		pPlayer:ChangeGold(-iCost)
		pPlayer:GetCapitalCity():SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_NEMESIS_FREE_SPY, 1)
		save(pPlayer, "Decisions_NemesisAutomatons", true)
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_NEMESIS, "Decisions_NemesisAutomatons", Decisions_NemesisAutomatons)

