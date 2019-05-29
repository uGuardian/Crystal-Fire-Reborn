-- LeanboxDecisions
-- Author: Vice
-- DateCreated: 3/23/2015 9:50:59 PM
--------------------------------------------------------------


function split(str, pat)
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


local iTurns = math.ceil(30 * iMod)
local PRODUCTION_SPEED_MOD = GameInfo.GameSpeeds[PreGame.GetGameSpeed()].ConstructPercent / 100

--------------------------------------------------------------------------------------------------------------------------------------------
--Decision 1: Commission a BL Novel
--Relationship bonus between two targeted, male-led Civs
--If those two civs DOF each other, you get Shares (plus the GA points you already get from the Trait)
--------------------------------------------------------------------------------------------------------------------------------------------
local Decisions_CommissionBLGame = {}
	Decisions_CommissionBLGame.Name = "TXT_KEY_DECISIONS_VV_LEANBOX_COMMISSION_BL_GAME"
	Decisions_CommissionBLGame.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_VV_LEANBOX_COMMISSION_BL_GAME_DESC")
	HookDecisionCivilizationIcon(Decisions_CommissionBLGame, "CIVILIZATION_VV_LEANBOX")
	Decisions_CommissionBLGame.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_VV_LEANBOX) and (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_VV_LEANBOX_GH)
		and (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_VV_LEANBOX_ULTRA) and (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_VV_LEANBOX_GH_ULTRA) then
			return false, false
		end

		if load(pPlayer, "Decisions_CommissionBLGame") ~= nil then
			return false, false
		end

		local iEra = pPlayer:GetCurrentEra()
		local temptable = {}
		temptable["Gold"] = math.ceil(200 * math.max(1, iEra), iMod)

		if pPlayer:GetGold() < temptable["Gold"] then return false, false end
		--Normally, you're supposed to return true, false end for those, but this would probably spam the decisions list up too much otherwise

		local iPlayer = pPlayer:GetID()
		local pTeam = Teams[pPlayer:GetTeam()]

		for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
			if i ~= iPlayer then
				local pLoop1 = Players[i]
				if pLoop1:IsAlive() and pTeam:IsHasMet(pLoop1:GetTeam()) then
					local sLeaderKey1 = GameInfo.Leaders[pLoop1:GetLeaderType()].Description
					if Locale.ConvertTextKey("{@1: gender feminine?yes; other?no}", sLeaderKey1) ~= "yes" then
						for j = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
							if j ~= i and j ~= iPlayer then
								local pLoop2 = Players[j]
								if pLoop2:IsAlive() and pTeam:IsHasMet(pLoop2:GetTeam()) then
									local sLeaderKey2 = GameInfo.Leaders[pLoop2:GetLeaderType()].Description
									if Locale.ConvertTextKey("{@1: gender feminine?yes; other?no}", sLeaderKey2) ~= "yes" then
										if not pLoop1:IsDoF(j) then
											print("No DOF")
											local sKey = "Decisions_CommissionBLGame"..i.."X"..j
											local sReverseKey = "Decisions_CommissionBLGame"..j.."X"..i --to check for duplicates
											if not tTempDecisions[sReverseKey] then
												temptable["P1"] = i
												temptable["P2"] = j
												tTempDecisions[sKey] = {}
												tTempDecisions[sKey].Name = Locale.ConvertTextKey("TXT_KEY_DECISIONS_VV_LEANBOX_COMMISSION_BL_GAME", sLeaderKey1, sLeaderKey2)
												tTempDecisions[sKey].Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_VV_LEANBOX_COMMISSION_BL_GAME_DESC")
												tTempDecisions[sKey].Data1 = temptable
												tTempDecisions[sKey].Weight = 0
												tTempDecisions[sKey].Type = "Civilization"
												HookDecisionCivilizationIcon(tTempDecisions[sKey], "CIVILIZATION_VV_LEANBOX")
												tTempDecisions[sKey].CanFunc = (
												function(pPlayer, tTable)
													local player1 = Players[tTable["P1"]]
													local player2 = Players[tTable["P2"]]

													local sName1 = player1:GetName()
													local sName2 = player2:GetName()

													tTempDecisions[sKey].Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_VV_LEANBOX_COMMISSION_BL_GAME_DESC", sName1, sName2, tTable["Gold"], iTurns)

													return true, true
												end
												)
			
												tTempDecisions[sKey].DoFunc = (
												function(pPlayer, tTable)
													local sKey = tTable["P1"].."X"..tTable["P2"]
													pPlayer:ChangeGold(-temptable["Gold"])
													for eEvent, fFunc in pairs(Decisions_CommissionBLGame.Monitors) do
														eEvent.Remove(fFunc)
														eEvent.Add(fFunc)
													end
													save("GAME", "Decisions_CommissionBLGame_Monitors", true)		
													save(pPlayer, "Decisions_CommissionBLGame", sKey)
													save(pPlayer, "Decisions_CommissionBLGameTurn", Game:GetGameTurn())
												end
												)
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
	)
	
	Decisions_CommissionBLGame.Monitors = {}
	Decisions_CommissionBLGame.Monitors[GameEvents.PlayerDoTurn] =  (
	function(iPlayer)
		if iPlayer < GameDefines.MAX_MAJOR_CIVS then
			local pPlayer = Players[iPlayer]
			if load(pPlayer, "Decisions_CommissionBLGameTurn") then
				if Game:GetGameTurn() - iTurns >= load(pPlayer, "Decisions_CommissionBLGameTurn") then
					save(pPlayer, "Decisions_CommissionBLGame", nil)
					save(pPlayer, "Decisions_CommissionBLGameTurn", nil)
					for eEvent, fFunc in pairs(Decisions_CommissionBLGame.Monitors) do
						eEvent.Remove(fFunc)
						eEvent.Add(fFunc)
					end
					MapModData.HDNMod.ExtraShareSources[pPlayer:GetID()]["Decisions_CommissionBLGame"] = nil
				else
					local key = load(pLoop, "Decisions_CommissionBLGame")
					if key then
						if not MapModData.HDNMod.ExtraShareSources[pPlayer:GetID()] then MapModData.HDNMod.ExtraShareSources[pPlayer:GetID()] = {} end
						local ids = split(key, "X")
						if Players[ids[1]]:IsDoF() then
							MapModData.HDNMod.ExtraShareSources[pPlayer:GetID()]["Decisions_CommissionBLGame"] = {50 * PRODUCTION_SPEED_MOD, "TXT_KEY_HDN_SHARES_FROM_DECISIONS"}
						else
							MapModData.HDNMod.ExtraShareSources[pPlayer:GetID()]["Decisions_CommissionBLGame"] = nil
						end
					end
				end
			end
		end
	end
	)

	Decisions_CommissionBLGame.Monitors[GameEvents.GetScenarioDiploModifier3] =  (
	function(iPlayer1, iPlayer2)
		local pPlayer1 = Players[iPlayer1]
		local pPlayer2 = Players[iPlayer2]
		for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
			if i ~= iPlayer1 and i ~= iPlayer2 then
				local pLoop = Players[i]
				if load(pLoop, "Decisions_CommissionBLGame") then
					local ids = split(load(pLoop, "Decisions_CommissionBLGame"), "X")
					if (ids[1] == iPlayer1 and ids[2] == iPlayer2) or (ids[1] == iPlayer2 and ids[2] == iPlayer1) then
						return -75
					end
				end
			end
		end
		return 0
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_VV_LEANBOX, "Decisions_CommissionBLGame", Decisions_CommissionBLGame)
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_VV_LEANBOX_GH, "Decisions_CommissionBLGame", Decisions_CommissionBLGame)
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_VV_LEANBOX_ULTRA, "Decisions_CommissionBLGame", Decisions_CommissionBLGame)
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_VV_LEANBOX_GH_ULTRA, "Decisions_CommissionBLGame", Decisions_CommissionBLGame)

