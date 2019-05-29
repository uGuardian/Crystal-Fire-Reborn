-- Ocelot's Trait Script
-- Author: Vicevirtuoso
-- DateCreated: 10/6/2013 12:31:28 AM
--------------------------------------------------------------

local iPMCInc = GameInfoTypes.UNIT_PMC_INCORPORATOR
local iOuterHeaven = GameInfoTypes.CIVILIZATION_OUTER_HEAVEN

function CollectiveRuleGivePMCInc(iPlayer, iPolicyID)
	local pPlayer = Players[iPlayer];
	if (pPlayer:IsEverAlive()) then
		if (pPlayer:GetCivilizationType() == iOuterHeaven) then
			if (iPolicyID == GameInfoTypes.POLICY_COLLECTIVE_RULE) then
				for pUnit in pPlayer:Units() do
					if (pUnit:GetUnitType() == GameInfoTypes.UNIT_SETTLER) then
						local pPlotX = pUnit:GetPlot():GetX()
						local pPlotY = pUnit:GetPlot():GetY()
						pUnit:Kill();
						local pNewUnit = pPlayer:InitUnit(iPMCInc, pPlotX, pPlotY, UNITAI_SETTLE)
					end
				end
			end
		end
	end
end

function RemovePMCIncGeneralBonus(iPlayer, iUnitID, iX, iY)
	if iX > 0 and iY > 0 then
		local pPlayer = Players[iPlayer];
		local pUnit = pPlayer:GetUnitByID(iUnitID);
		if (pUnit:GetUnitType() == GameInfoTypes.UNIT_PMC_INCORPORATOR) then
			pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_GREAT_GENERAL, false)
		end
	end
end

--Variable called between functions to trigger PMC Incorporator ability
local bCityJustFounded = false


function OnCityFounded()
	bCityJustFounded = true
end

function NewOcelotCity(iPlayer, iUnit)
	if bCityJustFounded then
		local pPlayer = Players[iPlayer];
		if pPlayer:IsAlive() then
			local pUnit = pPlayer:GetUnitByID(iUnit)
			if pUnit and pUnit:GetUnitType() == iPMCInc then
				local pCity = Map.GetPlot(pUnit:GetX(), pUnit:GetY()):GetPlotCity()
				if (pCity:GetOriginalOwner() == iPlayer and pCity:GetGameTurnFounded() == Game:GetGameTurn()) then
					if pPlayer:GetCivilizationType() == iOuterHeaven then
						local iFoundedPMCs = 0;
						for iLPlayer, pLPlayer in pairs(Players) do
							for pLCity in pLPlayer:Cities() do
								if (pLCity:IsHasBuilding(GameInfoTypes.BUILDING_WEREWOLF_PMC)) then
									iFoundedPMCs = 4;
									break
								elseif (pLCity:IsHasBuilding(GameInfoTypes.BUILDING_RAVEN_SWORD_PMC) and iFoundedPMCs < 4) then
									iFoundedPMCs = 3;
								elseif (pLCity:IsHasBuilding(GameInfoTypes.BUILDING_PIEUVRE_ARMEMENT_PMC) and iFoundedPMCs < 3) then
									iFoundedPMCs = 2;
								elseif (pLCity:IsHasBuilding(GameInfoTypes.BUILDING_PRAYING_MANTIS_PMC) and iFoundedPMCs < 2) then
									iFoundedPMCs = 1;
								end
							end
						end
						if (iFoundedPMCs == 3) then
							pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_WEREWOLF_PMC, 1)
						elseif (iFoundedPMCs == 2) then
							pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_RAVEN_SWORD_PMC, 1)
						elseif (iFoundedPMCs == 1) then
							pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_PIEUVRE_ARMEMENT_PMC, 1)
						elseif (iFoundedPMCs == 0) then
							pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_PRAYING_MANTIS_PMC, 1)
						end
					end
					pCity:ChangePopulation(2, true)
					pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_OCELOT_FREE_BARRACKS, 1)
					pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_OCELOT_FREE_WORKSHOP, 1)
					if not pCity:IsCapital() and not string.find(pCity:GetName(), " PMC") then
						pCity:SetName(pCity:GetName().." PMC")
					end
				end
			end
		end
	end
	bCityJustFounded = false		
