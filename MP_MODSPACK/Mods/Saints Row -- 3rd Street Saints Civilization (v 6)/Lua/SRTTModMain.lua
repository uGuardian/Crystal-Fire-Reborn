-- SRTTModMain
-- Author: Vicevirtuoso
-- DateCreated: 7/17/2014 2:23:13 PM
--------------------------------------------------------------
local iMaxCivs = GameDefines.MAX_MAJOR_CIVS
print("Saints script loaded.")

--Find out if there are any Saints players in the game, and get their player IDs.-------------------------
local tWhoAreTheSaints = MapModData.gSRTTSaintsPlayers or {}

local bAnySaints;

if not MapModData.gSRTTSaintsPlayers then
	for i = 0, iMaxCivs - 1, 1 do
		local pPlayer = Players[i]
		if pPlayer:IsEverAlive() then
			leaderType = GameInfo.Leaders[pPlayer:GetLeaderType()].Type
			leadertraitType = GameInfo.Leader_Traits("LeaderType ='" .. leaderType .. "'")().TraitType
			traitType = GameInfo.Traits[leadertraitType]
			if traitType.EnableRespectSystem == 1 then
				tWhoAreTheSaints[i] = true
				bAnySaints = true
			end
		end
	end
else
	bAnySaints = true
end

if not bAnySaints then
	print("Saints are not present in the game. No further functions will run.")
	return
else
	local string = ""
	for k, v in pairs(tWhoAreTheSaints) do
		if string == "" then
			string = k
		else
			string = string..", "..k
		end
	end
	local string = "Saints player IDs: "..string
	print(string)
end

--End Saints discovery function----------------------------------------------------------------------------


--Global Table defines-------------------------------------------------------------------------------------
MapModData.SRTT = {}
MapModData.SRTT.Respect = {}						--Amount of Respect held per player
MapModData.SRTT.RespectLevel = {}			--Respect Level per player
MapModData.SRTT.JoyrideCooldown = {}		--Turns between when Joyrides can be done, Will use special CityIDs for tracking
MapModData.SRTT.NitrousCooldown = {}			--Turns between when Nitrous can be used , will use special UnitIDs for tracking
SRTT = MapModData.SRTT															


include("TableSaverLoader016.lua")
include("TSLSerializerV2SRTT.lua")
include("PlotIterators.lua")
include("FLuaVector.lua")




--Local variable and constant defines----------------------------------------------------------------------

--Who are the Saints?--------------------------------------------------------
if not MapModData.gSRTTSaintsPlayers then
	MapModData.gSRTTSaintsPlayers = tWhoAreTheSaints
end

--Cache Respect level infos--------------------------------------------------
if not MapModData.gSRTTRespectLevels then
	MapModData.gSRTTRespectLevels = {}
	for level in GameInfo.SRTT_RespectLevels() do
		MapModData.gSRTTRespectLevels[level.ID - 1] = {
			["RespectRequirement"] = level.RespectRequirement,
			["DummyBuilding"] = GameInfo.Buildings("Type = '" ..level.DummyBuilding.. "'")().ID,
			["DummyBuildingCount"] = level.DummyBuildingCount,
			["PromotionUnitType"] = GameInfo.Units("Type = '" ..level.PromotionUnitType.. "'")().ID,
			["Promotion"] = GameInfo.UnitPromotions("Type = '" ..level.Promotion.. "'")().ID
		}
	end
end

--How much of the player's Score do they get in Respect each turn?-----------
if not MapModData.gSRTTRespectFromScoreModifier then
	--Flat 10%
	MapModData.gSRTTRespectFromScoreModifier = 0.1
end

--How much do you get from a Joyride?----------------------------------------
if not MapModData.gSRTTJoyrideRespect then
	--Multiplier for the Unit's Combat Strength times the Gold output of the City.
	--50%. Triples if the Boss is in the City.
	MapModData.gSRTTJoyrideRespect = 0.50
end

--How much Population is lost from a Joyride?--------------------------------
if not MapModData.gSRTTJoyridePopulationLoss then
	--1. Doubles if Boss is in the City.
	MapModData.gSRTTJoyridePopulationLoss = 1
end

