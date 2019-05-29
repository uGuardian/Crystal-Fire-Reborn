-- PMMMUltimateMadokaBuilding
-- Author: Vicevirtuoso
-- DateCreated: 7/10/2014 5:01:26 PM
--------------------------------------------------------------




local iLuminousGarden = GameInfoTypes.BUILDING_PMMM_LUMINOUS_GARDEN

function LuminousRecoverSoulGem(iPlayer)
	local pPlayer = Players[iPlayer]
	for pUnit in pPlayer:Units() do
		if pUnit:GetUnitType() == GameInfoTypes.UNIT_PMMM_MAGICAL_GIRL then
			if pUnit:GetPlot():IsCity() then
				local pCity = pUnit:GetPlot():GetPlotCity()
				if pCity:HasBuilding(iLuminousGarden) then
					local iMGKey = GetMagicalGirlKey(iPlayer, pUnit:GetID())
					DoChangeCorruption(-1, iMGKey)
				end
			end
		end
	end
end