-- SyntheticSingerGWScript
-- Author: Vicevirtuoso
-- DateCreated: 3/11/2014 11:26:09 PM
--------------------------------------------------------------

--set to true to enable print statements
local bDebug = false

function dprint(...)
  if (bDebug) then
    print(string.format(...))
  end
end

--Variable to detect if CultureOverview popup is up; this is the only time that the UpdateVocaloidBuildingsUI() function should run
local bPopup;


--Precache every Vocaloid Great Work in the database to speed things up.
local tVocaloidWorks = {}

for work in GameInfo.GreatWorks() do
	if work.BonusFromOtherCivsInfluenced == 1 then
		tVocaloidWorks[work.ID] = work.Type
	end
end

for k, v in pairs(tVocaloidWorks) do
	dprint("Great Work type " ..k.. "; Name: " ..v)
end

--Precache all buildings that have Great Works of Music to speed things up more.
local tGreatMusicBuildings = {};
for pBuilding in GameInfo.Buildings() do
	if pBuilding.GreatWorkSlotType == "GREAT_WORK_SLOT_MUSIC" and pBuilding.GreatWorkCount > 0 then
		local pBuildingClass = GameInfo.BuildingClasses("Type = '" ..pBuilding.BuildingClass.. "'")()
		--Save BuildingClasses instead of BuildingTypes since GetBuildingGreatWork() calls for Classes
		tGreatMusicBuildings[pBuildingClass.ID] = pBuildingClass.Type
		dprint("Added buildingclass " ..Locale.ConvertTextKey(pBuildingClass.Description).. " to Great Work building table")
	end
end


--Check all of a player's buildings at start of turn, and update the Vocaloid bonus buildings accordingly
--Time-consuming function, should look into possibilities of reducing processor impact
function UpdateVocaloidBuildings(iPlayer)
if iPlayer >= GameDefines.MAX_MAJOR_CIVS then return end
dprint("Called UpdateVocaloidBuildings")
local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() then
		for pCity in pPlayer:Cities() do
			local iNumVocaloidWorksThisCity = 0;
			for iVocaloidWork, pVocaloidWork in pairs(tVocaloidWorks) do
				dprint("Testing to see if " ..pVocaloidWork.. " (ID " ..iVocaloidWork.. ") is in " ..pCity:GetName())
				for iBuildingClass, pBuildingClass in pairs(tGreatMusicBuildings) do
					dprint("Checking building class " ..pBuildingClass)
					local iCurrentWorks = pCity:GetNumGreatWorksInBuilding(iBuildingClass)
					if iCurrentWorks > 0 then
						for i = 0, iCurrentWorks - 1, 1 do
							dprint("Testing work slot")
							local iWorkType = pCity:GetBuildingGreatWork(iBuildingClass, i)
							dprint("iWorkType:" ..iWorkType)
							dprint("GreatWorkType: " ..Game.GetGreatWorkType(iWorkType, iPlayer))
							if Game.GetGreatWorkType(iWorkType, iPlayer) == iVocaloidWork then
								dprint("Found it!")
								iNumVocaloidWorksThisCity = iNumVocaloidWorksThisCity + 1
								break
							end
						end
					else
						dprint("No works in this building!")
					end
				end
			end
			if iNumVocaloidWorksThisCity > 0 then
				dprint("Number of Vocaloid works: " ..iNumVocaloidWorksThisCity)
				local iInfluenceMultiplier = 0;
				for iEnemyPlayer = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
					local pEnemyPlayer = Players[iEnemyPlayer]
					if pEnemyPlayer:IsAlive() and iEnemyPlayer ~= iPlayer then
						dprint("Checking influence with " ..pEnemyPlayer:GetCivilizationShortDescription())
						local iInfluenceLevel = pPlayer:GetInfluenceLevel(iEnemyPlayer)
						dprint("Enemy player influence level: " ..iInfluenceLevel)
						if iInfluenceLevel == InfluenceLevelTypes.INFLUENCE_LEVEL_FAMILIAR then
							iInfluenceMultiplier = iInfluenceMultiplier + 1
						elseif iInfluenceLevel == InfluenceLevelTypes.INFLUENCE_LEVEL_POPULAR then
							iInfluenceMultiplier = iInfluenceMultiplier + 2
						elseif iInfluenceLevel == InfluenceLevelTypes.INFLUENCE_LEVEL_INFLUENTIAL then
							iInfluenceMultiplier = iInfluenceMultiplier + 3
						elseif iInfluenceLevel == InfluenceLevelTypes.INFLUENCE_LEVEL_DOMINANT then
							iInfluenceMultiplier = iInfluenceMultiplier + 4
						end
					end
				end
				dprint("Influence modifier: " ..iInfluenceMultiplier)
				local iTotalBuildings = iNumVocaloidWorksThisCity * iInfluenceMultiplier;
				pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_VOCALOID_SCIENCE, iTotalBuildings)
			end
		end
	end
