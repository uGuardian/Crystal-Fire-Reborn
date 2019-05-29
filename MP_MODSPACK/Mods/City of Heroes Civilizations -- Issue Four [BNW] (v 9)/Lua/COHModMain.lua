-- City of Heroes Civilizations: Issue Four
-- Author: Vicevirtuoso
-- DateCreated: 10/4/2014 2:40:41 PM
--------------------------------------------------------------

include('COHSharedFunctions.lua');
include('StatesmanTraitScript.lua');
include('RecluseTraitScript.lua');
include('ColeTraitScript.lua');
include('NemesisTraitScript.lua');
include('HrodtohzTraitScript.lua');
include('COHUniqueUnitScripts.lua');
include('PlotIterators.lua');


tSciencePerMoreAdvancedEnemyUnit = {}
tGreatPeopleSpawnAsVillains = {}
tVictoryPointsPerStrengthPoint = {}
tNemesisPlayers = {}
tRiktiPlayers = {}

local iNemesisType = GameInfoTypes.CIVILIZATION_NEMESIS
local iRiktiType = GameInfoTypes.CIVILIZATION_RIKTI


local bAnyStatesman;
local bAnyRecluse;
local bAnyCole;
local bAnyNemesis;
local bAnyHrodtohz;

for i = 0, GameDefines.MAX_MAJOR_CIVS -1, 1 do
	local pPlayer = Players[i]
	if pPlayer:IsEverAlive() then
		local leaderType = GameInfo.Leaders[pPlayer:GetLeaderType()].Type
		local traitType = GameInfo.Leader_Traits("LeaderType ='" .. leaderType .. "'")().TraitType
		local pTrait = GameInfo.Traits[traitType]
		if pTrait.SciencePerMoreAdvancedEnemyUnit > 0 then
			tSciencePerMoreAdvancedEnemyUnit[i] = pTrait.SciencePerMoreAdvancedEnemyUnit
			bAnyStatesman = true
		end
		if pTrait.GreatPeopleSpawnAsVillains == 1 then
			tGreatPeopleSpawnAsVillains[i] = pTrait.SciencePerMoreAdvancedEnemyUnit
			bAnyRecluse = true
		end
		if pTrait.VictoryPointsPerStrengthPoint > 0 then
			tVictoryPointsPerStrengthPoint[i] = pTrait.VictoryPointsPerStrengthPoint
			bAnyCole = true
		end
		--I'm lazy and don't feel like adding fields to the Traits table for Nemesis and Hro'dtohz, so I'm just hardcoding their Civ types.
		if pPlayer:GetCivilizationType() == iNemesisType then
			tNemesisPlayers[i] = true
			bAnyNemesis = true
		end
		if pPlayer:GetCivilizationType() == iRiktiType then
			tRiktiPlayers[i] = true
			bAnyHrodtohz = true
		end
	end
end


if bAnyStatesman then
	print("Statesman's trait script loaded.")
	GameEvents.PlayerDoTurn.Add(StatesmanScience)
	GameEvents.PlayerDoTurn.Add(Wentworths)
end

if bAnyRecluse then
	print("Recluse's trait script loaded.")
	GameEvents.UnitSetXY.Add(OnGPSpawn)
	GameEvents.CanSaveUnit.Add(OnCanSaveUnit)
	GameEvents.UnitKilledInCombat.Add(OnUnitKilled)
end

if bAnyCole then
	print("Cole's trait script loaded.")
	GameEvents.PlayerDoTurn.Add(StrengthFromVictoryPoints)
end

if bAnyNemesis then
	print("Nemesis's trait script loaded.")
	GameEvents.PlayerDoTurn.Add(NemesisIntrigueBonus)
	GameEvents.CanSaveUnit.Add(OnNemesisCanSaveUnit)
	GameEvents.UnitKilledInCombat.Add(OnNemesisUnitKilledInCombat)
end

if bAnyHrodtohz then
	print("Hro'dtohz's trait script loaded.")
	GameEvents.PlayerDoTurn.Add(RiktiPortalUpkeep)
	GameEvents.UnitSetXY.Add(ReplaceRiktiGeneral)
end


GameEvents.UnitSetXY.Add(LongbowRiflemanBonus)
GameEvents.PlayerDoTurn.Add(DenouncementUpkeep)
GameEvents.CanSaveUnit.Add(OnCanSaveUnitTheHarderTheyFall)
GameEvents.UnitKilledInCombat.Add(TheHarderTheyFall)
GameEvents.PlayerDoTurn.Add(NemesisTriage)


GameEvents.SetPopulation.Add(COHCityNamesDynamic)