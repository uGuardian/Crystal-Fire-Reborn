-- NoireBlackHeartTraitScript
-- Author: Vice
-- DateCreated: 11/1/2015
--------------------------------------------------------------

print("I-idiot, Noire's trait script didn't l-load for your sake or anything! Don't say weird things!")

---------------------------------------------------------------------------------------------------------------------------------------------------------
-- INIT
---------------------------------------------------------------------------------------------------------------------------------------------------------
--Constants

local PRODUCTION_SPEED_MOD = GameInfo.GameSpeeds[PreGame.GetGameSpeed()].ConstructPercent / 100
local iMaxCivs = GameDefines.MAX_MAJOR_CIVS
local HDD_SHARE_THRESHOLD = GameDefines.VV_HDN_HDD_SHARE_THRESHOLD
HDNMod.GreatGameDevProgress = HDNMod.GreatGameDevProgress or {}
HDNMod.GreatGameDevProgressNeeded = HDNMod.GreatGameDevProgressNeeded or {}

--UA Constants
local NOIRE_PRODBONUS = GameInfoTypes.BUILDING_VV_LASTATION_PRODUCTION_DUMMY
local NOIRE_SCIBONUS = GameInfoTypes.BUILDING_VV_LASTATION_SCIENCE_DUMMY
local NOIRE_NOFRIENDS = GameInfoTypes.BUILDING_VV_LASTATION_NOFRIEND_BONUS
local NOIRE_PRODBONUS_U = GameInfoTypes.BUILDING_VV_LASTATION_PRODUCTION_DUMMY_U
local NOIRE_SCIBONUS_U = GameInfoTypes.BUILDING_VV_LASTATION_SCIENCE_DUMMY_U
local NOIRE_NOFRIENDS_U = GameInfoTypes.BUILDING_VV_LASTATION_NOFRIEND_BONUS_U

local BLACK_HEART_DUMMY = GameInfoTypes.BUILDING_VV_LASTATION_WONDER_BONUS
--The wonder yields are multiplied by the Era of the PrereqTech of the Wonder. (if there is no Prereq Tech then it is considered Ancient Era)
local BLACK_HEART_WONDER_SCIENCE = 50
local BLACK_HEART_WONDER_GOLD = 100
local BLACK_HEART_WONDER_CULTURE = 30
local BLACK_HEART_WONDER_FAITH = 15
local BLACK_HEART_WONDER_XP = 5

local BLACK_HEART_U_WONDER_SCIENCE = 75
local BLACK_HEART_U_WONDER_GOLD = 133
local BLACK_HEART_U_WONDER_CULTURE = 50
local BLACK_HEART_U_WONDER_FAITH = 30
local BLACK_HEART_U_WONDER_XP = 2

local COSPLAY_SHOP = GameInfoTypes.BUILDING_VV_COSPLAY_SHOP
local COSPLAY_SHOP_OB = GameInfoTypes.BUILDING_VV_LASTATION_CC_DUMMY_OB
local COSPLAY_SHOP_WC = GameInfoTypes.BUILDING_VV_LASTATION_CC_DUMMY_WC
local COSPLAY_SHOP_OB_MOD = 0.5 --number of cosplay shop OB dummies to give per open borders allowed, rounds down

--Civ Identifiers
--Hyperdimension
local iNoire = GameInfoTypes.LEADER_VV_NOIRE or -1
local iBlackHeart = GameInfoTypes.LEADER_VV_BLACK_HEART or -1
local iNoireCiv = GameInfoTypes.CIVILIZATION_VV_LASTATION or -1
local iBlackHeartCiv = GameInfoTypes.CIVILIZATION_VV_LASTATION_BH or -1
--Ultradimension
local iNoireUltra = GameInfoTypes.LEADER_VV_NOIRE_ULTRA or -1
local iBlackHeartUltra = GameInfoTypes.LEADER_VV_BLACK_HEART_ULTRA or -1
local iNoireCivUltra = GameInfoTypes.CIVILIZATION_VV_LASTATION_ULTRA or -1
local iBlackHeartCivUltra = GameInfoTypes.CIVILIZATION_VV_LASTATION_BH_ULTRA or -1

