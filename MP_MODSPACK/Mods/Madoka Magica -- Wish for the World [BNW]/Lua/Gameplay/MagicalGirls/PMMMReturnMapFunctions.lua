-- PMMMReturnMapFunctions
-- Author: Vicevirtuoso
-- DateCreated: 8/7/2014 4:20:55 PM
--------------------------------------------------------------



--File for defining functions which happen when MGs return to the map from a clickable mission which removes them from play temporarily.
--These are set up to be easily added in by other mods which reference this one.



if not MapModData.gPMMMOnMGReturnMapFunctions then
	MapModData.gPMMMOnMGReturnMapFunctions = {}
end



--Witch Hunt
local iWitchHunt = GameInfoTypes.MGACTIONSTATE_WITCH_HUNT

MapModData.gPMMMOnMGReturnMapFunctions[iWitchHunt] =
function (iMGKey)
	local iX = 	MagicalGirls[iMGKey].PositionX
	local iY = 	MagicalGirls[iMGKey].PositionY
	local iSpecialID = GetUnitSpecialID(iX, iY)
	local pPlot = Map.GetPlot(iX, iY)
	
	local iPlayer = MagicalGirls[iMGKey].Owner
	local pPlayer = Players[iPlayer]

	local sText;
	local sTitle;
	--iBestResult is 2 if a Barrier was uncovered, 1 if a Barrier was not uncovered but with strong reaction, and 0 if nowhere near one.
	--Determines which Notification to send.
	local iBestResult = 0;
	
	for k, v in pairs(PMMM.HiddenWitchPlots) do
		local pTestPlot = ReturnPlotFromSpecialID(k)
		local iTestX = pTestPlot:GetX()
		local iTestY = pTestPlot:GetY()
		local iDistance = Map.PlotDistance(iX, iY, iTestX, iTestY)
		if iDistance <= GameDefines.HIDDEN_WITCH_FINDABLE_RADIUS then
			local iCurrentEra = Game:GetCurrentEra()
			local pCityPlot = ReturnPlotFromSpecialID(v)
			local pCity = pCityPlot:GetPlotCity()
			local iOwner;
			if pCity then
				 iOwner = pCity:GetOwner()
			else
				iOwner = -1
			end
			--The MG hunted within the findable distance, so now spawn the Witch and update the tables accordingly.
			local pBarbarians = Players[GameDefines.MAX_CIV_PLAYERS]
			local pWitch = pBarbarians:InitUnit(GameInfoTypes.UNIT_PMMM_WITCH, iTestX, iTestY, UNITAI_ATTACK)
			pWitch:SetBaseCombatStrength(MapModData.gPMMMWitchEraStrengths[iCurrentEra])

			local iNumFamiliars = GameDefines.HIDDEN_WITCH_EXTRA_FAMILIARS
			if Game.IsOption(GameOptionTypes.GAMEOPTION_RAGING_BARBARIANS) then
				iNumFamiliars = iNumFamiliars + GameDefines.HIDDEN_WITCH_EXTRA_FAMILIARS_RAGING_BARBS
			end

			if iNumFamiliars > 0 then
				for i = 1, iNumFamiliars, 1 do
					local pFamiliar = pBarbarians:InitUnit(GameInfoTypes.UNIT_PMMM_FAMILIAR, iTestX, iTestY, UNITAI_ATTACK)
					pFamiliar:SetBaseCombatStrength(MapModData.gPMMMFamiliarEraStrengths[iCurrentEra])
					pFamiliar:JumpToNearestValidPlot()
				end
			end
						
			--Handle stuff based on owner of the City near it
			--Other Majors: Slight diplo penalty
			if iOwner ~= iPlayer and iOwner < GameDefines.MAX_MAJOR_CIVS and iOwner > -1 then
				if not PMMM.WitchHuntDiploPenalties[iPlayer] then
					PMMM.WitchHuntDiploPenalties[iPlayer] = {}
				end
				if not PMMM.WitchHuntDiploPenalties[iPlayer][iOwner] then
					PMMM.WitchHuntDiploPenalties[iPlayer][iOwner] = GameDefines.DIPLO_PENALTY_PER_HIDDEN_WITCH_UNCOVERED_FROM_MAJOR
				else
					PMMM.WitchHuntDiploPenalties[iPlayer][iOwner] = PMMM.WitchHuntDiploPenalties[iPlayer][iOwner] + GameDefines.DIPLO_PENALTY_PER_HIDDEN_WITCH_UNCOVERED_FROM_MAJOR
				end
			--Minors: Slight influence boost
			elseif iOwner ~= iPlayer and iOwner < GameDefines.MAX_CIV_PLAYERS and iOwner >= GameDefines.MAX_MAJOR_CIVS then
				local pOwner = Players[iOwner]
				pOwner:ChangeMinorCivFriendshipWithMajor(iPlayer, GameDefines.INFLUENCE_BONUS_PER_HIDDEN_WITCH_UNCOVERED_FROM_MINOR)
			end

			PMMM.CurrentHiddenWitches[iPlayer] = math.max((PMMM.CurrentHiddenWitches[iPlayer] - 1), 0)
			PMMM.HiddenWitchCities[v] = nil
			PMMM.HiddenWitchPlots[k] = nil

			sText = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_HIDDEN_WITCH_UNVEILED_TEXT", Locale.ConvertTextKey(MagicalGirls[iMGKey].Name))
			sTitle =  Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_HIDDEN_WITCH_UNVEILED_TITLE")
			pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, sText, sTitle, iTestX, iTestY)

			iBestResult = 2
			return
			
		elseif iDistance <= GameDefines.HIDDEN_WITCH_RESPONSE_RADIUS then
			--The MG hunted within the response distance, so give it a "strong" response to alert the player that they're getting warmer
	
			if iBestResult < 1 then
				sText = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_HIDDEN_WITCH_NOT_FOUND_STRONG_RESPONSE_TEXT", Locale.ConvertTextKey(MagicalGirls[iMGKey].Name))
				sTitle =  Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_HIDDEN_WITCH_NOT_FOUND_STRONG_RESPONSE_TITLE")
				iBestResult = 1
			end

		else
			--The MG was not within the findable or response distance, so give a "weak" response.
			if iBestResult < 1 then
				sText = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_HIDDEN_WITCH_NOT_FOUND_WEAK_RESPONSE_TEXT", Locale.ConvertTextKey(MagicalGirls[iMGKey].Name))
				sTitle =  Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_HIDDEN_WITCH_NOT_FOUND_WEAK_RESPONSE_TITLE")
			end			
		end

	end
	if iBestResult < 2 then
		pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, sText, sTitle, MagicalGirls[iMGKey].PositionX, MagicalGirls[iMGKey].PositionY)
	end
