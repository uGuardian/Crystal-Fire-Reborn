-- RiderDecisions
-- Author: Vicevirtuoso
-- DateCreated: 8/25/2014 2:01:53 PM
--------------------------------------------------------------

local iPromotion = GameInfoTypes.PROMOTION_SOMATOPHYLAX_BUFF
local iDummyPromotion = GameInfoTypes.PROMOTION_RIDER_DIADOCHI_DECISION
local iDummyBuilding = GameInfoTypes.BUILDING_DECISIONS_RIDER_DIADOCHI
local iCotton = GameInfoTypes.RESOURCE_COTTON
local iPlantation = GameInfoTypes.IMPROVEMENT_PLANTATION
local iTShirtPromotion = GameInfoTypes.PROMOTION_RIDER_TSHIRT_DECISION

local Decisions_RiderDiadochi = {}
	Decisions_RiderDiadochi.Name = "TXT_KEY_DECISIONS_RIDER_DIADOCHI"
	Decisions_RiderDiadochi.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_RIDER_DIADOCHI_DESC")
	HookDecisionCivilizationIcon(Decisions_RiderDiadochi, "CIVILIZATION_MACEDON_FSN")
	Decisions_RiderDiadochi.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_MACEDON_FSN) then
			return false, false
		end

		if load(pPlayer, "Decisions_RiderDiadochi") then
			Decisions_RiderDiadochi.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_RIDER_DIADOCHI_ENACTED_DESC")
			return false, false, true
		end
		
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end
		

		local iNumSomats = 0
		for pUnit in pPlayer:Units() do
			if pUnit:IsHasPromotion(iPromotion) then  --checks for promotion instead of UnitType for futureproofing compatibility with WFTW
				iNumSomats = iNumSomats + 1
				if iNumSomats >= 4 then break end
			end
		end

		if iNumSomats < 4 then return true, false end

		local iNumConqueredCities = 0
		for pCity in pPlayer:Cities() do
			if pCity:GetOriginalOwner() ~= pPlayer:GetID() then
				iNumConqueredCities = iNumConqueredCities + 1
				if iNumConqueredCities >= 4 then return true, true end
			end
		end
	
		return true, false

	end
	)
	
	Decisions_RiderDiadochi.DoFunc = (
	function(pPlayer)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)

		for pCity in pPlayer:Cities() do
			if pCity:GetOriginalOwner() ~= pPlayer:GetID() then
				for pUnit in pPlayer:Units() do
					if pUnit:IsHasPromotion(iPromotion) and not pUnit:IsHasPromotion(iDummyPromotion) then
						pUnit:SetHasPromotion(iDummyPromotion, true)
						local sCurName = Locale.ConvertTextKey(pUnit:GetNameNoDesc())
						if sCurName == "" then
							sCurName = Locale.ConvertTextKey("TXT_KEY_UNIT_SOMATOPHYLAX_FSN")
						end
						local sCityName = pCity:GetName()
						pUnit:SetName(Locale.ConvertTextKey("TXT_KEY_RIDER_DIADOCHI_RENAME", sCurName, sCityName))
						local cityID = CompileCityID(pCity)
						save(pUnit, "Decisions_RiderDiadochi", cityID)

						if pUnit:GetPlot() == pCity:Plot() then
							pCity:SetNumRealBuilding(iDummyBuilding, 1)
						else
							pCity:SetNumRealBuilding(iDummyBuilding, 0)
						end

						break
					end
				end
			end
		end

		pPlayer:SetNumFreePolicies(1)
		pPlayer:SetNumFreePolicies(0)
		pPlayer:SetHasPolicy(GameInfoTypes.POLICY_DECISIONS_RIDER_DIADOCHI, true)

		save(pPlayer, "Decisions_RiderDiadochi", true)
	end
	)

	Decisions_RiderDiadochi.Monitors = {}
	Decisions_RiderDiadochi.Monitors[GameEvents.UnitSetXY] = (
	function(iPlayer, iUnit, iX, iY)
		if iX > 0 and iY > 0 and iPlayer < GameDefines.MAX_MAJOR_CIVS then
			local pPlayer = Players[iPlayer]
			if load(pPlayer, "Decisions_RiderDiadochi") then
				local pUnit = pPlayer:GetUnitByID(iUnit)
				if load(pUnit, "Decisions_RiderDiadochi") then
					local pCity = Vice_DecompileCityID(load(pUnit, "Decisions_RiderDiadochi"))
					if pCity then
						if pCity:Plot() == pUnit:GetPlot() then
							pCity:SetNumRealBuilding(iDummyBuilding, 1)
						else
							pCity:SetNumRealBuilding(iDummyBuilding, 0)
						end
					end
				end
			end
		end
	end
	)

	Decisions_RiderDiadochi.Monitors[GameEvents.PlayerDoTurn] = (
	function(iPlayer)
		if iPlayer < GameDefines.MAX_MAJOR_CIVS then
			local pPlayer = Players[iPlayer]
			if load(pPlayer, "Decisions_RiderDiadochi") then
				for pUnit in pPlayer:Units() do
					if load(pUnit, "Decisions_RiderDiadochi") then
						local pCity = Vice_DecompileCityID(load(pUnit, "Decisions_RiderDiadochi"))
						if pCity then
							if pCity:Plot() == pUnit:GetPlot() then
								pCity:SetNumRealBuilding(iDummyBuilding, 1)
							else
								pCity:SetNumRealBuilding(iDummyBuilding, 0)
							end
						end
					end
				end
			end
		end
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_MACEDON_FSN, "Decisions_RiderDiadochi", Decisions_RiderDiadochi)

