-- SayakaBuilding
-- Author: Vicevirtuoso
-- DateCreated: 6/12/2014 3:06:52 PM
--------------------------------------------------------------


include('PMMMGeneralFunctions.lua');

local iBuilding = GameInfoTypes.BUILDING_PMMM_STAGE_OF_OKTAVIA
local iBuildingClass = GameInfo.BuildingClasses("Type ='" ..GameInfo.Buildings[iBuilding].BuildingClass.. "'")().ID
local iPrereq = GameInfo.Technologies("Type ='" ..GameInfo.Buildings[iBuilding].PrereqTech.. "'")().ID

function OktaviaGreatWorkHeal(iPlayer)
	if iPlayer < iMaxCivs then
		local pPlayer = Players[iPlayer]
		if pPlayer:IsAlive() and MapModData.gPMMMUniqueBuildings[iPlayer] == iBuilding then
			if Teams[pPlayer:GetTeam()]:IsHasTech(iPrereq) then
				local iTotalOktaviaGreatWorks = 0;
				for pCity in pPlayer:Cities() do
					if pCity:GetBuildingGreatWork(iBuildingClass, 0) >= 0 then
						dprint("Found Stage of Oktavia with Great Work.")
						iTotalOktaviaGreatWorks = iTotalOktaviaGreatWorks + 1
					end
				end
				if iTotalOktaviaGreatWorks > 0 then
					for pUnit in pPlayer:Units() do
						if (pUnit:GetDamage() > 0) then
							pUnit:ChangeDamage(-1 * math.min(pUnit:GetDamage(), iTotalOktaviaGreatWorks))
						end
					end
				end
			end
		end
	end
end
