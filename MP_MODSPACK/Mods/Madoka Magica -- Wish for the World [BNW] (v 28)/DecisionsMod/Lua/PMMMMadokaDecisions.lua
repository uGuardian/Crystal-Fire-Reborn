-- PMMMMadokaDecisions
-- Author: Vicevirtuoso
-- DateCreated: 8/24/2014 6:37:08 PM
--------------------------------------------------------------

local iDummy = GameInfoTypes.BUILDING_DECISION_ORIGINAL_MADOKA_DUMMY

--------------------------------------------------------------------------------------------------------------------------------------------
--Decision 1: Establish Mitakiharafest
--Get 3 turns of Golden Age + WLKTD. This repeats every 25 turns.
--Requires 3 improved Wheats (i.e. brewing witbier) and 1 improved Wine
--------------------------------------------------------------------------------------------------------------------------------------------

local Decisions_Mitakiharafest = {}
	Decisions_Mitakiharafest.Name = "TXT_KEY_DECISIONS_ORIGINAL_MADOKA_MITAKIHARAFEST"
	Decisions_Mitakiharafest.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_ORIGINAL_MADOKA_MITAKIHARAFEST_DESC")
	HookDecisionCivilizationIcon(Decisions_Mitakiharafest, "CIVILIZATION_ORIGINAL_MADOKA")
	Decisions_Mitakiharafest.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_ORIGINAL_MADOKA) then
			return false, false
		end
		if load(pPlayer, "Decisions_Mitakiharafest") then
			Decisions_Mitakiharafest.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_ORIGINAL_MADOKA_MITAKIHARAFEST_ENACTED_DESC")
			return false, false, true
		end
		
		local iCost = math.ceil(500 * iMod)
		Decisions_Mitakiharafest.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_ORIGINAL_MADOKA_MITAKIHARAFEST_DESC", iCost)
		
		if pPlayer:GetGold() < iCost then return true, false end
		
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end

		local iWheats = 0;
		local iWines = 0;
		local iWheat = GameInfoTypes.RESOURCE_WHEAT
		local iWine = GameInfoTypes.RESOURCE_WINE
		local iFarm = GameInfoTypes.IMPROVEMENT_FARM
		local iPlantation = GameInfoTypes.IMPROVEMENT_PLANTATION

		for pCity in pPlayer:Cities() do
			local iNumPlots = pCity:GetNumCityPlots();
			for iPlot = 0, iNumPlots - 1 do
				local pPlot = pCity:GetCityIndexPlot(iPlot)
				if pPlot and pPlot:GetResourceType() > -1 then
					if pPlot:GetResourceType() == iWheat and pPlot:GetImprovementType() == iFarm then
						iWheats = iWheats + 1;
					elseif pPlot:GetResourceType() == iWine and pPlot:GetImprovementType() == iPlantation then
						iWines = iWines + 1;
					end
				end
			end
		end

		if iWheats >= 4 and iWines >= 2 then
			return true, true
		else
			return true, false
		end	
	end
	)
	
	Decisions_Mitakiharafest.DoFunc = (
	function(pPlayer)
		local iCost = math.ceil(500 * iMod)
		pPlayer:ChangeGold(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		pPlayer:ChangeGoldenAgeTurns(3)
		pPlayer:GetCapitalCity():ChangeWeLoveTheKingDayCounter(3)
		
		save(pPlayer, "Decisions_Mitakiharafest", Game:GetGameTurn())
	end
	)

	Decisions_Mitakiharafest.Monitors = {}
	Decisions_Mitakiharafest.Monitors[GameEvents.PlayerDoTurn] =  (
	function(iPlayer)
		if iPlayer < GameDefines.MAX_MAJOR_CIVS then
			local pPlayer = Players[iPlayer]
			if load(pPlayer, "Decisions_Mitakiharafest") then
				local iCurTurn = Game:GetGameTurn()
				local iTurnDifference = iCurTurn - load(pPlayer, "Decisions_Mitakiharafest")
				if iTurnDifference % 25 == 0 then
					pPlayer:ChangeGoldenAgeTurns(3)
					pPlayer:GetCapitalCity():ChangeWeLoveTheKingDayCounter(3)
					pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, Locale.ConvertTextKey("TXT_KEY_ALERT_DECISIONS_ORIGINAL_MADOKA_MITAKIHARAFEST_TEXT"), Locale.ConvertTextKey("TXT_KEY_ALERT_DECISIONS_ORIGINAL_MADOKA_MITAKIHARAFEST_TITLE"), pPlayer:GetCapitalCity():GetX(), pPlayer:GetCapitalCity():GetY())
				end
			end
			if load(pPlayer, "Decisions_Mitakun") == true then
				for pCity in pPlayer:Cities() do
					if pCity:IsCapital() or pPlayer:IsCapitalConnectedToCity(pCity) then
						pCity:SetNumRealBuilding(iDummy, 1)
					else
						pCity:SetNumRealBuilding(iDummy, 0)
					end
				end
			end
		end
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_ORIGINAL_MADOKA, "Decisions_Mitakiharafest", Decisions_Mitakiharafest)



