-- PMMMMamiDecisions
-- Author: Vicevirtuoso
-- DateCreated: 8/25/2014 2:01:14 PM
--------------------------------------------------------------

local iJapanese = GameInfoTypes.POLICY_DECISIONS_MAMI_JAPANESE
local iItalian = GameInfoTypes.POLICY_DECISIONS_MAMI_ITALIAN
local iDoctrine = GameInfoTypes.POLICY_DECISIONS_MAMI_MAMMIE_DOCTRINE


local tJapaneseCityNames = {}
local tItalianCityNames = {}
local sLocale = Locale.GetCurrentLanguage().Type

for query in DB.Query("SELECT Tag FROM Language_"..sLocale.." WHERE Tag LIKE 'TXT_KEY_CITY_NAME_MADOMAGI_%_DECISIONS_JAPANESE'") do
	tJapaneseCityNames[#tJapaneseCityNames + 1] = {
		["Name"] = query.Tag,
		["Taken"] = false
	}
end

--Find at game load which of these city names are already taken
for iPlayer, pPlayer in pairs(Players) do
	for pCity in pPlayer:Cities() do
		for k, v in pairs(tJapaneseCityNames) do
			if pCity:GetNameKey() == v.Name then
				v.Taken = true
				break
			end
		end
	end
end


local function GetMamiJapaneseCityName(iX, iY, iOldPop, iNewPop)
	if iOldPop == 0 then
		local pCity = Map.GetPlot(iX, iY):GetPlotCity()
		if pCity then
			for k, v in ipairs(tJapaneseCityNames) do
				if v.Taken ~= true then
					pCity:SetName(v.Name)
					v.Taken = true
				end
			end
		end
	end
end



function IsMammieAffectedPMMMCiv(pPlayer)
	if pPlayer:GetLeaderType() == GameInfoTypes.LEADER_ORIGINAL_MADOKA or pPlayer:GetLeaderType() == GameInfoTypes.LEADER_SAYAKA or pPlayer:GetLeaderType() == GameInfoTypes.LEADER_KYOUKO or pPlayer:GetLeaderType() == GameInfoTypes.LEADER_NAGISA then
		return true
	else
		return false
	end
end

local Decisions_MamiJapanese = {}
	Decisions_MamiJapanese.Name = "TXT_KEY_DECISIONS_MAMI_JAPANESE"
	Decisions_MamiJapanese.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MAMI_JAPANESE_DESC")
	HookDecisionCivilizationIcon(Decisions_MamiJapanese, "CIVILIZATION_MAMI")
	Decisions_MamiJapanese.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_MAMI) then
			return false, false
		end

		--The AI should not enact this if Italian is already enacted (to prevent them burning all their Gold/Magistrates on it)
		if not pPlayer:IsHuman() and load(pPlayer, "Decisions_MamiItalian") == true then
			return false, false
		end

		if load(pPlayer, "Decisions_MamiJapanese") == true then
			Decisions_MamiJapanese.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MAMI_JAPANESE_ENACTED_DESC")
			return false, false, true
		end
		
		local iCost = math.ceil(200 * iMod)
		Decisions_MamiJapanese.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MAMI_JAPANESE_DESC", iCost)
		
		if pPlayer:GetGold() < iCost then return true, false end
		
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end

		local pTeam = Teams[pPlayer:GetTeam()]
		local pTeamTechs = pTeam:GetTeamTechs()
		
		if pTeamTechs:HasTech(GameInfoTypes.TECH_WRITING) then 
			return true, true
		else
			return true, false
		end
	
	end
	)
	
	Decisions_MamiJapanese.DoFunc = (
	function(pPlayer)
		local iCost = math.ceil(200 * iMod)
		pPlayer:ChangeGold(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)

		if pPlayer:HasPolicy(iItalian) then
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetHasPolicy(iItalian, false)
			pPlayer:SetNumFreePolicies(0)
		end

		if not pPlayer:HasPolicy(iJapanese) then
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetHasPolicy(iJapanese, true)
			pPlayer:SetNumFreePolicies(0)
		end

		for pCity in pPlayer:Cities() do
			local sKey = pCity:GetNameKey()
			sKey = sKey.."_DECISIONS_JAPANESE"
			if Locale.ConvertTextKey(sKey) ~= sKey then
				for k, v in ipairs(tJapaneseCityNames) do
					if v.Name == sKey and v.Taken ~= true then
						pCity:SetName(sKey)
						v.Taken = true
						break
					end
				end
			end
		end

		PreGame.SetCivilizationAdjective(pPlayer:GetID(), "TXT_KEY_CIV_MAMI_ADJECTIVE_DECISIONS_JAPANESE")
		PreGame.SetCivilizationDescription(pPlayer:GetID(), "TXT_KEY_CIV_MAMI_DESC_DECISIONS_JAPANESE")
		PreGame.SetCivilizationShortDescription(pPlayer:GetID(), "TXT_KEY_CIV_MAMI_SHORT_DESC_DECISIONS_JAPANESE")
		save(pPlayer, "Decisions_MamiJapanese", true)
		save(pPlayer, "Decisions_MamiItalian", false)
		save(pPlayer, "Decisions_MamiRepeal", false) 
	end
	)

	Decisions_MamiJapanese.Monitors = {}
	Decisions_MamiJapanese.Monitors[GameEvents.SetPopulation] = GetMamiJapaneseCityName

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_MAMI, "Decisions_MamiJapanese", Decisions_MamiJapanese)