end


--Check all of a player's buildings when CultureOverview is updated (swapping Great Works around), and update the Logia bonus buildings accordingly
function UpdateVocaloidBuildingsUI()
	--If bPopup is false then that will (should) mean that CultureOverview is not active, and that's the only screen this mod needs tracking for,
	--so quit this function if false
	if not bPopup then
		return
	end
	local iPlayer = Game:GetActivePlayer()
	local pPlayer = Players[iPlayer]
	if pPlayer:IsEverAlive() then
		for pCity in pPlayer:Cities() do
			local iNumVocaloidWorksThisCity = 0;
			for iVocaloidWork, pVocaloidWork in pairs(tVocaloidWorks) do
				dprint("Testing to see if " ..pVocaloidWork.. " (ID " ..iVocaloidWork.. ") is in " ..pCity:GetName())
				for iBuildingClass, pBuildingClass in pairs(tGreatMusicBuildings) do
					dprint("Checking building class " ..pBuildingClass)
					local iCurrentWorks = pCity:GetNumGreatWorksInBuilding(iBuildingClass)
					if iCurrentWorks > 0 then
						for i = 0, iCurrentWorks - 1, 1 do
							dprint("Testing work slot")
							local iWorkType = pCity:GetBuildingGreatWork(iBuildingClass, i)
							dprint("iWorkType:" ..iWorkType)
							dprint("GreatWorkType: " ..Game.GetGreatWorkType(iWorkType, iPlayer))
							if Game.GetGreatWorkType(iWorkType, iPlayer) == iVocaloidWork then
								dprint("Found it!")
								iNumVocaloidWorksThisCity = iNumVocaloidWorksThisCity + 1
								break
							end
						end
					else
						dprint("No works in this building!")
					end
				end
			end
			if iNumVocaloidWorksThisCity > 0 then
				dprint("Number of Vocaloid works: " ..iNumVocaloidWorksThisCity)
				local iInfluenceMultiplier = 0;
				for iEnemyPlayer = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
					local pEnemyPlayer = Players[iEnemyPlayer]
					if pEnemyPlayer:IsAlive() and iEnemyPlayer ~= iPlayer then
						dprint("Checking influence with " ..pEnemyPlayer:GetCivilizationShortDescription())
						local iInfluenceLevel = pPlayer:GetInfluenceLevel(iEnemyPlayer)
						dprint("Enemy player influence level: " ..iInfluenceLevel)
						if iInfluenceLevel == InfluenceLevelTypes.INFLUENCE_LEVEL_FAMILIAR then
							iInfluenceMultiplier = iInfluenceMultiplier + 1
						elseif iInfluenceLevel == InfluenceLevelTypes.INFLUENCE_LEVEL_POPULAR then
							iInfluenceMultiplier = iInfluenceMultiplier + 2
						elseif iInfluenceLevel == InfluenceLevelTypes.INFLUENCE_LEVEL_INFLUENTIAL then
							iInfluenceMultiplier = iInfluenceMultiplier + 3
						elseif iInfluenceLevel == InfluenceLevelTypes.INFLUENCE_LEVEL_DOMINANT then
							iInfluenceMultiplier = iInfluenceMultiplier + 4
						end
					end
				end
				dprint("Influence modifier: " ..iInfluenceMultiplier)
				local iTotalBuildings = iNumVocaloidWorksThisCity * iInfluenceMultiplier;
				pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_VOCALOID_SCIENCE, iTotalBuildings)
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(UpdateVocaloidBuildings)
Events.SerialEventCityInfoDirty.Add(UpdateVocaloidBuildingsUI)


--When a popup screen appears, check if it is CultureOverview. If so, set bPopup to true, which lets UpdateLostLogiaBuildingsUI() fire
function SetCurrentPopupMiku(popupInfo)
	local popupType = popupInfo.Type
	if popupType == ButtonPopupTypes.BUTTONPOPUP_CULTURE_OVERVIEW then
		bPopup = true
	end
end
Events.SerialEventGameMessagePopup.Add(SetCurrentPopupMiku)


--When a popup is closed, delete bPopup so it doesn't keep refreshing Logia buildings when CultureOverview isn't open
function ClearCurrentPopupMiku()
	bPopup = nil;
end
Events.SerialEventGameMessagePopupProcessed.Add(ClearCurrentPopupMiku)