-- BigBossEvents
-- Author: Vicevirtuoso
-- DateCreated: 9/11/2014 4:48:02 PM
--------------------------------------------------------------


--=======================================================================================================================
-- Event 1: Lost Salvage Container (Random)
--=======================================================================================================================
local Event_MSFSalvageContainer = {}
	Event_MSFSalvageContainer.Name = "TXT_KEY_EVENT_BIGBOSS_LOST_SALVAGE"
	Event_MSFSalvageContainer.Desc = "TXT_KEY_EVENT_BIGBOSS_LOST_SALVAGE_DESC"
	Event_MSFSalvageContainer.Weight = 10
	Event_MSFSalvageContainer.Data1 = nil
	Event_MSFSalvageContainer.tValidCivs = 
	{
		["CIVILIZATION_MSF"]		= true,
	}
	Event_MSFSalvageContainer.CanFunc = (
		function(pPlayer)		
			if not MapModData.MSF.MSFSalvage[pPlayer:GetID()] then return false end

			if MapModData.MSF.MSFSalvage[pPlayer:GetID()] <= 100 then return false end

			local iRandSalvageMod = 0.01 * (Game.Rand(49, "MSF Event Salvage Random Roll") + 1)

			Event_MSFSalvageContainer.Data1 = math.ceil(MapModData.MSF.MSFSalvage[pPlayer:GetID()] * iRandSalvageMod)
			
			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			return Event_MSFSalvageContainer.tValidCivs[sCivType]
		end
		)
	Event_MSFSalvageContainer.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_MSFSalvageContainer.Outcomes[1] = {}
	Event_MSFSalvageContainer.Outcomes[1].Name = "TXT_KEY_EVENT_BIGBOSS_LOST_SALVAGE_OUTCOME_1"
	Event_MSFSalvageContainer.Outcomes[1].Desc = "TXT_KEY_EVENT_BIGBOSS_LOST_SALVAGE_OUTCOME_1_RESULT"
	Event_MSFSalvageContainer.Outcomes[1].Weight = 5
	Event_MSFSalvageContainer.Outcomes[1].CanFunc = (
		function(pPlayer, iSalvage)	

			Event_MSFSalvageContainer.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_BIGBOSS_LOST_SALVAGE_OUTCOME_1_RESULT", iSalvage)

			return true
		end
		)
	Event_MSFSalvageContainer.Outcomes[1].DoFunc = (
		function(pPlayer, iSalvage) 

			MapModData.MSF.MSFSalvage[pPlayer:GetID()] = MapModData.MSF.MSFSalvage[pPlayer:GetID()] - iSalvage

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_BIGBOSS_LOST_SALVAGE_OUTCOME_RESULT_1_NOTIFICATION"), Locale.ConvertTextKey(Event_MSFSalvageContainer.Name))
		end
		)

	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_MSFSalvageContainer.Outcomes[2] = {}
	Event_MSFSalvageContainer.Outcomes[2].Name = "TXT_KEY_EVENT_BIGBOSS_LOST_SALVAGE_OUTCOME_2"
	Event_MSFSalvageContainer.Outcomes[2].Desc = "TXT_KEY_EVENT_BIGBOSS_LOST_SALVAGE_OUTCOME_2_RESULT"
	Event_MSFSalvageContainer.Outcomes[2].Weight = 5
	Event_MSFSalvageContainer.Outcomes[2].CanFunc = (
		function(pPlayer, iSalvage)

			local iGold = iSalvage * 4

			if pPlayer:GetGold() < iGold then return false end

			Event_MSFSalvageContainer.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_BIGBOSS_LOST_SALVAGE_OUTCOME_2_RESULT", iGold)
				
			return true
		end
		)
	Event_MSFSalvageContainer.Outcomes[2].DoFunc = (
		function(pPlayer, iSalvage) 

			local iGold = iSalvage * 4

			pPlayer:ChangeGold(-iGold)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_BIGBOSS_LOST_SALVAGE_OUTCOME_RESULT_2_NOTIFICATION"), Locale.ConvertTextKey(Event_MSFSalvageContainer.Name))
		end
		)
		

for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_MSFSalvageContainer.tValidCivs[sCiv] then
			tEvents.Event_MSFSalvageContainer = Event_MSFSalvageContainer
			break
		end
	end
end



--=======================================================================================================================
-- Event 2: Rainbow Snake (Random after Renaissance, happens only once)
--=======================================================================================================================