--How many turns must pass between Joyrides in a single City?----------------
if not MapModData.gSRTTJoyrideCooldownTurns then
	--Half of the chosen game speed's deal duration. 15 turns (at Standard speed)
	MapModData.gSRTTJoyrideCooldownTurns =  math.ceil(GameInfo.GameSpeeds[Game.GetGameSpeedType()].DealDuration / 2)
end

--How much do you get from having a Unit with Saint Paint in enemy territory?
if not MapModData.gSRTTSaintPaintRespect then
	--Multiplier for Unit's Combat Strength. 20%
	MapModData.gSRTTSaintPaintRespect = 0.2
end

--How much do you get from getting a second Boss if you already own one?-----
if not MapModData.gSRTTSecondBossRespect then
	--200% of your current Score.
	MapModData.gSRTTSecondBossRespect = 2
end

--How much damage do Kneecappers do?-----------------------------------------
if not MapModData.gSRTTKneecapperDamage then
	--flat 3 damage
	MapModData.gSRTTKneecapperDamage = 3
end

--How many turns must pass between Nitrous Boosts?---------------------------
if not MapModData.gSRTTNitrousCooldown then
	--10 turns. Not adjusting for game speed, since movement is the same regardless.
	MapModData.gSRTTNitrousCooldown = 10
end

--What are the Rim Jobs promotions?------------------------------------------
if not MapModData.gSRTTRimJobsPromotions then
	--Cache everything from the UnitPromotions table with Respect and RJGold
	MapModData.gSRTTRimJobsPromotions = {}
	for promotion in GameInfo.UnitPromotions() do
		if promotion.RespectLevelRequired > 0 and promotion.RJGoldCost > 0 then
			table.insert(MapModData.gSRTTRimJobsPromotions, promotion.ID)
		end
	end
end


---------------Other Local Variables-----------------------------------------


local iSaintPaint = GameInfoTypes.PROMOTION_SRTT_RJ_SAINT_PAINT
local iReinforcedFrame = GameInfoTypes.PROMOTION_SRTT_RJ_REINFORCED
local iKneecappers = GameInfoTypes.PROMOTION_SRTT_RJ_KNEECAPPERS
local iNitrousBoost = GameInfoTypes.PROMOTION_SRTT_RJ_NITROUS_ACTIVE
local iNoDefense = GameInfoTypes.PROMOTION_NO_DEFENSIVE_BONUSES
local iBoss = GameInfoTypes.UNIT_SRTT_BOSS
local iBossPromo = GameInfoTypes.PROMOTION_SRTT_BOSS

local iMagicalGirlClass = GameInfoTypes.UNITCLASS_PMMM_MAGICAL_GIRL --WFTW special compatibility


----------------------------------------------------------------------------------------------------------------------------------------------------
--Used for TableSaverLoader
----------------------------------------------------------------------------------------------------------------------------------------------------
function DataLoad()
	local bNewGame = not TableLoad(SRTT, "SRTTMod")

	TableSave(SRTT, "SRTTMod")  --before the initial autosave that runs for both new and loaded games
end


DataLoad()

----------------------------------------------------------------------------------------------------------------------------------------------------
--Functions called from other Functions
----------------------------------------------------------------------------------------------------------------------------------------------------

-- from http://lua-users.org/wiki/SplitJoin
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

function GetUnitSpecialID(iPlayer, iUnit)
	return iPlayer..":"..iUnit
end

function ReturnUnitFromSpecialID(ID)
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

function GetCitySpecialID(iX, iY)
	return iX..":"..iY
end

function ReturnCityFromSpecialID(ID)
	local temptable = split(ID, ":");
	local iX = tonumber(temptable[1])
	local iY = tonumber(temptable[2])
	local pPlot = Map.GetPlot(iX, iY)
	local pCity = pPlot:GetPlotCity()
	return pCity
end