local tNoires = {}
local tHDNoires = {}
local tUDNoires = {}
for i = 0, iMaxCivs - 1, 1 do
	local pPlayer = Players[i]
	if pPlayer:IsEverAlive() then
		local iLeaderType = pPlayer:GetLeaderType()
		if (iLeaderType == iNoire or iLeaderType == iBlackHeart) then
			tNoires[i] = true
			tHDNoires[i] = true
		elseif (iLeaderType == iNoireUltra or iLeaderType == iBlackHeartUltra) then
			tNoires[i] = true
			tUDNoires[i] = true
		end
	end
end


---------------------------------------------------------------------------------------------------------------------------------------------------------
-- HELPER FUNCTIONS
-- None of these are directly assigned to any Events or GameEvents.
---------------------------------------------------------------------------------------------------------------------------------------------------------

--Note: This function loops over *every* Noire player in the game at once, so no iPlayer is passed to it. This is so multiple Noires can properly provide
--benefits as needed to multiple players at once if needed.

--How this works:
--A Civ Noire has met but is *not* friends with gives her one copy of her PRODBONUS building.
--A Civ Noire has met and *is* friends with gives the friend one copy of her PRODBONUS building and gives Noire herself one copy of her SCIBONUS building.
--If Noire has met every living major Civ in the world and has no friends, she gets the NOFRIENDS bonus building.
function UpdateNoireFriendBuildings()
	local tBuildingsToSet = {}
	local tBonusIneligibleNoires = {}
	for iPlayer = 0, iMaxCivs - 1, 1 do
		local pPlayer = Players[iPlayer]
		if pPlayer:IsAlive() then
			local pTeam = Teams[pPlayer:GetTeam()]
			if not tBuildingsToSet[iPlayer] then
				tBuildingsToSet[iPlayer] = {
				[NOIRE_PRODBONUS] =		0,
				[NOIRE_SCIBONUS] =		0,
				[NOIRE_NOFRIENDS] =		0,
				[NOIRE_PRODBONUS_U] =	0,
				[NOIRE_SCIBONUS_U] =	0,
				[NOIRE_NOFRIENDS_U] =	0
				}
			end
			--iType is shorthand for what sort of buildings need to be set for this particular player
			--1 = HD, 2 = UD, 0 = not noire
			local iType = 0
			if tHDNoires[iPlayer] and IsPlayerHDDMode(pPlayer) == false then
				iType = 1
			elseif tUDNoires[iPlayer] and IsPlayerHDDMode(pPlayer) == false then
				iType = 2
			end
			for iLoop = iPlayer + 1, iMaxCivs - 1, 1 do
				local pLoop = Players[iLoop]
				if pLoop:IsAlive() then
					if not tBuildingsToSet[iLoop] then
						tBuildingsToSet[iLoop] = {
							[NOIRE_PRODBONUS] =		0,
							[NOIRE_SCIBONUS] =		0,
							[NOIRE_NOFRIENDS] =		0,
							[NOIRE_PRODBONUS_U] =	0,
							[NOIRE_SCIBONUS_U] =	0,
							[NOIRE_NOFRIENDS_U] =	0
						}
					end
					


					if pLoop:IsDoF(iPlayer) then
						if iType > 0 then
							tBonusIneligibleNoires[iPlayer] = true
							
							if iType == 1 then
								tBonusIneligibleNoires[iPlayer] = true
								tBuildingsToSet[iLoop][NOIRE_PRODBONUS] = tBuildingsToSet[iLoop][NOIRE_PRODBONUS] + 1
								tBuildingsToSet[iPlayer][NOIRE_SCIBONUS] = tBuildingsToSet[iPlayer][NOIRE_SCIBONUS] + 1
							elseif iType == 2 then
								tBonusIneligibleNoires[iPlayer] = true
								tBuildingsToSet[iLoop][NOIRE_PRODBONUS_U] = tBuildingsToSet[iLoop][NOIRE_PRODBONUS_U] + 1
								tBuildingsToSet[iPlayer][NOIRE_SCIBONUS_U] = tBuildingsToSet[iPlayer][NOIRE_SCIBONUS_U] + 1
							end
						elseif tNoires[iLoop] and not IsPlayerHDDMode(pLoop) then
							if tHDNoires[iLoop] then
								tBonusIneligibleNoires[iLoop] = true
								tBuildingsToSet[iPlayer][NOIRE_PRODBONUS] = tBuildingsToSet[iPlayer][NOIRE_PRODBONUS] + 1
								tBuildingsToSet[iLoop][NOIRE_SCIBONUS] = tBuildingsToSet[iLoop][NOIRE_SCIBONUS] + 1
							elseif tUDNoires[iLoop] then
								tBonusIneligibleNoires[iLoop] = true
								tBuildingsToSet[iPlayer][NOIRE_PRODBONUS_U] = tBuildingsToSet[iPlayer][NOIRE_PRODBONUS_U] + 1
								tBuildingsToSet[iLoop][NOIRE_SCIBONUS_U] = tBuildingsToSet[iLoop][NOIRE_SCIBONUS_U] + 1
							end
						end
					elseif pTeam:IsHasMet(pLoop:GetTeam()) then
						if pTeam:IsAtWar(pLoop:GetTeam()) then
							tBonusIneligibleNoires[iPlayer] = true
						else
							if iType == 1 then
								tBuildingsToSet[iPlayer][NOIRE_PRODBONUS] = tBuildingsToSet[iPlayer][NOIRE_PRODBONUS] + 1
							elseif iType == 2 then
								tBuildingsToSet[iPlayer][NOIRE_PRODBONUS_U] = tBuildingsToSet[iPlayer][NOIRE_PRODBONUS_U] + 1
							end
						
							if tHDNoires[iLoop] and not IsPlayerHDDMode(pLoop) then
								tBuildingsToSet[iLoop][NOIRE_PRODBONUS] = tBuildingsToSet[iLoop][NOIRE_PRODBONUS] + 1
							elseif tUDNoires[iLoop] and not IsPlayerHDDMode(pLoop) then
								tBuildingsToSet[iLoop][NOIRE_PRODBONUS_U] = tBuildingsToSet[iLoop][NOIRE_PRODBONUS_U] + 1
							end
						end
					elseif iType > 0 then
						tBonusIneligibleNoires[iPlayer] = true
					end
				end
			end
			if not tBonusIneligibleNoires[iPlayer] then
				if iType == 1 then
					tBuildingsToSet[iPlayer][NOIRE_NOFRIENDS] = 1
				elseif iType == 2 then
					tBuildingsToSet[iPlayer][NOIRE_NOFRIENDS_U] = 1
				end
			end
		end
	end

	for iPlayer, thistable in pairs(tBuildingsToSet) do
		local pPlayer = Players[iPlayer]
		local pCapital = pPlayer:GetCapitalCity()
		if pCapital then
			for iBuilding, iNumber in pairs(thistable) do
				pCapital:SetNumRealBuilding(iBuilding, iNumber)
			end
		end
	end
