-- ArmstrongEvents
-- Author: Vicevirtuoso
-- DateCreated: 9/11/2014 4:48:02 PM
--------------------------------------------------------------

local iRaiden = GameInfoTypes.UNIT_DECISIONS_ARMSTRONG_RAIDEN

--=======================================================================================================================
-- Event 1: Poor Straw Poll Results (Random)
--=======================================================================================================================
local Event_ArmstrongStrawPoll = {}
	Event_ArmstrongStrawPoll.Name = "TXT_KEY_EVENT_ARMSTRONG_STRAW_POLL"
	Event_ArmstrongStrawPoll.Desc = "TXT_KEY_EVENT_ARMSTRONG_STRAW_POLL_DESC"
	Event_ArmstrongStrawPoll.Weight = 10
	Event_ArmstrongStrawPoll.Data1 = nil
	Event_ArmstrongStrawPoll.tValidCivs = 
	{
		["CIVILIZATION_WORLD_MARSHAL"]		= true,
	}
	Event_ArmstrongStrawPoll.CanFunc = (
		function(pPlayer)		
			if Game.GetNumActiveLeagues() < 1 then return false end

			Event_ArmstrongStrawPoll.Data1 = math.ceil(20 * iMod)

			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			return Event_ArmstrongStrawPoll.tValidCivs[sCivType]
		end
		)
	Event_ArmstrongStrawPoll.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_ArmstrongStrawPoll.Outcomes[1] = {}
	Event_ArmstrongStrawPoll.Outcomes[1].Name = "TXT_KEY_EVENT_ARMSTRONG_STRAW_POLL_OUTCOME_1"
	Event_ArmstrongStrawPoll.Outcomes[1].Desc = "TXT_KEY_EVENT_ARMSTRONG_STRAW_POLL_OUTCOME_1_RESULT"
	Event_ArmstrongStrawPoll.Outcomes[1].Weight = 5
	Event_ArmstrongStrawPoll.Outcomes[1].CanFunc = (
		function(pPlayer, iTurns)	
		
			Event_ArmstrongStrawPoll.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_ARMSTRONG_STRAW_POLL_OUTCOME_1_RESULT", iTurns)	
				
			return true
		end
		)
	Event_ArmstrongStrawPoll.Outcomes[1].DoFunc = (
		function(pPlayer, iTurns) 


			if not MapModData.gArmstrongEventDelegateMod then
				MapModData.gArmstrongEventDelegateMod = {}
			end

			MapModData.gArmstrongEventDelegateMod.Multiplier = 0.5
			MapModData.gArmstrongEventDelegateMod.Turn = Game:GetGameTurn()
			MapModData.gArmstrongEventDelegateMod.Duration = iTurns

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_ARMSTRONG_STRAW_POLL_OUTCOME_RESULT_1_NOTIFICATION"), Locale.ConvertTextKey(Event_ArmstrongStrawPoll.Name))
		end
		)

	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_ArmstrongStrawPoll.Outcomes[2] = {}
	Event_ArmstrongStrawPoll.Outcomes[2].Name = "TXT_KEY_EVENT_ARMSTRONG_STRAW_POLL_OUTCOME_2"
	Event_ArmstrongStrawPoll.Outcomes[2].Desc = "TXT_KEY_EVENT_ARMSTRONG_STRAW_POLL_OUTCOME_2_RESULT"
	Event_ArmstrongStrawPoll.Outcomes[2].Weight = 5
	Event_ArmstrongStrawPoll.Outcomes[2].CanFunc = (
		function(pPlayer, iTurns)	
			local iGoldCost = math.ceil((400 + (200 * pPlayer:GetCurrentEra())) * iMod)

			Event_ArmstrongStrawPoll.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_ARMSTRONG_STRAW_POLL_OUTCOME_2_RESULT", iGoldCost, iTurns)		
						
			if pPlayer:GetGold() < iGoldCost then return false else return true end
		end
		)
	Event_ArmstrongStrawPoll.Outcomes[2].DoFunc = (
		function(pPlayer, iTurns) 

			local iGoldCost = math.ceil((400 + (200 * pPlayer:GetCurrentEra())) * iMod)
			pPlayer:ChangeGold(-iGoldCost)

			if not MapModData.gArmstrongEventDelegateMod then
				MapModData.gArmstrongEventDelegateMod = {}
			end

			MapModData.gArmstrongEventDelegateMod.Multiplier = 1.25
			MapModData.gArmstrongEventDelegateMod.Turn = Game:GetGameTurn()
			MapModData.gArmstrongEventDelegateMod.Duration = iTurns
			
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_ARMSTRONG_STRAW_POLL_OUTCOME_RESULT_2_NOTIFICATION"), Locale.ConvertTextKey(Event_ArmstrongStrawPoll.Name))
		end
		)

	--=========================================================
	-- Outcome 3
	--=========================================================
	Event_ArmstrongStrawPoll.Outcomes[3] = {}
	Event_ArmstrongStrawPoll.Outcomes[3].Name = "TXT_KEY_EVENT_ARMSTRONG_STRAW_POLL_OUTCOME_3"
	Event_ArmstrongStrawPoll.Outcomes[3].Desc = "TXT_KEY_EVENT_ARMSTRONG_STRAW_POLL_OUTCOME_3_RESULT"
	Event_ArmstrongStrawPoll.Outcomes[3].Weight = 5
	Event_ArmstrongStrawPoll.Outcomes[3].CanFunc = (
		function(pPlayer, iTurns)

			Event_ArmstrongStrawPoll.Outcomes[3].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_ARMSTRONG_STRAW_POLL_OUTCOME_3_RESULT", iTurns)

			for i = GameDefines.MAX_MAJOR_CIVS, GameDefines.MAX_CIV_PLAYERS - 1, 1 do
				local pCityState = Players[i]
				if pCityState:GetMinorCivFriendshipLevelWithMajor(pPlayer:GetID()) > 0 then
					return true
				end
			end		
				
			return false
		end
		)
	Event_ArmstrongStrawPoll.Outcomes[3].DoFunc = (
		function(pPlayer, iTurns) 

			for i = GameDefines.MAX_MAJOR_CIVS, GameDefines.MAX_CIV_PLAYERS - 1, 1 do
				local pCityState = Players[i]
				if pCityState:GetMinorCivFriendshipLevelWithMajor(pPlayer:GetID()) > 0 then
					pCityState:ChangeMinorCivFriendshipWithMajor(pPlayer:GetID(), -20)
				end
			end


			if not MapModData.gArmstrongEventDelegateMod then
				MapModData.gArmstrongEventDelegateMod = {}
			end

			MapModData.gArmstrongEventDelegateMod.Multiplier = 1.25
			MapModData.gArmstrongEventDelegateMod.Turn = Game:GetGameTurn()
			MapModData.gArmstrongEventDelegateMod.Duration = iTurns


			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_ARMSTRONG_STRAW_POLL_OUTCOME_RESULT_3_NOTIFICATION"), Locale.ConvertTextKey(Event_ArmstrongStrawPoll.Name))
		end
		)



