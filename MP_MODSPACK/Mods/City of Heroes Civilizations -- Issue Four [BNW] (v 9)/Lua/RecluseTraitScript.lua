
--Cache all of Recluse's special great people and their unitclasses
local tRecluseGreatPeople = {
			[GameInfoTypes.PROMOTION_SCIENTIST_RECLUSE] = GameInfoTypes.UNIT_SCIENTIST_RECLUSE,
			[GameInfoTypes.PROMOTION_MERCHANT_RECLUSE] = GameInfoTypes.UNIT_MERCHANT_RECLUSE,
			[GameInfoTypes.PROMOTION_ENGINEER_RECLUSE] = GameInfoTypes.UNIT_ENGINEER_RECLUSE,
			[GameInfoTypes.PROMOTION_PROPHET_RECLUSE] = GameInfoTypes.UNIT_PROPHET_RECLUSE,
			[GameInfoTypes.PROMOTION_GREAT_GENERAL_RECLUSE] = GameInfoTypes.UNIT_GREAT_GENERAL_RECLUSE
	}
	
if bDebug == true then
	print("Promotion & GP-to-spawn table: ")
	for k, v in pairs(tRecluseGreatPeople) do
		print(k, v)
	end
end

--Cache all promotions given to the barbarian villain which keeps track of what Great Person to give Recluse when he defeats them.
local tRecluseDummyPromotions = {
			[GameInfoTypes.UNITCLASS_SCIENTIST] = GameInfoTypes.PROMOTION_SCIENTIST_RECLUSE,
			[GameInfoTypes.UNITCLASS_MERCHANT] = GameInfoTypes.PROMOTION_MERCHANT_RECLUSE,
			[GameInfoTypes.UNITCLASS_ENGINEER] = GameInfoTypes.PROMOTION_ENGINEER_RECLUSE,
			[GameInfoTypes.UNITCLASS_PROPHET] = GameInfoTypes.PROMOTION_PROPHET_RECLUSE,
			[GameInfoTypes.UNITCLASS_GREAT_GENERAL] = GameInfoTypes.PROMOTION_GREAT_GENERAL_RECLUSE
	}
	
if bDebug == true then
	print("UnitClass & Promotion table: ")
	for k, v in pairs(tRecluseDummyPromotions) do
		print(k, v)
	end
end

--Strength values per era for Villains. They should be quite powerful so that it is an actual drawback to the power of the UA instead of an annoyance!
local tRecluseVillainStrength = {
			[GameInfoTypes.ERA_CLASSICAL] = 28,
			[GameInfoTypes.ERA_MEDIEVAL] = 60,
			[GameInfoTypes.ERA_RENAISSANCE] = 85,
			[GameInfoTypes.ERA_INDUSTRIAL] = 150,
			[GameInfoTypes.ERA_MODERN] = 190,
			[GameInfoTypes.ERA_POSTMODERN] = 225,
			[GameInfoTypes.ERA_FUTURE] = 320 --!!
}

--If the unit doesn't actually have a replacement Unit type but is still replaced with a villain (Great Generals), this promotion will keep it from
--continuously spawning as a villain.
local iRecluseGenericDNKPromotion = GameInfoTypes.PROMOTION_RECLUSE_DONOTKILL_GREATPERSON

--Villain's unit type
local iVillain = GameInfoTypes.UNIT_RECLUSE_VILLAIN

