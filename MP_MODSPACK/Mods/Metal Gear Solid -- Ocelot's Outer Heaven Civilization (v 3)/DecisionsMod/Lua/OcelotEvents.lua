-- OcelotEvents
-- Author: Vicevirtuoso
-- DateCreated: 9/11/2014 4:48:02 PM
--------------------------------------------------------------

--From http://snippets.luacode.org/snippets/Shuffle_array_145
function shuffled(tab)
	local n, order, res = #tab, {}, {}
 
	for i=1,n do order[i] = { rnd = Game.Rand(99, "Table Shuffler Roll"), idx = i } end
	table.sort(order, function(a,b) return a.rnd < b.rnd end)
	for i=1,n do res[i] = tab[order[i].idx] end

	return res
end


function OcelotTortureGood(pPlayer)
	LuaEvents.Sukritact_ChangeResearchProgress(pPlayer:GetID(), (pPlayer:GetScience() * math.ceil(3 * iMod)))
	pPlayer:ChangeJONSCulture(pPlayer:GetTotalJONSCulturePerTurn() * math.ceil(3 * iMod))
	local sString = Locale.ConvertTextKey("TXT_KEY_OCELOT_TORTURE_OUTCOME_RESULT_2_NOTIFICATION")
	return sString
end

function OcelotTortureNeutral(pPlayer)
	--currently does nothing
	local sString = Locale.ConvertTextKey("TXT_KEY_OCELOT_TORTURE_OUTCOME_RESULT_3_NOTIFICATION")
	return sString
end