end


--Vacation
local iVacation = GameInfoTypes.MGACTIONSTATE_VACATIONING

MapModData.gPMMMOnMGReturnMapFunctions[iVacation] = 
function (iMGKey)
	local iPlayer = MagicalGirls[iMGKey].Owner
	local pPlayer = Players[iPlayer]
	--The vacation effectiveness is determined by the AVERAGE Entertainment throughout her vacation,
	--so we add up all of the Entertainment values for each turn she was gone and average them.
	local iVacationDestination = MagicalGirls[iMGKey].CurrentVacationLocation
	local pVacationDestination = Players[iVacationDestination]
	local sPlaceVacationedToName = pVacationDestination:GetCivilizationShortDescription()
	local iVacationAmount = 0
	local iNumVacationTurns = #MagicalGirls[iMGKey].VacationTurnTable
	for k, v in pairs(MagicalGirls[iMGKey].VacationTurnTable) do
		iVacationAmount = iVacationAmount + v
	end
	iVacationAmount = math.floor(iVacationAmount / iNumVacationTurns)

	local iTotalMoodPerEnt = GameInfo.MG_MoodModifiers["MGMOODMOD_VACATION"].Value
	local iMoodBoost = iVacationAmount * iTotalMoodPerEnt
	
	MagicalGirls[iMGKey].VacationBonus = iVacationAmount
	MagicalGirls[iMGKey].LastVacationTurn = Game:GetGameTurn()

	--Influence
	local MagicalGirls[iMGKey].Influence[iVacationDestination]
	if not MagicalGirls[iMGKey].Influence[iVacationDestination] then MagicalGirls[iMGKey].Influence[iVacationDestination] = 0 end
	if iVacationDestination ~= iPlayer then
		MagicalGirls[iMGKey].Influence[iVacationDestination] = MagicalGirls[iMGKey].Influence[iVacationDestination] + iVacationAmount 
	end
	
	--Boost of 25 Loyalty if she vacationed in her owner's territory.
	if iVacationDestination == iPlayer then
		MagicalGirls[iMGKey].Loyalty = math.min(MagicalGirls[iMGKey].Loyalty + 25, GameDefines.MAXIMUM_MG_LOYALTY)
	--Penalty of 25 Loyalty if she vacationed outside of her owner's territory, and they had more Entertainment.
	elseif GetEmpireEntertainment(pPlayer) < GetEmpireEntertainment(pVacationDestination) then
		MagicalGirls[iMGKey].Loyalty = math.max(MagicalGirls[iMGKey].Loyalty - 25, GameDefines.MAXIMUM_MG_LOYALTY)
	end
	

	

	--Notification Text
	local sText = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_RETURNED_FROM_VACATION_TEXT", Locale.ConvertTextKey(MagicalGirls[iMGKey].Name), sPlaceVacationedToName, iMoodBoost)
	local sTitle =  Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_RETURNED_FROM_VACATION_TITLE")
	local sTheirText = ""
	local sTheirTitle = ""
	if iPlayer ~= iVacationDestination then
		sTheirText = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_ENEMY_MG_ENDED_VACATION_TEXT", Locale.ConvertTextKey(MagicalGirls[iMGKey].Name), pPlayer:GetCivilizationShortDescription(), iMoodBoost)
		sTheirTitle = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_ENEMY_MG_ENDED_VACATION_TITLE")
	end

	--Demon Homura steals one of their Promotions and gets a half-Subjugation for it
	if MapModData.gPMMMTraits[iVacationDestination].CapitalBonusPerKilledMagicalGirl > 0 then
		local bAnyPromotionToSteal = false
		local tPromoTable = {}
		local tTableKeys = {}
		for k, v in pairs(MagicalGirls[iMGKey].Promotions) do
			if GameInfo.UnitPromotions[v].PediaType == "PEDIA_MAGICALGIRL" then
				tPromoTable[v] = 10
				tTableKeys[v] = k
				bAnyPromotionToSteal = true
			end
		end
		if bAnyPromotionToSteal then
			local iPromoToRemove = DeckShuffle(tPromoTable, "PMMM Demon Homura Vacation Promotion Removal")
			if iPromoToRemove then
				table.remove(MagicalGirls[iMGKey].Promotions, tTableKeys[iPromoToRemove])
				if not PMMM.Subjugations[iVacationDestination] then
					PMMM.Subjugations[iVacationDestination] = 0.5
				else
					PMMM.Subjugations[iVacationDestination] = PMMM.Subjugations[iVacationDestination] + 0.5
				end
				LuaEvents.PMMMSetNumDemonHomuraBuildings(iVacationDestination)
				sText = sText.."[NEWLINE][NEWLINE]"..Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_RETURNED_FROM_VACATION_TEXT_DEMON_HOMURA", Locale.ConvertTextKey(GameInfo.UnitPromotions[iPromoToRemove].Description))
				if sTheirText ~= "" then
					sTheirText = sTheirText.."[NEWLINE][NEWLINE]"..Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_ENEMY_MG_ENDED_VACATION_TEXT_DEMON_HOMURA")
				end
			end
		end
	end

	pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, sText, sTitle, MagicalGirls[iMGKey].PositionX, MagicalGirls[iMGKey].PositionY)
	if sTheirText ~= "" then
		pVacationDestination:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, sTheirText, sTheirTitle, -1, -1)
	end
	MagicalGirls[iMGKey].CurrentVacationLocation = -1
	MagicalGirls[iMGKey].VacationTurnTable = {}
