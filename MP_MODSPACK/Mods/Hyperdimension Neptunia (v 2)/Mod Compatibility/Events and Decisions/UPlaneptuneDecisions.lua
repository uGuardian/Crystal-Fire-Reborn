-- UPlaneptuneDecisions
-- Author: Vice
--------------------------------------------------------------


local BLAST_POLICY = GameInfoTypes.POLICY_DECISION_PLANEPTUNE_PL_BLAST
local DUMMY_NUKE = GameInfoTypes.UNIT_VV_PLUTIA_CLIMAX
local TOURISM_BOOST = 0
for row in GameInfo.Policy_TourismOnUnitCreation("PolicyType = 'POLICY_DECISION_PLANEPTUNE_PL_BLAST'") do
	TOURISM_BOOST = row.Tourism
	break
end
local COOLDOWN_TURNS		= 30
local PERSISTENT_TURN_COST	= 5
local DURATION				= 10

print("Plutia Decisions Loading")

--------------------------------------------------------------------------------------------------------------------------------------------
--Decision 1: Market Your Console with Blast Processing!
--------------------------------------------------------------------------------------------------------------------------------------------
local Decisions_UPlaneptuneBlast = {}
	Decisions_UPlaneptuneBlast.Name = "TXT_KEY_DECISIONS_VV_PLANEPTUNE_PL_BLAST"
	Decisions_UPlaneptuneBlast.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_VV_PLANEPTUNE_PL_BLAST_DESC")
	HookDecisionCivilizationIcon(Decisions_UPlaneptuneBlast, "CIVILIZATION_VV_PLANEPTUNE_PL")
	Decisions_UPlaneptuneBlast.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_VV_PLANEPTUNE_PL) and (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_VV_PLANEPTUNE_IH) then
			return false, false
		end

		if load(pPlayer, "Decisions_UPlaneptuneBlast") == true then
			Decisions_UPlaneptuneBlast.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_VV_PLANEPTUNE_PL_BLAST_ENACTED_DESC", TOURISM_BOOST)
			return false, false, true
		end

		local iGoldCost = math.ceil(500 * iMod)
		local iTourism = 0
		for row in GameInfo.Policy_TourismOnUnitCreation("PolicyType = 'POLICY_DECISION_PLANEPTUNE_PL_BLAST'") do
			iTourism = row.Tourism
			break
		end

		Decisions_UPlaneptuneBlast.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_VV_PLANEPTUNE_PL_BLAST_DESC", iGoldCost, TOURISM_BOOST)
		
		if pPlayer:GetGold() < iGoldCost then return true, false end
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end
		
		local pTeam = Teams[pPlayer:GetTeam()]
		local pTeamTechs = pTeam:GetTeamTechs()
		
		if pTeamTechs:HasTech(GameInfoTypes.TECH_PRINTING_PRESS) then 
			for pUnit in pPlayer:Units() do
				if pUnit:GetUnitClassType() == GameInfoTypes.UNITCLASS_WRITER then
					return true, true
				end
			end
			return true, false
		else
			return true, false
		end
	end
	)

	Decisions_UPlaneptuneBlast.DoFunc = (
	function(pPlayer)
		local iGoldCost = math.ceil(500 * iMod)
		pPlayer:ChangeGold(-iGoldCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)

		local iUnit;
		local iUnitType;
		local iX;
		local iY
		for pUnit in pPlayer:Units() do
			if pUnit:GetUnitClassType() == GameInfoTypes.UNITCLASS_WRITER then
				iUnit, iUnitType, iX, iY = pUnit:GetID(), pUnit:GetUnitType(), pUnit:GetX(), pUnit:GetY()
				pUnit:Kill(true)
			end
		end

		local bIsDVMC = false

		if GameInfo.CustomModOptions then
			for row in GameInfo.CustomModOptions() do
				if row.Name == "EVENTS_GREAT_PEOPLE" and row.Value == 1 then
					bIsDVMC = true
				end
			end
		end
		if bIsDVMC then
			GameEvents.GreatPersonExpended.Call(pPlayer:GetID(), iUnit, iUnitType, iX, iY)
		else
			GameEvents.GreatPersonExpended.Call(pPlayer:GetID(), iUnitType)
		end

		pPlayer:SetNumFreePolicies(1)
		pPlayer:SetNumFreePolicies(0)
		pPlayer:SetHasPolicy(BLAST_POLICY, true)

		save(pPlayer, "Decisions_UPlaneptuneBlast", true)
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_VV_PLANEPTUNE_PL, "Decisions_UPlaneptuneBlast", Decisions_UPlaneptuneBlast)
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_VV_PLANEPTUNE_IH, "Decisions_UPlaneptuneBlast", Decisions_UPlaneptuneBlast)