function OcelotTortureBad(pPlayer)
	local pCapital = pPlayer:GetCapitalCity()
	local tBuildings = {}
	for building in GameInfo.Buildings() do
		if building.PrereqTech and building.Cost > -1 then
			if GameInfo.BuildingClasses("Type = '" ..building.BuildingClass.. "'")().MaxGlobalInstances ~= 1 and GameInfo.BuildingClasses("Type = '" ..building.BuildingClass.. "'")().MaxPlayerInstances ~= 1 then
				if pCapital:IsHasBuilding(building.ID) then
					tBuildings[#tBuildings + 1] = building.ID
				end
			end
		end
	end
	local iRand = Game.Rand(#tBuildings - 1, "Ocelot Building Loss Roll") + 1
	pCapital:SetNumRealBuilding(tBuildings[iRand], 0)
	local sString = Locale.ConvertTextKey("TXT_KEY_OCELOT_TORTURE_OUTCOME_RESULT_1_NOTIFICATION", Locale.ConvertTextKey(GameInfo.Buildings[tBuildings[iRand]].Description))
	return sString
end


--=======================================================================================================================
-- Event 1: Torture (Random)
--=======================================================================================================================
local Event_OcelotTorture = {}
	Event_OcelotTorture.Name = "TXT_KEY_EVENT_OCELOT_TORTURE"
	Event_OcelotTorture.Desc = "TXT_KEY_EVENT_OCELOT_TORTURE_DESC"
	Event_OcelotTorture.Weight = 10
	Event_OcelotTorture.Data1 = nil
	Event_OcelotTorture.tValidCivs = 
	{
		["CIVILIZATION_OUTER_HEAVEN"]		= true,
	}
	Event_OcelotTorture.CanFunc = (
		function(pPlayer)		
			local iEra = pPlayer:GetCurrentEra()
			if iEra < GameInfoTypes.ERA_MEDIEVAL then
				return false
			end

			local tPossibilities = {
				[1] = OcelotTortureGood,
				[2] = OcelotTortureNeutral,
				[3] = OcelotTortureBad
			}

			Event_OcelotTorture.Data1 = shuffled(tPossibilities)

			for k, v in pairs(Event_OcelotTorture.Data1) do
				print(k, v)
			end
			
			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			return Event_OcelotTorture.tValidCivs[sCivType]
		end
		)
	Event_OcelotTorture.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_OcelotTorture.Outcomes[1] = {}
	Event_OcelotTorture.Outcomes[1].Name = "TXT_KEY_EVENT_OCELOT_TORTURE_OUTCOME_1"
	Event_OcelotTorture.Outcomes[1].Desc = "TXT_KEY_EVENT_OCELOT_TORTURE_OUTCOME_RESULT"
	Event_OcelotTorture.Outcomes[1].Weight = 5
	Event_OcelotTorture.Outcomes[1].CanFunc = (
		function(pPlayer, tTable)			
			return true
		end
		)
	Event_OcelotTorture.Outcomes[1].DoFunc = (
		function(pPlayer, tTable) 

			local sString = tTable[1](pPlayer)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", sString, Locale.ConvertTextKey(Event_OcelotTorture.Name))
		end
		)

	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_OcelotTorture.Outcomes[2] = {}
	Event_OcelotTorture.Outcomes[2].Name = "TXT_KEY_EVENT_OCELOT_TORTURE_OUTCOME_2"
	Event_OcelotTorture.Outcomes[2].Desc = "TXT_KEY_EVENT_OCELOT_TORTURE_OUTCOME_RESULT"
	Event_OcelotTorture.Outcomes[2].Weight = 5
	Event_OcelotTorture.Outcomes[2].CanFunc = (
		function(pPlayer, tPossibilities)			
			return true
		end
		)
	Event_OcelotTorture.Outcomes[2].DoFunc = (
		function(pPlayer, tTable) 

			local sString = tTable[2](pPlayer)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", sString, Locale.ConvertTextKey(Event_OcelotTorture.Name))
		end
		)

	--=========================================================
	-- Outcome 3
	--=========================================================
	Event_OcelotTorture.Outcomes[3] = {}
	Event_OcelotTorture.Outcomes[3].Name = "TXT_KEY_EVENT_OCELOT_TORTURE_OUTCOME_3"
	Event_OcelotTorture.Outcomes[3].Desc = "TXT_KEY_EVENT_OCELOT_TORTURE_OUTCOME_RESULT"
	Event_OcelotTorture.Outcomes[3].Weight = 5
	Event_OcelotTorture.Outcomes[3].CanFunc = (
		function(pPlayer, tPossibilities)			
			return true
		end
		)
	Event_OcelotTorture.Outcomes[3].DoFunc = (
		function(pPlayer, tTable) 

			local sString = tTable[3](pPlayer)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", sString, Locale.ConvertTextKey(Event_OcelotTorture.Name))
		end
		)



for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_OcelotTorture.tValidCivs[sCiv] then
			tEvents.Event_OcelotTorture = Event_OcelotTorture
			break
		end
	end
end



--=======================================================================================================================
-- Event 2: Les Enfantes Terribles (Scheduled for 1970)
--=======================================================================================================================

local Event_LesEnfantsTerribles = {}
	Event_LesEnfantsTerribles.Name = "TXT_KEY_EVENT_OCELOT_LET"
	Event_LesEnfantsTerribles.Desc = "TXT_KEY_EVENT_OCELOT_LET_DESC"
	Event_LesEnfantsTerribles.Weight = 0
	Event_LesEnfantsTerribles.CanFunc = (
		function(pPlayer)			
			Event_LesEnfantsTerribles.Desc = "TXT_KEY_EVENT_OCELOT_LET_DESC"
			if not pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_OUTER_HEAVEN then return false end

			return true
		end
		)
	Event_LesEnfantsTerribles.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_LesEnfantsTerribles.Outcomes[1] = {}
	Event_LesEnfantsTerribles.Outcomes[1].Name = "TXT_KEY_EVENT_OCELOT_LET_OUTCOME_1"
	Event_LesEnfantsTerribles.Outcomes[1].Desc = "TXT_KEY_EVENT_OCELOT_LET_OUTCOME_RESULT_1"
	Event_LesEnfantsTerribles.Outcomes[1].CanFunc = (
		function(pPlayer)			
			return true
		end
		)
	Event_LesEnfantsTerribles.Outcomes[1].DoFunc = (
		function(pPlayer) 
			for pUnit in pPlayer:Units() do
				if pUnit:IsCombatUnit() then
					pUnit:ChangeExperience(10)
				end
			end

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_OCELOT_LET_OUTCOME_RESULT_1_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_OCELOT_LET"))
		end)
	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_LesEnfantsTerribles.Outcomes[2] = {}
	Event_LesEnfantsTerribles.Outcomes[2].Name = "TXT_KEY_EVENT_OCELOT_LET_OUTCOME_2"
	Event_LesEnfantsTerribles.Outcomes[2].Desc = "TXT_KEY_EVENT_OCELOT_LET_OUTCOME_RESULT_2"
	Event_LesEnfantsTerribles.Outcomes[2].CanFunc = (
		function(pPlayer)
			local iGold = math.ceil(1500 * iMod)

			Event_LesEnfantsTerribles.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_OCELOT_LET_OUTCOME_RESULT_2", iGold)

			if pPlayer:GetGold() < iGold then return false end
								
			return true
		end
		)
	Event_LesEnfantsTerribles.Outcomes[2].DoFunc = (
		function(pPlayer) 
			local iGold = math.ceil(1500 * iMod)
			pPlayer:ChangeGold(-iGold)

			save(pPlayer, "Event_LesEnfantsTerribles", true)


			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_OCELOT_LET_OUTCOME_RESULT_2_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_OCELOT_LET"))
		end)
	
Events_AddCivilisationSpecificScheduled(GameInfoTypes["CIVILIZATION_OUTER_HEAVEN"], "Event_LesEnfantsTerribles", Event_LesEnfantsTerribles, 1970, true)



--=======================================================================================================================
-- Event 3: Les Enfantes Terribles Complete (Scheduled for 1988 but only if Event 2 is passed with Outcome 2)
--=======================================================================================================================

local Event_LesEnfantsTerriblesComplete = {}
	Event_LesEnfantsTerriblesComplete.Name = "TXT_KEY_EVENT_OCELOT_LET_FINISHED"
	Event_LesEnfantsTerriblesComplete.Desc = "TXT_KEY_EVENT_OCELOT_LET_FINISHED_DESC"
	Event_LesEnfantsTerriblesComplete.Weight = 0
	Event_LesEnfantsTerriblesComplete.CanFunc = (
		function(pPlayer)			
			Event_LesEnfantsTerriblesComplete.Desc = "TXT_KEY_EVENT_OCELOT_LET_FINISHED_DESC"
			if not pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_OUTER_HEAVEN then return false end

			if not load(pPlayer, "Event_LesEnfantsTerribles") == true then return false end
			
			return true
		end
		)
	Event_LesEnfantsTerriblesComplete.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_LesEnfantsTerriblesComplete.Outcomes[1] = {}
	Event_LesEnfantsTerriblesComplete.Outcomes[1].Name = "TXT_KEY_EVENT_OCELOT_LET_FINISHED_OUTCOME_1"
	Event_LesEnfantsTerriblesComplete.Outcomes[1].Desc = "TXT_KEY_EVENT_OCELOT_LET_FINISHED_OUTCOME_RESULT_1"
	Event_LesEnfantsTerriblesComplete.Outcomes[1].CanFunc = (
		function(pPlayer)			
			return true
		end
		)
	Event_LesEnfantsTerriblesComplete.Outcomes[1].DoFunc = (
		function(pPlayer) 
			InitUnitFromCity(pPlayer:GetCapitalCity(), GameInfoTypes.UNIT_DECISIONS_OCELOT_LSO, 1)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_OCELOT_LET_FINISHED_OUTCOME_RESULT_1_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_OCELOT_LET_FINISHED"))
		end
		)
		
Events_AddCivilisationSpecificScheduled(GameInfoTypes["CIVILIZATION_OUTER_HEAVEN"], "Event_LesEnfantsTerriblesComplete", Event_LesEnfantsTerriblesComplete, 1988, true)