end

function UpdateBlackHeartDummyBuildings(iPlayer)
	if tNoires[iPlayer] then
		local iNum = 0
		local pPlayer = Players[iPlayer]
		if IsPlayerHDDMode(pPlayer) then
			iNum = math.floor(HDNMod.Shares[iPlayer] / 100)
		end
		for pCity in pPlayer:Cities() do
			pCity:SetNumRealBuilding(BLACK_HEART_DUMMY, iNum)
		end
	end
end

--Dummy buildings for the Cosplay Shop. Set based on number of Open Borders Noire is allowing out (not in!) and whether or not she is the World Congress host.
function UpdateCosplayShopBuildings(iPlayer)
	local pPlayer = Players[iPlayer]
	local pTeam = Teams[pPlayer:GetTeam()]
	local iNumOBBuildings = 0
	local iNumHostBuildings = 0
	for i = 0, iMaxCivs - 1, 1 do
		local pLoop = Players[i]
		if pLoop:IsAlive() and pTeam:IsAllowsOpenBordersToTeam(pLoop:GetTeam()) then
			iNumOBBuildings = iNumOBBuildings + 1
		end
	end
	iNumOBBuildings = math.floor(iNumOBBuildings * COSPLAY_SHOP_OB_MOD)


	local pLeague = Game.GetActiveLeague()
	if pLeague and iPlayer == pLeague:GetHostMember() then
		iNumHostBuildings = 1
	end


	for pCity in pPlayer:Cities() do
		if pCity:IsHasBuilding(COSPLAY_SHOP) then
			pCity:SetNumRealBuilding(COSPLAY_SHOP_OB, iNumOBBuildings)
			pCity:SetNumRealBuilding(COSPLAY_SHOP_WC, iNumHostBuildings)
		else
			pCity:SetNumRealBuilding(COSPLAY_SHOP_OB, 0)
			pCity:SetNumRealBuilding(COSPLAY_SHOP_WC, 0)
		end
	end