function DoAddRespect(iPlayer, iAmount, pPlot)
	--initialize Respect and Level to 0 if they aren't there
	if not SRTT.Respect[iPlayer] then
		SRTT.Respect[iPlayer] = 0
	end
	if not SRTT.RespectLevel[iPlayer] then
		SRTT.RespectLevel[iPlayer] = 0
	end
	local iRespect = SRTT.Respect[iPlayer]
	local iLevel = SRTT.RespectLevel[iPlayer]
	iRespect = iRespect + iAmount
	--Do a loop for the levelup process, in case a user gains more than one level at once
	local bCanLevelUp = true
	while bCanLevelUp do
		if MapModData.gSRTTRespectLevels[iLevel + 1] then
			if iRespect >= MapModData.gSRTTRespectLevels[iLevel + 1].RespectRequirement then
				iRespect = iRespect - MapModData.gSRTTRespectLevels[iLevel + 1].RespectRequirement
				iLevel = iLevel + 1
				Players[iPlayer]:AddNotification(NotificationTypes.NOTIFICATION_PEACE_ACTIVE_PLAYER, Locale.ConvertTextKey("TXT_KEY_SRTT_NOTIFICATION_RESPECT_UP_TEXT", iLevel), Locale.ConvertTextKey("TXT_KEY_SRTT_NOTIFICATION_RESPECT_UP_TITLE"), -1, -1, iPlayer)
			else
				bCanLevelUp = false
			end
		else
			bCanLevelUp = false
		end
	end
	SRTT.Respect[iPlayer] = math.max(iRespect, 0)
	SRTT.RespectLevel[iPlayer] = iLevel
	--Hex popup if this function was passed a pPlot for it to be shown on
	if pPlot then
		Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(pPlot:GetX(), pPlot:GetY()))), Locale.ConvertTextKey("TXT_KEY_SRTT_TILEPOPUP_RESPECT_GAIN", iAmount), 1)
	end
	LuaEvents.SRTTRefreshRespectDisplay()
end

LuaEvents.SRTTDoAddRespect.Add(DoAddRespect)


function IsActivePlayerSaints(iPlayer, ttable)
	if tWhoAreTheSaints[iPlayer] then
		ttable[0] = true
	else
		ttable[0] = false
	end
end

LuaEvents.SRTTIsActivePlayerSaints.Add(IsActivePlayerSaints)

function GetRespect(iPlayer, ttable)
	local x = SRTT.Respect[iPlayer]
	ttable[0] = x or 0
end

LuaEvents.SRTTGetRespect.Add(GetRespect)

function GetNextRespectLevelReqs(iPlayer, ttable)
	local iLevel = SRTT.RespectLevel[iPlayer]
	if not iLevel then
		ttable[0] = MapModData.gSRTTRespectLevels[1].RespectRequirement or 0
		return
	end
	iLevel = iLevel + 1
	if MapModData.gSRTTRespectLevels[iLevel] then
		local x = MapModData.gSRTTRespectLevels[iLevel].RespectRequirement
		ttable[0] = x
	else
		ttable[0] = 0
	end
end

LuaEvents.SRTTGetNextRespectLevelReqs.Add(GetNextRespectLevelReqs)

function GetRespectPerTurn(iPlayer, ttable)
	local iRespectFromScore = math.floor(Players[iPlayer]:GetScore() * MapModData.gSRTTRespectFromScoreModifier)
	ttable[0] = iRespectFromScore or 0
end

LuaEvents.SRTTGetRespectPerTurn.Add(GetRespectPerTurn)

function GetRespectLevel(iPlayer, ttable)
	local iLevel = SRTT.RespectLevel[iPlayer]
	ttable[0] = iLevel or 0
end

LuaEvents.SRTTGetRespectLevel.Add(GetRespectLevel)

function GetNextRespectLevel(iPlayer, ttable)
	local iLevel = SRTT.RespectLevel[iPlayer]
	if not iLevel then
		ttable[0] = 1
		return
	end
	iLevel = iLevel + 1
	if MapModData.gSRTTRespectLevels[iLevel] then
		ttable[0] = iLevel
	else
		ttable[0] = -1
	end
end

LuaEvents.SRTTGetNextRespectLevel.Add(GetNextRespectLevel)

function GetNitrousCooldown(pUnit, ttable)
	local iOwner = pUnit:GetOwner()
	local iUnit = pUnit:GetID()
	local iSpecialID = GetUnitSpecialID(iOwner, iUnit)
	ttable[0] = SRTT.NitrousCooldown[iSpecialID]
end
LuaEvents.SRTTGetNitrousCooldown.Add(GetNitrousCooldown)

function GetJoyrideCooldown(pCity, ttable)
	local iX = pCity:GetX()
	local iY = pCity:GetY()
	local iSpecialID = GetCitySpecialID(iX, iY)
	ttable[0] = SRTT.JoyrideCooldown[iSpecialID]
