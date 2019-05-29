-- LeanboxEvents
-- Author: Vice
-- DateCreated: 3/23/2015 9:50:52 PM
--------------------------------------------------------------

local Event_LeanboxExpansion = {}
    Event_LeanboxExpansion.Name = "TXT_KEY_EVENT_VV_LEANBOX_EXPANSION"
	Event_LeanboxExpansion.Desc = "TXT_KEY_EVENT_VV_LEANBOX_EXPANSION_DESC"
	Event_LeanboxExpansion.tValidCivs = 
		{
		["CIVILIZATION_VV_LEANBOX"]		= true,
		["CIVILIZATION_VV_LEANBOX_GH"]		= true,
		["CIVILIZATION_VV_LEANBOX_ULTRA"]		= true,
		["CIVILIZATION_VV_LEANBOX_GH_ULTRA"]		= true
		}
	Event_LeanboxExpansion.Weight = 20
	Event_LeanboxExpansion.CanFunc = (
		function(pPlayer)
			if pPlayer:GetNumCities() < 1 then return end
			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			return Event_LeanboxExpansion.tValidCivs[sCivType]
		end
		)
	Event_LeanboxExpansion.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_LeanboxExpansion.Outcomes[1] = {}
	Event_LeanboxExpansion.Outcomes[1].Name = "TXT_KEY_EVENT_VV_LEANBOX_EXPANSION_OUTCOME_1"
	Event_LeanboxExpansion.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LEANBOX_EXPANSION_OUTCOME_1_RESULT")
	Event_LeanboxExpansion.Outcomes[1].CanFunc = (
		function(pPlayer)
			local iTurns = math.ceil(1 * iMod)
			Event_LeanboxExpansion.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LEANBOX_EXPANSION_OUTCOME_1_RESULT", iTurns)
			return true
		end
		)
	Event_LeanboxExpansion.Outcomes[1].DoFunc = (
		function(pPlayer)
			local pCapital = pPlayer:GetCapitalCity() 
			local iTurns = math.ceil(1 * iMod)
			pCapital:ChangeResistanceTurns(iTurns)
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LEANBOX_EXPANSION_OUTCOME_1_NOTIFICATION"), Locale.ConvertTextKey(Event_LeanboxExpansion.Name))
		end
		)

for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_LeanboxExpansion.tValidCivs[sCiv] then
			tEvents.Event_LeanboxExpansion = Event_LeanboxExpansion
			break
		end
	end
end


local tGreatGames = {}

for row in GameInfo.GreatWorks() do
	if string.find(row.Type, "GREAT_WORK_VV_GAME_DEV") then
		tGreatGames[row.ID] = true
	end
end