end

function GoldenAgeOcelotPromotion(iPlayer)
	local pPlayer = Players[iPlayer];
	if pPlayer:IsEverAlive() then
		if (pPlayer:GetCivilizationType() == iOuterHeaven) then
			if pPlayer:IsGoldenAge() then
				for pUnit in pPlayer:Units() do
					if (pUnit:IsCombatUnit() and pUnit:GetDomainType() == GameInfoTypes.DOMAIN_LAND) then
						pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_OCELOT_GOLDEN_AGE, true)
					end
				end
			else
				for pUnit in pPlayer:Units() do
					if (pUnit:IsCombatUnit() and pUnit:GetDomainType() == GameInfoTypes.DOMAIN_LAND) then
						pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_OCELOT_GOLDEN_AGE, false)
					end
				end
			end
		end
	end
end

function GoldenAgeOcelotPromotionOnMove(iPlayer, iUnitID)
	local pPlayer = Players[iPlayer];
	if pPlayer:IsEverAlive() then
		if (pPlayer:GetCivilizationType() == iOuterHeaven) then
			if pPlayer:IsGoldenAge() then
				local pUnit = pPlayer:GetUnitByID(iUnitID);
				if (pUnit:IsCombatUnit() and pUnit:GetDomainType() == GameInfoTypes.DOMAIN_LAND) then
					pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_OCELOT_GOLDEN_AGE, true)
				end
			end
		end
	end
end

function TestOcelotEnemyDebuff(iPlayer, iUnitID, iX, iY)
	local pPlayer = Players[iPlayer];
	local pUnit = pPlayer:GetUnitByID(iUnitID);
	if (iX > 0 and iY > 0) then
		if (pUnit:IsHasPromotion(GameInfoTypes.PROMOTION_LAUGHING_AMMO) or pUnit:IsHasPromotion(GameInfoTypes.PROMOTION_RAGING_AMMO) or pUnit:IsHasPromotion(GameInfoTypes.PROMOTION_CRYING_AMMO)) then
			--print("Unit with Ammo promotion moved")
			for iCheckID, pOtherPlayer in pairs(Players) do
				if (pPlayer ~= pOtherPlayer) then
					if (Teams[pPlayer:GetTeam()]:IsAtWar(pOtherPlayer:GetTeam())) then
						for pEnemyUnit in pOtherPlayer:Units() do
							local bIsLaughing = CheckUnitForAmmoDebuff(pPlayer, pOtherPlayer, pEnemyUnit, GameInfoTypes.PROMOTION_LAUGHING_AMMO)
							local bIsRaging = CheckUnitForAmmoDebuff(pPlayer, pOtherPlayer, pEnemyUnit, GameInfoTypes.PROMOTION_RAGING_AMMO)
							local bIsCrying = CheckUnitForAmmoDebuff(pPlayer, pOtherPlayer, pEnemyUnit, GameInfoTypes.PROMOTION_CRYING_AMMO)
							if (bIsLaughing == false) then
								--print("No Laughing ammo near")
								pEnemyUnit:SetHasPromotion(GameInfoTypes.PROMOTION_LAUGHING_AMMO_DEBUFF, false)
							else
								--print("Laughing ammo near")
								pEnemyUnit:SetHasPromotion(GameInfoTypes.PROMOTION_LAUGHING_AMMO_DEBUFF, true)
							end
							if (bIsRaging == false) then
								--print("No Raging ammo near")
								pEnemyUnit:SetHasPromotion(GameInfoTypes.PROMOTION_RAGING_AMMO_DEBUFF, false)
							else
								--print("Raging ammo near")
								pEnemyUnit:SetHasPromotion(GameInfoTypes.PROMOTION_RAGING_AMMO_DEBUFF, true)
							end
							if (bIsCrying == false) then
								--print("No Crying ammo near")
								pEnemyUnit:SetHasPromotion(GameInfoTypes.PROMOTION_CRYING_AMMO_DEBUFF, false)
							else
								--print("Crying ammo near")
								pEnemyUnit:SetHasPromotion(GameInfoTypes.PROMOTION_CRYING_AMMO_DEBUFF, true)
							end
						end
					end
				end
			end
		else
			for iCheckID, pOtherPlayer in pairs(Players) do
				if (pOtherPlayer ~= pPlayer) then
					if (pOtherPlayer:GetCivilizationType() == iOuterHeaven and Teams[pOtherPlayer:GetTeam()]:IsAtWar(pPlayer:GetTeam())) then
						--print("Unit from civ at war with Ocelot moved")
						local bIsLaughing = CheckUnitForAmmoDebuff(pOtherPlayer, pPlayer, pUnit, GameInfoTypes.PROMOTION_LAUGHING_AMMO)
						local bIsRaging = CheckUnitForAmmoDebuff(pOtherPlayer, pPlayer, pUnit, GameInfoTypes.PROMOTION_RAGING_AMMO)
						local bIsCrying = CheckUnitForAmmoDebuff(pOtherPlayer, pPlayer, pUnit, GameInfoTypes.PROMOTION_CRYING_AMMO)
						if (bIsLaughing == false) then
							--print("No Laughing ammo near")
							pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_LAUGHING_AMMO_DEBUFF, false)
						else
							--print("Laughing ammo near")
							pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_LAUGHING_AMMO_DEBUFF, true)
						end
						if (bIsRaging == false) then
							--print("No Raging ammo near")
							pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_RAGING_AMMO_DEBUFF, false)
						else
							--print("Raging ammo near")
							pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_RAGING_AMMO_DEBUFF, true)
						end
						if (bIsCrying == false) then
							--print("No Crying ammo near")
							pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_CRYING_AMMO_DEBUFF, false)
						else
							--print("Crying ammo near")
							pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_CRYING_AMMO_DEBUFF, true)
						end
					end
				end
			end
		end		
	end