end
LuaEvents.SRTTGetJoyrideCooldown.Add(GetJoyrideCooldown)

----------------------------------------------------------------------------------------------------------------------------------------------------
--PlayerDoTurn function
----------------------------------------------------------------------------------------------------------------------------------------------------

function OnSaintsTurn(iPlayer)
	if tWhoAreTheSaints[iPlayer] then
		local pPlayer = Players[iPlayer]
		if pPlayer:IsAlive() then
			--Init respect if not there
			SRTT.RespectLevel[iPlayer] = SRTT.RespectLevel[iPlayer] or 0

			--Respect from Score
			local iRespectFromScore = math.floor(pPlayer:GetScore() * MapModData.gSRTTRespectFromScoreModifier)
			DoAddRespect(iPlayer, iRespectFromScore)

			--Set Dummy Buildings in Capital from Respect
			local iRespectLevel = SRTT.RespectLevel[iPlayer]
			local iBuildingType = MapModData.gSRTTRespectLevels[iRespectLevel].DummyBuilding
			local iBuildingCount = MapModData.gSRTTRespectLevels[iRespectLevel].DummyBuildingCount
			if pPlayer:GetCapitalCity() then
				pPlayer:GetCapitalCity():SetNumRealBuilding(iBuildingType, iBuildingCount)
			end

			local iUnitType = MapModData.gSRTTRespectLevels[iRespectLevel].PromotionUnitType
			local iPromotionType = MapModData.gSRTTRespectLevels[iRespectLevel].Promotion

			--Set Boss's Moves
			for pUnit in pPlayer:Units() do
				if pUnit:IsHasPromotion(iBossPromo) then
					--Make sure it has the great general promotion. (Mostly for WFTW)
					pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_GREAT_GENERAL, true)
					for k, v in pairs(MapModData.gSRTTRespectLevels) do
						if v.Promotion == iPromotionType then
							pUnit:SetHasPromotion(v.Promotion, true)
						else
							pUnit:SetHasPromotion(v.Promotion, false)
						end
					end
				end
				--find Units with Saint Paint in enemy territory
				if pUnit:IsHasPromotion(iSaintPaint) then
					local pPlot = pUnit:GetPlot()
					local iOwner = pPlot:GetOwner()
					if iOwner > 0 and iOwner ~= iPlayer then
						local pTeam = Teams[pPlayer:GetTeam()]
						local iEnemyTeam = Players[iOwner]:GetTeam()
						if pTeam:IsAtWar(iEnemyTeam) then
							local iRespectFromSaintPaint = math.floor(pUnit:GetBaseCombatStrength() * MapModData.gSRTTSaintPaintRespect)
							DoAddRespect(iPlayer, iRespectFromSaintPaint, pPlot)
						end
					end
				end
				--Reduce Nitrous Cooldown
				local iSpecialID = GetUnitSpecialID(iPlayer, pUnit:GetID())
				if SRTT.NitrousCooldown[iSpecialID] then
					SRTT.NitrousCooldown[iSpecialID] = SRTT.NitrousCooldown[iSpecialID] - 1
					if SRTT.NitrousCooldown[iSpecialID] == 0 then
						SRTT.NitrousCooldown[iSpecialID] = nil
					end
				end
				--Remove Nitrous Boost and set cooldown
				if pUnit:IsHasPromotion(iNitrousBoost) then
					pUnit:SetHasPromotion(iNitrousBoost, false)
					pUnit:SetMoves(pUnit:MaxMoves())
					SRTT.NitrousCooldown[iSpecialID] = MapModData.gSRTTNitrousCooldown
				end
				--Remove Defense penalty from units with Reinforced Frame
				if pUnit:IsHasPromotion(iReinforcedFrame) then
					pUnit:SetHasPromotion(iNoDefense, false)
				end
			end
			--Reduce Joyride Cooldown
			for k, v in pairs(SRTT.JoyrideCooldown) do
				if v then
					SRTT.JoyrideCooldown[k] = v - 1
					if SRTT.JoyrideCooldown[k] == 0 then
						SRTT.JoyrideCooldown[k] = nil
					end
				end
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(OnSaintsTurn)


----------------------------------------------------------------------------------------------------------------------------------------------------
--UnitSetXY function
----------------------------------------------------------------------------------------------------------------------------------------------------

