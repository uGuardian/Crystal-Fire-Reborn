-- StatesmanTraitScript
-- Author: Vicevirtuoso
-- DateCreated: 3/27/2014 3:22:53 PM
--------------------------------------------------------------



--Cache data about buildings, promotions, etc for speed
local iScienceBuilding = GameInfoTypes.BUILDING_STATESMAN_SCIENCE_DUMMY
local iWentworths = GameInfoTypes.BUILDING_WENTWORTHS

local tWentworthsBuildings = {
	GameInfoTypes.BUILDING_WENTWORTHS_DUMMY_1,
	GameInfoTypes.BUILDING_WENTWORTHS_DUMMY_2,
	GameInfoTypes.BUILDING_WENTWORTHS_DUMMY_3,
	GameInfoTypes.BUILDING_WENTWORTHS_DUMMY_4
	}


--UA: +Science for more advanced Civ having military in your territory
function StatesmanScience(iPlayer)
	local pPlayer = Players[iPlayer]
	if iPlayer < GameDefines.MAX_MAJOR_CIVS and pPlayer:IsEverAlive() then
		if tTraits[iPlayer].SciencePerMoreAdvancedEnemyUnit > 0 then
			dprint("Statesman's trait called")
			local iNumBuildings = 0
			for iEnemyPlayer = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
				if iEnemyPlayer ~= iPlayer then
					local pEnemyPlayer = Players[iEnemyPlayer]
					local pTeam = Teams[pPlayer:GetTeam()]
					local pEnemyTeam = Teams[pEnemyPlayer:GetTeam()]
					local pTeamTechs = pTeam:GetTeamTechs()
					local pEnemyTeamTechs = pEnemyTeam:GetTeamTechs()
					if pEnemyTeam:IsAtWar(pTeam:GetID()) then
						dprint("Enemy at war with Statesman")
						local iTechDifference = pEnemyTeamTechs:GetNumTechsKnown() - pTeamTechs:GetNumTechsKnown()
						if iTechDifference > 0 then
							dprint("Higher tech level")
							for pUnit in pEnemyPlayer:Units() do
								if pUnit:GetPlot():GetOwner() == iPlayer then
									dprint("Unit in territory")
									iNumBuildings = iNumBuildings + 1
								end
							end
						end
					end
				end
			end
			iNumBuildings = iNumBuildings * tTraits[iPlayer].SciencePerMoreAdvancedEnemyUnit
			dprint("Total buildings to add: " ..iNumBuildings)
			local pCity = pPlayer:GetCapitalCity()
			if pCity then
				pCity:SetNumRealBuilding(iScienceBuilding, iNumBuildings)
			end
		end
	end
end






--UB: Bonus promotions per trade route with a city that has a Wentworth's
function Wentworths(iPlayer)
	local pPlayer = Players[iPlayer]
	if iPlayer < GameDefines.MAX_MAJOR_CIVS and pPlayer:IsEverAlive() then
		--Special thanks to LastSword, from whose Zimbabwe civ I based this trade route code.
		local tTradeRoutes = {}
		for k, v in pairs(pPlayer:GetTradeRoutes()) do
			if v.FromCity:IsHasBuilding(iWentworths) then
				dprint("Adding a trade route FROM " ..v.FromCity:GetName())
				if tTradeRoutes[v.FromCity] == nil then
					tTradeRoutes[v.FromCity] = 1
				else
					tTradeRoutes[v.FromCity] = tTradeRoutes[v.FromCity] + 1
				end
			end
		end
		for k, v in pairs(pPlayer:GetTradeRoutesToYou()) do
			if v.ToCity:IsHasBuilding(iWentworths) then
				dprint("Adding a trade route TO " ..v.FromCity:GetName())
				if v.FromCity:GetOwner() ~= iPlayer then
					if tTradeRoutes[v.ToCity] == nil then
						tTradeRoutes[v.ToCity] = 1
					else
						tTradeRoutes[v.ToCity] = tTradeRoutes[v.ToCity] + 1
					end	
				end
			end
		end
		for pCity in Players[iPlayer]:Cities() do
			if tTradeRoutes[pCity] == nil then
				dprint("No trade routes in " ..pCity:GetName())
				for k, v in pairs(tWentworthsBuildings) do
					pCity:SetNumRealBuilding(v, 0)
				end
			else
				if tTradeRoutes[pCity] > 6 then
					dprint("Set level 4 Wentworth's dummy in " ..pCity:GetName())
					pCity:SetNumRealBuilding(tWentworthsBuildings[4], 1)
				else
					pCity:SetNumRealBuilding(tWentworthsBuildings[4], 0)
				end
				if tTradeRoutes[pCity] > 4 then
					dprint("Set level 3 Wentworth's dummy in " ..pCity:GetName())
					pCity:SetNumRealBuilding(tWentworthsBuildings[3], 1)
				else
					pCity:SetNumRealBuilding(tWentworthsBuildings[3], 0)
				end
				if tTradeRoutes[pCity] > 2 then
					dprint("Set level 2 Wentworth's dummy in " ..pCity:GetName())
					pCity:SetNumRealBuilding(tWentworthsBuildings[2], 1)
				else
					pCity:SetNumRealBuilding(tWentworthsBuildings[2], 0)
				end
				if tTradeRoutes[pCity] > 0 then
					dprint("Set level 1 Wentworth's dummy in " ..pCity:GetName())
					pCity:SetNumRealBuilding(tWentworthsBuildings[1], 1)
				else
					pCity:SetNumRealBuilding(tWentworthsBuildings[1], 0)
				end
			end
		end
	end
end

