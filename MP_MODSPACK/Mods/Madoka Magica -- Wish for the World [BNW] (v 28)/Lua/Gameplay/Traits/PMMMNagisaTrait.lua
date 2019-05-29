-- Nagisa Trait
-- Author: Vicevirtuoso
-- DateCreated: 12/20/2013 2:15:57 PM
--------------------------------------------------------------


include('PMMMGeneralFunctions.lua');


function NagisaGoldenAge(iPlayer)
	if MapModData.gPMMMGoldenAgeResources[iPlayer] then
		local pPlayer = Players[iPlayer]
		if pPlayer:IsGoldenAge() then
			for pCity in pPlayer:Cities() do
				local iNumPlots = pCity:GetNumCityPlots();
				local EmptyPlots = {}
				local ResourcesToMake = {}
				for k in pairs(MapModData.gPMMMGoldenAgeResources[iPlayer]) do
					ResourcesToMake[MapModData.gPMMMGoldenAgeResources[iPlayer][k].ResourceType] = 0
				end
				for iPlot = 0, iNumPlots - 1 do
					local pPlot = pCity:GetCityIndexPlot(iPlot)
					if pPlot and pPlot:GetResourceType() > -1 and Map.PlotDistance(pPlot:GetX(), pPlot:GetY(), pCity:GetX(), pCity:GetY()) <= 3 then
						for k, v in pairs(MapModData.gPMMMGoldenAgeResources[iPlayer]) do
							if pPlot:GetResourceType() == v.ResourceType then
								local iRand = Game.Rand(100, "Resource Spread Roll PMMM")
								if iRand < MapModData.gPMMMGoldenAgeResources[iPlayer][k].ProbabilityPerTurn then
									ResourcesToMake[MapModData.gPMMMGoldenAgeResources[iPlayer][k].ResourceType] = ResourcesToMake[MapModData.gPMMMGoldenAgeResources[iPlayer][k].ResourceType] + 1
								end
							end
						end
					elseif pPlot and pPlot:GetResourceType() < 0 and pPlot:GetFeatureType() < 0 and pPlot:GetImprovementType() < 0 and not pPlot:IsWater() and not pPlot:IsMountain() and not pPlot:IsCity() then
						table.insert(EmptyPlots, pPlot)
					end
				end
				for k, v in pairs(ResourcesToMake) do
					while v > 0 and v~= nil do
						v = v - 1
						pPlot = EmptyPlots[Game.Rand(#EmptyPlots, "Empty Plot Roll for Resource Spread PMMM") + 1]
						pPlot:SetResourceType(k, 1)
						local sText = Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_PMMM_NAGISA_RESOURCE_TEXT")
						local sTitle = Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_PMMM_NAGISA_RESOURCE_TITLE")
						pPlayer:AddNotification(NotificationTypes.NOTIFICATION_DISCOVERED_BONUS_RESOURCE, sText, sTitle, pPlot:GetX(), pPlot:GetY(), k)
					end
				end
			end
		end
	end
end
