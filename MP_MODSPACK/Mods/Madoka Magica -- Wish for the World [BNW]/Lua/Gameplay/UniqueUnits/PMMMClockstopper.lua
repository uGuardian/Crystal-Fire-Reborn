-- Clockstopper (aka Thief of Time)
-- Author: Vicevirtuoso
-- DateCreated: 6/14/2014 3:03:30 PM
--------------------------------------------------------------


include('PMMMGeneralFunctions.lua');


function Clockstopper(iCapturedPlayer, bCapital, iX, iY, iCapturingPlayer, bConquest)
	dprint("A city has been captured.")
	if iCapturedPlayer < iMaxCivs then
		dprint("Capturer is a major Civ.")
		local bIsSteal = false
		local pCapturingPlayer = Players[iCapturingPlayer]
		local pPlot = Map.GetPlot(iX, iY)
		local pUnit = pPlot:GetUnit(0)
		for k, v in pairs(MapModData.gPMMMStealUUPromotions) do
			if pUnit:IsHasPromotion(v) then
				bIsSteal = true
				break
			end
		end
		if bIsSteal then
			dprint("The unit used to capture the city has a promotion allowing it to steal a UU promotion.")
			local pCapturedPlayer = Players[iCapturedPlayer]
			local UniqueUnits = {}
			for row in GameInfo.Civilization_UnitClassOverrides() do
				if row.CivilizationType == GameInfo.Civilizations[pCapturedPlayer:GetCivilizationType()].Type then
					table.insert(UniqueUnits, GameInfo.Units("Type = '" ..row.UnitType.. "'")())
				end
			end
			if #UniqueUnits <= 0 then
				dprint("No Unique Units found. End function.")
				return
			end
			dprint("Contents of temp UniqueUnits table: ")
			for k, v in pairs(UniqueUnits) do
				dprint(k ..": ".. Locale.ConvertTextKey(v.Description))
			end
			local UniquePromotions = {}
			for k, v in pairs(UniqueUnits) do
				--Only steal from UUs with the same domain
				if pUnit:GetDomainType() == GameInfo.Domains("Type = '" ..v.Domain.. "'")().ID then
					--Do not steal from civilian units or Great People
					if not v.Special and v.Combat >= 0 then
						dprint("UniqueUnit being checked is not a Civilian or a Great Person.")
						--Only steal promotions which are not available to the base unit
						local pUnitClass = GameInfo.UnitClasses("Type = '" ..v.Class.. "'")()
						local pDefaultUnit = GameInfo.Units("Type = '" ..pUnitClass.DefaultUnit.. "'")()
						if pDefaultUnit then
							dprint("The unique unit belongs to the class " ..pUnitClass.Type.. ", and that class's default unit is the "..pDefaultUnit.Type)
						else
							dprint("The unique unit belongs to the class " ..pUnitClass.Type.. ", which has no default unit")
						end
						--Find stuff in the free promotions table for the UU. Then look to see if the default unit gets it. If not, add it to the table. 
						for row in GameInfo.Unit_FreePromotions() do
							if row.UnitType == v.Type then
								dprint("Testing promotion " ..row.PromotionType)
								bIsUniquePromotion = true
								if pDefaultUnit then
									for row2 in GameInfo.Unit_FreePromotions() do
										if row2.UnitType == pDefaultUnit.Type and row2.PromotionType == row.PromotionType then
											dprint("This promotion is available to the default unit. Dropping.")
											bIsUniquePromotion = false
											break
										end
									end
								end
								if bIsUniquePromotion then
									dprint("This promotion is unique to the UU. Adding to potential promotions.")
									local iPromotion = GameInfo.UnitPromotions("Type = '" ..row.PromotionType.. "'")().ID
									if not pUnit:IsHasPromotion(iPromotion) then
										table.insert(UniquePromotions, iPromotion)
									end
								end
							end		
						end
					end
				end
			end
			if #UniquePromotions > 0 then
				dprint("At least one Unique Promotion was found.")
				--Choose one at random
				iChosenPromotion = Game.Rand(#UniquePromotions, "Random Clockstopper Promotion") + 1
				pUnit:SetHasPromotion(UniquePromotions[iChosenPromotion], true)
				dprint("Chosen promotion type " ..GameInfo.UnitPromotions[UniquePromotions[iChosenPromotion]].Type)
				if iCapturingPlayer == Game:GetActivePlayer() then
					local sPromotionName = Locale.ConvertTextKey(GameInfo.UnitPromotions[UniquePromotions[iChosenPromotion]].Description)
					Events.GameplayAlertMessage(Locale.ConvertTextKey("TXT_KEY_ALERT_HOMURA_STOLEN_PROMOTION", pUnit:GetName(), sPromotionName))
				end
			end
		end
	end
end