local Decisions_MamiItalian = {}
	Decisions_MamiItalian.Name = "TXT_KEY_DECISIONS_MAMI_ITALIAN"
	Decisions_MamiItalian.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MAMI_ITALIAN_DESC")
	HookDecisionCivilizationIcon(Decisions_MamiItalian, "CIVILIZATION_MAMI")
	Decisions_MamiItalian.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_MAMI) then
			return false, false
		end

		--The AI should not enact this if Japanese is already enacted (to prevent them burning all their Gold/Magistrates on it)
		if not pPlayer:IsHuman() and load(pPlayer, "Decisions_MamiJapanese") == true then
			return false, false
		end

		if load(pPlayer, "Decisions_MamiItalian") then
			Decisions_MamiItalian.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MAMI_ITALIAN_ENACTED_DESC")
			return false, false, true
		end
		
		local iCost = math.ceil(200 * iMod)
		Decisions_MamiItalian.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MAMI_ITALIAN_DESC", iCost)
		
		if pPlayer:GetGold() < iCost then return true, false end
		
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end

		local pTeam = Teams[pPlayer:GetTeam()]
		local pTeamTechs = pTeam:GetTeamTechs()
		
		if pTeamTechs:HasTech(GameInfoTypes.TECH_WRITING) then 
			return true, true
		else
			return true, false
		end
	
	end
	)
	
	Decisions_MamiItalian.DoFunc = (
	function(pPlayer)
		local iCost = math.ceil(200 * iMod)
		pPlayer:ChangeGold(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)

		if pPlayer:HasPolicy(iJapanese) then
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetHasPolicy(iJapanese, false)
			pPlayer:SetNumFreePolicies(0)
		end

		if not pPlayer:HasPolicy(iItalian) then
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetHasPolicy(iItalian, true)
			pPlayer:SetNumFreePolicies(0)
		end
		
		for pCity in pPlayer:Cities() do
			local sKey = pCity:GetNameKey()
			if string.find(sKey, "_DECISIONS_JAPANESE") then
				local iStart, iEnd = string.find(sKey, "_DECISIONS_JAPANESE")
				sKey = string.sub(sKey, 1, iStart)
				if Locale.ConvertTextKey(sKey) ~= sKey then
					local bTaken = false
					--loop through every city in the world to see if the name got taken by someone else!
					for iLoopPlayer, pLoopPlayer in pairs(Players) do
						for pCity in pLoopPlayer:Cities() do
							if pCity:GetNameKey() == v.Name then
								bTaken = true
								break
							end
						end
					end
					if not bTaken then
						pCity:SetName(sKey)
					end
				end
			end
		end
		PreGame.SetCivilizationAdjective(pPlayer:GetID(), "TXT_KEY_CIV_MAMI_ADJECTIVE")
		PreGame.SetCivilizationDescription(pPlayer:GetID(), "TXT_KEY_CIV_MAMI_DESC")
		PreGame.SetCivilizationShortDescription(pPlayer:GetID(), "TXT_KEY_CIV_MAMI_SHORT_DESC")

		GameEvents.SetPopulation.Remove(GetMamiJapaneseCityName)

		save(pPlayer, "Decisions_MamiItalian", true)
		save(pPlayer, "Decisions_MamiJapanese", false)
		save(pPlayer, "Decisions_MamiRepeal", false) 
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_MAMI, "Decisions_MamiItalian", Decisions_MamiItalian)


