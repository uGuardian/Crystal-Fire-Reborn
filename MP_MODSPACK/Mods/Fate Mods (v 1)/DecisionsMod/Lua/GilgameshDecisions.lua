-- SaberDecisions
-- Author: Vicevirtuoso
-- DateCreated: 8/25/2014 2:01:53 PM
--------------------------------------------------------------

local iGilgameshDummy = GameInfoTypes.BUILDING_DECISIONS_GILGAMESH_FSN
local iGilEaUnit = GameInfoTypes.UNIT_GILGAMESH_DECISION_EA
local iWine = GameInfoTypes.RESOURCE_WINE
local iPlantation = GameInfoTypes.IMPROVEMENT_PLANTATION

local iResistMod;

if (Map.GetWorldSize() == GameInfoTypes.WORLDSIZE_DUEL) then
	iResistMod = 3;
elseif (Map.GetWorldSize() == GameInfoTypes.WORLDSIZE_TINY) then
	iResistMod = 2;
elseif (Map.GetWorldSize() == GameInfoTypes.WORLDSIZE_SMALL) then
	iResistMod = 1.5;
elseif (Map.GetWorldSize() == GameInfoTypes.WORLDSIZE_STANDARD) then
	iResistMod = 1;
elseif (Map.GetWorldSize() == GameInfoTypes.WORLDSIZE_LARGE) then
	iResistMod = 0.75;
elseif (Map.GetWorldSize() == GameInfoTypes.WORLDSIZE_HUGE) then
	iResistMod = 0.5;
else
	iResistMod = 1;
end

local Decisions_GilgameshWine = {}
	Decisions_GilgameshWine.Name = "TXT_KEY_DECISIONS_GILGAMESH_WINE"
	Decisions_GilgameshWine.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_GILGAMESH_WINE_DESC")
	HookDecisionCivilizationIcon(Decisions_GilgameshWine, "CIVILIZATION_SUMER_FSN")
	Decisions_GilgameshWine.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_SUMER_FSN) then
			return false, false
		end

		if load(pPlayer, "Decisions_GilgameshWine") == true then
			Decisions_GilgameshWine.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_GILGAMESH_WINE_ENACTED_DESC")
			return false, false, true
		end
		
		local iGoldCost = math.ceil(300 * iMod)
		
		Decisions_GilgameshWine.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_GILGAMESH_WINE_DESC", iGoldCost)
		
		if pPlayer:GetGold() < iGoldCost then return true, false end

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end

		for pCity in pPlayer:Cities() do
			local iNumPlots = pCity:GetNumCityPlots();
			for iPlot = 0, iNumPlots - 1 do
				local pPlot = pCity:GetCityIndexPlot(iPlot)
				if pPlot and pPlot:GetResourceType() > -1 then
					if pPlot:GetResourceType() == iWine and pPlot:GetImprovementType() == iPlantation then
						return true, true
					end
				end
			end
		end
	
		return true, false

	end
	)
	
	Decisions_GilgameshWine.DoFunc = (
	function(pPlayer)
		local iGoldCost = math.ceil(300 * iMod)
		pPlayer:ChangeGold(-iGoldCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)

		for pCity in pPlayer:Cities() do
			pCity:SetNumRealBuilding(iGilgameshDummy, 1)
		end	

		save(pPlayer, "Decisions_GilgameshWine", true)
	end
	)

	Decisions_GilgameshWine.Monitors = {}
	Decisions_GilgameshWine.Monitors[GameEvents.PlayerDoTurn] = (
	function(iPlayer)
		local pPlayer = Players[iPlayer]
		if load(pPlayer, "Decisions_GilgameshWine") == true then
			for pCity in pPlayer:Cities() do
				pCity:SetNumRealBuilding(iGilgameshDummy, 1)
			end
			local iWineTotalAfterFirst = pPlayer:GetNumResourceAvailable(iWine, true) - 1
			if iWineTotalAfterFirst > 0 then
				pPlayer:ChangeGoldenAgeProgressMeter(iWineTotalAfterFirst * 10)
			end
		else
			for pCity in pPlayer:Cities() do
				pCity:SetNumRealBuilding(iGilgameshDummy, 0)
			end
		end
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_SUMER_FSN, "Decisions_GilgameshWine", Decisions_GilgameshWine)

