-- Valentine Decisions
-- Author: Vice
-- DateCreated: 2/13/2015 12:24:03 PM
--------------------------------------------------------------

local iTurns = math.ceil(5 * iMod)

--------------------------------------------------------------------------------------------------------------------------------------------
--Decision 1: Popularize the "Dojyan"
--------------------------------------------------------------------------------------------------------------------------------------------

local Decisions_Dojyan = {}
	Decisions_Dojyan.Name = "TXT_KEY_DECISIONS_FUNNY_VALENTINE_DOJYAN"
	Decisions_Dojyan.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_FUNNY_VALENTINE_DOJYAN_DESC")
	HookDecisionCivilizationIcon(Decisions_Dojyan, "CIVILIZATION_JJBA_AMERICA")
	Decisions_Dojyan.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_JJBA_AMERICA) then
			return false, false
		end
		if load(pPlayer, "Decisions_Dojyan") then
			Decisions_Dojyan.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_FUNNY_VALENTINE_DOJYAN_ENACTED_DESC")
			return false, false, true
		end
		
		local iCost = math.ceil(650 * iMod)
		Decisions_Dojyan.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_FUNNY_VALENTINE_DOJYAN_DESC", iCost, iTurns)
		
		if pPlayer:GetJONSCulture() < iCost then return true, false end
		
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end

		for row in GameInfo.Policies() do
			if string.find(row.Type, "_FINISHER") then
				if pPlayer:HasPolicy(row.ID) then
					return true, true
				end
			end
		end

		return true, false
	end
	)
	
	Decisions_Dojyan.DoFunc = (
	function(pPlayer)
		local iCost = math.ceil(650 * iMod)
		pPlayer:ChangeJONSCulture(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)

		save(pPlayer, "Decisions_Dojyan", true)
	end
	)

	Decisions_Dojyan.Monitors = {}
	Decisions_Dojyan.Monitors[GameEvents.PlayerAdoptPolicy] =  (
	function(iPlayer, iPolicyID)
		if iPlayer < GameDefines.MAX_MAJOR_CIVS then
			local pPlayer = Players[iPlayer]
			if load(pPlayer, "Decisions_Dojyan") == true then
				for pCity in pPlayer:Cities() do
					pCity:ChangeWeLoveTheKingDayCounter(5)
				end
			end
		end
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_JJBA_AMERICA, "Decisions_Dojyan", Decisions_Dojyan)



