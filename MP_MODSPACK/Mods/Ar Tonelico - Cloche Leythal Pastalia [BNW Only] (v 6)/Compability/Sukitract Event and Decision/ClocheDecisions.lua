-- Cloche Decisions
-- Author: LeonAzarola (Credits to Vicevirtuoso and Typholomence)
-- DateCreated: 5/10/2015 12:01:14 PM
--=======================================================================================================================
-- Includes
--=======================================================================================================================
include("FLuaVector");
include("IconSupport");
include("JFD_PietyUtils.lua");

local iHolyMaiden = GameInfoTypes.POLICY_DECISIONS_CLOCHE_HOLY_MAIDEN
local iMaidenofAqua = GameInfoTypes.POLICY_DECISIONS_CLOCHE_MAIDEN_OF_AQUA

---------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Coronation of Holy Maiden of Pastalia
---------------------------------------------------------------------------------------------------------------------------------------------------------------

local Decisions_ClocheHolyMaiden = {}
	Decisions_ClocheHolyMaiden.Name = "TXT_KEY_DECISIONS_CLOCHE_HOLY_MAIDEN"
	Decisions_ClocheHolyMaiden.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_CLOCHE_HOLY_MAIDEN_DESC")
	HookDecisionCivilizationIcon(Decisions_ClocheHolyMaiden, "CIVILIZATION_PASTALIA")
	Decisions_ClocheHolyMaiden.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_PASTALIA) then
			return false, false
		end

		--The AI should not enact this if MaidenofAqua is already enacted (to prevent them burning all their Faith/Magistrates on it)
		if not pPlayer:IsHuman()then
			return false, false
		end

		if load(pPlayer, "Decisions_ClocheMaidenofAqua") == true then
			return false, false
			end

		if load(pPlayer, "Decisions_ClocheHolyMaiden") == true then
			Decisions_ClocheHolyMaiden.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_CLOCHE_HOLY_MAIDEN_ENACTED_DESC")
			return false, false, true
		end
		
		local iCost = math.ceil(200 * iMod)
		Decisions_ClocheHolyMaiden.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_CLOCHE_HOLY_MAIDEN_DESC", iCost)
		
		if pPlayer:GetFaith() < iCost then return true, false end
		
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end

		local pTeam = Teams[pPlayer:GetTeam()]
		local pTeamTechs = pTeam:GetTeamTechs()
		
		if pTeamTechs:HasTech(GameInfoTypes.TECH_THEOLOGY) then 
			return true, true
		else
			return true, false
		end
	
	end
	)
	
	Decisions_ClocheHolyMaiden.DoFunc = (
	function(pPlayer)
		local iCost = math.ceil(200 * iMod)
		pPlayer:ChangeFaith(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)

		local iHolyMaiden = GameInfoTypes.POLICY_DECISIONS_CLOCHE_HOLY_MAIDEN
        local iMaidenofAqua = GameInfoTypes.POLICY_DECISIONS_CLOCHE_MAIDEN_OF_AQUA

		if pPlayer:HasPolicy(iMaidenofAqua) then
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetHasPolicy(iMaidenofAqua, false)
			pPlayer:SetNumFreePolicies(0)
		end

		if not pPlayer:HasPolicy(iHolyMaiden) then
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetHasPolicy(iHolyMaiden, true)
			pPlayer:SetNumFreePolicies(0)
		end

		save(pPlayer, "Decisions_ClocheHolyMaiden", true)
		save(pPlayer, "Decisions_ClocheMaidenofAqua", false)
		save(pPlayer, "Decisions_ClocheRepeal", false) 
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_PASTALIA, "Decisions_ClocheHolyMaiden", Decisions_ClocheHolyMaiden)

---------------------------------------------------------------------------------------------------------------------------------------------------
-- Coronation of Maiden of Aqua
--------------------------------------------------------------------------------------------------------------------------------------------------

