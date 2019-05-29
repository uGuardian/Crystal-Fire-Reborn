-- NeptunePurpleHeartTraitScript
-- Author: Vice
-- DateCreated: 9/12/2015 10:09:44 PM
--------------------------------------------------------------

print("''Vice put this here so he'll know he didn't break stuff!'' - Neptune")


---------------------------------------------------------------------------------------------------------------------------------------------------------
-- INIT
---------------------------------------------------------------------------------------------------------------------------------------------------------
--Constants
local PRODUCTION_SPEED_MOD = GameInfo.GameSpeeds[PreGame.GetGameSpeed()].ConstructPercent / 100
local GROWTH_SPEED_MOD = GameInfo.GameSpeeds[PreGame.GetGameSpeed()].GrowthPercent / 100
local HISTY_TRAVEL_TIME = 3 --always 3 since it's in-character
local MAXIMUM_ENERGY = 100
local ENERGY_GAIN_PER_TURN = 2
local ENERGY_CONSUMED_PER_TURN = 3
local STARTING_ENERGY = math.floor(20 * PRODUCTION_SPEED_MOD)
local NEPTUNE_DUMMY_BUILDING = GameInfoTypes.BUILDING_VV_PLANEPTUNE_DUMMY_BUILDING_NEPTUNE
local PURPLE_HEART_DUMMY_BUILDING = GameInfoTypes.BUILDING_VV_PLANEPTUNE_DUMMY_BUILDING_PURPLE_HEART
local PURPLE_HEART_UA_BUILDING = GameInfoTypes.BUILDING_VV_PLANEPTUNE_DUMMY_BUILDING_PURPLE_HEART_UA
local PURPLE_HEART_UA_DIVISOR = 250
local PURPLE_HEART_ENERGY_RECOVERY_MULTIPLIER = 2
local PUPPETING_ON = GameInfoTypes.TECH_VV_NEPTUNE_DUMMY_ON
local PUPPETING_OFF = GameInfoTypes.TECH_VV_NEPTUNE_DUMMY_OFF
local HISTOIRE_DUMMY = GameInfoTypes.BUILDING_VV_PLANEPTUNE_DUMMY_BUILDING_HISTOIRE
local PUDDING_PARLOR = GameInfoTypes.BUILDING_VV_PUDDING_PARLOR
local PUDDING_SCIENCE = GameInfoTypes.BUILDING_VV_PLANEPTUNE_DUMMY_PUDDING_PUPPET_SCIENCE
local PUDDING_GOLD = GameInfoTypes.BUILDING_VV_PLANEPTUNE_DUMMY_PUDDING_PUPPET_GOLD
local PUDDING_CULTURE = GameInfoTypes.BUILDING_VV_PLANEPTUNE_DUMMY_PUDDING_PUPPET_CULTURE
local PUDDING_BONUS_PER_POP = 2
local PUDDING_LUXURIES_ON_COMPLETE = 1   --was 3, changed on 1/17/2016
local PUDDING_SHARES_BONUS = 250
local PUDDING_QUEST_COMPLETE = GameInfoTypes.BUILDING_VV_PLANEPTUNE_DUMMY_PUDDING_QUEST_COMPLETE
local DOGOO_SLIME = GameInfoTypes.IMPROVEMENT_VV_DOGOO_SLIME
local DOGOO_SLIME_TURNS = 5
local DOGOO_SLIME_MAKE_TURNS = 3
local DOGOO_PROMO = GameInfoTypes.PROMOTION_VV_DOGOO_KNIGHT_NOUPGRADE

local iMaxCivs = GameDefines.MAX_MAJOR_CIVS
local iBuildingSellKeyHisty = 23852583 --arbitrary number used for the Network.SendSellBuilding netplay syncing trick
local iBuildingSellKeyHistyRemove = 23852584

local tGreatPersonImprovements = {}
for row in GameInfo.Improvements("CreatedByGreatPerson IN (1, 'true')") do
	tGreatPersonImprovements[row.ID] = true
end

--TSL Tables
HDNMod.HistoireCity = HDNMod.HistoireCity or {}
HDNMod.HistoireEnergy = HDNMod.HistoireEnergy or {}
HDNMod.HistoireArrivalTurn =  HDNMod.HistoireArrivalTurn or {}
HDNMod.HistoireBlocked =  HDNMod.HistoireBlocked or {}
HDNMod.PuddingQuests = HDNMod.PuddingQuests or {}
HDNMod.NeptuneUnitData = HDNMod.NeptuneUnitData or {}
HDNMod.DogooUnitData = HDNMod.DogooUnitData or {}
HDNMod.AssignedQuests = HDNMod.AssignedQuests or {}


--Civ Identifiers
local iNeptune = GameInfoTypes.LEADER_VV_NEPTUNE
local iPurpleHeart = GameInfoTypes.LEADER_VV_PURPLE_HEART
local iNeptuneCiv = GameInfoTypes.CIVILIZATION_VV_PLANEPTUNE
local iPurpleHeartCiv = GameInfoTypes.CIVILIZATION_VV_PLANEPTUNE_PH
local tNeptunes = {}
for i = 0, iMaxCivs - 1, 1 do
	local pPlayer = Players[i]
	if pPlayer:IsEverAlive() then
		local iLeaderType = pPlayer:GetLeaderType()
		if (iLeaderType == iNeptune or iLeaderType == iPurpleHeart) then
			tNeptunes[i] = true
		end
	end
end


--Pudding Quests
local BASE_TURNS_COUNT_PUDDING_QUESTS = math.floor(30 * PRODUCTION_SPEED_MOD)
local mtQuests = {
	__index = function(t, key)
		t[key] = { ["CanHaveQuestFunc"] = (function(iPlayer, iCity, sCity) return true end),
		["TooltipFunc"] = (function(iPlayer, iCity, heading, subheading, body) heading:SetText("None") subheading:SetText("None") body:SetText("None") end),
		["OnTurnFunc"] = (function(iPlayer, iCity, sCity) end),
		["Data"] = {["TurnsRequired"] = BASE_TURNS_COUNT_PUDDING_QUESTS, ["TurnsLeft"] = BASE_TURNS_COUNT_PUDDING_QUESTS},
		["AIOnlyFunc"] = (function(iPlayer, iCity, sCity)
			print("AIOnlyFunc")
			if not HDNMod.PuddingQuests[iPlayer][sCity].Data["AITurnsLeft"] then HDNMod.PuddingQuests[iPlayer][sCity].Data["AITurnsLeft"] = BASE_TURNS_COUNT_PUDDING_QUESTS * (2 + Players[iPlayer]:GetNumCities()) end
			HDNMod.PuddingQuests[iPlayer][sCity].Data["AITurnsLeft"] = HDNMod.PuddingQuests[iPlayer][sCity].Data["AITurnsLeft"] - 1
			if HDNMod.PuddingQuests[iPlayer][sCity].Data["AITurnsLeft"] == 0 then
				HDNMod.PuddingQuests[iPlayer][sCity].Completed = true
				return true
			end
		end)
		}
	end
}

local tQuests = setmetatable({}, mtQuests)

local iVanilla = tQuests[GameInfoTypes.RESOURCE_VV_VANILLA_PUDDING] or GameInfoTypes.RESOURCE_VV_VANILLA_PUDDING
local iChocolate = tQuests[GameInfoTypes.RESOURCE_VV_CHOCOLATE_PUDDING] or GameInfoTypes.RESOURCE_VV_CHOCOLATE_PUDDING
local iStrawberry = tQuests[GameInfoTypes.RESOURCE_VV_STRAWBERRY_PUDDING] or GameInfoTypes.RESOURCE_VV_STRAWBERRY_PUDDING
local iBanana = tQuests[GameInfoTypes.RESOURCE_VV_BANANA_PUDDING] or GameInfoTypes.RESOURCE_VV_BANANA_PUDDING
local iCaramel = tQuests[GameInfoTypes.RESOURCE_VV_CARAMEL_PUDDING] or GameInfoTypes.RESOURCE_VV_CARAMEL_PUDDING
local iBerry = tQuests[GameInfoTypes.RESOURCE_VV_BERRY_PUDDING] or GameInfoTypes.RESOURCE_VV_BERRY_PUDDING
local iMint = tQuests[GameInfoTypes.RESOURCE_VV_MINT_PUDDING] or GameInfoTypes.RESOURCE_VV_MINT_PUDDING
local iCake = tQuests[GameInfoTypes.RESOURCE_VV_CAKE_PUDDING] or GameInfoTypes.RESOURCE_VV_CAKE_PUDDING


local bIsDVMCFound = false

---------------------------------------------------------------------------------------------------------------------------------------------------------
-- HELPER FUNCTIONS
-- None of these are directly assigned to any Events or GameEvents.
---------------------------------------------------------------------------------------------------------------------------------------------------------
--Taken from sukritact's Events & Decisions
function CompileCityID(pCity)
	local iOriginalOwner = pCity:GetOriginalOwner()
	local iTurnFounded = pCity:GetGameTurnFounded ()	--Used to Compile Unique City ID
	local iCityID = ("X" .. pCity:GetX() .. "Y" .. pCity:GetY() .. "P" .. iOriginalOwner .. "T" .. iTurnFounded)
	return iCityID
end

function Vice_DecompileCityID(sKey)
    local iBreak = string.find(sKey, "Y")
	local iBreak2 = string.find(sKey, "P")
    iX = tonumber(string.sub(sKey, 2, iBreak - 1))
    iY = tonumber(string.sub(sKey, iBreak + 1, iBreak2 - 1))
    local pPlot = Map.GetPlot(iX, iY)
	local pCity = pPlot:GetPlotCity()
    return pCity
end


--Set dummy buildings for a city for the Pudding Parlor.
--This can't just be done in the HDN main script, since unlike other Civs, this one must be done on a per-City basis.
function PuddingParlorDummyBuildings(pPlayer, pCity)
	if pCity:IsHasBuilding(PUDDING_PARLOR) then
		--Neptune and Purple Heart dummies for yields to Pastures
		if pPlayer:GetLeaderType() == iPurpleHeart then
			pCity:SetNumRealBuilding(NEPTUNE_DUMMY_BUILDING, 0, true)
			pCity:SetNumRealBuilding(PURPLE_HEART_DUMMY_BUILDING, 1, true)
		else
			pCity:SetNumRealBuilding(NEPTUNE_DUMMY_BUILDING, 1, true)
			pCity:SetNumRealBuilding(PURPLE_HEART_DUMMY_BUILDING, 0, true)
		end
		
		--Pop-based dummies for Puppet Yields

		local iScience = 0
		local iGold = 0
		local iCulture = 0
		if pCity:IsPuppet() then
			if pCity:IsCapital() then   --as of v3, the Capital always has negated penalties
				iScience = -GameDefines.PUPPET_SCIENCE_MODIFIER
				iGold = -GameDefines.PUPPET_GOLD_MODIFIER
				iCulture = -GameDefines.PUPPET_CULTURE_MODIFIER
			else
				local iPop = pCity:GetPopulation() * PUDDING_BONUS_PER_POP
				iScience = math.min(iPop, -GameDefines.PUPPET_SCIENCE_MODIFIER)
				iGold =  math.min(iPop, -GameDefines.PUPPET_GOLD_MODIFIER)
				iCulture =  math.min(iPop, -GameDefines.PUPPET_CULTURE_MODIFIER)
			end
		end

		pCity:SetNumRealBuilding(PUDDING_SCIENCE,iScience, true)
		pCity:SetNumRealBuilding(PUDDING_GOLD, iGold, true)
		pCity:SetNumRealBuilding(PUDDING_CULTURE, iCulture, true)
	else
		pCity:SetNumRealBuilding(NEPTUNE_DUMMY_BUILDING, 0, true)
		pCity:SetNumRealBuilding(PURPLE_HEART_DUMMY_BUILDING, 0, true)
		pCity:SetNumRealBuilding(PUDDING_SCIENCE, 0, true)
		pCity:SetNumRealBuilding(PUDDING_GOLD, 0, true)
		pCity:SetNumRealBuilding(PUDDING_CULTURE, 0, true)
	end
