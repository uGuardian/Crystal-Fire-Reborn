-- Nanoha's Trait Script
-- Author: Vicevirtuoso
-- DateCreated: 2/18/2014 4:09:40 PM
--------------------------------------------------------------

--set to true to enable print statements
local bDebug = false

function dprint(...)
  if (bDebug) then
    print(string.format(...))
  end
end


local iMaxCivs = GameDefines.MAX_MAJOR_CIVS
print("Nanoha script loaded.")

--Find out if there are any Nanoha players in the game, and get their player IDs.-------------------------
local tWhoIsNanoha = MapModData.gNanohaPlayers or {}

local bAnyNanohas;

if not MapModData.gNanohaPlayers then
	for i = 0, iMaxCivs - 1, 1 do
		local pPlayer = Players[i]
		if pPlayer:IsEverAlive() then
			leaderType = GameInfo.Leaders[pPlayer:GetLeaderType()].Type
			leadertraitType = GameInfo.Leader_Traits("LeaderType ='" .. leaderType .. "'")().TraitType
			traitType = GameInfo.Traits[leadertraitType]
			if traitType.DOFOnPeaceTreaty == 1 or traitType.SiegeUnitsDefenseBonus == 1 then
				tWhoIsNanoha[i] = true
				bAnyNanohas = true
			end
		end
	end
else
	bAnyNanohas = true
end

if not bAnyNanohas then
	print("Nanoha is not present in the game. No further functions will run.")
	return
else
	local string = ""
	for k, v in pairs(tWhoIsNanoha) do
		if string == "" then
			string = k
		else
			string = string..", "..k
		end
	end
	string = "Nanoha player IDs: "..string
	print(string)
end

--End Nanoha discovery function----------------------------------------------------------------------------

if not MapModData.gNanohaPlayers then
	MapModData.gNanohaPlayers = tWhoIsNanoha
end