function OnGPSpawn(iPlayer, iUnitID, iX, iY)
	dprint("Called OnGPSpawn")
	if iPlayer < GameDefines.MAX_MAJOR_CIVS and tTraits[iPlayer].GreatPeopleSpawnAsVillains == 1 and iX > 0 and iY > 0 then
		dprint("Player has Recluse trait")
		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iUnitID)
		if pUnit:IsGreatPerson() and not pUnit:IsHasPromotion(iRecluseGenericDNKPromotion) and not string.find(GameInfo.Units[pUnit:GetUnitType()].Type, "RECLUSE") then
			dprint("Unit is a GP without the DoNotKill promotion.")
			dprint("X location: " ..pUnit:GetX().. ", Y location: " ..pUnit:GetY())
			for k, v in pairs(tRecluseDummyPromotions) do
				if pUnit:GetUnitClassType() == k then
					dprint("GP should be replaced with a villain.")
					--This next bit of code handles free Great People from policies or buildings which provide specific Great People (like Warrior Code, Brandenburg Gate, Porcelain Tower, etc.).
					--These work by creating the GP and then moving it to a tile adjacent to your capital, which triggers this twice.
					--So, we're only going to make GPs that spawn on the inside of a City count, and if they don't spawn inside a City, just kill them off directly.
					--We'll add a check for this being a GP originally created by the player, though, in case the player captures a GP of some sort.
					--May conflict with the Patronage policy, but this will need to be tested.
					if not pUnit:GetPlot():IsCity() and pUnit:GetOriginalOwner() == iPlayer then
						pUnit:Kill(true)
						return
					end
					--Now, let's try to find a good spot for it to spawn!
					--First, we're gonna go through the plot the GP is on and every adjacent plot to see if there are any which contain no cities or other units.
					--This is the ideal place to spawn the Villain.
					--If there isn't one, though, we'll try to spawn it in the least destructive spot possible (to avoid automatic death of Civilian units).
					local pSpawnPlot;
					local pOriginalPlot = pUnit:GetPlot()
					--We'll keep a table of how acceptable a plot is to spawn on if it doesn't have perfect conditions (no cities or units).
					--Values used:
					--2: Contains only military units, pretty acceptable since it will just displace the units.
					--1: Contains civilian units, only acceptable as a last resort since it will kill the civilian unit.
					--0: Contains a city. NEVER spawn it in a city!
					local tPlotValidity = {}


					--Let's see if the plot it's already on is okay first.
					if not pOriginalPlot:IsCity() then
						local bThisPlotValid = true;
						--Iterate over units in this plot, if there are any units other than the GP itself then this shouldn't be considered valid for this first check
						for i = 0, pOriginalPlot:GetNumUnits() - 1 do
							local pPlotUnit = pOriginalPlot:GetUnit(i)
							if pPlotUnit ~= pUnit then
								bThisPlotValid = false
								if not pPlotUnit:IsCombatUnit() then
									tPlotValidity[pOriginalPlot] = 1
								end
							end
						end
						if bThisPlotValid == true then
							pSpawnPlot = pOriginalPlot
						elseif tPlotValidity[pOriginalPlot] == nil then
							tPlotValidity[pOriginalPlot] = 2
						end
					else
						tPlotValidity[pOriginalPlot] = 0
					end

					--If that didn't work, then let's try each adjacent plot.
					if not pSpawnPlot then
						local direction_types = {
							DirectionTypes.DIRECTION_NORTHEAST,
							DirectionTypes.DIRECTION_EAST,
							DirectionTypes.DIRECTION_SOUTHEAST,
							DirectionTypes.DIRECTION_SOUTHWEST,
							DirectionTypes.DIRECTION_WEST,
							DirectionTypes.DIRECTION_NORTHWEST
						}
						for a, direction in ipairs(direction_types) do
							local pNextPlot = Map.PlotDirection(pUnit:GetX(), pUnit:GetY(), direction)
							if pNextPlot ~= nil then
								if not pNextPlot:IsCity() then
									if pNextPlot:IsUnit() then
										for i = 0, pNextPlot:GetNumUnits() - 1 do
											local pPlotUnit = pNextPlot:GetUnit(i)
											if not pPlotUnit:IsCombatUnit() then
												tPlotValidity[pNextPlot] = 1
											end
										end
										if tPlotValidity[pNextPlot] == nil then
											tPlotValidity[pNextPlot] = 2
										end
									else
										pSpawnPlot = pNextPlot
										break
									end
								else
									tPlotValidity[pNextPlot] = 0
								end
							end
						end
					end

					--If THAT didn't work, then we'll refer to the table we've created.
					if not pSpawnPlot then
						local tBestPlots = {}
						for pPlot, iValidity in pairs(tPlotValidity) do
							if iValidity == 2 then
								table.insert(tBestPlots, pPlot)
							end
						end
						if #tBestPlots < 1 then
							for pPlot, iValidity in pairs(tPlotValidity) do
								if iValidity == 1 then
									table.insert(tBestPlots, pPlot)
								end
							end	
						end
						--Choose one of the best plots at random!
						if #tBestPlots > 0 then
							pSpawnPlot = tBestPlots[Game.Rand(#tBestPlots, "Villain Plot Randomizer")]
						end
					end

					--If even THAT didn't work...that basically means that there is a city in both the GP's tile and in every tile around it!
					--If something that crazy happened, then whatever -- spawn it in the same plot!
					if not pSpawnPlot then
						pSpawnPlot = pOriginalPlot
					end


					local iX = pSpawnPlot:GetX()
					local iY = pSpawnPlot:GetY()
					
					dprint("pSpawnPlot coordinates: " ..iX.. ", " ..iX)
					
					pUnit:Kill(true)
					pVillain = Players[63]:InitUnit(iVillain, iX, iY, UNITAI_ATTACK)
					pVillain:SetHasPromotion(v, true)
					if pVillain:GetPlot():IsWater() then
						pVillain:Embark()
					end
					--Increase strength and give additional promotions per era.
					if pPlayer:GetCurrentEra() > GameInfoTypes.ERA_ANCIENT then
						pVillain:SetBaseCombatStrength(tRecluseVillainStrength[pPlayer:GetCurrentEra()])
						if pPlayer:GetCurrentEra() >= GameInfoTypes.ERA_RENAISSANCE then
							pVillain:SetHasPromotion(GameInfoTypes.PROMOTION_MARCH, true)
						end
						if pPlayer:GetCurrentEra() >= GameInfoTypes.ERA_MODERN then
							pVillain:SetHasPromotion(GameInfoTypes.PROMOTION_BLITZ, true)
						end
					end
					pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, Locale.ConvertTextKey("TXT_KEY_RECLUSE_BARBARIAN_SPAWNED_TEXT"), Locale.ConvertTextKey("TXT_KEY_RECLUSE_BARBARIAN_SPAWNED_TITLE"), iX, iY)
					break
				end
			end
		end
	end
end



--Variables passed between CanSaveUnit and UnitKilledInCombat.
--Thanks to Pazyryk for his research into these functions!
local iGPTypeToSpawn;
local sGPName;

--This calls when a Barb is about to die. We'll find out if it's a villain and get its promotion to find out what to spawn if so.
function OnCanSaveUnit(iPlayer, iUnitID)
	dprint("Called OnCanSaveUnit")
	if iPlayer == 63 then
		local pBarb = Players[63]
		local pKilledUnit = pBarb:GetUnitByID(iUnitID)
		for k, v in pairs(tRecluseGreatPeople) do
			if pKilledUnit:IsHasPromotion(k) then
				iGPTypeToSpawn = v
				sGPName = Locale.ConvertTextKey(pKilledUnit:GetNameNoDesc())
				return
			end
		end
		iGPTypeToSpawn = nil;
		sGPName = nil;
	end
end



--This calls after the unit actually dies.
function OnUnitKilled(iKiller, iOwner, iUnitType)
	dprint("Called OnUnitKilled")
	if iGPTypeToSpawn then
		if iKiller < GameDefines.MAX_MAJOR_CIVS and tTraits[iKiller].GreatPeopleSpawnAsVillains == 1 and iOwner == 63 then
			if iUnitType == iVillain then
				local pPlayer = Players[iKiller]
				--Spawn the unit in the Capital.
				local iX = pPlayer:GetCapitalCity():GetX()
				local iY = pPlayer:GetCapitalCity():GetY()
				pNewUnit = pPlayer:InitUnit(iGPTypeToSpawn, iX, iY)
				pNewUnit:SetHasPromotion(iRecluseGenericDNKPromotion, true)
				pNewUnit:SetMoves(0)
				if sGPName ~= nil then
					pNewUnit:SetName(sGPName)
				end
				if iKiller == Game:GetActivePlayer() then
					Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_ALERT_RECLUSE_GP", Locale.ConvertTextKey(GameInfo.Units[pNewUnit:GetUnitType()].Description)))
				end
				iGPTypeToSpawn = nil;
				sGPName = nil;
			end
		end
	end
end