local Event_MSFRainbowSnake = {}
	Event_MSFRainbowSnake.Name = "TXT_KEY_EVENT_BIGBOSS_RAINBOW_SNAKE"
	Event_MSFRainbowSnake.Desc = "TXT_KEY_EVENT_BIGBOSS_RAINBOW_SNAKE_DESC"
	Event_MSFRainbowSnake.Weight = 5
	Event_MSFRainbowSnake.tValidCivs = 
	{
		["CIVILIZATION_MSF"]		= true,
	}
	Event_MSFRainbowSnake.CanFunc = (
		function(pPlayer)			
			if pPlayer:GetCurrentEra() < GameInfoTypes.ERA_RENAISSANCE then return false end

			local sCivType = GameInfo.Civilizations[pPlayer:GetCivilizationType()].Type
			return Event_MSFRainbowSnake.tValidCivs[sCivType]
		end
		)
	Event_MSFRainbowSnake.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_MSFRainbowSnake.Outcomes[1] = {}
	Event_MSFRainbowSnake.Outcomes[1].Name = "TXT_KEY_EVENT_BIGBOSS_RAINBOW_SNAKE_OUTCOME_1"
	Event_MSFRainbowSnake.Outcomes[1].Desc = "TXT_KEY_EVENT_BIGBOSS_RAINBOW_SNAKE_OUTCOME_RESULT_1"
	Event_MSFRainbowSnake.Outcomes[1].CanFunc = (
		function(pPlayer)
			
			local iCulture = pPlayer:GetTotalJONSCulturePerTurn() * 3

			Event_MSFRainbowSnake.Outcomes[1].Desc = Locale.ConvertTextKey("TXT_KEY_EVENT_BIGBOSS_RAINBOW_SNAKE_OUTCOME_RESULT_1", iCulture)
				
			return true
		end
		)
	Event_MSFRainbowSnake.Outcomes[1].DoFunc = (
		function(pPlayer) 
			pPlayer:ChangeJONSCulture(pPlayer:GetTotalJONSCulturePerTurn() * 3)

			local pCapital = pPlayer:GetCapitalCity()

			if pCapital then
				pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_DECISION_BIGBOSS, 1)
			end

			save(pPlayer, "Event_MSFRainbowSnake", true)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_BIGBOSS_RAINBOW_SNAKE_OUTCOME_RESULT_1_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_BIGBOSS_RAINBOW_SNAKE"))
		end)
	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_MSFRainbowSnake.Outcomes[2] = {}
	Event_MSFRainbowSnake.Outcomes[2].Name = "TXT_KEY_EVENT_BIGBOSS_RAINBOW_SNAKE_OUTCOME_2"
	Event_MSFRainbowSnake.Outcomes[2].Desc = "TXT_KEY_EVENT_BIGBOSS_RAINBOW_SNAKE_OUTCOME_RESULT_2"
	Event_MSFRainbowSnake.Outcomes[2].CanFunc = (
		function(pPlayer)
			local pCapital = pPlayer:GetCapitalCity()

			if pCapital then
				return true
			else
				return false
			end
		end
		)
	Event_MSFRainbowSnake.Outcomes[2].DoFunc = (
		function(pPlayer) 

			local pCapital = pPlayer:GetCapitalCity()

			if pCapital then
				pCapital:ChangePopulation(2, true)
			end

			save(pPlayer, "Event_MSFRainbowSnake", true)


			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_BIGBOSS_RAINBOW_SNAKE_OUTCOME_RESULT_2_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_BIGBOSS_RAINBOW_SNAKE"))
		end)


	--=========================================================
	-- Outcome 3
	--=========================================================
	Event_MSFRainbowSnake.Outcomes[3] = {}
	Event_MSFRainbowSnake.Outcomes[3].Name = "TXT_KEY_EVENT_BIGBOSS_RAINBOW_SNAKE_OUTCOME_3"
	Event_MSFRainbowSnake.Outcomes[3].Desc = "TXT_KEY_EVENT_BIGBOSS_RAINBOW_SNAKE_OUTCOME_RESULT_3"
	Event_MSFRainbowSnake.Outcomes[3].CanFunc = (
		function(pPlayer)
			return true
		end
		)
	Event_MSFRainbowSnake.Outcomes[3].DoFunc = (
		function(pPlayer) 

			pPlayer:ChangeGoldenAgeTurns(math.ceil(pPlayer:GetGoldenAgeLength() * 1.5))

			save(pPlayer, "Event_MSFRainbowSnake", true)


			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_BIGBOSS_RAINBOW_SNAKE_OUTCOME_RESULT_3_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_BIGBOSS_RAINBOW_SNAKE"))
		end)
	

for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_MSFRainbowSnake.tValidCivs[sCiv] then
			tEvents.Event_MSFRainbowSnake = Event_MSFRainbowSnake
			break
		end
	end