--------------------------------------------------------------------------------------------------------------------------------------------
--Decision 2: Reach Your Climax~
--------------------------------------------------------------------------------------------------------------------------------------------

local Decisions_UPlaneptuneClimax = {}
	Decisions_UPlaneptuneClimax.Name = "TXT_KEY_DECISIONS_VV_PLANEPTUNE_PL_CLIMAX"
	Decisions_UPlaneptuneClimax.Desc = "TXT_KEY_DECISIONS_VV_PLANEPTUNE_PL_CLIMAX_DESC"
	HookDecisionCivilizationIcon(Decisions_UPlaneptuneClimax, "CIVILIZATION_VV_PLANEPTUNE_PL")
	Decisions_UPlaneptuneClimax.CanFunc = (
	function(pPlayer)
		Decisions_UPlaneptuneClimax.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_VV_PLANEPTUNE_PL_CLIMAX_DESC", COOLDOWN_TURNS, PERSISTENT_TURN_COST, DURATION)


		if (pPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_VV_PLANEPTUNE_PL)  then
			return true, false
		elseif (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_VV_PLANEPTUNE_IH) then
			return false, false
		end

		local iLastTurn = load(pPlayer, "Decisions_UPlaneptuneClimax")
		if iLastTurn and (Game:GetGameTurn() - COOLDOWN_TURNS) < iLastTurn  then
			Decisions_UPlaneptuneClimax.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_VV_PLANEPTUNE_PL_CLIMAX_ENACTED_DESC")
			return false, false, true
		else
			save(pPlayer, "Decisions_UPlaneptuneClimax", nil)
		end

				
		local HDNMod = MapModData.HDNMod
		local iPlayer = pPlayer:GetID()
		if HDNMod.PersistentPolicies[iPlayer] and HDNMod.PersistentPolicies[iPlayer]["TRAIT_VV_IRIS_HEART"] 
		and HDNMod.PersistentPolicies[iPlayer]["TRAIT_VV_IRIS_HEART"].Turns and HDNMod.PersistentPolicies[iPlayer]["TRAIT_VV_IRIS_HEART"].Turns >= PERSISTENT_TURN_COST then
			return true, true
		else
			return true, false
		end
	end
	)

	Decisions_UPlaneptuneClimax.DoFunc = (
	function(pPlayer)

		local HDNMod = MapModData.HDNMod
		local iPlayer = pPlayer:GetID()
		HDNMod.PersistentPolicies[iPlayer]["TRAIT_VV_IRIS_HEART"].Turns = HDNMod.PersistentPolicies[iPlayer]["TRAIT_VV_IRIS_HEART"].Turns - PERSISTENT_TURN_COST

		
		local pCapital = pPlayer:GetCapitalCity()
		if pCapital then
			local pUnit = pPlayer:InitUnit(DUMMY_NUKE, pCapital:GetX(), pCapital:GetY())
		end
		save(pPlayer, "Decisions_UPlaneptuneClimax", Game:GetGameTurn())
	end
	)
	
	Decisions_UPlaneptuneClimax.Monitors = {}
	Decisions_UPlaneptuneClimax.Monitors[GameEvents.PlayerDoTurn] = (function(iPlayer)
		local pPlayer = Players[iPlayer]
		local iLastTurn = load(pPlayer, "Decisions_UPlaneptuneClimax")
		if iLastTurn and (Game:GetGameTurn() - DURATION) <= iLastTurn  then
			for pUnit in pPlayer:Units() do
				if pUnit:GetUnitClassType() == DUMMY_NUKE then pUnit:Kill(true) end
			end
		end
	end)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_VV_PLANEPTUNE_PL, "Decisions_UPlaneptuneClimax", Decisions_UPlaneptuneClimax)
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_VV_PLANEPTUNE_IH, "Decisions_UPlaneptuneClimax", Decisions_UPlaneptuneClimax)

print("Plutia Decisions Load Complete")