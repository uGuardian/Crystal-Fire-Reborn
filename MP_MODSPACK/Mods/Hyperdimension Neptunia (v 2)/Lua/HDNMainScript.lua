-- Neptunia Civs Main Script
-- Author: Vice
-- DateCreated: 3/18/2015 12:44:28 AM
--------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- INITIALIZATION
--------------------------------------------------------------------------------------------------------------------------------------------------------
print("Hyperdimension Neptunia mod beginning load.")

MapModData.HDNMod = {} -- empty the table

---------------------Constants------------------------------------------
local iMaxCivs = GameDefines.MAX_MAJOR_CIVS

-- We're going to try not making Shares production require consumption of Faith. Instead, the need to eliminate enemy Religions and the race to found a Religion in the first place
-- will justify the Faith each human form's UB/UI gives them.

local tFaithRequirementsForShares = {
	-- [GameInfoTypes.ERA_ANCIENT]		=	10,
	-- [GameInfoTypes.ERA_CLASSICAL]	=	10,
	-- [GameInfoTypes.ERA_MEDIEVAL]	=	10,
	-- [GameInfoTypes.ERA_RENAISSANCE] =	20,
	-- [GameInfoTypes.ERA_INDUSTRIAL]	=	40,
	-- [GameInfoTypes.ERA_MODERN]		=	60,
	-- [GameInfoTypes.ERA_POSTMODERN]	=	80,
	-- [GameInfoTypes.ERA_FUTURE]		=	100
}

local PRODUCTION_SPEED_MOD = GameInfo.GameSpeeds[PreGame.GetGameSpeed()].ConstructPercent / 100
--NOTE: this is still here in case I need it, but Shares are no longer going to scale with game speed.

--Constants for Shares system.
--These have all been pushed out to GameDefines!

local HDD_SHARE_THRESHOLD = GameDefines.VV_HDN_HDD_SHARE_THRESHOLD
local MAXIMUM_SHARES = GameDefines.VV_HDN_MAXIMUM_SHARES
local HDD_CONVERT_COOLDOWN_TURNS = GameDefines.VV_HDN_HDD_CONVERT_COOLDOWN_TURNS
local HDD_SHARE_LOSS_PER_TURN = GameDefines.VV_HDN_HDD_SHARE_LOSS_PER_TURN

--Share sources from Religion.
local PROPHET_EXPEND_SHARES = GameDefines.VV_HDN_PROPHET_EXPEND_SHARES
local RELIGION_FOLLOWER_SHARES = GameDefines.VV_HDN_RELIGION_FOLLOWER_SHARES

--Share sources from Buildings and Improvements.
local tShareBuildings = {}
local tShareImprovements = {}

for row in GameInfo.Buildings() do
	if row.VV_SharesChange ~= 0 or row.VV_SharesChangeOthers ~= 0 then
		tShareBuildings[row.ID] = {
			["Neps"] = row.VV_SharesChange,
			["Others"] = row.VV_SharesChangeOthers
		}
	end
end

for row in GameInfo.Improvements() do
	if row.VV_SharesChange ~= 0 or row.VV_SharesChangeOthers ~= 0 then
		tShareImprovements[row.ID] = {
			["Neps"] = row.VV_SharesChange,
			["Others"] = row.VV_SharesChangeOthers
		}
	end
end

--Share sources from Happiness.
local HAPPINESS_SHARES = GameDefines.VV_HDN_HAPPINESS_SHARES
local UNHAPPINESS_SHARES = GameDefines.VV_HDN_UNHAPPINESS_SHARES

--Share sources from Tourism.
local INFLUENCE_SHARES = GameDefines.VV_HDN_INFLUENCE_SHARES

--Share sources from War.
local BARBARIAN_KILL_SHARES = GameDefines.VV_HDN_BARBARIAN_KILL_SHARES
local OTHERS_KILL_SHARES = GameDefines.VV_HDN_OTHERS_KILL_SHARES
local OTHERS_LOSS_SHARES = GameDefines.VV_HDN_OTHERS_LOSS_SHARES
local NEPTUNIA_KILL_SHARES = GameDefines.VV_HDN_NEPTUNIA_KILL_SHARES
local CITY_CAPTURE_SHARES = GameDefines.VV_HDN_CITY_CAPTURE_SHARES

--Share sources from Production.
local SHARES_PROCESS = GameInfoTypes.PROCESS_VV_HDN_SHARES
local SHARE_PROCESS_MULTIPLIER = GameDefines.VV_HDN_SHARE_PROCESS_MULTIPLIER
local SHARE_PROCESS_MULTIPLIER_NO_RELIGION = GameDefines.VV_HDN_SHARE_PROCESS_MULTIPLIER_NO_RELIGION

--Misc stuff
local iBuildingSellKey = 23852582 --arbitrary number used for the Network.SendSellBuilding netplay syncing trick
local bWFTW = GameInfoTypes.UNIT_PMMM_MAGICAL_GIRL and true or false   --WFTW makes a few changes to things
---------------------End Constants----------------------------------------------------------------------------------------------


-- Find out which leaders present in the game can use the Shares system.
-- Start by caching every Civ present in the game's trait.
local tTraitCache = {}

function CacheLeaderTraits(iPlayer)
	if iPlayer then
		local pPlayer = Players[iPlayer]
		if pPlayer:IsEverAlive() then
			local leaderType = GameInfo.Leaders[pPlayer:GetLeaderType()].Type
			local traitType = GameInfo.Leader_Traits("LeaderType ='" .. leaderType .. "'")().TraitType
			tTraitCache[traitType] = i
		end
	else
		for i = 0, iMaxCivs - 1, 1 do
			local pPlayer = Players[i]
			if pPlayer:IsEverAlive() then
				local leaderType = GameInfo.Leaders[pPlayer:GetLeaderType()].Type
				local traitType = GameInfo.Leader_Traits("LeaderType ='" .. leaderType .. "'")().TraitType
				tTraitCache[traitType] = i
			end
		end
	end
end
CacheLeaderTraits();

--Cache data for HDD transformations, including which leader goes to which Civ, Dummy buildings/policies to swap between when transforming,
--trait-based Share gains, and extra scripts to load.
local bAnyHDNCivs = false
local tHDNCivs = {}
local tHDDModeLeaders = {}
local tNormalToHDD = {}
local tHDDToNormal = {}
local tCivLeaderLinks = {}
local tUBDummies = {}
local tDummyPolicies = {}
local tScriptsToInclude = {}
local tSharesHDDCostChange = {}
local tSharesGreatWorks = {}
local tSharesTerrain = {}
local tSharesFriendships = {}
local tSharesAllies = {}
local tSharesCounterspies = {}
local tShareProcessMultipliers = {}
local tSharesAnnexedPopulation = {}
local tSharesWonders = {}
local tSharesAfraidCS = {}
local tSharesAfraidCivs = {}

