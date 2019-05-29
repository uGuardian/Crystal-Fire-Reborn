-- HrodtohzTraitScript
-- Author: Vicevirtuoso
-- DateCreated: 10/4/2014 2:40:20 PM
--------------------------------------------------------------

local iRiktiDummy = GameInfoTypes.BUILDING_RIKTI_DUMMY
local iMachinery = GameInfoTypes.TECH_MACHINERY
local iRegularGeneral = GameInfoTypes.UNIT_GREAT_GENERAL
local iRiktiGeneral = GameInfoTypes.UNIT_GREAT_GENERAL_RIKTI

function RiktiPortalUpkeep (iPlayer)
	if tRiktiPlayers[iPlayer] then
		local pPlayer = Players[iPlayer]
		if pPlayer:IsAlive() then
			local pTeam = Teams[pPlayer:GetTeam()]
			local pTeamTechs = pTeam:GetTeamTechs()
		
			if pTeamTechs:HasTech(iMachinery) then 
				for pCity in pPlayer:Cities() do
					local iNumBuilding = 1
					if pCity:IsRazing() or pCity:IsPuppet() or pCity:IsOccupied() or pCity:IsResistance() then
						iNumBuilding = 0
					elseif (not pCity:IsCapital() and not pPlayer:IsCapitalConnectedToCity(pCity)) then
						iNumBuilding = 0
					end
					pCity:SetNumRealBuilding(iRiktiDummy, iNumBuilding)
				end
			else
				for pCity in pPlayer:Cities() do
					pCity:SetNumRealBuilding(iRiktiDummy, 0)
				end
			end
		end
	end
end


function ReplaceRiktiGeneral (iPlayer, iUnit, iX, iY)
	--This should not only replace normal Generals with Rikti Generals for the Rikti, but do the opposite for non-Rikti Civs (Patronage)
	if iX > 0 and iY > 0 then
		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iUnit)
		if pUnit then
			local bIsRikti = tRiktiPlayers[iPlayer]
			local iOldUnitType;
			local iNewUnitType;
			if bIsRikti then
				iOldUnitType = iRegularGeneral
				iNewUnitType = iRiktiGeneral
			else
				iOldUnitType = iRiktiGeneral
				iNewUnitType = iRegularGeneral
			end
			if pUnit:GetUnitType() == iOldUnitType then
				local pNewUnit = pPlayer:InitUnit(iNewUnitType, pUnit:GetX(), pUnit:GetY(), UNITAI_GREAT_GENERAL)
				pNewUnit:Convert(pUnit)
			end
		end
	end
end