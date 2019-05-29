-- MikuDecisions
-- Author: Vicevirtuoso
-- DateCreated: 8/25/2014 2:01:53 PM
--------------------------------------------------------------


local Decisions_HappinessPeaceOfMind = {}
	Decisions_HappinessPeaceOfMind.Name = "TXT_KEY_DECISIONS_MIKU_HAPPINESS_COMMITTEE"
	Decisions_HappinessPeaceOfMind.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MIKU_HAPPINESS_COMMITTEE_DESC")
	HookDecisionCivilizationIcon(Decisions_HappinessPeaceOfMind, "CIVILIZATION_VOCALOID")
	Decisions_HappinessPeaceOfMind.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_VOCALOID) then
			return false, false
		end
		local iTurnMod = math.ceil(10 * iMod)
		if load(pPlayer, "Decisions_HappinessPeaceOfMind") then
			Decisions_HappinessPeaceOfMind.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MIKU_HAPPINESS_COMMITTEE_ENACTED_DESC", iTurnMod)
			return false, false, true
		end
		
		local iCost = math.ceil(800 * iMod)

		Decisions_HappinessPeaceOfMind.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MIKU_HAPPINESS_COMMITTEE_DESC", iCost, iTurnMod)
		
		if pPlayer:GetGold() < iCost then return true, false end
		
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end

		local pTeam = Teams[pPlayer:GetTeam()]
		local pTeamTechs = pTeam:GetTeamTechs()
		
		if not pTeamTechs:HasTech(GameInfoTypes.TECH_CIVIL_SERVICE) then return true, false end

		if pPlayer:GetExcessHappiness() <= -10 then
			return true, true
		else
			return true, false
		end
	
	end
	)
	
	Decisions_HappinessPeaceOfMind.DoFunc = (
	function(pPlayer)
		local iCost = math.ceil(800 * iMod)
		pPlayer:ChangeGold(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		pPlayer:GetCapitalCity():SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_MIKU_HPMC, 1)
		save(pPlayer, "Decisions_HappinessPeaceOfMind", Game:GetGameTurn())
	end
	)

	Decisions_HappinessPeaceOfMind.Monitors = {}
	Decisions_HappinessPeaceOfMind.Monitors[GameEvents.PlayerDoTurn] =  (
	function(iPlayer)
		local pPlayer = Players[iPlayer]
		if load(pPlayer, "Decisions_HappinessPeaceOfMind") and pPlayer:GetCapitalCity():IsHasBuilding(GameInfoTypes.BUILDING_DECISIONS_MIKU_HPMC) then
			local iTurn = Game:GetGameTurn()
			local iTurnMod = math.ceil(10 * iMod)
			iTurn = iTurn - load(pPlayer, "Decisions_HappinessPeaceOfMind")
			if iTurn % iTurnMod == 0 then
				local iNumCities = pPlayer:GetNumCities()
				if iNumCities > 0 then
					iChosenCity = Game.Rand(iNumCities - 1, "Miku HPMC Roll")
					for pCity in pPlayer:Cities() do
						if iChosenCity <= 0 and pCity:GetPopulation() > 1 then
							pCity:ChangePopulation(-1, true)
							local sText = Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_DECISIONS_MIKU_TEXT", pCity:GetName())
							local sTitle = Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_DECISIONS_MIKU_TITLE")
							pPlayer:AddNotification(NotificationTypes.NOTIFICATION_STARVING, sText, sTitle, pCity:GetX(), pCity:GetY())
							return
						else
							iChosenCity = iChosenCity - 1
						end
					end
				end
			end
		end
	end)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_VOCALOID, "Decisions_HappinessPeaceOfMind", Decisions_HappinessPeaceOfMind)

local Decisions_UTAUloid = {}
	Decisions_UTAUloid.Name = "TXT_KEY_DECISIONS_MIKU_UTAULOID"
	Decisions_UTAUloid.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MIKU_UTAULOID_DESC")
	HookDecisionCivilizationIcon(Decisions_UTAUloid, "CIVILIZATION_VOCALOID")
	Decisions_UTAUloid.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_VOCALOID) then
			return false, false
		end
		if load(pPlayer, "Decisions_UTAUloid") == true then
			Decisions_UTAUloid.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MIKU_UTAULOID_ENACTED_DESC")
			return false, false, true
		end

		local iAnarchy = math.ceil(3 * iMod)
		
		Decisions_UTAUloid.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MIKU_UTAULOID_DESC", iAnarchy)
		
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end

		local iRationalism = 0
		local iFreedom = 0

		for policy in GameInfo.Policies() do
			if pPlayer:HasPolicy(policy.ID) then
				if policy.PolicyBranchType then
					if policy.PolicyBranchType == "POLICY_BRANCH_RATIONALISM" then
						iRationalism = iRationalism + 1
						if iRationalism >= 2 then
							return true, true
						end
					elseif policy.PolicyBranchType == "POLICY_BRANCH_FREEDOM" then
						iFreedom = iFreedom + 1
						if iFreedom >= 3 then
							return true, true
						end
					end
				end
			end
		end
	
		return true, false
	end
	)
	
	Decisions_UTAUloid.DoFunc = (
	function(pPlayer)
		local iAnarchy = math.ceil(3 * iMod)
		pPlayer:ChangeAnarchyNumTurns(iAnarchy)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		pPlayer:GetCapitalCity():SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_MIKU_UTAULOID, 1)
		save(pPlayer, "Decisions_UTAUloid", true)
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_VOCALOID, "Decisions_UTAUloid", Decisions_UTAUloid)