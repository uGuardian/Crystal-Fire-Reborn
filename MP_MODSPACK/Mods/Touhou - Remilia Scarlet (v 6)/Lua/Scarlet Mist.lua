--Scarlet Mist trait
function ScarletMist(iPlayer)
	local pPlayer = Players[iPlayer]
	
	--If the player is Scarlet
	if pPlayer:GetCivilizationType() == GameInfo.Civilizations["CIVILIZATION_SCARLET"].ID then
		
		--for every unit
		for unit in pPlayer:Units() do
			
			--if the unit can acquire promotions
			if unit:CanAcquirePromotionAny() then
				local pPlot = unit:GetPlot()
				
				--if the plot is owned by any player
				if pPlot:GetOwner() > -1 then
					local pPlotOwner = Players[pPlot:GetOwner()]
					
					--if the unit is in owned territory, and under level 4
					if pPlotOwner == pPlayer and unit:GetLevel() < 4 then

						--gain 1 XP
						unit:ChangeExperience(1, -1, 0, 1, 1)
					end
				end
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(ScarletMist)