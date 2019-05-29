-- Lancer's Trait SCript
-- Author: Vicevirtuoso
-- DateCreated: 9/19/2013 5:06:20 PM
--------------------------------------------------------------

include("PlotIterators.lua")

--=======================================================================================================================
-- Init
--=======================================================================================================================
local iIreland = GameInfoTypes.CIVILIZATION_IRELAND_FSN
local iMaxCivs = GameDefines.MAX_MAJOR_CIVS
local iGeneralClass = GameInfoTypes.UNITCLASS_GREAT_GENERAL

local iRadius = 2
local iBuffPromo = GameInfoTypes.PROMOTION_LANCER_GREAT_GENERAL
local iDebuffPromo = GameInfoTypes.PROMOTION_GAE_BUIDHE_CURSE_10

local iImprovement = GameInfoTypes.IMPROVEMENT_RUNE_HENGE_FSN
local iMissionaryClass = GameInfoTypes.UNITCLASS_MISSIONARY
local iBonusFaith = 3 --constant for Faith gain from Missionaries on the Rune Henge improvement

local tLancerPlayers = {}
local bAnyLancerPlayers;

print("Lancer trait script loaded.")

for i = 0, GameDefines.MAX_MAJOR_CIVS -1, 1 do
	local pPlayer = Players[i]
	if pPlayer:IsEverAlive() then
		if pPlayer:GetCivilizationType() == iIreland then
			tLancerPlayers[i] = true
			bAnyLancerPlayers = true
		end
	end
end


if not bAnyLancerPlayers then
	print("Lancer not present on map, no functions will run.")
	return
end


--=======================================================================================================================
-- Saving utilities for Rune Henge plot yields. Copied from Sukritact_SaveUtils.lua.
--=======================================================================================================================
-- Connection to the Modding save data.  Keep one global connection, rather than opening/closing, to speed up access
g_SaveData = Modding.OpenSaveData();
g_Properties = nil;
-------------------------------------------------------------- 
-- Access the modding database entries through a locally cached table
function GetPersistentProperty(name)
	if(g_Properties == nil) then
		g_Properties = {};
	end
	
	if(g_Properties[name] == nil) then
		g_Properties[name] = g_SaveData.GetValue(name);
	end
	
	return g_Properties[name];
end
--------------------------------------------------------------
-- Access the modding database entries through a locally cached table
function SetPersistentProperty(name, value)
	if(g_Properties == nil) then
		g_Properties = {};
	end
	
	if (g_Properties[name] ~= value) then
		g_SaveData.SetValue(name, value);
		g_Properties[name] = value;
	end
end



--=======================================================================================================================
-- Mystic Face
--=======================================================================================================================


GameEvents.GetScenarioDiploModifier1.Add(function(iPlayer1, iPlayer2)
	local pPlayer1 = Players[iPlayer1]
	local pPlayer2 = Players[iPlayer2]
	if (pPlayer1:GetCivilizationType() == iIreland) then
		if (Locale.ConvertTextKey("{@1: gender feminine?yes; other?no}", pPlayer2:GetNameKey()) == "yes") then
			return -30
		end
	elseif (pPlayer2:GetCivilizationType() == iIreland) then
		if (Locale.ConvertTextKey("{@1: gender feminine?yes; other?no}", pPlayer1:GetNameKey()) == "yes") then
			return -30
		end
	else
		return 0
	end
end)

--=======================================================================================================================
-- Gae Buidhe debuff functions
--=======================================================================================================================

function GiveGeneralsDebuffPromotion(iPlayer, iUnitID)
	if tLancerPlayers[iPlayer] then
		local pPlayer = Players[iPlayer];
		local pUnit = pPlayer:GetUnitByID(iUnitID)
		if pUnit then
			if pUnit:GetUnitClassType() == iGeneralClass then
				pUnit:SetHasPromotion(iBuffPromo, true)
			else
				pUnit:SetHasPromotion(iBuffPromo, false)
			end
		end
	end
end

GameEvents.UnitSetXY.Add(GiveGeneralsDebuffPromotion)