function OnUnitSetXY(iPlayer, iUnit, iX, iY)
	if iX > 0 and iY > 0 then
		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iUnit)
		if pUnit then
			--Kneecappers damage
			if pUnit:IsHasPromotion(iKneecappers) then
				local iDamage = MapModData.gSRTTKneecapperDamage
				for pAreaPlot in PlotAreaSpiralIterator(pUnit:GetPlot(), 1, 1, false, false, false) do
					if pAreaPlot:IsUnit() then
						for c = 0, pAreaPlot:GetNumUnits() - 1 do
							local pEnemyUnit = pAreaPlot:GetUnit(c)
							if pEnemyUnit then
								if pEnemyUnit:GetOwner() ~= iPlayer then
									local pTeam = Teams[pPlayer:GetTeam()]
									local iEnemyTeam = Players[pEnemyUnit:GetOwner()]:GetTeam()
									if pTeam:IsAtWar(iEnemyTeam) then
										pEnemyUnit:ChangeDamage(iDamage, iPlayer)
										break
									end
								end
							end
						end
					end
				end
			end
			--Reinforced Frame
			if pUnit:IsHasPromotion(iReinforcedFrame) then
				pUnit:SetHasPromotion(iNoDefense, false)
			end 
			--If it's a Boss, see if another one exists, then kill this new one if so. Also, give him his Respect moves bonus.
			if tWhoAreTheSaints[iPlayer] then
				--Init respect if not there
				SRTT.RespectLevel[iPlayer] = SRTT.RespectLevel[iPlayer] or 0
				local iRespectLevel = SRTT.RespectLevel[iPlayer]
				local iUnitType = MapModData.gSRTTRespectLevels[iRespectLevel].PromotionUnitType
				local iPromotionType = MapModData.gSRTTRespectLevels[iRespectLevel].Promotion
				if pUnit:IsHasPromotion(iBossPromo) then
					--Make sure it has the great general promotion. (Mostly for WFTW)
					pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_GREAT_GENERAL, true)
					for k, v in pairs(MapModData.gSRTTRespectLevels) do
						if v.Promotion == iPromotionType then
							pUnit:SetHasPromotion(v.Promotion, true)
						else
							pUnit:SetHasPromotion(v.Promotion, false)
						end
					end
				end
				if pUnit:GetUnitType() == iBoss then
					if iMagicalGirlClass ~= nil then
						local iRespectFromSecondBoss = math.floor(pPlayer:GetScore() * MapModData.gSRTTSecondBossRespect)
						DoAddRespect(iPlayer, iRespectFromSecondBoss, pUnit:GetPlot())
						pUnit:Kill(true)
					else
						for pLoopUnit in pPlayer:Units() do
							if pLoopUnit:GetUnitType() == iBoss and pLoopUnit ~= pUnit then
								local iRespectFromSecondBoss = math.floor(pPlayer:GetScore() * MapModData.gSRTTSecondBossRespect)
								DoAddRespect(iPlayer, iRespectFromSecondBoss, pUnit:GetPlot())
								pUnit:Kill(true)
								break
							end
						end
					end
				end
			end
		end
	end
end

GameEvents.UnitSetXY.Add(OnUnitSetXY)


----------------------------------------------------------------------------------------------------------------------------------------------------
--Functions called by Action Buttons
----------------------------------------------------------------------------------------------------------------------------------------------------

function DoJoyride(pUnit)
	local iPlayer = pUnit:GetOwner()
	local pPlayer = Players[iPlayer]
	local pPlot = pUnit:GetPlot()
	local pCity = pPlot:GetPlotCity()
	local iStrength = pUnit:GetBaseCombatStrength()
	local iGoldPerTurn = pCity:GetYieldRateTimes100(YieldTypes.YIELD_GOLD) / 100
	local iTotalRespect = math.ceil(iStrength * iGoldPerTurn * MapModData.gSRTTJoyrideRespect)
	local iTotalPopLoss = MapModData.gSRTTJoyridePopulationLoss
	for i = 0, pPlot:GetNumUnits() - 1 do
		local pPlotUnit = pPlot:GetUnit(i)
		if pPlotUnit ~= pUnit and pPlotUnit:IsHasPromotion(iBossPromo) then
			iTotalRespect = iTotalRespect * 3
			iTotalPopLoss = iTotalPopLoss * 2
		end
	end
	DoAddRespect(iPlayer, iTotalRespect, pPlot)
	if iTotalPopLoss >= pCity:GetPopulation() then
		pCity:SetPopulation(1)
	else
		pCity:ChangePopulation(-1 * iTotalPopLoss)
	end
	pCity:SetFood(0)
	local iSpecialID = GetCitySpecialID(pPlot:GetX(), pPlot:GetY())
	SRTT.JoyrideCooldown[iSpecialID] = MapModData.gSRTTJoyrideCooldownTurns
	pUnit:ChangeMoves(-1 * GameDefines.MOVE_DENOMINATOR)
	Events.SerialEventUnitInfoDirty()
