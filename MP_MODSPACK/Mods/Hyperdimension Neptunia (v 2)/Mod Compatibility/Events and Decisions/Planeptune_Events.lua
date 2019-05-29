-- PlaneptuneEvents
-- Author: Vice
--------------------------------------------------------------


local PRODUCTION_SPEED_MOD = GameInfo.GameSpeeds[PreGame.GetGameSpeed()].ConstructPercent / 100
local CULTURE_SPEED_MOD = GameInfo.GameSpeeds[PreGame.GetGameSpeed()].CulturePercent / 100

function ConvertToPercentString(value)
	if not value then value = 0 end
	value = value / 100
	return string.format("%.2f%%", value)
end

--------------------------------------------------------------------------------------------------------------------------
-- Abababababa!
--------------------------------------------------------------------------------------------------------------------------
local Event_PlaneptuneAbababa = {}
    Event_PlaneptuneAbababa.Name = "TXT_KEY_EVENT_VV_PLANEPTUNE_SHAKING_HISTY"
	Event_PlaneptuneAbababa.Desc = "TXT_KEY_EVENT_VV_PLANEPTUNE_SHAKING_HISTY_DESC"
	Event_PlaneptuneAbababa.tValidCivs = 
		{
		["CIVILIZATION_VV_PLANEPTUNE"]		= true,
		["CIVILIZATION_VV_PLANEPTUNE_PH"]	= true
		}
	Event_PlaneptuneAbababa.Weight = 9
	Event_PlaneptuneAbababa.EventImage = "Event_PlaneptuneAbababa.dds"
	Event_PlaneptuneAbababa.CanFunc = (
		function(pPlayer)
			if not pPlayer:GetCapitalCity() then return false end
			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			return Event_PlaneptuneAbababa.tValidCivs[sCivType]
		end
		)
	Event_PlaneptuneAbababa.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_PlaneptuneAbababa.Outcomes[1] = {}
	Event_PlaneptuneAbababa.Outcomes[1].Name = "TXT_KEY_EVENT_VV_PLANEPTUNE_SHAKING_HISTY_OUTCOME_1"
	Event_PlaneptuneAbababa.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_SHAKING_HISTY_OUTCOME_1_RESULT")
	Event_PlaneptuneAbababa.Outcomes[1].CanFunc = (
		function(pPlayer)
			local iShares = 50 + (25 * (pPlayer:GetCurrentEra() * 2))
			local iEnergy = 5 + (3 * (pPlayer:GetCurrentEra() * 2))
			Event_PlaneptuneAbababa.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_SHAKING_HISTY_OUTCOME_1_RESULT", ConvertToPercentString(iShares), iEnergy)
			if MapModData.HDNMod.Shares[pPlayer:GetID()] < iShares or pPlayer:GetLeaderType() == GameInfoTypes.LEADER_VV_PURPLE_HEART then
				return false
			else
				return true
			end
		end
		)
	Event_PlaneptuneAbababa.Outcomes[1].DoFunc = (
		function(pPlayer)
			local iShares = 50 + (25 * (pPlayer:GetCurrentEra() * 2))
			local iEnergy = 5 + (3 * (pPlayer:GetCurrentEra() * 2))
			LuaEvents.HDNChangeShares(pPlayer:GetID(), -iShares)
			LuaEvents.VV_ChangeHistyEnergy(pPlayer:GetID(), iEnergy)
			if pPlayer:GetID() == Game:GetActivePlayer() then
				Events.AudioPlay2DSound("AS2D_VV_HISTY_ABABABA")
			end
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_SHAKING_HISTY_OUTCOME_1_NOTIFICATION"), Locale.ConvertTextKey(Event_PlaneptuneAbababa.Name))
		end
		)

	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_PlaneptuneAbababa.Outcomes[2] = {}
	Event_PlaneptuneAbababa.Outcomes[2].Name = "TXT_KEY_EVENT_VV_PLANEPTUNE_SHAKING_HISTY_OUTCOME_2"
	Event_PlaneptuneAbababa.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_SHAKING_HISTY_OUTCOME_2_RESULT")
	Event_PlaneptuneAbababa.Outcomes[2].CanFunc = (
		function(pPlayer)
			local iEnergy = 5 + (3 * (pPlayer:GetCurrentEra()))
			Event_PlaneptuneAbababa.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_SHAKING_HISTY_OUTCOME_2_RESULT", iEnergy)
			if pPlayer:GetLeaderType() == GameInfoTypes.LEADER_VV_PURPLE_HEART then
				return true
			else
				return false
			end
		end
		)
	Event_PlaneptuneAbababa.Outcomes[2].DoFunc = (
		function(pPlayer)
			local iEnergy = 5 + (3 * (pPlayer:GetCurrentEra()))
			LuaEvents.VV_ChangeHistyEnergy(pPlayer:GetID(), iEnergy)
			if pPlayer:GetID() == Game:GetActivePlayer() then
				Events.AudioPlay2DSound("AS2D_VV_HISTY_ABABABA")
			end
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_SHAKING_HISTY_OUTCOME_2_NOTIFICATION"), Locale.ConvertTextKey(Event_PlaneptuneAbababa.Name))
		end
		)

	--=========================================================
	-- Outcome 3
	--=========================================================
	Event_PlaneptuneAbababa.Outcomes[3] = {}
	Event_PlaneptuneAbababa.Outcomes[3].Name = "TXT_KEY_EVENT_VV_PLANEPTUNE_SHAKING_HISTY_OUTCOME_3"
	Event_PlaneptuneAbababa.Outcomes[3].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_SHAKING_HISTY_OUTCOME_3_RESULT")
	Event_PlaneptuneAbababa.Outcomes[3].CanFunc = (
		function(pPlayer)
			local iGold = 50 + (25 * (pPlayer:GetCurrentEra() * 2))
			local iEnergy = 5 + (3 * (pPlayer:GetCurrentEra() * 2))
			Event_PlaneptuneAbababa.Outcomes[3].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_SHAKING_HISTY_OUTCOME_3_RESULT", iGold, iEnergy)
			if pPlayer:GetGold() < iGold then
				return false
			else
				return true
			end
		end
		)
	Event_PlaneptuneAbababa.Outcomes[3].DoFunc = (
		function(pPlayer)
			local iGold = 50 + (25 * (pPlayer:GetCurrentEra() * 2))
			local iEnergy = 5 + (3 * (pPlayer:GetCurrentEra() * 2))
			pPlayer:ChangeGold(-iGold)
			LuaEvents.VV_ChangeHistyEnergy(pPlayer:GetID(), iEnergy)
			if pPlayer:GetID() == Game:GetActivePlayer() then
				Events.AudioPlay2DSound("AS2D_VV_HISTY_ABABABA")
			end
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_SHAKING_HISTY_OUTCOME_3_NOTIFICATION"), Locale.ConvertTextKey(Event_PlaneptuneAbababa.Name))
		end
		)

	--=========================================================
	-- Outcome 4
	--=========================================================
	Event_PlaneptuneAbababa.Outcomes[4] = {}
	Event_PlaneptuneAbababa.Outcomes[4].Name = "TXT_KEY_EVENT_VV_PLANEPTUNE_SHAKING_HISTY_OUTCOME_4"
	Event_PlaneptuneAbababa.Outcomes[4].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_SHAKING_HISTY_OUTCOME_4_RESULT")
	Event_PlaneptuneAbababa.Outcomes[4].CanFunc = (
		function(pPlayer)
			local iEnergy = 4 + (3 * (pPlayer:GetCurrentEra() * 2))
			Event_PlaneptuneAbababa.Outcomes[4].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_SHAKING_HISTY_OUTCOME_4_RESULT", iEnergy)
			return true
		end
		)
	Event_PlaneptuneAbababa.Outcomes[4].DoFunc = (
		function(pPlayer)
			local iEnergy = 4 + (3 * (pPlayer:GetCurrentEra() * 2))
			LuaEvents.VV_ChangeHistyEnergy(pPlayer:GetID(), -iEnergy)
			if pPlayer:GetID() == Game:GetActivePlayer() then
				Events.AudioPlay2DSound("AS2D_VV_HISTY_ABABABA")
			end
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_SHAKING_HISTY_OUTCOME_4_NOTIFICATION"), Locale.ConvertTextKey(Event_PlaneptuneAbababa.Name))
		end
		)

