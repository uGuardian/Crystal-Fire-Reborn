----------------------------------------------------------------------------------------------------------------------------

-- PMMMGeneralFunctions
-- Author: Vicevirtuoso
-- DateCreated: 6/16/2014 4:11:32 PM
----------------------------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------------------------
--This is known as "GeneralFunctions" since these should ONLY be called from other functions. None of these should ever
--be directly added to a GameEvent hook! (LuaEvents are okay though)
----------------------------------------------------------------------------------------------------------------------------

iMaxCivs = GameDefines.MAX_MAJOR_CIVS

include("VV_PlotIt.lua")



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


--Credit to UltimatePotato from Civfanatics for this trick!
function toBits(num)
    -- returns a table of bits, least significant first.
	t={} -- will contain the bits
    while num>0 do
        local rest=math.fmod(num,2)
        t[#t+1]=rest
        num=(num-rest)/2
    end
    return t
end

--This function returns a value of the format "xx:yyyyyyy", where "xx" is the PlayerID of a unit owner and "yyyyyyy" is the UnitID of the unit.
--Needed for table keys. Using a pUnit as a table key causes cross-table updates to fail!
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

function ReturnPlotFromSpecialID(ID)
	local temptable = split(ID, ":");	
	local iX = tonumber(temptable[1]);
	local iY = tonumber(temptable[2]);
	local pPlot = Map.GetPlot(iX, iY)
	if pPlot then
		return pPlot
	else
		return nil
	end
end

function ReturnPlayerAndUnitIDsFromSpecialID(ID)
	local temptable = split(ID, ":");	
	local iPlayer = tonumber(temptable[1]);
	local iUnit = tonumber(temptable[2]);
	return iPlayer, iUnit
end


--Taken from Events & Decisions
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

--v21: Find the nearest friendly City

function FindNearestFriendlyCity(pPlayer, pPlot)
	if pPlot:IsCity() and pPlot:GetOwner() == pPlayer:GetID() then
		return pPlot:GetPlotCity()
	else
		local iNearestDistance = 10000
		local pNearestCity;
		local iX = pPlot:GetX()
		local iY = pPlot:GetY()
		for pCity in pPlayer:Cities() do
			local iThisDistance = Map.PlotDistance(iX, iY, pCity:GetX(), pCity:GetY())
			if iThisDistance < iNearestDistance then
				iNearestDistance = iThisDistance
				pNearestCity = pCity
			end
		end
		return pNearestCity
	end
end


--Given a Unit ID and Owner ID, get the Key in the MagicalGirls table which corresponds.
function GetMagicalGirlKey(iOwner, iUnit)
	for k, v in pairs(MagicalGirls) do
		if v.UnitID == iUnit and v.Owner == iOwner then
			return k
		end
	end
	return false
end

--Set the Soul Gem State for a MG, corresponding to its given Soul Gem value. Also provide it with the proper Promotion.
function SetSoulGemState(iMGKey)
	for k, v in pairs(MapModData.gPMMMSoulGemStates) do
		if v.MinPercent <= MagicalGirls[iMGKey].SoulGem and v.MaxPercent >= MagicalGirls[iMGKey].SoulGem then
			MagicalGirls[iMGKey].SoulGemState = k
			local pPlayer, pUnit = RetrieveMGPointers(iMGKey)
			pUnit:SetHasPromotion(v.Promotion, true)
			for k2, v2 in pairs(MapModData.gPMMMSoulGemStates) do
				if k2 ~= k then
					pUnit:SetHasPromotion(v2.Promotion, false)
				end
			end
			return
		end
	end
	print("Error: Soul Gem State for current Soul Gem percentage not found!")
end

--Add Corruption to a MG's gem, taking into account Polishing.
function DoChangeCorruption(iCorruption, iMGKey)
	--Do we have Polish?
	local bIsPolish
	if MagicalGirls[iMGKey].Polish then
		if MagicalGirls[iMGKey].Polish > 0 then
			bIsPolish = true
		end
	end
	if bIsPolish and iCorruption > 0 then
		local iSoulGemCorruption = 0
		local iPolishCorruption = 0
		--In the case of an odd number, the amount hit to the Soul Gem is 1 higher than the amount hit to the Polish.
		--This means the default 1% corruption per turn is not affected!
		if (iCorruption % 2) > 0 then
			iSoulGemCorruption = math.floor(iCorruption / 2) + 1
			iPolishCorruption = math.floor(iCorruption / 2)
		else
			iSoulGemCorruption = iCorruption / 2
			iPolishCorruption = iCorruption / 2
		end
		--If the corruption to the Polish is higher than the total Polish, then the remainder is dealt to the Soul Gem proper
		if iPolishCorruption > MagicalGirls[iMGKey].Polish then
			iPolishCorruption = iPolishCorruption - MagicalGirls[iMGKey].Polish
			iSoulGemCorruption = iSoulGemCorruption + iPolishCorruption
			MagicalGirls[iMGKey].Polish = 0
		else
			MagicalGirls[iMGKey].Polish = MagicalGirls[iMGKey].Polish - iPolishCorruption
		end
		MagicalGirls[iMGKey].SoulGem = MagicalGirls[iMGKey].SoulGem - iSoulGemCorruption
		local pPlayer, pMagicalGirl = RetrieveMGPointers(iMGKey)
		if pPlayer:GetID() == Game:GetActivePlayer() then
			Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(pMagicalGirl:GetX(), pMagicalGirl:GetY()))), Locale.ConvertTextKey("TXT_KEY_PMMM_TILEPOPUP_SOUL_GEM_MINUS", iSoulGemCorruption), 1)
		end
	else
		MagicalGirls[iMGKey].SoulGem = MagicalGirls[iMGKey].SoulGem - iCorruption
		--Clamp
		if MagicalGirls[iMGKey].SoulGem < 0 then
			MagicalGirls[iMGKey].SoulGem = 0
		elseif MagicalGirls[iMGKey].SoulGem > GameDefines.MAXIMUM_SOUL_GEM_AMOUNT then
			MagicalGirls[iMGKey].SoulGem = GameDefines.MAXIMUM_SOUL_GEM_AMOUNT
		end
		--Mood Nerf, Leader MGs can't corrupt
		if MagicalGirls[iKey].IsLeader then
			MagicalGirls[iMGKey].SoulGem = GameDefines.MAXIMUM_SOUL_GEM_AMOUNT
		end
		SetSoulGemState(iMGKey)
		local pPlayer, pMagicalGirl = RetrieveMGPointers(iMGKey)
		if pPlayer:GetID() == Game:GetActivePlayer() then
			local sString;
			if iCorruption > 0 then
				sString = Locale.ConvertTextKey("TXT_KEY_PMMM_TILEPOPUP_SOUL_GEM_MINUS", iCorruption)
			else
				sString = Locale.ConvertTextKey("TXT_KEY_PMMM_TILEPOPUP_SOUL_GEM_PLUS", -iCorruption)
			end
			Events.AddPopupTextEvent(HexToWorld(ToHexFromGrid(Vector2(pMagicalGirl:GetX(), pMagicalGirl:GetY()))), sString, 1)
		end
	end