end

--Purple Heart's UA dummy buildings.
function PurpleHeartDummyBuildings(pPlayer)
	local iNum = 0
	if pPlayer:GetLeaderType() == iPurpleHeart then
		iNum = math.floor(HDNMod.Shares[pPlayer:GetID()] / PURPLE_HEART_UA_DIVISOR)
	end
		
	for pCity in pPlayer:Cities() do
		pCity:SetNumRealBuilding(PURPLE_HEART_UA_BUILDING, iNum, true)
	end
end

--Function wrappers for puppeting and annexing cities
function NeptunePuppet(pCity)
    pCity:DoTask(TaskTypes.TASK_CREATE_PUPPET, -1, -1)
	pCity:SetProductionAutomated(true)
	pCity:SetNumRealBuilding(HISTOIRE_DUMMY, 0)
	PuddingParlorDummyBuildings(Players[pCity:GetOwner()], pCity)
end

function NeptuneAnnex(pCity)
    pCity:DoTask(TaskTypes.TASK_ANNEX_PUPPET, -1, -1)
	PuddingParlorDummyBuildings(Players[pCity:GetOwner()], pCity)
end
LuaEvents.VV_NeptuneAnnex.Add(NeptuneAnnex)


--Set the dummy techs to obsolete Neptune's trait or not, so that she can annex and settle cities normally when needed.
--if bSet is true, set the PUPPETING_OFF trait to true and PUPPETING_ON trait false.
function NeptuneDummyTechSet(pPlayer, bSet)
	if Game:GetElapsedGameTurns() > 0 then
		local pTeam = Teams[pPlayer:GetTeam()]
		local bIsActivePlayer = (pPlayer:GetID() == Game:GetActivePlayer())
		
		--Special override to make the AI's settlers work:
		--If the player is an AI and it has a living Settler, always force off.
		if not pPlayer:IsHuman() then
			for pUnit in pPlayer:Units() do
				if pUnit:IsFound() then
					pTeam:SetHasTech(PUPPETING_ON, false)
					pTeam:SetHasTech(PUPPETING_OFF, true, pPlayer:GetID(), false, false, false)
					return
				end
			end
		end
		--Temporarily disable reward popups if they are on.
		local bNoRewardPopups = OptionsManager.IsNoRewardPopups_Cached()
		if bIsActivePlayer and not bNoRewardPopups then
			OptionsManager.SetNoRewardPopups_Cached(true)
			OptionsManager.CommitGameOptions();	
		end

		pTeam:SetHasTech(PUPPETING_ON, not bSet)
		pTeam:SetHasTech(PUPPETING_OFF, bSet, pPlayer:GetID(), false, false, false)
		
		if bIsActivePlayer and not bNoRewardPopups then
			OptionsManager.SetNoRewardPopups_Cached(false)
			OptionsManager.CommitGameOptions();
		end
	end
end


--Return true if one of Neptune's cities should be puppeted.
function ShouldCityBeForcedPuppet(pPlayer, pCity)
    --Neptune's cities should always be puppets if:
    --She isn't Purple Heart
    --AND Histoire isn't running the city
    --AND she hasn't completed the Pudding Quest
    local iPlayer = pPlayer:GetID()
	local sCity = CompileCityID(pCity)
	if pCity:IsRazing() then return false end
    if pPlayer:GetLeaderType() == iPurpleHeart then return false end
    if HDNMod.HistoireCity[iPlayer] and HDNMod.HistoireCity[iPlayer] == sCity and not HDNMod.HistoireArrivalTurn[iPlayer] then return false end
	if HDNMod.PuddingQuests[iPlayer] and HDNMod.PuddingQuests[iPlayer][sCity] and HDNMod.PuddingQuests[iPlayer][sCity].Completed == true then return false end
    return true
end

--Go over one or more of Neptune's cities and set them to be puppets as necessary.
--pCity does not have to be passed to the function; if it isn't, it loops over all her cities.
--Also calls the Pudding Parlor dummies function. 
--NEW: should also ensure that Histy's dummy building is gone if it shouldn't be there
function NeptuneEnsurePuppets(pPlayer, pCity)
	local iPlayer = pPlayer:GetID()
    if pCity then
        local bShouldPuppet = ShouldCityBeForcedPuppet(pPlayer, pCity)
        if bShouldPuppet and not pCity:IsPuppet() then
			NeptunePuppet(pCity)
			if not HDNMod.HistoireCity[iPlayer] or HDNMod.HistoireCity[iPlayer] ~= CompileCityID(pCity) then
				pCity:SetNumRealBuilding(HISTOIRE_DUMMY, 0)
			end
		end
	else
		for pCity in pPlayer:Cities() do
			local bShouldPuppet = ShouldCityBeForcedPuppet(pPlayer, pCity)
			if bShouldPuppet and not pCity:IsPuppet() then
				NeptunePuppet(pCity)
				if not HDNMod.HistoireCity[iPlayer] or HDNMod.HistoireCity[iPlayer] ~= CompileCityID(pCity) then
					pCity:SetNumRealBuilding(HISTOIRE_DUMMY, 0)
				end
			end
		end
	end
end

--Wrapper to change Histoire's Energy value.
function ChangeHistyEnergy(iPlayer, iValue)
    HDNMod.HistoireEnergy[iPlayer] = HDNMod.HistoireEnergy[iPlayer] + iValue
    --clamp
    if HDNMod.HistoireEnergy[iPlayer] < 0 then 
        HDNMod.HistoireEnergy[iPlayer] = 0
    elseif HDNMod.HistoireEnergy[iPlayer] > MAXIMUM_ENERGY then
        HDNMod.HistoireEnergy[iPlayer] = MAXIMUM_ENERGY
    end

	--Remove her from city if she's now below necessary amount
	if CanHistyMaintainACity(iPlayer) == false then
		RemoveHistyFromCity(iPlayer, true)
	end
end
LuaEvents.VV_ChangeHistyEnergy.Add(ChangeHistyEnergy)

--Can Histoire keep governing a city?
function CanHistyMaintainACity(iPlayer)
    if HDNMod.HistoireBlocked[iPlayer] or HDNMod.HistoireEnergy[iPlayer] < ENERGY_CONSUMED_PER_TURN then
        return false
    else
        return true
    end
end

--When Histoire arrives in the city (AFTER her 3 turns have elapsed for her to get there)
function HistyArriveInCity(iPlayer, bNotify)
    local sCity = HDNMod.HistoireCity[iPlayer]
    if sCity then
        local pPlayer = Players[iPlayer]
        local pCity = Vice_DecompileCityID(sCity)
		if pCity then    
			NeptuneAnnex(pCity)
			PuddingParlorDummyBuildings(pPlayer, pCity)
			pCity:SetNumRealBuilding(HISTOIRE_DUMMY, 1, true)
			if bNotify and iPlayer == Game:GetActivePlayer() then
				local sTitle = Locale.ConvertTextKey("TXT_KEY_VV_HDN_HISTOIRE_CITY_ARRIVAL_TITLE", pCity:GetName())
				local sText = Locale.ConvertTextKey("TXT_KEY_VV_HDN_HISTOIRE_CITY_ARRIVAL_TEXT", pCity:GetName(), ENERGY_CONSUMED_PER_TURN)

				pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, sText, sTitle, pCity:GetX(), pCity:GetY())
			end
		end
	end
	Events.SerialEventCityInfoDirty()
end


--Histoire is removed from a City, forcefully or voluntarily.
function RemoveHistyFromCity(iPlayer, bNotify)
    local sCity = HDNMod.HistoireCity[iPlayer]
    if sCity then
        local pPlayer = Players[iPlayer]
        local pCity = Vice_DecompileCityID(sCity) 
		if pCity then    
			HDNMod.HistoireCity[iPlayer] = nil
			pCity:SetNumRealBuilding(HISTOIRE_DUMMY, 0, true)
			if not pCity:IsPuppet() and ShouldCityBeForcedPuppet(pPlayer, pCity) == true then
				pCity:DoTask(TaskTypes.TASK_CLEAR_ORDERS, -1, -1)
				NeptunePuppet(pCity)
				PuddingParlorDummyBuildings(pPlayer, pCity)
			end
			if bNotify and iPlayer == Game:GetActivePlayer() then
				local sTitle = Locale.ConvertTextKey("TXT_KEY_VV_HDN_HISTOIRE_OUT_OF_ENERGY_TITLE")
				local sText = Locale.ConvertTextKey("TXT_KEY_VV_HDN_HISTOIRE_OUT_OF_ENERGY_TEXT", pCity:GetName())
				if pCity:IsPuppet() then
					sText = sText.."[NEWLINE][NEWLINE]"..Locale.ConvertTextKey("TXT_KEY_VV_HDN_HISTOIRE_CITY_REPUPPETED")
				end

				pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, sText, sTitle, pCity:GetX(), pCity:GetY())
			end
		end
    end
	
	Events.SerialEventCityInfoDirty()
end


--Used by E&D: Block Histy from use
function BlockHistyUse(iPlayer, iTurns)
	HDNMod.HistoireBlocked[iPlayer] = Game:GetGameTurn() + iTurns
	if MapModData.HistoireCity[iPlayer] then RemoveHistyFromCity(iPlayer) end
end
LuaEvents.VV_BlockHistyUse.Add(BlockHistyUse)


--Set Histoire to arrive in a City after 3 turns.
function DepartHisty(iCity, iPlayer)
	HDNMod.HistoireCity[iPlayer] = CompileCityID(Players[iPlayer]:GetCityByID(iCity))
    HDNMod.HistoireArrivalTurn[iPlayer] = Game:GetGameTurn() + HISTY_TRAVEL_TIME
	Events.SerialEventCityInfoDirty()
end


--Put slime down from a Dogoo
function SetDogooSlime(iPlayer, iUnit, iX, iY, bSet)
	if not HDNMod.DogooUnitData[iPlayer] and not HDNMod.DogooUnitData[iPlayer][iUnit] then return end
	local pPlot = Map.GetPlot(iX, iY)
	if bSet == false and pPlot:GetImprovementType() == DOGOO_SLIME then
		pPlot:SetImprovementType(-1)
		HDNMod.DogooUnitData[iPlayer][iUnit].ImprovementPlot.X = -1
		HDNMod.DogooUnitData[iPlayer][iUnit].ImprovementPlot.Y = -1
		
	elseif bSet == true then
		if not pPlot:IsCity() and not pPlot:IsWater() and not tGreatPersonImprovements[pPlot:GetImprovementType()] and not (pPlot:GetImprovementType() > -1 and pPlot:GetNumResource() > 0) then
			HDNMod.DogooUnitData[iPlayer][iUnit].ImprovementPlot.Turns = 0
			HDNMod.DogooUnitData[iPlayer][iUnit].ImprovementPlot.X = iX
			HDNMod.DogooUnitData[iPlayer][iUnit].ImprovementPlot.Y = iY
			pPlot:SetImprovementType(DOGOO_SLIME)
		end
	end
end


---------------------------------------------------------------------------------------------------------------------------------------------------------
-- PUDDING QUESTS
---------------------------------------------------------------------------------------------------------------------------------------------------------