end

function CryingUnitDamage(iPlayer)
	for pUnit in Players[iPlayer]:Units() do
		if pUnit:IsHasPromotion(GameInfoTypes.PROMOTION_CRYING_AMMO_DEBUFF) then
			--print("Unit with Crying Ammo promotion found, dealing 5 Damage")
			pUnit:ChangeDamage(5, iPlayer);
		end
	end
end

function CheckWorldWarsForOcelot(iPlayer)
	local pPlayer = Players[iPlayer];
	if pPlayer:IsEverAlive() then
		if (pPlayer:GetCivilizationType() == iOuterHeaven and pPlayer:IsGoldenAge() == false) then
			local iTotalGoldenAgeBoost = 0;
			local sNotificationString = "";
			for iLoopPlayer1 = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
				local pLoopPlayer1 = Players[iLoopPlayer1]
				if (pLoopPlayer1:IsAlive() and iLoopPlayer1 ~= 63 and pLoopPlayer1:IsMinorCiv() == false) then
					--print("Testing war status of " ..pLoopPlayer1:GetCivilizationShortDescription())
					for iLoopPlayer2 = iLoopPlayer1 + 1, GameDefines.MAX_MAJOR_CIVS-1, 1 do
						local pLoopPlayer2 = Players[iLoopPlayer2]
						if (pLoopPlayer2:IsAlive() and iLoopPlayer2 ~= 63 and pLoopPlayer2:IsMinorCiv() == false) then
							if (pLoopPlayer1 ~= pLoopPlayer2) then
								--print("Comparing war status of "..pLoopPlayer1:GetCivilizationShortDescription().." with "..pLoopPlayer2:GetCivilizationShortDescription())
								if (Teams[pPlayer:GetTeam()]:IsHasMet(pLoopPlayer1:GetTeam()) and Teams[pPlayer:GetTeam()]:IsHasMet(pLoopPlayer2:GetTeam())) then
									if (Teams[pLoopPlayer1:GetTeam()]:IsAtWar(pLoopPlayer2:GetTeam())) then
										--print("The two civs are at war.")
										local iGoldenAgeThisWar = 0;
										if (Map.GetWorldSize() == GameInfoTypes.WORLDSIZE_DUEL) then
											iGoldenAgeThisWar = 30;
										elseif (Map.GetWorldSize() == GameInfoTypes.WORLDSIZE_TINY) then
											iGoldenAgeThisWar = 25
										elseif (Map.GetWorldSize() == GameInfoTypes.WORLDSIZE_SMALL) then
											iGoldenAgeThisWar = 20
										elseif (Map.GetWorldSize() == GameInfoTypes.WORLDSIZE_STANDARD) then
											iGoldenAgeThisWar = 15
										elseif (Map.GetWorldSize() == GameInfoTypes.WORLDSIZE_LARGE) then
											iGoldenAgeThisWar = 10
										elseif (Map.GetWorldSize() == GameInfoTypes.WORLDSIZE_HUGE) then
											iGoldenAgeThisWar = 5
										end
										iTotalGoldenAgeBoost = iTotalGoldenAgeBoost + iGoldenAgeThisWar;
										if (pLoopPlayer1 == pPlayer) then
											sNotificationString = sNotificationString .. "[NEWLINE][COLOR_WARNING_TEXT]YOU[ENDCOLOR]" .. " vs. " .. pLoopPlayer2:GetCivilizationShortDescription();
										elseif (pLoopPlayer2 == pPlayer) then
											sNotificationString = sNotificationString .. "[NEWLINE]" .. pLoopPlayer1:GetCivilizationShortDescription() .. " vs. " .. "[COLOR_WARNING_TEXT]YOU[ENDCOLOR]";
										else
											sNotificationString = sNotificationString .. "[NEWLINE]" .. pLoopPlayer1:GetCivilizationShortDescription() .. " vs. " .. pLoopPlayer2:GetCivilizationShortDescription();
										end
									else
										--print("The two civs are not at war.")
									end
								end
							end
						end
					end
				end
			end
			if (iTotalGoldenAgeBoost > 0) then
				sNotificationString = Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_OCELOT_WAR_UPDATE_TEXT", iTotalGoldenAgeBoost) .. sNotificationString
				sNotificationTitle = Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_OCELOT_WAR_UPDATE_TITLE")
				pPlayer:ChangeGoldenAgeProgressMeter(iTotalGoldenAgeBoost)
				pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GOLDEN_AGE_ENDED_ACTIVE_PLAYER, sNotificationString, sNotificationTitle, -1, -1)
			end
		end
	end
