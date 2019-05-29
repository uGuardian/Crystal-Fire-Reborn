-- ArmstrongDecisions
-- Author: Vicevirtuoso
-- DateCreated: 8/25/2014 2:01:53 PM
--------------------------------------------------------------

local Decisions_WorldMarshalMercs = {}
	Decisions_WorldMarshalMercs.Name = "TXT_KEY_DECISIONS_ARMSTRONG_HIRE_OUT_MERCS"
	Decisions_WorldMarshalMercs.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_ARMSTRONG_HIRE_OUT_MERCS_DESC")
	HookDecisionCivilizationIcon(Decisions_WorldMarshalMercs, "CIVILIZATION_WORLD_MARSHAL")
	Decisions_WorldMarshalMercs.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_WORLD_MARSHAL) then
			return false, false
		end

		if load(pPlayer, "Decisions_WorldMarshalMercs") == true then
			Decisions_WorldMarshalMercs.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_ARMSTRONG_HIRE_OUT_MERCS_ENACTED_DESC")
			return false, false, true
		end
		
		local iCultureCost = math.ceil(1000 * iMod)

		Decisions_WorldMarshalMercs.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_ARMSTRONG_HIRE_OUT_MERCS_DESC", iCultureCost)
		
		if pPlayer:GetJONSCulture() < iCultureCost then return true, false end

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end

		if pPlayer:HasPolicy(GameInfoTypes.POLICY_COMMERCE_FINISHER) then 
			return true, true
		else
			return true, false
		end
	end
	)
	
	Decisions_WorldMarshalMercs.DoFunc = (
	function(pPlayer)
		local iCultureCost = math.ceil(1000 * iMod)
		pPlayer:ChangeJONSCulture(-iCultureCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		pPlayer:SetHasPolicy(GameInfoTypes.POLICY_ARMSTRONG_DUMMY, false)
		pPlayer:SetNumFreePolicies(1)
		pPlayer:SetNumFreePolicies(0)
		pPlayer:SetHasPolicy(GameInfoTypes.POLICY_DECISIONS_ARMSTRONG_HIRE_OUT_MERCS, true)
		save(pPlayer, "Decisions_WorldMarshalMercs", true)
	end
	)

	Decisions_WorldMarshalMercs.Monitors = {}
	Decisions_WorldMarshalMercs.Monitors[GameEvents.PlayerDoTurn] =  (
	function(iPlayer)
		if iPlayer < GameDefines.MAX_MAJOR_CIVS then
			local pPlayer = Players[iPlayer]
			if load(pPlayer, "Decisions_WorldMarshalMercs") == true then
				local iGoldGain = 0;
				local iGoldPerUnit = 1
				if pPlayer:HasPolicy(GameInfoTypes.POLICY_HONOR_FINISHER) then
					iGoldPerUnit = 3
				end
				for pUnit in pPlayer:Units() do
					if (pUnit:IsCombatUnit()) then
						local pPlot = pUnit:GetPlot()
						local pPlotOwner = Players[pPlot:GetOwner()]
						if (pPlotOwner ~= nil) then
							if pPlotOwner:IsMinorCiv() and pPlotOwner:IsProtectedByMajor(iPlayer) and	pPlotOwner:GetMinorCivFriendshipLevelWithMajor(iPlayer) > 0 then
								iGoldGain = iGoldGain + iGoldPerUnit
							end
						end
					end
				end
				pPlayer:GetCapitalCity():SetNumRealBuilding(GameInfoTypes.BUILDING_ARMSTRONG_MERC_GOLD_BUILDING, iGoldGain);
				Events.SerialEventCityInfoDirty()
			end
		end
	end)

	Decisions_WorldMarshalMercs.Monitors[GameEvents.UnitSetXY] =  (
	function(iPlayer, iUnit, iX, iY)
		if iPlayer < GameDefines.MAX_MAJOR_CIVS then
			local pPlayer = Players[iPlayer]
			if load(pPlayer, "Decisions_WorldMarshalMercs") == true then
				local pThisUnit = pPlayer:GetUnitByID(iUnit)
				if pThisUnit:IsCombatUnit() then
					local iGoldGain = 0;
					local iGoldPerUnit = 1
					if pPlayer:HasPolicy(GameInfoTypes.POLICY_HONOR_FINISHER) then
						iGoldPerUnit = 3
					end
					for pUnit in pPlayer:Units() do
						if (pUnit:IsCombatUnit()) then
							local pPlot = pUnit:GetPlot()
							local pPlotOwner = Players[pPlot:GetOwner()]
							if (pPlotOwner ~= nil) then
								if pPlotOwner:IsMinorCiv() and pPlotOwner:IsProtectedByMajor(iPlayer) and	pPlotOwner:GetMinorCivFriendshipLevelWithMajor(iPlayer) > 0 then
									iGoldGain = iGoldGain + iGoldPerUnit
								end
							end
						end
					end
					pPlayer:GetCapitalCity():SetNumRealBuilding(GameInfoTypes.BUILDING_ARMSTRONG_MERC_GOLD_BUILDING, iGoldGain);
					Events.SerialEventCityInfoDirty()
				end
			end
		end
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_WORLD_MARSHAL, "Decisions_WorldMarshalMercs", Decisions_WorldMarshalMercs)



local Decisions_WorldMarshalChildSoldiers = {}
	Decisions_WorldMarshalChildSoldiers.Name = "TXT_KEY_DECISIONS_ARMSTRONG_CHILD_SOLDIERS"
	Decisions_WorldMarshalChildSoldiers.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_ARMSTRONG_CHILD_SOLDIERS_DESC")
	HookDecisionCivilizationIcon(Decisions_WorldMarshalChildSoldiers, "CIVILIZATION_WORLD_MARSHAL")
	Decisions_WorldMarshalChildSoldiers.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_WORLD_MARSHAL) then
			return false, false
		end

		local iGoldCost = math.ceil(400 * iMod)
		if pPlayer:GetGold() < iGoldCost then return false, false end

		for pCity in pPlayer:Cities() do
			local iOriginalOwner = pCity:GetOriginalOwner()
			local pOriginalOwner = Players[iOriginalOwner]
			if pOriginalOwner:IsMinorCiv() and pCity:IsOriginalCapital() then
			
				local sKey = "Decisions_WorldMarshalChildSoldiers" .. iOriginalOwner
				local sName = pCity:GetName()
				
				tTempDecisions[sKey] = {}
				tTempDecisions[sKey].Name = Locale.ConvertTextKey("TXT_KEY_DECISIONS_ARMSTRONG_CHILD_SOLDIERS", sName)
				tTempDecisions[sKey].Desc = "TXT_KEY_DECISIONS_ARMSTRONG_CHILD_SOLDIERS_DESC"
				tTempDecisions[sKey].Data1 = pCity
				tTempDecisions[sKey].Data2 = iGoldCost
				tTempDecisions[sKey].Weight = 0
				tTempDecisions[sKey].Type = "Civilization"
				HookDecisionCivilizationIcon(tTempDecisions[sKey], "CIVILIZATION_WORLD_MARSHAL")
				tTempDecisions[sKey].CanFunc = (
				function(pPlayer, pCity, iGoldCost)
					local sKey = "Decisions_WorldMarshalChildSoldiers" .. pCity:GetOriginalOwner()
					local sName = pCity:GetName()

					if load(pPlayer, sKey) == true then
						tTempDecisions[sKey].Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_ARMSTRONG_CHILD_SOLDIERS_ENACTED_DESC", sName)
						return false, false, true
					end
	
					tTempDecisions[sKey].Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_ARMSTRONG_CHILD_SOLDIERS_DESC", sName, iGoldCost)

					if pCity:IsHasBuilding(GameInfoTypes.BUILDING_DESPERADO_JUNTA) then
						return true, true
					else
						return true, false
					end
				end
				)
				
				tTempDecisions[sKey].DoFunc = (
				function(pPlayer, pCity, iGoldCost)
					local sKey = "Decisions_WorldMarshalChildSoldiers" .. pCity:GetOriginalOwner()
					local sName = pCity:GetName()

					pPlayer:ChangeGold(-iGoldCost)

					pCity:SetNumRealBuilding(GameInfoTypes.BUILDING_DECISIONS_ARMSTRONG_CHILD_SOLDIERS, 1)

					for i = GameDefines.MAX_MAJOR_CIVS, GameDefines.MAX_CIV_PLAYERS - 1, 1 do
						local pCityState = Players[i]
						if Teams[pCityState:GetTeam()]:IsHasMet(pPlayer:GetTeam()) then
							pCityState:ChangeMinorCivFriendshipWithMajor(pPlayer:GetID(), -20)
						end
					end
							
					save(pPlayer, sKey, true)
				end
				)
			end
		end

		return false, false
	end
	)
	
Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_WORLD_MARSHAL, "Decisions_WorldMarshalChildSoldiers", Decisions_WorldMarshalChildSoldiers)