local Decisions_GilgameshEa = {}
	Decisions_GilgameshEa.Name = "TXT_KEY_DECISIONS_GILGAMESH_EA"
	Decisions_GilgameshEa.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_GILGAMESH_EA_DESC")
	HookDecisionCivilizationIcon(Decisions_GilgameshEa, "CIVILIZATION_SUMER_FSN")
	Decisions_GilgameshEa.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_SUMER_FSN) then
			return false, false
		end

		local pTeam = Teams[pPlayer:GetTeam()]

		local tEaTable1 = {}

		tEaTable1.GoldCost = math.ceil(500 * iMod)
		tEaTable1.GAMinimum = math.ceil(500 * iMod)



		for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
			local pEnemyPlayer = Players[i]
			local iEnemyTeam = pEnemyPlayer:GetTeam()
			if pEnemyPlayer ~= pPlayer and pTeam:IsAtWar(iEnemyTeam) then
				local tEaTable2 = tEaTable1
				tEaTable2.Player = pEnemyPlayer
				tEaTable2.Adjective = pEnemyPlayer:GetCivilizationAdjective()
				for pCity in pEnemyPlayer:Cities() do
					if pCity:Plot():IsVisible(pTeam:GetID()) then
						local sKey = "Decisions_GilgameshEa" .. CompileCityID(pCity)
						local sName = pCity:GetName()

						tTempDecisions[sKey] = {}
						tTempDecisions[sKey].Name = Locale.ConvertTextKey("TXT_KEY_DECISIONS_GILGAMESH_EA", sName)
						tTempDecisions[sKey].Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_GILGAMESH_EA_DESC")
						tTempDecisions[sKey].Data1 = pCity
						tTempDecisions[sKey].Data2 = tEaTable2
						tTempDecisions[sKey].Weight = 0
						tTempDecisions[sKey].Type = "Civilization"
						HookDecisionCivilizationIcon(tTempDecisions[sKey], "CIVILIZATION_SUMER_FSN")
						tTempDecisions[sKey].CanFunc = (
						function(pPlayer, pCity, tInfo)
							local sKey = "Decisions_GilgameshEa" .. CompileCityID(pCity)
							local sName = pCity:GetName()

							local pCapitalPlot = pPlayer:GetCapitalCity():Plot()
							local pCityPlot = pCity:Plot()

							local iResistTurns = math.ceil(iResistMod * math.floor(Map.PlotDistance(pCapitalPlot:GetX(), pCapitalPlot:GetY(), pCityPlot:GetX(), pCityPlot:GetY()) / 5))
							local iTravelTurns = math.ceil(iResistTurns / 2)

							if load(pPlayer, sKey) then
								tTempDecisions[sKey].Desc  = Locale.ConvertTextKey("TXT_KEY_DECISIONS_GILGAMESH_EA_ENACTED_DESC", tInfo.Adjective, sName, iTravelTurns)
								return false, false, true
							end

							if load(pPlayer, "Decisions_GilgameshEa") then return false, false end

							tTempDecisions[sKey].Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_GILGAMESH_EA_DESC", tInfo.Adjective, tInfo.GAMinimum, iResistTurns, tInfo.GoldCost, sName, iTravelTurns)

							if tInfo.Player:GetMilitaryMight() < (pPlayer:GetMilitaryMight() * 2) then return true, false end
							if pPlayer:GetGold() < tInfo.GoldCost then return true, false end
							if pPlayer:GetGoldenAgeProgressMeter() < tInfo.GAMinimum then return true, false end

							return true, true
						end
						)

						tTempDecisions[sKey].DoFunc = (
						function(pPlayer, pCity, tInfo)
							local cityID = CompileCityID(pCity)
							local sKey = "Decisions_GilgameshEa" .. cityID
							local sName = pCity:GetName()
							
							pPlayer:ChangeGold(-tInfo.GoldCost)
							pPlayer:SetGoldenAgeProgressMeter(0)

							local pCapital = pPlayer:GetCapitalCity()

							local iResistTurns = math.ceil(iResistMod * math.floor(Map.PlotDistance(pCapital:GetX(), pCapital:GetY(), pCity:GetX(), pCity:GetY()) / 5))
							local iTravelTurns = math.ceil(iResistTurns / 2)

							pCapital:ChangeResistanceTurns(iResistTurns)

							for eEvent, fFunc in pairs(Decisions_GilgameshEa.Monitors) do
								eEvent.Remove(fFunc)
								eEvent.Add(fFunc)
							end
							

							-- local tSaveTable = {}
							-- tSaveTable.ArriveTurn = iTravelTurns + Game:GetGameTurn()
							-- tSaveTable.ReturnTurn = iResistTurns + Game:GetGameTurn()
							-- tSaveTable.CityID = CompileCityID(pCity)
							
							JFD_SendNotification(pCity:GetOwner(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_GILGAMESH_EA_ENEMY_NOTIFICATION_TEXT", iTravelTurns, sName), Locale.ConvertTextKey("TXT_KEY_GILGAMESH_EA_ENEMY_NOTIFICATION_TITLE"))
							

							save("GAME", "Decisions_GilgameshEa_Monitors", true)		
							save(pPlayer, sKey, Game:GetGameTurn())
							save(pPlayer, "Decisions_GilgameshEa", cityID)
						end
						)
					end
				end
			end
		end
	end
	)

	Decisions_GilgameshEa.Monitors = {}
	Decisions_GilgameshEa.Monitors[GameEvents.PlayerDoTurn] = (
	function(iPlayer)
		local pPlayer = Players[iPlayer]
		if load(pPlayer, "Decisions_GilgameshEa") and pPlayer:IsAlive() then
			local cityID = load(pPlayer, "Decisions_GilgameshEa")
			local pCity = Vice_DecompileCityID(cityID)
			if pCity then
				local sKey = "Decisions_GilgameshEa" .. cityID
				local iEnactTurn = load(pPlayer, sKey)
				local iThisTurn = Game:GetGameTurn()
				local pCapital = pPlayer:GetCapitalCity()
				local iResistTurns = math.ceil(iResistMod * math.floor(Map.PlotDistance(pCapital:GetX(), pCapital:GetY(), pCity:GetX(), pCity:GetY()) / 5))
				local iTravelTurns = math.ceil(iResistTurns / 2)
				
				if iThisTurn - iTravelTurns == iEnactTurn then
					--Account for if Gil and his opponent have made peace; if so, nothing will happen

					if Teams[pPlayer:GetTeam()]:IsAtWar(Players[pCity:GetOwner()]:GetTeam()) then

						local pEa = pPlayer:InitUnit(iGilEaUnit, pCity:GetX() - 1, pCity:GetY() - 1, UNITAI_ICBM)

						if pPlayer:GetID() == Game:GetActivePlayer() then
							UI.SelectUnit(pEa)
							Game.SelectionListGameNetMessage(GameMessageTypes.GAMEMESSAGE_PUSH_MISSION, MissionTypes.MISSION_NUKE, pCity:GetX(), pCity:GetY(), 0, false, false)
						elseif not pPlayer:IsHuman() then
							pEa:PushMission(MissionTypes.MISSION_NUKE, -1, -1, 0, 0, 0, 0, pCity:GetPlot(), pEa)
						end

					end
				elseif iThisTurn - iResistTurns == iEnactTurn then
					save(pPlayer, "Decisions_GilgameshEa", nil)
					save(pPlayer, sKey, nil)
				end
			end
		end
	end
	)
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_SUMER_FSN, "Decisions_GilgameshEa", Decisions_GilgameshEa)


--Modified from EventsAndDecisions_Utilities.lua
function Vice_DecompileCityID(sKey)
    local iBreak = string.find(sKey, "Y")
	local iBreak2 = string.find(sKey, "P")
    iX = tonumber(string.sub(sKey, 2, iBreak - 1))
    iY = tonumber(string.sub(sKey, iBreak + 1, iBreak2 - 1))
    local pPlot = Map.GetPlot(iX, iY)
	local pCity = pPlot:GetPlotCity()
    return pCity
end