--Quest helper functions
function SetQuestObjectivesText(sText, sObjectiveText, bFulfilled)
	local color = bFulfilled and "[COLOR_GREEN]" or "[COLOR_GREY]"
	sObjectiveText = "[NEWLINE][ICON_BULLET]"..color..sObjectiveText.."[ENDCOLOR]"
	sText = sText..sObjectiveText
	return sText
end

function DoCompleteQuest(iPlayer, iCity, iResource)
	local pPlayer = Players[iPlayer]
	local pCity = pPlayer:GetCityByID(iCity)
	pPlayer:ChangeNumResourceTotal(iResource, PUDDING_LUXURIES_ON_COMPLETE)
	pCity:SetNumRealBuilding(PUDDING_QUEST_COMPLETE, 1, true)
	ChangeShares(iPlayer, PUDDING_SHARES_BONUS)
	pPlayer:AddNotification(NotificationTypes.NOTIFICATION_PEACE_ACTIVE_PLAYER, Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_COMPLETED_TEXT", PUDDING_LUXURIES_ON_COMPLETE, GameInfo.Resources[iResource].Description, ConvertToPercentString(PUDDING_SHARES_BONUS)), Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_COMPLETED_NOTIFICATION", pCity:GetName()), pCity:GetX(), pCity:GetY(), iPlayer)
end

