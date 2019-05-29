-- PMMMRouseMilitia
-- Author: Vicevirtuoso
-- DateCreated: 11/20/2014 11:40:20 PM
--------------------------------------------------------------

local iGeneralClass = GameInfoTypes.UNITCLASS_GREAT_GENERAL
local iMissionType = GameInfoTypes.MISSION_PMMM_ROUSE_MILITIA

function RouseMilitiaCustomMissionPossible(iPlayer, iUnit, iMission, iData1, iData2, _, _, iPlotX, iPlotY, bTestVisible)
	if iPlayer < iMaxCivs then
		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iUnit)
		if pUnit:GetUnitClassType() == iGeneralClass and iMission == iMissionType then
			local pPlot = pUnit:GetPlot()
			if pPlot:GetOwner() == iPlayer then
				return true
			else
				return bTestVisible
			end
		end
	end
	return false
end


function RouseMilitiaCustomMissionStart(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	if iMission == iMissionType then
		local iNewUnit, iNumUnits = GetRouseMilitiaUnitsAndType(iPlayer, iUnit)

		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iUnit)
		local pPlot = pUnit:GetPlot()

		GameEvents.GreatPersonExpended.Call(iPlayer, iUnit, pUnit:GetUnitType(), pUnit:GetX(), pUnit:GetY())
		pUnit:Kill(true)
		for pAreaPlot in PlotAreaSpiralIterator(pPlot, 1) do
			local bJump = false
			if pAreaPlot:GetNumUnits() > 0 then
				bJump = true
			end
			local eNewUnit = pPlayer:InitUnit(iNewUnit, pAreaPlot:GetX(), pAreaPlot:GetY(), UNITAI_DEFENSE)
			iNumUnits = iNumUnits - 1
			local plot = eNewUnit:GetPlot()
			if plot:IsWater() or plot:IsMountain() or plot:IsImpassable() then
				bJump = true
			end
			if bJump then
				eNewUnit:JumpToNearestValidPlot()
			end
			eNewUnit:SetMoves(0)
			if iNumUnits <= 0 then
				break
			end
		end
	end
	return 0
end