local Events_LeanboxHacked = {}
    Events_LeanboxHacked.Name = "TXT_KEY_EVENT_VV_LEANBOX_HACKED"
	Events_LeanboxHacked.Desc = "TXT_KEY_EVENT_VV_LEANBOX_HACKED_DESC"
	Events_LeanboxHacked.tValidCivs = 
		{
		["CIVILIZATION_VV_LEANBOX"]		= true,
		["CIVILIZATION_VV_LEANBOX_GH"]		= true,
		["CIVILIZATION_VV_LEANBOX_ULTRA"]		= true,
		["CIVILIZATION_VV_LEANBOX_GH_ULTRA"]		= true
		}
	Events_LeanboxHacked.Weight = 20
	Events_LeanboxHacked.CanFunc = (
		function(pPlayer)
			if pPlayer:GetNumCities() < 1 then return end
			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			if Events_LeanboxHacked.tValidCivs[sCivType] == true then
				local tCities = {}
				for pCity in pPlayer:Cities() do
					if pCity:IsHasBuilding(GameInfoTypes.BUILDING_VV_LEANBOX_ARCADE) then
						--Don't target one with Great Works in it!
						local iCurrentWorks = pCity:GetNumGreatWorksInBuilding(GameInfoTypes.BUILDINGCLASS_COLOSSEUM)
						if iCurrentWorks > 0 then
							for i = 0, iCurrentWorks - 1, 1 do
								local iWorkType = pCity:GetBuildingGreatWork(GameInfoTypes.BUILDINGCLASS_COLOSSEUM, i)
								if tGreatGames[Game.GetGreatWorkType(iWorkType, iPlayer)] == true then
									tCities[#tCities + 1] = pCity
								end
							end
						end

					end
				end
				local pChosenCity = tCities[Game.Rand(#tCities - 1, "HDN Event Roll") + 1]
				if pChosenCity then
					Events_LeanboxHacked.Data1 = pChosenCity
					Events_LeanboxHacked.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LEANBOX_HACKED_DESC", pChosenCity:GetName())
					return true
				end
			end
			return false
		end
		)
	Events_LeanboxHacked.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Events_LeanboxHacked.Outcomes[1] = {}
	Events_LeanboxHacked.Outcomes[1].Name = "TXT_KEY_EVENT_VV_LEANBOX_HACKED_OUTCOME_1"
	Events_LeanboxHacked.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LEANBOX_HACKED_OUTCOME_1_RESULT")
	Events_LeanboxHacked.Outcomes[1].CanFunc = (
		function(pPlayer, pCity)
			Events_LeanboxHacked.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LEANBOX_HACKED_OUTCOME_1_RESULT", pCity:GetName())
			return true
		end
		)
	Events_LeanboxHacked.Outcomes[1].DoFunc = (
		function(pPlayer, pCity)
			pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_VV_LEANBOX_ARCADE, 0)
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LEANBOX_HACKED_OUTCOME_1_NOTIFICATION"), Locale.ConvertTextKey(Events_LeanboxHacked.Name))
		end
		)

for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Events_LeanboxHacked.tValidCivs[sCiv] then
			tEvents.Events_LeanboxHacked = Events_LeanboxHacked
			break
		end
	end
end



local Events_LeanboxRedRings = {}
    Events_LeanboxRedRings.Name = "TXT_KEY_EVENT_VV_LEANBOX_RED_RINGS"
	Events_LeanboxRedRings.Desc = "TXT_KEY_EVENT_VV_LEANBOX_RED_RINGS_DESC"
	Events_LeanboxRedRings.tValidCivs = 
		{
		["CIVILIZATION_VV_LEANBOX"]		= true,
		["CIVILIZATION_VV_LEANBOX_GH"]		= true,
		["CIVILIZATION_VV_LEANBOX_ULTRA"]		= true,
		["CIVILIZATION_VV_LEANBOX_GH_ULTRA"]		= true
		}
	Events_LeanboxRedRings.Weight = 20
	Events_LeanboxRedRings.CanFunc = (
		function(pPlayer)
			if pPlayer:GetNumCities() < 1 then return end
			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			if Events_LeanboxRedRings.tValidCivs[sCivType] then
				local tCities = {}
				for pCity in pPlayer:Cities() do
					table.insert(tCities, pCity)
				end
				
				Events_LeanboxRedRings.Data1 = tCities[GetRandom(1, #tCities)]
				Events_LeanboxRedRings.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LEANBOX_RED_RINGS_DESC", Events_LeanboxRedRings.Data1:GetName())
				return true
			end
			return false
		end
		)
	Events_LeanboxRedRings.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Events_LeanboxRedRings.Outcomes[1] = {}
	Events_LeanboxRedRings.Outcomes[1].Name = "TXT_KEY_EVENT_VV_LEANBOX_RED_RINGS_OUTCOME_1"
	Events_LeanboxRedRings.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LEANBOX_RED_RINGS_OUTCOME_1_RESULT")
	Events_LeanboxRedRings.Outcomes[1].CanFunc = (
		function(pPlayer, pCity)
			local iTurns = math.ceil(1 * iMod)
			Events_LeanboxRedRings.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LEANBOX_RED_RINGS_OUTCOME_1_RESULT", pCity:GetName())
			return true
		end
		)
	Events_LeanboxRedRings.Outcomes[1].DoFunc = (
		function(pPlayer, pCity)
			local iNumPlots = pCity:GetNumCityPlots();
			local iPlayer = pPlayer:GetID()

			local iNumToDestroy = 3
			
			for iPlot = 0, iNumPlots - 1 do
				local pPlot = pCity:GetCityIndexPlot(iPlot)
				if pPlot and pPlot:GetOwner() == iPlayer and pPlot:GetImprovementType() > -1 and not pPlot:IsImprovementPillaged() then
					pPlot:SetImprovementPillaged(true)
					iNumToDestroy = iNumToDestroy - 1
					if iNumToDestroy <= 0 then 
						break
					end
				end
			end

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LEANBOX_RED_RINGS_OUTCOME_1_NOTIFICATION"), Locale.ConvertTextKey(Events_LeanboxRedRings.Name))
		end
		)

for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Events_LeanboxRedRings.tValidCivs[sCiv] then
			tEvents.Events_LeanboxRedRings = Events_LeanboxRedRings
			break
		end
	end
end







local Events_LeanboxLegendaryTheme = {}
    Events_LeanboxLegendaryTheme.Name = "TXT_KEY_EVENT_VV_LEANBOX_LEGENDARY_THEME"
	Events_LeanboxLegendaryTheme.Desc = "TXT_KEY_EVENT_VV_LEANBOX_LEGENDARY_THEME_DESC"
	Events_LeanboxLegendaryTheme.tValidCivs = 
		{
		["CIVILIZATION_VV_LEANBOX"]		= true,
		["CIVILIZATION_VV_LEANBOX_GH"]		= true,
		["CIVILIZATION_VV_LEANBOX_ULTRA"]		= true,
		["CIVILIZATION_VV_LEANBOX_GH_ULTRA"]		= true
		}
	Events_LeanboxLegendaryTheme.Weight = 120
	Events_LeanboxLegendaryTheme.CanFunc = (
		function(pPlayer)
			if pPlayer:GetNumCities() < 1 then return false end
			if load(pPlayer, "Events_LeanboxLegendaryTheme") == true then return false end
			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			if Events_LeanboxLegendaryTheme.tValidCivs[sCivType] then
				local pTeam = Teams[pPlayer:GetTeam()]
				local iPlayer = pPlayer:GetID()
				local bAtWar = false
				for i = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
					if i ~= iPlayer then
						local pLoop = Players[i]
						if pTeam:IsAtWar(pLoop:GetTeam()) and pLoop:IsAlive() then
							bAtWar = true
							break
						end
					end
				end
				if bAtWar then
					local iNumLandmarks = 0
					for pCity in pPlayer:Cities() do
						local iNumPlots = pCity:GetNumCityPlots();
						for iPlot = 0, iNumPlots - 1 do
							local pPlot = pCity:GetCityIndexPlot(iPlot)
							if pPlot and pPlot:GetOwner() == iPlayer and pPlot:GetImprovementType() == GameInfoTypes.IMPROVEMENT_LANDMARK and not pPlot:IsImprovementPillaged() then
								iNumLandmarks = iNumLandmarks + 1
								if iNumLandmarks >= 2 then 
									return true
								end
							end
						end
					end
				end
			end
			return false
		end
		)
	Events_LeanboxLegendaryTheme.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Events_LeanboxLegendaryTheme.Outcomes[1] = {}
	Events_LeanboxLegendaryTheme.Outcomes[1].Name = "TXT_KEY_EVENT_VV_LEANBOX_LEGENDARY_THEME_OUTCOME_1"
	Events_LeanboxLegendaryTheme.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LEANBOX_LEGENDARY_THEME_OUTCOME_1_RESULT")
	Events_LeanboxLegendaryTheme.Outcomes[1].CanFunc = (
		function(pPlayer)
			return true
		end
		)
	Events_LeanboxLegendaryTheme.Outcomes[1].DoFunc = (
		function(pPlayer)
			local iPlayer = pPlayer:GetID()
			
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetHasPolicy(GameInfoTypes.POLICY_EVENTS_VV_LEANBOX_LEGENDARY, true)
			pPlayer:SetNumFreePolicies(0)
			
			if iPlayer == Game:GetActivePlayer() then
				Events.AudioPlay2DSound("AS2D_EVENTS_VV_LEANBOX_LEGENDARY")
			end
			
			save(pPlayer, "Events_LeanboxLegendaryTheme", true)
			
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LEANBOX_LEGENDARY_THEME_OUTCOME_1_NOTIFICATION"), Locale.ConvertTextKey(Events_LeanboxLegendaryTheme.Name))
		end
		)

for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Events_LeanboxLegendaryTheme.tValidCivs[sCiv] then
			tEvents.Events_LeanboxLegendaryTheme = Events_LeanboxLegendaryTheme
			break
		end
	end
end


local Events_LeanboxBlog = {}
    Events_LeanboxBlog.Name = "TXT_KEY_EVENT_VV_LEANBOX_BLOG"
	Events_LeanboxBlog.Desc = "TXT_KEY_EVENT_VV_LEANBOX_BLOG_DESC"
	Events_LeanboxBlog.tValidCivs = 
		{
		["CIVILIZATION_VV_LEANBOX"]		= true,
		["CIVILIZATION_VV_LEANBOX_GH"]		= true,
		["CIVILIZATION_VV_LEANBOX_ULTRA"]		= true,
		["CIVILIZATION_VV_LEANBOX_GH_ULTRA"]		= true
		}
	Events_LeanboxBlog.Weight = 250
	Events_LeanboxBlog.CanFunc = (
		function(pPlayer)
			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			if Event_LeanboxExpansion.tValidCivs[sCivType] == true then
				local iPlayer = pPlayer:GetID()
				local iTimes = load(pPlayer, "Events_LeanboxBlog")
				if not iTimes then iTimes = 0 end
				if iTimes >= 5 then return false end
				if iTimes >= 1 then
					Events_LeanboxBlog.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LEANBOX_BLOG_REPEAT_DESC")
				end
				local iShareReqs = 1500 * (iTimes + 1)
				if MapModData.HDNMod.Shares[iPlayer] and MapModData.HDNMod.Shares[iPlayer] >= iShareReqs then
					return true
				end
			end
			return false
		end
		)
	Events_LeanboxBlog.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Events_LeanboxBlog.Outcomes[1] = {}
	Events_LeanboxBlog.Outcomes[1].Name = "TXT_KEY_EVENT_VV_LEANBOX_BLOG_OUTCOME_1"
	Events_LeanboxBlog.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LEANBOX_BLOG_OUTCOME_1_RESULT")
	Events_LeanboxBlog.Outcomes[1].CanFunc = (
		function(pPlayer)
			if load(pPlayer, "Events_LeanboxBlog1") == nil then
				local iCulture = math.ceil(10 * iMod)
				Events_LeanboxBlog.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LEANBOX_BLOG_OUTCOME_1_RESULT", iCulture)
				return true
			end
		end
		)
	Events_LeanboxBlog.Outcomes[1].DoFunc = (
		function(pPlayer)
		
			local iCulture = math.ceil(10 * iMod)
			pPlayer:ChangeJONSCulture(iCulture * pPlayer:GetTotalPopulation())
			
			save(pPlayer, "Events_LeanboxBlog1", true)
			local iTimes = load(pPlayer, "Events_LeanboxBlog")
			if not iTimes then
				save(pPlayer, "Events_LeanboxBlog", 1)
			else
				save(pPlayer, "Events_LeanboxBlog", iTimes + 1)
			end
			
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LEANBOX_BLOG_OUTCOME_NOTIFICATION"), Locale.ConvertTextKey(Events_LeanboxBlog.Name))
		end
		)
		
	--=========================================================
	-- Outcome 2
	--=========================================================
	Events_LeanboxBlog.Outcomes[2] = {}
	Events_LeanboxBlog.Outcomes[2].Name = "TXT_KEY_EVENT_VV_LEANBOX_BLOG_OUTCOME_2"
	Events_LeanboxBlog.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LEANBOX_BLOG_OUTCOME_2_RESULT")
	Events_LeanboxBlog.Outcomes[2].CanFunc = (
		function(pPlayer)
			if load(pPlayer, "Events_LeanboxBlog2") == nil then
				local iCulture = math.ceil(5 * iMod)
				Events_LeanboxBlog.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LEANBOX_BLOG_OUTCOME_2_RESULT", iCulture)
				return true
			end
		end
		)
	Events_LeanboxBlog.Outcomes[2].DoFunc = (
		function(pPlayer)
		
			local iCulture = math.ceil(5 * iMod)
			local iTotalCulture = 0
			local iPlayer = pPlayer:GetID()
			
			for pCity in pPlayer:Cities() do
				local iNumPlots = pCity:GetNumCityPlots();
				for iPlot = 0, iNumPlots - 1 do
					local pPlot = pCity:GetCityIndexPlot(iPlot)
					if pPlot and pPlot:GetOwner() == iPlayer then
						if pPlot:GetTerrainType() == GameInfoTypes.TERRAIN_GRASS then
							iTotalCulture = iTotalCulture + iCulture
						end
						if pPlot:GetFeatureType() == GameInfoTypes.FEATURE_FOREST then
							iTotalCulture = iTotalCulture + iCulture
						end
					end
				end
			end
			
			pPlayer:ChangeJONSCulture(iTotalCulture)
			
			save(pPlayer, "Events_LeanboxBlog2", true)
			local iTimes = load(pPlayer, "Events_LeanboxBlog")
			if not iTimes then
				save(pPlayer, "Events_LeanboxBlog", 1)
			else
				save(pPlayer, "Events_LeanboxBlog", iTimes + 1)
			end
			
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LEANBOX_BLOG_OUTCOME_NOTIFICATION"), Locale.ConvertTextKey(Events_LeanboxBlog.Name))
		end
		)
		
	--=========================================================
	-- Outcome 3
	--=========================================================
	Events_LeanboxBlog.Outcomes[3] = {}
	Events_LeanboxBlog.Outcomes[3].Name = "TXT_KEY_EVENT_VV_LEANBOX_BLOG_OUTCOME_3"
	Events_LeanboxBlog.Outcomes[3].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LEANBOX_BLOG_OUTCOME_3_RESULT")
	Events_LeanboxBlog.Outcomes[3].CanFunc = (
		function(pPlayer)
			if load(pPlayer, "Events_LeanboxBlog3") == nil then
				local iGold = math.ceil(100 * iMod)
				Events_LeanboxBlog.Outcomes[3].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LEANBOX_BLOG_OUTCOME_3_RESULT", iGold)
				return true
			end
		end
		)
	Events_LeanboxBlog.Outcomes[3].DoFunc = (
		function(pPlayer)
		
			local iGold = math.ceil(100 * iMod)
			local iTotalGold = 0
			local tr = pPlayer:GetTradeRoutes()
			
			for k, v in pairs(tr) do
				if v.ToCiv ~= v.FromCiv then
					iTotalGold = iTotalGold + iGold
				end
			end
			
			pPlayer:ChangeGold(iTotalGold)
			
			save(pPlayer, "Events_LeanboxBlog3", true)
			local iTimes = load(pPlayer, "Events_LeanboxBlog")
			if not iTimes then
				save(pPlayer, "Events_LeanboxBlog", 1)
			else
				save(pPlayer, "Events_LeanboxBlog", iTimes + 1)
			end
			
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LEANBOX_BLOG_OUTCOME_NOTIFICATION"), Locale.ConvertTextKey(Events_LeanboxBlog.Name))
		end
		)
		
	--=========================================================
	-- Outcome 4
	--=========================================================
	Events_LeanboxBlog.Outcomes[4] = {}
	Events_LeanboxBlog.Outcomes[4].Name = "TXT_KEY_EVENT_VV_LEANBOX_BLOG_OUTCOME_4"
	Events_LeanboxBlog.Outcomes[4].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LEANBOX_BLOG_OUTCOME_4_RESULT")
	Events_LeanboxBlog.Outcomes[4].CanFunc = (
		function(pPlayer)
			if load(pPlayer, "Events_LeanboxBlog4") == nil then
				return true
			end
		end
		)
	Events_LeanboxBlog.Outcomes[4].DoFunc = (
		function(pPlayer)
		
			for pUnit in pPlayer:Units() do
				if pUnit:IsCombatUnit() or pUnit:GetDomainType() == DomainTypes.DOMAIN_AIR then
					pUnit:ChangeExperience(10)
				end
			end

			save(pPlayer, "Events_LeanboxBlog4", true)
			local iTimes = load(pPlayer, "Events_LeanboxBlog")
			if not iTimes then
				save(pPlayer, "Events_LeanboxBlog", 1)
			else
				save(pPlayer, "Events_LeanboxBlog", iTimes + 1)
			end
			
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LEANBOX_BLOG_OUTCOME_NOTIFICATION"), Locale.ConvertTextKey(Events_LeanboxBlog.Name))
		end
		)
		
		
	--=========================================================
	-- Outcome 5
	--=========================================================
	Events_LeanboxBlog.Outcomes[5] = {}
	Events_LeanboxBlog.Outcomes[5].Name = "TXT_KEY_EVENT_VV_LEANBOX_BLOG_OUTCOME_5"
	Events_LeanboxBlog.Outcomes[5].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LEANBOX_BLOG_OUTCOME_5_RESULT")
	Events_LeanboxBlog.Outcomes[5].CanFunc = (
		function(pPlayer)
			if load(pPlayer, "Events_LeanboxBlog5") == nil then
				return true
			end
		end
		)
	Events_LeanboxBlog.Outcomes[5].DoFunc = (
		function(pPlayer)
		
			pPlayer:ChangeGoldenAgeTurns(pPlayer:GetGoldenAgeLength())

			save(pPlayer, "Events_LeanboxBlog5", true)
			local iTimes = load(pPlayer, "Events_LeanboxBlog")
			if not iTimes then
				save(pPlayer, "Events_LeanboxBlog", 1)
			else
				save(pPlayer, "Events_LeanboxBlog", iTimes + 1)
			end
			
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LEANBOX_BLOG_OUTCOME_NOTIFICATION"), Locale.ConvertTextKey(Events_LeanboxBlog.Name))
		end
		)

for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Events_LeanboxBlog.tValidCivs[sCiv] then
			tEvents.Events_LeanboxBlog = Events_LeanboxBlog
			break
		end
	end
end