local Decisions_ClocheMaidenofAqua = {}
	Decisions_ClocheMaidenofAqua.Name = "TXT_KEY_DECISIONS_CLOCHE_MAIDEN_OF_AQUA"
	Decisions_ClocheMaidenofAqua.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_CLOCHE_MAIDEN_OF_AQUA_DESC")
	HookDecisionCivilizationIcon(Decisions_ClocheMaidenofAqua, "CIVILIZATION_PASTALIA")
	Decisions_ClocheMaidenofAqua.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_PASTALIA) then
			return false, false
		end

		--The AI should not enact this if Coronation Holy of Maiden is already enacted (to prevent them burning all their Faith/Magistrates on it)
		if not pPlayer:IsHuman()then
			return false, false
		end

		if load(pPlayer, "Decisions_ClocheHolyMaiden") == true then
			return false, false
			end

		if load(pPlayer, "Decisions_ClocheMaidenofAqua") then
			Decisions_ClocheMaidenofAqua.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_CLOCHE_MAIDEN_OF_AQUA_ENACTED_DESC")
			return false, false, true
		end
		
		local iCost = math.ceil(200 * iMod)
		Decisions_ClocheMaidenofAqua.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_CLOCHE_MAIDEN_OF_AQUA_DESC", iCost)
		
		if pPlayer:GetFaith() < iCost then return true, false end
		
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end

		local pTeam = Teams[pPlayer:GetTeam()]
		local pTeamTechs = pTeam:GetTeamTechs()
		
		if pTeamTechs:HasTech(GameInfoTypes.TECH_THEOLOGY) then 
			return true, true
		else
			return true, false
		end
	
	end
	)
	
	Decisions_ClocheMaidenofAqua.DoFunc = (
	function(pPlayer)
		local iCost = math.ceil(200 * iMod)
		pPlayer:ChangeFaith(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)
		 
		 local iHolyMaiden = GameInfoTypes.POLICY_DECISIONS_CLOCHE_HOLY_MAIDEN
         local iMaidenofAqua = GameInfoTypes.POLICY_DECISIONS_CLOCHE_MAIDEN_OF_AQUA

		if pPlayer:HasPolicy(iHolyMaiden) then
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetHasPolicy(iHolyMaiden, false)
			pPlayer:SetNumFreePolicies(0)
		end

		if not pPlayer:HasPolicy(iMaidenofAqua) then
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetHasPolicy(iMaidenofAqua, true)
			pPlayer:SetNumFreePolicies(0)
		end
		
		save(pPlayer, "Decisions_ClocheMaidenofAqua", true)
		save(pPlayer, "Decisions_ClocheHolyMaiden", false)
		save(pPlayer, "Decisions_ClocheRepeal", false) 
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_PASTALIA, "Decisions_ClocheMaidenofAqua", Decisions_ClocheMaidenofAqua)

----------------------------------------------------------------------------------------------------------------------------------------------------
--- Repeal the decision
----------------------------------------------------------------------------------------------------------------------------------------------------

local Decisions_ClocheRepeal = {}
	Decisions_ClocheRepeal.Name = "TXT_KEY_DECISIONS_CLOCHE_REPEAL"
	Decisions_ClocheRepeal.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_CLOCHE_REPEAL_DESC")
	HookDecisionCivilizationIcon(Decisions_ClocheRepeal, "CIVILIZATION_PASTALIA")
	Decisions_ClocheRepeal.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_PASTALIA) then
			return false, false
		end

		--The AI will never pass the repeal
		if not pPlayer:IsHuman() then
			return false, false
		end

		if load(pPlayer, "Decisions_ClocheRepeal") then
			Decisions_ClocheRepeal.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_CLOCHE_REPEAL_ENACTED_DESC")
			return false, false, true
		end
		
		local iCost = math.ceil(200 * iMod)
		Decisions_ClocheRepeal.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_CLOCHE_REPEAL_DESC", iCost)
		
		if pPlayer:GetFaith() < iCost then return true, false end
		
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 1) then return true, false end

		if load(pPlayer, "Decisions_ClocheMaidenofAqua") == true or load(pPlayer, "Decisions_ClocheHolyMaiden") == true then
			return true, true
		else
			return true, false
		end
	
	end
	)
	
	Decisions_ClocheRepeal.DoFunc = (
	function(pPlayer)
		local iCost = math.ceil(200 * iMod)
		pPlayer:ChangeFaith(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -1)

		local iHolyMaiden = GameInfoTypes.POLICY_DECISIONS_CLOCHE_HOLY_MAIDEN
         local iMaidenofAqua = GameInfoTypes.POLICY_DECISIONS_CLOCHE_MAIDEN_OF_AQUA

		if pPlayer:HasPolicy(iMaidenofAqua) then
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetHasPolicy(iMaidenofAqua, false)
			pPlayer:SetNumFreePolicies(0)
		end

		if not pPlayer:HasPolicy(iHolyMaiden) then
			pPlayer:SetNumFreePolicies(1)
			pPlayer:SetHasPolicy(iHolyMaiden, false)
			pPlayer:SetNumFreePolicies(0)
		end

		save(pPlayer, "Decisions_ClocheMaidenofAqua", false)
		save(pPlayer, "Decisions_ClocheHolyMaiden", false)
		save(pPlayer, "Decisions_ClocheRepeal", true)

	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_PASTALIA, "Decisions_ClocheRepeal", Decisions_ClocheRepeal)