--------------------------------------------------------------------------------------------------------------------------------------------
--Decision 2: Declare Winter Catfish Etouffee as the National Dish
--------------------------------------------------------------------------------------------------------------------------------------------
local Decisions_WinterCatfish = {}
	Decisions_WinterCatfish.Name = "TXT_KEY_DECISIONS_FUNNY_VALENTINE_WINTER_CATFISH"
	Decisions_WinterCatfish.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_FUNNY_VALENTINE_WINTER_CATFISH_DESC")
	HookDecisionCivilizationIcon(Decisions_WinterCatfish, "CIVILIZATION_JJBA_AMERICA")
	Decisions_WinterCatfish.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_JJBA_AMERICA) then
			return false, false
		end
		if load(pPlayer, "Decisions_WinterCatfish") == true then
			Decisions_WinterCatfish.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_FUNNY_VALENTINE_WINTER_CATFISH_ENACTED_DESC")
			return false, false, true
		end

		local iGoldCost = math.ceil(300 * iMod)
		local iCultureCost = math.ceil(100 * iMod)
		Decisions_WinterCatfish.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_FUNNY_VALENTINE_WINTER_CATFISH_DESC", iGoldCost, iCultureCost)
		
		if pPlayer:GetGold() < iGoldCost then return true, false end
		if pPlayer:GetJONSCulture() < iCultureCost then return true, false end
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end

		local bHasTundraSnow = false
		local bHasImprovedFish = false

		for pCity in pPlayer:Cities() do
			local iNumPlots = pCity:GetNumCityPlots();
			for iPlot = 0, iNumPlots - 1 do
				local pPlot = pCity:GetCityIndexPlot(iPlot)
				if pPlot then
					if (pPlot:GetTerrainType() == GameInfoTypes.TERRAIN_TUNDRA or pPlot:GetTerrainType() == GameInfoTypes.TERRAIN_SNOW) and Map.PlotDistance(pPlot:GetX(), pPlot:GetY(), pCity:GetX(), pCity:GetY()) <= 1  then
						bHasTundraSnow = true
					end
					if pPlot:GetResourceType() == GameInfoTypes.RESOURCE_FISH and pPlot:GetImprovementType() > -1 then
						bHasImprovedFish = true
					end
					if bHasTundraSnow and bHasImprovedFish then
						return true, true
					end
				end
			end
		end

		return true, false
	end
	)
	
	Decisions_WinterCatfish.DoFunc = (
	function(pPlayer)
		local iGoldCost = math.ceil(300 * iMod)
		local iCultureCost = math.ceil(100 * iMod)
		pPlayer:ChangeGold(-iGoldCost)
		pPlayer:ChangeJONSCulture(-iCultureCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
		for pCity in pPlayer:Cities() do
			local iNumPlots = pCity:GetNumCityPlots();
			local iSet = 0
			for iPlot = 0, iNumPlots - 1 do
				local pPlot = pCity:GetCityIndexPlot(iPlot)
				if pPlot then
					if (pPlot:GetTerrainType() == GameInfoTypes.TERRAIN_TUNDRA or pPlot:GetTerrainType() == GameInfoTypes.TERRAIN_SNOW) and Map.PlotDistance(pPlot:GetX(), pPlot:GetY(), pCity:GetX(), pCity:GetY()) <= 1  then
						iSet = 1
						break
					end
				end
			end
			pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_FUNNY_VALENTINE_WINTER_CATFISH, iSet)
		end
		save(pPlayer, "Decisions_WinterCatfish", true)
	end
	)

	Decisions_WinterCatfish.Monitors = {}
	Decisions_WinterCatfish.Monitors[GameEvents.PlayerCityFounded] =  (
	function(iPlayer, iX, iY)
		if iPlayer < GameDefines.MAX_MAJOR_CIVS then
			local pPlayer = Players[iPlayer]
			if load(pPlayer, "Decisions_WinterCatfish") == true then
				local pCity = Map.GetPlot(iX, iY):GetPlotCity()
				if pCity then
					local iNumPlots = pCity:GetNumCityPlots();
					local iSet = 0
					for iPlot = 0, iNumPlots - 1 do
						local pPlot = pCity:GetCityIndexPlot(iPlot)
						if pPlot then
							if (pPlot:GetTerrainType() == GameInfoTypes.TERRAIN_TUNDRA or pPlot:GetTerrainType() == GameInfoTypes.TERRAIN_SNOW) and Map.PlotDistance(pPlot:GetX(), pPlot:GetY(), pCity:GetX(), pCity:GetY()) <= 1  then
								iSet = 1
								break
							end
						end
					end
					pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_FUNNY_VALENTINE_WINTER_CATFISH, iSet)
				end
			end
		end
	end
	)

	Decisions_WinterCatfish.Monitors[GameEvents.CityCaptureComplete] =  (
	function(iPlayer, bCapital, iX, iY, iCapturingPlayer, iPopulation, bConquest)
		if iCapturingPlayer < GameDefines.MAX_MAJOR_CIVS then
			local pPlayer = Players[iCapturingPlayer]
			if load(pPlayer, "Decisions_WinterCatfish") == true then
				local pCity = Map.GetPlot(iX, iY):GetPlotCity()
				if pCity then
					local iNumPlots = pCity:GetNumCityPlots();
					local iSet = 0
					for iPlot = 0, iNumPlots - 1 do
						local pPlot = pCity:GetCityIndexPlot(iPlot)
						if pPlot then
							if (pPlot:GetTerrainType() == GameInfoTypes.TERRAIN_TUNDRA or pPlot:GetTerrainType() == GameInfoTypes.TERRAIN_SNOW) and Map.PlotDistance(pPlot:GetX(), pPlot:GetY(), pCity:GetX(), pCity:GetY()) <= 1  then
								iSet = 1
								break
							end
						end
					end
					pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_FUNNY_VALENTINE_WINTER_CATFISH, iSet)
				end
			end
		end
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_JJBA_AMERICA, "Decisions_WinterCatfish", Decisions_WinterCatfish)