--------------------------------------------------------------------------------------------------------------------------------------------
--Decision 2: Commission Mi-ta-kun
--Adds 1 Culture to tiles with roads or railroads at the time the decision is enacted.
--2 Tourism in the Capital and Cities with a Connection to the Capital
--Does NOT work on roads/RRs built afterwards!
--Requires Combustion and a Great Artist; the GA is consumed
--------------------------------------------------------------------------------------------------------------------------------------------
local Decisions_Mitakun = {}
	Decisions_Mitakun.Name = "TXT_KEY_DECISIONS_ORIGINAL_MADOKA_MITAKUN"
	Decisions_Mitakun.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_ORIGINAL_MADOKA_MITAKUN_DESC")
	HookDecisionCivilizationIcon(Decisions_Mitakun, "CIVILIZATION_ORIGINAL_MADOKA")
	Decisions_Mitakun.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_ORIGINAL_MADOKA) then
			return false, false
		end
		if load(pPlayer, "Decisions_Mitakun") == true then
			Decisions_Mitakun.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_ORIGINAL_MADOKA_MITAKUN_ENACTED_DESC")
			return false, false, true
		end

		local iCost = math.ceil(1000 * iMod)
		Decisions_Mitakun.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_ORIGINAL_MADOKA_MITAKUN_DESC", iCost)
		
		if pPlayer:GetGold() < iCost then return true, false end

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end


		local pTeam = Teams[pPlayer:GetTeam()]
		local pTeamTechs = pTeam:GetTeamTechs()
		
		if not pTeamTechs:HasTech(GameInfoTypes.TECH_COMBUSTION) then return true, false end
		
		for pUnit in pPlayer:Units() do
			if pUnit:GetUnitClassType() == GameInfoTypes.UNITCLASS_ARTIST then
				return true, true
			end
		end

		return true, false
	end
	)
	
	Decisions_Mitakun.DoFunc = (
	function(pPlayer)
		local iCost = math.ceil(1000 * iMod)
		pPlayer:ChangeGold(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
		for pUnit in pPlayer:Units() do
			if pUnit:GetUnitClassType() == GameInfoTypes.UNITCLASS_ARTIST then
				GameEvents.GreatPersonExpended.Call(pPlayer:GetID(), pUnit:GetID(), pUnit:GetUnitType(), pUnit:GetX(), pUnit:GetY())
				pUnit:Kill(true)
				break
			end
		end
		for pCity in pPlayer:Cities() do
			local iNumPlots = pCity:GetNumCityPlots();
			for iPlot = 0, iNumPlots - 1 do
				local pPlot = pCity:GetCityIndexPlot(iPlot)
				if pPlot then
					if pPlot:GetOwner() == pPlayer:GetID() then
						if pPlot:IsRoute() then
							Game.SetPlotExtraYield(pPlot:GetX(), pPlot:GetY(), YieldTypes.YIELD_CULTURE, 1)
						end
					end
				end
			end
			if pCity:IsCapital() or pPlayer:IsCapitalConnectedToCity(pCity) then
				pCity:SetNumRealBuilding(iDummy, 1)
			end
		end
		Events.SerialEventCityInfoDirty()
		save(pPlayer, "Decisions_Mitakun", true)
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_ORIGINAL_MADOKA, "Decisions_Mitakun", Decisions_Mitakun)