--------------------------------------------------------------------------------------------------------------------------------------------
--Decision 2: Fund Leanbox's Killer App
--Free Police Station and bonuses to Cities with counterspies in them
--------------------------------------------------------------------------------------------------------------------------------------------

local Decisions_LeanboxKinect = {}
	Decisions_LeanboxKinect.Name = "TXT_KEY_DECISIONS_VV_LEANBOX_KINECT"
	Decisions_LeanboxKinect.Desc = "TXT_KEY_DECISIONS_VV_LEANBOX_KINECT_DESC"
	HookDecisionCivilizationIcon(Decisions_LeanboxKinect, "CIVILIZATION_VV_LEANBOX")
	Decisions_LeanboxKinect.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_VV_LEANBOX) and (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_VV_LEANBOX_GH)
		and (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_VV_LEANBOX_ULTRA) and (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_VV_LEANBOX_GH_ULTRA) then
			return false, false
		end

		if load(pPlayer, "Decisions_LeanboxKinect") == true then
			Decisions_LeanboxKinect.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_VV_LEANBOX_KINECT_ENACTED_DESC")
			return false, false, true
		end

		local iCost = math.ceil(700 * iMod)
		Decisions_LeanboxKinect.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_VV_LEANBOX_KINECT_DESC", iCost)
		
		if pPlayer:GetGold() < iCost then return true, false end

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 3) then return true, false end
		
		local pTeam = Teams[pPlayer:GetTeam()]
		local pTeamTechs = pTeam:GetTeamTechs()
		
		if pTeamTechs:HasTech(GameInfoTypes.TECH_ELECTRICITY) then 
			return true, true
		else
			return true, false
		end
	end
	)

	Decisions_LeanboxKinect.DoFunc = (
	function(pPlayer)
		local iCost = math.ceil(700 * iMod)
		pPlayer:ChangeGold(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -3)
		pPlayer:ChangeAnarchyNumTurns(1)
		pPlayer:GetCapitalCity():SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_LEANBOX_DUMMY_2, 1, true)
		save(pPlayer, "Decisions_LeanboxKinect", true)
	end
	)
	
	Decisions_LeanboxKinect.Monitors = {}

	Decisions_LeanboxKinect.Monitors[GameEvents.PlayerDoTurn] =  (
	function(iPlayer)
		if iPlayer < GameDefines.MAX_MAJOR_CIVS then
			local pPlayer = Players[iPlayer]
			if load(pPlayer, "Decisions_LeanboxKinect") == true then
				local tSpyPlots = {}
				for k, v in pairs(pPlayer:GetEspionageSpies()) do
					if v.CityX > -1 and v.CityY > -1 then
						tSpyPlots[Map.GetPlot(v.CityX, v.CityY)] = true
					end
				end
				for pCity in pPlayer:Cities() do
					if tSpyPlots[pCity:Plot()] then
						pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_LEANBOX_DUMMY, 1, true)
					else
						pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_LEANBOX_DUMMY, 0)
					end
				end
			end
		end
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_VV_LEANBOX, "Decisions_LeanboxKinect", Decisions_LeanboxKinect)
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_VV_LEANBOX_GH, "Decisions_LeanboxKinect", Decisions_LeanboxKinect)
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_VV_LEANBOX_ULTRA, "Decisions_LeanboxKinect", Decisions_LeanboxKinect)
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_VV_LEANBOX_GH_ULTRA, "Decisions_LeanboxKinect", Decisions_LeanboxKinect)