end


--Defecting
local iDefecting = GameInfoTypes.MGACTIONSTATE_DEFECTING

MapModData.gPMMMOnMGReturnMapFunctions[iDefecting] = 
function (iMGKey)
	local pPlayer = Players[MagicalGirls[iMGKey].Owner]

	--In v25, we reset several Mood mod turns.
	MagicalGirls[iMGKey].LastVacationTurn = Game:GetGameTurn()
	MagicalGirls[iMGKey].LastSocializedTurn = Game:GetGameTurn()
	MagicalGirls[iMGKey].HomeCityLastVisited = Game:GetGameTurn()
	MagicalGirls[iMGKey].LastCombatTurn = Game:GetGameTurn()
	
	
	sText = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_DEFECTED_TO_YOUR_COUNTRY_TEXT", Locale.ConvertTextKey(MagicalGirls[iMGKey].Name), Players[MagicalGirls[iMGKey].OriginalOwner]:GetCivilizationAdjective())
	sTitle =  Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_DEFECTED_TO_YOUR_COUNTRY_TITLE")
	pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GREAT_PERSON_ACTIVE_PLAYER, sText, sTitle, MagicalGirls[iMGKey].PositionX, MagicalGirls[iMGKey].PositionY, GameInfoTypes.UNIT_PMMM_MAGICAL_GIRL)
