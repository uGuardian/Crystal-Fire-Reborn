-- HDNSharesMood
-- Author: Vice
-- DateCreated: 3/23/2015 6:29:06 PM
--------------------------------------------------------------


local iVert = GameInfoTypes.LEADER_VV_VERT or -1
local iGreenHeart = GameInfoTypes.LEADER_VV_GREEN_HEART or -1
local iBlanc = GameInfoTypes.LEADER_VV_BLANC or -1
local iWhiteHeart = GameInfoTypes.LEADER_VV_WHITE_HEART or -1
local iNepgear = GameInfoTypes.LEADER_VV_NEPGEAR or -1
local iPurpleSister = GameInfoTypes.LEADER_VV_PURPLE_SISTER or -1
local iUni = GameInfoTypes.LEADER_VV_UNI or -1
local iBlackSister = GameInfoTypes.LEADER_VV_BLACK_SISTER or -1


local tHDDModeLeaders = {
	[iGreenHeart] = true,
	[iWhiteHeart] = true,
	[iPurpleSister] = true,
	[iBlackSister] = true,
}

function IsPlayerHDDMode(pPlayer)
	local iLeaderType = pPlayer:GetLeaderType();
	return tHDDModeLeaders[iLeaderType] and tHDDModeLeaders[iLeaderType] or false;
end

local PRODUCTION_SPEED_MOD = GameInfo.GameSpeeds[PreGame.GetGameSpeed()].ConstructPercent / 100




local row = GameInfo.MG_MoodModifiers["MGMOODMOD_HDN_SHARES"]
local iSharesID = row.ID
t_MoodMods[iSharesID] = {}
t_MoodMods[iSharesID].Value = row.Value
t_MoodMods[iSharesID].Func = (
	function(iMGKey, pPlayer, pUnit)
		local iVal = 0;
		if MagicalGirls[iMGKey].IsLeader == true and IsPlayerHDDMode(pPlayer) == true then	
			local iPlayer = pPlayer:GetID()
			if MapModData.HDNMod.Shares[iPlayer] then
				local iSharesPercent = math.floor(MapModData.HDNMod.Shares[iPlayer] / (50 * PRODUCTION_SPEED_MOD))
				iVal = iSharesPercent
			end
		end

		return iVal
	end
)

t_MoodMods[iSharesID].Desc = row.Description
t_MoodMods[iSharesID].PosTT = row.PositiveTooltip
t_MoodMods[iSharesID].Max = row.MaxValue



local iMagicalGirl = GameInfoTypes.UNIT_PMMM_MAGICAL_GIRL
local iMagicalGirlClass = GameInfoTypes.UNITCLASS_PMMM_MAGICAL_GIRL
----------------------------ASSAM LINK------------------------------------------------------------------------------------
local iAssamLink = MissionTypes.MISSION_PMMM_HDN_ASSAM_LINK
local iAssamLinkCorruption;
local iAssamLinkPromotion;
if iAssamLink then
	iAssamLinkCorruption = GameInfo.Missions[iAssamLink].PMMMSoulGemCorruptionBase or 0
	iAssamLinkPromotion = GameInfoTypes.PROMOTION_HDN_ASSAM_LINK or 0
end

function AssamLinkCustomMissionPossible(iPlayer, iUnit, iMission, iData1, iData2, _, _, iPlotX, iPlotY, bTestVisible)
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnit)
	if pUnit:GetUnitClassType() == iMagicalGirlClass then
		local iMGKey = GetMagicalGirlKey(iPlayer, iUnit)
		if MagicalGirls[iMGKey].ExtraMission and iMission == MagicalGirls[iMGKey].ExtraMission and iMission == iAssamLink then
			if not pUnit:IsHasPromotion(iAssamLinkPromotion) then
				local iModifiedCorruption = math.floor(iAssamLinkCorruption * (1 + (GameInfo.MG_Moods[MagicalGirls[iMGKey].MoodLevel].SoulGemAbilityCostMod / 100)))
				if MagicalGirls[iMGKey].SoulGem >= iModifiedCorruption then
					return true
				else
					return bTestVisible
				end
			else
				return bTestVisible
			end
		end
	end
	return false
end