function LancerGeneral(iPlayer, iUnit, bTestAllEnemies)
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnit)
	local pTeam = Teams[pPlayer:GetTeam()]
	if not pUnit then return end
	--Test if this unit gets a debuff.
	local bThisUnitStaysDebuffed = LancerGeneralLoopTest(pPlayer, pTeam, pUnit:GetPlot())
	pUnit:SetHasPromotion(iDebuffPromo, bThisUnitStaysDebuffed)
	--Test if any enemy unit gets a debuff, but only if the function call said to do it.
	if bTestAllEnemies then
		for iEnemyPlayer, pEnemyPlayer in pairs(Players) do
			if iEnemyPlayer ~= iPlayer then
				local bIsWar = pTeam:IsAtWar(pEnemyPlayer:GetTeam())
				local pEnemyTeam = Teams[pEnemyPlayer:GetTeam()]
				for pEnemyUnit in pEnemyPlayer:Units() do
					if bIsWar ~= false then 
						bIsWar = LancerGeneralLoopTest(pEnemyPlayer, pEnemyTeam, pEnemyUnit:GetPlot())
					end
					pEnemyUnit:SetHasPromotion(iDebuffPromo, bIsWar)
				end
			end
		end
	end
end


function OnTurnLancerGeneral(iPlayer)
	local pPlayer = Players[iPlayer]
	if iPlayer < iMaxCivs and pPlayer:IsAlive() then
		for pUnit in pPlayer:Units() do
			LancerGeneral(iPlayer, pUnit:GetID(), false)
		end
	end
end

GameEvents.PlayerDoTurn.Add(OnTurnLancerGeneral)

function OnSetXYLancerGeneral(iPlayer, iUnit, iX, iY)
	if iX > 0 and iY > 0 and iPlayer < iMaxCivs then
		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iUnit)
		LancerGeneral(iPlayer, iUnit, pUnit:IsHasPromotion(iBuffPromo))
	end
end

GameEvents.UnitSetXY.Add(OnSetXYLancerGeneral)


function LancerGeneralLoopTest(pPlayer, pTeam, pPlot)
	for pAreaPlot in PlotAreaSpiralIterator(pPlot, iRadius, 1, true, true, false) do
		if pAreaPlot:IsUnit() then
			for c = 0, pAreaPlot:GetNumUnits() - 1 do
				local pPlotUnit = pAreaPlot:GetUnit(c)
				if pPlotUnit then
					local pPlotOwner = Players[pPlotUnit:GetOwner()]
					local iPlotTeam = pPlotOwner:GetTeam()
					if pTeam:IsAtWar(iPlotTeam) and pPlotUnit:IsHasPromotion(iBuffPromo) then
						return true
					end
				end
			end
		end
	end
	return false
end


--=======================================================================================================================
-- Rune Henge
--=======================================================================================================================


function SaveLancerRuneHenge(pPlot, iVal)
	if not pPlot then
		print("SaveLancerRuneHenge error: pPlot is invalid")
		return false
	end

	--Only save number values
	if type(iVal) ~= "number" then 
		print("SaveLancerRuneHenge error: iVal is not a number")
		return false
	end	

	local sKey = "LancerFSNMod_"..tostring(pPlot:GetX())..tostring(pPlot:GetY())

	SetPersistentProperty(sKey, iVal)
end

function LoadLancerRuneHenge(pPlot)
	if not pPlot then
		print("LoadLancerRuneHenge error: pPlot is invalid")
		return false
	end

	local sKey = "LancerFSNMod_"..tostring(pPlot:GetX())..tostring(pPlot:GetY())

	local retVal = GetPersistentProperty(sKey)

	if not retVal then retVal = 0 end

	return retVal
end