end



--Writing Home
local iWritingHome = GameInfoTypes.MGACTIONSTATE_WRITING_HOME

MapModData.gPMMMOnMGReturnMapFunctions[iWritingHome] = 
function (iMGKey)	
	MagicalGirls[iMGKey].HomeCityLastContacted = Game:GetGameTurn()

	local sText = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_RETURNED_FROM_WRITING_HOME_TEXT", Locale.ConvertTextKey(MagicalGirls[iMGKey].Name))
	local sTitle =  Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_RETURNED_FROM_WRITING_HOME_TITLE")

	--We'll add 3 to the HomeCityLastVisited value so that it will be at the same position it was before she left
	MagicalGirls[iMGKey].HomeCityLastVisited = MagicalGirls[iMGKey].HomeCityLastVisited + 3

	local pPlayer = Players[MagicalGirls[iMGKey].Owner]
	pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, sText, sTitle, MagicalGirls[iMGKey].PositionX, MagicalGirls[iMGKey].PositionY)
end


--Sparring
local iSparring = GameInfoTypes.MGACTIONSTATE_SPARRING

local tSparringPromos = {}

for row in GameInfo.UnitPromotions() do
	if row.MGSparringPartnerBonus > 0 or row.MGSparringCooldownReduction > 0 then
		tSparringPromos[row.ID] = {
			["Bonus"] =	row.MGSparringPartnerBonus,
			["Cooldown"] = row.MGSparringCooldownReduction
		}
	end
end

MapModData.gPMMMOnMGReturnMapFunctions[iSparring] = 
function (iMGKey)
	local iXPChange = GameDefines.XP_GAINED_FROM_SPARRING
	local iCooldown = GameDefines.MG_SPARRING_COOLDOWN
	local iCooldownMod = 0
	for k, v in pairs(MagicalGirls[iMGKey].Promotions) do
		if tSparringPromos[v] and tSparringPromos[v].Cooldown > 0 then
			iCooldownMod = math.max(iCooldownMod + tSparringPromos[v].Cooldown, 0)
		end
	end

	iCooldown = math.ceil(iCooldown - iCooldownMod, 0)

	for k, v in pairs(MagicalGirls[MagicalGirls[iMGKey].SparringPartner].Promotions) do
		if tSparringPromos[v] and tSparringPromos[v].Bonus > 0 then
			iXPChange = iXPChange + tSparringPromos[v].Bonus
		end
	end

	MagicalGirls[iMGKey].XP = MagicalGirls[iMGKey].XP + iXPChange
	MagicalGirls[iMGKey].SparringCooldown = Game:GetGameTurn() - iCooldownMod

	local pPlot = Map.GetPlot(MagicalGirls[iMGKey].PositionX, MagicalGirls[iMGKey].PositionY)
	for pAreaPlot in PlotAreaSpiralIterator(pPlot, 1, false, false, false, true) do
		if pAreaPlot:IsCity() then
			local pCity = pAreaPlot:GetPlotCity()
			if pCity:GetOwner() == MagicalGirls[iMGKey].Owner then
				PMMM.SparringCities[CompileCityID(pCity)] = false
				break
			end
		end
	end

	local sText = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_RETURNED_FROM_SPARRING_TEXT", Locale.ConvertTextKey(MagicalGirls[iMGKey].Name), iXPChange, iCooldown)
	local sTitle =  Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_RETURNED_FROM_SPARRING_TITLE")
	local pPlayer = Players[MagicalGirls[iMGKey].Owner]
	pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, sText, sTitle, MagicalGirls[iMGKey].PositionX, MagicalGirls[iMGKey].PositionY)
end






--This is not actually a ReturnMapFunction, but it's related
local iWitchHuntEvent = GameInfoTypes.DIPLOMODIFIER_PMMM_WITCH_HUNT_IN_ENEMY_TERRITORY

function DiploPenaltyForWitchHunt(iEvent, iFromPlayer, iToPlayer)
	if iEvent == iWitchHuntEvent then
		if PMMM.WitchHuntDiploPenalties[iToPlayer] then
			if PMMM.WitchHuntDiploPenalties[iToPlayer][iFromPlayer] then
				return PMMM.WitchHuntDiploPenalties[iToPlayer][iFromPlayer]
			end	
		end
	end
	return 0
end