for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_PlaneptuneAbababa.tValidCivs[sCiv] then
			tEvents.Event_PlaneptuneAbababa = Event_PlaneptuneAbababa
			break
		end
	end
end


--------------------------------------------------------------------------------------------------------------------------
-- Pissty!
--------------------------------------------------------------------------------------------------------------------------
local Event_PlaneptunePissty = {}
    Event_PlaneptunePissty.Name = "TXT_KEY_EVENT_VV_PLANEPTUNE_PISSTY"
	Event_PlaneptunePissty.Desc = "TXT_KEY_EVENT_VV_PLANEPTUNE_PISSTY_DESC"
	Event_PlaneptunePissty.Data1 = {}
	Event_PlaneptunePissty.Data2 = nil
	Event_PlaneptunePissty.Data3 = nil
	Event_PlaneptunePissty.tValidCivs = 
		{
		["CIVILIZATION_VV_PLANEPTUNE"]		= true    --doesn't trigger for PH
		}
	Event_PlaneptunePissty.Weight = 15
	Event_PlaneptunePissty.EventImage = "Event_PlaneptunePissty.dds"
	Event_PlaneptunePissty.CanFunc = (
		function(pPlayer)
			if load(pPlayer, "Event_PlaneptunePisstyA") or load(pPlayer, "Event_PlaneptunePisstyB") or load("GAME", "Event_PlaneptunePisstyA") then return false end
			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			if Event_PlaneptunePissty.tValidCivs[sCivType] then
				--Histy's energy must be less than 10%
				if MapModData.HDNMod.HistoireEnergy[pPlayer:GetID()] < 10 then
					--No pudding quests must be completed
					for k, v in pairs (MapModData.HDNMod.PuddingQuests[pPlayer:GetID()]) do
						if v.Completed and v.Completed == true then
							return false
						end
					end
					return true
				end
			end
		end
		)
	Event_PlaneptunePissty.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_PlaneptunePissty.Outcomes[1] = {}
	Event_PlaneptunePissty.Outcomes[1].Name = "TXT_KEY_EVENT_VV_PLANEPTUNE_PISSTY_OUTCOME_1"
	Event_PlaneptunePissty.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_PISSTY_OUTCOME_1_RESULT")
	Event_PlaneptunePissty.Outcomes[1].CanFunc = (
		function(pPlayer)
			local iNumBarbs = 3
			local iNumTurns = math.floor(6 * PRODUCTION_SPEED_MOD)
			local iShares = 500
			local iBlockTurns = 10 * PRODUCTION_SPEED_MOD
			Event_PlaneptunePissty.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_PISSTY_OUTCOME_1_RESULT", iNumBarbs, iNumTurns, ConvertToPercentString(iShares), iBlockTurns)
			return true
		end
		)
	Event_PlaneptunePissty.Outcomes[1].DoFunc = (
		function(pPlayer)
			local iNumBarbs = 3
			local iNumTurns = math.floor(6 * PRODUCTION_SPEED_MOD)
			save(pPlayer, "Event_PlaneptunePisstyA", Game:GetGameTurn() + iNumTurns)
			save("GAME", "Event_PlaneptunePisstyA", true)
			local unitID = GetStrongestMilitaryUnit(pPlayer, false, "UNITCOMBAT_MELEE", "UNITCOMBAT_GUN")
			for i = 1, iNumBarbs, 1 do
				local pUnit = Players[63]:InitUnit(unitID, pPlayer:GetCapitalCity():GetX() + 1, pPlayer:GetCapitalCity():GetY() + 1)
				pUnit:JumpToNearestValidPlot() 
				pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_VV_PLANEPTUNE_EVENT, true)
			end
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_PISSTY_OUTCOME_1_NOTIFICATION"), Locale.ConvertTextKey(Event_PlaneptunePissty.Name))
		end
		)


	Event_PlaneptunePissty.Outcomes[1].Monitors = {}
	Event_PlaneptunePissty.Outcomes[1].Monitors[GameEvents.PlayerDoTurn] = (
	function(iPlayer)
		local pPlayer = Players[iPlayer]
		local iTurnLimit = load(pPlayer, "Event_PlaneptunePisstyA")
		local iBlockTurns = 10 * PRODUCTION_SPEED_MOD
		if iTurnLimit then
			for pUnit in Players[63]:Units() do
				if pUnit:IsHasPromotion(GameInfoTypes.PROMOTION_VV_PLANEPTUNE_EVENT) then
					if Game:GetGameTurn() >= iTurnLimit then
						LuaEvents.VV_BlockHistyUse(iPlayer, iBlockTurns)
						save(pPlayer, "Event_PlaneptunePisstyA", nil)
						save("GAME", "Event_PlaneptunePisstyA", nil)
						JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_PISSTY_OUTCOME_1_FAILURE"), Locale.ConvertTextKey(Event_PlaneptunePissty.Name))
						return
					end
				end
			end
			if Game:GetGameTurn() >= iTurnLimit then
				LuaEvents.HDNChangeShares(iPlayer, 500)
				save(pPlayer, "Event_PlaneptunePisstyA", nil)
				save("GAME", "Event_PlaneptunePisstyA", nil)
				JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_PISSTY_OUTCOME_1_COMPLETE"), Locale.ConvertTextKey(Event_PlaneptunePissty.Name))
			end
		end
	end
	)

	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_PlaneptunePissty.Outcomes[2] = {}
	Event_PlaneptunePissty.Outcomes[2].Name = "TXT_KEY_EVENT_VV_PLANEPTUNE_PISSTY_OUTCOME_2"
	Event_PlaneptunePissty.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_PISSTY_OUTCOME_2_RESULT")
	Event_PlaneptunePissty.Outcomes[2].CanFunc = (
		function(pPlayer)
			local iNumTurns = math.floor(15 * PRODUCTION_SPEED_MOD)
			local iShares = 500
			local iBlockTurns = 10 * PRODUCTION_SPEED_MOD
			Event_PlaneptunePissty.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_PISSTY_OUTCOME_2_RESULT", iNumTurns, ConvertToPercentString(iShares), iBlockTurns)
			return true
		end
		)
	Event_PlaneptunePissty.Outcomes[2].DoFunc = (
		function(pPlayer)
			local iNumTurns = math.floor(15 * PRODUCTION_SPEED_MOD)
			save(pPlayer, "Event_PlaneptunePisstyB", Game:GetGameTurn() + iNumTurns)
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_PISSTY_OUTCOME_2_NOTIFICATION"), Locale.ConvertTextKey(Event_PlaneptunePissty.Name))
		end
		)

	Event_PlaneptunePissty.Outcomes[2].Monitors = {}
	Event_PlaneptunePissty.Outcomes[2].Monitors[GameEvents.PlayerDoTurn] = (
	function(iPlayer)
		local pPlayer = Players[iPlayer]
		local iTurnLimit = load(pPlayer, "Event_PlaneptunePisstyB")
		local iBlockTurns = 10 * PRODUCTION_SPEED_MOD
		if iTurnLimit and Game:GetGameTurn() >= iTurnLimit then
			LuaEvents.VV_BlockHistyUse(iPlayer, iBlockTurns)
			save(pPlayer, "Event_PlaneptunePisstyA", nil)
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_PISSTY_OUTCOME_2_FAILURE"), Locale.ConvertTextKey(Event_PlaneptunePissty.Name))
		end
	end
	)
	Event_PlaneptunePissty.Outcomes[2].Monitors[GameEvents.MinorAlliesChanged] = (
	function(iMinor, iMajor, bIncrease)
		if bIncrease == true then
			local pPlayer = Players[iMajor]
			if load(pPlayer, "Event_PlaneptunePisstyB") then
				LuaEvents.HDNChangeShares(iMajor, 500)
				save(pPlayer, "Event_PlaneptunePisstyB", nil)
				JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_PISSTY_OUTCOME_2_COMPLETE"), Locale.ConvertTextKey(Event_PlaneptunePissty.Name))
			end
		end
	end
	)
	Event_PlaneptunePissty.Outcomes[2].Monitors[GameEvents.MinorFriendsChanged] = (
	function(iMinor, iMajor, bIncrease)
		if bIncrease == true then
			local pPlayer = Players[iMajor]
			if load(pPlayer, "Event_PlaneptunePisstyB") then
				LuaEvents.HDNChangeShares(iMajor, 500)
				save(pPlayer, "Event_PlaneptunePisstyB", nil)
				JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_PISSTY_OUTCOME_2_COMPLETE"), Locale.ConvertTextKey(Event_PlaneptunePissty.Name))
			end
		end
	end
	)