end

--Get a pPlayer and a pUnit from a key in the MG table.
--This returns two values, so always call it as "pPlayer, pUnit = RetrieveMGPointers(iMGKey)"
--Using "(RetrieveMGPointers(iMGKey))" will return just a pPlayer
function RetrieveMGPointers(iMGKey)
	local pPlayer = Players[MagicalGirls[iMGKey].Owner]
	local pUnit = pPlayer:GetUnitByID(MagicalGirls[iMGKey].UnitID)
	if pUnit then
		return pPlayer, pUnit
	else
		return pPlayer
	end
end


--Get the best possible spot to plop a new Hostile unit. Copied from Recluse's Lua.
function FindBestEnemySpawnPlot(pOriginalPlot)
	local pSpawnPlot;
	--We'll keep a table of how acceptable a plot is to spawn on if it doesn't have perfect conditions (no cities or units).
	--Values used:
	--2: Contains only military units, pretty acceptable since it will just displace the units.
	--1: Contains civilian units, only acceptable as a last resort since it will kill the civilian unit.
	--0: Contains a city. NEVER spawn it in a city!
	local tPlotValidity = {}
	--Let's see if the plot it's already on is okay first.
	if not pOriginalPlot:IsCity() then
		local bThisPlotValid = true;
		--Iterate over units in this plot, if there are any units other than the GP itself then this shouldn't be considered valid for this first check
		for i = 0, pOriginalPlot:GetNumUnits() - 1 do
			local pPlotUnit = pOriginalPlot:GetUnit(i)
			if pPlotUnit ~= pUnit then
				bThisPlotValid = false
				if not pPlotUnit:IsCombatUnit() then
					tPlotValidity[pOriginalPlot] = 1
				end
			end
		end
		if bThisPlotValid == true then
			pSpawnPlot = pOriginalPlot
		elseif tPlotValidity[pOriginalPlot] == nil then
			tPlotValidity[pOriginalPlot] = 2
		end
	else
		tPlotValidity[pOriginalPlot] = 0
	end

	--If that didn't work, then let's try each adjacent plot.
	if not pSpawnPlot then
		local direction_types = {
			DirectionTypes.DIRECTION_NORTHEAST,
			DirectionTypes.DIRECTION_EAST,
			DirectionTypes.DIRECTION_SOUTHEAST,
			DirectionTypes.DIRECTION_SOUTHWEST,
			DirectionTypes.DIRECTION_WEST,
			DirectionTypes.DIRECTION_NORTHWEST
		}
		for a, direction in ipairs(direction_types) do
			local pNextPlot = Map.PlotDirection(pOriginalPlot:GetX(), pOriginalPlot:GetY(), direction)
			if pNextPlot ~= nil then
				if not pNextPlot:IsCity() then
					if pNextPlot:IsUnit() then
						for i = 0, pNextPlot:GetNumUnits() - 1 do
							local pPlotUnit = pNextPlot:GetUnit(i)
							if not pPlotUnit:IsCombatUnit() then
								tPlotValidity[pNextPlot] = 1
							end
						end
						if tPlotValidity[pNextPlot] == nil then
							tPlotValidity[pNextPlot] = 2
						end
					else
						pSpawnPlot = pNextPlot
						break
					end
				else
					tPlotValidity[pNextPlot] = 0
				end
			end
		end
	end

	--If THAT didn't work, then we'll refer to the table we've created.
	if not pSpawnPlot then
		local tBestPlots = {}
		for pPlot, iValidity in pairs(tPlotValidity) do
			if iValidity == 2 then
				table.insert(tBestPlots, pPlot)
			end
		end
		if #tBestPlots < 1 then
			for pPlot, iValidity in pairs(tPlotValidity) do
				if iValidity == 1 then
					table.insert(tBestPlots, pPlot)
				end
			end	
		end
		--Choose one of the best plots at random!
		if #tBestPlots > 0 then
			pSpawnPlot = tBestPlots[Game.Rand(#tBestPlots, "Witch Plot Randomizer") + 1]
		end
	end

	--If even THAT didn't work...that basically means that there is a city in both the GP's tile and in every tile around it!
	--If something that crazy happened, then whatever -- spawn it in the same plot!
	if not pSpawnPlot then
		pSpawnPlot = pOriginalPlot
	end

	return pSpawnPlot
end


function DoConsumeGriefSeed(iMGKey, iPlayer)
	PMMM.GriefSeeds[iPlayer] = math.max(0, PMMM.GriefSeeds[iPlayer] - 1)
	DoChangeCorruption(-MapModData.gPMMMGriefSeedRecoverAmount, iMGKey)
	local pPlayer, pUnit = RetrieveMGPointers(iMGKey)
	pPlayer:AddMessage(Locale.ConvertTextKey("TXT_KEY_PMMM_ALERT_USED_GRIEF_SEED", MagicalGirls[iMGKey].Name, MapModData.gPMMMGriefSeedRecoverAmount))
end


--Ultimate Madoka Law of Cycles
function DoLawOfCyclesTakeaway(iMGKey, iNewPlayer)
	local pPlayer, pUnit = RetrieveMGPointers(iMGKey)
	local iX = pUnit:GetX()
	local iY = pUnit:GetY()
	local iMG = GameInfoTypes.UNIT_PMMM_MAGICAL_GIRL
	MagicalGirls[iMGKey].Status = GameInfoTypes.MGACTIONSTATE_CYCLING
	MagicalGirls[iMGKey].CycleStartTurn = Game:GetGameTurn()
	if MagicalGirls[iMGKey].SummonedWitch then
		local _, iUnit = ReturnPlayerAndUnitIDsFromSpecialID(MagicalGirls[iMGKey].SummonedWitch)
		local pWitchUnit = Players[_]:GetUnitByID(iUnit)
		pWitchUnit:Kill(true)
		MagicalGirls[iMGKey].SummonedWitch = nil
	end
	MagicalGirls[iMGKey].SummonedWitchCooldown = nil
	MagicalGirls[iMGKey].Promotions = {}
	local sText;
	local sTitle;
	local iNotiType;
	if iNewPlayer then
		local iOldPlayer = MagicalGirls[iMGKey].Owner
		MagicalGirls[iMGKey].Owner = iNewPlayer
		sText = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_TOOK_ENEMY_MG_LOC_TEXT", MagicalGirls[iMGKey].Name, MapModData.gPMMMLawOfCyclesTurns)
		sTitle = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_TOOK_ENEMY_MG_LOC_TITLE")
		iNotiType = NotificationTypes.NOTIFICATION_GENERIC

		local sTheirText = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_MG_LED_AWAY_BY_ENEMY_LOC_TEXT", MagicalGirls[iMGKey].Name)
		local sTheirTitle = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_MG_LED_AWAY_BY_ENEMY_LOC_TITLE")
		pPlayer:AddNotification(NotificationTypes.NOTIFICATION_UNIT_DIED, sTheirText, sTheirTitle, iX, iY, iMG)
		Players[iNewPlayer]:AddNotification(iNotiType, sText, sTitle, iX, iY, iMG)
	else
		sText = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_TAKEN_BY_LOC_TEXT", MagicalGirls[iMGKey].Name, MapModData.gPMMMLawOfCyclesTurns)
		sTitle = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_TAKEN_BY_LOC_TITLE")
		iNotiType = NotificationTypes.NOTIFICATION_UNIT_DIED
		pPlayer:AddNotification(iNotiType, sText, sTitle, iX, iY, iMG)
	end
	pUnit:Kill()

end


function ReturnFromLawOfCycles(iMGKey)
	local pPlayer = (RetrieveMGPointers(iMGKey))
	local pCapital = pPlayer:GetCapitalCity()
	local iX = pCapital:GetX()
	local iY = pCapital:GetY()
	local iMG = GameInfoTypes.UNIT_PMMM_MAGICAL_GIRL
	tMagicalGirlSpawnTable["ID"] = iMGKey
	local eMagicalGirl = pPlayer:InitUnit(iMG, iX, iY, UNITAI_ATTACK)
	eMagicalGirl:SetName(MagicalGirls[iMGKey].Name)
	SetMagicalGirlStrength(pPlayer:GetID(), eMagicalGirl:GetID())
	MagicalGirls[iMGKey].UnitID = eMagicalGirl:GetID()
	MagicalGirls[iMGKey].SoulGem = 100
	MagicalGirls[iMGKey].Level = 1
	MagicalGirls[iMGKey].XP = 0
	MagicalGirls[iMGKey].HP = 100
	MagicalGirls[iMGKey].Loyalty = 100
	MagicalGirls[iMGKey].Status = GameInfoTypes.MGACTIONSTATE_ACTIVE
	SetSoulGemState(iMGKey)
	sText = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_LAW_OF_CYCLES_REBORN_TEXT", MagicalGirls[iMGKey].Name)
	sTitle = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_LAW_OF_CYCLES_REBORN_TITLE")
	pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GREAT_PERSON_ACTIVE_PLAYER, sText, sTitle, iX, iY, iMG)
end



--Use Grief Seed button clicked (enabled as a LuaEvent)
--As of v21, it is still in the LuaEvents, but it will be called from a CustomMissionStart for multiplayer compatibility.
function UseGriefSeed(iUnit, iPlayer, bKey)
	--bKey means that iUnit is a MGKey rather than a Unit ID, used for the Freezer button since those units aren't on the map
	local pPlayer = Players[iPlayer]
	local pUnit;
	local iMGKey
	if not bKey then
		pUnit = pPlayer:GetUnitByID(iUnit)
		iMGKey = GetMagicalGirlKey(iPlayer, iUnit)
	else
		iMGKey = iUnit
	end
	local ttable = {}
	if iMGKey and PMMM.GriefSeeds[iPlayer] and PMMM.GriefSeeds[iPlayer] > 0 then
		DoConsumeGriefSeed(iMGKey, iPlayer)
		SetSoulGemState(iMGKey)
		LuaEvents.PMMMRefreshGriefSeedDisplay()
		if pUnit then
			pUnit:ChangeMoves(-1 * GameDefines.MOVE_DENOMINATOR)
		end
	else
		return
	end
end


--Check if unit has time stop promos.
--This was in Homura's trait script, but since EnemyUnitPanel and such use it, it needs to always be available.
tTimeStopPromotions = {}

for promotion in GameInfo.UnitPromotions() do
	if string.find(promotion.Type, 'PROMOTION_PMMM_TIME_STOP_') then
		tTimeStopPromotions[-promotion.MovesChange] = promotion.ID
	end
end

function HasAnyTimeStopPromo(pUnit)
	for k, v in pairs(tTimeStopPromotions) do
		if pUnit:IsHasPromotion(v) then
			return true
		end
	end
	return false
end


function DeckShuffle(tTable, sString)
	local tDeck = {}
	for k, v in pairs(tTable) do
		if v > -1 then
			for i = 0, v, 1 do
				tDeck[#tDeck + 1] = k
			end
		end
	end
	
	if not sString then sString = "PMMM Generic Deck Shuffle" end
	
	return tDeck[Game.Rand(#tDeck, sString) + 1]
end


function GetLeaderMagicalGirl(iPlayer)
	for k, v in pairs(MapModData.PMMM.MagicalGirls) do
		if v.Owner == iPlayer and v.IsLeader == true and v.Status == GameInfoTypes.MGACTIONSTATE_ACTIVE then
			local pPlayer = Players[iPlayer]
			local pUnit = pPlayer:GetUnitByID(v.UnitID)
			if pUnit then return pUnit end
		end
	end
	return false
end


function SetMagicalGirlStrength(iPlayer, iUnit)
	local iEra;
	local pPlayer = Players[iPlayer]
	local pUnit;
	if iUnit then
		pUnit = pPlayer:GetUnitByID(iUnit)
	end
	if MapModData.gPMMMTraits[iPlayer] and (MapModData.gPMMMTraits[iPlayer].MaximumMetEraMGStrength == 1 or MapModData.gPMMMTraits[iPlayer].MaximumMetEraMGStrength == true) then
		local iHighestEra = pPlayer:GetCurrentEra();
		local pTeam = Teams[pPlayer:GetTeam()]
		for i = 0, GameDefines.MAX_MAJOR_CIVS -1, 1 do
			local pLoop = Players[i]
			if pLoop:IsAlive() and pTeam:IsHasMet(pLoop:GetTeam()) then
				local iTheirEra = pLoop:GetCurrentEra()
				if iTheirEra and iTheirEra > iHighestEra then
					iHighestEra = iTheirEra
				end
			end
		end
		iEra = iHighestEra
	else
		iEra = pPlayer:GetCurrentEra()
	end

	--Set the strength (but check for pUnit to exist; this function should work without passing a unit ID so we can just get a number.)
	if pUnit then
		pUnit:SetBaseCombatStrength(MapModData.gPMMMMagicalGirlEraStrengths[iEra])
	end

	--Also return the value.
	return MapModData.gPMMMMagicalGirlEraStrengths[iEra]
end