-- PMMMMamiBuilding
-- Author: Vicevirtuoso
-- DateCreated: 6/12/2014 3:24:25 PM
--------------------------------------------------------------



include ('PMMMGeneralFunctions.lua');

local iBuilding = GameInfoTypes.BUILDING_PMMM_TEAHOUSE
local iPrereq = GameInfo.Technologies("Type ='" ..GameInfo.Buildings[iBuilding].PrereqTech.. "'")().ID
local iMamiDummy = GameInfoTypes.BUILDING_PMMM_TEAHOUSE_MAMI_DUMMY
local iFriendDummy = GameInfoTypes.BUILDING_PMMM_TEAHOUSE_FRIEND_DUMMY


--NOTE: This function currently will be broken if multiple Mamis are on the map. Each Mami will get their bonuses, but each of their friends will only get the bonus from the one with the
--highest PlayerID. Looking into a way to fix this without too much overhead (i.e. checking EVERY friendship EVERY turn is too much)
function CheckMamiFriendship(iPlayer)
	local pPlayer = Players[iPlayer]
	if iPlayer < iMaxCivs and pPlayer:IsAlive() then
		if MapModData.gPMMMUniqueBuildings[iPlayer] == iBuilding and Teams[pPlayer:GetTeam()]:IsHasTech(iPrereq) then
			dprint("Called function for FriendshipProductionModifier")
			--First, find out how many Teahouses she has.
			local iNumBuildingsInEmpire = 0;
			for pCity in pPlayer:Cities() do
				if pCity:IsHasBuilding(iBuilding) then
					iNumBuildingsInEmpire = iNumBuildingsInEmpire + 1;
				end
			end
			local iNumDoFs = 0;
			for iLoopID=0, iMaxCivs - 1 do
				local pOtherPlayer = Players[iLoopID]
				local iBuildingsToSet = iNumBuildingsInEmpire
				if pOtherPlayer:IsAlive() then
					if pPlayer ~= pOtherPlayer then
						if (pPlayer:IsDoF(pOtherPlayer:GetID())) then
							iNumDoFs = iNumDoFs + 1;
						else
							iBuildingsToSet = 0
						end
					end
					local pOtherCapital = pOtherPlayer:GetCapitalCity()
					if pOtherCapital then
						local tOtherBuildingTable = toBits(iBuildingsToSet)
						pOtherCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_PMMM_TEAHOUSE_FRIEND_DUMMY_1, tOtherBuildingTable[1] or 0)
						pOtherCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_PMMM_TEAHOUSE_FRIEND_DUMMY_2, tOtherBuildingTable[2] or 0)
						pOtherCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_PMMM_TEAHOUSE_FRIEND_DUMMY_4, tOtherBuildingTable[3] or 0)
						pOtherCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_PMMM_TEAHOUSE_FRIEND_DUMMY_8, tOtherBuildingTable[4] or 0)
						pOtherCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_PMMM_TEAHOUSE_FRIEND_DUMMY_16, tOtherBuildingTable[5] or 0)
						pOtherCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_PMMM_TEAHOUSE_FRIEND_DUMMY_32, tOtherBuildingTable[6] or 0)
					end
				end
			end
			local pCapital = pPlayer:GetCapitalCity()
			if pCapital then
				local tBuildingTable = toBits(iNumDoFs)
				pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_PMMM_TEAHOUSE_MAMI_DUMMY_1, tBuildingTable[1] or 0)
				pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_PMMM_TEAHOUSE_MAMI_DUMMY_2, tBuildingTable[2] or 0)
				pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_PMMM_TEAHOUSE_MAMI_DUMMY_4, tBuildingTable[3] or 0)
				pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_PMMM_TEAHOUSE_MAMI_DUMMY_8, tBuildingTable[4] or 0)
				pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_PMMM_TEAHOUSE_MAMI_DUMMY_16, tBuildingTable[5] or 0)
				pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_PMMM_TEAHOUSE_MAMI_DUMMY_32, tBuildingTable[6] or 0)
			end
		end
	end
end