end

LuaEvents.SRTTDoJoyride.Add(DoJoyride)

function DoNitrous(pUnit)
	pUnit:SetHasPromotion(iNitrousBoost, true)
	pUnit:SetMoves(pUnit:MaxMoves())
	Events.SerialEventUnitInfoDirty()
end

LuaEvents.SRTTDoNitrous.Add(DoNitrous)



----------------------------------------------------------------------------------------------------------------------------------------------------
--DLL Various Mod Components-based Custom Mission Compatibility. When DVMC is loaded, the separate mission Lua files will not run.
----------------------------------------------------------------------------------------------------------------------------------------------------

local iNitrousMission = GameInfoTypes.MISSION_SRTT_NITROUS
local iJoyrideMission = GameInfoTypes.MISSION_SRTT_JOYRIDE
local iRimJobsMission = GameInfoTypes.MISSION_SRTT_RIM_JOBS
local iNitrous = GameInfoTypes.PROMOTION_SRTT_RJ_NITROUS
local iBuilding = GameInfoTypes.BUILDING_SRTT_RIM_JOBS
local iArmor = GameInfoTypes.UNITCOMBAT_ARMOR


function SaintsCustomMissionPossible(iPlayer, iUnit, iMission, iData1, iData2, _, _, iPlotX, iPlotY, bTestVisible)
	if iPlayer < iMaxCivs and tWhoAreTheSaints[iPlayer] then
		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iUnit)
		--lazy and specifying one promotion for now
		if iMission == iNitrousMission then
			if pUnit:IsHasPromotion(iNitrous) and not pUnit:IsHasPromotion(iNitrousBoost) then
				local iSpecialID = GetUnitSpecialID(iPlayer, iUnit)
				if not SRTT.NitrousCooldown[iSpecialID] then
					return true
				else
					return bTestVisible
				end
			end
		elseif iMission == iJoyrideMission then
			if pUnit:IsCombatUnit() then
				local pCity = pUnit:GetPlot():GetPlotCity()
				if pCity then
					if pCity:GetPopulation() > 1 then
						local iX = pCity:GetX()
						local iY = pCity:GetY()
						local iSpecialID = GetCitySpecialID(iX, iY)
						if not SRTT.JoyrideCooldown[iSpecialID] then
							return true
						else
							return bTestVisible
						end
					else
						return bTestVisible
					end
				else
					return bTestVisible
				end
			end
		elseif iMission == iRimJobsMission then
			if pUnit:GetUnitCombatType() == iArmor then
				local pCity = pUnit:GetPlot():GetPlotCity()
				if pCity then
					if pCity:IsHasBuilding(iBuilding) then
						return true
					end
				end
			end
		end
	end
	return false
end

function SaintsCustomMissionStart(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnit)
	if iMission == iNitrousMission then
		DoNitrous(pUnit)
	elseif iMission == iJoyrideMission then
		DoJoyride(pUnit)
	elseif iMission == iRimJobsMission then
		LuaEvents.SRTTOpenRimJobsPopup()
	end
	return 0
end

function SaintsCustomMissionCompleted(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	if iMission == iNitrousMission or iMission == iJoyrideMission or iMission == iRimJobsMission then
		return true
	end
end


if GameInfo.CustomModOptions then
	print("DLL Various Mod Components loaded, add GameEvent calls for the DLL-based Custom Mission Handlers.")
	GameEvents.CustomMissionPossible.Add(SaintsCustomMissionPossible)
	GameEvents.CustomMissionStart.Add(SaintsCustomMissionStart)
	GameEvents.CustomMissionCompleted.Add(SaintsCustomMissionCompleted)
end