local Decisions_RiderTShirt = {}
	Decisions_RiderTShirt.Name = "TXT_KEY_DECISIONS_RIDER_TSHIRT"
	Decisions_RiderTShirt.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_RIDER_TSHIRT_DESC")
	HookDecisionCivilizationIcon(Decisions_RiderTShirt, "CIVILIZATION_MACEDON_FSN")
	Decisions_RiderTShirt.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_MACEDON_FSN) then
			return false, false
		end

		if load(pPlayer, "Decisions_RiderTShirt") then
			Decisions_RiderTShirt.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_RIDER_TSHIRT_ENACTED_DESC")
			return false, false, true
		end

		local iGoldCost = math.ceil(5 * iMod)

		local iTurns = pPlayer:GetGoldenAgeLength() * 2

		Decisions_RiderTShirt.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_RIDER_TSHIRT_DESC", iGoldCost, iTurns)
		
		if pPlayer:GetGold() < iGoldCost then return true, false end
		
		for pCity in pPlayer:Cities() do
			local iNumPlots = pCity:GetNumCityPlots();
			for iPlot = 0, iNumPlots - 1 do
				local pPlot = pCity:GetCityIndexPlot(iPlot)
				if pPlot and pPlot:GetResourceType() > -1 then
					if pPlot:GetResourceType() == iCotton and pPlot:GetImprovementType() == iPlantation then
						return true, true
					end
				end
			end
		end

		return true, false
	end
	)

	Decisions_RiderTShirt.DoFunc = (
	function(pPlayer)
		local iGoldCost = math.ceil(5 * iMod)
		local iTurns = pPlayer:GetGoldenAgeLength() * 2
		local iEndTurn = Game:GetGameTurn() + iTurns

		pPlayer:ChangeGold(-iGoldCost)

		for pUnit in pPlayer:Units() do
			if pUnit:IsCombatUnit() then
				pUnit:SetHasPromotion(iTShirtPromotion, true)
			end
		end

		pPlayer:SetNumFreePolicies(1)
		pPlayer:SetNumFreePolicies(0)
		pPlayer:SetHasPolicy(GameInfoTypes.POLICY_DECISIONS_RIDER_TSHIRT, true)

		save(pPlayer, "Decisions_RiderTShirt", iEndTurn)
	end
	)

	Decisions_RiderTShirt.Monitors = {}
	Decisions_RiderTShirt.Monitors[GameEvents.PlayerDoTurn] = (
	function(iPlayer)
		if iPlayer < GameDefines.MAX_MAJOR_CIVS then
			local pPlayer = Players[iPlayer]
			if load(pPlayer, "Decisions_RiderTShirt") and load(pPlayer, "Decisions_RiderTShirt") ~= true then
				local bBool;
				if Game:GetGameTurn() == load(pPlayer, "Decisions_RiderTShirt") then
					bBool = false
					save(pPlayer, "Decisions_RiderTShirt", true)
				else
					bBool = true
				end
				for pUnit in pPlayer:Units() do
					if pUnit:IsCombatUnit() then
						pUnit:SetHasPromotion(iTShirtPromotion, bBool)
					end
				end
			end
		end
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_MACEDON_FSN, "Decisions_RiderTShirt", Decisions_RiderTShirt)




function Vice_DecompileCityID(sKey)
    local iBreak = string.find(sKey, "Y")
	local iBreak2 = string.find(sKey, "P")
    iX = tonumber(string.sub(sKey, 2, iBreak - 1))
    iY = tonumber(string.sub(sKey, iBreak + 1, iBreak2 - 1))
    local pPlot = Map.GetPlot(iX, iY)
	local pCity = pPlot:GetPlotCity()
    return pCity
end