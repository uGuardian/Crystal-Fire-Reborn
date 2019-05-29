-- PMMMShiromeTrait
-- Author: Vice
-- DateCreated: 8/9/2014 9:50:40 PM
--------------------------------------------------------------


function OnPlayerDoTurnShiromeTrait(iPlayer)
	if MapModData.gPMMMTraits[iPlayer].LeaderMGIntrigueTurns > 0 then
		local iLastTurn = PMMM.PlayerLastGotFreeIntrigueTurn[iPlayer] or -100
		if Game:GetGameTurn() - iLastTurn >= MapModData.gPMMMTraits[iPlayer].LeaderMGIntrigueTurns then
			local pLeader = GetLeaderMagicalGirl(iPlayer)
			if pLeader then
				local tCities = {}
				for pAreaPlot in PlotAreaSpiralIterator(pLeader:GetPlot(), 2, false, false, false, true) do
					if pAreaPlot:IsCity() then
						local pCity = pAreaPlot:GetPlotCity()
						if pCity:GetOwner() ~= iPlayer then
							tCities[#tCities + 1] = pCity
						end
					end
				end
				local pChosenCity;
				if #tCities > 1 then
					pChosenCity = tCities[Game.Rand(#tCities, "PMMM Shirome Trait Roll") + 1]
				elseif #tCities == 1 then
					pChosenCity = tCities[1]
				end
				if pChosenCity then
					Players[iPlayer]:GetRandomIntrigue(pChosenCity)
					PMMM.PlayerLastGotFreeIntrigueTurn[iPlayer] = Game:GetGameTurn()
				end
			end
		end
	end
end


function OnLoadScreenCloseShiromeTrait()
	for i = 0, iMaxCivs - 1, 1 do
		if MapModData.gPMMMTraits[i].RevealCivLocations and (MapModData.gPMMMTraits[i].RevealCivLocations == 1 or MapModData.gPMMMTraits[i].RevealCivLocations == true) then
			local iTeam = Players[i]:GetTeam()
			for j = 0, iMaxCivs - 1, 1 do
				if i ~= j then
					local pPlayer = Players[j]
					if pPlayer:IsEverAlive() then
						for pAreaPlot in PlotAreaSpiralIterator(pPlayer:GetStartingPlot(), 1, false, false, false, true) do
							pAreaPlot:SetRevealed(iTeam, true)
						end
					end
				end
			end
		end
	end
end