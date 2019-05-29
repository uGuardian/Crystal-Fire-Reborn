-- Planeptunemk2Events
-- Author: Vice
-- DateCreated: 3/23/2015 9:50:52 PM
--------------------------------------------------------------

local PRODUCTION_SPEED_MOD = GameInfo.GameSpeeds[PreGame.GetGameSpeed()].ConstructPercent / 100
local CULTURE_SPEED_MOD = GameInfo.GameSpeeds[PreGame.GetGameSpeed()].CulturePercent / 100


--------------------------------------------------------------------------------------------------------------------------
-- Love Letter
--------------------------------------------------------------------------------------------------------------------------
local Event_Planeptunemk2LoveLetter = {}
    Event_Planeptunemk2LoveLetter.Name = "TXT_KEY_EVENT_VV_PLANEPTUNE_NG_LOVE_LETTER"
	Event_Planeptunemk2LoveLetter.Desc = "TXT_KEY_EVENT_VV_PLANEPTUNE_NG_LOVE_LETTER_DESC"
	Event_Planeptunemk2LoveLetter.tValidCivs = 
		{
		["CIVILIZATION_VV_PLANEPTUNE_NG"]		= true,
		["CIVILIZATION_VV_PLANEPTUNE_PS"]	= true
		}
	Event_Planeptunemk2LoveLetter.Weight = 20
	Event_Planeptunemk2LoveLetter.CanFunc = (
		function(pPlayer)
			if not pPlayer:GetCapitalCity() then return false end
			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			return Event_Planeptunemk2LoveLetter.tValidCivs[sCivType]
		end
		)
	Event_Planeptunemk2LoveLetter.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_Planeptunemk2LoveLetter.Outcomes[1] = {}
	Event_Planeptunemk2LoveLetter.Outcomes[1].Name = "TXT_KEY_EVENT_VV_PLANEPTUNE_NG_LOVE_LETTER_OUTCOME_1"
	Event_Planeptunemk2LoveLetter.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_NG_LOVE_LETTER_OUTCOME_1_RESULT")
	Event_Planeptunemk2LoveLetter.Outcomes[1].CanFunc = (
		function(pPlayer)
			local iCulture = math.floor(50 + (100 * (pPlayer:GetCurrentEra() * 2)) * CULTURE_SPEED_MOD)
			Event_Planeptunemk2LoveLetter.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_NG_LOVE_LETTER_OUTCOME_1_RESULT", iCulture)
			return true
		end
		)
	Event_Planeptunemk2LoveLetter.Outcomes[1].DoFunc = (
		function(pPlayer)
			local iCulture = math.floor(50 + (100 * (pPlayer:GetCurrentEra() * 2)) * CULTURE_SPEED_MOD)
			pPlayer:ChangeJONSCulture(iCulture)
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_NG_LOVE_LETTER_OUTCOME_1_NOTIFICATION"), Locale.ConvertTextKey(Event_Planeptunemk2LoveLetter.Name))
		end
		)

	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_Planeptunemk2LoveLetter.Outcomes[2] = {}
	Event_Planeptunemk2LoveLetter.Outcomes[2].Name = "TXT_KEY_EVENT_VV_PLANEPTUNE_NG_LOVE_LETTER_OUTCOME_2"
	Event_Planeptunemk2LoveLetter.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_NG_LOVE_LETTER_OUTCOME_2_RESULT")
	Event_Planeptunemk2LoveLetter.Outcomes[2].CanFunc = (
		function(pPlayer)
			local iCulture = math.floor(50 + (100 * (pPlayer:GetCurrentEra() * 2)) * CULTURE_SPEED_MOD)
			if pPlayer:GetJONSCulture() >= iCulture then
				local iShares = math.floor(200 + (100 * (pPlayer:GetCurrentEra() * 2)) * PRODUCTION_SPEED_MOD)
				Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_NG_LOVE_LETTER_OUTCOME_2_RESULT", iCulture, iShares)
				return true
			else
				return false
			end
		end
		)
	Event_Planeptunemk2LoveLetter.Outcomes[2].DoFunc = (
		function(pPlayer)
			local iCulture = math.floor(50 + (100 * (pPlayer:GetCurrentEra() * 2)) * CULTURE_SPEED_MOD)
			pPlayer:ChangeJONSCulture(-iCulture)
			local iShares = math.floor(200 + (100 * (pPlayer:GetCurrentEra() * 2)) * PRODUCTION_SPEED_MOD)
			LuaEvents.HDNChangeShares(pPlayer:GetID(), iShares)
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_NG_LOVE_LETTER_OUTCOME_2_NOTIFICATION"), Locale.ConvertTextKey(Event_Planeptunemk2LoveLetter.Name))
		end
		)

