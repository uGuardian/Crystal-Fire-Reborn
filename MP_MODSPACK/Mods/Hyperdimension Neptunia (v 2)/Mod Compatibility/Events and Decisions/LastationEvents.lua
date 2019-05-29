-- LastationEvents
-- Author: Vice
--------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------
-- Caught Cosplaying
----------------------------------------------------------------------------------------------------------------------------
local Events_LastationCosplayCaught = {}
    Events_LastationCosplayCaught.Name = "TXT_KEY_EVENT_VV_LASTATION_COSPLAY"
	Events_LastationCosplayCaught.Desc = "TXT_KEY_EVENT_VV_LASTATION_COSPLAY_DESC"
	Events_LastationCosplayCaught.tValidCivs = 
		{
		["CIVILIZATION_VV_LASTATION"]			= true,
		["CIVILIZATION_VV_LASTATION_BH"]		= true,
		["CIVILIZATION_VV_LASTATION_ULTRA"]		= true,
		["CIVILIZATION_VV_LASTATION_BH_ULTRA"]	= true
		}
	Events_LastationCosplayCaught.Weight = 2
	Events_LastationCosplayCaught.EventImage = "Event_NoireCosplay.dds"
	Events_LastationCosplayCaught.CanFunc = (
		function(pPlayer)
			if pPlayer:GetNumCities() < 1 then return end
			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			if Events_LastationCosplayCaught.tValidCivs[sCivType] == true then
				local iWeight = 2
				for pCity in pPlayer:Cities() do
					if pCity:IsHasBuilding(GameInfoTypes.BUILDING_VV_COSPLAY_SHOP) then
						iWeight = iWeight + 4
					end
				end
				Events_LastationCosplayCaught.Weight = iWeight
				return true
			end
			return false
		end
		)
	Events_LastationCosplayCaught.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Events_LastationCosplayCaught.Outcomes[1] = {}
	Events_LastationCosplayCaught.Outcomes[1].Name = "TXT_KEY_EVENT_VV_LASTATION_COSPLAY_OUTCOME_1"
	Events_LastationCosplayCaught.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LASTATION_COSPLAY_OUTCOME_1_RESULT")
	Events_LastationCosplayCaught.Outcomes[1].CanFunc = (
		function(pPlayer)
			local iGoldLoss = math.min(math.floor(100 * iMod * math.max(pPlayer:GetCurrentEra(), 1)), pPlayer:GetGold())
			local iShareLoss = math.min(50 * math.max(pPlayer:GetCurrentEra(), 1), MapModData.HDNMod.Shares[pPlayer:GetID()])
			local iCultureGain = math.ceil(150 * iMod * math.max(pPlayer:GetCurrentEra(), 1))
			local sShareLoss = string.format("%.2f%%", iShareLoss / 100)
			Events_LastationCosplayCaught.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LASTATION_COSPLAY_OUTCOME_1_RESULT", iGoldLoss, sShareLoss, iCultureGain)
			return true
		end
		)
	Events_LastationCosplayCaught.Outcomes[1].DoFunc = (
		function(pPlayer)
			local iGoldLoss = math.min(math.floor(100 * iMod * math.max(pPlayer:GetCurrentEra(), 1)), pPlayer:GetGold())
			local iShareLoss = math.min(50 * math.max(pPlayer:GetCurrentEra(), 1), MapModData.HDNMod.Shares[pPlayer:GetID()])
			local iCultureGain = math.ceil(150 * iMod * math.max(pPlayer:GetCurrentEra(), 1))

			pPlayer:ChangeGold(-iGoldLoss)
			LuaEvents.HDNChangeShares(pPlayer:GetID(), -iShareLoss)
			pPlayer:ChangeJONSCulture(iCultureGain)
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LASTATION_COSPLAY_OUTCOME_1_NOTIFICATION"), Locale.ConvertTextKey(Events_LastationCosplayCaught.Name))
		end
		)

	--=========================================================
	-- Outcome 2
	--=========================================================
	Events_LastationCosplayCaught.Outcomes[2] = {}
	Events_LastationCosplayCaught.Outcomes[2].Name = "TXT_KEY_EVENT_VV_LASTATION_COSPLAY_OUTCOME_2"
	Events_LastationCosplayCaught.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LASTATION_COSPLAY_OUTCOME_2_RESULT")
	Events_LastationCosplayCaught.Outcomes[2].CanFunc = (
		function(pPlayer)
			local iShareGain = 75 * math.max(pPlayer:GetCurrentEra() * 2, 2)
			local sShareGain = string.format("%.2f%%", iShareGain / 100)
			Events_LastationCosplayCaught.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LASTATION_COSPLAY_OUTCOME_2_RESULT", sShareGain)
			return true
		end
		)
	Events_LastationCosplayCaught.Outcomes[2].DoFunc = (
		function(pPlayer)
			local iShareGain = 75 * math.max(pPlayer:GetCurrentEra(), 1)
			LuaEvents.HDNChangeShares(pPlayer:GetID(), iShareGain)
			
			local tRandomUnits = {}
			for pUnit in pPlayer:Units() do
				if pUnit:IsCombatUnit() and pUnit:GetUnitClassType() ~= GameInfoTypes.UNITCLASS_PMMM_MAGICAL_GIRL then
					tRandomUnits[#tRandomUnits + 1] = pUnit
				end
			end

			if #tRandomUnits > 0 then
				local iRand = Game.Rand(#tRandomUnits, "HDN Event Roll") + 1
				tRandomUnits[iRand]:Kill(true)
				table.remove(tRandomUnits, iRand)
				if #tRandomUnits > 0 then
					iRand = Game.Rand(#tRandomUnits, "HDN Event Roll") + 1
					tRandomUnits[iRand]:Kill(true)
				end
			end

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LASTATION_COSPLAY_OUTCOME_2_NOTIFICATION"), Locale.ConvertTextKey(Events_LastationCosplayCaught.Name))
		end
		)

for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Events_LastationCosplayCaught.tValidCivs[sCiv] then
			tEvents.Events_LastationCosplayCaught = Events_LastationCosplayCaught
			break
		end
	end
end

----------------------------------------------------------------------------------------------------------------------------
-- Kei's Diplomacy
----------------------------------------------------------------------------------------------------------------------------
local Events_LastationKeiDiplomacy = {}
    Events_LastationKeiDiplomacy.Name = "TXT_KEY_EVENT_VV_LASTATION_KEI"
	Events_LastationKeiDiplomacy.Desc = "TXT_KEY_EVENT_VV_LASTATION_KEI_DESC"
	Events_LastationKeiDiplomacy.tValidCivs = 
		{
		["CIVILIZATION_VV_LASTATION"]			= true,
		["CIVILIZATION_VV_LASTATION_BH"]		= true,
		["CIVILIZATION_VV_LASTATION_ULTRA"]		= true,
		["CIVILIZATION_VV_LASTATION_BH_ULTRA"]	= true
		}
	Events_LastationKeiDiplomacy.Weight = 10
	Events_LastationKeiDiplomacy.EventImage = "Event_LastationKei.dds"
	Events_LastationKeiDiplomacy.CanFunc = (
		function(pPlayer)
			if pPlayer:GetNumCities() < 1 then return end
			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			if Events_LastationKeiDiplomacy.tValidCivs[sCivType] == true then
				if MapModData.HDNMod.Shares[pPlayer:GetID()] < 500 then return false end
				Events_LastationKeiDiplomacy.Data1 = {}
				for iCS, pCS in pairs(Players) do
					if (pCS:IsAlive() and pCS:IsMinorCiv() and Teams[pPlayer:GetTeam()]:IsHasMet(pCS:GetTeam()) and not(Teams[pPlayer:GetTeam()]:IsAtWar(pCS:GetTeam()))) then
						table.insert(Events_LastationKeiDiplomacy.Data1, pCS)
					end
				end
				if #Events_LastationKeiDiplomacy.Data1 < 1 then return false end
			
				Events_LastationKeiDiplomacy.Data2 = Events_LastationKeiDiplomacy.Data1[GetRandom(1, #Events_LastationKeiDiplomacy.Data1)]
				Events_LastationKeiDiplomacy.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LASTATION_KEI_DESC", Events_LastationKeiDiplomacy.Data2:GetCivilizationShortDescription())
				return true
			end
			return false
		end
		)
	Events_LastationKeiDiplomacy.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Events_LastationKeiDiplomacy.Outcomes[1] = {}
	Events_LastationKeiDiplomacy.Outcomes[1].Name = "TXT_KEY_EVENT_VV_LASTATION_KEI_OUTCOME_1"
	Events_LastationKeiDiplomacy.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LASTATION_KEI_OUTCOME_1_RESULT")
	Events_LastationKeiDiplomacy.Outcomes[1].CanFunc = (
		function(pPlayer)
			local iInfluence = math.floor(MapModData.HDNMod.Shares[pPlayer:GetID()] * 0.01)
			local iGold = math.floor(MapModData.HDNMod.Shares[pPlayer:GetID()] * 0.10 * iMod)
			Events_LastationKeiDiplomacy.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LASTATION_KEI_OUTCOME_1_RESULT", iGold, iInfluence, Events_LastationKeiDiplomacy.Data2:GetCivilizationShortDescription())
			return true
		end
		)
	Events_LastationKeiDiplomacy.Outcomes[1].DoFunc = (
		function(pPlayer)
			local iInfluence = math.floor(MapModData.HDNMod.Shares[pPlayer:GetID()] * 0.01)
			local iGold = math.floor(MapModData.HDNMod.Shares[pPlayer:GetID()] * 0.10 * iMod)

			Events_LastationKeiDiplomacy.Data2:ChangeMinorCivFriendshipWithMajor(pPlayer:GetID(), iInfluence)
			pPlayer:ChangeGold(iGold)
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LASTATION_KEI_OUTCOME_1_NOTIFICATION"), Locale.ConvertTextKey(Events_LastationKeiDiplomacy.Name))
		end
		)

	--=========================================================
	-- Outcome 2
	--=========================================================
	Events_LastationKeiDiplomacy.Outcomes[2] = {}
	Events_LastationKeiDiplomacy.Outcomes[2].Name = "TXT_KEY_EVENT_VV_LASTATION_KEI_OUTCOME_2"
	Events_LastationKeiDiplomacy.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LASTATION_KEI_OUTCOME_2_RESULT")
	Events_LastationKeiDiplomacy.Outcomes[2].CanFunc = (
		function(pPlayer)
			local iInfluence = math.floor(MapModData.HDNMod.Shares[pPlayer:GetID()] * 0.01)
			local iGold = math.floor(MapModData.HDNMod.Shares[pPlayer:GetID()] * 0.25 * iMod)
			Events_LastationKeiDiplomacy.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LASTATION_KEI_OUTCOME_2_RESULT", iGold, iInfluence, Events_LastationKeiDiplomacy.Data2:GetCivilizationShortDescription())
			return true
		end
		)
	Events_LastationKeiDiplomacy.Outcomes[2].DoFunc = (
		function(pPlayer)
			local iInfluence = math.floor(MapModData.HDNMod.Shares[pPlayer:GetID()] * 0.01)
			local iGold = math.floor(MapModData.HDNMod.Shares[pPlayer:GetID()] * 0.25 * iMod)

			Events_LastationKeiDiplomacy.Data2:ChangeMinorCivFriendshipWithMajor(pPlayer:GetID(), -iInfluence)
			pPlayer:ChangeGold(iGold)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LASTATION_KEI_OUTCOME_2_NOTIFICATION"), Locale.ConvertTextKey(Events_LastationKeiDiplomacy.Name))
		end
		)

for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Events_LastationKeiDiplomacy.tValidCivs[sCiv] then
			tEvents.Events_LastationKeiDiplomacy = Events_LastationKeiDiplomacy
			break
		end
	end
end


----------------------------------------------------------------------------------------------------------------------------
-- Avenir Gains Support
----------------------------------------------------------------------------------------------------------------------------
local Events_LastationAvenir = {}
    Events_LastationAvenir.Name = "TXT_KEY_EVENT_VV_LASTATION_AVENIR"
	Events_LastationAvenir.Desc = "TXT_KEY_EVENT_VV_LASTATION_AVENIR_DESC"
	Events_LastationAvenir.tValidCivs = 
		{
		["CIVILIZATION_VV_LASTATION"]			= true,
		["CIVILIZATION_VV_LASTATION_BH"]		= true,
		["CIVILIZATION_VV_LASTATION_ULTRA"]		= true,
		["CIVILIZATION_VV_LASTATION_BH_ULTRA"]	= true
		}
	Events_LastationAvenir.Weight = 35
	Events_LastationAvenir.CanFunc = (
		function(pPlayer)
			if pPlayer:GetNumCities() < 1 then return false end
			if load(pPlayer, "Events_LastationAvenir") == true then return false end
			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			if Events_LastationAvenir.tValidCivs[sCivType] == true then
				Events_LastationAvenir.Data1 = {}
				for pCity in pPlayer:Cities() do
					if pCity:IsHasBuilding(GameInfoTypes.BUILDING_FACTORY) then
						table.insert(Events_LastationAvenir.Data1, pCity)
					end
				end
				if #Events_LastationAvenir.Data1 < 1 then return false end
			
				Events_LastationAvenir.Data2 = Events_LastationAvenir.Data1[GetRandom(1, #Events_LastationAvenir.Data1)]
				Events_LastationAvenir.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LASTATION_AVENIR_DESC", Events_LastationAvenir.Data2:GetName())
				return true
			end
			return false
		end
		)
	Events_LastationAvenir.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Events_LastationAvenir.Outcomes[1] = {}
	Events_LastationAvenir.Outcomes[1].Name = "TXT_KEY_EVENT_VV_LASTATION_AVENIR_OUTCOME_1"
	Events_LastationAvenir.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LASTATION_AVENIR_OUTCOME_1_RESULT")
	Events_LastationAvenir.Outcomes[1].CanFunc = (
		function(pPlayer, _, pCity)
			local iProductionLoss = math.floor(25 + (20 * (pPlayer:GetCurrentEra() * 3)) * iMod)
			Events_LastationAvenir.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LASTATION_AVENIR_OUTCOME_1_RESULT", iProductionLoss)
			return true
		end
		)
	Events_LastationAvenir.Outcomes[1].DoFunc = (
		function(pPlayer, _, pCity)
			local iProductionLoss = math.floor(25 + (20 * (pPlayer:GetCurrentEra() * 3)) * iMod)

			for pCity in pPlayer:Cities() do
				pCity:ChangeProduction(-iProductionLoss)
			end

			save(pPlayer, "Events_LastationAvenir", true)
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LASTATION_AVENIR_OUTCOME_1_NOTIFICATION"), Locale.ConvertTextKey(Events_LastationAvenir.Name))
		end
		)

	--=========================================================
	-- Outcome 2
	--=========================================================
	Events_LastationAvenir.Outcomes[2] = {}
	Events_LastationAvenir.Outcomes[2].Name = "TXT_KEY_EVENT_VV_LASTATION_AVENIR_OUTCOME_2"
	Events_LastationAvenir.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LASTATION_AVENIR_OUTCOME_2_RESULT")
	Events_LastationAvenir.Outcomes[2].CanFunc = (
		function(pPlayer, _, pCity)
			local iShareGain = 1000
			local sShareGain = string.format("%.2f%%", iShareGain / 100)
			Events_LastationAvenir.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LASTATION_AVENIR_OUTCOME_2_RESULT", sShareGain, pCity:GetName())
			return true
		end
		)
	Events_LastationAvenir.Outcomes[2].DoFunc = (
		function(pPlayer, _, pCity)
			local iShareGain = 1000
			LuaEvents.HDNChangeShares(pPlayer:GetID(), iShareGain)

			local unitID = GetStrongestMilitaryUnit(pPlayer, true, "UNITCOMBAT_ARMOR")
			if unitID == GameInfoTypes.UNIT_WARRIOR then unitID = GameInfoTypes.UNIT_WWI_TANK end
			local unitOne	= Players[63]:InitUnit(unitID, pCity:GetX() + 1, pCity:GetY() + 1)
			local unitTwo	= Players[63]:InitUnit(unitID, pCity:GetX() + 1, pCity:GetY() + 1)
			local unitThree = Players[63]:InitUnit(unitID, pCity:GetX() + 1, pCity:GetY() + 1)
			local unitFour	= Players[63]:InitUnit(unitID, pCity:GetX() + 1, pCity:GetY() + 1)

			unitOne:JumpToNearestValidPlot() 
			unitTwo:JumpToNearestValidPlot() 
			unitThree:JumpToNearestValidPlot() 
			unitFour:JumpToNearestValidPlot() 
			unitOne:SetExperience(210)
			unitTwo:SetExperience(210)
			unitThree:SetExperience(210)
			unitFour:SetExperience(210)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LASTATION_AVENIR_OUTCOME_2_NOTIFICATION"), Locale.ConvertTextKey(Events_LastationAvenir.Name))
		end
		)

	--=========================================================
	-- Outcome 3
	--=========================================================
	Events_LastationAvenir.Outcomes[3] = {}
	Events_LastationAvenir.Outcomes[3].Name = "TXT_KEY_EVENT_VV_LASTATION_AVENIR_OUTCOME_3"
	Events_LastationAvenir.Outcomes[3].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LASTATION_AVENIR_OUTCOME_3_RESULT")
	Events_LastationAvenir.Outcomes[3].CanFunc = (
		function(pPlayer, _, pCity)
			local iShareLoss = math.min(1000, MapModData.HDNMod.Shares[pPlayer:GetID()])
			local sShareLoss = string.format("%.3f%%", iShareLoss / 100)
			local iProductionGain = math.floor(25 + (20 * (pPlayer:GetCurrentEra() * 3)) * iMod)
			Events_LastationAvenir.Outcomes[3].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LASTATION_AVENIR_OUTCOME_3_RESULT", sShareLoss, iProductionGain)
			return true
		end
		)
	Events_LastationAvenir.Outcomes[3].DoFunc = (
		function(pPlayer, _, pCity)
			local iShareLoss = math.min(1000, MapModData.HDNMod.Shares[pPlayer:GetID()])
			local iProductionGain = math.floor(25 + (20 * (pPlayer:GetCurrentEra() * 3)) * iMod)
			LuaEvents.HDNChangeShares(pPlayer:GetID(), -iShareLoss)

			for pCity in pPlayer:Cities() do
				pCity:ChangeProduction(iProductionGain)
			end

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LASTATION_AVENIR_OUTCOME_3_NOTIFICATION"), Locale.ConvertTextKey(Events_LastationAvenir.Name))
		end
		)

for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Events_LastationAvenir.tValidCivs[sCiv] then
			tEvents.Events_LastationAvenir = Events_LastationAvenir
			break
		end
	end
end

----------------------------------------------------------------------------------------------------------------------------
-- Lastation Network Hacked!
----------------------------------------------------------------------------------------------------------------------------


local Events_LastationHacked = {}
    Events_LastationHacked.Name = "TXT_KEY_EVENT_VV_LASTATION_HACKED"
	Events_LastationHacked.Desc = "TXT_KEY_EVENT_VV_LASTATION_HACKED_DESC"
	Events_LastationHacked.tValidCivs = 
		{
		["CIVILIZATION_VV_LASTATION"]			= true,
		["CIVILIZATION_VV_LASTATION_BH"]		= true,
		["CIVILIZATION_VV_LASTATION_ULTRA"]		= true,
		["CIVILIZATION_VV_LASTATION_BH_ULTRA"]	= true
		}
	Events_LastationHacked.Weight = 20
	Events_LastationHacked.CanFunc = (
		function(pPlayer)
			if pPlayer:GetNumCities() < 1 then return end
			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			if Events_LastationHacked.tValidCivs[sCivType] == true then
				local tCities = {}
				for pCity in pPlayer:Cities() do
					if not pCity:IsResistance() and not pCity:IsRazing() then
						tCities[#tCities + 1] = pCity
					end
				end
				local pChosenCity = tCities[Game.Rand(#tCities - 1, "HDN Event Roll") + 1]
				if pChosenCity then
					Events_LastationHacked.Data1 = pChosenCity
					Events_LastationHacked.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LASTATION_HACKED_DESC", pChosenCity:GetName())
					return true
				end
			end
			return false
		end
		)
	Events_LastationHacked.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Events_LastationHacked.Outcomes[1] = {}
	Events_LastationHacked.Outcomes[1].Name = "TXT_KEY_EVENT_VV_LASTATION_HACKED_OUTCOME_1"
	Events_LastationHacked.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LASTATION_HACKED_OUTCOME_1_RESULT")
	Events_LastationHacked.Outcomes[1].CanFunc = (
		function(pPlayer, pCity)
			Events_LastationHacked.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LASTATION_HACKED_OUTCOME_1_RESULT", math.ceil(1 * iMod), pCity:GetName())
			return true
		end
		)
	Events_LastationHacked.Outcomes[1].DoFunc = (
		function(pPlayer, pCity)
			pCity:ChangeResistanceTurns(math.ceil(1 * iMod))
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LASTATION_HACKED_OUTCOME_1_NOTIFICATION"), Locale.ConvertTextKey(Events_LastationHacked.Name))
		end
		)

for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Events_LastationHacked.tValidCivs[sCiv] then
			tEvents.Events_LastationHacked = Events_LastationHacked
			break
		end
	end
end

----------------------------------------------------------------------------------------------------------------------------
-- Lastation Goddess Blog
----------------------------------------------------------------------------------------------------------------------------

local Events_LastationBlog = {}
    Events_LastationBlog.Name = "TXT_KEY_EVENT_VV_LASTATION_BLOG"
	Events_LastationBlog.Desc = "TXT_KEY_EVENT_VV_LASTATION_BLOG_DESC"
	Events_LastationBlog.tValidCivs = 
		{
		["CIVILIZATION_VV_LASTATION"]		= true,
		["CIVILIZATION_VV_LASTATION_BH"]		= true,
		["CIVILIZATION_VV_LASTATION_ULTRA"]		= true,
		["CIVILIZATION_VV_LASTATION_BH_ULTRA"]		= true
		}
	Events_LastationBlog.Weight = 250
	Events_LastationBlog.EventImage = "Event_LastationBlog.dds"
	Events_LastationBlog.CanFunc = (
		function(pPlayer)
			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			if Events_LastationBlog.tValidCivs[sCivType] == true then
				local iPlayer = pPlayer:GetID()
				local iTimes = load(pPlayer, "Events_LastationBlog")
				if not iTimes then iTimes = 0 end
				if iTimes >= 5 then return false end
				if iTimes >= 1 then
					Events_LastationBlog.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LASTATION_BLOG_REPEAT_DESC")
				end
				local iShareReqs = 1500 * iMod * (iTimes + 1)
				if MapModData.HDNMod.Shares[iPlayer] and MapModData.HDNMod.Shares[iPlayer] >= iShareReqs then
					return true
				end
			end
			return false
		end
		)
	Events_LastationBlog.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Events_LastationBlog.Outcomes[1] = {}
	Events_LastationBlog.Outcomes[1].Name = "TXT_KEY_EVENT_VV_LASTATION_BLOG_OUTCOME_1"
	Events_LastationBlog.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LASTATION_BLOG_OUTCOME_1_RESULT")
	Events_LastationBlog.Outcomes[1].CanFunc = (
		function(pPlayer)
			if load(pPlayer, "Events_LastationBlog1") == nil then
				local iCulture = math.ceil(10 * iMod)
				Events_LastationBlog.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LASTATION_BLOG_OUTCOME_1_RESULT", iCulture)
				return true
			end
		end
		)
	Events_LastationBlog.Outcomes[1].DoFunc = (
		function(pPlayer)
		
			local iCulture = math.ceil(10 * iMod)
			pPlayer:ChangeJONSCulture(iCulture * pPlayer:GetTotalPopulation())
			
			save(pPlayer, "Events_LastationBlog1", true)
			local iTimes = load(pPlayer, "Events_LastationBlog")
			if not iTimes then
				save(pPlayer, "Events_LastationBlog", 1)
			else
				save(pPlayer, "Events_LastationBlog", iTimes + 1)
			end
			
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LASTATION_BLOG_OUTCOME_NOTIFICATION"), Locale.ConvertTextKey(Events_LastationBlog.Name))
		end
		)
		
	--=========================================================
	-- Outcome 2
	--=========================================================
	Events_LastationBlog.Outcomes[2] = {}
	Events_LastationBlog.Outcomes[2].Name = "TXT_KEY_EVENT_VV_LASTATION_BLOG_OUTCOME_2"
	Events_LastationBlog.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LASTATION_BLOG_OUTCOME_2_RESULT")
	Events_LastationBlog.Outcomes[2].CanFunc = (
		function(pPlayer)
			if load(pPlayer, "Events_LastationBlog2") == nil then
				local iCulture = math.ceil(5 * iMod)
				Events_LastationBlog.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LASTATION_BLOG_OUTCOME_2_RESULT", iCulture)
				return true
			end
		end
		)
	Events_LastationBlog.Outcomes[2].DoFunc = (
		function(pPlayer)
		
			local iCulture = math.ceil(5 * iMod)
			local iTotalCulture = 0
			local iPlayer = pPlayer:GetID()
			
			for pCity in pPlayer:Cities() do
				local iNumPlots = pCity:GetNumCityPlots();
				for iPlot = 0, iNumPlots - 1 do
					local pPlot = pCity:GetCityIndexPlot(iPlot)
					if pPlot and pPlot:GetOwner() == iPlayer then
						local iFeature = pPlot:GetFeatureType()
						if iFeature == GameInfoTypes.FEATURE_FOREST or iFeature == GameInfoTypes.FEATURE_JUNGLE then
							iTotalCulture = iTotalCulture + iCulture
						end
					end
				end
			end
			
			pPlayer:ChangeJONSCulture(iTotalCulture)
			
			save(pPlayer, "Events_LastationBlog2", true)
			local iTimes = load(pPlayer, "Events_LastationBlog")
			if not iTimes then
				save(pPlayer, "Events_LastationBlog", 1)
			else
				save(pPlayer, "Events_LastationBlog", iTimes + 1)
			end
			
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LASTATION_BLOG_OUTCOME_NOTIFICATION"), Locale.ConvertTextKey(Events_LastationBlog.Name))
		end
		)
		
	--=========================================================
	-- Outcome 3
	--=========================================================
	Events_LastationBlog.Outcomes[3] = {}
	Events_LastationBlog.Outcomes[3].Name = "TXT_KEY_EVENT_VV_LASTATION_BLOG_OUTCOME_3"
	Events_LastationBlog.Outcomes[3].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LASTATION_BLOG_OUTCOME_3_RESULT")
	Events_LastationBlog.Outcomes[3].CanFunc = (
		function(pPlayer)
			if load(pPlayer, "Events_LastationBlog3") == nil then
				local iGold = math.ceil(100 * iMod)
				Events_LastationBlog.Outcomes[3].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LASTATION_BLOG_OUTCOME_3_RESULT", iGold)
				return true
			end
		end
		)
	Events_LastationBlog.Outcomes[3].DoFunc = (
		function(pPlayer)
		
			pPlayer:ChangeNumFreeGreatPeople(1)
			
			save(pPlayer, "Events_LastationBlog3", true)
			local iTimes = load(pPlayer, "Events_LastationBlog")
			if not iTimes then
				save(pPlayer, "Events_LastationBlog", 1)
			else
				save(pPlayer, "Events_LastationBlog", iTimes + 1)
			end
			
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LASTATION_BLOG_OUTCOME_NOTIFICATION"), Locale.ConvertTextKey(Events_LastationBlog.Name))
		end
		)
		
	--=========================================================
	-- Outcome 4
	--=========================================================
	Events_LastationBlog.Outcomes[4] = {}
	Events_LastationBlog.Outcomes[4].Name = "TXT_KEY_EVENT_VV_LASTATION_BLOG_OUTCOME_4"
	Events_LastationBlog.Outcomes[4].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LASTATION_BLOG_OUTCOME_4_RESULT")
	Events_LastationBlog.Outcomes[4].CanFunc = (
		function(pPlayer)
			if load(pPlayer, "Events_LastationBlog4") == nil then
				return true
			end
		end
		)
	Events_LastationBlog.Outcomes[4].DoFunc = (
		function(pPlayer)
		
			for pUnit in pPlayer:Units() do
				if pUnit:IsCombatUnit() or pUnit:GetDomainType() == DomainTypes.DOMAIN_AIR then
					pUnit:ChangeExperience(10)
				end
			end

			save(pPlayer, "Events_LastationBlog4", true)
			local iTimes = load(pPlayer, "Events_LastationBlog")
			if not iTimes then
				save(pPlayer, "Events_LastationBlog", 1)
			else
				save(pPlayer, "Events_LastationBlog", iTimes + 1)
			end
			
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LASTATION_BLOG_OUTCOME_NOTIFICATION"), Locale.ConvertTextKey(Events_LastationBlog.Name))
		end
		)
		
		
	--=========================================================
	-- Outcome 5
	--=========================================================
	Events_LastationBlog.Outcomes[5] = {}
	Events_LastationBlog.Outcomes[5].Name = "TXT_KEY_EVENT_VV_LASTATION_BLOG_OUTCOME_5"
	Events_LastationBlog.Outcomes[5].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LASTATION_BLOG_OUTCOME_5_RESULT")
	Events_LastationBlog.Outcomes[5].CanFunc = (
		function(pPlayer)
			if load(pPlayer, "Events_LastationBlog5") == nil then
				return true
			end
		end
		)
	Events_LastationBlog.Outcomes[5].DoFunc = (
		function(pPlayer)
		
			pPlayer:ChangeGoldenAgeTurns(pPlayer:GetGoldenAgeLength())

			save(pPlayer, "Events_LastationBlog5", true)
			local iTimes = load(pPlayer, "Events_LastationBlog")
			if not iTimes then
				save(pPlayer, "Events_LastationBlog", 1)
			else
				save(pPlayer, "Events_LastationBlog", iTimes + 1)
			end
			
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_LASTATION_BLOG_OUTCOME_NOTIFICATION"), Locale.ConvertTextKey(Events_LastationBlog.Name))
		end
		)

for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Events_LastationBlog.tValidCivs[sCiv] then
			tEvents.Events_LastationBlog = Events_LastationBlog
			break
		end
	end
end