for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_PlaneptunePissty.tValidCivs[sCiv] then
			tEvents.Event_PlaneptunePissty = Event_PlaneptunePissty
			break
		end
	end
end


--------------------------------------------------------------------------------------------------------------------------
-- Dogoo Delicacy
--------------------------------------------------------------------------------------------------------------------------
local Event_PlaneptuneDogooDelicacy = {}
    Event_PlaneptuneDogooDelicacy.Name = "TXT_KEY_EVENT_VV_PLANEPTUNE_DOGOO_DELICACY"
	Event_PlaneptuneDogooDelicacy.Desc = "TXT_KEY_EVENT_VV_PLANEPTUNE_DOGOO_DELICACY_DESC"
	Event_PlaneptuneDogooDelicacy.Weight = 4
	Event_PlaneptuneDogooDelicacy.tValidCivs = 
		{
			["CIVILIZATION_VV_PLANEPTUNE"]		= true
		}
	Event_PlaneptuneDogooDelicacy.Data1 = nil
	Event_PlaneptuneDogooDelicacy.EventImage = "Event_PlaneptuneDogooDelicacy.dds"
	Event_PlaneptuneDogooDelicacy.CanFunc = (
		function(pPlayer)
			if load(pPlayer, "Event_PlaneptuneDogooDelicacy") then return false end
			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			if Event_PlaneptuneDogooDelicacy.tValidCivs[sCivType] then
				local iPlayer = pPlayer:GetID()
				if not MapModData.HDNMod.DogooUnitData[iPlayer] then print("No unit data") return false end
				local tPlots = {}
				for k, v in pairs(MapModData.HDNMod.DogooUnitData[iPlayer]) do
					if pPlayer:GetUnitByID(k) and v.ImprovementPlot and v.ImprovementPlot.X > -1 and v.ImprovementPlot.Y > -1 then
						print("Found potential spot")
						local pPlot = Map.GetPlot(v.ImprovementPlot.X, v.ImprovementPlot.Y)
						if pPlot and pPlot:GetOwner() == pPlayer:GetID() and pPlot:GetImprovementType() == GameInfoTypes.IMPROVEMENT_VV_DOGOO_SLIME then
							print("Add to tPlots")
							tPlots[#tPlots + 1] = pPlot
						end
					end
				end
				if #tPlots == 0 then print("Nothing in tPLots") return false end
				Event_PlaneptuneDogooDelicacy.Data1 = tPlots[Game.Rand(#tPlots, "Neptune Event Roll") + 1]
				if Event_PlaneptuneDogooDelicacy.Data1 then return true end
			end
			return false
		end
		)
	Event_PlaneptuneDogooDelicacy.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_PlaneptuneDogooDelicacy.Outcomes[1] = {}
	Event_PlaneptuneDogooDelicacy.Outcomes[1].Name = "TXT_KEY_EVENT_VV_PLANEPTUNE_DOGOO_DELICACY_OUTCOME_1"
	Event_PlaneptuneDogooDelicacy.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_DOGOO_DELICACY_OUTCOME_1_RESULT")
	Event_PlaneptuneDogooDelicacy.Outcomes[1].CanFunc = (
		function(pPlayer, pPlot)
			local iPop = 1
			local pClosestCity;
			local iDist = 5555555
			for pCity in pPlayer:Cities() do
				local iThisDist = Map.PlotDistance(pCity:GetX(), pCity:GetY(), pPlot:GetX(), pPlot:GetY())
				if iThisDist < iDist then
					iDist = iThisDist
					pClosestCity = pCity
				end
			end
			if not pClosestCity then return false end
			Event_PlaneptuneDogooDelicacy.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_DOGOO_DELICACY_OUTCOME_1_RESULT", pClosestCity:GetName(), iPop)
			return true
		end
		)
	Event_PlaneptuneDogooDelicacy.Outcomes[1].DoFunc = (
		function(pPlayer, pPlot)
			local iPop = 2
			local pClosestCity;
			local iDist = 5555555
			for pCity in pPlayer:Cities() do
				local iThisDist = Map.PlotDistance(pCity:GetX(), pCity:GetY(), pPlot:GetX(), pPlot:GetY())
				if iThisDist < iDist then
					iDist = iThisDist
					pClosestCity = pCity
				end
			end
			pClosestCity:ChangePopulation(iPop, true)
			save(pPlayer, "Event_PlaneptuneDogooDelicacy", true)
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_DOGOO_DELICACY_OUTCOME_1_NOTIFICATION"), Locale.ConvertTextKey(Event_PlaneptuneDogooDelicacy.Name))
		end
		)

	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_PlaneptuneDogooDelicacy.Outcomes[2] = {}
	Event_PlaneptuneDogooDelicacy.Outcomes[2].Name = "TXT_KEY_EVENT_VV_PLANEPTUNE_DOGOO_DELICACY_OUTCOME_2"
	Event_PlaneptuneDogooDelicacy.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_DOGOO_DELICACY_OUTCOME_2_RESULT")
	Event_PlaneptuneDogooDelicacy.Outcomes[2].CanFunc = (
		function(pPlayer, pPlot)
			return true
		end
		)
	Event_PlaneptuneDogooDelicacy.Outcomes[2].DoFunc = (
		function(pPlayer, pPlot)
			local iUnitToRemove;
			for k, v in pairs(MapModData.HDNMod.DogooUnitData[pPlayer:GetID()]) do
				if pPlayer:GetUnitByID(k) and v.ImprovementPlot and v.ImprovementPlot.X > -1 and v.ImprovementPlot.Y > -1 then
					local pThisPlot = Map.GetPlot(v.ImprovementPlot.X, v.ImprovementPlot.Y)
					if pThisPlot and pThisPlot == pPlot then
						pThisPlot:SetImprovementType(GameInfoTypes.IMPROVEMENT_VV_ORANGE_SLIME_PUDDLE)
						pPlayer:GetUnitByID(k):Kill(true)
						iUnitToRemove = k
					end
				end
			end
			MapModData.HDNMod.DogooUnitData[pPlayer:GetID()][iUnitToRemove] = nil

			save(pPlayer, "Event_PlaneptuneDogooDelicacy", true)
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_DOGOO_DELICACY_OUTCOME_2_NOTIFICATION"), Locale.ConvertTextKey(Event_PlaneptuneDogooDelicacy.Name))
		end
		)

for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_PlaneptuneDogooDelicacy.tValidCivs[sCiv] then
			tEvents.Event_PlaneptuneDogooDelicacy = Event_PlaneptuneDogooDelicacy
			break
		end
	end
end




--------------------------------------------------------------------------------------------------------------------------
-- "You must play the Neptune!"
--------------------------------------------------------------------------------------------------------------------------

local Event_PlaneptuneSegata = {}
    Event_PlaneptuneSegata.Name = "TXT_KEY_EVENT_VV_PLANEPTUNE_SANSHIRO"
	Event_PlaneptuneSegata.Desc = "TXT_KEY_EVENT_VV_PLANEPTUNE_SANSHIRO_DESC"
	Event_PlaneptuneSegata.tValidCivs = 
		{
		["CIVILIZATION_VV_PLANEPTUNE"]		= true,
		["CIVILIZATION_VV_PLANEPTUNE_PH"]	= true
		}
	Event_PlaneptuneSegata.Weight = 4
	Event_PlaneptuneSegata.EventImage = "Event_PlaneptuneSegata.dds"
	Event_PlaneptuneSegata.CanFunc = (
		function(pPlayer)
			if load(pPlayer, "Event_PlaneptuneSegata") then return false end
			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			return Event_PlaneptuneAbababa.tValidCivs[sCivType]
		end
		)
	Event_PlaneptuneSegata.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_PlaneptuneSegata.Outcomes[1] = {}
	Event_PlaneptuneSegata.Outcomes[1].Name = "TXT_KEY_EVENT_VV_PLANEPTUNE_SANSHIRO_OUTCOME_1"
	Event_PlaneptuneSegata.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_SANSHIRO_OUTCOME_1_RESULT")
	Event_PlaneptuneSegata.Outcomes[1].CanFunc = (
		function(pPlayer)
			return true
		end
		)
	Event_PlaneptuneSegata.Outcomes[1].DoFunc = (
		function(pPlayer)
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetNumFreePolicies(0)
			pPlayer:SetHasPolicy(GameInfoTypes.POLICY_DECISIONS_VV_SEGATA_A, true)
			save(pPlayer, "Event_PlaneptuneSegata", true)
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_SANSHIRO_OUTCOME_1_NOTIFICATION"), Locale.ConvertTextKey(Event_PlaneptuneDogooDelicacy.Name))
		end
		)

	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_PlaneptuneSegata.Outcomes[2] = {}
	Event_PlaneptuneSegata.Outcomes[2].Name = "TXT_KEY_EVENT_VV_PLANEPTUNE_SANSHIRO_OUTCOME_2"
	Event_PlaneptuneSegata.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_SANSHIRO_OUTCOME_2_RESULT")
	Event_PlaneptuneSegata.Outcomes[2].CanFunc = (
		function(pPlayer)
			return true
		end
		)
	Event_PlaneptuneSegata.Outcomes[2].DoFunc = (
		function(pPlayer)
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetNumFreePolicies(0)
			pPlayer:SetHasPolicy(GameInfoTypes.POLICY_DECISIONS_VV_SEGATA_B, true)
			save(pPlayer, "Event_PlaneptuneSegata", true)
			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VV_PLANEPTUNE_SANSHIRO_OUTCOME_2_NOTIFICATION"), Locale.ConvertTextKey(Event_PlaneptuneDogooDelicacy.Name))
		end
		)


for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_PlaneptuneSegata.tValidCivs[sCiv] then
			tEvents.Event_PlaneptuneSegata = Event_PlaneptuneSegata
			break
		end
	end
end