local Decisions_MamiRepeal = {}
	Decisions_MamiRepeal.Name = "TXT_KEY_DECISIONS_MAMI_REPEAL_LANGUAGE"
	Decisions_MamiRepeal.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MAMI_REPEAL_LANGUAGE_DESC")
	HookDecisionCivilizationIcon(Decisions_MamiRepeal, "CIVILIZATION_MAMI")
	Decisions_MamiRepeal.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_MAMI) then
			return false, false
		end

		--The AI will never pass the repeal
		if not pPlayer:IsHuman() then
			return false, false
		end

		if load(pPlayer, "Decisions_MamiRepeal") then
			Decisions_MamiRepeal.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MAMI_REPEAL_LANGUAGE_ENACTED_DESC")
			return false, false, true
		end
		
		local iCost = math.ceil(200 * iMod)
		Decisions_MamiRepeal.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MAMI_REPEAL_LANGUAGE_DESC", iCost)
		
		if pPlayer:GetGold() < iCost then return true, false end
		
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end

		if load(pPlayer, "Decisions_MamiItalian") == true or load(pPlayer, "Decisions_MamiJapanese") == true then
			return true, true
		else
			return true, false
		end
	
	end
	)
	
	Decisions_MamiRepeal.DoFunc = (
	function(pPlayer)
		local iCost = math.ceil(200 * iMod)
		pPlayer:ChangeGold(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)

		if pPlayer:HasPolicy(iItalian) then
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetHasPolicy(iItalian, false)
			pPlayer:SetNumFreePolicies(0)
		end

		if not pPlayer:HasPolicy(iJapanese) then
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetHasPolicy(iJapanese, false)
			pPlayer:SetNumFreePolicies(0)
		end

		save(pPlayer, "Decisions_MamiItalian", false)
		save(pPlayer, "Decisions_MamiJapanese", false)
		save(pPlayer, "Decisions_MamiRepeal", true)

		--The repeal function will keep the current city/civ naming scheme
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_MAMI, "Decisions_MamiRepeal", Decisions_MamiRepeal)


local Decisions_MammieDoctrine = {}
	Decisions_MammieDoctrine.Name = "TXT_KEY_DECISIONS_MAMI_MAMMIE_DOCTRINE"
	Decisions_MammieDoctrine.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MAMI_MAMMIE_DOCTRINE_DESC")
	HookDecisionCivilizationIcon(Decisions_MammieDoctrine, "CIVILIZATION_MAMI")
	Decisions_MammieDoctrine.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_MAMI) then
			return false, false
		end
		if load(pPlayer, "Decisions_MammieDoctrine") then
			Decisions_MammieDoctrine.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MAMI_MAMMIE_DOCTRINE_ENACTED_DESC")
			return false, false, true
		end
		
		local iCost = math.ceil(600 * iMod)
		Decisions_MammieDoctrine.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MAMI_MAMMIE_DOCTRINE_DESC", iCost)
		
		if pPlayer:GetJONSCulture() < iCost then return true, false end
		
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end

		if pPlayer:GetExcessHappiness() >= 15 then
			return true, true
		else
			return true, false
		end
	
	end
	)
	
	Decisions_MammieDoctrine.DoFunc = (
	function(pPlayer)
		local iCost = math.ceil(600 * iMod)
		pPlayer:ChangeJONSCulture(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		pPlayer:SetNumFreePolicies(1)
		pPlayer:SetNumFreePolicies(0)
		pPlayer:SetHasPolicy(iDoctrine, true)
		save(pPlayer, "Decisions_MammieDoctrine", true)
	end
	)

	Decisions_MammieDoctrine.Monitors = {}
	Decisions_MammieDoctrine.Monitors[GameEvents.GetDiploModifier] =  (
	function (iEvent, iFromPlayer, iToPlayer)
		local pFromPlayer = Players[iFromPlayer]
		local pToPlayer = Players[iToPlayer]
		if load(pFromPlayer, "Decisions_MammieDoctrine") or load(pToPlayer, "Decisions_MammieDoctrine") then
			if iEvent == GameInfoTypes.DIPLOMODIFIER_PMMM_DECISIONS_MAMI_FROM_MALE then
				if pFromPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_MAMI then
					if (Locale.ConvertTextKey("{@1: gender feminine?yes; other?no}", pToPlayer:GetNameKey()) ~= "yes") and pToPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_BRITAIN_FSN then
						return -30
					else
						return 0 
					end
				else
					return 0
				end
			elseif iEvent == GameInfoTypes.DIPLOMODIFIER_PMMM_DECISIONS_MAMI_FROM_MG then
				if pFromPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_MAMI then
					if IsMammieAffectedPMMMCiv(pToPlayer) then
						return -30
					else
						return 0 
					end
				else
					return 0
				end
			elseif iEvent == GameInfoTypes.DIPLOMODIFIER_PMMM_DECISIONS_MAMI_TO_MAMI then
				if pToPlayer:GetCivilizationType() == GameInfoTypes.CIVILIZATION_MAMI then
					if (Locale.ConvertTextKey("{@1: gender feminine?yes; other?no}", pFromPlayer:GetNameKey()) ~= "yes") and pFromPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_BRITAIN_FSN then
						return -30
					elseif IsMammieAffectedPMMMCiv(pFromPlayer) then
						return -30
					else
						return 0
					end
				else
					return 0 
				end
			end
		else
			return 0
		end
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_MAMI, "Decisions_MammieDoctrine", Decisions_MammieDoctrine)
