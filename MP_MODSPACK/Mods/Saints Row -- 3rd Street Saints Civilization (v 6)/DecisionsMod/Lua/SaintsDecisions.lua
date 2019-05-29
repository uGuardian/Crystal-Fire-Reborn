-- NanohaDecisions
-- Author: Vicevirtuoso
-- DateCreated: 8/25/2014 2:01:53 PM
--------------------------------------------------------------

local tResources = {
	[GameInfoTypes.RESOURCE_GOLD] = true,
	[GameInfoTypes.RESOURCE_SILVER] = true,
	[GameInfoTypes.RESOURCE_GEMS] = true,
	[GameInfoTypes.RESOURCE_COPPER] = true,
	[GameInfoTypes.RESOURCE_IVORY] = true,
	[GameInfoTypes.RESOURCE_PEARLS] = true
	}


--More Luxuries by Barathor support
if GameInfoTypes.RESOURCE_AMBER then
	tResources[GameInfoTypes.RESOURCE_AMBER] = true
end

if GameInfoTypes.RESOURCE_JADE then
	tResources[GameInfoTypes.RESOURCE_JADE] = true
end

if GameInfoTypes.RESOURCE_CORAL then
	tResources[GameInfoTypes.RESOURCE_CORAL] = true
end

if GameInfoTypes.RESOURCE_LAPIS then
	tResources[GameInfoTypes.RESOURCE_LAPIS] = true
end

local iSaintsFlowBuilding = GameInfoTypes.BUILDING_DECISIONS_SRTT_SAINTS_FLOW

local Decisions_BuySomeBling = {}
	Decisions_BuySomeBling.Name = "TXT_KEY_DECISIONS_SRTT_BUY_BLING"
	Decisions_BuySomeBling.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_SRTT_BUY_BLING_DESC")
	HookDecisionCivilizationIcon(Decisions_BuySomeBling, "CIVILIZATION_THIRD_STREET_SAINTS")
	Decisions_BuySomeBling.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_THIRD_STREET_SAINTS) then
			return false, false
		end

		local iEra = load(pPlayer, "Decisions_BuySomeBling")
		local iCurrentEra = pPlayer:GetCurrentEra()
		if iEra ~= nil then
			if iEra < iCurrentEra then
				save(pPlayer, "Decisions_BuySomeBling", nil)
			else
				Decisions_BuySomeBling.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_SRTT_BUY_BLING_ENACTED_DESC")
				return false, false, true
			end
		end
		
		local iGoldCost = 200 * iCurrentEra 
		local iRespectReward = 75 * iCurrentEra

		local tPossessedResources = {}

		for pCity in pPlayer:Cities() do
			local iNumPlots = pCity:GetNumCityPlots();
			for iPlot = 0, iNumPlots - 1 do
				local pPlot = pCity:GetCityIndexPlot(iPlot)
				if pPlot and pPlot:GetImprovementType() > -1 then
					local iResourceType = pPlot:GetResourceType()
					if tResources[iResourceType] then
						tPossessedResources[iResourceType] = true
					end
				end
			end
		end

		local iMultiplier = 0

		for k, v in pairs(tPossessedResources) do
			iMultiplier = iMultiplier + 1
		end

		iGoldCost = iGoldCost + (50 * iMultiplier)
		iRespectReward = iRespectReward + (100 * iMultiplier)

		Decisions_BuySomeBling.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_SRTT_BUY_BLING_DESC", iGoldCost, iRespectReward)
		
		if iMultiplier < 1 then return true, false end

		if pPlayer:GetGold() < iGoldCost then return true, false else return true, true end

	end
	)
	
	Decisions_BuySomeBling.DoFunc = (
	function(pPlayer)
		local iCurrentEra = pPlayer:GetCurrentEra()
		local iGoldCost = 200 * iCurrentEra 
		local iRespectReward = 75 * iCurrentEra

		local tPossessedResources = {}

		for pCity in pPlayer:Cities() do
			local iNumPlots = pCity:GetNumCityPlots();
			for iPlot = 0, iNumPlots - 1 do
				local pPlot = pCity:GetCityIndexPlot(iPlot)
				if pPlot and pPlot:GetImprovementType() > -1 then
					local iResourceType = pPlot:GetResourceType()
					if tResources[iResourceType] then
						tPossessedResources[iResourceType] = true
					end
				end
			end
		end

		local iMultiplier = 0

		for k, v in pairs(tPossessedResources) do
			iMultiplier = iMultiplier + 1
		end

		iGoldCost = iGoldCost + (50 * iMultiplier)
		iRespectReward = iRespectReward + (100 * iMultiplier)

		pPlayer:ChangeGold(-iGoldCost)
		LuaEvents.SRTTDoAddRespect(pPlayer:GetID(), iRespectReward)

		save(pPlayer, "Decisions_BuySomeBling", iCurrentEra)
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_THIRD_STREET_SAINTS, "Decisions_BuySomeBling", Decisions_BuySomeBling)

local Decisions_SaintsFlow = {}
	Decisions_SaintsFlow.Name = "TXT_KEY_DECISIONS_SRTT_SAINTS_FLOW"
	Decisions_SaintsFlow.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_SRTT_SAINTS_FLOW_DESC")
	HookDecisionCivilizationIcon(Decisions_SaintsFlow, "CIVILIZATION_THIRD_STREET_SAINTS")
	Decisions_SaintsFlow.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_THIRD_STREET_SAINTS) then
			return false, false
		end

		if load(pPlayer, "Decisions_SaintsFlow") == true then
			Decisions_SaintsFlow.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_SRTT_SAINTS_FLOW_ENACTED_DESC")
			return false, false, true
		end

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end

		local pTeam = Teams[pPlayer:GetTeam()]
		local pTeamTechs = pTeam:GetTeamTechs()
		
		if pTeamTechs:HasTech(GameInfoTypes.TECH_INDUSTRIALIZATION) and pTeamTechs:HasTech(GameInfoTypes.TECH_BIOLOGY) then
			return true, true
		else
			return true, false
		end
	end
	)
	
	Decisions_SaintsFlow.DoFunc = (
	function(pPlayer)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		save(pPlayer, "Decisions_SaintsFlow", true)
	end
	)

	Decisions_SaintsFlow.Monitors = {}
	Decisions_SaintsFlow.Monitors[GameEvents.PlayerDoTurn] = (
	function(iPlayer)
		local pPlayer = Players[iPlayer]
		local ttable = {}
		LuaEvents.SRTTIsActivePlayerSaints(iPlayer, ttable)
		if ttable[0] == true then
			local iRespectReduction = 0
			for pCity in pPlayer:Cities() do 
				if pCity:IsHasBuilding(iSaintsFlowBuilding) then
					iRespectReduction = iRespectReduction + 15
				end
			end
			LuaEvents.SRTTDoAddRespect(iPlayer, -iRespectReduction)
		end
	end
	)
	
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_THIRD_STREET_SAINTS, "Decisions_SaintsFlow", Decisions_SaintsFlow)


GameEvents.PlayerCanConstruct.Add(
	function(iPlayer, iBuilding)
		if iBuilding == iSaintsFlowBuilding then
			local pPlayer = Players[iPlayer]
			if load(pPlayer, "Decisions_SaintsFlow") == true then
				return true
			else
				return false
			end
		end
		return true
	end
)