for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_Planeptunemk2LoveLetter.tValidCivs[sCiv] then
			tEvents.Event_Planeptunemk2LoveLetter = Event_Planeptunemk2LoveLetter
			break
		end
	end
end


--------------------------------------------------------------------------------------------------------------------------
-- Out of Batteries
--------------------------------------------------------------------------------------------------------------------------
local Event_Planeptunemk2Batteries = {}
    Event_Planeptunemk2Batteries.Name = "TXT_KEY_EVENT_VV_PLANEPTUNE_NG_BATTERIES"
	Event_Planeptunemk2Batteries.Desc = "TXT_KEY_EVENT_VV_PLANEPTUNE_NG_BATTERIES_DESC"
	Event_Planeptunemk2Batteries.Data1 = {}
	Event_Planeptunemk2Batteries.Data2 = nil
	Event_Planeptunemk2Batteries.Data3 = nil
	Event_Planeptunemk2Batteries.tValidCivs = 
		{
		["CIVILIZATION_VV_PLANEPTUNE_NG"]		= true,
		["CIVILIZATION_VV_PLANEPTUNE_PS"]	= true
		}
	Event_Planeptunemk2Batteries.Weight = 20
	Event_Planeptunemk2Batteries.CanFunc = (
		function(pPlayer)
			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			if Event_Planeptunemk2Batteries.tValidCivs[sCivType] then
				local pCapital = pPlayer:GetCapitalCity()
				if pCapital and (pCapital:GetProductionUnit() or pCapital:GetProductionBuilding()) then
					return true
				end
			end
		end
		)
	Event_Planeptunemk2Batteries.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_Planeptunemk2Batteries.Outcomes[1] = {}
	Event_Planeptunemk2Batteries.Outcomes[1].Name = "TXT_KEY_EVENT_VV_PLANEPTUNE_NG_BATTERIES_OUTCOME_1"
	Event_Planeptunemk2Batteries.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_NG_BATTERIES_OUTCOME_1_RESULT")
	Event_Planeptunemk2Batteries.Outcomes[1].CanFunc = (
		function(pPlayer)
			local iProductionLoss = math.floor(20 + (12 * (pPlayer:GetCurrentEra() * 2)) * PRODUCTION_SPEED_MOD)
			Event_Planeptunemk2Batteries.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_NG_BATTERIES_OUTCOME_1_RESULT", iProductionLoss)
			return true
		end
		)
	Event_Planeptunemk2Batteries.Outcomes[1].DoFunc = (
		function(pPlayer)
			local iProductionLoss = math.floor(20 + (12 * (pPlayer:GetCurrentEra() * 2)) * PRODUCTION_SPEED_MOD)
			local pCapital = pPlayer:GetCapitalCity()
			pCapital:ChangeProduction(-iProductionLoss)
			if pCapital:GetProduction() < 0 then pCapital:SetProduction(0) end
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_NG_BATTERIES_OUTCOME_1_NOTIFICATION"), Locale.ConvertTextKey(Event_Planeptunemk2Batteries.Name))
		end
		)


for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_Planeptunemk2Batteries.tValidCivs[sCiv] then
			tEvents.Event_Planeptunemk2Batteries = Event_Planeptunemk2Batteries
			break
		end
	end
end