end



---------------------------------------------------------------------------------------------------------------------------------------------------------
-- PlayerDoTurn
---------------------------------------------------------------------------------------------------------------------------------------------------------


function OnPlayerDoTurnNoire(iPlayer)
	local pPlayer = Players[iPlayer]
	if tNoires[iPlayer] then
		UpdateNoireFriendBuildings()
		UpdateBlackHeartDummyBuildings(iPlayer)
		UpdateCosplayShopBuildings(iPlayer)
	end
end
GameEvents.PlayerDoTurn.Add(OnPlayerDoTurnNoire)


--------------------------------------------------------------------------------------------------------------------------------------------------------
-- CityConstructed
--------------------------------------------------------------------------------------------------------------------------------------------------------

function OnCityConstructedNoire(iPlayer, iCity, iBuildingType)
	if tNoires[iPlayer] then
		local pPlayer = Players[iPlayer]
		if IsPlayerHDDMode(pPlayer) then
			local sBuildingClass = GameInfo.Buildings[iBuildingType].BuildingClass
			if GameInfo.BuildingClasses[sBuildingClass].MaxGlobalInstances == 1 then
				local iScience;
				local iGold;
				local iCulture;
				local iFaith;
				local iXP;
				if tHDNoires[iPlayer] then
					iScience = BLACK_HEART_WONDER_SCIENCE
					iGold = BLACK_HEART_WONDER_GOLD
					iCulture = BLACK_HEART_WONDER_CULTURE
					iFaith = BLACK_HEART_WONDER_FAITH
					iXP = BLACK_HEART_WONDER_XP
				elseif tUDNoires[iPlayer] then
					iScience = BLACK_HEART_U_WONDER_SCIENCE
					iGold = BLACK_HEART_U_WONDER_GOLD
					iCulture = BLACK_HEART_U_WONDER_CULTURE
					iFaith = BLACK_HEART_U_WONDER_FAITH
					iXP = BLACK_HEART_U_WONDER_XP
				end

				local iEra = 1
				local tech = GameInfo.Buildings[iBuildingType].PrereqTech
				if tech and GameInfo.Technologies[tech] and GameInfo.Technologies[tech].Era then
					iEra = GameInfo.Eras[GameInfo.Technologies[tech].Era].ID
					if iEra < 1 then iEra = 1 end
				end

				iScience = iScience * iEra
				iGold = iGold * iEra
				iCulture = iCulture * iEra
				iFaith = iFaith * iEra


				local iTech = pPlayer:GetCurrentResearch()
				if iTech and iTech > 0 then
					local pTeamTechs = Teams[pPlayer:GetTeam()]:GetTeamTechs()
					pTeamTechs:ChangeResearchProgress(iTech, iScience, iPlayer)
				end
				
				pPlayer:ChangeGold(iGold)
				pPlayer:ChangeJONSCulture(iCulture)
				pPlayer:ChangeFaith(iFaith)
				for pUnit in pPlayer:Units() do
					if pUnit:IsCombatUnit() or pUnit:GetDomainType() == GameInfoTypes.DOMAIN_AIR then
						pUnit:ChangeExperience(iXP)
					end
				end

				local sTitle = Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_VV_BLACK_HEART_WONDER_FINISHED_TITLE", GameInfo.Buildings[iBuildingType].Description)
				local sText = Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_VV_BLACK_HEART_WONDER_FINISHED_TEXT", iScience, iGold, iCulture, iFaith, iXP)
				local pCity = pPlayer:GetCityByID(iCity)
				pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, sText, sTitle, pCity:GetX(), pCity:GetY())
			end
		end
	end
