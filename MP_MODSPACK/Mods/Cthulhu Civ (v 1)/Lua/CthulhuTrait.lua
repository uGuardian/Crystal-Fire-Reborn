-- CTHULHUTrait
-- Author: Charles Zhao
-- DateCreated: 6/19/2014 4:03:50 AM
--------------------------------------------------------------

-- Science from Faith, also handles SHRINE faith from pop
-- 

function CthulhuStart()
	-- Grants Yuno a free marble tile near starting settler
	for _, player in pairs(Players) do
		if player:IsEverAlive() then
			if(player:GetCivilizationType() == GameInfoTypes["CIVILIZATION_RLYEH"]) then		
				GameEvents.PlayerDoTurn.Add(CthulhuReplaceHolySites)
				GameEvents.PlayerDoTurn.Add(CthulhuScienceFromFaith)
			end
		end
	end
end
Events.SequenceGameInitComplete.Add(CthulhuStart)

function CthulhuScienceFromFaith(iPlayer)
	local bonusScience=0;
	for iPlayer, pPlayer in pairs(Players) do
		if pPlayer:IsEverAlive() and not pPlayer:IsMinorCiv() and iPlayer~=63 then
			if (pPlayer:GetCivilizationType()==GameInfoTypes["CIVILIZATION_RLYEH"]) then
				bonusScience=math.floor(pPlayer:GetTotalFaithPerTurn()/3)
				for pCity in pPlayer:Cities() do
					local shrineFaith=0
					if (pCity:GetNumBuilding(GameInfoTypes["BUILDING_BLOOD_SHRINE"]) > 0) then
						shrineFaith=math.floor(pCity:GetPopulation()/4)
					end
					pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_CTHULHU_TRAIT_BUILDING_2"], shrineFaith)
					pCity:SetNumRealBuilding(GameInfoTypes["BUILDING_CTHULHU_TRAIT_BUILDING"],0)
				end
				if (pPlayer:GetCapitalCity()) then
					pPlayer:GetCapitalCity():SetNumRealBuilding(GameInfoTypes["BUILDING_CTHULHU_TRAIT_BUILDING"], bonusScience)
				end
			end
		end
	end
end

--Check every turn for holy sites, replace if necessary
--If this is too inefficient, then build code to store converted holy-sites for conversion back if they change owner

function CthulhuReplaceHolySites(iPlayer)
	local pPlayer = Players[iPlayer];
	if (pPlayer:GetCivilizationType()==GameInfoTypes["CIVILIZATION_RLYEH"]) then	
		--Check player piety policies
		local replacementID=GameInfoTypes["IMPROVEMENT_HOLY_SITE_CTHULHU1"]
		--Is World Congree active?
		local pWorldCongress = nil
		if (Game.GetNumActiveLeagues() > 0) then
			pWorldCongress = Game.GetActiveLeague()
		end
		--Check correct Cthulhu site for this time period
		if (pWorldCongress ~= nil) then
			for  _, t in ipairs(pWorldCongress:GetActiveResolutions()) do
				--print(t.Type)
				--print(GameInfoTypes["RESOLUTION_HISTORICAL_LANDMARKS"])
				if (t.Type==GameInfoTypes["RESOLUTION_HISTORICAL_LANDMARKS"]) then
					replacementID=GameInfoTypes["IMPROVEMENT_HOLY_SITE_CTHULHU2"]
				end
			end
		end
		--Check all city plots for holy sites; replace if necessary
		for pCity in pPlayer:Cities() do
			for ii = 0, pCity:GetNumCityPlots() - 1, 1 do
				local mPlot	= pCity:GetCityIndexPlot( ii );
				if ((mPlot:GetImprovementType()==GameInfoTypes["IMPROVEMENT_HOLY_SITE"]) or (mPlot:GetImprovementType()==GameInfoTypes["IMPROVEMENT_HOLY_SITE_CTHULHU2"]) and (replacementID==GameInfoTypes["IMPROVEMENT_HOLY_SITE_CTHULHU1"])) then
					local pillaged=mPlot:IsImprovementPillaged()
					mPlot:SetImprovementType(replacementID)
					mPlot:SetImprovementPillaged(pillaged)
				elseif ((mPlot:GetImprovementType()==GameInfoTypes["IMPROVEMENT_HOLY_SITE"]) or (mPlot:GetImprovementType()==GameInfoTypes["IMPROVEMENT_HOLY_SITE_CTHULHU1"]) and (replacementID==GameInfoTypes["IMPROVEMENT_HOLY_SITE_CTHULHU2"])) then
					local pillaged=mPlot:IsImprovementPillaged()
					mPlot:SetImprovementType(replacementID)
					mPlot:SetImprovementPillaged(pillaged)
				end
			end
		end
	else
		--Check all city plots for holy sites; replace if necessary
		for pCity in pPlayer:Cities() do
			for ii = 0, pCity:GetNumCityPlots() - 1, 1 do
				local mPlot	= pCity:GetCityIndexPlot( ii );
				if ((mPlot:GetImprovementType()==GameInfoTypes["IMPROVEMENT_HOLY_SITE_CTHULHU1"]) or (mPlot:GetImprovementType()==GameInfoTypes["IMPROVEMENT_HOLY_SITE_CTHULHU2"])) then
					local pillaged=mPlot:IsImprovementPillaged()
					mPlot:SetImprovementType(GameInfoTypes["IMPROVEMENT_HOLY_SITE"])
					mPlot:SetImprovementPillaged(pillaged)
				end
			end
		end
	end
end

--Shoggoths spawn more shoggoths when killing a unit?