--------------------------------------------------------------------------------------------------------------------------
-- Old Sword in the Ruins
-- This event triggers the turn after the player finds their first Ancient Ruin.
-- If the player chooses to keep the sword, they will be plagued by war and bloodshed...
--------------------------------------------------------------------------------------------------------------------------
local Event_Planeptunemk2FindGehaburn = {}
    Event_Planeptunemk2FindGehaburn.Name = "TXT_KEY_EVENT_VV_PLANEPTUNE_NG_FIND_EVIL_SWORD"
	Event_Planeptunemk2FindGehaburn.Desc = "TXT_KEY_EVENT_VV_PLANEPTUNE_NG_FIND_EVIL_SWORD_DESC"
	Event_Planeptunemk2FindGehaburn.Weight = 0
	Event_Planeptunemk2FindGehaburn.tValidCivs = 
		{
		["CIVILIZATION_VV_PLANEPTUNE_NG"]		= true,
		["CIVILIZATION_VV_PLANEPTUNE_PS"]		= true
		}
	Event_Planeptunemk2FindGehaburn.Weight = 0
	Event_Planeptunemk2FindGehaburn.CanFunc = (
		function(pPlayer)
			if load(pPlayer, "Event_Planeptunemk2FindGehaburn") then return false end
			local pCapital = pPlayer:GetCapitalCity()
			if pCapital then
				local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
				return Event_Planeptunemk2FindGehaburn.tValidCivs[sCivType]
			end
			return false
		end
		)
	Event_Planeptunemk2FindGehaburn.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_Planeptunemk2FindGehaburn.Outcomes[1] = {}
	Event_Planeptunemk2FindGehaburn.Outcomes[1].Name = "TXT_KEY_EVENT_VV_PLANEPTUNE_NG_FIND_EVIL_SWORD_OUTCOME_1"
	Event_Planeptunemk2FindGehaburn.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_NG_FIND_EVIL_SWORD_OUTCOME_1_RESULT")
	Event_Planeptunemk2FindGehaburn.Outcomes[1].CanFunc = (
		function(pPlayer)
			--Smaller chance for this being available for AIs to choose
			if not pPlayer:IsHuman() then
				if GetRandom(1, 100) <= 15 then
					return false
				end
			end
			return true
		end
		)
	Event_Planeptunemk2FindGehaburn.Outcomes[1].DoFunc = (
		function(pPlayer, pCity)
			local pCapital = pPlayer:GetCapitalCity()
			pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_EVENTS_VV_PLANEPTUNE_NG_GEHABURN_1, 1, true)
			save(pPlayer, "Event_Planeptunemk2FindGehaburn", 1)
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_NG_FIND_EVIL_SWORD_OUTCOME_1_NOTIFICATION"), Locale.ConvertTextKey(Event_Planeptunemk2FindGehaburn.Name))
		end
		)

	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_Planeptunemk2FindGehaburn.Outcomes[2] = {}
	Event_Planeptunemk2FindGehaburn.Outcomes[2].Name = "TXT_KEY_EVENT_VV_PLANEPTUNE_NG_FIND_EVIL_SWORD_OUTCOME_2"
	Event_Planeptunemk2FindGehaburn.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_NG_FIND_EVIL_SWORD_OUTCOME_2_RESULT")
	Event_Planeptunemk2FindGehaburn.Outcomes[2].CanFunc = (
		function(pPlayer)
			--Smaller chance for this being available for AIs to choose
			if not pPlayer:IsHuman() then
				if GetRandom(1, 100) <= 15 then
					return false
				end
			end
			return true
		end
		)
	Event_Planeptunemk2FindGehaburn.Outcomes[2].DoFunc = (
		function(pPlayer, pCity)
			local pCapital = pPlayer:GetCapitalCity()
			pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_EVENTS_VV_PLANEPTUNE_NG_GEHABURN_2, 1, true)
			save(pPlayer, "Event_Planeptunemk2FindGehaburn", 1)
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_NG_FIND_EVIL_SWORD_OUTCOME_2_NOTIFICATION"), Locale.ConvertTextKey(Event_Planeptunemk2FindGehaburn.Name))
		end
		)

	--=========================================================
	-- Outcome 3
	--=========================================================
	Event_Planeptunemk2FindGehaburn.Outcomes[3] = {}
	Event_Planeptunemk2FindGehaburn.Outcomes[3].Name = "TXT_KEY_EVENT_VV_PLANEPTUNE_NG_FIND_EVIL_SWORD_OUTCOME_3"
	Event_Planeptunemk2FindGehaburn.Outcomes[3].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_NG_FIND_EVIL_SWORD_OUTCOME_3_RESULT")
	Event_Planeptunemk2FindGehaburn.Outcomes[3].CanFunc = (
		function(pPlayer)
			return true
		end
		)
	Event_Planeptunemk2FindGehaburn.Outcomes[3].DoFunc = (
		function(pPlayer, pCity)
			save(pPlayer, "Event_Planeptunemk2FindGehaburn", 2)
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_NG_FIND_EVIL_SWORD_OUTCOME_3_NOTIFICATION"), Locale.ConvertTextKey(Event_Planeptunemk2FindGehaburn.Name))
		end
		)

for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_Planeptunemk2FindGehaburn.tValidCivs[sCiv] then
			tEvents.Event_Planeptunemk2FindGehaburn = Event_Planeptunemk2FindGehaburn
			break
		end
	end
end



--Table of every plot which contains a goody hut. This will be used by the UnitSetXY function to determine when a unit has opened the goody hut.
local tGoodyHuts = {}