function CacheHDNLeaderData()
	for row in GameInfo.Trait_VV_HDDModes() do
		if tTraitCache[row.NormalTraitType] or tTraitCache[row.HDDTraitType] then
			local iPlayer = tTraitCache[row.NormalTraitType] and tTraitCache[row.NormalTraitType] or tTraitCache[row.HDDTraitType]
			tHDNCivs[iPlayer] = true
			local iHumanForm;
			local iHDDForm;
			local sHumanTrait;
			local sHDDTrait;
			for row2 in GameInfo.Leader_Traits() do
				--Find IDs from Leaders table of Human and HDD forms
				if row2.TraitType == row.NormalTraitType then
					iHumanForm = GameInfo.Leaders[row2.LeaderType].ID
					sHumanTrait = row.NormalTraitType
				elseif row2.TraitType == row.HDDTraitType then
					iHDDForm = GameInfo.Leaders[row2.LeaderType].ID
					sHDDTrait = row.HDDTraitType
				end
				if iHumanForm and iHDDForm then break end
			end
			if iHumanForm and iHDDForm then
				--Add to the tables which define which leaders are HDD modes, and the ones linking Human to HDD and reverse.
				tHDDModeLeaders[iHDDForm] = true
				tNormalToHDD[iHumanForm] = iHDDForm
				tHDDToNormal[iHDDForm] = iHumanForm
				--Find the Civilization to which each Leader belongs
				local iHumanCiv;
				local iHDDCiv;
				for row3 in GameInfo.Civilization_Leaders() do
					if GameInfo.Leaders[iHumanForm].Type == row3.LeaderheadType then
						iHumanCiv = GameInfo.Civilizations[row3.CivilizationType].ID
					elseif GameInfo.Leaders[iHDDForm].Type == row3.LeaderheadType then
						iHDDCiv = GameInfo.Civilizations[row3.CivilizationType].ID
					end
					if iHumanCiv and iHDDCiv then
						break
					end
				end
				if iHumanCiv and iHDDCiv then
					tCivLeaderLinks[iHumanForm] = iHumanCiv
					tCivLeaderLinks[iHDDForm] = iHDDCiv
					bAnyHDNCivs = true
				end
				--Find what unique Shares bonuses they get from their UAs.
				local trait = GameInfo.Traits[sHumanTrait]
				if trait.VV_Shares_HDDCostChange ~= 0 then
					tSharesHDDCostChange[sHumanTrait] = trait.VV_Shares_HDDCostChange
				end
				if trait.VV_Shares_GreatWorks ~= 0 then
					tSharesGreatWorks[sHumanTrait] = trait.VV_Shares_GreatWorks
				end
				if trait.VV_Shares_Friendships ~= 0 then
					tSharesFriendships[sHumanTrait] = trait.VV_Shares_Friendships
				end
				if trait.VV_Shares_CSAllies ~= 0 then
					tSharesAllies[sHumanTrait] = trait.VV_Shares_CSAllies
				end
				if trait.VV_Shares_Counterspies ~= 0 then
					tSharesCounterspies[sHumanTrait] = trait.VV_Shares_Counterspies
				end
				if trait.VV_Shares_ProcessMultiplier ~= 0 then
					tShareProcessMultipliers[sHumanTrait] = trait.VV_Shares_ProcessMultiplier
				end
				if trait.VV_Shares_Wonders ~= 0 then
					tSharesWonders[sHumanTrait] = trait.VV_Shares_Wonders
				end
				if trait.VV_Shares_AfraidCS ~= 0 then
					tSharesAfraidCS[sHumanTrait] = trait.VV_Shares_AfraidCS
				end
				if trait.VV_Shares_AfraidCivs ~= 0 then
					tSharesAfraidCivs[sHumanTrait] = trait.VV_Shares_AfraidCivs
				end
				if trait.VV_Shares_AnnexedPopulationTimes100 ~= 0 then
					tSharesAnnexedPopulation[sHumanTrait] = trait.VV_Shares_AnnexedPopulationTimes100
				end
				
				for row4 in GameInfo.Trait_VV_Shares_Terrain("TraitType ='" .. sHumanTrait .. "'") do
					if not tSharesTerrain[sHumanTrait] then tSharesTerrain[sHumanTrait] = {} end
					tSharesTerrain[sHumanTrait][#tSharesTerrain[sHumanTrait] + 1] = {
						["Terrain"] = GameInfo.Terrains[row4.TerrainType].ID,
						["Shares"] = row4.Shares
					}
				end
				
				local trait = GameInfo.Traits[sHDDTrait]
				if trait.VV_Shares_HDDCostChange ~= 0 then
					tSharesHDDCostChange[sHDDTrait] = trait.VV_Shares_HDDCostChange
				end
				if trait.VV_Shares_GreatWorks ~= 0 then
					tSharesGreatWorks[sHDDTrait] = trait.VV_Shares_GreatWorks
				end
				if trait.VV_Shares_Friendships ~= 0 then
					tSharesFriendships[sHDDTrait] = trait.VV_Shares_Friendships
				end
				if trait.VV_Shares_CSAllies ~= 0 then
					tSharesAllies[sHDDTrait] = trait.VV_Shares_CSAllies
				end
				if trait.VV_Shares_Counterspies ~= 0 then
					tSharesCounterspies[sHDDTrait] = trait.VV_Shares_Counterspies
				end
				if trait.VV_Shares_ProcessMultiplier ~= 0 then
					tShareProcessMultipliers[sHDDTrait] = trait.VV_Shares_ProcessMultiplier
				end
				if trait.VV_Shares_Wonders ~= 0 then
					tSharesWonders[sHDDTrait] = trait.VV_Shares_Wonders
				end
				if trait.VV_Shares_AfraidCS ~= 0 then
					tSharesAfraidCS[sHDDTrait] = trait.VV_Shares_AfraidCS
				end
				if trait.VV_Shares_AfraidCivs ~= 0 then
					tSharesAfraidCivs[sHDDTrait] = trait.VV_Shares_AfraidCivs
				end
				if trait.VV_Shares_AnnexedPopulationTimes100 ~= 0 then
					tSharesAnnexedPopulation[sHDDTrait] = trait.VV_Shares_AnnexedPopulationTimes100
				end
				
				for row4 in GameInfo.Trait_VV_Shares_Terrain("TraitType ='" .. sHDDTrait .. "'") do
					if not tSharesTerrain[sHDDTrait] then tSharesTerrain[sHDDTrait] = {} end
					tSharesTerrain[sHDDTrait][#tSharesTerrain[sHDDTrait] + 1] = {
						["Terrain"] = GameInfo.Terrains[row4.TerrainType].ID,
						["Shares"] = row4.Shares
					}
				end
				
				if row.NormalDummyBuilding then 
					tUBDummies[iHumanForm] = GameInfo.Buildings[row.NormalDummyBuilding].ID
				end
				if row.HDDDummyBuilding then 
					tUBDummies[iHDDForm] = GameInfo.Buildings[row.HDDDummyBuilding].ID
				end
				if row.NormalDummyPolicy then 
					tDummyPolicies[iHumanForm] = GameInfo.Policies[row.NormalDummyPolicy].ID
				end
				if row.HDDDummyPolicy then 
					tDummyPolicies[iHDDForm] = GameInfo.Policies[row.HDDDummyPolicy].ID
				end
				if row.ScriptName then
					tScriptsToInclude[row.ScriptName] = true
				end
			end
		end
	end
	tTraitCache = nil --no longer necessary after initialization
end
CacheHDNLeaderData();

--Start TSL if any HDN Civs are in the game
if bAnyHDNCivs == true then
	print("At least one Share System-enabled Civ is present in the game.")

	MapModData.HDNMod.Shares = {}
	MapModData.HDNMod.TransformedTurn = {}
	MapModData.HDNMod.UsedCityHeaders = {}
	MapModData.HDNMod.CulDivInit = nil
	MapModData.HDNMod.ExtraShareSources = {}
	-- MapModData.HDNMod.GreatGameDevProgress = {}
	-- MapModData.HDNMod.GreatGameDevProgressNeeded = {}
	-- MapModData.HDNMod.NepgearCitiesTurn = {}
	-- MapModData.HDNMod.UniGotFreeSpy = {}
	-- MapModData.HDNMod.HistoireEnergy = {}
	-- MapModData.HDNMod.HistoireCity = {}
	-- MapModData.HDNMod.HistoireTravelTurns = {}
	HDNMod = MapModData.HDNMod

	include("TableSaverLoader016.lua");
	include("TSLSerializerV3Neptunia.lua");

	TableLoad(HDNMod, "HDNMod")
	TableSave(HDNMod, "HDNMod")
	HDNMod = MapModData.HDNMod
else
	MapModData.HDNMod = nil
end

function OnLoadScreenCloseInitialization()
	--Set Dummy policies.
	for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
		local pPlayer = Players[i]
		if pPlayer:IsAlive() then
			local iLeaderType = pPlayer:GetLeaderType()
			local iOtherLeaderType;
			if tHDDModeLeaders[iLeaderType] then
				iOtherLeaderType = tHDDToNormal[iLeaderType]
			else
				iOtherLeaderType = tNormalToHDD[iLeaderType]
			end
			--Dummy Policy Set
			if tDummyPolicies[iLeaderType] and (not pPlayer:HasPolicy(tDummyPolicies[iLeaderType]) and not pPlayer:HasPolicy(tDummyPolicies[iOtherLeaderType])) then
				pPlayer:SetNumFreePolicies(1)
				pPlayer:SetNumFreePolicies(0)
				pPlayer:SetHasPolicy(tDummyPolicies[iLeaderType], true)
			end
		end
	end
end

Events.LoadScreenClose.Add(OnLoadScreenCloseInitialization)

include("FLuaVector.lua")
include("VV_PlotIt.lua");

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- HELPER FUNCTIONS
--------------------------------------------------------------------------------------------------------------------------------------------------------

function IsPlayerHDDMode(pPlayer)
	local iLeaderType = pPlayer:GetLeaderType();
	return tHDDModeLeaders[iLeaderType] and tHDDModeLeaders[iLeaderType] or false;
end

function GetLeaderTraitType(pPlayer)
	--Returns Type string (e.g. "TRAIT_VV_NEPTUNE")
	local leaderType = GameInfo.Leaders[pPlayer:GetLeaderType()].Type
	local traitType = GameInfo.Leader_Traits("LeaderType ='" .. leaderType .. "'")().TraitType
	return traitType
end

function CanPlayerTransform(iPlayer, bReturnText)
	if tHDNCivs[iPlayer] == true then
		if (not HDNMod.TransformedTurn[iPlayer]) or (Game:GetGameTurn() - HDD_CONVERT_COOLDOWN_TURNS >= HDNMod.TransformedTurn[iPlayer]) then
			InitSharesIfNeeded(iPlayer)
			local pPlayer = Players[iPlayer]
			if IsPlayerHDDMode(pPlayer) == true then return true end
			if HDNMod.Shares[iPlayer] >= HDD_SHARE_THRESHOLD then
				return true
			elseif bReturnText then
				return false, Locale.ConvertTextKey("TXT_KEY_VV_HDN_TRANSFORMATION_INSUFFICIENT_SHARES", ConvertToPercentString(HDD_SHARE_THRESHOLD))
			end
		elseif bReturnText then
			return false, Locale.ConvertTextKey("TXT_KEY_VV_HDN_TRANSFORMATION_COOLDOWN", HDD_CONVERT_COOLDOWN_TURNS - (Game:GetGameTurn() - HDNMod.TransformedTurn[iPlayer]))
		end
	end
	return false
end