end



--=======================================================================================================================
-- Event 3: Tribute to Speedball's LP (random with high weight in Industrial, only if Ocelot is on the map and other conditions are met)
--=======================================================================================================================

local Event_MSFSpeedball = {}
	Event_MSFSpeedball.Name = "TXT_KEY_EVENT_BIGBOSS_SPEEDBALL"
	Event_MSFSpeedball.Desc = "TXT_KEY_EVENT_BIGBOSS_SPEEDBALL_DESC"
	Event_MSFSpeedball.Weight = 30
	Event_MSFSpeedball.Data1 = nil
	Event_MSFSpeedball.tValidCivs = 
	{
		["CIVILIZATION_MSF"]		= true,
	}
	Event_MSFSpeedball.CanFunc = (
		function(pPlayer)			
			Event_MSFSpeedball.Desc = "TXT_KEY_EVENT_BIGBOSS_SPEEDBALL_DESC"
			if not pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_MSF then return false end

			if load(pPlayer, "Event_MSFSpeedball") then return false end

			if not pPlayer:GetCurrentEra() >= EraTypes.ERA_FUTURE then return false end

			for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
				local pLoop = Players[i]
				if pLoop ~= pPlayer and pLoop:IsAlive() then
					if pLoop:GetCivilizationType() == GameInfoTypes.CIVILIZATION_OUTER_HEAVEN then
						if pLoop:GetCapitalCity():IsOriginalCapital() then
							if pPlayer:GetInfluenceLevel(i) < InfluenceLevelTypes.INFLUENCE_LEVEL_INFLUENTIAL then
								Event_MSFSpeedball.Data1 = pLoop
								return true
							end
						end
					end
				end
			end
			
			return false
		end
		)
	Event_MSFSpeedball.Outcomes = {}
	--=========================================================
	-- Outcome 1
	--=========================================================
	Event_MSFSpeedball.Outcomes[1] = {}
	Event_MSFSpeedball.Outcomes[1].Name = "TXT_KEY_EVENT_BIGBOSS_SPEEDBALL_OUTCOME_1"
	Event_MSFSpeedball.Outcomes[1].Desc = "TXT_KEY_EVENT_BIGBOSS_SPEEDBALL_OUTCOME_RESULT_1"
	Event_MSFSpeedball.Outcomes[1].CanFunc = (
		function(pPlayer)			
			return true
		end
		)
	Event_MSFSpeedball.Outcomes[1].DoFunc = (
		function(pPlayer, pEnemyPlayer) 
			
			local pTeam = Teams[pPlayer:GetTeam()]
			local iEnemyTeam = pEnemyPlayer:GetTeam()

			pTeam:DeclareWar(iEnemyTeam)
			pTeam:SetPermanentWarPeace(iEnemyTeam, true)	
			
			GameEvents.PlayerDoTurn.Add(OnTurnSpeedball)
			GameEvents.UnitSetXY.Add(OnMoveSpeedball)		

			save(pPlayer, "Event_MSFSpeedball", pEnemyPlayer:GetID())

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_BIGBOSS_SPEEDBALL_OUTCOME_RESULT_1_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_BIGBOSS_SPEEDBALL"))
		end
		)


	--=========================================================
	-- Outcome 2
	--=========================================================
	Event_MSFSpeedball.Outcomes[2] = {}
	Event_MSFSpeedball.Outcomes[2].Name = "TXT_KEY_EVENT_BIGBOSS_SPEEDBALL_OUTCOME_2"
	Event_MSFSpeedball.Outcomes[2].Desc = "TXT_KEY_EVENT_BIGBOSS_SPEEDBALL_OUTCOME_RESULT_2"
	Event_MSFSpeedball.Outcomes[2].CanFunc = (
		function(pPlayer)			
			return true
		end
		)
	Event_MSFSpeedball.Outcomes[2].DoFunc = (
		function(pPlayer) 

			save(pPlayer, "Event_MSFSpeedball", true)

			JFD_SendNotification(pPlayer:GetID(), "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_BIGBOSS_SPEEDBALL_OUTCOME_RESULT_2_NOTIFICATION"), Locale.ConvertTextKey("TXT_KEY_EVENT_BIGBOSS_SPEEDBALL"))
		end
		)

		
for iSlot = 0, GameDefines.MAX_MAJOR_CIVS-1, 1 do
	local slotStatus = PreGame.GetSlotStatus(iSlot)
	if (slotStatus == SlotStatus["SS_TAKEN"] or slotStatus == SlotStatus["SS_COMPUTER"]) then
		local iCiv = PreGame.GetCivilization(iSlot)
		local sCiv = GameInfo.Civilizations[iCiv].Type
		if Event_MSFSpeedball.tValidCivs[sCiv] then
			tEvents.Event_MSFSpeedball = Event_MSFSpeedball
			break
		end
	end