function VV_Nepgear_RefreshGoodyHutLocations()
	for iPlot = 0, Map:GetNumPlots() - 1 do
		local pPlot = Map.GetPlotByIndex(iPlot)
		if pPlot:GetImprovementType() == GameInfoTypes.IMPROVEMENT_GOODY_HUT then
			tGoodyHuts[#tGoodyHuts + 1] = {
				["X"] = pPlot:GetX(),
				["Y"] = pPlot:GetY()
			}
		end
	end
end

Events.LoadScreenClose.Add(VV_Nepgear_RefreshGoodyHutLocations)


function VV_Nepgear_OnUnitSetXY(iPlayer, iUnit, iX, iY)
	if iX > 0 and iY > 0 and iPlayer < GameDefines.MAX_MAJOR_CIVS then --CS and Barbs can't take Goody Huts
		local iRemoveKey;
		for k, v in pairs(tGoodyHuts) do
			if v.X == iX and v.Y == iY then
				local pPlayer = Players[iPlayer]
				if not load(pPlayer, "Event_Planeptunemk2FindGehaburn") then
					local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
					if Event_Planeptunemk2FindGehaburn.tValidCivs[sCivType] then
						print("Triggered event scheduler for Gehaburn event.")
						LuaEvents.ScheduleEvent(iPlayer, "Event_Planeptunemk2FindGehaburn", Game:GetGameTurn() + 1, false)
					end		
					--The entry should be removed from the table REGARDLESS of which major took the goody!
				end
				iRemoveKey = k
			end
		end
		if iRemoveKey then
			table.remove(tGoodyHuts, iRemoveKey)
		end
	end
end

GameEvents.UnitSetXY.Add(VV_Nepgear_OnUnitSetXY)


--------------------------------------------------------------------------------------------------------------------------
-- The Sword's Thirst
--------------------------------------------------------------------------------------------------------------------------