--Used for the TransformButton so I don't have to re-localize everything there.
function RefreshTransformButton(button, label, context)
	if not button or not label or not context then return end
	if UI.IsCityScreenUp() then
		context:SetHide(true)
		return
	end
	local iPlayer = Game:GetActivePlayer()
	local pPlayer = Players[iPlayer]
	if not pPlayer:GetCapitalCity() then
		context:SetHide(true)
		return
	end
	if tHDNCivs[iPlayer] then
		context:SetHide(false) 
	else
		context:SetHide(true)
		return
	end
	local sTitle;
	local sTooltip;

	local bIsHDD = IsPlayerHDDMode(pPlayer)
	local iLeaderType = pPlayer:GetLeaderType()
	if bIsHDD then
		sTitle = Locale.ConvertTextKey("TXT_KEY_VV_HDN_REVERT_BUTTON")
		sTooltip = Locale.ConvertTextKey("TXT_KEY_VV_HDN_REVERT_BUTTON_TT", GameInfo.Leaders[tHDDToNormal[iLeaderType]].Description)
		for row in GameInfo.Leader_Traits() do
			if row.LeaderType == GameInfo.Leaders[tHDDToNormal[iLeaderType]].Type then
				sTooltip = sTooltip.." "..Locale.ConvertTextKey("TXT_KEY_VV_HDN_TRANSFORM_TRAIT").."[NEWLINE][NEWLINE]"..
				Locale.ConvertTextKey(GameInfo.Traits[row.TraitType].ShortDescription).."[NEWLINE]"..Locale.ConvertTextKey(GameInfo.Traits[row.TraitType].Description)
				break
			end
		end
	else
		sTitle = "[COLOR:31:236:224:255]"..Locale.ConvertTextKey("TXT_KEY_VV_HDN_TRANSFORM_BUTTON").."[ENDCOLOR]"
		sTooltip = Locale.ConvertTextKey("TXT_KEY_VV_HDN_TRANSFORM_BUTTON_TT", GameInfo.Leaders[tNormalToHDD[iLeaderType]].Description)
		for row in GameInfo.Leader_Traits() do
			if row.LeaderType == GameInfo.Leaders[tNormalToHDD[iLeaderType]].Type then
				sTooltip = sTooltip.." "..Locale.ConvertTextKey("TXT_KEY_VV_HDN_TRANSFORM_TRAIT").."[NEWLINE][NEWLINE]"..
				Locale.ConvertTextKey(GameInfo.Traits[row.TraitType].ShortDescription).."[NEWLINE]"..Locale.ConvertTextKey(GameInfo.Traits[row.TraitType].Description)
				break
			end
		end
	end

	local bCanTransform, sError = CanPlayerTransform(iPlayer, true)
	if sError then 
		sTooltip = sTooltip.."[NEWLINE][NEWLINE][COLOR_WARNING_TEXT]"..sError.."[ENDCOLOR]"
	end

	button:SetDisabled(not bCanTransform)
	label:SetText(sTitle)
	button:SetText(sTitle)
	button:SetToolTipString(sTooltip)
end

LuaEvents.VV_RefreshTransformButton.Add(RefreshTransformButton)

function InitSharesIfNeeded(iPlayer)
	if not HDNMod.Shares[iPlayer] then HDNMod.Shares[iPlayer] = 0 end
end

function ConvertToPercentString(value)
	if not value then value = 0 end
	value = value / 100
	return string.format("%.2f%%", value)
end