function GetNeptuneQuestTooltip(iQuestID, iPlayer, iCity, sCity, heading, subheading, body)
	local pPlayer = Players[iPlayer]
	local sCity = CompileCityID(pPlayer:GetCityByID(iCity))
	if HDNMod.PuddingQuests[iPlayer][sCity].Completed == true then
		heading:SetText("[COLOR_GREEN]"..string.upper(Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_COMPLETED_TITLE")).."[ENDCOLOR]")
		subheading:SetText(Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_COMPLETED_TEXT", PUDDING_LUXURIES_ON_COMPLETE, GameInfo.Resources[iQuestID].Description, ConvertToPercentString(PUDDING_SHARES_BONUS)))
		body:SetText("")
	else
		tQuests[iQuestID].TooltipFunc(iPlayer, iCity, sCity, heading, subheading, body)
	end
end

LuaEvents.VV_GetNeptuneQuestTooltip.Add(GetNeptuneQuestTooltip)



------------------------------------------------------------------
-- Quest 1
------------------------------------------------------------------

tQuests[iVanilla].Data["RequiredBuildings"] = {
	GameInfoTypes.BUILDING_CARAVANSARY,
	GameInfoTypes.BUILDING_MARKET
	}
tQuests[iVanilla].Data["CivsRequired"] = 3
tQuests[iVanilla].OnTurnFunc = (function(iPlayer, iCity, sCity)
	if not HDNMod.PuddingQuests[iPlayer][sCity].Data["OtherCivs"] then HDNMod.PuddingQuests[iPlayer][sCity].Data["OtherCivs"] = {} end
	local pPlayer = Players[iPlayer]
	local iTeam = pPlayer:GetTeam()
	local pTeam = Teams[iTeam]
	local pCity = pPlayer:GetCityByID(iCity)
	for k, v in pairs(tQuests[iVanilla].Data.RequiredBuildings) do
		if not pCity:IsHasBuilding(v) then return false end
	end
	local tTradeRoutes = pPlayer:GetTradeRoutes()
	local tPlayersWithTradeRoutes = {}
	print("Begin Trade Route test")
	for k, v in pairs(tTradeRoutes) do
		if v.ToID ~= v.FromID then
			print("Trade route from Planeptune to player "..v.ToID)
			tPlayersWithTradeRoutes[v.ToID] = true
		end
	end
	for i = 0, iMaxCivs - 1, 1 do
		if i ~= iPlayer then
			local pLoop = Players[i]
			local iLoopTeam = pLoop:GetTeam()
			local pLoopTeam = Teams[iLoopTeam]
			if tPlayersWithTradeRoutes[i] and pLoopTeam:IsAllowsOpenBordersToTeam(iTeam) and pTeam:IsAllowsOpenBordersToTeam(iLoopTeam) then
				print("Mutual Open Borders")
				if not HDNMod.PuddingQuests[iPlayer][sCity].Data["OtherCivs"][i] then HDNMod.PuddingQuests[iPlayer][sCity].Data["OtherCivs"][i] = 0 end
				HDNMod.PuddingQuests[iPlayer][sCity].Data["OtherCivs"][i] = math.min(HDNMod.PuddingQuests[iPlayer][sCity].Data["OtherCivs"][i] + 1, tQuests[iVanilla].Data.TurnsRequired)
			end
		end
	end
	
	local iMetRequirementCivs = 0
	for k, v in pairs(HDNMod.PuddingQuests[iPlayer][sCity].Data["OtherCivs"]) do
		if v >= tQuests[iVanilla].Data.TurnsRequired then
			iMetRequirementCivs = iMetRequirementCivs + 1
			if iMetRequirementCivs >= tQuests[iVanilla].Data["CivsRequired"] then
				HDNMod.PuddingQuests[iPlayer][sCity].Completed = true
				return true
			end
		end
	end
end)
tQuests[iVanilla].TooltipFunc = (function(iPlayer, iCity, sCity, heading, subheading, body)
	local pPlayer = Players[iPlayer]
	local pCity = pPlayer:GetCityByID(iCity)
	heading:SetText("[COLOR_GREEN]"..string.upper(Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_1_TITLE")).."[ENDCOLOR]")
	subheading:SetText("[COLOR_YELLOW]"..Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_1_SUBTITLE", tQuests[iVanilla].Data.TurnsRequired).."[ENDCOLOR]")
	
	local sBody = Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_1_FLAVOR", pCity:GetName()).."[NEWLINE][NEWLINE]"..Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_OBJECTIVES_HEADER")
	
	for k, v in pairs(tQuests[iVanilla].Data.RequiredBuildings) do
		sBody = SetQuestObjectivesText(sBody, Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_BUILD", GameInfo.Buildings[v].Description), pCity:IsHasBuilding(v))
	end
	sBody = SetQuestObjectivesText(sBody, Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_1_OBJECTIVE"), false)
	if not HDNMod.PuddingQuests[iPlayer][sCity].Data["OtherCivs"] then HDNMod.PuddingQuests[iPlayer][sCity].Data["OtherCivs"] = {} end
	for k, v in pairs(HDNMod.PuddingQuests[iPlayer][sCity].Data["OtherCivs"]) do
		local sText = Players[k]:GetCivilizationShortDescription().." ("..v.."/"..tQuests[iVanilla].Data.TurnsRequired..")"
		sBody = SetQuestObjectivesText(sBody, sText, v >= tQuests[iVanilla].Data.TurnsRequired)
	end
	body:SetText(sBody)
end)

------------------------------------------------------------------
-- Quest 2
------------------------------------------------------------------

tQuests[iChocolate].Data["ThemingBonusCities"] = {}
for row in GameInfo.Building_ThemingBonuses() do
	local building = GameInfo.Buildings[row.BuildingType]
	local buildingClass = GameInfo.BuildingClasses[building.BuildingClass].ID
	table.insert(tQuests[iChocolate].Data["ThemingBonusCities"], {
		["Building"] = building.ID,
		["BuildingClass"] = buildingClass
	})
end
tQuests[iChocolate].OnTurnFunc = (function(iPlayer, iCity, sCity)
	if not HDNMod.PuddingQuests[iPlayer][sCity].Data["TurnsLeft"] then HDNMod.PuddingQuests[iPlayer][sCity].Data["TurnsLeft"] = tQuests[iChocolate].Data.TurnsRequired end
	local pPlayer = Players[iPlayer]
	local pCity = pPlayer:GetCityByID(iCity)
	if pCity:GetNumWorldWonders() == 0 then return false end

	for k, v in pairs(tQuests[iChocolate].Data["ThemingBonusCities"]) do
		if pCity:IsHasBuilding(v.Building) and pCity:GetThemingBonus(v.BuildingClass) > 0 then
			HDNMod.PuddingQuests[iPlayer][sCity].Data["TurnsLeft"] = HDNMod.PuddingQuests[iPlayer][sCity].Data["TurnsLeft"] - 1
			if HDNMod.PuddingQuests[iPlayer][sCity].Data["TurnsLeft"] <= 0 then
				HDNMod.PuddingQuests[iPlayer][sCity].Completed = true
				return true
			end
		end
	end
end)
tQuests[iChocolate].TooltipFunc = (function(iPlayer, iCity, sCity, heading, subheading, body)
	local pPlayer = Players[iPlayer]
	local pCity = pPlayer:GetCityByID(iCity)
	heading:SetText("[COLOR_GREEN]"..string.upper(Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_2_TITLE")).."[ENDCOLOR]")
	subheading:SetText("[COLOR_YELLOW]"..Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_2_SUBTITLE", tQuests[iChocolate].Data.TurnsRequired).."[ENDCOLOR]")
	
	local sBody = Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_2_FLAVOR", pCity:GetName()).."[NEWLINE][NEWLINE]"..Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_OBJECTIVES_HEADER")
	
	sBody = SetQuestObjectivesText(sBody, Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_2_OBJECTIVE_1"), pCity:GetNumWorldWonders() > 0)
	
	if not HDNMod.PuddingQuests[iPlayer][sCity].Data["TurnsLeft"] then HDNMod.PuddingQuests[iPlayer][sCity].Data["TurnsLeft"] = tQuests[iChocolate].Data.TurnsRequired end
	sBody = SetQuestObjectivesText(sBody, Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_2_OBJECTIVE_2", math.abs(HDNMod.PuddingQuests[iPlayer][sCity].Data["TurnsLeft"] - tQuests[iStrawberry].Data.TurnsRequired), tQuests[iChocolate].Data.TurnsRequired), HDNMod.PuddingQuests[iPlayer][sCity].Data["TurnsLeft"] <= 0)
	body:SetText(sBody)
end)

------------------------------------------------------------------
-- Quest 3
------------------------------------------------------------------

tQuests[iStrawberry].Data["RequiredBuilding"] = GameInfoTypes.BUILDING_UNIVERSITY
tQuests[iStrawberry].Data["RequiredOrBuildings"] = {
	GameInfoTypes.BUILDING_GARDEN,
	GameInfoTypes.BUILDING_PUBLIC_SCHOOL
	}
tQuests[iStrawberry].OnTurnFunc = (function(iPlayer, iCity, sCity)
	if not HDNMod.PuddingQuests[iPlayer][sCity].Data["TurnsLeft"] then HDNMod.PuddingQuests[iPlayer][sCity].Data["TurnsLeft"] = tQuests[iStrawberry].Data.TurnsRequired end
	local pPlayer = Players[iPlayer]
	local pCity = pPlayer:GetCityByID(iCity)
	if pCity:IsHasBuilding(tQuests[iStrawberry].Data["RequiredBuilding"]) == false then return false end
	local bAnyOrBuilding = false
	for k, v in pairs(tQuests[iStrawberry].Data["RequiredOrBuildings"]) do
		if pCity:IsHasBuilding(v) then
			bAnyOrBuilding = true
			break
		end
	end
	if bAnyOrBuilding == false then return false end
	local iNumPlots = pCity:GetNumCityPlots();
	local iNumWorked = 0
	for iPlot = 0, iNumPlots - 1 do
		local pPlot = pCity:GetCityIndexPlot(iPlot)
		if pPlot then
			--Improvements
			local iImprovement = pPlot:GetImprovementType()
			if tGreatPersonImprovements[iImprovement] and pCity:IsWorkingPlot(pPlot) and not pPlot:IsImprovementPillaged() then
				iNumWorked = iNumWorked + 1
				if iNumWorked >= 4 then
					HDNMod.PuddingQuests[iPlayer][sCity].Data["TurnsLeft"] = HDNMod.PuddingQuests[iPlayer][sCity].Data["TurnsLeft"] - 1
					if HDNMod.PuddingQuests[iPlayer][sCity].Data["TurnsLeft"] <= 0 then
						HDNMod.PuddingQuests[iPlayer][sCity].Completed = true
						return true
					end
					break
				end
			end
		end
	end
end)
tQuests[iStrawberry].TooltipFunc = (function(iPlayer, iCity, sCity, heading, subheading, body)
	local pPlayer = Players[iPlayer]
	local pCity = pPlayer:GetCityByID(iCity)
	heading:SetText("[COLOR_GREEN]"..string.upper(Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_3_TITLE")).."[ENDCOLOR]")
	subheading:SetText("[COLOR_YELLOW]"..Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_3_SUBTITLE", tQuests[iStrawberry].Data.TurnsRequired).."[ENDCOLOR]")
	
	local sBody = Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_3_FLAVOR", pCity:GetName()).."[NEWLINE][NEWLINE]"..Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_OBJECTIVES_HEADER")
	
	sBody = SetQuestObjectivesText(sBody, Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_BUILD", GameInfo.Buildings[tQuests[iStrawberry].Data["RequiredBuilding"]].Description), pCity:IsHasBuilding(tQuests[iStrawberry].Data["RequiredBuilding"]))
	local bAnyOrBuilding = false
	for k, v in pairs(tQuests[iStrawberry].Data["RequiredOrBuildings"]) do
		if pCity:IsHasBuilding(v) then
			bAnyOrBuilding = true
			break
		end
	end
	sBody = SetQuestObjectivesText(sBody, Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_3_OBJECTIVE_1"), bAnyOrBuilding)
	
	local bThemingBonus = false
	if not HDNMod.PuddingQuests[iPlayer][sCity].Data["TurnsLeft"] then HDNMod.PuddingQuests[iPlayer][sCity].Data["TurnsLeft"] = tQuests[iStrawberry].Data.TurnsRequired end
	sBody = SetQuestObjectivesText(sBody, Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_3_OBJECTIVE_2", math.abs(HDNMod.PuddingQuests[iPlayer][sCity].Data["TurnsLeft"] - tQuests[iStrawberry].Data.TurnsRequired), tQuests[iStrawberry].Data.TurnsRequired), HDNMod.PuddingQuests[iPlayer][sCity].Data["TurnsLeft"] <= 0)
	body:SetText(sBody)
end)

------------------------------------------------------------------
-- Quest 4
------------------------------------------------------------------
function GetNumNotPalaceNationalWonders(pCity)
	local iVal = pCity:GetNumNationalWonders()
	if pCity:IsHasBuilding(GameInfoTypes.BUILDING_PALACE) then
		iVal = iVal - 1
	end
	return iVal
end

tQuests[iBanana].Data["RequiredNatWonders"] = 3
tQuests[iBanana].OnTurnFunc = (function(iPlayer, iCity, sCity)
	if not HDNMod.PuddingQuests[iPlayer][sCity].Data["TurnsLeft"] then HDNMod.PuddingQuests[iPlayer][sCity].Data["TurnsLeft"] = tQuests[iBanana].Data.TurnsRequired end
	local pPlayer = Players[iPlayer]
	local pCity = pPlayer:GetCityByID(iCity)
	if GetNumNotPalaceNationalWonders(pCity) >= tQuests[iBanana].Data["RequiredNatWonders"] then
		HDNMod.PuddingQuests[iPlayer][sCity].Completed = true
		return true
	else
		return false
	end
end)
tQuests[iBanana].TooltipFunc = (function(iPlayer, iCity, sCity, heading, subheading, body)
	local pPlayer = Players[iPlayer]
	local pCity = pPlayer:GetCityByID(iCity)
	heading:SetText("[COLOR_GREEN]"..string.upper(Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_4_TITLE")).."[ENDCOLOR]")
	subheading:SetText("[COLOR_YELLOW]"..Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_4_SUBTITLE", tQuests[iBanana].Data.TurnsRequired).."[ENDCOLOR]")
	
	local sBody = Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_4_FLAVOR", pCity:GetName()).."[NEWLINE][NEWLINE]"..Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_OBJECTIVES_HEADER")
	sBody = SetQuestObjectivesText(sBody, Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_4_OBJECTIVE", math.min(GetNumNotPalaceNationalWonders(pCity), tQuests[iBanana].Data["RequiredNatWonders"]), tQuests[iBanana].Data["RequiredNatWonders"]), GetNumNotPalaceNationalWonders(pCity) >= tQuests[iBanana].Data["RequiredNatWonders"])
	body:SetText(sBody)
end)

------------------------------------------------------------------
-- Quest 5
------------------------------------------------------------------

tQuests[iCaramel].Data["RequiredBuildings"] = {
	GameInfoTypes.BUILDING_SHRINE,
	GameInfoTypes.BUILDING_TEMPLE
	}
tQuests[iCaramel].Data["SharesRequired"] = 500
tQuests[iCaramel].OnTurnFunc = (function(iPlayer, iCity, sCity)
	if not HDNMod.PuddingQuests[iPlayer][sCity].Data["SharesLeft"] then HDNMod.PuddingQuests[iPlayer][sCity].Data["SharesLeft"] = tQuests[iCaramel].Data["SharesRequired"] end
	local pPlayer = Players[iPlayer]
	local pCity = pPlayer:GetCityByID(iCity)
	for k, v in pairs(tQuests[iCaramel].Data.RequiredBuildings) do
		if not pCity:IsHasBuilding(v) then return false end
	end
	if pCity:GetProductionProcess() == GameInfoTypes.PROCESS_VV_HDN_SHARES then  
		local iProcessMultiplier = GameDefines.VV_HDN_SHARE_PROCESS_MULTIPLIER
		if pPlayer:GetReligionCreatedByPlayer() <= GameInfoTypes.RELIGION_PANTHEON and Game.GetNumReligionsStillToFound() == 0 then
			iProcessMultiplier = GameDefines.VV_HDN_SHARE_PROCESS_MULTIPLIER
		end
		if pPlayer:GetLeaderType() == iNeptune then
			iProcessMultiplier = iProcessMultiplier + (GameInfo.Traits["TRAIT_VV_NEPTUNE"].VV_Shares_ProcessMultiplier / 100)
		end
		local iFromSharesProduction = math.floor(pCity:GetCurrentProductionDifferenceTimes100() * iProcessMultiplier)

		HDNMod.PuddingQuests[iPlayer][sCity].Data["SharesLeft"] = math.max(HDNMod.PuddingQuests[iPlayer][sCity].Data["SharesLeft"] - iFromSharesProduction, 0)
		if HDNMod.PuddingQuests[iPlayer][sCity].Data["SharesLeft"] == 0 then
			HDNMod.PuddingQuests[iPlayer][sCity].Completed = true
			return true
		else
			return false
		end
	end
end)
tQuests[iCaramel].TooltipFunc = (function(iPlayer, iCity, sCity, heading, subheading, body)
	local pPlayer = Players[iPlayer]
	local pCity = pPlayer:GetCityByID(iCity)
	heading:SetText("[COLOR_GREEN]"..string.upper(Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_5_TITLE")).."[ENDCOLOR]")
	subheading:SetText("[COLOR_YELLOW]"..Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_5_SUBTITLE", tQuests[iCaramel].Data.TurnsRequired).."[ENDCOLOR]")
	
	local sBody = Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_5_FLAVOR", pCity:GetName()).."[NEWLINE][NEWLINE]"..Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_OBJECTIVES_HEADER")
	
	for k, v in pairs(tQuests[iCaramel].Data.RequiredBuildings) do
		sBody = SetQuestObjectivesText(sBody, Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_BUILD", GameInfo.Buildings[v].Description), pCity:IsHasBuilding(v))
	end
	
	if not HDNMod.PuddingQuests[iPlayer][sCity].Data["SharesLeft"] then HDNMod.PuddingQuests[iPlayer][sCity].Data["SharesLeft"] = tQuests[iCaramel].Data.SharesRequired end
	sBody = SetQuestObjectivesText(sBody, Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_5_OBJECTIVE", ConvertToPercentString(math.abs(HDNMod.PuddingQuests[iPlayer][sCity].Data["SharesLeft"] - tQuests[iCaramel].Data.SharesRequired)), ConvertToPercentString(tQuests[iCaramel].Data.SharesRequired)), HDNMod.PuddingQuests[iPlayer][sCity].Data["SharesLeft"] <= 0)
	body:SetText(sBody)
end)

------------------------------------------------------------------
-- Quest 6
------------------------------------------------------------------

tQuests[iBerry].Data["RequiredBuildings"] = {
	GameInfoTypes.BUILDING_BARRACKS,
	GameInfoTypes.BUILDING_WALLS
	}
tQuests[iBerry].Data["RequiredLevel"] = 6
tQuests[iBerry].Data["RequiredPromotions"] = {
	GameInfoTypes.PROMOTION_GREAT_GENERAL,
	GameInfoTypes.PROMOTION_GREAT_ADMIRAL
	}
tQuests[iBerry].OnTurnFunc = (function(iPlayer, iCity, sCity)
	if not HDNMod.PuddingQuests[iPlayer][sCity].Data["TurnsLeft"] then HDNMod.PuddingQuests[iPlayer][sCity].Data["TurnsLeft"] = tQuests[iBerry].Data.TurnsRequired end
	local pPlayer = Players[iPlayer]
	local pCity = pPlayer:GetCityByID(iCity)
	for k, v in pairs(tQuests[iBerry].Data.RequiredBuildings) do
		if not pCity:IsHasBuilding(v) then return false end
	end

	
	if HDNMod.PuddingQuests[iPlayer][sCity].Data["TurnsLeft"] > 0 then
		local pPlot = pCity:Plot()
		for c = 0, pPlot:GetNumUnits() - 1 do
			local pPlotUnit = pPlot:GetUnit(c)
			local bValidUnit = false
			if pPlotUnit and pPlotUnit:GetOwner() == iPlayer then
				for k, v in pairs(tQuests[iBerry].Data["RequiredPromotions"]) do
					if pPlotUnit:IsHasPromotion(v) then
						HDNMod.PuddingQuests[iPlayer][sCity].Data["TurnsLeft"] = HDNMod.PuddingQuests[iPlayer][sCity].Data["TurnsLeft"] - 1
						bValidUnit = true
						break
					end
				end
			end
			if bValidUnit then break end
		end
	end
	
	if HDNMod.PuddingQuests[iPlayer][sCity].Data["TurnsLeft"] == 0 then
		if not HDNMod.NeptuneUnitData[iPlayer] then HDNMod.NeptuneUnitData[iPlayer] = {} end
		for k, v in pairs(HDNMod.NeptuneUnitData[iPlayer]) do
			if v.HomeCity == iCity then
				local pUnit = pPlayer:GetUnitByID(k)
				if pUnit and pUnit:GetLevel() >= tQuests[iBerry].Data["RequiredLevel"] then
					HDNMod.PuddingQuests[iPlayer][sCity].Completed = true
					return true
				end
			end
		end
	end
end)
tQuests[iBerry].TooltipFunc = (function(iPlayer, iCity, sCity, heading, subheading, body)
	local pPlayer = Players[iPlayer]
	local pCity = pPlayer:GetCityByID(iCity)
	heading:SetText("[COLOR_GREEN]"..string.upper(Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_6_TITLE")).."[ENDCOLOR]")
	subheading:SetText("[COLOR_YELLOW]"..Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_6_SUBTITLE", tQuests[iBerry].Data.TurnsRequired).."[ENDCOLOR]")
	
	local sBody = Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_6_FLAVOR", pCity:GetName()).."[NEWLINE][NEWLINE]"..Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_OBJECTIVES_HEADER")
	
	for k, v in pairs(tQuests[iBerry].Data.RequiredBuildings) do
		sBody = SetQuestObjectivesText(sBody, Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_BUILD", GameInfo.Buildings[v].Description), pCity:IsHasBuilding(v))
	end
	
	local bLevel6Unit = false
	if not HDNMod.NeptuneUnitData[iPlayer] then HDNMod.NeptuneUnitData[iPlayer] = {} end
	for k, v in pairs(HDNMod.NeptuneUnitData[iPlayer]) do
		if v.HomeCity == iCity then
			local pUnit = pPlayer:GetUnitByID(k)
			if pUnit and pUnit:GetLevel() >= tQuests[iBerry].Data["RequiredLevel"] then
				bLevel6Unit = true
				break
			end
		end
	end
	sBody = SetQuestObjectivesText(sBody, Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_6_OBJECTIVE_1"), bLevel6Unit)
	
	local bThemingBonus = false
	if not HDNMod.PuddingQuests[iPlayer][sCity].Data["TurnsLeft"] then HDNMod.PuddingQuests[iPlayer][sCity].Data["TurnsLeft"] = tQuests[iBerry].Data.TurnsRequired end
	sBody = SetQuestObjectivesText(sBody, Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_6_OBJECTIVE_2", math.abs(HDNMod.PuddingQuests[iPlayer][sCity].Data["TurnsLeft"] - tQuests[iBerry].Data.TurnsRequired), tQuests[iBerry].Data.TurnsRequired), HDNMod.PuddingQuests[iPlayer][sCity].Data["TurnsLeft"] <= 0)
	body:SetText(sBody)
end)

------------------------------------------------------------------
-- Quest 7
------------------------------------------------------------------

tQuests[iMint].Data["RequiredBuildings"] = {
	GameInfoTypes.BUILDING_HARBOR,
	GameInfoTypes.BUILDING_SEAPORT
	}
tQuests[iMint].CanHaveQuestFunc = (function(iPlayer, iCity, sCity)
	if not Map.IsWrapX() then return false end
	local pPlayer = Players[iPlayer]
	local pCity = pPlayer:GetCityByID(iCity)
	if not pCity:IsCoastal() then return false end
end)
tQuests[iMint].Data["MapXWidth"], _ = Map.GetGridSize();
tQuests[iMint].OnTurnFunc = (function(iPlayer, iCity, sCity)
	local pPlayer = Players[iPlayer]
	local pCity = pPlayer:GetCityByID(iCity)
	for k, v in pairs(tQuests[iMint].Data.RequiredBuildings) do
		if not pCity:IsHasBuilding(v) then return false end
	end
	
	local pPlot = pCity:Plot()
	for c = 0, pPlot:GetNumUnits() - 1 do
		local pPlotUnit = pPlot:GetUnit(c)
		if pPlotUnit and pPlotUnit:GetOwner() == iPlayer then
			local iUnit = pPlotUnit:GetID()
			if HDNMod.NeptuneUnitData[iPlayer][iUnit] and HDNMod.NeptuneUnitData[iPlayer][iUnit].TraveledXCoords then
				if #HDNMod.NeptuneUnitData[iPlayer][iUnit].TraveledXCoords + 1 >= tQuests[iMint].Data["MapXWidth"] then
					HDNMod.PuddingQuests[iPlayer][sCity].Completed = true
					return true
				end
			end
		end
	end
end)
tQuests[iMint].TooltipFunc = (function(iPlayer, iCity, sCity, heading, subheading, body)
	local pPlayer = Players[iPlayer]
	local pCity = pPlayer:GetCityByID(iCity)
	heading:SetText("[COLOR_GREEN]"..string.upper(Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_7_TITLE")).."[ENDCOLOR]")
	subheading:SetText("[COLOR_YELLOW]"..Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_7_SUBTITLE", tQuests[iMint].Data.TurnsRequired).."[ENDCOLOR]")
	
	local sBody = Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_7_FLAVOR", pCity:GetName()).."[NEWLINE][NEWLINE]"..Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_OBJECTIVES_HEADER")
	
	for k, v in pairs(tQuests[iMint].Data.RequiredBuildings) do
		sBody = SetQuestObjectivesText(sBody, Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_BUILD", GameInfo.Buildings[v].Description), pCity:IsHasBuilding(v))
	end
	
	local bUnit = false
	local pPlot = pCity:Plot()
	for c = 0, pPlot:GetNumUnits() - 1 do
		local pPlotUnit = pPlot:GetUnit(c)
		if pPlotUnit and pPlotUnit:GetOwner() == iPlayer then
			local iUnit = pPlotUnit:GetID()
			if HDNMod.NeptuneUnitData[iPlayer][iUnit] and HDNMod.NeptuneUnitData[iPlayer][iUnit].TraveledXCoords then
				if #HDNMod.NeptuneUnitData[iPlayer][iUnit].TraveledXCoords + 1 >= tQuests[iMint].Data["MapXWidth"] then
					bUnit = true
					break
				end
			end
		end
	end
	sBody = SetQuestObjectivesText(sBody, Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_7_OBJECTIVE"), bUnit)
	body:SetText(sBody)
end)

------------------------------------------------------------------
-- Quest 8
------------------------------------------------------------------

tQuests[iCake].Data["RequiredBuildings"] = {
	GameInfoTypes.BUILDING_AMPHITHEATER,
	GameInfoTypes.BUILDING_OPERA_HOUSE
	}
tQuests[iCake].Data["RequiredCulture"] = 20
tQuests[iCake].OnTurnFunc = (function(iPlayer, iCity, sCity)
	if not HDNMod.PuddingQuests[iPlayer][sCity].Data["TurnsLeft"] then HDNMod.PuddingQuests[iPlayer][sCity].Data["TurnsLeft"] = tQuests[iCake].Data.TurnsRequired end
	local pPlayer = Players[iPlayer]
	local pCity = pPlayer:GetCityByID(iCity)
	for k, v in pairs(tQuests[iCake].Data.RequiredBuildings) do
		if not pCity:IsHasBuilding(v) then return false end
	end
	if pCity:GetJONSCulturePerTurn() >= tQuests[iCake].Data["RequiredCulture"] then
		HDNMod.PuddingQuests[iPlayer][sCity].Data["TurnsLeft"] = HDNMod.PuddingQuests[iPlayer][sCity].Data["TurnsLeft"] - 1
		if HDNMod.PuddingQuests[iPlayer][sCity].Data["TurnsLeft"] <= 0 then
			HDNMod.PuddingQuests[iPlayer][sCity].Completed = true
			return true
		end
	end
end)
tQuests[iCake].TooltipFunc = (function(iPlayer, iCity, sCity, heading, subheading, body)
	local pPlayer = Players[iPlayer]
	local pCity = pPlayer:GetCityByID(iCity)
	heading:SetText("[COLOR_GREEN]"..string.upper(Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_8_TITLE")).."[ENDCOLOR]")
	subheading:SetText("[COLOR_YELLOW]"..Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_8_SUBTITLE", tQuests[iCake].Data.TurnsRequired).."[ENDCOLOR]")
	
	local sBody = Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_8_FLAVOR", pCity:GetName()).."[NEWLINE][NEWLINE]"..Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_OBJECTIVES_HEADER")
	
	for k, v in pairs(tQuests[iCake].Data.RequiredBuildings) do
		sBody = SetQuestObjectivesText(sBody, Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_BUILD", GameInfo.Buildings[v].Description), pCity:IsHasBuilding(v))
	end
	
	local bThemingBonus = false
	if not HDNMod.PuddingQuests[iPlayer][sCity].Data["TurnsLeft"] then HDNMod.PuddingQuests[iPlayer][sCity].Data["TurnsLeft"] = tQuests[iCake].Data.TurnsRequired end
	sBody = SetQuestObjectivesText(sBody, Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_8_OBJECTIVE", math.abs(HDNMod.PuddingQuests[iPlayer][sCity].Data["TurnsLeft"] - tQuests[iCake].Data.TurnsRequired), tQuests[iCake].Data.TurnsRequired), HDNMod.PuddingQuests[iPlayer][sCity].Data["TurnsLeft"] <= 0)
	body:SetText(sBody)
end)



---------------------------------------------------------------------------------------------------------------------------------------------------------
-- LoadScreenClose
---------------------------------------------------------------------------------------------------------------------------------------------------------

-- function OnGameInit()

-- end
-- Events.LoadScreenClose.Add(OnGameInit)



---------------------------------------------------------------------------------------------------------------------------------------------------------
-- NotificationAdded
---------------------------------------------------------------------------------------------------------------------------------------------------------
local bDisableAllTechNotifications = false
function OnNotificationAdded( Id, nType, toolTip, strSummary, iGameValue, iExtraGameData, ePlayer )
	if (nType == NotificationTypes.NOTIFICATION_TECH_AWARD) and (bDisableAllTechNotifications == true or iExtraGameData == PUPPETING_OFF or iExtraGameData == PUPPETING_ON or iExtraGameData == GameInfoTypes.TECH_AGRICULTURE) then
		UI.RemoveNotification( Id )
	end
end
Events.NotificationAdded.Add(OnNotificationAdded)


---------------------------------------------------------------------------------------------------------------------------------------------------------
-- PlayerCityFounded
---------------------------------------------------------------------------------------------------------------------------------------------------------

function OnPlayerCityFounded(iPlayer, iX, iY)
	local pPlayer = Players[iPlayer]
	local pPlot = Map.GetPlot(iX, iY)
	if pPlot then
		local pCity = pPlot:GetPlotCity()
		if pCity:IsOriginalCapital() then
		
			--Temporarily disable reward popups if they are on.
			bDisableAllTechNotifications = true
			local bNoRewardPopups = OptionsManager.IsNoRewardPopups_Cached()
			if not bNoRewardPopups then
				OptionsManager.SetNoRewardPopups_Cached(true)
				OptionsManager.CommitGameOptions();	
			end
			
			if tNeptunes[iPlayer] and not HDNMod.HistoireEnergy[iPlayer] then
				HDNMod.HistoireEnergy[iPlayer] = STARTING_ENERGY
				HDNMod.PuddingQuests[iPlayer] = {}
				HDNMod.NeptuneUnitData[iPlayer] = {}
				pCity:SetNumRealBuilding(PUDDING_PARLOR, 1, false)
				OnCityConstructedPuddingParlor(iPlayer, pCity:GetID(), PUDDING_PARLOR)
			end
			local pTeam = Teams[pPlayer:GetTeam()]
			if not pTeam:IsHasTech(PUPPETING_ON) and not pTeam:IsHasTech(PUPPETING_OFF) then
				pTeam:GetTeamTechs():SetHasTech(PUPPETING_ON, true, iPlayer, false, false, false)
				local sCivilizationType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
				for row in GameInfo.Civilization_FreeTechs("CivilizationType = '"..sCivilizationType.."'") do
					local tech = GameInfo.Technologies[row.TechType]
					if tech then
						pTeam:SetHasTech(tech.ID, false)
						pTeam:SetHasTech(tech.ID, true, iPlayer, false, false, false)
					end
				end
			end
			
			if not bNoRewardPopups then
				OptionsManager.SetNoRewardPopups_Cached(false)
				OptionsManager.CommitGameOptions();
			end
		end
		
		if tNeptunes[iPlayer] then
			NeptuneEnsurePuppets(pPlayer, pCity)
		end
		
		bDisableAllTechNotifications = false
	end
end
GameEvents.PlayerCityFounded.Add(OnPlayerCityFounded)


---------------------------------------------------------------------------------------------------------------------------------------------------------
-- SpecificCityInfoDirty
---------------------------------------------------------------------------------------------------------------------------------------------------------

function OnSpecificCityInfoDirty(iPlayer, iCity)
    if tNeptunes[iPlayer] then
        local pPlayer = Players[iPlayer]	
        local pCity = pPlayer:GetCityByID(iCity)
        if pCity then
            NeptuneEnsurePuppets(pPlayer, pCity)
        end
    end
end
Events.SpecificCityInfoDirty.Add(OnSpecificCityInfoDirty)

---------------------------------------------------------------------------------------------------------------------------------------------------------
-- VV_RefreshHistyPanel
-- Used by HistyButton.lua
---------------------------------------------------------------------------------------------------------------------------------------------------------

function RefreshHistyPanel(energyLabel, statusLabel, pulldown, context)
	if not energyLabel or not statusLabel or not pulldown or not context then return end
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
	if tNeptunes[iPlayer] then
		context:SetHide(false) 
	else
		context:SetHide(true)
		return
	end
	
	
	--Energy Label
	local sEnergyText = "[COLOR_PLAYER_VV_PLANEPTUNE_BACKGROUND][ICON_VV_HISTY_ENERGY] "..HDNMod.HistoireEnergy[iPlayer].."%[NEWLINE]   ("
	if HDNMod.HistoireCity[iPlayer] then
		if HDNMod.HistoireArrivalTurn[iPlayer] then
			sEnergyText = sEnergyText.."+0"
		else
			sEnergyText = sEnergyText.."-"..ENERGY_CONSUMED_PER_TURN	
		end
	else
		if pPlayer:GetLeaderType() == iPurpleHeart then
			sEnergyText = sEnergyText.."+"..math.floor(ENERGY_GAIN_PER_TURN * PURPLE_HEART_ENERGY_RECOVERY_MULTIPLIER)
		else
			sEnergyText = sEnergyText.."+"..ENERGY_GAIN_PER_TURN
		end
	end
	sEnergyText = sEnergyText.."%)[ENDCOLOR]"
	energyLabel:SetText(sEnergyText)
	
	--Status Label
	local sStatusText;
	if HDNMod.HistoireCity[iPlayer] then
		local pCity = Vice_DecompileCityID(HDNMod.HistoireCity[iPlayer])
		if pCity then
			if HDNMod.HistoireArrivalTurn[iPlayer] then
				local iTurnsLeft = HDNMod.HistoireArrivalTurn[iPlayer] - Game:GetGameTurn()
				sStatusText = Locale.ConvertTextKey("TXT_KEY_VV_HDN_HISTOIRE_TRAVELING", pCity:GetName(), iTurnsLeft)
			else
				sStatusText = Locale.ConvertTextKey("TXT_KEY_VV_HDN_HISTOIRE_GOVERNING", pCity:GetName())
			end
		else
			sStatusText = Locale.ConvertTextKey("TXT_KEY_VV_HDN_HISTOIRE_NO_ASSIGNMENT")
		end
	else
		sStatusText = Locale.ConvertTextKey("TXT_KEY_VV_HDN_HISTOIRE_NO_ASSIGNMENT")
	end
	statusLabel:SetText(sStatusText)
	
	--Pulldown
	pulldown:ClearEntries()
	if HDNMod.HistoireEnergy[iPlayer] < ENERGY_CONSUMED_PER_TURN then
		pulldown:GetButton():LocalizeAndSetText("TXT_KEY_VV_HDN_HISTOIRE_NOT_ENOUGH_TO_ASSIGN");
		pulldown:GetButton():SetToolTipString(Locale.ConvertTextKey("TXT_KEY_VV_HDN_HISTOIRE_NOT_ENOUGH_TO_ASSIGN_TT", ENERGY_CONSUMED_PER_TURN));
		pulldown:SetDisabled(true)
	elseif pPlayer:GetLeaderType() == iPurpleHeart then
		pulldown:GetButton():LocalizeAndSetText("TXT_KEY_VV_HDN_HISTOIRE_CANT_ASSIGN_AS_PURPLE_HEART");
		pulldown:GetButton():SetToolTipString(Locale.ConvertTextKey("TXT_KEY_VV_HDN_HISTOIRE_CANT_ASSIGN_AS_PURPLE_HEART_TT"));
		pulldown:SetDisabled(true)
	elseif HDNMod.HistoireBlocked[iPlayer] then
		pulldown:GetButton():LocalizeAndSetText("TXT_KEY_VV_HDN_HISTOIRE_BLOCKED");
		pulldown:GetButton():SetToolTipString(Locale.ConvertTextKey("TXT_KEY_VV_HDN_HISTOIRE_BLOCKED_TT"));
		pulldown:SetDisabled(true)
	else
		pulldown:SetDisabled(false)
		function AddToPullDown(text, id)

			local controlTable = {};
			pulldown:BuildEntry( "InstanceOne", controlTable );
			
			controlTable.Button:SetVoids(id, 0);
			controlTable.Button:SetText(text);
		end
		
		function SetCurrentSelection(v1)
			if v1 == -1 then
				pulldown:GetButton():LocalizeAndSetText("TXT_KEY_VV_HDN_HISTOIRE_ASSIGN");
				pulldown:GetButton():SetToolTipString(Locale.ConvertTextKey("TXT_KEY_VV_HDN_HISTOIRE_ASSIGN_TT", ENERGY_CONSUMED_PER_TURN));
			else
				for pCity in pPlayer:Cities() do
					local sCity = CompileCityID(pCity)
					if(pCity:GetID() == v1) then
						pulldown:GetButton():LocalizeAndSetText(pCity:GetName());
						pulldown:GetButton():SetToolTipString(Locale.ConvertTextKey("TXT_KEY_VV_HDN_HISTOIRE_ASSIGN_TT", ENERGY_CONSUMED_PER_TURN));
						break
					end
				end
			end
		end
		
		AddToPullDown(Locale.ConvertTextKey("TXT_KEY_VV_HDN_HISTOIRE_UNASSIGN"), -1)
		for pCity in pPlayer:Cities() do
			if pCity:IsPuppet() and not pCity:IsResistance() and not pCity:IsRazing() then
				AddToPullDown(pCity:GetName(), pCity:GetID())
			end
		end
		
		if HDNMod.HistoireCity[iPlayer] then
			SetCurrentSelection(Vice_DecompileCityID(HDNMod.HistoireCity[iPlayer]):GetID())
		else
			SetCurrentSelection(-1)
		end
		
		
		pulldown:CalculateInternals();
		pulldown:RegisterSelectionCallback(function(v1, v2)
			print("RegisterSelectionCallback "..v1, v2)
			if v1 == -1 then
				LuaEvents.NetSyncCall("VV_NEPTUNE_HISTY_REMOVE")
				--Network.SendSellBuilding(pPlayer:GetCapitalCity():GetID(), iBuildingSellKeyHistyRemove)
			else
				LuaEvents.NetSyncCall("VV_NEPTUNE_HISTY", v1)
			end
			RefreshHistyPanel(energyLabel, statusLabel, pulldown, context)
		end)
	end
end
LuaEvents.VV_RefreshHistyPanel.Add(RefreshHistyPanel)

-- CitySoldBuilding (Network Compatibility)
function OnCitySoldBuilding(iPlayer, iCity)
	local pPlayer = Players[iPlayer]
	local pCity = pPlayer:GetCityByID(iCity)
	local sCity = CompileCityID(pCity)
	if (not HDNMod.HistoireCity[iPlayer]) or (HDNMod.HistoireCity[iPlayer] and sCity ~= iCity) then
		RemoveHistyFromCity(iPlayer)
		DepartHisty(iCity, iPlayer)
	end
end

function OnCitySoldBuildingRemove(iPlayer, iCity, iBuilding)
	if HDNMod.HistoireCity[iPlayer] then
		RemoveHistyFromCity(iPlayer)
	end
end
GameEvents.CitySoldBuilding.Add(OnCitySoldBuilding)

Events.LoadScreenClose.Add(function ()
LuaEvents.AddNetSyncFunction(OnCitySoldBuilding,		"VV_NEPTUNE_HISTY",			1)
LuaEvents.AddNetSyncFunction(OnCitySoldBuildingRemove,	"VV_NEPTUNE_HISTY_REMOVE",	1)
end)

---------------------------------------------------------------------------------------------------------------------------------------------------------
-- CityConstructed
---------------------------------------------------------------------------------------------------------------------------------------------------------

function OnCityConstructedPuddingParlor(iPlayer, iCity, iBuildingType, bGold, bFaithOrCulture)
	if iBuildingType == PUDDING_PARLOR then
		local pPlayer = Players[iPlayer]
		local pCity = pPlayer:GetCityByID(iCity)
		local sCity = CompileCityID(pCity)
		PuddingParlorDummyBuildings(pPlayer, pCity)
		
		--Don't assign duplicate quests...
		local tValidQuests = {}
		for k, v in pairs(tQuests) do
			if not HDNMod.AssignedQuests[iPlayer] then HDNMod.AssignedQuests[iPlayer] = {} end
			if not HDNMod.AssignedQuests[iPlayer][k] and v.CanHaveQuestFunc(iPlayer, iCity, sCity) == true then
				tValidQuests[#tValidQuests + 1] = k
			end
		end

		--...until we've run out of unique quests to assign
		if #tValidQuests == 0 then
			HDNMod.AssignedQuests[iPlayer] = {}
			for k, v in pairs(tQuests) do
				if v.CanHaveQuestFunc(iPlayer, iCity, sCity) == true then
					tValidQuests[#tValidQuests + 1] = k
				end
			end
		end


		local iRand = tValidQuests[Game.Rand(#tValidQuests, "Neptune Random Quest Roll") + 1]
		HDNMod.PuddingQuests[iPlayer][sCity] = {
			["QuestType"] = iRand,
			["Completed"] = false,
			["Data"] = {}
		}
		HDNMod.AssignedQuests[iPlayer][iRand] = true
		pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_STARTED_NOTIFICATION", pCity:GetName()), Locale.ConvertTextKey("TXT_KEY_VV_NEPTUNE_PUDDING_QUEST_STARTED_NOTIFICATION_TITLE", pCity:GetName()), pCity:GetX(), pCity:GetY())
	end
end
GameEvents.CityConstructed.Add(OnCityConstructedPuddingParlor)

---------------------------------------------------------------------------------------------------------------------------------------------------------
-- UnitSetXY
---------------------------------------------------------------------------------------------------------------------------------------------------------

function OnUnitSetXYNeptune(iPlayer, iUnit, iX, iY)
	if tNeptunes[iPlayer] and iX > 0 and iY > 0 then
		if not HDNMod.NeptuneUnitData[iPlayer][iUnit] then HDNMod.NeptuneUnitData[iPlayer][iUnit] = {} end
		if not HDNMod.NeptuneUnitData[iPlayer][iUnit].TraveledXCoords then HDNMod.NeptuneUnitData[iPlayer][iUnit].TraveledXCoords = {} end
		HDNMod.NeptuneUnitData[iPlayer][iUnit].TraveledXCoords[iX] = true
	end
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnit)
	if pUnit then
		if pUnit:IsHasPromotion(DOGOO_PROMO) then
			if not HDNMod.DogooUnitData[iPlayer] then HDNMod.DogooUnitData[iPlayer] = {} end
			if not HDNMod.DogooUnitData[iPlayer][iUnit] then
				HDNMod.DogooUnitData[iPlayer][iUnit] ={
					["LastTurnPlot"] = {
						["X"] = iX,
						["Y"] = iY,
						["Turns"] = 0
					},
					["ImprovementPlot"] = {
						["X"] = -1,
						["Y"] = -1,
						["Turns"] = 0
					}
				}
			else
				HDNMod.DogooUnitData[iPlayer][iUnit].LastTurnPlot = {
						["X"] = iX,
						["Y"] = iY,
						["Turns"] = 0
				}
			end
		elseif pUnit:GetPlot() and pUnit:GetPlot():GetImprovementType() == DOGOO_SLIME then
			pUnit:SetMoves(0)
		end
	end
end
GameEvents.UnitSetXY.Add(OnUnitSetXYNeptune)

---------------------------------------------------------------------------------------------------------------------------------------------------------
-- CityTrained
---------------------------------------------------------------------------------------------------------------------------------------------------------
function OnCityTrainedNeptune(iPlayer, iCity, iUnit, bGold, bFaithOrCulture)
	if iPlayer and tNeptunes[iPlayer] then
		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iUnit)
		if pUnit then
			HDNMod.NeptuneUnitData[iPlayer][iUnit] = {
				["HomeCity"] = iCity,
				["TraveledXCoords"] = {
					[pUnit:GetX()] = true
				}
			}
			if pUnit:IsHasPromotion(DOGOO_PROMO) then
				if not HDNMod.DogooUnitData[iPlayer] then HDNMod.DogooUnitData[iPlayer] = {} end
				HDNMod.DogooUnitData[iPlayer][iUnit] ={
					["LastTurnPlot"] = {
						["X"] = pUnit:GetX(),
						["Y"] = pUnit:GetY(),
						["Turns"] = 0
					},
					["ImprovementPlot"] = {
						["X"] = -1,
						["Y"] = -1,
						["Turns"] = 0
					}
				}
			end
		end
	end
end
GameEvents.CityTrained.Add(OnCityTrainedNeptune)

---------------------------------------------------------------------------------------------------------------------------------------------------------
-- PlayerAdoptPolicy
---------------------------------------------------------------------------------------------------------------------------------------------------------
local tSettlerPolicies = {}
for row in GameInfo.Policy_FreeUnitClasses("UnitClassType = 'UNITCLASS_SETTLER'") do
	tSettlerPolicies[row.PolicyType] = true
end

function OnPlayerAdoptPolicyNeptune(iPlayer, iPolicyID)
	if tNeptunes[iPlayer] then
		local pPlayer = Players[iPlayer];
		local sPolicy = GameInfo.Policies[iPolicyID].Type
		if tSettlerPolicies[sPolicy] then
			local pSettler = pPlayer:InitUnit(GameInfoTypes.UNIT_SETTLER, pPlayer:GetCapitalCity():GetX(), pPlayer:GetCapitalCity():GetY(), UNITAI_SETTLE)
			pSettler:JumpToNearestValidPlot()
		end
	end
end
GameEvents.PlayerAdoptPolicy.Add(OnPlayerAdoptPolicyNeptune)

---------------------------------------------------------------------------------------------------------------------------------------------------------
-- UnitPrekill
---------------------------------------------------------------------------------------------------------------------------------------------------------

function OnUnitPrekillNeptune(iVictim, iUnitID, iUnitType, iX, iY, bDelay, iKiller)
	if tNeptunes[iVictim] then
		if HDNMod.NeptuneUnitData[iPlayer] then
			HDNMod.NeptuneUnitData[iPlayer][iUnit] = nil
		end
		if HDNMod.DogooUnitData[iPlayer] then
			if HDNMod.DogooUnitData[iPlayer][iUnit] then
				SetDogooSlime(iPlayer, iUnit, HDNMod.DogooUnitData[iPlayer][iUnit].ImprovementPlot.X, HDNMod.DogooUnitData[iPlayer][iUnit].ImprovementPlot.Y, false)
			end
			HDNMod.DogooUnitData[iPlayer][iUnit] = nil
		end
	end
end
GameEvents.UnitPrekill.Add(OnCityTrainedNeptune)

---------------------------------------------------------------------------------------------------------------------------------------------------------
-- CityCaptureComplete
---------------------------------------------------------------------------------------------------------------------------------------------------------

function OnCityCaptureCompleteNeptune(iOldOwner, bCapital, iX, iY, iNewOwner, iPop, bConquest)
	if tNeptunes[iNewOwner] then
		local pPlayer = Players[iNewOwner]
		if pPlayer:GetLeaderType() == iNeptune then
			NeptuneDummyTechSet(pPlayer, false)
		end
	end
	if tNeptunes[iOldOwner] and HDNMod.HistoireCity[iOldOwner] then 
		local pPlayer = Players[iOldOwner]
		local pCity = Vice_DecompileCityID(HDNMod.HistoireCity[iOldOwner])
		if not pCity then
			HDNMod.HistoireCity[iOldOwner] = nil
			HDNMod.HistoireArrivalTurn[iOldOwner] = nil
		end
	end
end
GameEvents.CityCaptureComplete.Add(OnCityCaptureCompletePurpleSister)

---------------------------------------------------------------------------------------------------------------------------------------------------------
-- PlayerDoTurn
---------------------------------------------------------------------------------------------------------------------------------------------------------

function OnPlayerDoTurnNeptune(iPlayer)
	if tNeptunes[iPlayer] then
		local pPlayer = Players[iPlayer]
		if pPlayer:GetLeaderType() == iNeptune then
			if HDNMod.HistoireBlocked[iPlayer] and HDNMod.HistoireBlocked[iPlayer] <= Game:GetGameTurn() then
				HDNMod.HistoireBlocked[iPlayer] = nil
			end
			NeptuneDummyTechSet(pPlayer, false)
			if HDNMod.HistoireArrivalTurn[iPlayer] and HDNMod.HistoireArrivalTurn[iPlayer] <= Game:GetGameTurn() then
				if HDNMod.HistoireCity[iPlayer] then
					HistyArriveInCity(iPlayer, true)
				end
					HDNMod.HistoireArrivalTurn[iPlayer] = nil
			elseif not HDNMod.HistoireArrivalTurn[iPlayer] then
				if HDNMod.HistoireCity[iPlayer] then
					ChangeHistyEnergy(iPlayer, -ENERGY_CONSUMED_PER_TURN)
				else
					ChangeHistyEnergy(iPlayer, ENERGY_GAIN_PER_TURN)
				end
			end
			--AI Logic for sending Histy
			if not pPlayer:IsHuman() and not HDNMod.HistoireArrivalTurn[iPlayer] and not HDNMod.HistoireCity[iPlayer] and CanHistyMaintainACity(iPlayer) and HDNMod.HistoireEnergy[iPlayer] >= ENERGY_CONSUMED_PER_TURN * 10 then
				for pCity in pPlayer:Cities() do	
					if pCity:IsPuppet() and not pCity:IsResistance() then
						DepartHisty(pCity:GetID(), iPlayer)
						break
					end
				end
			end
		else
			NeptuneDummyTechSet(pPlayer, true)
			ChangeHistyEnergy(iPlayer, math.floor(ENERGY_GAIN_PER_TURN * PURPLE_HEART_ENERGY_RECOVERY_MULTIPLIER))
		end
		for pCity in pPlayer:Cities() do
			PuddingParlorDummyBuildings(pPlayer, pCity)
			local iCity = pCity:GetID()
			local sCity = CompileCityID(pCity)
			if HDNMod.PuddingQuests[iPlayer][sCity] and HDNMod.PuddingQuests[iPlayer][sCity].Completed == false then
				tQuests[HDNMod.PuddingQuests[iPlayer][sCity].QuestType].OnTurnFunc(iPlayer, iCity, sCity)
				if not pPlayer:IsHuman() then
					tQuests[HDNMod.PuddingQuests[iPlayer][sCity].QuestType].AIOnlyFunc(iPlayer, iCity, sCity)
				end
				if HDNMod.PuddingQuests[iPlayer][sCity].Completed == true then
					DoCompleteQuest(iPlayer, iCity, HDNMod.PuddingQuests[iPlayer][sCity].QuestType)
				end
			end
		end
		PurpleHeartDummyBuildings(pPlayer)
		

	end
	
	if HDNMod.DogooUnitData[iPlayer] then
		for k, v in pairs(HDNMod.DogooUnitData[iPlayer]) do
			local pPlayer = Players[iPlayer]
			local pUnit = pPlayer:GetUnitByID(k)
			if not pUnit then v = nil
			else
				if v.ImprovementPlot.X > -1 and v.ImprovementPlot.Y > -1 then
					local pPlot = Map.GetPlot(v.ImprovementPlot.X, v.ImprovementPlot.Y)
					if pPlot:GetImprovementType() == DOGOO_SLIME then
						v.ImprovementPlot.Turns = v.ImprovementPlot.Turns + 1
						if v.ImprovementPlot.Turns >= DOGOO_SLIME_TURNS then
							SetDogooSlime(iPlayer, k, v.ImprovementPlot.X, v.ImprovementPlot.Y, false)
						end
					else
						v.ImprovementPlot.X, v.ImprovementPlot.Y = -1, -1
						v.ImprovementPlot.Turns = 0
					end
				end
				local iX, iY = pUnit:GetX(), pUnit:GetY()
				if iX == v.LastTurnPlot.X and iY == v.LastTurnPlot.Y then
					v.LastTurnPlot.Turns = v.LastTurnPlot.Turns + 1
					if v.LastTurnPlot.Turns >= DOGOO_SLIME_MAKE_TURNS and v.ImprovementPlot.X == -1 and v.ImprovementPlot.Y == -1 then
						SetDogooSlime(iPlayer, k, iX, iY, true)
					end
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(OnPlayerDoTurnNeptune)

---------------------------------------------------------------------------------------------------------------------------------------------------------
-- VV_ConvertHDNLeader
---------------------------------------------------------------------------------------------------------------------------------------------------------
function OnTransformedNeptune(iPlayer, bHDDOn)
	if tNeptunes[iPlayer] then
		local pPlayer = Players[iPlayer]
		local iLeaderType = pPlayer:GetLeaderType()
		if iLeaderType == iPurpleHeart then
			NeptuneDummyTechSet(pPlayer, true)
			HDNMod.HistoireCity[iPlayer] = nil
			HDNMod.HistoireArrivalTurn[iPlayer] = nil
		elseif iLeaderType == iNeptune then
			NeptuneDummyTechSet(pPlayer, false)
		end
		for pCity in pPlayer:Cities() do
			PuddingParlorDummyBuildings(pPlayer, pCity)
		end
		PurpleHeartDummyBuildings(pPlayer)
	end
end
LuaEvents.VV_ConvertHDNLeader.Add(OnTransformedNeptune)


---------------------------------------------------------------------------------------------------------------------------------------------------------
-- VV_AddToTransformLogicTable
---------------------------------------------------------------------------------------------------------------------------------------------------------

function NeptuneTransformationAILogic(iPlayer)
	local bShouldTransform = false
	if HDNMod.Shares[iPlayer] >= GameDefines.VV_HDN_HDD_SHARE_THRESHOLD * 5 then
		--50%+ shares: Transform immediately, no questions asked.
		bShouldTransform = true
	elseif HDNMod.Shares[iPlayer] >= GameDefines.VV_HDN_HDD_SHARE_THRESHOLD * 2.5 then
		--25%-49.99% shares: Transform if at war, we don't have many world wonders, or if we are just below the global military average.
		local pPlayer = Players[iPlayer]
		local iOurWorldWonders = pPlayer:GetNumWorldWonders()
		local iLowestWorldWondersEveryoneElse = 10000
		for i = 0, iMaxCivs - 1, 1 do
			if i ~= iPlayer then
				local pLoop = Players[i]
				if pLoop:IsAlive() then
					local iTheirWonders = pLoop:GetNumWorldWonders()
					if iTheirWonders < iLowestWorldWondersEveryoneElse then
						iTheirWonders = iLowestWorldWondersEveryoneElse
					end
				end
			end
		end
		if iOurWorldWonders + 1 <= iLowestWorldWondersEveryoneElse then
			bShouldTransform = true
		else
			local pTeam = Teams[pPlayer:GetTeam()]
			for i = 0, iMaxCivs - 1, 1 do
				if i ~= iPlayer then
					local pLoop = Players[i]
					if pLoop:IsAlive() and pTeam:IsAtWar(pLoop:GetTeam()) then
						bShouldTransform = true
						break
					end
				end
			end
			if not bShouldTransform then
				local iOurMight = pPlayer:GetMilitaryMight()
				local iAverageMightOthers = 0
				local iNumMetCivsAlive = 0
				for i = 0, iMaxCivs - 1, 1 do
					if i ~= iPlayer then
						local pLoop = Players[i]
						if pLoop:IsAlive() and pTeam:IsHasMet(pLoop:GetTeam()) then
							iAverageMightOthers = iAverageMightOthers + pLoop:GetMilitaryMight()
							iNumMetCivsAlive = iNumMetCivsAlive + 1
						end
					end
				end
				iAverageMightOthers = math.floor(iAverageMightOthers / iNumMetCivsAlive)
				if iOurMight < iAverageMightOthers then
					bShouldTransform = true
				end
			end
		end
	elseif HDNMod.Shares[iPlayer] >= GameDefines.VV_HDN_HDD_SHARE_THRESHOLD * 2 then
		--20%-24.99% Shares: transform if at war or far behind the world militarily.
		local pPlayer = Players[iPlayer]
		local pTeam = Teams[pPlayer:GetTeam()]
		for i = 0, iMaxCivs - 1, 1 do
			if i ~= iPlayer then
				local pLoop = Players[i]
				if pLoop:IsAlive() and pTeam:IsAtWar(pLoop:GetTeam()) then
					bShouldTransform = true
					break
				end
			end
		end
		if not bShouldTransform then
			local iOurMight = pPlayer:GetMilitaryMight()
			local iAverageMightOthers = 0
			local iNumMetCivsAlive = 0
			for i = 0, iMaxCivs - 1, 1 do
				if i ~= iPlayer then
					local pLoop = Players[i]
					if pLoop:IsAlive() and pTeam:IsHasMet(pLoop:GetTeam()) then
						iAverageMightOthers = iAverageMightOthers + pLoop:GetMilitaryMight()
						iNumMetCivsAlive = iNumMetCivsAlive + 1
					end
				end
			end
			iAverageMightOthers = math.floor(iAverageMightOthers / iNumMetCivsAlive)
			if iOurMight < iAverageMightOthers * 1.33 and HDNMod.HistoireEnergy[iPlayer] < MAXIMUM_ENERGY / 10 then
				bShouldTransform = true
			end
		end
	elseif HDNMod.Shares[iPlayer] >= GameDefines.VV_HDN_HDD_SHARE_THRESHOLD * 1.5 then
		--15%-19.99% shares: Transform if Histy doesn't have much energy and we are far behind the world militarily.
		local pPlayer = Players[iPlayer]
		local pTeam = Teams[pPlayer:GetTeam()]
		local iOurMight = pPlayer:GetMilitaryMight()
		local iAverageMightOthers = 0
		local iNumMetCivsAlive = 0
		for i = 0, iMaxCivs - 1, 1 do
			if i ~= iPlayer then
				local pLoop = Players[i]
				if pLoop:IsAlive() and pTeam:IsHasMet(pLoop:GetTeam()) then
					iAverageMightOthers = iAverageMightOthers + pLoop:GetMilitaryMight()
					iNumMetCivsAlive = iNumMetCivsAlive + 1
				end
			end
		end
		iAverageMightOthers = math.floor(iAverageMightOthers / iNumMetCivsAlive)
		if iOurMight < iAverageMightOthers * 1.33 and HDNMod.HistoireEnergy[iPlayer] < MAXIMUM_ENERGY / 10 then
			bShouldTransform = true
		end
	end
	return bShouldTransform
end

function PurpleHeartTransformationAILogic(iPlayer)
	--Revert if we are both ahead of the curve militarily and have a fair number of wonders.
	local bShouldRevert = false
	local pPlayer = Players[iPlayer]
	local pTeam = Teams[pPlayer:GetTeam()]
	local iOurMight = pPlayer:GetMilitaryMight()
	local iAverageMightOthers = 0
	local iNumMetCivsAlive = 0
	for i = 0, iMaxCivs - 1, 1 do
		if i ~= iPlayer then
			local pLoop = Players[i]
			if pLoop:IsAlive() and pTeam:IsHasMet(pLoop:GetTeam()) then
				iAverageMightOthers = iAverageMightOthers + pLoop:GetMilitaryMight()
				iNumMetCivsAlive = iNumMetCivsAlive + 1
			end
		end
	end
	iAverageMightOthers = math.floor(iAverageMightOthers / iNumMetCivsAlive)
	if iOurMight > math.ceil(iAverageMightOthers * 1.4) then
		bShouldRevert = true
	end
	if not bShouldRevert then
		local iOurWorldWonders = pPlayer:GetNumWorldWonders()
		local iHighestWorldWondersEveryoneElse = 0
		for i = 0, iMaxCivs - 1, 1 do
			if i ~= iPlayer then
				local pLoop = Players[i]
				if pLoop:IsAlive() then
					local iTheirWonders = pLoop:GetNumWorldWonders()
					if iTheirWonders > iHighestWorldWondersEveryoneElse then
						iTheirWonders = iHighestWorldWondersEveryoneElse
					end
				end
			end
		end
		if iOurWorldWonders >= math.floor(iHighestWorldWondersEveryoneElse * 0.70) then
			bShouldRevert = true
		end
	end
	return bShouldRevert
end
LuaEvents.VV_AddToTransformLogicTable(iNeptune, NeptuneTransformationAILogic)
LuaEvents.VV_AddToTransformLogicTable(iPurpleHeart, PurpleHeartTransformationAILogic)

---------------------------------------------------------------------------------------------------------------------------------------------------------
-- CityCanConstruct / CityCanTrain
---------------------------------------------------------------------------------------------------------------------------------------------------------
--Prevents purchasing in puppet states
function NeptuneNoPuppetBuy(iPlayer, iCityID)
	if not tNeptunes[iPlayer] then
		return true
	end
	local pPlayer = Players[iPlayer]
	local pCity = UI.GetHeadSelectedCity()
	if pCity ~= nil then
		if pCity:IsPuppet() then
			return false
		end
	end
	return true
end

GameEvents.CityCanConstruct.Add(NeptuneNoPuppetBuy)
GameEvents.CityCanTrain.Add(NeptuneNoPuppetBuy)

---------------------------------------------------------------------------------------------------------------------------------------------------------
-- UnitSelectionChanged/Cleared
---------------------------------------------------------------------------------------------------------------------------------------------------------

function OnUnitSelectionChangedNeptune(iPlayer, iUnitID)
	if tNeptunes[iPlayer] then
		local pPlayer = Players[iPlayer]
		if pPlayer:GetLeaderType() == iNeptune then
			local pUnit = pPlayer:GetUnitByID(iUnitID)
			if pUnit and pUnit:IsFound() and not pUnit:IsCombatUnit() then
				NeptuneDummyTechSet(pPlayer, true)
			else
				NeptuneDummyTechSet(pPlayer, false)
			end
			Events.SerialEventUnitInfoDirty()
		end
	end
end
Events.UnitSelectionChanged.Add(OnUnitSelectionChangedNeptune)

function OnUnitSelectionClearedNeptune()
	local activePlayer = Game:GetActivePlayer()
	if tNeptunes[activePlayer] then
		local pPlayer = Players[activePlayer]
		if pPlayer:GetLeaderType() == iNeptune then
			NeptuneDummyTechSet(pPlayer, false)
		end
	end
end
Events.UnitSelectionCleared.Add(OnUnitSelectionClearedNeptune)

---------------------------------------------------------------------------------------------------------------------------------------------------------
-- SerialEventGameMessagePopup
---------------------------------------------------------------------------------------------------------------------------------------------------------

function OnPopupNeptune(popupInfo)
	local activePlayer = Game:GetActivePlayer()
	if tNeptunes[activePlayer] then
		local pPlayer = Players[activePlayer]
		if pPlayer:GetLeaderType() == iNeptune then
			if popupInfo.Type == ButtonPopupTypes.BUTTONPOPUP_ANNEX_CITY then 
				if HDNMod.PuddingQuests[activePlayer] and HDNMod.PuddingQuests[activePlayer][popupInfo.Data1] and HDNMod.PuddingQuests[activePlayer][popupInfo.Data1] == true then
					return
				else
					NeptuneDummyTechSet(pPlayer, true)
					UIManager:DequeuePopup(ContextPtr:LookUpControl('/InGame/GenericPopup'))
					local city = pPlayer:GetCityByID(popupInfo.Data1)
					UI.DoSelectCityAtPlot(city:Plot())
				end
			end
		end
	end
end
Events.SerialEventGameMessagePopup.Add(OnPopupNeptune)


---------------------------------------------------------------------------------------------------------------------------------------------------------
-- SerialEventEnterCityScreen
---------------------------------------------------------------------------------------------------------------------------------------------------------
Events.SerialEventEnterCityScreen.Add(OnUnitSelectionClearedNeptune)




---------------------------------------------------------------------------------------------------------------------------------------------------------
-- Community Balance Patch
---------------------------------------------------------------------------------------------------------------------------------------------------------

if GameInfo.COMMUNITY then
	for row in GameInfo.COMMUNITY() do
		if row.Type == "COMMUNITY_CORE_BALANCE_BUILDINGS" and row.Value == 1 then
			include("PlaneptuneCBP.lua")
			break
		end
	end
end



---------------------------------------------------------------------------------------------------------------------------------------------------------
-- DVMC/Community Patch better override for city founding
---------------------------------------------------------------------------------------------------------------------------------------------------------
function NeptunePlayerCanFoundCityRegardless(iPlayer, iX, iY)
	if tNeptunes[iPlayer] then
		local pPlayer = Players[iPlayer]
		if not pPlayer:IsEmpireVeryUnhappy() then
			local pPlot = Map.GetPlot(iX, iY)
			for pCity in pPlayer:Cities() do
				local pCityPlot = pCity:Plot()
				if pPlot:GetArea() == pCityPlot:GetArea() and Map.PlotDistance(pPlot:GetX(), pPlot:GetY(), pCityPlot:GetX(), pCityPlot:GetY()) <= GameDefines.MIN_CITY_RANGE then
					return
				end
			end
			return true
		end
	end
end

if GameInfo.CustomModOptions then
	for row in GameInfo.CustomModOptions("Name = 'EVENTS_CITY_FOUNDING' AND Value = 1") do
		bIsDVMCFound = true
		GameEvents.PlayerCanFoundCityRegardless.Add(NeptunePlayerCanFoundCityRegardless)
		Events.UnitSelectionChanged.Remove(OnUnitSelectionChangedNeptune)
		Events.UnitSelectionCleared.Remove(OnUnitSelectionClearedNeptune)
	end
end