local Event_Planeptunemk2SwordThirst = {}
    Event_Planeptunemk2SwordThirst.Name = "TXT_KEY_EVENT_VV_PLANEPTUNE_NG_SWORD_THIRST"
	Event_Planeptunemk2SwordThirst.Desc = "TXT_KEY_EVENT_VV_PLANEPTUNE_NG_SWORD_THIRST_DESC"
	Event_Planeptunemk2SwordThirst.tValidCivs = 
		{
		["CIVILIZATION_VV_PLANEPTUNE_NG"]		= true,
		["CIVILIZATION_VV_PLANEPTUNE_PS"]		= true
		}
	Event_Planeptunemk2SwordThirst.Weight = 750
	Event_Planeptunemk2SwordThirst.Data1 = nil
	Event_Planeptunemk2SwordThirst.CanFunc = (
		function(pPlayer)
			if pPlayer:GetNumCities() < 1 then return end
			if load(pPlayer, "Event_Planeptunemk2FindGehaburn") and load(pPlayer, "Event_Planeptunemk2FindGehaburn") == 1 then
				local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
				local pTeam = Teams[pPlayer:GetTeam()]
				local tValidCivs = {}
				local iLoopToNumber = GameDefines.MAX_MAJOR_CIVS - 1
				if load(pPlayer, "Event_Planeptunemk2SwordThirst") then
					iLoopToNumber = GameDefines.MAX_CIV_PLAYERS - 1
				end
				for i = 0, iLoopToNumber, 1 do
					if i ~= pPlayer:GetID() then
						local pLoop = Players[i]
						local iLoopTeam = pLoop:GetTeam()
						if pLoop:IsAlive() and pTeam:IsHasMet(iLoopTeam) and pTeam:GetID() ~= pLoop:GetTeam() and not pTeam:IsPermanentWarPeace(iLoopTeam)then
							tValidCivs[#tValidCivs + 1] = pLoop
						end
					end
				end
				if #tValidCivs > 0 then
					Event_Planeptunemk2SwordThirst.Data1 = tValidCivs[GetRandom(1, #tValidCivs)]
					if load(pPlayer, "Event_Planeptunemk2SwordThirst") then
						if Event_Planeptunemk2SwordThirst.Data1:IsMinorCiv() then
							Event_Planeptunemk2SwordThirst.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_NG_SWORD_THIRST_CITY_STATE_DESC", Event_Planeptunemk2SwordThirst.Data1:GetCivilizationShortDescription())
						else
							Event_Planeptunemk2SwordThirst.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_NG_SWORD_THIRST_REPEAT_DESC", Event_Planeptunemk2SwordThirst.Data1:GetName())
						end
					else
						Event_Planeptunemk2SwordThirst.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_NG_SWORD_THIRST_DESC", Event_Planeptunemk2SwordThirst.Data1:GetName())
					end
					return Event_Planeptunemk2SwordThirst.tValidCivs[sCivType]
				end
			end
			return false
		end
		)
	Event_Planeptunemk2SwordThirst.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_Planeptunemk2SwordThirst.Outcomes[1] = {}
	Event_Planeptunemk2SwordThirst.Outcomes[1].Name = "TXT_KEY_EVENT_VV_PLANEPTUNE_NG_SWORD_THIRST_OUTCOME_1"
	Event_Planeptunemk2SwordThirst.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_NG_SWORD_THIRST_OUTCOME_1_RESULT")
	Event_Planeptunemk2SwordThirst.Outcomes[1].CanFunc = (
		function(pPlayer, pOtherPlayer)
			if load(pPlayer, "Event_Planeptunemk2SwordThirst") then
				if pOtherPlayer:IsMinorCiv() then
					Event_Planeptunemk2SwordThirst.Outcomes[1].Name = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_NG_SWORD_THIRST_OUTCOME_CITY_STATE_1")
				else
					Event_Planeptunemk2SwordThirst.Outcomes[1].Name = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_NG_SWORD_THIRST_OUTCOME_1")
				end
			else
				Event_Planeptunemk2SwordThirst.Outcomes[1].Name = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_NG_SWORD_THIRST_OUTCOME_REPEAT_1")
			end
			if pOtherPlayer:IsMinorCiv() then
				Event_Planeptunemk2SwordThirst.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_NG_SWORD_THIRST_CITY_STATE_OUTCOME_1_RESULT", pOtherPlayer:GetCivilizationShortDescription())
			else
				Event_Planeptunemk2SwordThirst.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_NG_SWORD_THIRST_OUTCOME_1_RESULT", pOtherPlayer:GetCivilizationShortDescription())
			end
			return true
		end
		)
	Event_Planeptunemk2SwordThirst.Outcomes[1].DoFunc = (
		function(pPlayer, pOtherPlayer)
			local pTeam = Teams[pPlayer:GetTeam()]
			local iTheirTeam = pOtherPlayer:GetTeam()
			if not pTeam:IsAtWar(iTheirTeam) then
				pTeam:DeclareWar(iTheirTeam)
			end
			pTeam:SetPermanentWarPeace(iTheirTeam, true)
			Teams[iTheirTeam]:SetPermanentWarPeace(pTeam:GetID(), true)
			
			if load(pPlayer, "Event_Planeptunemk2SwordThirst") then
				JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_NG_SWORD_THIRST_REPEAT_OUTCOME_1_NOTIFICATION"), Locale.ConvertTextKey(Event_Planeptunemk2SwordThirst.Name))
			else
				JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_NG_SWORD_THIRST_OUTCOME_1_NOTIFICATION"), Locale.ConvertTextKey(Event_Planeptunemk2SwordThirst.Name))
			end	
			
			save(pPlayer, "Event_Planeptunemk2SwordThirst", 10)
			JFD_SendNotification(pOtherPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_NG_SWORD_THIRST_OUTCOME_1_NOTIFICATION_OTHER_PLAYER", pPlayer:GetName()), Locale.ConvertTextKey(Event_Planeptunemk2SwordThirst.Name))
		end
		)

	Event_Planeptunemk2SwordThirst.Outcomes[1].Monitors = {}
	Event_Planeptunemk2SwordThirst.Outcomes[1].Monitors[GameEvents.GetScenarioDiploModifier2] = (
	function(iPlayer1, iPlayer2)
		local pPlayer1 = Players[iPlayer1]
		local pPlayer2 = Players[iPlayer2]
		if load(pPlayer1, "Event_Planeptunemk2SwordThirst") then
			return load(pPlayer1, "Event_Planeptunemk2SwordThirst")
		elseif load(pPlayer2, "Event_Planeptunemk2SwordThirst") then
			return load(pPlayer2, "Event_Planeptunemk2SwordThirst")
		end
		return 0
	end
	)
	Event_Planeptunemk2SwordThirst.Outcomes[1].Monitors[GameEvents.PlayerDoTurn] = (
	function(iPlayer)
		local pPlayer = Players[iPlayer]
		local pCapital = pPlayer:GetCapitalCity()
		if pCapital and load(pPlayer, "Event_Planeptunemk2SwordThirst") then
			local iTeam = pPlayer:GetTeam()
			local iNumConquestedCivs = 0
			for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
				if i ~= iPlayer then
					local pLoop = Players[i]
					if pLoop:GetTeam() ~= iTeam and not pLoop:IsAlive() and pLoop:IsEverAlive() and pLoop:IsCapitalCapturedBy(iPlayer) and Teams[pLoop:GetTeam()]:IsPermanentWarPeace(iTeam) then
						iNumConquestedCivs = iNumConquestedCivs + 1
					end
				end
			end
			pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_EVENTS_VV_NEPGEAR_CONQUEST_BONUS, iNumConquestedCivs, true)
		end
	end
	)

for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_Planeptunemk2SwordThirst.tValidCivs[sCiv] then
			tEvents.Event_Planeptunemk2SwordThirst = Event_Planeptunemk2SwordThirst
			break
		end
	end
end




--------------------------------------------------------------------------------------------------------------------------
-- The End of Conflict
--------------------------------------------------------------------------------------------------------------------------

local Event_Planeptunemk2ConquestEnd = {}
    Event_Planeptunemk2ConquestEnd.Name = "TXT_KEY_EVENT_VV_PLANEPTUNE_NG_CONQUEST_ENDING"
	Event_Planeptunemk2ConquestEnd.Desc = "TXT_KEY_EVENT_VV_PLANEPTUNE_NG_CONQUEST_ENDING_DESC"
	Event_Planeptunemk2ConquestEnd.tValidCivs = 
		{
		["CIVILIZATION_VV_PLANEPTUNE_NG"]		= true,
		["CIVILIZATION_VV_PLANEPTUNE_PS"]		= true
		}
	Event_Planeptunemk2ConquestEnd.Weight = 50000
	Event_Planeptunemk2ConquestEnd.Data1 = nil
	Event_Planeptunemk2ConquestEnd.CanFunc = (
		function(pPlayer)
			if load(pPlayer, "Event_Planeptunemk2ConquestEnd") then return false end
			if load(pPlayer, "Event_Planeptunemk2FindGehaburn") and load(pPlayer, "Event_Planeptunemk2FindGehaburn") == 1 then
				local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
				local pTeam = Teams[pPlayer:GetTeam()]
				local tValidCivs = {}
				for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
					if i ~= pPlayer:GetID() then
						local pLoop = Players[i]
						if pLoop:IsAlive() then
							return false
						end
					end
				end
			end
			return Event_Planeptunemk2SwordThirst.tValidCivs[sCivType]
		end
		)
	Event_Planeptunemk2ConquestEnd.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_Planeptunemk2ConquestEnd.Outcomes[1] = {}
	Event_Planeptunemk2ConquestEnd.Outcomes[1].Name = "TXT_KEY_EVENT_VV_PLANEPTUNE_NG_CONQUEST_ENDING_OUTCOME"
	Event_Planeptunemk2ConquestEnd.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_NG_CONQUEST_ENDING_OUTCOME_RESULT")
	Event_Planeptunemk2ConquestEnd.Outcomes[1].CanFunc = (
		function(pPlayer)
			return true
		end
		)
	Event_Planeptunemk2ConquestEnd.Outcomes[1].DoFunc = (
		function(pPlayer)
			save(pPlayer, "Event_Planeptunemk2ConquestEnd", true)
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_NG_CONQUEST_ENDING_OUTCOME_NOTIFICATION"), Locale.ConvertTextKey(Event_Planeptunemk2ConquestEnd.Name))
		end
		)
		
for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_Planeptunemk2ConquestEnd.tValidCivs[sCiv] then
			tEvents.Event_Planeptunemk2ConquestEnd = Event_Planeptunemk2ConquestEnd
			break
		end
	end
end



--Hijack the texture for the Victory Screen if Conquest Ending
function ConquestVictoryScreen(type, team)
	if team == Game:GetActiveTeam() and type == EndGameTypes.Domination then
		local iPlayer = Game:GetActivePlayer()
		local pPlayer = Players[iPlayer]
		if load(pPlayer, "Event_Planeptunemk2FindGehaburn") and load(pPlayer, "Event_Planeptunemk2FindGehaburn") == 1 then
			local image = ContextPtr:LookUpControl('/InGame/EndGameMenu/BackgroundImage')
			if image then
				image:SetTexture("NepgearConquestVictory.dds")
			end
		end
	end
end
Events.EndGameShow.Add( ConquestVictoryScreen );