function GetPlayerSharesPerTurn(iPlayer, bGetTooltip)
	local pPlayer = Players[iPlayer]
	local sTrait = GetLeaderTraitType(pPlayer)
	local iValue = 0
	local tStringTable = {}
	
	local iOurReligion = pPlayer:GetReligionCreatedByPlayer()

	--Shares production from Cities
	local iFromSharesProduction = 0
	local iFromBuildings = 0
	local iFromImprovements = 0
	local iFromTerrain = 0
	
	local iProcessMultiplier = SHARE_PROCESS_MULTIPLIER
	if tHDNCivs[iPlayer] then
		if iOurReligion <= GameInfoTypes.RELIGION_PANTHEON and Game.GetNumReligionsStillToFound() == 0 then
			iProcessMultiplier = SHARE_PROCESS_MULTIPLIER_NO_RELIGION
		end
		if tShareProcessMultipliers[sTrait] then
			iProcessMultiplier = iProcessMultiplier + (tShareProcessMultipliers[sTrait] / 100)
		end
	end
	
	for pCity in pPlayer:Cities() do
		--Shares process
		if pCity:GetProductionProcess() == SHARES_PROCESS then
			iFromSharesProduction = iFromSharesProduction + math.floor(pCity:GetCurrentProductionDifferenceTimes100() * iProcessMultiplier)
		end
		--Buildings
		local sIsNepKey = tHDNCivs[iPlayer] and "Neps" or "Others"
		for iBuilding, _ in pairs(tShareBuildings) do
			if pCity:IsHasBuilding(iBuilding) then
				iFromBuildings = iFromBuildings + (tShareBuildings[iBuilding][sIsNepKey] * pCity:GetNumRealBuilding(iBuilding))
			end
		end

		local iNumPlots = pCity:GetNumCityPlots();
		for iPlot = 0, iNumPlots - 1 do
			local pPlot = pCity:GetCityIndexPlot(iPlot)
			if pPlot then
				--Improvements
				local iImprovement = pPlot:GetImprovementType()
				if tShareImprovements[iImprovement] and pCity:IsWorkingPlot(pPlot) then
					iFromImprovements = iFromImprovements + tShareImprovements[iImprovement][sIsNepKey]
				end
				
				--Terrain (Blanc)
				if tSharesTerrain[sTrait] and pCity:IsWorkingPlot(pPlot) then
					local iTerrainType = pPlot:GetTerrainType()
					for k, v in pairs(tSharesTerrain[sTrait]) do
						if v.Terrain == iTerrainType then
							iFromTerrain = iFromTerrain + v.Shares
						end
					end

				end
			end
		end
	end
	
	iValue = iValue + iFromSharesProduction + iFromBuildings + iFromImprovements + iFromTerrain
	if bGetTooltip then
		if iFromSharesProduction > 0 then
			tStringTable[#tStringTable + 1] = "[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_HDN_SHARES_FROM_CITIES", string.format("%.2f%%", iFromSharesProduction / 100))
		end
		if iFromBuildings > 0 then
			tStringTable[#tStringTable + 1] = "[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_HDN_SHARES_FROM_BUILDINGS", string.format("%.2f%%", iFromBuildings / 100))
		end
		if iFromImprovements > 0 then
			tStringTable[#tStringTable + 1] = "[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_HDN_SHARES_FROM_IMPROVEMENTS", string.format("%.2f%%", iFromImprovements / 100))
		end
		if iFromTerrain > 0 then
			tStringTable[#tStringTable + 1] = "[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_HDN_SHARES_FROM_TERRAIN", string.format("%.2f%%", iFromTerrain / 100))
		end
	end
	
	--Shares from Religious followers.
	if iOurReligion > GameInfoTypes.RELIGION_PANTHEON then
		local iFromFollowers = math.floor(Game.GetNumFollowers(iOurReligion) * RELIGION_FOLLOWER_SHARES)
		iValue = iValue + iFromFollowers
		if bGetTooltip and iFromFollowers > 0 then
			tStringTable[#tStringTable + 1] = "[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_HDN_SHARES_FROM_FOLLOWERS", string.format("%.2f%%", iFromFollowers / 100))
		end
	end
	
	--Shares from Happiness. NOTE: Only HDN Civs get this.
	if tHDNCivs[iPlayer] then
		local iHappiness = pPlayer:GetExcessHappiness()
		local iFromHappiness = 0
		if iHappiness < 0 then
			iFromHappiness = math.floor(iHappiness * UNHAPPINESS_SHARES)
		else
			iFromHappiness = math.floor(iHappiness * HAPPINESS_SHARES)
		end
		iValue = iValue + iFromHappiness
		if bGetTooltip then
			if iFromHappiness < 0 then
				tStringTable[#tStringTable + 1] = "[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_HDN_SHARES_FROM_UNHAPPINESS", string.format("%.2f%%", iFromHappiness / 100))
			elseif iFromHappiness > 0 then
				tStringTable[#tStringTable + 1] = "[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_HDN_SHARES_FROM_HAPPINESS", string.format("%.2f%%", iFromHappiness / 100))
			end
		end
	end
	
	--Shares from Tourism.
	local iFromTourism = 0
	for i = 0, iMaxCivs - 1, 1 do
		if i ~= iPlayer then
			local iInfluenceLevel = pPlayer:GetInfluenceLevel(i);
			if iInfluenceLevel > 0 then
				iFromTourism = iFromTourism + math.floor(iInfluenceLevel * INFLUENCE_SHARES)
			end
		end
	end
	iValue = iValue + iFromTourism
	if bGetTooltip and iFromTourism > 0 then
		tStringTable[#tStringTable + 1] = "[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_HDN_SHARES_FROM_INFLUENCE", string.format("%.2f%%", iFromTourism / 100))
	end
	
	
	--Great Works (Vert)
	if tSharesGreatWorks[sTrait] then
		local iTotalGreatWorks = pPlayer:GetNumGreatWorks();
		local iFromGreatWorks = iTotalGreatWorks * tSharesGreatWorks[sTrait]
		iValue = iValue + iFromGreatWorks
		if bGetTooltip and iFromGreatWorks > 0 then
			tStringTable[#tStringTable + 1] = "[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_HDN_SHARES_FROM_GREAT_WORKS", string.format("%.2f%%", iFromGreatWorks / 100))
		end
	end

	--DoFs and City-State Allies (Nepgear)
	if tSharesFriendships[sTrait] then
		local iTotalFriends = 0
		for i = 0, iMaxCivs - 1, 1 do
			if Players[i]:IsAlive() and pPlayer:IsDoF(i) then
				iTotalFriends = iTotalFriends + 1
			end
		end
		local iFromFriends = iTotalFriends * tSharesFriendships[sTrait]
		iValue = iValue + iFromFriends
		if bGetTooltip and iFromFriends > 0 then
			tStringTable[#tStringTable + 1] = "[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_HDN_SHARES_FROM_FRIENDS", string.format("%.2f%%", iFromFriends / 100))
		end
	end
	if tSharesAllies[sTrait] then
		local iTotalAllies = 0
		for i = iMaxCivs, GameDefines.MAX_CIV_PLAYERS - 1, 1 do
			local pLoop = Players[i]
			if pLoop:IsAlive() and pLoop:GetMinorCivFriendshipLevelWithMajor(iPlayer) >= 2 then
				iTotalAllies = iTotalAllies + 1
			end
		end
		local iFromAllies = iTotalAllies * tSharesAllies[sTrait]
		iValue = iValue + iFromAllies
		if bGetTooltip and iFromAllies > 0 then
			tStringTable[#tStringTable + 1] = "[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_HDN_SHARES_FROM_ALLIES", string.format("%.2f%%", iFromAllies / 100))
		end
	end

	--Counterspies (Uni)
	if tSharesCounterspies[sTrait] then
		local iTotalHomeSpies = 0
		local agents = pPlayer:GetEspionageSpies();
		for k, v in pairs(agents) do
			local pPlot = Map.GetPlot(v.CityX, v.CityY)
			if pPlot then
				local pCity = pPlot:GetPlotCity()
				if pCity and pCity:GetOwner() == iPlayer then
					iTotalHomeSpies = iTotalHomeSpies + 1
				end
			end
		end
		local iFromHomeSpies = iTotalHomeSpies * tSharesCounterspies[sTrait]
		iValue = iValue + iFromHomeSpies
		if bGetTooltip and iFromHomeSpies > 0 then
			tStringTable[#tStringTable + 1] = "[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_HDN_SHARES_FROM_COUNTERSPIES", string.format("%.2f%%", iFromHomeSpies / 100))
		end
	end

	-- Annexed City Population (Neptune's new version)
	if tSharesAnnexedPopulation[sTrait] then
		local iTotalPop = 0
		for pCity in pPlayer:Cities() do
			if (pCity:IsRazing() == false and pCity:IsPuppet() == false) then
				--If CP is active, civs with NoAnnexing which have all of their cities puppeted will automatically de-puppet the capital. Not ideal, so we'll have to make a special exception for the capital.
				-- This does mean that if a player voluntarily makes their Capital have automated production while annexed and running CP, it grants no shares. Oh well!
				if pPlayer.GetWarScore and pCity:IsCapital() then
					if pCity:IsProductionAutomated() == false then
						iTotalPop = iTotalPop + pCity:GetPopulation()
					end
				else
					iTotalPop = iTotalPop + pCity:GetPopulation()
				end
			end
		end
		local iFromAnnexedPop = math.floor(iTotalPop * tSharesAnnexedPopulation[sTrait] / 100)
		iValue = iValue + iFromAnnexedPop
		if bGetTooltip and iFromAnnexedPop > 0 then
			tStringTable[#tStringTable + 1] = "[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_HDN_SHARES_FROM_ANNEXED_POPULATION", string.format("%.2f%%", iFromAnnexedPop / 100))
		end
	end
	
	-- World Wonders (Noire)
	if tSharesWonders[sTrait] then
		local iFromWonders = pPlayer:GetNumWorldWonders() * tSharesWonders[sTrait]
		iValue = iValue + iFromWonders
		if bGetTooltip and iFromWonders > 0 then
			tStringTable[#tStringTable + 1] = "[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_HDN_SHARES_FROM_WONDERS", string.format("%.2f%%", iFromWonders / 100))
		end
	end
	
	-- Afraid City-States (Plutia)
	if tSharesAfraidCS[sTrait] then
		local iTotalAfraid = 0
		local pTeam = Teams[pPlayer:GetTeam()]
		for i = iMaxCivs, GameDefines.MAX_CIV_PLAYERS - 1, 1 do
			local pLoop = Players[i]
			if pLoop:IsAlive() and pTeam:IsHasMet(pLoop:GetTeam()) and (pLoop:CanMajorBullyGold(iPlayer) or pLoop:CanMajorBullyUnit(iPlayer)) then
				iTotalAfraid = iTotalAfraid + 1
			end
		end
		local iFromAfraid = iTotalAfraid * tSharesAfraidCS[sTrait]
		iValue = iValue + iFromAfraid
		if bGetTooltip and iFromAfraid > 0 then
			tStringTable[#tStringTable + 1] = "[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_HDN_SHARES_FROM_AFRAID_CITY_STATES", string.format("%.2f%%", iFromAfraid / 100))
		end
	end
	
	-- Afraid Civs (Plutia)
	if tSharesAfraidCivs[sTrait] then
		local iTotalAfraid = 0
		local pTeam = Teams[pPlayer:GetTeam()]
		for i = 0, iMaxCivs - 1, 1 do
			local pLoop = Players[i]
			if pLoop:IsAlive() and pTeam:IsHasMet(pLoop:GetTeam()) and (pPlayer:GetApproachTowardsUsGuess(i) == MajorCivApproachTypes.MAJOR_CIV_APPROACH_AFRAID) then
				iTotalAfraid = iTotalAfraid + 1
			end
		end
		local iFromAfraid = iTotalAfraid * tSharesAfraidCivs[sTrait]
		iValue = iValue + iFromAfraid
		if bGetTooltip and iFromAfraid > 0 then
			tStringTable[#tStringTable + 1] = "[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_HDN_SHARES_FROM_AFRAID_CIVILIZATIONS", string.format("%.2f%%", iFromAfraid / 100))
		end
	end
	
	--Misc stuff (like Decisions)
	if not HDNMod.ExtraShareSources[iPlayer] then HDNMod.ExtraShareSources[iPlayer] = {} end
	for k, v in pairs(HDNMod.ExtraShareSources[iPlayer]) do
		iValue = iValue + v[1]
		if bGetTooltip then
			tStringTable[#tStringTable + 1] = "[ICON_BULLET]"..Locale.ConvertTextKey(v[2], string.format("%.2f%%", v[1]))
		end
	end
		
	if IsPlayerHDDMode(pPlayer)	== true then
		--Subtract base value if HDD mode
		local iFromHDDLoss = HDD_SHARE_LOSS_PER_TURN
		if tSharesHDDCostChange[sTrait] then
			iFromHDDLoss = iFromHDDLoss + tSharesHDDCostChange[sTrait]
		end
		iValue = iValue - iFromHDDLoss
		tStringTable[#tStringTable + 1] = "[ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_HDN_SHARES_LOSS_PER_TURN", string.format("-%.2f%%", iFromHDDLoss / 100))
	end

	
	if bGetTooltip then
		return iValue, tStringTable
	else
		return iValue
	end
end


function GetOthersShares()
	local iBaseValue = MAXIMUM_SHARES
	for iPlayer, iValue in pairs(HDNMod.Shares) do
		if Players[iPlayer]:IsAlive() then
			iBaseValue = iBaseValue - iValue
		end
	end
	if iBaseValue < 0 then iBaseValue = 0 end
	return iBaseValue
end

function ChangeShares(iPlayer, iValue, iTakeFromPlayer)
	InitSharesIfNeeded(iPlayer)
	--Negative values will be added back to Others, not distributed to HDN Civs.
	if iValue < 0 then
		HDNMod.Shares[iPlayer] = math.max(HDNMod.Shares[iPlayer] + iValue, 0)
	elseif iTakeFromPlayer then
	--Shares stolen directly from another Civ.
		InitSharesIfNeeded(iTakeFromPlayer)
		iValue = math.min(iValue, HDNMod.Shares[iTakeFromPlayer])
		HDNMod.Shares[iPlayer] =			math.min(HDNMod.Shares[iPlayer] + iValue, MAXIMUM_SHARES)
		HDNMod.Shares[iTakeFromPlayer] =	math.max(HDNMod.Shares[iTakeFromPlayer] - iValue, 0)
	else
		--If there is already a total of 100% shares distributed amongst HDN Civs, then take an even amount from each other one.
		--Otherwise, take from the Others pool until it reaches 0%, then begin taking from other HDN Civs.
		local iOthersShares = GetOthersShares()
		if iOthersShares > iValue then
			HDNMod.Shares[iPlayer] = math.min(HDNMod.Shares[iPlayer] + iValue, MAXIMUM_SHARES)
			iValue = 0
		elseif iOthersShares > 0 then
			HDNMod.Shares[iPlayer] = math.min(HDNMod.Shares[iPlayer] + iOthersShares, MAXIMUM_SHARES)
			iValue = iValue - iOthersShares
		end

		if iValue > 0 and HDNMod.Shares[iPlayer] < MAXIMUM_SHARES then

			--If iValue brings them above the maximum, change it to exactly how much they'll need to get to the maximum.
			local iTentativeTotal = HDNMod.Shares[iPlayer] + iValue
			if iTentativeTotal > MAXIMUM_SHARES then
				iValue = MAXIMUM_SHARES - HDNMod.Shares[iPlayer]
			end
			HDNMod.Shares[iPlayer] = math.min(HDNMod.Shares[iPlayer] + iValue, MAXIMUM_SHARES)
			local iNumOtherHDNCivs = 0
			for iEnemyPlayer, iEnemyValue in pairs(HDNMod.Shares) do
				if iPlayer ~= iEnemyPlayer and iEnemyValue > 0 then
					iNumOtherHDNCivs = iNumOtherHDNCivs + 1
				end
			end
			if iNumOtherHDNCivs > 0 then
				--Ideally, we subtract equally from everyone else, but if someone else doesn't have enough, we must take more from the others to compensate.
				local iAverage = math.floor(iValue / iNumOtherHDNCivs)
				local iRemainder = iValue % iNumOtherHDNCivs
				for iEnemyPlayer, iEnemyValue in pairs(HDNMod.Shares) do
					if iPlayer ~= iEnemyPlayer then
						if iEnemyValue > iAverage then
							HDNMod.Shares[iEnemyPlayer] = math.max(HDNMod.Shares[iEnemyPlayer] - iAverage, 0)
						else
							iRemainder = iRemainder + (iAverage - iEnemyValue)
							HDNMod.Shares[iEnemyPlayer] = 0
						end
					end
				end
				while iRemainder > 0 do
					local bAnyoneHasSharesLeft = false
					for iEnemyPlayer, iEnemyValue in pairs(HDNMod.Shares) do
						if iPlayer ~= iEnemyPlayer then
							if iEnemyValue > 0 then
								bAnyoneHasSharesLeft = true
								HDNMod.Shares[iEnemyPlayer] = HDNMod.Shares[iEnemyPlayer] - 1
								iRemainder = iRemainder - 1
								if iRemainder <= 0 then break end
							end
						end
					end
					if not bAnyoneHasSharesLeft then break end
				end
			end
		end
	end
	RefreshSharesDisplay()
end

LuaEvents.HDNChangeShares.Add(ChangeShares)

function AddToOthersShares(iValue)
	local iCurrentOthersShares = GetOthersShares()
	if iCurrentOthersShares + iValue >= MAXIMUM_SHARES then
		iValue = MAXIMUM_SHARES - iCurrentOthersShares
	end
	if iValue > 0 then
		local iNumHDNCivs = 0
		for i, v in pairs(HDNMod.Shares) do
			if v > 0 then
				iNumHDNCivs = iNumHDNCivs + 1
			end
		end
		if iNumHDNCivs > 0 then
			--Ideally, we subtract equally from everyone else, but if someone else doesn't have enough, we must take more from the others to compensate.
			local iAverage = math.floor(iValue / iNumHDNCivs)
			local iRemainder = iValue % iNumHDNCivs
			for iEnemyPlayer, iEnemyValue in pairs(HDNMod.Shares) do
				if iEnemyValue > iAverage then
					HDNMod.Shares[iEnemyPlayer] = math.max(HDNMod.Shares[iEnemyPlayer] - iAverage, 0)
				else
					iRemainder = iRemainder + (iAverage - iEnemyValue)
					HDNMod.Shares[iEnemyPlayer] = 0
				end
			end
			while iRemainder > 0 do
				local bAnyoneHasSharesLeft = false
				for iEnemyPlayer, iEnemyValue in pairs(HDNMod.Shares) do
					if iEnemyValue > 0 then
						bAnyoneHasSharesLeft = true
						HDNMod.Shares[iEnemyPlayer] = HDNMod.Shares[iEnemyPlayer] - 1
						iRemainder = iRemainder - 1
						if iRemainder <= 0 then break end
					end
				end
				if not bAnyoneHasSharesLeft then break end
			end
		end
	end
	RefreshSharesDisplay()
end

function ConvertHDNLeader(pPlayer, bHDDOn)
	local iPlayer = pPlayer:GetID()
	local iLeaderType = pPlayer:GetLeaderType()
	local iNewLeaderType;
	local iNewCivType;
	if bHDDOn == true then
		iNewLeaderType = tNormalToHDD[iLeaderType]
	else
		iNewLeaderType = tHDDToNormal[iLeaderType]
	end
	if iNewLeaderType ~= nil then
		iNewCivType = tCivLeaderLinks[iNewLeaderType]
		if iNewCivType ~= nil then
			print("Converting "..Locale.ConvertTextKey(GameInfo.Leaders[iLeaderType].Description).." to "..Locale.ConvertTextKey(GameInfo.Leaders[iNewLeaderType].Description))
			PreGame.SetCivilization(iPlayer, iNewCivType)
			PreGame.SetLeaderType(iPlayer, iNewLeaderType)
			
			--Dummy building set
			local pCapital = pPlayer:GetCapitalCity()
			if pCapital then
				for k, v in pairs(tUBDummies) do
					if iNewLeaderType == k then
						pCapital:SetNumRealBuilding(v, 1, true)
					else
						pCapital:SetNumRealBuilding(v, 0)
					end
				end
			end
			Events.SerialEventGameDataDirty()
			LuaEvents.RepopulateGameMenuData()

			--Dummy Policy Set
			if tDummyPolicies[iNewLeaderType] then
				pPlayer:SetHasPolicy(tDummyPolicies[iLeaderType], false)
				pPlayer:SetHasPolicy(tDummyPolicies[iNewLeaderType], true)
			end
			
			--Leader dialog set
			-- if tBlancs[iPlayer] then
				-- UpdateBlancDiploText(Game:GetActivePlayer())
				-- UpdateWhiteHeartUnits(iPlayer)
			-- end

			--Neptune:  Puppet every City when reverting. Kick Histoire out of the City she's running if transforming.
			-- if tNeptunes[iPlayer] then
				-- local iTask = TaskTypes.TASK_CREATE_PUPPET
				-- if bHDDOn == true then
					-- if HDNMod.HistoireCity[iPlayer] then 
						-- local pCity = pPlayer:GetCityByID(HDNMod.HistoireCity[iPlayer])
						-- pCity:DoTask(iTask, -1, -1, false)
						-- HDNMod.HistoireCity[iPlayer] = nil
						-- LuaEvents.VV_RefreshHistoireDisplay()
					-- end
				-- else
					
					-- for pCity in pPlayer:Cities() do
						-- if not pCity:IsRazing() then
							-- pCity:DoTask(iTask, -1, -1, false)
						-- end
					-- end
				-- end
			-- end
			
		else
			print("Error: Did not find the Civilization type for leader "..Locale.ConvertTextKey(GameInfo.Leaders[iLeaderType].Description).." when attempting to convert them.")
			return
		end
	else
		print("Error: Attempted to convert leader "..Locale.ConvertTextKey(GameInfo.Leaders[iLeaderType].Description).." into a new leader, but there was no info for them in the Lua tables!")
		return
	end
	RefreshSharesDisplay()

	--If playing WFTW, update Leader MG name and portrait
	if (bWFTW == true) then
		for k, v in pairs(MapModData.PMMM.MagicalGirls) do
			if v.Owner == iPlayer and v.IsLeader == true then
				local pUnit = pPlayer:GetUnitByID(v.UnitID)
				--Only rename if they haven't already been renamed
				local sOldName = GameInfo.Leaders[iLeaderType].Description
				if v.Name == sOldName then
					v.Name = GameInfo.Leaders[iNewLeaderType].Description
					if pUnit then
						pUnit:SetName(GameDefines.LEADER_MG_HIGHLIGHT_STRING..Locale.ConvertTextKey(GameInfo.Leaders[iNewLeaderType].Description).."[ENDCOLOR]")
					end
				end

				--Portrait
				local sIconAtlas = GameInfo.Leaders[iNewLeaderType].IconAtlas
				local iPortraitIndex = GameInfo.Leaders[iNewLeaderType].PortraitIndex
				v.OverrideIcon = {sIconAtlas, iPortraitIndex}

				--Combat Strength
				--Removed until I fix WFTW
				--[[if pUnit and tHDDModeLeaders[iNewLeaderType] then
					local iSharesStrength = math.floor(HDNMod.Shares[iPlayer] / (100 * PRODUCTION_SPEED_MOD))
					pUnit:SetBaseCombatStrength(MapModData.gPMMMMagicalGirlEraStrengths[pPlayer:GetCurrentEra()] + iSharesStrength)
				else
					pUnit:SetBaseCombatStrength(MapModData.gPMMMMagicalGirlEraStrengths[pPlayer:GetCurrentEra()])
				end

				--Extra Missions
				--Also Removed until I fix WFTW
				v.ExtraMission = nil
				leaderType = GameInfo.Leaders[iNewLeaderType].Type
				traitType = GameInfo.Leader_Traits("LeaderType ='" .. leaderType .. "'")().TraitType
				trait = GameInfo.Traits[traitType]
				if trait.LeaderMGUniqueMission then
					v.ExtraMission = GameInfo.Missions[trait.LeaderMGUniqueMission].ID
				end]]

				Events.SerialEventUnitInfoDirty()
				break
			end
		end
	end
	--Call a LuaEvent for when a Civ transforms.
	LuaEvents.VV_ConvertHDNLeader(iPlayer, bHDDOn)

	HDNMod.TransformedTurn[iPlayer] = Game:GetGameTurn()
end



function SendHDDNotifications(pPlayer, iType)
	--iType values:
	--0: Transformed to HDD
	--1: Reverted to normal
	--2: Forcibly reverted to normal due to lack of Shares
	local iPlayer = pPlayer:GetID()
	local pTeam = Teams[pPlayer:GetTeam()]
	if iType == 0 then
		if iPlayer == Game:GetActivePlayer() then
			Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_HDN_TURNED_HDD"))
		end
		local sOthersText = Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_HDN_OTHER_PLAYER_TURNED_HDD", pPlayer:GetCivilizationShortDescription(), pPlayer:GetName())
		local sOthersTitle = Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_HDN_OTHER_PLAYER_TURNED_HDD_TITLE", pPlayer:GetCivilizationShortDescription())
		for i = 0, iMaxCivs - 1, 1 do
			local pLoop = Players[i]
			if i ~= iPlayer and pTeam:IsHasMet(pLoop:GetTeam()) then
				pLoop:AddNotification(NotificationTypes.NOTIFICATION_PEACE_ACTIVE_PLAYER, sOthersText, sOthersTitle, -1, -1, iPlayer)
			end
		end
	elseif iType == 1 then
		if iPlayer == Game:GetActivePlayer() then
			Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_HDN_REVERTED_HDD"))
		end
		local sOthersText = Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_HDN_OTHER_PLAYER_REVERTED_HDD", pPlayer:GetCivilizationShortDescription(), pPlayer:GetName())
		local sOthersTitle = Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_HDN_OTHER_PLAYER_REVERTED_HDD_TITLE", pPlayer:GetCivilizationShortDescription())
		for i = 0, iMaxCivs - 1, 1 do
			local pLoop = Players[i]
			if i ~= iPlayer and pTeam:IsHasMet(pLoop:GetTeam()) then
				pLoop:AddNotification(NotificationTypes.NOTIFICATION_PEACE_ACTIVE_PLAYER, sOthersText, sOthersTitle, -1, -1, iPlayer)
			end
		end
	elseif iType == 2 then
		local sText = Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_HDN_FORCED_REVERTED_HDD")
		local sTitle = Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_HDN_FORCED_REVERTED_HDD_TITLE")

		local sOthersText = Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_HDN_OTHER_PLAYER_FORCED_REVERTED_HDD", pPlayer:GetCivilizationShortDescription(), pPlayer:GetName())
		local sOthersTitle = Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_HDN_OTHER_PLAYER_FORCED_REVERTED_HDD_TITLE", pPlayer:GetCivilizationShortDescription())
		for i = 0, iMaxCivs - 1, 1 do
			local pLoop = Players[i]
			if i ~= iPlayer and pTeam:IsHasMet(pLoop:GetTeam()) then
				pLoop:AddNotification(NotificationTypes.NOTIFICATION_PEACE_ACTIVE_PLAYER, sOthersText, sOthersTitle, -1, -1, iPlayer)
			end
		end
	else
		print("Error: Incorrect iType value given to function SendHDDNotifications")
	end
end



--------------------------------------------------------------------------------------------------------------------------------------------------------
-- PlayerCanMaintain
-- Should always run; no civs other than my HDN Civs should be able to build Shares
--------------------------------------------------------------------------------------------------------------------------------------------------------

function OnPlayerCanProcessShares(iPlayer, iProcessType)
	if iProcessType == SHARES_PROCESS then
		if tHDNCivs[iPlayer] then
			local pPlayer = Players[iPlayer]
			if IsPlayerHDDMode(pPlayer) == false --[[ and pPlayer:GetFaith() >= tFaithRequirementsForShares[pPlayer:GetCurrentEra()] ]] then
				if pPlayer:IsHuman() then
					return true
				else --AI Logic
					--The AI probably shouldn't try to build over 50% Shares.
					if HDNMod.Shares[iPlayer] >= MAXIMUM_SHARES / 2 then
						return false
					else
						return true
					end
				end
			else
				return false
			end
		end
		return false
	end
	return true
end



--------------------------------------------------------------------------------------------------------------------------------------------------------
-- PlayerDoTurn
--------------------------------------------------------------------------------------------------------------------------------------------------------

local tTransformLogicFunctions = {}
function AddToTransformLogicTable(iLeaderType, fFunc)
	tTransformLogicFunctions[iLeaderType] = fFunc
end
LuaEvents.VV_AddToTransformLogicTable.Add(AddToTransformLogicTable)


function OnPlayerDoTurnHDN(iPlayer)
	if tHDNCivs[iPlayer] == true then
		local pPlayer = Players[iPlayer]
		local bIsHDD = IsPlayerHDDMode(pPlayer)
		local iLeaderType = pPlayer:GetLeaderType()
		InitSharesIfNeeded(iPlayer)
		
		--Adjust the player's Shares.
		if tHDNCivs[iPlayer] then
			ChangeShares(iPlayer, GetPlayerSharesPerTurn(iPlayer))
			if HDNMod.Shares[iPlayer] < HDD_SHARE_THRESHOLD and bIsHDD == true then
				ConvertHDNLeader(pPlayer, false)
				SendHDDNotifications(pPlayer, 2)
			end
		else
			AddToOthersShares(GetPlayerSharesPerTurn(iPlayer))
		end
		
		--Check if the City has enough Faith to produce its Shares process, if that is what it's doing.
		--Otherwise, cancel the city's current production.
		--NOTE: currently unused, but we might bring it back so it'll just be commented out.
		
		--[[
		if tHDNCivs[iPlayer] then
			local iEra = pPlayer:GetCurrentEra()
			for pCity in pPlayer:Cities() do
				if pCity:GetProductionProcess() == SHARES_PROCESS then
					if pPlayer:GetFaith() >= tFaithRequirementsForShares[iEra] then
						pPlayer:ChangeFaith(-tFaithRequirementsForShares[iEra])
					end
					if pPlayer:GetFaith() < tFaithRequirementsForShares[iEra] then
						pCity:DoTask(TaskTypes.TASK_CLEAR_ORDERS, -1, -1)
						if iPlayer == Game:GetActivePlayer() then
							Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_ALERT_HDN_INSUFFICIENT_FAITH_TO_PRODUCE_SHARES", pCity:GetName()))
						end
					end
				end
			end
		end 
		]]

		--Dummy building set
		local pCapital = pPlayer:GetCapitalCity()
		if pCapital then
			for k, v in pairs(tUBDummies) do
				if iLeaderType == k then
					pCapital:SetNumRealBuilding(v, 1, true)
				else
					pCapital:SetNumRealBuilding(v, 0)
				end
			end
		end

		--AI: Decide whether or not to Transform/Revert
		if not pPlayer:IsHuman() and CanPlayerTransform(iPlayer) == true then
			local bShouldTransform = tTransformLogicFunctions[iLeaderType](iPlayer)		
			if bShouldTransform then
				ConvertHDNLeader(pPlayer, not bIsHDD)
				local iNoteType = bIsHDD and 1 or 0
				SendHDDNotifications(pPlayer, iNoteType)
			end
		end
	end
end

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- GreatPersonExpended
--------------------------------------------------------------------------------------------------------------------------------------------------------

--Must be compatible both with and without DVMC
local bIsDVMC = false

if GameInfo.CustomModOptions then
	for row in GameInfo.CustomModOptions() do
		if row.Name == "EVENTS_GREAT_PEOPLE" and row.Value == 1 then
			bIsDVMC = true
		end
	end
end

function OnGreatPersonExpendedHDN(iPlayer, iUnitTypeNormal, iUnitTypeDVMC)	
	if tHDNCivs[iPlayer] == true then
		local iUnitType = iUnitTypeNormal
		if bIsDVMC then
			iUnitType = iUnitTypeDVMC
		end
		--Prophets
		if GameInfo.Units[iUnitType] and GameInfo.Units[iUnitType].Class == "UNITCLASS_PROPHET" then
			ChangeShares(iPlayer, PROPHET_EXPEND_SHARES)
		end
	end
end

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- UnitPrekill
--------------------------------------------------------------------------------------------------------------------------------------------------------
function SharesTilePopup(iX, iY, iValue)
	local sConvertedValue = ConvertToPercentString(iValue)
	local sText;
	if iValue < 0 then
		sText = Locale.ConvertTextKey("TXT_KEY_TILEPOPUP_HDN_SHARES_NEGATIVE", sConvertedValue)
	else
		sText = Locale.ConvertTextKey("TXT_KEY_TILEPOPUP_HDN_SHARES_POSITIVE", sConvertedValue)
	end
	Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid( Vector2(iX,iY))), sText, 3)
end

local AIR_DOMAIN = GameInfoTypes.DOMAIN_AIR

--This used to be invoked by UnitPrekill, but that triggers in bad situations when used with pUnit:Kill() by many mods.
function OnUnitKilledInCombatHDN(iKiller, iVictim, iUnitType)
	if iKiller > -1 then
		local pPlayer = Players[iVictim]
		local unitdata = GameInfo.Units[iUnitType]
		if (unitdata.Combat and unitdata.Combat > 0) or (unitdata.Domain == "DOMAIN_AIR") then
			if tHDNCivs[iKiller] and tHDNCivs[iVictim] then --both players are Neps
				local iValue = NEPTUNIA_KILL_SHARES
				ChangeShares(iKiller, NEPTUNIA_KILL_SHARES, iVictim)
			--[[	if iKiller == Game:GetActivePlayer() then
					SharesTilePopup(pUnit:GetX(), pUnit:GetY(), iValue)
				elseif iVictim == Game:GetActivePlayer() then
					SharesTilePopup(pUnit:GetX(), pUnit:GetY(), -iValue)
				end]]
			elseif tHDNCivs[iVictim] then  --only victim is a Nep
				local iValue =  -OTHERS_LOSS_SHARES
				ChangeShares(iVictim, iValue)
				--[[if iVictim == Game:GetActivePlayer() then
					SharesTilePopup(pUnit:GetX(), pUnit:GetY(), iValue)
				end]]
			elseif tHDNCivs[iKiller] then  --only killer is a Nep
				if iVictim == GameDefines.MAX_CIV_PLAYERS then  --Barbarian kills are worth less Shares
					local iValue = BARBARIAN_KILL_SHARES
					ChangeShares(iKiller, iValue)
					--[[if iKiller == Game:GetActivePlayer() then
						SharesTilePopup(pUnit:GetX(), pUnit:GetY(), iValue)
					end]]
				else
					local iValue = OTHERS_KILL_SHARES
					ChangeShares(iKiller, iValue)
					--[[if iKiller == Game:GetActivePlayer() then
						SharesTilePopup(pUnit:GetX(), pUnit:GetY(), iValue)
					end]]
				end
			end
		end
	end
end

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- CityCaptureComplete
--------------------------------------------------------------------------------------------------------------------------------------------------------

function OnCityCaptureCompleteHDN(iVictim, bCapital, iX, iY, iConqueror, bConquest)
	if bConquest then
		if tHDNCivs[iConqueror] and tHDNCivs[iVictim] then
			local iChangeAmount = CITY_CAPTURE_SHARES
			--v4: Completely eradicating a player gives you ALL their Shares!
			if not Players[iVictim]:IsAlive() and HDNMod.Shares[iVictim] then
				iChangeAmount = HDNMod.Shares[iVictim]
			end
			ChangeShares(iConqueror, iChangeAmount, iVictim)
			if iConqueror == Game:GetActivePlayer() then
				SharesTilePopup(pUnit:GetX(), pUnit:GetY(), iChangeAmount)
			elseif iVictim == Game:GetActivePlayer() then
				SharesTilePopup(pUnit:GetX(), pUnit:GetY(), -iChangeAmount)
			end
		elseif tHDNCivs[iVictim] then
			ChangeShares(iVictim, -CITY_CAPTURE_SHARES)
			if iVictim == Game:GetActivePlayer() then
				SharesTilePopup(pUnit:GetX(), pUnit:GetY(), -iChangeAmount)
			end
		elseif tHDNCivs[iConqueror] then
			ChangeShares(iConqueror, CITY_CAPTURE_SHARES)
			if iConqueror == Game:GetActivePlayer() then
				SharesTilePopup(pUnit:GetX(), pUnit:GetY(), iChangeAmount)
			end
		end
	end
end


--------------------------------------------------------------------------------------------------------------------------------------------------------
-- SetPopulation
--------------------------------------------------------------------------------------------------------------------------------------------------------

function DeckShuffle(tTable, sString)
	local tDeck = {}
	for k, v in pairs(tTable) do
		if v > -1 then
			for i = 0, v, 1 do
				tDeck[#tDeck + 1] = k
			end
		end
	end
	
	if not sString then sString = "HDN Generic Deck Shuffle" end
	
	return tDeck[Game.Rand(#tDeck, sString) + 1]
end


function HDNCityNamesDynamic(iPlotX, iPlotY, iOldPop, iNewPop)
	if iOldPop == 0 then
		local pPlot = Map.GetPlot(iPlotX, iPlotY)
		local pCity = pPlot:GetPlotCity()
		if pCity then
			local iPlayer = pCity:GetOwner()
			if tHDNCivs[iPlayer] then
				local pPlayer = Players[iPlayer]
				--Give dummies in Capital
				if string.find(pCity:GetNameKey(), "TXT_KEY_CITY_NAME_VV_HDNCAPITAL_") then
					local iLeaderType = pPlayer:GetLeaderType()
					for k, v in pairs(tUBDummies) do
						if iLeaderType == k then
							pCity:SetNumRealBuilding(v, 1, true)
						else
							pCity:SetNumRealBuilding(v, 0)
						end
					end
				else
					local sCityName;
					local sCivilizationType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
					local sHeaderType;
					if string.find(sCivilizationType, "VV_PLANEPTUNE") then
						sHeaderType = "VV_PLANEPTUNE"
					elseif string.find(sCivilizationType, "VV_LEANBOX") then
						sHeaderType = "VV_LEANBOX"
					elseif string.find(sCivilizationType, "VV_LOWEE") then
						sHeaderType = "VV_LOWEE"
					elseif string.find(sCivilizationType, "VV_LASTATION") then
						sHeaderType = "VV_LASTATION"
					end		
					sHeaderType = "TXT_KEY_HDN_DYNAMIC_CITY_HEADER_" ..sHeaderType
					local locale = "Language_" ..Locale.GetCurrentLanguage().Type
					local tRandomTable = {}
					for row in DB.Query("SELECT * FROM " ..locale .." WHERE Tag LIKE('" ..sHeaderType.."%')") do
						if not HDNMod.UsedCityHeaders[row.Tag] then
							tRandomTable[#tRandomTable + 1] = row.Tag
						end
					end
					--If there are no more available headers, then return the function and let the DLL city name picker handle it
					if #tRandomTable == 0 then return end
					local sSelectedHeader = tRandomTable[Game.Rand(#tRandomTable - 1, "HDN City Name Roll") + 1]
					HDNMod.UsedCityHeaders[sSelectedHeader] = true
					if sSelectedHeader then
						sCityName = Locale.ConvertTextKey(sSelectedHeader)
					end
					tRandomTable = {}

					if sCityName then
						local sFooterType;
						--Footers can be determined by terrain, or be a generic one.
						--Terrain based ones have a higher chance of occurring.
						for row in DB.Query("SELECT * FROM " ..locale .." WHERE Tag LIKE('TXT_KEY_HDN_DYNAMIC_CITY_FOOTER_GENERIC%')") do
							tRandomTable[row.Tag] = 5
						end
						if not sFooterType then
							local iNumLandTiles = Map.GetArea(pPlot:GetArea()):GetNumTiles()
							if iNumLandTiles <= 5 then
								for row in DB.Query("SELECT * FROM " ..locale .." WHERE Tag LIKE('TXT_KEY_HDN_DYNAMIC_CITY_FOOTER_ISLAND%')") do
									tRandomTable[row.Tag] = 50
								end
							end
							if pPlot:IsRiver() then
								for row in DB.Query("SELECT * FROM " ..locale .." WHERE Tag LIKE('TXT_KEY_HDN_DYNAMIC_CITY_FOOTER_RIVER%')") do
									tRandomTable[row.Tag] = 10
								end
							end
							if pPlot:IsCoastalLand() then
								for row in DB.Query("SELECT * FROM " ..locale .." WHERE Tag LIKE('TXT_KEY_HDN_DYNAMIC_CITY_FOOTER_COAST%')") do
									tRandomTable[row.Tag] = 10
								end
							end
							local iNumHills = 0
							local iNumForestJungles = 0
							local iNumDesert = 0
							local iNumTundraSnow = 0
							local iNumGrassland = 0
							local iNumPlains = 0
							for pAreaPlot in PlotAreaSpiralIterator(pPlot, 2, false, false, false, true) do
								if pAreaPlot:IsMountain() and Map.PlotDistance(pAreaPlot:GetX(), pAreaPlot:GetY(), pPlot:GetX(), pPlot:GetY()) < 2 then
									for row in DB.Query("SELECT * FROM " ..locale .." WHERE Tag LIKE('TXT_KEY_HDN_DYNAMIC_CITY_FOOTER_MOUNTAIN%')") do
										tRandomTable[row.Tag] = 30
									end
								end
								if pAreaPlot:GetFeatureType() == GameInfoTypes.FEATURE_MARSH and Map.PlotDistance(pAreaPlot:GetX(), pAreaPlot:GetY(), pPlot:GetX(), pPlot:GetY()) < 2 then
									for row in DB.Query("SELECT * FROM " ..locale .." WHERE Tag LIKE('TXT_KEY_HDN_DYNAMIC_CITY_FOOTER_MARSH%')") do
										tRandomTable[row.Tag] = 25
									end
								end
								if pAreaPlot:GetFeatureType() == GameInfoTypes.FEATURE_JUNGLE or pAreaPlot:GetFeatureType() == GameInfoTypes.FEATURE_FOREST then
									iNumForestJungles = iNumForestJungles + 1
								end
								if pAreaPlot:IsHills() then
									iNumHills = iNumHills + 1
								end
								local iTerrainType = pAreaPlot:GetTerrainType()
								if iTerrainType == GameInfoTypes.TERRAIN_GRASS then
									iNumGrassland = iNumGrassland + 1
								elseif iTerrainType == GameInfoTypes.TERRAIN_PLAINS then
									iNumPlains = iNumPlains + 1
								elseif iTerrainType == GameInfoTypes.TERRAIN_TUNDRA or iTerrainType == GameInfoTypes.TERRAIN_SNOW then
									iNumTundraSnow = iNumTundraSnow + 1
								elseif iTerrainType == GameInfoTypes.TERRAIN_DESERT then
									iNumDesert = iNumDesert + 1
								end
							end
							if iNumForestJungles > 4 then
								for row in DB.Query("SELECT * FROM " ..locale .." WHERE Tag LIKE('TXT_KEY_HDN_DYNAMIC_CITY_FOOTER_FOREST%')") do
									tRandomTable[row.Tag] = 25
								end
							end
							if iNumGrassland > 8 then
								for row in DB.Query("SELECT * FROM " ..locale .." WHERE Tag LIKE('TXT_KEY_HDN_DYNAMIC_CITY_FOOTER_GRASSLAND%')") do
									tRandomTable[row.Tag] = 25
								end
							end
							if iNumPlains > 8 then
								for row in DB.Query("SELECT * FROM " ..locale .." WHERE Tag LIKE('TXT_KEY_HDN_DYNAMIC_CITY_FOOTER_PLAINS%')") do
									tRandomTable[row.Tag] = 25
								end
							end
							if iNumDesert > 6 then
								for row in DB.Query("SELECT * FROM " ..locale .." WHERE Tag LIKE('TXT_KEY_HDN_DYNAMIC_CITY_FOOTER_DESERT%')") do
									tRandomTable[row.Tag] = 25
								end
							end
							if iNumTundraSnow > 6 then
								for row in DB.Query("SELECT * FROM " ..locale .." WHERE Tag LIKE('TXT_KEY_HDN_DYNAMIC_CITY_FOOTER_TUNDRA_SNOW%')") do
									tRandomTable[row.Tag] = 25
								end
							end
							if iNumHills > 6 then
								for row in DB.Query("SELECT * FROM " ..locale .." WHERE Tag LIKE('TXT_KEY_HDN_DYNAMIC_CITY_FOOTER_HILLS%')") do
									tRandomTable[row.Tag] = 25
								end
							end
						end

						sFooterType = DeckShuffle(tRandomTable, "HDN City Name Footer Roll")

						if string.find(sFooterType, "_PRE") then
							sCityName = Locale.ConvertTextKey(sFooterType).." "..sCityName
						elseif string.find(sFooterType, "_NOSPACE") then
							sCityName = sCityName..Locale.ConvertTextKey(sFooterType)
						else
							sCityName = sCityName.." "..Locale.ConvertTextKey(sFooterType)
						end

						pCity:SetName(sCityName)
					end
				end
			end
		end
	end
end

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- Other
--------------------------------------------------------------------------------------------------------------------------------------------------------
-- CitySoldBuilding (Network Compatibility)

function OnCitySoldBuilding(iPlayer, iCity, iBuilding)
	if iBuilding == iBuildingSellKey then
		local pPlayer = Players[iPlayer]
		local bHDDOn = not IsPlayerHDDMode(pPlayer)
		ConvertHDNLeader(pPlayer, bHDDOn)
		if iPlayer == Game:GetActivePlayer() then
			local sKey;
			if bHDDOn then
				sKey = 'TXT_KEY_NOTIFICATION_HDN_TURNED_HDD'
			else
				sKey = 'TXT_KEY_NOTIFICATION_HDN_REVERTED_HDD'
			end
		end
	end
end

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- Event Hooks
--------------------------------------------------------------------------------------------------------------------------------------------------------

GameEvents.PlayerCanMaintain.Add(OnPlayerCanProcessShares)
GameEvents.PlayerDoTurn.Add(OnPlayerDoTurnHDN)

if bAnyHDNCivs then
	GameEvents.GreatPersonExpended.Add(OnGreatPersonExpendedHDN)
	GameEvents.SetPopulation.Add(HDNCityNamesDynamic)
	GameEvents.CitySoldBuilding.Add(OnCitySoldBuilding)
	GameEvents.UnitKilledInCombat.Add(OnUnitKilledInCombatHDN)
	GameEvents.CityCaptureComplete.Add(OnCityCaptureCompleteHDN)
end



--------------------------------------------------------------------------------------------------------------------------------------------------------
-- User Interface
--------------------------------------------------------------------------------------------------------------------------------------------------------

function UpdateSharesDisplay()
	Controls.HDNSharesString:ChangeParent(ContextPtr:LookUpControl("/InGame/TopPanel/TopPanelInfoStack"))
	Controls.HDNGameDevString:ChangeParent(ContextPtr:LookUpControl("/InGame/TopPanel/TopPanelInfoStack"))
	ContextPtr:LookUpControl("/InGame/TopPanel/TopPanelInfoStack"):ReprocessAnchoring()
	DoInitSharesTooltips()
	RefreshSharesDisplay()
	RefreshGameDevDisplay()
end

Events.LoadScreenClose.Add(UpdateSharesDisplay)

local tipControlTable = {}
TTManager:GetTypeControlTable( "TooltipTypeTopPanel", tipControlTable )

function SharesTipHandler(control)
	local iPlayer = Game:GetActivePlayer()
	local pTeam = Teams[Players[iPlayer]:GetTeam()]
	local sText = Locale.ConvertTextKey("TXT_KEY_HDN_TT_SHARES_HEADER").."[NEWLINE][NEWLINE]"
	if CanPlayerTransform(iPlayer) == true then
		sText = sText..Locale.ConvertTextKey("TXT_KEY_HDN_TT_TRANSFORM").."[NEWLINE]"
	end
	--Shares List
	local iOthersPerTurn = 0
	local tSourceList = {}
	for i = 0, iMaxCivs - 1, 1 do
		if tHDNCivs[i] then
			local pLoop = Players[i]
			InitSharesIfNeeded(i)
			if pLoop:IsAlive() then
				local sCivName;
				if pTeam:IsHasMet(pLoop:GetTeam()) then
					sCivName = pLoop:GetCivilizationShortDescription()
				else
					sCivName = Locale.ConvertTextKey("TXT_KEY_POP_VOTE_RESULTS_UNMET_PLAYER")
				end 
				if i == iPlayer then
					sCivName = sCivName.." ("..Locale.ConvertTextKey("TXT_KEY_YOU")..")"
				end
				local sShares = ConvertToPercentString(HDNMod.Shares[i])
				local iSharesPerTurn;
				if i == iPlayer then
					iSharesPerTurn, tSourceList = GetPlayerSharesPerTurn(i, true)
				else
					iSharesPerTurn = GetPlayerSharesPerTurn(i)
				end
				if iSharesPerTurn < 0 then
					sShares = sShares .." ("..ConvertToPercentString(iSharesPerTurn)..")"
				else
					sShares = sShares .." (+"..ConvertToPercentString(iSharesPerTurn)..")"
				end
				sText = sText..Locale.ConvertTextKey("TXT_KEY_HDN_TT_SHARES_LIST", sCivName, sShares).."[NEWLINE]"
			end
		else
			local pLoop = Players[i]
			if pLoop:IsAlive() then
				local iSharesPerTurn = GetPlayerSharesPerTurn(i)
				iOthersPerTurn = iOthersPerTurn + iSharesPerTurn
			end
		end
	end
	--Others
	local sOthersAmount = ConvertToPercentString(iOthersPerTurn)
	if iOthersPerTurn < 0 then
		sOthersAmount = ConvertToPercentString(GetOthersShares()).."("..sOthersAmount..")"
	else
		sOthersAmount = ConvertToPercentString(GetOthersShares()).."(+"..sOthersAmount..")"
	end
	sText = sText..Locale.ConvertTextKey("TXT_KEY_HDN_TT_SHARES_LIST", Locale.ConvertTextKey("TXT_KEY_HDN_TT_SHARES_OTHERS"), sOthersAmount).."[NEWLINE][NEWLINE]"

	--Sources of Share Changes
	if tSourceList and #tSourceList > 0 then
		for k, v in ipairs(tSourceList) do
			sText = sText..v.."[NEWLINE]"
		end
	end

	--HelpInfo
	sText = sText.."[NEWLINE][NEWLINE]"..Locale.ConvertTextKey("TXT_KEY_HDN_TT_SHARES") 
	
	if(sText ~= "") then
		tipControlTable.TopPanelMouseover:SetHide(false)
		tipControlTable.TooltipLabel:SetText( sText )
	else
		tipControlTable.TopPanelMouseover:SetHide(true)
	end

	tipControlTable.TopPanelMouseover:DoAutoSize()
end

function GameDevTipHandler(control)
	local iPlayer = Game:GetActivePlayer()
	local iShares = HDNMod.Shares[iPlayer] or 0
	local sText = Locale.ConvertTextKey("TXT_KEY_HDN_TT_GAME_DEV") 
	
	if(sText ~= "") then
		tipControlTable.TopPanelMouseover:SetHide(false)
		tipControlTable.TooltipLabel:SetText( sText )
	else
		tipControlTable.TopPanelMouseover:SetHide(true)
	end

	tipControlTable.TopPanelMouseover:DoAutoSize()
end

function RefreshSharesDisplay()
	local iPlayer = Game:GetActivePlayer()
	local pPlayer = Players[iPlayer]
	if not tHDNCivs[iPlayer] then
		Controls.HDNSharesString:SetText("");
		return
	end
	local sText = "[ICON_VV_SHARES] "
	if IsPlayerHDDMode(pPlayer) == true then
		sText = sText.."[COLOR:31:236:224:255]"
	end
	local sShares = ConvertToPercentString(HDNMod.Shares[iPlayer])
	local iSharesPerTurn = GetPlayerSharesPerTurn(iPlayer)
	local sSharesPerTurn = ConvertToPercentString(iSharesPerTurn)
	if iSharesPerTurn < 0 then
		sText = sText..sShares.." ("..sSharesPerTurn..")[ENDCOLOR]"
	else
		sText = sText..sShares.." (+"..sSharesPerTurn..")[ENDCOLOR]"
	end
	Controls.HDNSharesString:SetText(sText);
end

function RefreshGameDevDisplay()
	Controls.HDNGameDevString:SetText("");
	return
end

function DoInitSharesTooltips()
	Controls.HDNSharesString:SetToolTipCallback( SharesTipHandler );
	Controls.HDNGameDevString:SetToolTipCallback( GameDevTipHandler );
end

function OnTopPanelClicked()
	local iPlayer = Game:GetActivePlayer()
	if CanPlayerTransform(iPlayer) == true then
		local pPlayer = Players[iPlayer]
		--We will send this as a Network.SendSellBuilding call, so it can sync in multiplayer.
		for pCity in pPlayer:Cities() do
			Network.SendSellBuilding(pCity:GetID(), iBuildingSellKey)
			break
		end
	end
end
LuaEvents.VV_HDDButton.Add(OnTopPanelClicked)

--Controls.HDNSharesString:RegisterCallback(Mouse.eLClick, OnTopPanelClicked)
Events.SerialEventCityInfoDirty.Add(RefreshSharesDisplay)

if not GameInfoTypes.LEADER_VV_VERT then
	Events.SerialEventCityInfoDirty.Add(RefreshGameDevDisplay)
end


--------------------------------------------------------------------------------------------------------------------------------------------------------
-- Civ-Specific Includes
--------------------------------------------------------------------------------------------------------------------------------------------------------
for script, _ in pairs(tScriptsToInclude) do
	include(script)
end

--------------------------------------------------------------------------------------------------------------------------------------------------------
-- Cultural Diversity
--------------------------------------------------------------------------------------------------------------------------------------------------------

include("JFD_CulDivUtilities.lua")


function CulDivBonus()
	if JFD_GetCultureID and not HDNMod.CulDivInit then
		for i = 0, iMaxCivs - 1, 1 do
			if JFD_GetCultureID(i) == GameInfo.JFD_CultureTypes["JFD_Gamindustri"].ID then
				for row in DB.Query("SELECT * FROM JFD_GlobalUserSettings WHERE Type = 'JFD_CULDIV_STARTING_BONUSES' AND Value = 1") do
					ChangeShares(i, 500)
					break
				end
			end
		end
		HDNMod.CulDivInit = true
	end
end

Events.LoadScreenClose.Add(CulDivBonus)