function RouseMilitiaCustomMissionCompleted(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	if iMission == iMissionType then
		return true
	end
	return false
end


--Force AI to rouse militia if it can gain a certain number of units (2)
--Also try to force the use of more citadels -- the goal is to get the AI to turn its Generals into MGs otherwise it's crippling itself
function AIRouseMilitiaHandler(iPlayer)
	local pPlayer = Players[iPlayer]
	if not pPlayer:IsHuman() then
		--only run citadels if it's at war with a major
		local bAIAtWar = false
		local pTeam = Teams[pPlayer:GetTeam()]
		for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
			local pLoop = Players[i]
			if i ~= iPlayer and pTeam:IsAtWar(pLoop:GetTeam()) and pLoop:IsAlive() then
				bAIAtWar = true
				break
			end
		end

		for pUnit in pPlayer:Units() do
			if pUnit:GetUnitClassType() == iGeneralClass then
				local iMinimumNumber = 2
				if pUnit:IsHasPromotion(GameInfoTypes.PROMOTION_DOES_NOT_BECOME_GMG) then
					iMinimumNumber = iMinimumNumber + 1
				end
				local bCanDo = RouseMilitiaCustomMissionPossible(iPlayer, pUnit:GetID(), iMissionType)
				local iNumUnits = GetRouseMilitiaUnitsAndType(iPlayer, pUnit:GetID())
				if bCanDo == true and iNumUnits >= iMinimumNumber then
					pUnit:PopMission()
					pUnit:PushMission(iMissionType)
				end
				
				--Citadels: plop one down if it's possible to do and there are at least 4 enemy units within 2 tiles
				if bAIAtWar and pUnit:CanBuild(pUnit:GetPlot(), GameInfoTypes.BUILD_CITADEL) then
					local pTeam = Teams[pPlayer:GetTeam()]
					local iNumEnemyUnits = 0
					for pAreaPlot in PlotAreaSpiralIterator(pUnit:GetPlot(), 2) do
						if pAreaPlot:IsUnit() then
							for c = 0, pAreaPlot:GetNumUnits() - 1 do
								local pTestUnit = pAreaPlot:GetUnit(c)
								if pTestUnit then
									if pTestUnit:GetOwner() ~= iPlayer and pTestUnit:IsCombatUnit() and pTeam:IsAtWar(Players[pTestUnit:GetOwner()]:GetTeam()) then
										iNumEnemyUnits = iNumEnemyUnits + 1
										if iNumEnemyUnits >= 4 then
											pUnit:PopMission()
											pUnit:PushMission(MissionTypes.MISSION_BUILD, GameInfoTypes.BUILD_CITADEL, -1, 0, 0, 1, MissionTypes.MISSION_BUILD, pUnit:GetPlot(), pUnit)
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





function GetRouseMilitiaUnitsAndType(iPlayer, iUnit, ttable)
	local pPlayer = Players[iPlayer]

	--Find the best unit type for the player
	local pTeamTechs = Teams[pPlayer:GetTeam()]:GetTeamTechs()
	local iBestUnitID;
	local sTypeString = "";
	local iHighestCombatStrength = 0
	for unit in GameInfo.Units() do
		if unit.CombatClass == 'UNITCOMBAT_MELEE' or unit.CombatClass == 'UNITCOMBAT_GUN' then
			if (unit.PrereqTech and GameInfo.Technologies[unit.PrereqTech].ID and pTeamTechs:HasTech(GameInfo.Technologies[unit.PrereqTech].ID)) or (not unit.PrereqTech and unit.Cost > 0) then
				if not unit.ObsoleteTech or (GameInfo.Technologies[unit.ObsoleteTech].ID and not pTeamTechs:HasTech(GameInfo.Technologies[unit.ObsoleteTech].ID)) then
					local bRequiresResource;
					for requirement in GameInfo.Unit_ResourceQuantityRequirements() do
						if requirement.UnitType == unit.Type then
							bRequiresResource = true
							break
						end
					end
					--Unique Unit?
					local bIsOtherCivUU;
					local bIsThisCivUU;
					for replace in GameInfo.Civilization_UnitClassOverrides() do
						if replace.UnitType == unit.Type then
							if replace.CivilizationType == GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type then
								iBestUnitID = GameInfo.Units[replace.UnitType].ID
								sBestUnitType = replace.UnitType
								bIsThisCivUU = true
							else
								bIsOtherCivUU = true
							end
							break
						end
					end
					if not bRequiresResource and not bIsOtherCivUU then
						if unit.Combat > iHighestCombatStrength or bIsThisCivUU == true then
							iHighestCombatStrength = unit.Combat
							iBestUnitID = unit.ID
							sTypeString = Locale.ConvertTextKey(unit.Description)
						end
					end
				end
			end
		end
	end

	--Default to Warrior if there is a problem
	if not iBestUnitID then
		print("Error getting best unit type for Rouse Militia. Defaulting to Warrior")
		iBestUnitID = GameInfoTypes.UNIT_WARRIOR
	end

	--How many will we receive?
	--New formula: Can only receive a maximum of 3 units.
	--Being at war no longer adds more units.
	--Calculated based off of the strongest world military power.
	--If you are at 60% or less of the military leader's power, you will get 2 Units.
	--If you are at 30% or less of the military leader's power, you will get 3 Units.
	--Otherwise you only get one.
	local iStrongestMight = 0
	local iMyMight = pPlayer:GetMilitaryMight()
	for iLoop = 0, iMaxCivs - 1, 1 do
		local pLoop = Players[iLoop]
		if pLoop:IsAlive() then
			local iThisMight = pLoop:GetMilitaryMight()
			if iThisMight > iStrongestMight then
				iStrongestMight = iThisMight
			end
		end
	end
	
	print("strongest player might: "..iStrongestMight..", active player might: "..iMyMight)

	local iNumUnits = 0
	if iMyMight <= math.floor(iStrongestMight * 0.3) then
		print("3 base units")
		iNumUnits = 3
	elseif iMyMight <= math.floor(iStrongestMight * 0.6) then
		print("2 base units")
		iNumUnits = 2
	else
		print("1 base unit")
		iNumUnits = 1
	end
	
	--Gets another unit if it is a non-contracting unit (i.e. Clara Doll)
	local pUnit = pPlayer:GetUnitByID(iUnit)
	if pUnit:IsHasPromotion(GameInfoTypes.PROMOTION_DOES_NOT_BECOME_GMG) then
		iNumUnits = iNumUnits + 1
	end
	
	if ttable then
		ttable[0] = iNumUnits
		ttable[1] = sTypeString
	end

	return iBestUnitID, iNumUnits
end

LuaEvents.PMMMGetRouseMilitiaUnitsAndType.Add(GetRouseMilitiaUnitsAndType)



--To save space in other Lua files, this one will also contain the function to remove the General/Admiral promotion from Navigator/Commander prodigies.
--For whatever reason, this causes crashes. Let's remove it for now.
-- function RemoveGeneralAdmiralBonusFromProdigies(iPlayer, iUnit, iUnitType)
	-- if GameInfo.Units[iUnitType].Class == 'UNITCLASS_GREAT_GENERAL' then
		-- local pPlayer = Players[iPlayer]
		-- local pUnit = pPlayer:GetUnitByID(iUnit)
		-- if pUnit and not pUnit:IsHasPromotion(GameInfoTypes.PROMOTION_DOES_NOT_BECOME_GMG) then
			-- pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_GREAT_GENERAL, false)
		-- end
	-- elseif GameInfo.Units[iUnitType].Class == 'UNITCLASS_GREAT_ADMIRAL' then
		-- local pPlayer = Players[iPlayer]
		-- local pUnit = pPlayer:GetUnitByID(iUnit)
		-- if pUnit and not pUnit:IsHasPromotion(GameInfoTypes.PROMOTION_DOES_NOT_BECOME_GMG) then
			-- pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_GREAT_ADMIRAL, false)
		-- end
	-- end
-- end