end
GameEvents.CityConstructed.Add(OnCityConstructedNoire)

---------------------------------------------------------------------------------------------------------------------------------------------------------
-- VV_ConvertHDNLeader
---------------------------------------------------------------------------------------------------------------------------------------------------------
function OnTransformedNoire(iPlayer, bHDDOn)
	if tNoires[iPlayer] then
		UpdateNoireFriendBuildings()
		UpdateBlackHeartDummyBuildings(iPlayer)
	end
end
LuaEvents.VV_ConvertHDNLeader.Add(OnTransformedNoire)


function NoireTransformationAILogic(iPlayer)
	local bShouldTransform = false
	if HDNMod.Shares[iPlayer] >= HDD_SHARE_THRESHOLD * 1.5 then
		local pPlayer = Players[iPlayer]
		--Transform if we're building a Wonder and have at least 20%.
		if not bShouldTransform and (HDNMod.Shares[iPlayer] >= HDD_SHARE_THRESHOLD * 2) then
			for pCity in pPlayer:Cities() do
				local iBuilding = pCity:GetProductionBuilding()
				if GameInfo.Buildings[iBuilding] then
					local sBuildingClass = GameInfo.Buildings[iBuilding].BuildingClass
					if sBuildingClass and GameInfo.BuildingClasses[sBuildingClass] and GameInfo.BuildingClasses[sBuildingClass].MaxGlobalInstances == 1 then
						bShouldTransform = true
						break
					end
				end
			end
		end
	end
	return bShouldTransform
end

function BlackHeartTransformationAILogic(iPlayer)
	local bShouldRevert = true
	--Revert if not building any wonders.
	local pPlayer = Players[iPlayer]
	for pCity in pPlayer:Cities() do
		local iBuilding = pCity:GetProductionBuilding()
		if GameInfo.Buildings[iBuilding] then
			local sBuildingClass = GameInfo.Buildings[iBuilding].BuildingClass
			if sBuildingClass and GameInfo.BuildingClasses[sBuildingClass] and GameInfo.BuildingClasses[sBuildingClass].MaxGlobalInstances == 1 then
				bShouldRevert = false
				break
			end
		end
	end
	return bShouldRevert
end
LuaEvents.VV_AddToTransformLogicTable(iNoire, NoireTransformationAILogic)
LuaEvents.VV_AddToTransformLogicTable(iBlackHeart, BlackHeartTransformationAILogic)
LuaEvents.VV_AddToTransformLogicTable(iNoireUltra, NoireTransformationAILogic)
LuaEvents.VV_AddToTransformLogicTable(iBlackHeartUltra, BlackHeartTransformationAILogic)


