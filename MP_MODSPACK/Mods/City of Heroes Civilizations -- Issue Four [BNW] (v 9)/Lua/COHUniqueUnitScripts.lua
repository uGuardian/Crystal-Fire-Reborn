-- COHUniqueUnitScripts
-- Author: Vicevirtuoso
-- DateCreated: 10/4/2014 2:40:31 PM
--------------------------------------------------------------


local iLongbowPromotion = GameInfoTypes.PROMOTION_LONGBOW_RIFLEMAN
local iNemesisPromotion = GameInfoTypes.PROMOTION_ARMIGER_SURGEON

local tHTFPromotions = {}

for promotion in GameInfo.UnitPromotions() do
	if promotion.AdjacentDamageWhenKilled > 0 then
		tHTFPromotions[promotion.ID] = promotion.AdjacentDamageWhenKilled
	end
end

--Longbow Rifleman: Bonus per every Civ denouncing an enemy
function LongbowRiflemanBonus(iPlayer, iUnitID)
	local pPlayer = Players[iPlayer]
	if iPlayer < GameDefines.MAX_MAJOR_CIVS and pPlayer:IsEverAlive() then
		local pUnit = pPlayer:GetUnitByID(iUnitID)
		if pUnit:IsHasPromotion(iLongbowPromotion) then
			local iDenouncements = 0
			local iOwner = pUnit:GetPlot():GetOwner()
			local pOwner = Players[iOwner]
			if iOwner ~= iPlayer and iOwner < GameDefines.MAX_MAJOR_CIVS - 1 and iOwner > -1 then
				if Teams[pOwner:GetTeam()]:IsAtWar(pPlayer:GetTeam()) then
					for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
						if iOwner ~= i then
							local pLoopPlayer = Players[i]
							if pLoopPlayer:IsDenouncedPlayer(iOwner) then
								iDenouncements = iDenouncements + 1
							end
						end
					end
				end
				pUnit:SetBaseCombatStrength(GameInfo.Units[pUnit:GetUnitType()].Combat + (iDenouncements * 3))
			else
				pUnit:SetBaseCombatStrength(GameInfo.Units[pUnit:GetUnitType()].Combat)
			end
		end
	end
end



--Refresh denunciations and Longbow Riflemen strength on each turn
function DenouncementUpkeep(iPlayer)
	local pPlayer = Players[iPlayer]
	if iPlayer < GameDefines.MAX_MAJOR_CIVS and pPlayer:IsEverAlive() then
		for pUnit in pPlayer:Units() do
			local iUnit = pUnit:GetID()
			LongbowRiflemanBonus(iPlayer, iUnit)
		end
	end
end



--Variables stored between the following two functions.
local iHTFDamageToDeal = 0;
local pHTFPlot;


--When a unit dies, find out if it had promotions which damage adjacent units on death.
function OnCanSaveUnitTheHarderTheyFall(iPlayer, iUnitID)
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnitID)
	for iPromotionID, iDamageThisPromotion in pairs(tHTFPromotions) do
		if pUnit:IsHasPromotion(iPromotionID) then
			iHTFDamageToDeal = iHTFDamageToDeal + iDamageThisPromotion
		end
	end
	if iHTFDamageToDeal > 0 then
		pHTFPlot = pUnit:GetPlot()
	end
	dprint("Damage to deal: " ..iHTFDamageToDeal)
end




--Now we make the unit actually do the damage. Only works if the above function gave proper values to the variables.
function TheHarderTheyFall(iKiller, iPlayer, iUnitType)
	if iHTFDamageToDeal > 0 and pHTFPlot then
		local pPlayer = Players[iPlayer]
		for i = 0, pHTFPlot:GetNumUnits() - 1 do
			local pUnit = pHTFPlot:GetUnit(i)
			local pEnemyUnitOwner = Players[pUnit:GetOwner()]
			if Teams[pEnemyUnitOwner:GetTeam()]:IsAtWar(pPlayer:GetTeam()) then
				pUnit:ChangeDamage(iHTFDamageToDeal, iKiller)
				if pUnit:GetOwner() == Game:GetActivePlayer() then
					Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_ALERT_HTF_DAMAGE", Locale.ConvertTextKey(GameInfo.Units[iUnitType].Description), iHTFDamageToDeal, pUnit:GetName()))
				end
			end
		end
		local direction_types = {
			DirectionTypes.DIRECTION_NORTHEAST,
			DirectionTypes.DIRECTION_EAST,
			DirectionTypes.DIRECTION_SOUTHEAST,
			DirectionTypes.DIRECTION_SOUTHWEST,
			DirectionTypes.DIRECTION_WEST,
			DirectionTypes.DIRECTION_NORTHWEST
		}
		for a, direction in ipairs(direction_types) do
			local pNextPlot = Map.PlotDirection(pHTFPlot:GetX(), pHTFPlot:GetY(), direction)
			if pNextPlot ~= nil then
				if pNextPlot:IsUnit() then
					for i = 0, pNextPlot:GetNumUnits() - 1 do
						local pUnit = pNextPlot:GetUnit(i)
						local pEnemyUnitOwner = Players[pUnit:GetOwner()]
						if Teams[pEnemyUnitOwner:GetTeam()]:IsAtWar(pPlayer:GetTeam()) then
							pUnit:ChangeDamage(iHTFDamageToDeal, iKiller)
							if pUnit:GetOwner() == Game:GetActivePlayer() then
								Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_ALERT_HTF_DAMAGE", Locale.ConvertTextKey(GameInfo.Units[iUnitType].Description), iHTFDamageToDeal, pUnit:GetName()))
							end
						end
					end
				end
			end
		end
	end
	iHTFDamageToDeal = 0
	pHTFPlot = nil
end


function NemesisTriage(iPlayer)
	if iPlayer < GameDefines.MAX_MAJOR_CIVS then
		local pPlayer = Players[iPlayer]
		local tHealedUnits = {}
		for pUnit in pPlayer:Units() do
			if pUnit:IsHasPromotion(iNemesisPromotion) then
				local iFortTurns = math.min(10, pUnit:GetFortifyTurns())
				for pPlot in PlotAreaSpiralIterator(pUnit:GetPlot(), 1) do
					if pPlot:IsUnit() then
						for c = 0, pPlot:GetNumUnits() -1 do
							local pPlotUnit = pPlot:GetUnit(c)
							if pPlotUnit and pPlotUnit:GetOwner() == iPlayer and pPlotUnit:GetDamage() > 0 then
								if tHealedUnits[pPlotUnit] then
									if iFortTurns > tHealedUnits[pPlotUnit] then
										tHealedUnits[pPlotUnit] = iFortTurns
									end
								else
									tHealedUnits[pPlotUnit] = iFortTurns
								end
							end
						end
					end
				end
			end
		end
		for unit, value in pairs(tHealedUnits) do
			unit:ChangeDamage(math.max(unit:GetDamage() * -1, -value))
		end
	end
end