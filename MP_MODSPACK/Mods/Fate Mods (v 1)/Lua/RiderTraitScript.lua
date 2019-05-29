-- Rider Happiness from Military Units script
-- Author: Vicevirtuoso
-- DateCreated: 6/20/2013 3:35:43 AM
--------------------------------------------------------------

--Cache building types for a little speed boost
local iHappinessBuilding = GameInfoTypes.BUILDING_RIDER_DUMMY_BUILDING
local iOkeanosBuilding = GameInfoTypes.BUILDING_OKEANOS_DUMMY
local iOkeanosDummyPolicy = GameInfoTypes.POLICY_RIDER_DUMMY

--Initialize happy points from military units from traits upon game load
local tHappinessFromUnits = {}
local bAnyRiders;

for i = 0, GameDefines.MAX_MAJOR_CIVS -1, 1 do
	local pPlayer = Players[i]
	if pPlayer:IsEverAlive() then
		local leaderType = GameInfo.Leaders[pPlayer:GetLeaderType()].Type
		local traitType = GameInfo.Leader_Traits("LeaderType ='" .. leaderType .. "'")().TraitType
		local pTrait = GameInfo.Traits[traitType]
		if pTrait.UnitsRequiredPerHappinessPoint > 0 then
			tHappinessFromUnits[i] = pTrait.UnitsRequiredPerHappinessPoint
			bAnyRiders = true
		end
	end
end


if not bAnyRiders then
	print("Rider not present on map, no functions will run.")
	return
end

--Initialize Okeanos variable constant
local iMinimumOkeanosGoldenAge = math.floor(8 * (GameInfo.GameSpeeds[PreGame.GetGameSpeed()].ResearchPercent / 100))
print("Minimum turns for Okeanos Golden Age: " ..iMinimumOkeanosGoldenAge)


--Add happiness from military units
function UpdateHappinessFromUnits(iPlayer)
	if iPlayer < GameDefines.MAX_MAJOR_CIVS then
		local ttable = {}
		local pPlayer = Players[iPlayer]
		if pPlayer:IsEverAlive() then
			LuaEvents.FSNRiderGetAlexanderVictory(pPlayer, ttable)
			local iVal;
			if tHappinessFromUnits[iPlayer] then 
				iVal = tHappinessFromUnits[iPlayer]
			elseif ttable[0] then --ttable[0] can have a value from an Event, which can allow Alexander to utilize this trait
				iVal = ttable[0]
			end
			if iVal then
				local iTotalMilitaryUnits = 0
				for pUnit in pPlayer:Units() do
					if pUnit:IsCombatUnit() then
						iTotalMilitaryUnits = iTotalMilitaryUnits + 1
					end
				end
				iBuildingsToAdd = math.floor(iTotalMilitaryUnits / iVal)
				pPlayer:GetCapitalCity():SetNumRealBuilding(iHappinessBuilding, iBuildingsToAdd)
			end
		end
	end
end

LuaEvents.FSNRiderUpdateHappinessFromUnits.Add(UpdateHappinessFromUnits)

GameEvents.PlayerDoTurn.Add(UpdateHappinessFromUnits)
GameEvents.UnitSetXY.Add(UpdateHappinessFromUnits)

--Determine if Rider has discovered all of the land tiles on his starting continent at the beginning of his turn.
--If he has, start a golden age based on its size and give him the Okeanos building.
function Okeanos(iPlayer)
	if iPlayer < GameDefines.MAX_MAJOR_CIVS then
		local pPlayer = Players[iPlayer]
		if pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_MACEDON_FSN then
			if not pPlayer:HasPolicy(iOkeanosDummyPolicy) then
				local pCity = pPlayer:GetCapitalCity()
				local pTeam = Teams[pPlayer:GetTeam()]
				local pArea = Map.GetArea(pCity:Plot():GetArea())
				if pArea:GetNumUnrevealedTiles(pTeam) <= 0 then
					print("Rider has discovered all of the tiles on his starting Continent!")
					--Current Golden Age formula:
					--Minimum length is 8 turns times the ResearchPercent of the current game speed, rounded down.
					--Add 1 turn for every 40 tiles, then multiply the total by the ResearchPercent.
					local iOkeanosGoldenAgeTurns = math.floor((pArea:GetNumTiles() / 40) * (GameInfo.GameSpeeds[PreGame.GetGameSpeed()].ResearchPercent / 100))
					print("Okeanos Golden Age turns from number of tiles on continent: " ..iOkeanosGoldenAgeTurns)
					if iOkeanosGoldenAgeTurns < iMinimumOkeanosGoldenAge then
						print("Turns from number of tiles less than the minimum.")
					end
					local iGoldenAge = math.max(iMinimumOkeanosGoldenAge, iOkeanosGoldenAgeTurns)
					pPlayer:ChangeGoldenAgeTurns(iGoldenAge)
					pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GOLDEN_AGE_BEGUN_ACTIVE_PLAYER, Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_RIDER_OKEANOS_TEXT", iGoldenAge), Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_RIDER_OKEANOS_TITLE"), -1, -1)
					pCity:SetNumRealBuilding(iOkeanosBuilding, 1)
					pPlayer:SetNumFreePolicies(1)
					pPlayer:SetNumFreePolicies(0)
					pPlayer:SetHasPolicy(iOkeanosDummyPolicy, true)
				end
			end
		end
	end
end

GameEvents.PlayerDoTurn.Add(Okeanos)