end

local iMaxCivs = GameDefines.MAX_MAJOR_CIVS
local iOcelotPromotion = GameInfoTypes.PROMOTION_DECISIONS_BIGBOSS
local iOuterHeaven = GameInfoTypes.CIVILIZATION_OUTER_HEAVEN

function OnTurnSpeedball(iPlayer)
	if iPlayer < iMaxCivs then
		local pPlayer = Players[iPlayer]
		if pPlayer:IsAlive() then
			if load(pPlayer, "Event_MSFSpeedball") and load(pPlayer, "Event_MSFSpeedball") ~= true then
				local pEnemyPlayer = Players[load(pPlayer, "Event_MSFSpeedball")]
				if pEnemyPlayer then
					if pEnemyPlayer:IsAlive() then
						if pPlayer:GetInfluenceLevel(pEnemyPlayer:GetID()) >= InfluenceLevelTypes.INFLUENCE_LEVEL_INFLUENTIAL then
							JFD_SendNotification(iPlayer, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_BIGBOSS_SPEEDBALL_VICTORIOUS_TEXT"), Locale.ConvertTextKey("TXT_KEY_BIGBOSS_SPEEDBALL_VICTORIOUS_TITLE"))

							local pTeam = Teams[pPlayer:GetTeam()]
							local iEnemyTeam = pEnemyPlayer:GetTeam()

							pTeam:MakePeace(iEnemyTeam)

							for pUnit in pEnemyPlayer:Units() do
								pUnit:SetHasPromotion(iOcelotPromotion, false)
							end

							PreGame.SetLeaderName(iPlayer, "TXT_KEY_LEADER_BIGBOSS_SPEEDBALL")

							local pCapital = pPlayer:GetCapitalCity()
							if pCapital then
								pCapital:SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_BIGBOSS_SPEEDBALL, 1)
							end

							GameEvents.PlayerDoTurn.Remove(OnTurnSpeedball)
							GameEvents.UnitSetXY.Remove(OnMoveSpeedball)	
							
							save(pPlayer, "Event_MSFSpeedball", true)
						end
					else
						JFD_SendNotification(iPlayer, "NOTIFICATION_GENERIC", Locale.ConvertTextKey("TXT_KEY_BIGBOSS_SPEEDBALL_KILLED_OCELOT_TEXT"), Locale.ConvertTextKey("TXT_KEY_BIGBOSS_SPEEDBALL_KILLED_OCELOT_TITLE"))
						save(pPlayer, "Event_MSFSpeedball", true)
					end
				end
			end
		elseif pPlayer:GetCivilizationType() == iOuterHeaven then
			for i = 0, iMaxCivs - 1, 1 do
				local pEnemyPlayer = Players[i]
				if load(pEnemyPlayer, "Event_MSFSpeedball") and load(pEnemyPlayer, "Event_MSFSpeedball") ~= true then
					if load(pEnemyPlayer, "Event_MSFSpeedball") == iPlayer then
						for pUnit in pPlayer:Units() do
							OcelotTestUnitSpeedball(pUnit, i, pUnit:GetX(), pUnit:GetY())
						end
					end
				end
			end
		end
	end
end


function OnMoveSpeedball(iPlayer, iUnit, iX, iY)
	if iPlayer < iMaxCivs and iX > 0 and iY > 0 then
		local pPlayer = Players[iPlayer]
		if pPlayer:GetCivilizationType() == iOuterHeaven then
		elseif pPlayer:GetCivilizationType() == iOuterHeaven then
			for i = 0, iMaxCivs - 1, 1 do
				local pEnemyPlayer = Players[i]
				if load(pEnemyPlayer, "Event_MSFSpeedball") and load(pEnemyPlayer, "Event_MSFSpeedball") ~= true then
					if load(pEnemyPlayer, "Event_MSFSpeedball") == iPlayer then
						local pUnit = pPlayer:GetUnitByID(iUnitID)
						OcelotTestUnitSpeedball(pUnit, i, iX, iY)
					end
				end
			end
		end
	end
end


function OcelotTestUnitSpeedball(pUnit, iEnemyPlayer, iX, iY)
	if not pUnit:IsCombatUnit() then return end
	local pPlot = Map.GetPlot(iX, iY)
	if pPlot:GetOwner() == iEnemyPlayer then
		pUnit:SetHasPromotion(iOcelotPromotion, true)
	else
		pUnit:SetHasPromotion(iOcelotPromotion, false)
	end
end