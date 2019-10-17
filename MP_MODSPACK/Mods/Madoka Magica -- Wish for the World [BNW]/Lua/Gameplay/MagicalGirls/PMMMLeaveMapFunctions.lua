-- PMMMLeaveMapFunctions
-- Author: Vicevirtuoso
-- DateCreated: 8/7/2014 4:31:47 PM
--------------------------------------------------------------



--File for defining functions which happen when MGs leave the map due to a clickable mission which removes them from play temporarily.
--These are set up to be easily added in by other mods which reference this one.



if not MapModData.gPMMMOnMGLeaveMapFunctions then
	MapModData.gPMMMOnMGLeaveMapFunctions = {}
end



--Vacation
local iVacation = GameInfoTypes.MGACTIONSTATE_VACATIONING

MapModData.gPMMMOnMGLeaveMapFunctions[iVacation] = 
function (iMGKey)
	--Determining where the MG goes to vacation.
	--There are currently five factors:
	--Open Borders: Civs *allowing* open borders are more likely to be vacation targets. The MG's owner allowing OB to them has no effect.
	--Trade Routes: Each trade route with the Civ (regardless of who owns it) increases the chance.
	--Declaration of Friendship: DOFs increase the chance of another civ being the vacation target.
	--Denouncement: Denouncements decrease the chance.
	--Not necessarily a factor so much as a complete negation, but of course, civs at war with the MG's owner are never valid targets.

	local tCivs = {}
	local iPlayer = MagicalGirls[iMGKey].Owner
	local pPlayer = Players[iPlayer]
	local pTeam = Teams[pPlayer:GetTeam()]
	--It starts with a 100 weight of the choice being her home country, and increase by 1 for every 20 Tourism and Entertainment combined.
	tCivs[iPlayer] = 100 + math.floor((pPlayer:GetTourism() + GetEmpireEntertainment(pPlayer)) / GameDefines.VACATION_DESTINATION_HOME_TOURISM_DIVISOR)
	

	for i = 0, iMaxCivs - 1, 1 do
		if i ~= iPlayer then
			local pLoop = Players[i]
			if pLoop:IsAlive() then
				if pTeam:IsHasMet(pLoop:GetTeam()) then
					if pTeam:IsAtWar(pLoop:GetTeam()) then
						tCivs[i] = -1
					else
						tCivs[i] = 15
						if pPlayer:IsDoF(i) then
							tCivs[i] = tCivs[i] + GameDefines.VACATION_DESTINATION_FRIENDSHIP_BONUS
						end
						if pPlayer:IsPlayerHasOpenBorders(i) then
							tCivs[i] = tCivs[i] + GameDefines.VACATION_DESTINATION_OPEN_BORDER_BONUS
						end
						if pPlayer:IsDenouncingPlayer(i) or pLoop:IsDenouncingPlayer(iPlayer) then
							tCivs[i] = tCivs[i] + GameDefines.VACATION_DESTINATION_DENOUNCE_PENALTY
						end
						local iInfluence = pLoop:GetInfluenceLevel(iPlayer);
						tCivs[i] = tCivs[i] + (iInfluence * iInfluence * GameDefines.VACATION_DESTINATION_INFLUENCE_BONUS)
					end
				else
					tCivs[i] = -1
				end
			else
				tCivs[i] = -1
			end
		end
	end

	for k, v in pairs(pPlayer:GetTradeRoutes()) do
		local iOtherCiv = v.ToCiv
		if tCivs[iOtherCiv] and tCivs[iOtherCiv] ~= -1 then
			tCivs[iOtherCiv] = tCivs[iOtherCiv] + GameDefines.VACATION_DESTINATION_TRADE_ROUTE_BONUS
		end
	end

	for k, v in pairs(pPlayer:GetTradeRoutesToYou()) do
		local iOtherCiv = v.FromCiv
		if tCivs[iOtherCiv] and tCivs[iOtherCiv] ~= false then
			tCivs[iOtherCiv] = tCivs[iOtherCiv] + GameDefines.VACATION_DESTINATION_TRADE_ROUTE_BONUS
		end
	end
	
	local iSelectedPlayer = DeckShuffle(tCivs, "PMMM Vacation Destination Roll")
	local pSelectedPlayer = Players[iSelectedPlayer]
	local sPlaceVacationedToName;
	if iSelectedPlayer == iPlayer then
		sPlaceVacationedToName = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_WENT_ON_VACATION_YOUR_COUNTRY")
	else
		sPlaceVacationedToName = pSelectedPlayer:GetCivilizationShortDescription()
	end 
	MagicalGirls[iMGKey].CurrentVacationLocation = iSelectedPlayer
	local iTurns = GameInfo.MG_ActionStates[iVacation].Turns
	
	--Have her do the first turn of Vacation bonuses now
	DoVacationTurn(iMGKey)

	local sText = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_WENT_ON_VACATION_TEXT", Locale.ConvertTextKey(MagicalGirls[iMGKey].Name), sPlaceVacationedToName, iTurns)
	local sTitle =  Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_WENT_ON_VACATION_TITLE")
	pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, sText, sTitle, MagicalGirls[iMGKey].LocationX, MagicalGirls[iMGKey].LocationY)
	if iSelectedPlayer ~= iPlayer then
		local sTheirText = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_ENEMY_MG_VACATION_TEXT", Locale.ConvertTextKey(MagicalGirls[iMGKey].Name), pPlayer:GetCivilizationAdjective())
		local sTheirTitle = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_ENEMY_MG_VACATION_TITLE")
		pSelectedPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, sTheirText, sTheirTitle, -1, -1)
	end
