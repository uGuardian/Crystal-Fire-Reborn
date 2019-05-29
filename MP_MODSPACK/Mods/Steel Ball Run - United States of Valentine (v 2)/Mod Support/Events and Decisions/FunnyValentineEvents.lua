-- Funny Valentine Events
-- Author: Vice
-- DateCreated: 2/13/2015 11:43:16 PM
--------------------------------------------------------------

local function ReturnUnitFromSpecialID(ID)
	local temptable = split(ID, ":");	
	local iPlayer = tonumber(temptable[1]);
	local iUnit = tonumber(temptable[2]);
	local pUnit = Players[iPlayer]:GetUnitByID(iUnit)
	if pUnit then
		return pUnit
	else
		return nil
	end
end

-- from http://lua-users.org/wiki/SplitJoin
local function split(str, pat)
   local t = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pat
   local last_end = 1
   local s, e, cap = str:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
	 table.insert(t,cap)
      end
      last_end = e+1
      s, e, cap = str:find(fpat, last_end)
   end
   if last_end <= #str then
      cap = str:sub(last_end)
      table.insert(t, cap)
   end
   return t
end

--===========================================================================================================================================================================
-- EVENT 1: SBR DEMANDS PRIZE MONEY
--===========================================================================================================================================================================

local Event_SteelBallRunner = {}
    Event_SteelBallRunner.Name = "TXT_KEY_EVENT_STEEL_BALL_RUNNER"
	Event_SteelBallRunner.Desc = "TXT_KEY_EVENT_STEEL_BALL_RUNNER_DESC"
	Event_SteelBallRunner.tValidCivs = 
		{
		["CIVILIZATION_JJBA_AMERICA"] = true
		}
	Event_SteelBallRunner.Data1 = nil
	Event_SteelBallRunner.Weight = 15
	Event_SteelBallRunner.CanFunc = (
		function(pPlayer)
			local iPlayer = pPlayer:GetID()

			if not MapModData.FValentine.SteelBallRunnersThatFoundCorpseParts[iPlayer] then MapModData.FValentine.SteelBallRunnersThatFoundCorpseParts[iPlayer] = {} end

			if #MapModData.FValentine.SteelBallRunnersThatFoundCorpseParts[iPlayer] == 0 then return false end

			local bAnySBRsValid = false
			local specialID = MapModData.FValentine.SteelBallRunnersThatFoundCorpseParts[iPlayer][Game.Rand(#MapModData.FValentine.SteelBallRunnersThatFoundCorpseParts[iPlayer] + 1)]
			local pUnit = ReturnUnitFromSpecialID(specialID)

			if pUnit then
				Event_SteelBallRunner.Data1 = pUnit
				Event_SteelBallRunner.Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_STEEL_BALL_RUNNER_DESC", pUnit:GetNameNoDesc())
				local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
				return Event_SteelBallRunner.tValidCivs[sCivType]
			else
				return false
			end
		end
		)
	Event_SteelBallRunner.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_SteelBallRunner.Outcomes[1] = {}
	Event_SteelBallRunner.Outcomes[1].Name = "TXT_KEY_EVENT_STEEL_BALL_RUNNER_OUTCOME_1"
	Event_SteelBallRunner.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_STEEL_BALL_RUNNER_OUTCOME_1_DESC")
	Event_SteelBallRunner.Outcomes[1].CanFunc = (
		function(pPlayer)
			local iValue = math.ceil(300 * pPlayer:GetCurrentEra() * iMod)

			Event_SteelBallRunner.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_STEEL_BALL_RUNNER_OUTCOME_1_DESC", iValue)

			if pPlayer:GetGold() >= iValue then
				return true
			else
				return false
			end
		end
		)
	Event_SteelBallRunner.Outcomes[1].DoFunc = (
		function(pPlayer)
			local iValue = math.ceil(300 * iMod)
			pPlayer:ChangeGold(-iValue)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_STEEL_BALL_RUNNER_OUTCOME_1_NOTIFICATION"), Locale.ConvertTextKey(Event_SteelBallRunner.Name))
		end
		)

	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_SteelBallRunner.Outcomes[2] = {}
	Event_SteelBallRunner.Outcomes[2].Name = "TXT_KEY_EVENT_STEEL_BALL_RUNNER_OUTCOME_2"
	Event_SteelBallRunner.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_STEEL_BALL_RUNNER_OUTCOME_2_DESC")
	Event_SteelBallRunner.Outcomes[2].CanFunc = (
		function(pPlayer, pUnit)
			Event_SteelBallRunner.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_STEEL_BALL_RUNNER_OUTCOME_2_DESC", pUnit:GetNameNoDesc())

			return true
		end
		)
	Event_SteelBallRunner.Outcomes[2].DoFunc = (
		function(pPlayer, pUnit)

			local pPlot = pUnit:GetPlot()
			if pPlot:IsCity() then
				pPlot = Map.GetPlot(pPlot:GetX() + 1, pPlot:GetY() + 1)
			end

			local pBarbUnit = Players[63]:InitUnit(GameInfoTypes.UNIT_STEEL_BALL_RUNNER, pPlot:GetX(), pPlot:GetY(), UNITAI_FAST_ATTACK)

			pBarbUnit:SetName(pUnit:GetNameNoDesc())
			for row in GameInfo.UnitPromotions() do
				if pUnit:IsHasPromotion(row.ID) then
					pBarbUnit:SetHasPromotion(row.ID, true)
				end
			end

			pBarbUnit:SetDamage(pUnit:GetDamage())

			pUnit:Kill(true)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_STEEL_BALL_RUNNER_OUTCOME_2_NOTIFICATION"), Locale.ConvertTextKey(Event_SteelBallRunner.Name))
		end
		)

for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_SteelBallRunner.tValidCivs[sCiv] then
			tEvents.Event_SteelBallRunner = Event_SteelBallRunner
			break
		end
	end
end

--===========================================================================================================================================================================
-- EVENT 2: VALENTINE'S ORIGINS IN THE CIVIL WAR
--===========================================================================================================================================================================



local Event_ValentineCivilWarOrigin = {}
    Event_ValentineCivilWarOrigin.Name = "TXT_KEY_EVENT_VALENTINE_CIVIL_WAR_ORIGIN"
	Event_ValentineCivilWarOrigin.Desc = "TXT_KEY_EVENT_VALENTINE_CIVIL_WAR_ORIGIN_DESC"
	Event_ValentineCivilWarOrigin.tValidCivs = 
		{
		["CIVILIZATION_JJBA_AMERICA"] = true
		}
	Event_ValentineCivilWarOrigin.Data1 = nil
	Event_ValentineCivilWarOrigin.Weight = 200
	Event_ValentineCivilWarOrigin.CanFunc = (
		function(pPlayer)
			if load(pPlayer, "Event_ValentineCivilWarOrigin") == true then return false end
			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			return Event_ValentineCivilWarOrigin.tValidCivs[sCivType]
		end
		)
	Event_ValentineCivilWarOrigin.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_ValentineCivilWarOrigin.Outcomes[1] = {}
	Event_ValentineCivilWarOrigin.Outcomes[1].Name = "TXT_KEY_EVENT_VALENTINE_CIVIL_WAR_ORIGIN_OUTCOME_1"
	Event_ValentineCivilWarOrigin.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VALENTINE_CIVIL_WAR_ORIGIN_OUTCOME_1_DESC")
	Event_ValentineCivilWarOrigin.Outcomes[1].CanFunc = (
		function(pPlayer)
			return true
		end
		)
	Event_ValentineCivilWarOrigin.Outcomes[1].DoFunc = (
		function(pPlayer)
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetHasPolicy(GameInfoTypes.POLICY_DECISIONS_FUNNY_VALENTINE_UNION, true)
			pPlayer:SetNumFreePolicies(0)

			save(pPlayer, "Event_ValentineCivilWarOrigin", true)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VALENTINE_CIVIL_WAR_ORIGIN_OUTCOME_1_NOTIFICATION"), Locale.ConvertTextKey(Event_ValentineCivilWarOrigin.Name))
		end
		)

	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_ValentineCivilWarOrigin.Outcomes[2] = {}
	Event_ValentineCivilWarOrigin.Outcomes[2].Name = "TXT_KEY_EVENT_VALENTINE_CIVIL_WAR_ORIGIN_OUTCOME_2"
	Event_ValentineCivilWarOrigin.Outcomes[2].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VALENTINE_CIVIL_WAR_ORIGIN_OUTCOME_2_DESC")
	Event_ValentineCivilWarOrigin.Outcomes[2].CanFunc = (
		function(pPlayer, pUnit)
			return true
		end
		)
	Event_ValentineCivilWarOrigin.Outcomes[2].DoFunc = (
		function(pPlayer, pUnit)
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetHasPolicy(GameInfoTypes.POLICY_DECISIONS_FUNNY_VALENTINE_CONFEDERACY, true)
			pPlayer:SetNumFreePolicies(0)

			local pCapital = pPlayer:GetCapitalCity()
			if pCapital then
				pPlayer:InitUnit(GameInfoTypes.UNIT_WORKER, pCapital:GetX(), pCapital:GetY(), UNITAI_WORKER)
				pPlayer:InitUnit(GameInfoTypes.UNIT_SETTLER, pCapital:GetX(), pCapital:GetY(), UNITAI_SETTLE)
			end

			save(pPlayer, "Event_ValentineCivilWarOrigin", true)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VALENTINE_CIVIL_WAR_ORIGIN_OUTCOME_2_NOTIFICATION"), Locale.ConvertTextKey(Event_ValentineCivilWarOrigin.Name))
		end
		)

	--=========================================================
	-- Outcome 3
	--=========================================================
	Event_ValentineCivilWarOrigin.Outcomes[3] = {}
	Event_ValentineCivilWarOrigin.Outcomes[3].Name = "TXT_KEY_EVENT_VALENTINE_CIVIL_WAR_ORIGIN_OUTCOME_3"
	Event_ValentineCivilWarOrigin.Outcomes[3].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_VALENTINE_CIVIL_WAR_ORIGIN_OUTCOME_3_DESC")
	Event_ValentineCivilWarOrigin.Outcomes[3].CanFunc = (
		function(pPlayer, pUnit)
			return true
		end
		)
	Event_ValentineCivilWarOrigin.Outcomes[3].DoFunc = (
		function(pPlayer, pUnit)
			save(pPlayer, "Event_ValentineCivilWarOrigin", true)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_EVENT_VALENTINE_CIVIL_WAR_ORIGIN_OUTCOME_3_NOTIFICATION"), Locale.ConvertTextKey(Event_ValentineCivilWarOrigin.Name))
		end
		)

for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_ValentineCivilWarOrigin.tValidCivs[sCiv] then
			tEvents.Event_ValentineCivilWarOrigin = Event_ValentineCivilWarOrigin
			break
		end
	end
end