--Force friendship upon a peace treaty
--Was there really any other trait that Nanoha could have?
function YouGonnaGetBefriended(iTeam1, iTeam2, bIsWar)
	if bIsWar == true then
		dprint("War state changed to War, no friendship!")
		return
	end
	for iPlayer = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
		local pPlayer = Players[iPlayer]
		if pPlayer:IsAlive() then
			if pPlayer:GetTeam() == iTeam1 or pPlayer:GetTeam() == iTeam2 then
				if tWhoIsNanoha[iPlayer] then
					dprint("War state changed to Peace, player with DOFOnPeacetreaty found")
					if pPlayer:GetTeam() == iTeam1 then
						for iPlayer2 = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
							local pPlayer2 = Players[iPlayer2]
							if pPlayer2:IsAlive() then
								if pPlayer2:GetTeam() == iTeam2 and not pPlayer:IsDoF(iPlayer2) then
									pPlayer:DoForceDoF(iPlayer2)
									local sP1Leader = pPlayer:GetNameKey()
									local sP2Leader = pPlayer2:GetNameKey()
									local sP1Civ = pPlayer:GetCivilizationShortDescriptionKey()
									local sP2Civ = pPlayer2:GetCivilizationShortDescriptionKey()
									for iNotificationPlayer = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
										local pNotificationPlayer = Players[iNotificationPlayer]
										local sTitle;
										local sText;
										if pNotificationPlayer == pPlayer then
											sTitle = Locale.ConvertTextKey("TXT_KEY_NANOHA_DOF_FIRST_PERSON_TITLE", sP2Civ)
											sText = Locale.ConvertTextKey("TXT_KEY_NANOHA_DOF_FIRST_PERSON_TEXT", sP2Leader)
										elseif pNotificationPlayer == pPlayer2 then
											sTitle = Locale.ConvertTextKey("TXT_KEY_NANOHA_DOF_SECOND_PERSON_TITLE", sP1Civ)
											sText = Locale.ConvertTextKey("TXT_KEY_NANOHA_DOF_SECOND_PERSON_TEXT", sP1Leader)
										else
											local pNotificationTeam = Teams[pNotificationPlayer:GetTeam()]
											local iTeam1 = pPlayer:GetTeam()
											local iTeam2 = pPlayer2:GetTeam()
											if pNotificationTeam:IsHasMet(iTeam1) and pNotificationTeam:IsHasMet(iTeam2) then
												sTitle = Locale.ConvertTextKey("TXT_KEY_NANOHA_DOF_THIRD_PERSON_TITLE", sP1Civ, sP2Civ)
												sText = Locale.ConvertTextKey("TXT_KEY_NANOHA_DOF_THIRD_PERSON_TEXT", sP1Leader, sP2Leader)
											end
										end
										if sText and sTitle then
											pNotificationPlayer:AddNotification(NotificationTypes.NOTIFICATION_DIPLOMACY_DECLARATION, sText, sTitle, -1, -1)
										end
									end
									dprint("DoF forced between " ..pPlayer:GetCivilizationShortDescription().. " and " ..pPlayer2:GetCivilizationShortDescription())
								end
							end
						end
					elseif pPlayer:GetTeam() == iTeam2 then
						for iPlayer2 = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
							local pPlayer2 = Players[iPlayer2]
							if pPlayer2:IsAlive() then
								if pPlayer2:GetTeam() == iTeam1 and not pPlayer:IsDoF(iPlayer2) then
									pPlayer:DoForceDoF(iPlayer2)
									local sP1Leader = pPlayer:GetNameKey()
									local sP2Leader = pPlayer2:GetNameKey()
									local sP1Civ = pPlayer:GetCivilizationShortDescriptionKey()
									local sP2Civ = pPlayer2:GetCivilizationShortDescriptionKey()
									for iNotificationPlayer = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
										local pNotificationPlayer = Players[iNotificationPlayer]
										local sTitle;
										local sText;
										if pNotificationPlayer == pPlayer then
											sTitle = Locale.ConvertTextKey("TXT_KEY_NANOHA_DOF_FIRST_PERSON_TITLE", sP2Civ)
											sText = Locale.ConvertTextKey("TXT_KEY_NANOHA_DOF_FIRST_PERSON_TEXT", sP2Leader)
										elseif pNotificationPlayer == pPlayer2 then
											sTitle = Locale.ConvertTextKey("TXT_KEY_NANOHA_DOF_SECOND_PERSON_TITLE", sP1Civ)
											sText = Locale.ConvertTextKey("TXT_KEY_NANOHA_DOF_SECOND_PERSON_TEXT", sP1Leader)
										else
											local pNotificationTeam = Teams[pNotificationPlayer:GetTeam()]
											local iTeam1 = pPlayer:GetTeam()
											local iTeam2 = pPlayer2:GetTeam()
											if pNotificationTeam:IsHasMet(iTeam1) and pNotificationTeam:IsHasMet(iTeam2) then
												sTitle = Locale.ConvertTextKey("TXT_KEY_NANOHA_DOF_THIRD_PERSON_TITLE", sP1Civ, sP2Civ)
												sText = Locale.ConvertTextKey("TXT_KEY_NANOHA_DOF_THIRD_PERSON_TEXT", sP1Leader, sP2Leader)
											end
										end
										if sText and sTitle then
											pNotificationPlayer:AddNotification(NotificationTypes.NOTIFICATION_DIPLOMACY_DECLARATION, sText, sTitle, -1, -1)
										end
									end
									dprint("DoF forced between " ..pPlayer:GetCivilizationShortDescription().. " and " ..pPlayer2:GetCivilizationShortDescription())
								end
							end
						end
					end
				end
			end
		end
	end
end

Events.WarStateChanged.Add(YouGonnaGetBefriended)



--Remove defense penalty and siege bonus from Siege units
function NanohaSiegeUnits(iPlayer, iUnitID, iX, iY)
	if tWhoIsNanoha[iPlayer] then
		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iUnitID)
		if pUnit then
			if pUnit:GetUnitCombatType() == GameInfoTypes.UNITCOMBAT_SIEGE then
				pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_NO_DEFENSIVE_BONUSES, false)
				local testtable ={}
				LuaEvents.DecisionsNanohaTest(iPlayer, testtable)
				if not testtable[0] then
					pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_CITY_SIEGE, false)
				end
			end
		end
	end
end

GameEvents.UnitSetXY.Add(NanohaSiegeUnits)