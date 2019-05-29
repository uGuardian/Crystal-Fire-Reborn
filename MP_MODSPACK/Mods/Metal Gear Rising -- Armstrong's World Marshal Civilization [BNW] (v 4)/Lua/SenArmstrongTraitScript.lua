-- Senator Armstrong's Trait Script
-- Author: Vicevirtuoso
-- DateCreated: 2/1/2014 12:02:33 PM
--------------------------------------------------------------

local tWhoIsArmstrong = {}

function GetTraitDelegates(iPlayer)
	local pPlayer = Players[iPlayer]
	leaderType = GameInfo.Leaders[pPlayer:GetLeaderType()].Type
	traitType = GameInfo.Leader_Traits("LeaderType ='" .. leaderType .. "'")().TraitType
	trait = GameInfo.Traits[traitType]
	return trait.DelegatesFromWar, trait.UnitsRequiredForWarDelegates
end

for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
	local iDelegates, iUnitsNeeded = GetTraitDelegates(i)
	if iDelegates > 0 and iUnitsNeeded > 0 then
		tWhoIsArmstrong[i] = {
		["Delegates"] = iDelegates,
		["UnitsNeeded"] = iUnitsNeeded
		}
	end
end


function WarOffOurShores(iPlayer)
	if tWhoIsArmstrong[iPlayer] then
		local pPlayer = Players[iPlayer]
		local iDelegates = 0;
		for iEnemyPlayer, pEnemyPlayer in pairs(Players) do
			if iEnemyPlayer == iPlayer or iEnemyPlayer == 63 or pEnemyPlayer:IsMinorCiv() then 
				iDelegates = iDelegates;
			elseif Teams[pEnemyPlayer:GetTeam()]:IsAtWar(Teams[pPlayer:GetTeam()]) then
				local iNumForeignUnits = 0;
				for pUnit in pPlayer:Units() do
					if pUnit:IsCombatUnit() then
						if pUnit:GetPlot():GetOwner() == iEnemyPlayer then
							iNumForeignUnits = iNumForeignUnits + 1;
							if iNumForeignUnits >= tWhoIsArmstrong[iPlayer].UnitsRequired then
								iDelegates = iDelegates + tWhoIsArmstrong[iPlayer].Delegates;
								break
							end
						end
					end
				end
			end
		end
		for pCity in pPlayer:Cities() do
			if pCity:IsHasBuilding(GameInfoTypes.BUILDING_DESPERADO_JUNTA) then
				if Players[pCity:GetOriginalOwner()]:IsMinorCiv() and pCity:IsOriginalCapital() then
					if Game:GetCurrentEra() == GameInfoTypes.ERA_INDUSTRIAL or Game:GetCurrentEra() == GameInfoTypes.ERA_MODERN then
						iDelegates = iDelegates + 1
					elseif Game:GetCurrentEra() == GameInfoTypes.ERA_POSTMODERN or Game:GetCurrentEra() == GameInfoTypes.ERA_FUTURE then
						iDelegates = iDelegates + 2
					end
				end
			end
		end
		if MapModData.gArmstrongEventDelegateMod then
			if Game.GetGameTurn() - MapModData.gArmstrongEventDelegateMod.Turn >= MapModData.gArmstrongEventDelegateMod.Duration then
				MapModData.gArmstrongEventDelegateMod = nil
			else
				iDelegates = math.ceil(iDelegates * MapModData.gArmstrongEventDelegateMod.Multiplier)
			end
		end
		pPlayer:GetCapitalCity():SetNumRealBuilding(GameInfoTypes.BUILDING_SENARMSTRONG_ABILITY_BUILDING, iDelegates)
	end
end


GameEvents.PlayerDoTurn.Add(WarOffOurShores)


function ArmstrongDummyPolicy(iPlayer, iX, iY)
	local iFreePolicy = GameInfoTypes.POLICY_ARMSTRONG_DUMMY
	local pPlayer = Players[iPlayer]
	if iPlayer < GameDefines.MAX_MAJOR_CIVS then
		local pCity = Map.GetPlot(iX, iY):GetPlotCity()
		if pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_WORLD_MARSHAL and pCity:IsOriginalCapital() then
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetNumFreePolicies(0)
			pPlayer:SetHasPolicy(iFreePolicy, true)
		end
	end
end

GameEvents.PlayerCityFounded.Add(ArmstrongDummyPolicy)


local sCourthouse = "BUILDING_COURTHOUSE"
local iCourthouse = GameInfoTypes.BUILDING_COURTHOUSE
local iFreeJunta = GameInfoTypes.BUILDING_DESPERADO_JUNTA_FREE

function IronCurtainWorkaroundArmstrong(iCapturedPlayer, iCapital, iX, iY, iCapturingPlayer, iPopulation, bConquest)
	local pCapturedPlayer = Players[iCapturedPlayer];
	local pCapturingPlayer = Players[iCapturingPlayer];
	local pCity = Map.GetPlot(iX, iY):GetPlotCity()
	if (pCapturingPlayer:IsAlive()) and bConquest == true and pCapturingPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_WORLD_MARSHAL then
		for policyInfo in GameInfo.Policies() do
			if policyInfo.FreeBuildingOnConquest == sCourthouse then
				if pCapturingPlayer:HasPolicy(policyInfo.ID) then
					pCity:SetNumRealBuilding(iFreeJunta, 1)
					pCity:SetNumRealBuilding(iCourthouse, 0)
					return
				end
			end
		end
	end
end

GameEvents.CityCaptureComplete.Add(IronCurtainWorkaroundArmstrong)