end

						
function CheckUnitForAmmoDebuff(pPlayer, pOtherPlayer, pEnemyUnit, sPromotionType)
	local direction_types = {
		DirectionTypes.DIRECTION_NORTHEAST,
		DirectionTypes.DIRECTION_EAST,
		DirectionTypes.DIRECTION_SOUTHEAST,
		DirectionTypes.DIRECTION_SOUTHWEST,
		DirectionTypes.DIRECTION_WEST,
		DirectionTypes.DIRECTION_NORTHWEST
		}
	for a, direction in ipairs(direction_types) do
		local nextPlot = Map.PlotDirection(pEnemyUnit:GetX(), pEnemyUnit:GetY(), direction)
		--print("Test direction: "..direction)
		if (nextPlot ~= nil) then
			if (nextPlot:IsUnit()) then
				--print("Unit in plot in direction" ..direction)
				for i = 0, nextPlot:GetNumUnits() do
					local pAmmoUnit = nextPlot:GetUnit(i);
					if (pAmmoUnit ~= nil) then
						if (Players[pAmmoUnit:GetOwner()] == pPlayer and pAmmoUnit:IsHasPromotion(sPromotionType)) then
							--print("Nearby unit has an ammo promotion")
							return true
						end
					end
				end
			end
		end
	end
	return false;
end


GameEvents.UnitSetXY.Add(TestOcelotEnemyDebuff)
GameEvents.UnitSetXY.Add(GoldenAgeOcelotPromotionOnMove)
GameEvents.UnitSetXY.Add(RemovePMCIncGeneralBonus)
GameEvents.PlayerAdoptPolicy.Add(CollectiveRuleGivePMCInc)
GameEvents.PlayerCityFounded.Add(OnCityFounded)
GameEvents.CanSaveUnit.Add(NewOcelotCity)
GameEvents.PlayerDoTurn.Add(GoldenAgeOcelotPromotion)
GameEvents.PlayerDoTurn.Add(CryingUnitDamage)
GameEvents.PlayerDoTurn.Add(CheckWorldWarsForOcelot)