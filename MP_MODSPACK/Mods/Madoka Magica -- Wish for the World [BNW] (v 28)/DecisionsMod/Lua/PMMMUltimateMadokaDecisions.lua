-- PMMMUltimateMadokaDecisions
-- Author: Vice
-- DateCreated: 8/25/2014 2:01:53 PM
--------------------------------------------------------------

local iMagicalGirlClass = GameInfoTypes.UNITCLASS_PMMM_MAGICAL_GIRL
local iLuminous = GameInfoTypes.BUILDING_PMMM_LUMINOUS_GARDEN

--------------------------------------------------------------------------------------------------------------------------------------------
--Decision 1: Establish Yuri Valhalla
--+3 Happiness from Luminous Gardens and +10% Growth
--------------------------------------------------------------------------------------------------------------------------------------------
local Decisions_YuriValhalla = {}
	Decisions_YuriValhalla.Name = "TXT_KEY_DECISIONS_MADOKA_YURI_VALHALLA"
	Decisions_YuriValhalla.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MADOKA_YURI_VALHALLA_DESC")
	HookDecisionCivilizationIcon(Decisions_YuriValhalla, "CIVILIZATION_MADOKA")
	Decisions_YuriValhalla.CanFunc = (
	function(pPlayer)
		if (pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_MADOKA) then
			return false, false
		end
		if load(pPlayer, "Decisions_YuriValhalla") == true then
			Decisions_YuriValhalla.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MADOKA_YURI_VALHALLA_ENACTED_DESC")
			return false, false, true
		end

		local iCost = math.ceil(800 * iMod)
		Decisions_YuriValhalla.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MADOKA_YURI_VALHALLA_DESC", iCost)
		
		if pPlayer:GetGold() < iCost then return true, false end

		if (pPlayer:GetNumResourceAvailable(iMagistrate, false) < 2) then return true, false end
		
		local iNumMagicalGirls = 0
		for pUnit in pPlayer:Units() do
			if pUnit:GetUnitClassType() == iMagicalGirlClass then
				iNumMagicalGirls = iNumMagicalGirls + 1
				if iNumMagicalGirls >= 4 then
					break
				end
			end
		end

		if iNumMagicalGirls < 4 then
			return true, false
		end

		local iNumLuminousGardens = 0
		for pCity in pPlayer:Cities() do
			if pCity:IsHasBuilding(iLuminous) then
				iNumLuminousGardens = iNumLuminousGardens + 1
				if iNumLuminousGardens >= 2 then
					return true, true
				end
			end
		end

		return true, false
	end
	)
	
	Decisions_YuriValhalla.DoFunc = (
	function(pPlayer)
		local iCost = math.ceil(800 * iMod)
		pPlayer:ChangeGold(-iCost)
		pPlayer:ChangeNumResourceTotal(iMagistrate, -2)
		pPlayer:SetNumFreePolicies(1)
		pPlayer:SetNumFreePolicies(0)
		pPlayer:SetHasPolicy(GameInfoTypes.POLICY_DECISIONS_MADOKA_YURI_VALHALLA, true)
		save(pPlayer, "Decisions_YuriValhalla", true)
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_MADOKA, "Decisions_YuriValhalla", Decisions_YuriValhalla)


--------------------------------------------------------------------------------------------------------------------------------------------
--Decision 2: Appoint {Magical Girl Name} as your Knight
--Turn a level 4+ MG into a Leader MG
--------------------------------------------------------------------------------------------------------------------------------------------

local Decisions_KnightOfMadoka = {}
	Decisions_KnightOfMadoka.Name = "TXT_KEY_DECISIONS_MADOKA_KNIGHT"
	Decisions_KnightOfMadoka.Desc = "TXT_KEY_DECISIONS_MADOKA_KNIGHT_DESC"
	Decisions_KnightOfMadoka.CanFunc = (
	function(pPlayer)
		if pPlayer:GetCivilizationType() ~= GameInfoTypes.CIVILIZATION_MADOKA then return false, false end
		
		if load(pPlayer, "Decisions_KnightOfMadoka") then
			local MagicalGirls = MapModData.gT.PMMM.MagicalGirls
			local iMGKey = load(pPlayer, "Decisions_KnightOfMadoka")
			for k, v in pairs(MagicalGirls) do
				if k == iMGKey and v.Owner == pPlayer:GetID() then
					Decisions_YuriValhalla.Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MADOKA_KNIGHT_ENACTED_DESC", Locale.ConvertTextKey(MagicalGirls[iMGKey].Name))
					return false, false, true
				end
			end
		end
		
		for pUnit in pPlayer:Units() do

			if pUnit:GetUnitClassType() == iMagicalGirlClass then
			
				local sKey = "Decisions_KnightOfMadoka" ..pPlayer:GetID()..":"..pUnit:GetID()
				local sName = Locale.ConvertTextKey(pUnit:GetNameNoDesc())
				
				tTempDecisions[sKey] = {}
				tTempDecisions[sKey].Name = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MADOKA_KNIGHT", sName)
				tTempDecisions[sKey].Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MADOKA_KNIGHT_DESC", sName)
				tTempDecisions[sKey].Data1 = pUnit
				tTempDecisions[sKey].Weight = 0
				tTempDecisions[sKey].Type = "Civilization"
				HookDecisionCivilizationIcon(tTempDecisions[sKey], "CIVILIZATION_MADOKA")
				tTempDecisions[sKey].CanFunc = (
				function(pPlayer, pUnit)
				
					if pUnit:GetLevel() < 4 then
						return false, false
					end
					
					local sKey = "Decisions_KnightOfMadoka" ..pPlayer:GetID()..":"..pUnit:GetID()
					local sName = Locale.ConvertTextKey(pUnit:GetNameNoDesc())

					local iCost = math.ceil(200 * iMod)

					tTempDecisions[sKey].Desc = Locale.ConvertTextKey("TXT_KEY_DECISIONS_MADOKA_KNIGHT_DESC", sName, iCost)

					if pPlayer:GetFaith() < iCost then return true, false end
				
					return true, true
				end
				)
				
				tTempDecisions[sKey].DoFunc = (
				function(pPlayer, pUnit)
					local sKey = "Decisions_KnightOfMadoka" ..pPlayer:GetID()..":"..pUnit:GetID()
					local iCost = math.ceil(200 * iMod)

					local MagicalGirls = MapModData.gT.PMMM.MagicalGirls
					local iMGKey;
					for k, v in pairs(MagicalGirls) do
						if v.UnitID == pUnit:GetID() and v.Owner == pPlayer:GetID() then
							iMGKey = k
						end
					end
					
					if not iMGKey then
						print("Error: Magical Girl table key not found for UM decision")
						return
					end
					
					pPlayer:ChangeFaith(-iCost)
					MagicalGirls[iMGKey].IsLeader = true
					pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_PMMM_MAGICAL_GIRL_LEADER, true)
					pUnit:SetName(GameDefines.LEADER_MG_HIGHLIGHT_STRING..Locale.ConvertTextKey(pUnit:GetNameNoDesc())..'[ENDCOLOR]')
					save(pPlayer, "Decisions_KnightOfMadoka", iMGKey)
				end
				)
			end
		end
	end
	)

Decisions_AddCivilisationSpecific(GameInfoTypes.CIVILIZATION_MADOKA, "Decisions_KnightOfMadoka", Decisions_KnightOfMadoka)