function AssamLinkCustomMissionStart(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	if iMission == iAssamLink then
		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iUnit)
		local iMGKey = GetMagicalGirlKey(iPlayer, iUnit)

		if iMGKey then
			for pAreaPlot in PlotAreaSpiralIterator(pUnit:GetPlot(), 1, false, false, false, true) do
				for c = 0, pAreaPlot:GetNumUnits() - 1 do
					local pPlotUnit = pAreaPlot:GetUnit(c)
					if pPlotUnit then
						if pPlotUnit:GetOwner() == iPlayer and pPlotUnit:IsCombatUnit() then
							pPlotUnit:SetHasPromotion(iAssamLinkPromotion, true)
							pPlotUnit:ChangeMoves(2 * GameDefines.MOVE_DENOMINATOR)
						end
					end
				end
			end



			local iModifiedCorruption = math.floor(iAssamLinkCorruption * (1 + (GameInfo.MG_Moods[MagicalGirls[iMGKey].MoodLevel].SoulGemAbilityCostMod / 100)))
			DoChangeCorruption(iModifiedCorruption, iMGKey)
		end
	end
	return 0
end

function AssamLinkCustomMissionCompleted(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	if iMission == iAssamLink then
		return true
	end
	return false
end


----------------------------GETTER RAVINE------------------------------------------------------------------------------------
local iGetterRavine = MissionTypes.MISSION_PMMM_HDN_GETTER_RAVINE
local iGetterRavineCorruption;
if iGetterRavine then
	iGetterRavineCorruption = GameInfo.Missions[iGetterRavine].PMMMSoulGemCorruptionBase or 0
end
local iGetterRavineDamageMultiplier = 1.5

function GetterRavineCustomMissionPossible(iPlayer, iUnit, iMission, iData1, iData2, _, _, iPlotX, iPlotY, bTestVisible)
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnit)
	if pUnit:GetUnitClassType() == iMagicalGirlClass then
		local iMGKey = GetMagicalGirlKey(iPlayer, iUnit)
		if MagicalGirls[iMGKey].ExtraMission and iMission == MagicalGirls[iMGKey].ExtraMission and iMission == iGetterRavine then
			local iModifiedCorruption = math.floor(iGetterRavineCorruption * (1 + (GameInfo.MG_Moods[MagicalGirls[iMGKey].MoodLevel].SoulGemAbilityCostMod / 100)))
			if MagicalGirls[iMGKey].SoulGem >= iModifiedCorruption and pUnit:GetMoves() >= 2 * GameDefines.MOVE_DENOMINATOR then
				return true
			else
				return bTestVisible
			end
		end
	end
	return false
end


