-- Sakura Church
-- Author: Vicevirtuoso
-- DateCreated: 6/14/2014 2:19:42 PM
--------------------------------------------------------------


include('PMMMGeneralFunctions.lua');

local iBuilding = GameInfoTypes.BUILDING_PMMM_SAKURA_CHURCH
local iPrereq = GameInfo.Technologies("Type ='" ..GameInfo.Buildings[iBuilding].PrereqTech.. "'")().ID
local iDummy = GameInfoTypes.BUILDING_PMMM_SAKURA_CHURCH_DUMMY

function CheckSakuraChurch(iPlayer)
	local pPlayer = Players[iPlayer]
	if iPlayer < iMaxCivs and pPlayer:IsAlive() then
		if MapModData.gPMMMUniqueBuildings[iPlayer] == iBuilding and Teams[pPlayer:GetTeam()]:IsHasTech(iPrereq) then
			for pCity in pPlayer:Cities() do
				if pCity:IsHasBuilding(iBuilding) then
					local iReligion = pCity:GetReligiousMajority()
					if iReligion > -1 then
						if pPlayer:GetReligionCreatedByPlayer() > -1 and iReligion == pPlayer:GetReligionCreatedByPlayer() then
							local iFollowers = math.min(pCity:GetNumFollowers(iReligion), 20)
							pCity:SetNumRealBuilding(iDummy, iFollowers)
						elseif pPlayer:GetReligionCreatedByPlayer() < 0 and iReligion == pPlayer:HasReligionInMostCities(iReligion) then
							local iFollowers = math.min(pCity:GetNumFollowers(iReligion), 20)
							pCity:SetNumRealBuilding(iDummy, iFollowers)
						else
							pCity:SetNumRealBuilding(iDummy, 0)
						end
					else
						pCity:SetNumRealBuilding(iDummy, 0)
					end
				else
					pCity:SetNumRealBuilding(iDummy, 0)
				end
			end
		end
	end
end