--------------------------------------------------------------------------------------------------------------------------
-- Pastalia: Replekia
--------------------------------------------------------------------------------------------------------------------------

local Decisions_PastaliaReplekia = {}
	Decisions_PastaliaReplekia.Name = "TXT_KEY_DECISIONS_PASTALIAREPLEKIA"
	Decisions_PastaliaReplekia.Desc = "TXT_KEY_DECISIONS_PASTALIAREPLEKIA_DESC"
	HookDecisionCivilizationIcon(Decisions_PastaliaReplekia, "CIVILIZATION_PASTALIA")
	Decisions_PastaliaReplekia.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_PASTALIA then return false, false end
		if load(pPlayer, "Decisions_PastaliaReplekia") == true then
			Decisions_PastaliaReplekia.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_PASTALIAREPLEKIA_ENACTED_DESC")
			return false, false, true
		end
		
		local iCost = math.ceil(500 * iMod)
		Decisions_PastaliaReplekia.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_PASTALIAREPLEKIA_DESC", iCost)
		
		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end
		if (pPlayer:GetNumCities() > pPlayer:CountNumBuildings(GameInfoTypes.BUILDING_SPEECH_HALL)) then return true, false end
		if (pPlayer:GetFaith() >= iCost) and (pPlayer:GetCapitalCity() ~= nil) then
			return true, true
		else
			return true, false
		end
	end
	)

	Decisions_PastaliaReplekia.DoFunc = (
	function(pPlayer)
		local iCost = math.ceil(500 * iMod)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		pPlayer:ChangeFaith(-iCost)
		

function ReplekiaCalc(iPlayer)
	local pPlayer = Players[iPlayer]
	local Replekia = GameInfoTypes.PROMOTION_PASTALIA --Strength from Culture per turn
	for pUnit in pPlayer:Units() do
		if pUnit:IsHasPromotion(Replekia) then
			local iReligionRate = pPlayer:GetTotalFaithPerTurn()
			if iReligionRate >= 20 then
				if not pUnit:IsHasPromotion(GameInfoTypes["PROMOTION_PASTALIAN_SPIRIT"]) then
					pUnit:SetHasPromotion(GameInfoTypes["PROMOTION_PASTALIAN_SPIRIT"], true)
				end	
			else
				pUnit:SetHasPromotion(GameInfoTypes["PROMOTION_PASTALIAN_SPIRIT"], false)
			end

			if iReligionRate >= 40 then
				if not pUnit:IsHasPromotion(GameInfoTypes["PROMOTION_NATIONAL_UNITY"]) then
					pUnit:SetHasPromotion(GameInfoTypes["PROMOTION_NATIONAL_UNITY"], true)
				end
			else
				pUnit:SetHasPromotion(GameInfoTypes["PROMOTION_NATIONAL_UNITY"], false)
			end

			if iReligionRate >= 60 then
				if not pUnit:IsHasPromotion(GameInfoTypes["PROMOTION_HERITAGE_OF_PASTALIA"]) then
					pUnit:SetHasPromotion(GameInfoTypes["PROMOTION_HERITAGE_OF_PASTALIA"], true)
				end	
			else
				pUnit:SetHasPromotion(GameInfoTypes["PROMOTION_HERITAGE_OF_PASTALIA"], false)
			end

			if iReligionRate >= 90 then
				if not pUnit:IsHasPromotion(GameInfoTypes["PROMOTION_PASTALIAN_TOUGHNESS"]) then
					pUnit:SetHasPromotion(GameInfoTypes["PROMOTION_PASTALIAN_TOUGHNESS"], true)
			else
				pUnit:SetHasPromotion(GameInfoTypes["PROMOTION_PASTALIAN_TOUGHNESS"], false)
			end

			if iReligionRate >= 120 then
				if not pUnit:IsHasPromotion(GameInfoTypes["PROMOTION_PATRIOTIC_FERVOR"]) then
					pUnit:SetHasPromotion(GameInfoTypes["PROMOTION_PATRIOTIC_FERVOR"], true)
				end
			else
				pUnit:SetHasPromotion(GameInfoTypes["PROMOTION_PATRIOTIC_FERVOR"], false)
			end
		end
	end	
end	
end
		save(pPlayer, "Decisions_PastaliaReplekia", true)		
	end
	)
	