end


--Defecting
local iDefecting = GameInfoTypes.MGACTIONSTATE_DEFECTING

MapModData.gPMMMOnMGLeaveMapFunctions[iDefecting] = 
function (iMGKey)
	local iPlayer = MagicalGirls[iMGKey].Owner
	local pPlayer = Players[iPlayer]

	--Find her new owner based on Influence.
	local iHighestInfluence = 1
	local tHighestInfluencePlayers = {}
	local bSelectByInfluence = false
	for k, v in pairs(MagicalGirls[iMGKey].Influence) do
		if k ~= iPlayer then
			local pLoop = Players[k]
			if pLoop:IsAlive() then
				if v == iHighestInfluence then
					tHighestInfluencePlayers[k] = 10
					bSelectByInfluence = true
				elseif v > iHighestInfluence then
					iHighestInfluence = v
					tHighestInfluencePlayers = {}
					tHighestInfluencePlayers[k] = 10
					bSelectByInfluence = true
				end
			end
		else
			tHighestInfluencePlayers[k] = -1
		end
	end

	--If nobody has any influence for whatever reason, just choose a random Civ (even if unmet)
	local iChosenCiv;
	if bSelectByInfluence == false then
		local pTeam = Teams[pPlayer:GetTeam()]
		print("No influence above 0. Randomly select from met Civs")
		local tAvailableCivs = {}
		for i = 0, iMaxCivs - 1, 1 do
			local pLoop = Players[i]
			if i ~= iPlayer and pLoop:IsAlive() and pTeam:IsHasMet(pLoop:GetTeam()) then
				tAvailableCivs[i] = 10
			else
				tAvailableCivs[i] = -1
			end
		end
		iChosenCiv = DeckShuffle(tAvailableCivs, "PMMM Defection Choice Roll")
	else
		iChosenCiv = DeckShuffle(tHighestInfluencePlayers, "PMMM Defection Choice Roll")
	end


	--If we haven't even met anybody, choose a random unmet Civ
	if not iChosenCiv then
		print("No met Civs. Randomly select from ALL Civs")
		local tAvailableCivs = {}
		for i = 0, iMaxCivs - 1, 1 do
			local pLoop = Players[i]
			if i ~= iPlayer and pLoop:IsAlive() then
				tAvailableCivs[i] = 10
			else
				tAvailableCivs[i] = -1
			end
		end
		iChosenCiv = DeckShuffle(tAvailableCivs, "PMMM Defection Choice Roll")
	end
	
	
	--At THIS point, if there is no iChosenCiv, that means that the active player is the only Civ left in the world. So at this point she can just defect back to her own Civ
	
	if not iChosenCiv then iChosenCiv = iPlayer end
	
	
	MagicalGirls[iMGKey].Owner = iChosenCiv
	MagicalGirls[iMGKey].Loyalty = GameDefines.MAXIMUM_MG_LOYALTY
	--Nullify her influence
	MagicalGirls[iMGKey].Influence = {}
	
	--she will respawn with 100% Soul Gem, to avoid the shitty issue of having a 5% SG girl defecting to you
	MagicalGirls[iMGKey].SoulGem = GameDefines.MAXIMUM_SOUL_GEM_AMOUNT
	--Spawns near their capital, or their starting plot if they have one
	local pEnemyPlayer = Players[iChosenCiv]
	local pCapital = pEnemyPlayer:GetCapitalCity()
	local pPlot;
	if pCapital then
		pPlot = pCapital:Plot()
	else
		pPlot = pEnemyPlayer:GetStartingPlot()
	end
	
	sText = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_DEFECTED_TEXT", Locale.ConvertTextKey(MagicalGirls[iMGKey].Name), pEnemyPlayer:GetCivilizationShortDescription())
	sTitle =  Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_DEFECTED_TITLE")
	pPlayer:AddNotification(NotificationTypes.NOTIFICATION_UNIT_DIED, sText, sTitle, MagicalGirls[iMGKey].PositionX, MagicalGirls[iMGKey].PositionY, GameInfoTypes.UNIT_PMMM_MAGICAL_GIRL)
	
	MagicalGirls[iMGKey].PositionX = pPlot:GetX()
	MagicalGirls[iMGKey].PositionY = pPlot:GetY()
end