for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_ArmstrongStrawPoll.tValidCivs[sCiv] then
			tEvents.Event_ArmstrongStrawPoll = Event_ArmstrongStrawPoll
			break
		end
	end
end



--=======================================================================================================================
-- Event 2: Johnson's New Reception Area (Scheduled for 1970)
--=======================================================================================================================

local Event_JohnsonsNewReceptionArea = {}
	Event_JohnsonsNewReceptionArea.Name = "TXT_KEY_EVENT_ARMSTRONG_JAPANESE"
	Event_JohnsonsNewReceptionArea.Desc = "TXT_KEY_EVENT_ARMSTRONG_JAPANESE_DESC"
	Event_JohnsonsNewReceptionArea.Weight = 25
	Event_JohnsonsNewReceptionArea.Data1 = nil
	Event_JohnsonsNewReceptionArea.tValidCivs = 
	{
		["CIVILIZATION_WORLD_MARSHAL"]		= true,
	}
	Event_JohnsonsNewReceptionArea.CanFunc = (
		function(pPlayer)

			if load(pPlayer, "Event_JohnsonsNewReceptionArea") == true then return false end

			local tJapaneseArtCivs = {}
			
			for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
				local pLoop = Players[i]
				if pLoop:IsAlive() and Teams[pLoop:GetTeam()]:IsHasMet(pPlayer:GetTeam()) then
					local sArtStyle = GameInfo.Civilizations[pLoop:GetCivilizationType()].ArtDefineTag
					if sArtStyle == "ART_DEF_CIVILIZATION_JAPAN" then
						tJapaneseArtCivs[#tJapaneseArtCivs + 1] = i
					end
				end
			end

			if #tJapaneseArtCivs <= 0 then return false end

			local iRand = Game.Rand(#tJapaneseArtCivs - 1, "WM Random Japanese Civ Roll") + 1

			Event_JohnsonsNewReceptionArea.Data1 = Players[tJapaneseArtCivs[iRand]]

			Event_JohnsonsNewReceptionArea.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_ARMSTRONG_JAPANESE_DESC", Event_JohnsonsNewReceptionArea.Data1:GetCivilizationAdjective())

			return true
		end
		)
	Event_JohnsonsNewReceptionArea.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_JohnsonsNewReceptionArea.Outcomes[1] = {}
	Event_JohnsonsNewReceptionArea.Outcomes[1].Name = "TXT_KEY_EVENT_ARMSTRONG_JAPANESE_OUTCOME_1"
	Event_JohnsonsNewReceptionArea.Outcomes[1].Desc = "TXT_KEY_EVENT_ARMSTRONG_JAPANESE_OUTCOME_RESULT_1"
	Event_JohnsonsNewReceptionArea.Outcomes[1].CanFunc = (
		function(pPlayer, pOtherPlayer)
			if pPlayer:IsDoF(pOtherPlayer:GetID()) then return false end

			Event_JohnsonsNewReceptionArea.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_ARMSTRONG_JAPANESE_OUTCOME_RESULT_1", pOtherPlayer:GetCivilizationShortDescription())

			return true
		end
		)
	Event_JohnsonsNewReceptionArea.Outcomes[1].DoFunc = (
		function(pPlayer, pOtherPlayer) 
			pPlayer:DoForceDoF(pOtherPlayer:GetID())

			save(pPlayer, "Event_JohnsonsNewReceptionArea", true)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_ARMSTRONG_JAPANESE_OUTCOME_RESULT_1_NOTIFICATION", pOtherPlayer:GetName()), Locale.ConvertTextKey("TXT_KEY_EVENT_ARMSTRONG_JAPANESE"))
		end)
	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_JohnsonsNewReceptionArea.Outcomes[2] = {}
	Event_JohnsonsNewReceptionArea.Outcomes[2].Name = "TXT_KEY_EVENT_ARMSTRONG_JAPANESE_OUTCOME_2"
	Event_JohnsonsNewReceptionArea.Outcomes[2].Desc = "TXT_KEY_EVENT_ARMSTRONG_JAPANESE_OUTCOME_RESULT_2"
	Event_JohnsonsNewReceptionArea.Outcomes[2].CanFunc = (
		function(pPlayer, pOtherPlayer)
			local iResistance = math.ceil(1 * iMod)

			local iCulture = math.ceil(3 * pPlayer:GetTotalJONSCulturePerTurn() * iMod)

			Event_JohnsonsNewReceptionArea.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_ARMSTRONG_JAPANESE_OUTCOME_RESULT_2", iResistance, iCulture)
					
			return true
		end
		)
	Event_JohnsonsNewReceptionArea.Outcomes[2].DoFunc = (
		function(pPlayer, pOtherPlayer) 
			local iResistance = math.ceil(1 * iMod)

			local iCulture = math.ceil(3 * pPlayer:GetTotalJONSCulturePerTurn() * iMod)

			pPlayer:ChangeJONSCulture(iCulture)

			local pCapital = pPlayer:GetCapitalCity()

			if pCapital then
				pCapital:ChangeResistanceTurns(iResistance)
			end

			save(pPlayer, "Event_JohnsonsNewReceptionArea", true)


			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_ARMSTRONG_JAPANESE_OUTCOME_RESULT_2_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_ARMSTRONG_JAPANESE"))
		end)
	
for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_JohnsonsNewReceptionArea.tValidCivs[sCiv] then
			tEvents.Event_JohnsonsNewReceptionArea = Event_JohnsonsNewReceptionArea
			break
		end
	end
end



--=======================================================================================================================
-- Event 3: Standing Here, He Realizes... (Scheduled for 2018)
--=======================================================================================================================

local Event_ArmstrongVSRaiden = {}
	Event_ArmstrongVSRaiden.Name = "TXT_KEY_EVENT_ARMSTRONG_RAIDEN"
	Event_ArmstrongVSRaiden.Desc = "TXT_KEY_EVENT_ARMSTRONG_RAIDEN_DESC"
	Event_ArmstrongVSRaiden.Weight = 0
	Event_ArmstrongVSRaiden.CanFunc = (
		function(pPlayer)			
			Event_ArmstrongVSRaiden.Desc = "TXT_KEY_EVENT_ARMSTRONG_RAIDEN_DESC"
			if not pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_WORLD_MARSHAL then return false end

			return true
		end
		)
	Event_ArmstrongVSRaiden.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_ArmstrongVSRaiden.Outcomes[1] = {}
	Event_ArmstrongVSRaiden.Outcomes[1].Name = "TXT_KEY_EVENT_ARMSTRONG_RAIDEN_OUTCOME_1"
	Event_ArmstrongVSRaiden.Outcomes[1].Desc = "TXT_KEY_EVENT_ARMSTRONG_RAIDEN_OUTCOME_RESULT_1"
	Event_ArmstrongVSRaiden.Outcomes[1].CanFunc = (
		function(pPlayer)			
			return true
		end
		)
	Event_ArmstrongVSRaiden.Outcomes[1].DoFunc = (
		function(pPlayer) 
			local pBarbarian = Players[GameDefines.MAX_CIV_PLAYERS]
			local pPlot = pPlayer:GetCapitalCity():Plot()

			local tPlotRandoms = {}
			for pAreaPlot in PlotRingIterator(pPlot, 2, 1, false) do
				if not pAreaPlot:IsUnit() and not pAreaPlot:IsImpassable() and not pAreaPlot:IsCity() then
					tPlotRandoms[#tPlotRandoms + 1] = pAreaPlot
				end
			end

			--No unitless plots to spawn on = spawn on the first plot given by PlotRingIterator even if there IS a unit on it
			if #tPlotRandoms == 0 then
				for pAreaPlot in PlotRingIterator(pPlot, 2, 1, false) do
					tPlotRandoms[1] = pAreaPlot
					break
				end
			end

			local pSpawnPlot = tPlotRandoms[Game.Rand(#tPlotRandoms - 1, "Armstrong Event Spawn Plot Roll") + 1]
			local pNewUnit = pBarbarian:InitUnit(iRaiden, pSpawnPlot:GetX(), pSpawnPlot:GetY(), UNITAI_ATTACK)
			
			pNewUnit:SetName("UNITNAME_DECISIONS_ARMSTRONG_RAIDEN")
			if pNewUnit:GetPlot():IsWater() then
				pNewUnit:Embark(pNewUnit:GetPlot())
			end

			GameEvents.UnitKilledInCombat.Add(OnRaidenKilled)
			GameEvents.PlayerDoTurn.Add(ItsTimeForJackToLetErRip)

			save(pPlayer, "Event_ArmstrongVSRaiden", true)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_ARMSTRONG_RAIDEN_OUTCOME_RESULT_1_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_ARMSTRONG_RAIDEN"))
		end
		)
		
Events_AddCivilisationSpecificScheduled(GameInfoTypes["CIVILIZATION_WORLD_MARSHAL"], "Event_ArmstrongVSRaiden", Event_ArmstrongVSRaiden, 2018, true)


function OnRaidenKilled(iKiller, iKilled, iUnitType)
	if iUnitType == iRaiden then
		local pKiller = Players[iKiller]
		if load(pKiller, "Event_ArmstrongVSRaiden") == true and iKilled == GameDefines.MAX_CIV_PLAYERS then
			local pPlot = pKiller:GetCapitalCity():Plot()
			if pPlot then
				local pNewUnit = pKiller:InitUnit(iRaiden, pPlot:GetX(), pPlot:GetY(), UNITAI_ATTACK)
				pNewUnit:SetName("UNITNAME_DECISIONS_ARMSTRONG_RAIDEN")
				JFD_SendNotification(pKiller:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_ARMSTRONG_RAIDEN_DEFEATED_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_ARMSTRONG_RAIDEN_DEFEATED_NOTIFICATION_TITLE"))
			end
		end
	end
end

function ItsTimeForJackToLetErRip(iPlayer)
	local pPlayer = Players[iPlayer]
	if pPlayer:IsAlive() then
		for pUnit in pPlayer:Units() do
			if pUnit:GetUnitType() == iRaiden then
				local iBaseStrength = GameInfo.Units[iRaiden].Combat
				if pUnit:GetCurrHitPoints() <= 25 then
					pUnit:SetBaseCombatStrength(iBaseStrength + 50)
					pUnit:SetName("UNITNAME_DECISIONS_ARMSTRONG_RAIDEN_2")
					pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, Locale.ConvertTextKey("TXT_KEY_ARMSTRONG_RAIDEN_JACK_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_ARMSTRONG_RAIDEN_JACK_NOTIFICATION_TITLE"), pUnit:GetX(), pUnit:GetY())
					for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
						local pLoop = Players[i]
						local iTeam = pLoop:GetTeam()
						if pLoop ~= pPlayer and Teams[iTeam]:IsAtWar(pPlayer:GetTeam()) and pUnit:GetPlot():IsVisible(iTeam) then
							pLoop:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, Locale.ConvertTextKey("TXT_KEY_ARMSTRONG_RAIDEN_JACK_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_ARMSTRONG_RAIDEN_JACK_NOTIFICATION_TITLE"), pUnit:GetX(), pUnit:GetY())
						end
					end
				else
					pUnit:SetBaseCombatStrength(iBaseStrength)
					pUnit:SetName("UNITNAME_DECISIONS_ARMSTRONG_RAIDEN")
				end
			end
		end
	end
end