tDecisions.Decisions_PastaliaReplekia = Decisions_PastaliaReplekia

--------------------------------------------------------------------------------------------------------------------------
-- Aqua: Hymnoss
--------------------------------------------------------------------------------------------------------------------------
-- Hymnoss Vars
iHymnosTechPrereq = GameInfoTypes.TECH_THEOLOGY;
iHymnosCultureMaxBaseCost = 500
iHymnosCultureReducedCost = 4
iHymnosCultureCostperEra = 120
iHymnosCultureReducedEraCost = 1
iHymnosFaithPerCitizen = 5
---------------------------------------
tDecisions.Decisions_Cloche_Hymnoss = nil

local Decisions_Cloche_Hymnoss = {}
	Decisions_Cloche_Hymnoss.Name = "TXT_KEY_DECISIONS_CLOCHE_HYMNOS_CONCERT"
	Decisions_Cloche_Hymnoss.Desc = "TXT_KEY_DECISIONS_JFD_PIETY_CLOCHE_HYMNOS_CONCERT_DESC"
	Decisions_Cloche_Hymnoss.Data1 = nil
	Decisions_Cloche_Hymnoss.Weight = nil
	Decisions_Cloche_Hymnoss.CanFunc = (
		function(pPlayer)	
			-- Check Civ
			if (pPlayer:GetCivilizationType() ~= GameInfoTypes["CIVILIZATION_PASTALIA"]) then return false, false end
			HookDecisionCivilizationIcon(Decisions_Cloche_Hymnoss, "CIVILIZATION_PASTALIA")
			--Check State Religion
			-- Check if the player has enacted in this era
			local iEra = load(pPlayer, "Decisions_Cloche_Hymnoss")
			local iCurrentEra = pPlayer:GetCurrentEra()
			if iEra ~= nil then
				if iEra < iCurrentEra then
					save(pPlayer, "Decisions_Cloche_Hymnoss", nil)
				else
					if pPlayer:IsHuman() then	
						Decisions_Cloche_Hymnoss.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_PIETY_CLOCHE_HYMNOS_CONCERT_ENACTED_DESC")
					end
					return false, false, true
				end
			end
			HymnossEnactable = true
			-- Religious Unity
			---- Get Religion
			iUnity = 0
			local iReligion = pPlayer:GetReligionCreatedByPlayer();
			if not (pPlayer:HasCreatedReligion()) then
				HymnossEnactable = false
			else
				iUnity = GetReligiousUnity(pPlayer, iReligion)
				iUnity = iUnity * 100

				-- Majority Religion
				nFollowers = 0
				for pCity in pPlayer:Cities() do
					local CityFollowers = pCity:GetNumFollowers(iReligion)
					nFollowers = nFollowers + CityFollowers
				end
				local totalpop = pPlayer:GetTotalPopulation()
				local FollowDiff = totalpop - nFollowers
				if FollowDiff > (nFollowers / 2) then
					HymnossEnactable = false
				end
			end
			
			-- Requirements
			---- Tech Prereq
			local pTeam = pPlayer:GetTeam();
			if not (Teams[pTeam]:IsHasTech(iHymnosTechPrereq)) then HymnossEnactable = false end
			-- Costs
			---- Culture
			------ Create the cost
			local iExtraEraCost = iCurrentEra * iHymnosCultureCostperEra
			local iExtraEraUnityCost = iCurrentEra * iHymnosCultureReducedEraCost * iUnity
			local iEraCost = iExtraEraCost - iExtraEraUnityCost

			local iUnityCost = iHymnosCultureReducedCost * iUnity
			local baseCost = iHymnosCultureMaxBaseCost - iUnityCost

			local iCost =math.ceil((baseCost + iEraCost) * iMod)

			if (pPlayer:GetJONSCulture() < iCost) then HymnossEnactable = false end
			---- Received Faith
			local iFaithBoost =math.ceil((iHymnosFaithPerCitizen) * iMod)
			---- Get num followers
			nFollowers = 0
			for pCity in pPlayer:Cities() do
				local Followers = pCity:GetNumFollowers(iReligion)
				nFollowers = nFollowers + Followers
			end
			local totalFaitboost = nFollowers * iFaithBoost

			Decisions_Cloche_Hymnoss.Data1 = nil
			for pCity in pPlayer:Cities() do
			if pCity:IsCapital() then
				--Worker Check
				local pPlot = pCity:Plot()
				local iNumUnits = pPlot:GetNumUnits()
				for iVal = 0,(iNumUnits - 1) do
					local pUnit = pPlot:GetUnit(iVal)
					if (pUnit:GetUnitClassType() == GameInfoTypes.UNITCLASS_MUSICIAN) then
						Decisions_Cloche_Hymnoss.Data1 = pUnit
						break
					end
				end			
				end
				end
			-- Build the Description
			local iPietyBoost = math.ceil(15 * iMod)
			Decisions_Cloche_Hymnoss.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_JFD_PIETY_CLOCHE_HYMNOS_CONCERT_DESC", iCost, iPietyBoost, iFaithBoost, iUnity, totalFaitboost)
			if not (JFD_HasStateReligion(pPlayer:GetID())) then return true, false end

			if not(Decisions_Cloche_Hymnoss.Data1) then return true, false end
			if HymnossEnactable == false then
				return true, false 
			end
			-- Allow the decision!
			return true, true
		end
	)
	
	Decisions_Cloche_Hymnoss.DoFunc = (
	function(pPlayer, pUnit)
		-- Get Religious Unity Again
		local iReligion = pPlayer:GetReligionCreatedByPlayer();
		iUnity = GetReligiousUnity(pPlayer, iReligion)
		iUnity = iUnity * 100
		-- Pay the price
		pUnit:Kill()
		local iCurrentEra = pPlayer:GetCurrentEra()
		---- Culture
		local iExtraEraCost = iCurrentEra * iHymnosCultureCostperEra
			local iExtraEraUnityCost = iCurrentEra * iHymnosCultureReducedEraCost * iUnity
			local iEraCost = iExtraEraCost - iExtraEraUnityCost

			local iUnityCost = iHymnosCultureReducedCost * iUnity
			local baseCost = iHymnosCultureMaxBaseCost - iUnityCost

			local iCost =math.ceil((baseCost + iEraCost) * iMod)
			pPlayer:ChangeJONSCulture(-iCost)
		-- Rewards
		---- Piety
		local iPietyBoost = math.ceil(15 * iMod)
		JFD_ChangePiety(pPlayer:GetID(), iPietyBoost)
		---- Faith
		local iFaithBoost =math.ceil((iHymnosFaithPerCitizen) * iMod)
		---- Get num followers
		nFollowers = 0
		for pCity in pPlayer:Cities() do
			local Followers = pCity:GetNumFollowers(iReligion)
			nFollowers = nFollowers + Followers
		end
		local totalFaithboost = nFollowers * iFaithBoost
		pPlayer:ChangeFaith(totalFaithboost);
		-- Save the Decision
		local iCurrentEra = pPlayer:GetCurrentEra()
		save(pPlayer, "Decisions_Cloche_Hymnoss", iCurrentEra)
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes["CIVILIZATION_PASTALIA"], "Decisions_Cloche_Hymnoss", Decisions_Cloche_Hymnoss)