function RuneHenge(iPlayer, pPlot)
	if not pPlot then return false end

	local iCurVal = LoadLancerRuneHenge(pPlot)

	local bIncrease = false

	if pPlot:GetImprovementType() == iImprovement then
		bIncrease = true
	end

	if bIncrease then
		bIncrease = false
		for c = 0, pPlot:GetNumUnits() - 1 do
			local pPlotUnit = pPlot:GetUnit(c)
			if pPlotUnit and pPlotUnit ~= pUnit then
				if pPlotUnit:GetOwner() == iPlayer and pPlotUnit:GetUnitClassType() == iMissionaryClass then
					bIncrease = true
					break
				end
			end
		end
	end

	if bIncrease then
		if iCurVal == iBonusFaith then
			return true
		else
			Game.SetPlotExtraYield(pPlot:GetX(), pPlot:GetY(), YieldTypes.YIELD_FAITH, iBonusFaith)
			SaveLancerRuneHenge(pPlot, iBonusFaith)
		end
	else
		if iCurVal == iBonusFaith then
			Game.SetPlotExtraYield(pPlot:GetX(), pPlot:GetY(), YieldTypes.YIELD_FAITH, -iBonusFaith)
			SaveLancerRuneHenge(pPlot, 0)
		else
			return true
		end
	end
end


function OnTurnRuneHenge(iPlayer, iUnit, iX, iY)
	--This should run for all Civs, since it's entirely possible for other Civs to take Lancer's cities with Rune Henges.
	if iPlayer < iMaxCivs then
		local pPlayer = Players[iPlayer]
		local tRuneHenges = {}
		for pCity in pPlayer:Cities() do
			local iNumPlots = pCity:GetNumCityPlots();
			for iPlot = 0, iNumPlots - 1 do
				local pPlot = pCity:GetCityIndexPlot(iPlot)
				RuneHenge(iPlayer, pPlot)
				if pPlot:GetImprovementType() == iImprovement then
					tRuneHenges[#tRuneHenges + 1] = pPlot
				end
			end
		end
		--AI helper: will only run for Lancer to save time
		if tLancerPlayers[iPlayer] and not pPlayer:IsHuman() then
			local tAvailableMissionaries = {}
			for pUnit in pPlayer:Units() do
				if pUnit:GetUnitClassType() == iMissionaryClass then
					tAvailableMissionaries[#tAvailableMissionaries + 1] = pUnit
				end
			end
			if #tAvailableMissionaries > 0 and #tRuneHenges > 0 then
				--We will currently consider it most important to have every Rune Henge covered, rather than try to figure out which ones should be spreading religion or not.
				--However, we will try to find the closest one to the plot.
				for i, pPlot in pairs(tRuneHenges) do
					local pBestUnit;
					local iSmallestDistance = 99999
					for j, pUnit in pairs(tAvailableMissionaries) do
						local iDistance = Map.PlotDistance(pPlot:GetX(), pPlot:GetY(), pUnit:GetX(), pUnit:GetY())
						if iDistance < iSmallestDistance then
							pBestUnit = pUnit
							iSmallestDistance = iDistance
							if iDistance == 0 then
								break
							end
						end
					end
					if pBestUnit then
						pBestUnit:PopMission()
						local iMission;
						if iSmallestDistance == 0 then
							iMission = MissionTypes.MISSION_MOVE_TO
						else
							iMission = MissionTypes.MISSION_SLEEP
						end
						pBestUnit:PushMission(iMission, pPlot:GetX(), pPlot:GetY(), 0, 0, 1, iMission, pUnit:GetPlot(), pUnit)
						for j, pUnit in pairs(tAvailableMissionaries) do
							if pUnit == pBestUnit then
								tAvailableMissionaries[j] = nil
							end
						end	
					end
				end
			end
		end
	end

end

GameEvents.PlayerDoTurn.Add(OnTurnRuneHenge)

function OnMoveRuneHenge(iPlayer, iUnit, iX, iY)
	if iX > 0 and iY > 0 and iPlayer < iMaxCivs then
		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iPlayer)
		if pUnit and pUnit:GetUnitClassType() == iMissionaryClass then
			for pCity in pPlayer:Cities() do
				local iNumPlots = pCity:GetNumCityPlots();
				for iPlot = 0, iNumPlots - 1 do
					local pPlot = pCity:GetCityIndexPlot(iPlot)
					RuneHenge(iPlayer, pPlot)
				end
			end
		end
	end
end

GameEvents.UnitSetXY.Add(OnMoveRuneHenge)