function GetterRavineCustomMissionStart(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	if iMission == iGetterRavine then
		DoGetterRavine(iPlayer, Players[iPlayer]:GetUnitByID(iUnit), Map.GetPlot(-iData1, -iData2))
	end
	return 0
end

function GetterRavineCustomMissionCompleted(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	if iMission == iGetterRavine then
		return true
	end
	return false
end


function DoGetterRavine(iPlayer, pHeadUnit, pPlot)
	print("Getter Ravine called")
	local pPlayer = Players[iPlayer]
	local pTeam = Teams[pPlayer:GetTeam()]
	local iNumUnits = pPlot:GetNumUnits();
	local pThisPlot = pHeadUnit:GetPlot()
	local bDamagedCombatUnit = false
	-- Loop through Units to find the first Combat unit. If no Combat unit is found, loop again and do the damage to the first non-combat unit.
	for i = 0, iNumUnits do
		pUnit = pPlot:GetUnit(i);
		if (pUnit ~= nil and not pUnit:IsInvisible(iTeam, false)) then
			 if (pUnit:GetBaseCombatStrength() > 0 or pHeadUnit:IsRanged()) then
				if (pTeam:IsAtWar(pUnit:GetTeam()) or (UIManager:GetAlt() and pUnit:GetOwner() ~= iTeam)) then
					print("Found valid target")
					iStrength = math.floor(pHeadUnit:GetMaxAttackStrength(pThisPlot, pPlot, pUnit) * iGetterRavineDamageMultiplier)
					print("iStrength: " ..iStrength)
					InflictGetterRavineDamage(pHeadUnit, pUnit, pPlot, iStrength)
					--Destroy an Improvement
					if not pPlot:IsCity() and pPlot:GetImprovementType() > -1 and not pPlot:IsImprovementPillaged() then
						pPlot:SetImprovementPillaged(true)
						pUnit:ChangeDamage(-10)
						if pHeadUnit:GetOwner() == Game:GetActivePlayer() then
							Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_ALERT_HDN_GETTER_RAVINE_IMPROVEMENT_DAMAGE_INFLICTED", pHeadUnit:GetNameNoDesc(), 10))
						elseif pUnit:GetOwner() == Game:GetActivePlayer() then
							Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_ALERT_HDN_GETTER_RAVINE_IMPROVEMENT_DAMAGE_RECEIVED", pUnit:GetNameNoDesc(), 10))
						end
					end
					bDamagedCombatUnit = true
					break
				end
			end
		end
	end
	if not bDamagedCombatUnit then
		for i = 0, iNumUnits do
			pUnit = pPlot:GetUnit(i);
			if (pUnit ~= nil and not pUnit:IsInvisible(iTeam, false)) then
				if (pTeam:IsAtWar(pUnit:GetTeam()) or (UIManager:GetAlt() and pUnit:GetOwner() ~= iTeam)) then
				print("Found valid target")
					iStrength = math.floor(pHeadUnit:GetMaxAttackStrength(pThisPlot, pPlot, pUnit) * 1.5)
					print("iStrength: " ..iStrength)
					InflictGetterRavineDamage(pHeadUnit, pUnit, pPlot, iStrength)
					--Destroy an Improvement
					if not pPlot:IsCity() and pPlot:GetImprovementType() > -1 and not pPlot:IsImprovementPillaged() then
						pPlot:SetImprovementPillaged(true)
						pUnit:ChangeDamage(-10)
						if pHeadUnit:GetOwner() == Game:GetActivePlayer() then
							Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_ALERT_HDN_GETTER_RAVINE_IMPROVEMENT_DAMAGE_INFLICTED", pHeadUnit:GetNameNoDesc(), 10))
						elseif pUnit:GetOwner() == Game:GetActivePlayer() then
							Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_ALERT_HDN_GETTER_RAVINE_IMPROVEMENT_DAMAGE_RECEIVED", pUnit:GetNameNoDesc(), 10))
						end
					end
					break
				end
			end
		end
	end

	local iMGKey = GetMagicalGirlKey(iPlayer, pHeadUnit:GetID())
	local iModifiedCorruption = math.floor(iGetterRavineCorruption * (1 + (GameInfo.MG_Moods[MagicalGirls[iMGKey].MoodLevel].SoulGemAbilityCostMod / 100)))
	DoChangeCorruption(iModifiedCorruption, iMGKey)
	pHeadUnit:ChangeExperience(3)
	pHeadUnit:ChangeMoves(-2 * GameDefines.MOVE_DENOMINATOR)
	CleanMissionInfo()
	ClearAllHighlights()
end


function InflictGetterRavineDamage(pHeadUnit, pUnit, pPlot, iMyStrength)
	print("Getter Ravine damage called")
	local iTheirStrength = 0;
	if (pUnit:IsEmbarked()) then
		iTheirStrength = pUnit:GetEmbarkedUnitDefense();
		print("iTheirStrength: " ..iTheirStrength)
	else
		iTheirStrength = pUnit:GetMaxDefenseStrength(pPlot, pHeadUnit);
		print("iTheirStrength: " ..iTheirStrength)
	end
	
	local iDamage = pHeadUnit:GetCombatDamage(iMyStrength, iTheirStrength, pHeadUnit:GetDamage(), true, false, false)
	print("iDamage: " ..iDamage)
	if iDamage > 100 then
		iDamage = 100
	end
	pUnit:ChangeDamage(iDamage, pHeadUnit:GetOwner())

	if pHeadUnit:GetOwner() == Game:GetActivePlayer() then
		Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_ALERT_HDN_GETTER_RAVINE_DAMAGE_INFLICTED", pHeadUnit:GetNameNoDesc(), pUnit:GetNameNoDesc(), iDamage))
	elseif pUnit:GetOwner() == Game:GetActivePlayer() then
		Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_ALERT_HDN_GETTER_RAVINE_DAMAGE_RECEIVED", pUnit:GetNameNoDesc(), pHeadUnit:GetNameNoDesc(), iDamage))
	end
end

----------------------------NEPGEARDAM, GO!------------------------------------------------------------------------------------
local iNepgeardamGo = MissionTypes.MISSION_PMMM_HDN_NEPGEARDAM_GO
local iNepgeardamGoCorruption;
if iNepgeardamGo then
	iNepgeardamGoCorruption = GameInfo.Missions[iNepgeardamGo].PMMMSoulGemCorruptionBase or 0
end

local iNumTurnsNepgeardamLasts = 3
local tNepgeardamStrengths = {}

for era in GameInfo.Eras() do
	local iHighestStrength = 8
	for unit in GameInfo.Units() do
		if unit.PrereqTech and unit.PrereqTech ~= 'NONE' and unit.PrereqTech ~= 'NULL' then
			if GameInfo.Technologies("Type ='" ..unit.PrereqTech.. "'")() ~= 'NONE' and GameInfo.Technologies("Type ='" ..unit.PrereqTech.. "'")() ~= 'NULL' then --i don't know why 'NONE' is a valid PrereqTech, but it's there and causes problems
				if GameInfo.Technologies("Type ='" ..unit.PrereqTech.. "'")().Era then
					if GameInfo.Technologies("Type ='" ..unit.PrereqTech.. "'")().Era == era.Type then
						if unit.CombatClass == 'UNITCOMBAT_MOUNTED' or unit.CombatClass == 'UNITCOMBAT_ARMOR' then
							if unit.Combat > iHighestStrength then
								local bIsUnique;
								for uniqueunit in GameInfo.Civilization_UnitClassOverrides() do
									if uniqueunit.UnitType == unit.Type then
										bIsUnique = true
										break
									end
								end
								if not bIsUnique then
									iHighestStrength = unit.Combat
								end
							end
						end
					end
				end
			end
		end
	end
	tNepgeardamStrengths[era.ID] = math.floor(iHighestStrength * 0.85)
end

function NepgeardamGoCustomMissionPossible(iPlayer, iUnit, iMission, iData1, iData2, _, _, iPlotX, iPlotY, bTestVisible)
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnit)
	if pUnit:GetUnitClassType() == iMagicalGirlClass then
		local iMGKey = GetMagicalGirlKey(iPlayer, iUnit)
		if MagicalGirls[iMGKey].ExtraMission and iMission == MagicalGirls[iMGKey].ExtraMission and iMission == iNepgeardamGo then
			if not pUnit:IsHasPromotion(iNepgeardamGoPromotion) then
				local iModifiedCorruption = math.floor(iNepgeardamGoCorruption * (1 + (GameInfo.MG_Moods[MagicalGirls[iMGKey].MoodLevel].SoulGemAbilityCostMod / 100)))
				if MagicalGirls[iMGKey].SoulGem >= iModifiedCorruption then
					return true
				else
					return bTestVisible
				end
			else
				return bTestVisible
			end
		end
	end
	return false
end


function NepgeardamGoCustomMissionStart(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	if iMission == iNepgeardamGo then
		DoSummonNepgeardam(iPlayer, Players[iPlayer]:GetUnitByID(iUnit), Map.GetPlot(-iData1, -iData2))
		CleanMissionInfo()
		ClearAllHighlights()
	end
	return 0
end

function NepgeardamGoCustomMissionCompleted(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	if iMission == iNepgeardamGo then
		return true
	end
	return false
end

function DoSummonNepgeardam(iPlayer, pUnit, pPlot)
	local pPlayer = Players[iPlayer]
	local iMGKey = GetMagicalGirlKey(iPlayer, pUnit:GetID())
	local eNepgeardam = pPlayer:InitUnit(GameInfoTypes.UNIT_VV_GEARNAUGHT_SPECIAL, pPlot:GetX(), pPlot:GetY(), UNITAI_FAST_ATTACK)
	eNepgeardam:SetBaseCombatStrength(tNepgeardamStrengths[pPlayer:GetCurrentEra()])
	eNepgeardam:SetHasPromotion(GameInfoTypes.PROMOTION_PMMM_WITCH_NO_XP, true)
	pUnit:SetMoves(0)
	local iModifiedCorruption = math.floor(iNepgeardamGoCorruption * (1 + (GameInfo.MG_Moods[MagicalGirls[iMGKey].MoodLevel].SoulGemAbilityCostMod / 100)))
	DoChangeCorruption(iModifiedCorruption, iMGKey)
end


----------------------------BRAVE CANNON------------------------------------------------------------------------------------
local iBraveCannon = MissionTypes.MISSION_PMMM_HDN_BRAVE_CANNON
local iBraveCannonCorruption;
if iBraveCannon then
	iBraveCannonCorruption = GameInfo.Missions[iBraveCannon].PMMMSoulGemCorruptionBase or 0
end
local iBraveCannonDamageMultiplier = 0.5
local XMB_PROMO = GameInfoTypes.PROMOTION_VV_XMB_ARTILLERY
local iXMBMultiplier = 0.2

function BraveCannonCustomMissionPossible(iPlayer, iUnit, iMission, iData1, iData2, _, _, iPlotX, iPlotY, bTestVisible)
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnit)
	if pUnit:GetUnitClassType() == iMagicalGirlClass then
		local iMGKey = GetMagicalGirlKey(iPlayer, iUnit)
		if MagicalGirls[iMGKey].ExtraMission and iMission == MagicalGirls[iMGKey].ExtraMission and iMission == iBraveCannon then
			local iModifiedCorruption = math.floor(iBraveCannonCorruption * (1 + (GameInfo.MG_Moods[MagicalGirls[iMGKey].MoodLevel].SoulGemAbilityCostMod / 100)))
			if MagicalGirls[iMGKey].SoulGem >= iModifiedCorruption and pUnit:GetMoves() >= 2 * GameDefines.MOVE_DENOMINATOR then
				return true
			else
				return bTestVisible
			end
		end
	end
	return false
end


function BraveCannonCustomMissionStart(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	if iMission == iBraveCannon then
		DoBraveCannon(iPlayer, Players[iPlayer]:GetUnitByID(iUnit), Map.GetPlot(-iData1, -iData2))
	end
	return 0
end

function BraveCannonCustomMissionCompleted(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	if iMission == iBraveCannon then
		return true
	end
	return false
end


function DoBraveCannon(iPlayer, pHeadUnit, pPlot)
	print("Brave Cannon called")
	local pPlayer = Players[iPlayer]
	local pTeam = Teams[pPlayer:GetTeam()]
	local iNumUnits = pPlot:GetNumUnits();
	local pThisPlot = pHeadUnit:GetPlot()
	local bDamagedCombatUnit = false
	-- Loop through Units to find the first Combat unit. If no Combat unit is found, loop again and do the damage to the first non-combat unit.
	for i = 0, iNumUnits do
		pUnit = pPlot:GetUnit(i);
		if (pUnit ~= nil and not pUnit:IsInvisible(iTeam, false)) then
			 if (pUnit:GetBaseCombatStrength() > 0 or pHeadUnit:IsRanged()) then
				if (pTeam:IsAtWar(pUnit:GetTeam()) or (UIManager:GetAlt() and pUnit:GetOwner() ~= iTeam)) then
					print("Found valid target")
					--Determine strength from nearby XMB Artillery
					local iStrengthMultiplier = iBraveCannonDamageMultiplier
					for pAreaPlot in PlotAreaSpiralIterator(pHeadUnit:GetPlot(), 1, 1, false, false, true) do
						if pAreaPlot:IsUnit() then
							for c = 0, pAreaPlot:GetNumUnits() - 1 do
								local pPlotUnit = pAreaPlot:GetUnit(c)
								if pPlotUnit and pPlotUnit ~= pHeadUnit then
									if pPlotUnit:GetOwner() == pHeadUnit:GetOwner() and pPlotUnit:IsHasPromotion(GameInfoTypes.XMB_PROMO) then
										iStrengthMultiplier = iStrengthMultiplier + iXMBMultiplier
									end
								end
							end
						end
					end
					iStrength = math.floor(pHeadUnit:GetMaxAttackStrength(pThisPlot, pPlot, pUnit) * iBraveCannonDamageMultiplier)
					print("iStrength: " ..iStrength)
					InflictBraveCannonDamage(pHeadUnit, pUnit, pPlot, iStrength)
					bDamagedCombatUnit = true
					break
				end
			end
		end
	end
	if not bDamagedCombatUnit then
		for i = 0, iNumUnits do
			pUnit = pPlot:GetUnit(i);
			if (pUnit ~= nil and not pUnit:IsInvisible(iTeam, false)) then
				if (pTeam:IsAtWar(pUnit:GetTeam()) or (UIManager:GetAlt() and pUnit:GetOwner() ~= iTeam)) then
				print("Found valid target")
					iStrength = math.floor(pHeadUnit:GetMaxAttackStrength(pThisPlot, pPlot, pUnit) * 1.5)
					print("iStrength: " ..iStrength)
					InflictBraveCannonDamage(pHeadUnit, pUnit, pPlot, iStrength)
					break
				end
			end
		end
	end

	local iMGKey = GetMagicalGirlKey(iPlayer, pHeadUnit:GetID())
	local iModifiedCorruption = math.floor(iBraveCannonCorruption * (1 + (GameInfo.MG_Moods[MagicalGirls[iMGKey].MoodLevel].SoulGemAbilityCostMod / 100)))
	DoChangeCorruption(iModifiedCorruption, iMGKey)
	pHeadUnit:ChangeExperience(3)
	pHeadUnit:ChangeMoves(-2 * GameDefines.MOVE_DENOMINATOR)
	CleanMissionInfo()
	ClearAllHighlights()
end


function InflictBraveCannonDamage(pHeadUnit, pUnit, pPlot, iMyStrength)
	print("Brave Cannon damage called")
	local iTheirStrength = 0;
	if (pUnit:IsEmbarked()) then
		iTheirStrength = pUnit:GetEmbarkedUnitDefense();
		print("iTheirStrength: " ..iTheirStrength)
	else
		iTheirStrength = pUnit:GetMaxDefenseStrength(pPlot, pHeadUnit, true);
		print("iTheirStrength: " ..iTheirStrength)
	end
	
	local iDamage = pHeadUnit:GetCombatDamage(iMyStrength, iTheirStrength, pHeadUnit:GetDamage(), true, false, false)
	print("iDamage: " ..iDamage)
	if iDamage > 100 then
		iDamage = 100
	end
	pUnit:ChangeDamage(iDamage, pHeadUnit:GetOwner())

	if pHeadUnit:GetOwner() == Game:GetActivePlayer() then
		Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_ALERT_HDN_BRAVE_CANNON_DAMAGE_INFLICTED", pHeadUnit:GetNameNoDesc(), pUnit:GetNameNoDesc(), iDamage))
	elseif pUnit:GetOwner() == Game:GetActivePlayer() then
		Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_ALERT_HDN_BRAVE_CANNON_DAMAGE_RECEIVED", pUnit:GetNameNoDesc(), pHeadUnit:GetNameNoDesc(), iDamage))
	end
end



function HDNWFTWUpkeep(iPlayer)
	if iPlayer < iMaxCivs then
		local pPlayer = Players[iPlayer]
		for pUnit in pPlayer:Units() do
			pUnit:SetHasPromotion(iAssamLinkPromotion, false)
			if pUnit:GetUnitClassType() == iMagicalGirlClass then
				local iMGKey = GetMagicalGirlKey(iPlayer, iUnit)
				if iMGKey then
					if MagicalGirls[iMGKey].IsLeader == true and IsPlayerHDDMode(pPlayer) == true then
						if not MapModData.HDNMod.Shares[iPlayer] then MapModData.HDNMod.Shares[iPlayer] = 0 end
						local iSharesStrength = math.floor(MapModData.HDNMod.Shares[iPlayer] / (200 * PRODUCTION_SPEED_MOD))
						pUnit:SetBaseCombatStrength(MapModData.gPMMMMagicalGirlEraStrengths[pPlayer:GetCurrentEra()] + iSharesStrength)
					end
				end
			elseif pUnit:GetUnitType() == GameInfoTypes.UNIT_VV_GEARNAUGHT_SPECIAL and Game:GetGameTurn() - iNumTurnsNepgeardamLasts > pUnit:GetGameTurnCreated() then
				pUnit:Kill(true)
			end
		end
	end
end


if iAssamLink then
	GameEvents.CustomMissionPossible.Add(AssamLinkCustomMissionPossible)
	GameEvents.CustomMissionStart.Add(AssamLinkCustomMissionStart)
	GameEvents.CustomMissionCompleted.Add(AssamLinkCustomMissionCompleted)
end
if iGetterRavine then
	GameEvents.CustomMissionPossible.Add(GetterRavineCustomMissionPossible)
	GameEvents.CustomMissionStart.Add(GetterRavineCustomMissionStart)
	GameEvents.CustomMissionCompleted.Add(GetterRavineCustomMissionCompleted)
end
if iNepgeardamGo then
	GameEvents.CustomMissionPossible.Add(NepgeardamGoCustomMissionPossible)
	GameEvents.CustomMissionStart.Add(NepgeardamGoCustomMissionStart)
	GameEvents.CustomMissionCompleted.Add(NepgeardamGoCustomMissionCompleted)
end
if iBraveCannon then
	GameEvents.CustomMissionPossible.Add(BraveCannonCustomMissionPossible)
	GameEvents.CustomMissionStart.Add(BraveCannonCustomMissionStart)
	GameEvents.CustomMissionCompleted.Add(BraveCannonCustomMissionCompleted)
end
GameEvents.PlayerDoTurn.Add(HDNWFTWUpkeep)