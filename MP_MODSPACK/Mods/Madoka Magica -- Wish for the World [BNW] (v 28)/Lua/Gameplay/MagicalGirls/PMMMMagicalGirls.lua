------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PMMMMagicalGirls.lua
-- Author: Vicevirtuoso
-- DateCreated: 2/4/2014 5:13:00 PM
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CONSTANTS
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local iNoMakeGMG = GameInfoTypes.PROMOTION_DOES_NOT_BECOME_GMG

local iMaxCivsAndCS = GameDefines.MAX_CIV_PLAYERS --City-States will get MGs too! But that's in a later release.
local iMagicalGirl = GameInfoTypes.UNIT_PMMM_MAGICAL_GIRL
local iMagicalGirlClass = GameInfoTypes.UNITCLASS_PMMM_MAGICAL_GIRL

local iWitchType = GameInfoTypes.UNIT_PMMM_WITCH
local iSeaWitchType = GameInfoTypes.UNIT_PMMM_SEA_WITCH
local iFamiliarType = GameInfoTypes.UNIT_PMMM_FAMILIAR
local iSeaFamiliarType = GameInfoTypes.UNIT_PMMM_SEA_FAMILIAR

local iWitchHuntMission = MissionTypes.MISSION_PMMM_WITCH_HUNT
local iSparringMission = MissionTypes.MISSION_PMMM_SPAR

local iCorruptionPerTurnBase = GameDefines.SOUL_GEM_LOSS_PER_TURN
local iCorruptionPerHPHealedBase = GameDefines.SOUL_GEM_LOSS_PER_HP_REGENERATED

local iDealDuration = GameInfo.GameSpeeds[Game.GetGameSpeedType()].DealDuration --will be the turns it takes for a Familiar to become a Witch

local iCommandDelete = GameInfoTypes.COMMAND_DELETE
local iCommandGift = GameInfoTypes.COMMAND_GIFT

local iHalicarnassus = GameInfoTypes.BUILDING_MAUSOLEUM_HALICARNASSUS
local iHalicarnassusGold;
if iHalicarnassus then
	iHalicarnassusGold = GameInfo.Buildings[iHalicarnassus].GoldFromKillingWitches
end

local iLightningWarfare = GameInfoTypes.POLICY_LIGHTNING_WARFARE
local iNavigationSchool = GameInfoTypes.POLICY_NAVIGATION_SCHOOL
local iGeneralClass = GameInfoTypes.UNITCLASS_GREAT_GENERAL
local iAdmiralClass = GameInfoTypes.UNITCLASS_GREAT_ADMIRAL
local iPolicyMovesPromotion = GameInfoTypes.PROMOTION_MG_MOVE_BONUS_FROM_POLICY

local iSparCooldown = GameDefines.MG_SPARRING_COOLDOWN

tMagicalGirlSpawnTable = {}
--passes data between certain functions for MG spawning


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNING
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Added to GameEvents.UnitCreated
--This happens ANY TIME an MG is created, regardless of its source, so it should handle both respawns of existing MGs and births of new MGs.
function OnCreatedMagicalGirl(iPlayer, iUnit, iUnitType)
	dprint("OnCreatedMagicalGirl called")
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnit)
	if iUnitType == iMagicalGirl then
		--Did she already exist in the table?
		if tMagicalGirlSpawnTable["ID"] then
			dprint("MG is respawning.")
			--This is a respawning MG, so we will simply adjust the existing entries accordingly.

			local iMGKey = tMagicalGirlSpawnTable["ID"]

			--if Demon Homura is getting this spawn, just set it to "returned to normal" state, kill, and do nothing else with it
			if MapModData.gPMMMTraits[iPlayer] and (MapModData.gPMMMTraits[iPlayer].NoMagicalGirls == 1 or MapModData.gPMMMTraits[iPlayer].NoMagicalGirls == true) then
				MagicalGirls[iMGKey].Status = GameInfoTypes.MGACTIONSTATE_RETURNED_NORMAL
				OnDemonHomuraKillMG(iPlayer, pUnit:GetX(), pUnit:GetY())
				pUnit:Kill(true)
				return
			end


			--The table should now reflect the current owner and UnitID, and an MG actually walking around the map is always Active.
			MagicalGirls[iMGKey].Owner = iPlayer
			MagicalGirls[iMGKey].Status = GameInfoTypes.MGACTIONSTATE_ACTIVE
			MagicalGirls[iMGKey].UnitID = iUnit


			--Functions which respawn MGs can specify an amount of HP and SG to give her when she comes back.
			--If those values aren't present, they default to what was in the MG table.
			if not tMagicalGirlSpawnTable["RespawnHP"] then
				pUnit:ChangeDamage(GameDefines.MAX_HIT_POINTS - MagicalGirls[iMGKey].HP)
			else
				pUnit:ChangeDamage(GameDefines.MAX_HIT_POINTS - tMagicalGirlSpawnTable["RespawnHP"])
			end

			if tMagicalGirlSpawnTable["RespawnSG"] then
				MagicalGirls[iMGKey].SoulGem = tMagicalGirlSpawnTable["RespawnSG"]
			end

			--Update the unit's level, XP, and promotions to match what she already had.
			pUnit:SetLevel(MagicalGirls[iMGKey].Level)
			pUnit:SetExperience(MagicalGirls[iMGKey].XP)
			if MagicalGirls[iMGKey].Promotions then
				for k, v in pairs(MagicalGirls[iMGKey].Promotions) do
					pUnit:SetHasPromotion(v, true)
				end
			end


			--Make unit's name highlighted 
			if MagicalGirls[iMGKey].IsLeader == true then
				pUnit:SetName(GameDefines.LEADER_MG_HIGHLIGHT_STRING..Locale.ConvertTextKey(MagicalGirls[iMGKey].Name)..'[ENDCOLOR]')
			else
				pUnit:SetName(MagicalGirls[iMGKey].Name)
			end
				
		
			--Embark if on water
			if pUnit:GetPlot():IsWater() then
				pUnit:Embark(pUnit:GetPlot())
			end

			--Set combat strength
			SetMagicalGirlStrength(iPlayer, iUnit)

			--Reinitialize her soul gem
			SetSoulGemState(iMGKey)
			
			--Refresh mood
			RefreshMGMood(iMGKey, pPlayer, pUnit, true, false)
			
			--If debug mode is on, print out everything about this Magical Girl to the console.
			if bDebug then
				print("Magical Girl #" ..iMGKey.."'s data:") 
				print(Locale.ConvertTextKey(MagicalGirls[iMGKey].Name))
				print("Owned by "..Players[MagicalGirls[iMGKey].Owner]:GetCivilizationShortDescription())
				print("Status ID: "..MagicalGirls[iMGKey].Status)
				print("UnitID: "..MagicalGirls[iMGKey].UnitID)
				print("Soul Gem: "..MagicalGirls[iMGKey].SoulGem)
				print("Soul Gem State: "..MagicalGirls[iMGKey].SoulGemState)
				print("Level: "..MagicalGirls[iMGKey].Level)
				if MagicalGirls[iMGKey].Class then
					print("UnitClass: "..Locale.ConvertTextKey(GameInfo.UnitClasses[MagicalGirls[iMGKey].Class].Description))
				else
					print("No GP Class data.")
				end
				if MagicalGirls[iMGKey].IsLeader then
					print("This MG is a leader.")
				else
					print("Not a leader.")
				end
				print("Home City: "..Vice_DecompileCityID(MagicalGirls[iMGKey].HomeCity):GetName())
			end
		else
			dprint("New Magical Girl.")
			--She did not exist, so initialize them in the MG table. Start by giving them base values

			--Don't do any of this for DH
			if MapModData.gPMMMTraits[iPlayer] and (MapModData.gPMMMTraits[iPlayer].NoMagicalGirls == 1 or MapModData.gPMMMTraits[iPlayer].NoMagicalGirls == true) then
				OnDemonHomuraKillMG(iPlayer, pUnit:GetX(), pUnit:GetY())
				pUnit:Kill(true)
				return
			end

			local iKey = #MagicalGirls + 1

			MagicalGirls[iKey] = {
				["Owner"] = iPlayer,
				["OriginalOwner"] = iPlayer,
				["UnitID"] = iUnit,
				["SoulGem"] = GameDefines.MAXIMUM_SOUL_GEM_AMOUNT,
				--["SkillPoints"] = 0,  --not yet implemented
				["Level"] = 1,
				["Status"] = GameInfoTypes.MGACTIONSTATE_ACTIVE,
				["Class"] = tMagicalGirlSpawnTable["Class"] or 'UNITCLASS_PMMM_MAGICAL_GIRL',
				["TurnCreated"] = Game:GetGameTurn()
			}
				
			--Name her if the spawn table doesn't have a name
			if not tMagicalGirlSpawnTable["Name"] then
				GiveGPAName(iPlayer, iUnit, iUnitType, true)
				MagicalGirls[iKey]["Name"] = pUnit:GetNameNoDesc()
			else
				pUnit:SetName(tMagicalGirlSpawnTable["Name"])
				MagicalGirls[iKey]["Name"] = tMagicalGirlSpawnTable["Name"]
			end

			--If for whatever reason naming didn't work, default to fallback name
			if not pUnit:HasName() then
				pUnit:SetName("TXT_KEY_PMMM_FALLBACK_MAGICAL_GIRL_NAME")
				MagicalGirls[iKey]["Name"] = "TXT_KEY_PMMM_FALLBACK_MAGICAL_GIRL_NAME"
			end

			--Additional abilities if defined (usu. for Leader MGs)
			if tMagicalGirlSpawnTable["ExtraMission"] then
				MagicalGirls[iKey]["ExtraMission"] = tMagicalGirlSpawnTable["ExtraMission"]
			end


			--Extra stuff for leaders
			if tMagicalGirlSpawnTable["IsLeader"] then
				--Highlight the unit's name to make it stand out (only for the unit's name, not the MG table name)
				pUnit:SetName(GameDefines.LEADER_MG_HIGHLIGHT_STRING..Locale.ConvertTextKey(pUnit:GetNameNoDesc())..'[ENDCOLOR]')
					
				--Give them the main leader promotion
				pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_PMMM_MAGICAL_GIRL_LEADER, true)
				
				MagicalGirls[iKey]["IsLeader"] = true
			else
				MagicalGirls[iKey]["IsLeader"] = false
			end
				
			--Initialize her soul gem
			SetSoulGemState(iKey)
				
			--Initialize mood
			RefreshMGMood(iKey, pPlayer, pUnit, true, false)

			--Portrait Overrides
			if tMagicalGirlSpawnTable["IconAtlas"] and tMagicalGirlSpawnTable["PortraitIndex"] then
				MagicalGirls[iKey]["OverrideIcon"] = {tMagicalGirlSpawnTable["IconAtlas"], tMagicalGirlSpawnTable["PortraitIndex"]}
			end

			--Initialize her portrait if there are not already values
			if not MagicalGirls[iKey].OverrideIcon and not MagicalGirls[iKey].BodyIcon
			and not MagicalGirls[iKey].OutfitIcon and not MagicalGirls[iKey].FaceIcon and not MagicalGirls[iKey].HairIcon then
				RandomizeMagicalGirlPortrait(iKey, iPlayer)
			else
				print("Magical Girl already has portrait data, do not randomize.")
			end
				
			--v19: Set Promotions from base Unit from which the MG was created, if they exist
			if tMagicalGirlSpawnTable.Promotions then
				for k, v in ipairs(tMagicalGirlSpawnTable.Promotions) do
					pUnit:SetHasPromotion(v, true)
				end
			end

			--v19: Give move bonus based on certain policies for certain base Units
			if (MagicalGirls[iKey].Class == iGeneralClass and pPlayer:HasPolicy(iLightningWarfare)) or (MagicalGirls[iKey].Class == iAdmiralClass and pPlayer:HasPolicy(iNavigationSchool)) then
				pUnit:SetHasPromotion(iPolicyMovesPromotion, true)
			end
			
			--v21: Leaders and UM's girls get the Immune to Truth promo
			if (MapModData.gPMMMTraits[iPlayer] and (MapModData.gPMMMTraits[iPlayer].NoMagicalGirls == true or MapModData.gPMMMTraits[iPlayer].NoMagicalGirls == 1)) or MagicalGirls[iKey]["IsLeader"] == true then
				pUnit:SetHasPromotion(GameInfoTypes.PROMOTION_PMMM_IMMUNE_TO_TRUTH, true)
			end
			
			--v21: Set Home City
			local pHomeCity;
			if tMagicalGirlSpawnTable.HomeCity then
				MagicalGirls[iKey].HomeCity = tMagicalGirlSpawnTable.HomeCity
				pHomeCity = Vice_DecompileCityID(MagicalGirls[iKey].HomeCity)
			else
				local pCity = FindNearestFriendlyCity(pPlayer, pUnit:GetPlot())
				if pCity then
					MagicalGirls[iKey].HomeCity = CompileCityID(pCity)
					pHomeCity = pCity
				end
			end
			MagicalGirls[iKey].HomeCityLastVisited = Game:GetGameTurn()
			
			--v21: Does the home city have any Hostile Terrains she can adapt to?
			--The terrain must be within 1 tile of the City.
			--In case there are multiple hostile terrains within 1 tile, we will choose based on the one which occurs the most.
			local iNumDeserts = 0
			local iNumTundraSnow = 0
			local iNumJungles = 0
			for pHomeCityPlot in PlotAreaSpiralIterator(pHomeCity:Plot(), 1, false, false, false, true) do
					if pHomeCityPlot:GetTerrainType() == TerrainTypes.TERRAIN_DESERT then
						iNumDeserts = iNumDeserts + 1
					elseif pHomeCityPlot:GetTerrainType() == TerrainTypes.TERRAIN_TUNDRA or pHomeCityPlot:GetTerrainType() == TerrainTypes.TERRAIN_SNOW then
						iNumTundraSnow = iNumTundraSnow + 1
					elseif pHomeCityPlot:GetFeatureType() == FeatureTypes.FEATURE_JUNGLE then
						iNumJungles = iNumJungles + 1
					end
			end
			if iNumDeserts > iNumTundraSnow and iNumDeserts > iNumJungles then
				MagicalGirls[iKey].AdaptedHostileTerrain = TerrainTypes.TERRAIN_DESERT
			elseif iNumTundraSnow > iNumDeserts and iNumTundraSnow > iNumJungles then
				MagicalGirls[iKey].AdaptedHostileTerrain = TerrainTypes.TERRAIN_TUNDRA
			elseif iNumJungles > iNumDeserts and iNumJungles > iNumTundraSnow then
				MagicalGirls[iKey].AdaptedHostileFeature = FeatureTypes.FEATURE_JUNGLE
			end  -- if all values are equal, no adapted terrains are granted
			
			--v21: Grant her first Like/Dislike and set the turn for the next one to appear
			if PMMM.LikesDislikesBegun == true then
				ObtainNewLikeDislike(iPlayer, iKey)
				SetSpecificMGNextLikeDislikeTurn(iPlayer, iKey)
			end
			
			--v21: Are ideologies in play? If so, give her an ideological belief
			if PMMM.AnyoneHasIdeology then
				LuaEvents.PMMMGetMGIdeologicalBelief(iPlayer, iKey)
			end

			--v23: Set Loyalty to 100
			MagicalGirls[iKey].Loyalty = GameDefines.MAXIMUM_MG_LOYALTY

			--v28: Initialize and clear her Influence table to prevent an error!
			MagicalGirls[iKey].Influence = {}

			--Notify player
			local sText = Locale.ConvertTextKey("TXT_KEY_PMMM_MG_CREATED_TEXT", Locale.ConvertTextKey(pUnit:GetNameNoDesc()))
			local sTitle = Locale.ConvertTextKey("TXT_KEY_PMMM_MG_CREATED_TITLE")
			pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GREAT_PERSON_ACTIVE_PLAYER, sText, sTitle, pUnit:GetX(), pUnit:GetY(), iMagicalGirl)
				
			--MGs can't move on the turn which they were contracted, unless they're a leader
			if not MagicalGirls[iKey].IsLeader then
				pUnit:SetMoves(0)
			end
			
			--If debug mode is on, print out everything about this Magical Girl to the console.
			if bDebug then
				print("Magical Girl #" ..iKey.."'s data:") 
				print(Locale.ConvertTextKey(MagicalGirls[iKey].Name))
				print("Owned by "..Players[MagicalGirls[iKey].Owner]:GetCivilizationShortDescription())
				print("Status ID: "..MagicalGirls[iKey].Status)
				print("UnitID: "..MagicalGirls[iKey].UnitID)
				print("Soul Gem: "..MagicalGirls[iKey].SoulGem)
				print("Soul Gem State: "..MagicalGirls[iKey].SoulGemState)
				print("Level: "..MagicalGirls[iKey].Level)
				if MagicalGirls[iKey].Class then
					print("UnitClass: "..Locale.ConvertTextKey(GameInfo.UnitClasses[MagicalGirls[iKey].Class].Description))
				else
					print("No GP Class data.")
				end
				if MagicalGirls[iKey].IsLeader then
					print("This MG is a leader.")
				else
					print("Not a leader.")
				end
				print("Home City: "..Vice_DecompileCityID(MagicalGirls[iKey].HomeCity):GetName())
			end
		end

		--Embark if on water
		if pUnit:GetPlot():IsWater() then
			pUnit:Embark(pUnit:GetPlot())
		end

		--Set combat strength
		SetMagicalGirlStrength(iPlayer, iUnit)
		
	--v21: Check if the new unit is a GP, and if it is, set its Home City to the closest one
	elseif pUnit:IsGreatPerson() and not pUnit:IsHasPromotion(iNoMakeGMG) then
		local pCity = FindNearestFriendlyCity(pPlayer, pUnit:GetPlot())
		if pCity then
			local iSpecialID = GetUnitSpecialID(iPlayer, iUnit)
			PMMM.GPHomeCities[iSpecialID] = CompileCityID(pCity)
		end
	end
	--Clear the spawn table
	tMagicalGirlSpawnTable = {}
end


--Make a magical girl from GP expenditure.
function MadokaInitMagicalGirl(iPlayer, iUnitID, iUnitType, iX, iY)
	if iPlayer < iMaxCivsAndCS then
		local pPlayer = Players[iPlayer]
		local pUsedGP = pPlayer:GetUnitByID(iUnitID)

		--Units with the "does not become MG" promotion...well, you get the idea
		if pUsedGP:IsHasPromotion(iNoMakeGMG) then
			return
		end

		--Demon Homura is a bitch and steals the MG's power as soon as she's gotten what she wanted out of her
		if MapModData.gPMMMTraits[iPlayer] and (MapModData.gPMMMTraits[iPlayer].NoMagicalGirls == true or MapModData.gPMMMTraits[iPlayer].NoMagicalGirls == 1) then
			print("Demon Homura spawned a MG")
			if bIsDHomura and MapModData.gPMMMTraits[iPlayer].CapitalBonusPerKilledMagicalGirl > 0 then
				OnDemonHomuraKillMG(iPlayer, iX, iY)
			end
			return
		end


		if pUsedGP:HasName() then
			tMagicalGirlSpawnTable["Name"] = pUsedGP:GetNameNoDesc()
		end

		
		--v21: Pass home city info
		local iSpecialID = GetUnitSpecialID(iPlayer, iUnitID)
		if PMMM.GPHomeCities[iSpecialID] then
			tMagicalGirlSpawnTable["HomeCity"] = PMMM.GPHomeCities[iSpecialID]
			PMMM.GPHomeCities[iSpecialID] = nil
		end
		
		tMagicalGirlSpawnTable["Class"] = pUsedGP:GetUnitClassType()
		--v19: add promotions given by the base unit (could cause some bugs with some mods, but those can be handled case-by-case)
		tMagicalGirlSpawnTable["Promotions"] = {}
		local sExpendedUnitType = GameInfo.Units[iUnitType].Type
		for row in GameInfo.Unit_FreePromotions() do
			if row.UnitType == sExpendedUnitType then
				tMagicalGirlSpawnTable.Promotions[#tMagicalGirlSpawnTable.Promotions + 1] = GameInfo.UnitPromotions[row.PromotionType].ID
			end
		end

		local eMagicalGirl = pPlayer:InitUnit(iMagicalGirl, iX, iY, UNITAI_ATTACK)
		--This immediately triggers the previous function, so nothing further needed here
	end
end


--Create Leader Magical Girl upon founding of the first city.
function CreateFirstLeaderMagicalGirl(iPlayer, iX, iY)
	if iPlayer ~= iMaxCivsAndCS then  --not iMaxCivs! City-States get Leader MGs too!
		local pCity = Map.GetPlot(iX, iY):GetPlotCity()
		if pCity then
			if pCity:GetOwner() == iPlayer and pCity:IsOriginalCapital() then
				local pPlayer = Players[iPlayer]
				local iCivType = pPlayer:GetCivilizationType()
				local iLeaderType = pPlayer:GetLeaderType()
				local sLeaderKey = GameInfo.Leaders[iLeaderType].Description
				
				--UM and DH don't get them, since they're up in lesbian space doing lesbian space things
				if iCivType == GameInfoTypes.CIVILIZATION_MADOKA or iCivType == GameInfoTypes.CIVILIZATION_DEMON_HOMURA then return end
		
				--Determine name. First, check if there is a Civ-specific override. If not, then if the leader is female, use her name directly.
				--Finally, if neither of those work, she'll just get a generic MG list name.
				local sNameKey;
				if pPlayer:IsMinorCiv() then
					sNameKey = "TXT_KEY_PMMM_LEADER_MG_NAME_"..GameInfo.MinorCivilizations[pPlayer:GetMinorCivType()].Type
				else
					sNameKey = "TXT_KEY_PMMM_LEADER_MG_NAME_"..string.gsub(GameInfo.Civilizations[iCivType].Type, "CIVILIZATION_", "")
				end

				if Locale.ConvertTextKey(sNameKey) ~= sNameKey then
					tMagicalGirlSpawnTable["Name"] = sNameKey
				elseif not pPlayer:IsMinorCiv() then
					if (Locale.ConvertTextKey("{@1: gender feminine?yes; other?no}", sLeaderKey) == "yes") 
						--Special exception for Saber
						or iCivType == GameInfoTypes.CIVILIZATION_BRITAIN_FSN then
						tMagicalGirlSpawnTable["Name"] = sLeaderKey
					end
				end
				--If the previous two didn't work, OnCreatedMagicalGirl() will handle the random name
				
				--Determine if there is a portrait override. If not, then if the leader is female, use her portrait.
				--Otherwise, the portrait will be generated.
				
				if not pPlayer:IsMinorCiv() then
					if GameInfo.Civilizations[iCivType].LeaderMagicalGirlIconAtlasOverride ~= nil and GameInfo.Civilizations[iCivType].LeaderMagicalGirlPortraitIndexOverride > -1 then
						tMagicalGirlSpawnTable["IconAtlas"] = GameInfo.Civilizations[iCivType].LeaderMagicalGirlIconAtlasOverride
						tMagicalGirlSpawnTable["PortraitIndex"] = GameInfo.Civilizations[iCivType].LeaderMagicalGirlPortraitIndexOverride
					else
						if (Locale.ConvertTextKey("{@1: gender feminine?yes; other?no}", sLeaderKey) == "yes") 
							--Special exception for Saber
							or iCivType == GameInfoTypes.CIVILIZATION_BRITAIN_FSN then
							tMagicalGirlSpawnTable["IconAtlas"] = GameInfo.Leaders[iLeaderType].IconAtlas
							tMagicalGirlSpawnTable["PortraitIndex"] = GameInfo.Leaders[iLeaderType].PortraitIndex
						end
					end
				end
				
				tMagicalGirlSpawnTable["Promotions"] = {}
				
				if MapModData.gPMMMTraits[iPlayer] then
					--Does this Civ get an extra promotion for its leader?
					if MapModData.gPMMMTraits[iPlayer].LeaderMGUniquePromotion then
						tMagicalGirlSpawnTable.Promotions[#tMagicalGirlSpawnTable.Promotions + 1] = GameInfo.UnitPromotions[MapModData.gPMMMTraits[iPlayer].LeaderMGUniquePromotion].ID
					end
					
					--Does this Civ get an extra mission for its leader?
					if MapModData.gPMMMTraits[iPlayer].LeaderMGUniqueMission then
						tMagicalGirlSpawnTable["ExtraMission"] = GameInfo.Missions[MapModData.gPMMMTraits[iPlayer].LeaderMGUniqueMission].ID
					end
				end
				
				tMagicalGirlSpawnTable["IsLeader"] = true
				
				local pLeader = pPlayer:InitUnit(iMagicalGirl, iX, iY, UNITAI_DEFENSE)
				
				if MapModData.gPMMMTraits[iPlayer] then
					--Does this Civ get a second leader?
					if MapModData.gPMMMTraits[iPlayer].ExtraLeaderMG == 1 or MapModData.gPMMMTraits[iPlayer].ExtraLeaderMG == true then
						--Determine name. If there is nothing in the trait definition, just get a generic MG list name.
						if MapModData.gPMMMTraits[iPlayer].ExtraLeaderMGName then
							tMagicalGirlSpawnTable["Name"] = MapModData.gPMMMTraits[iPlayer].ExtraLeaderMGName
						end
						
						--Determine if there is a portrait override. Otherwise, the portrait will be generated.
						
						if MapModData.gPMMMTraits[iPlayer].ExtraLeaderMGIconAtlasOverride ~= nil and MapModData.gPMMMTraits[iPlayer].ExtraLeaderMGPortraitIndexOverride > -1 then
							tMagicalGirlSpawnTable["IconAtlas"] = MapModData.gPMMMTraits[iPlayer].ExtraLeaderMGIconAtlasOverride
							tMagicalGirlSpawnTable["PortraitIndex"] = MapModData.gPMMMTraits[iPlayer].ExtraLeaderMGPortraitIndexOverride
						end
						
						tMagicalGirlSpawnTable["Promotions"] = {}
						
						--Does this Civ get an extra promotion for its second leader?
						if MapModData.gPMMMTraits[iPlayer].ExtraLeaderMGUniquePromotion then
							tMagicalGirlSpawnTable.Promotions[#tMagicalGirlSpawnTable.Promotions + 1] = GameInfo.UnitPromotions[MapModData.gPMMMTraits[iPlayer].ExtraLeaderMGUniquePromotion].ID
						end
						
						--Does this Civ get an extra mission for its second leader?
						if MapModData.gPMMMTraits[iPlayer].ExtraLeaderMGUniqueMission then
							tMagicalGirlSpawnTable["ExtraMission"] = GameInfo.Missions[MapModData.gPMMMTraits[iPlayer].ExtraLeaderMGUniqueMission].ID
						end
						
						tMagicalGirlSpawnTable["IsLeader"] = true
						
						local pExtraLeader = pPlayer:InitUnit(iMagicalGirl, iX, iY, UNITAI_DEFENSE)
						
						pExtraLeader:JumpToNearestValidPlot()
					end
				end
				
			end
		end
	end
end


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MAINTENANCE
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Upon new Era, update MGs' strength for the Era. This happens REGARDLESS of territory now. Reach a new Era and the balance of power might just shift!
function UpdateMGStrengthOnEra(eTeam, eEra, bFirst)
	for iPlayer = 0, iMaxCivsAndCS - 1, 1 do
		local pPlayer = Players[iPlayer]
		--as of v27, thanks to Homura's new trait, this will now loop over all players when any player reaches a new era.
		for pUnit in pPlayer:Units() do
			local iUnitType = pUnit:GetUnitType()
			local iStrength;
			if iUnitType == iMagicalGirl then
				SetMagicalGirlStrength(iPlayer, pUnit:GetID())
			--v21: Also update the strengths of Familiars, Witches, Incubators, and Artificial Incubators
			elseif iUnitType == iWitchType or iUnitType == iSeaWitchType then
				iStrength = MapModData.gPMMMWitchEraStrengths[pPlayer:GetCurrentEra()]
			elseif iUnitType == iFamiliarType or iUnitType == iSeaFamiliarType then
				iStrength = MapModData.gPMMMFamiliarEraStrengths[pPlayer:GetCurrentEra()]
			elseif iUnitType == GameInfoTypes.UNIT_PMMM_INCUBATOR or iUnitType == GameInfoTypes.UNIT_PMMM_ARTIFICIAL_INCUBATOR then
				iStrength = MapModData.gPMMMIncubatorEraStrengths[pPlayer:GetCurrentEra()]	
			end
			if iStrength then
				pUnit:SetBaseCombatStrength(iStrength)
			end
		end
	end
end



--Called by GameEvents.UnitPrekill
--When a MG or her Witch dies, update her data accordingly
function UpdateMagicalGirlToDead(iPlayer, iUnit, iUnitType, iX, iY, bDelay, iByPlayer)
	if iUnitType == iMagicalGirl or iUnitType == iWitchType or iUnitType == iSeaWitchType then
		local iMGKey = GetMagicalGirlKey(iPlayer, iUnit)
		if iMGKey then
			if MagicalGirls[iMGKey].Status and (MagicalGirls[iMGKey].Status == GameInfoTypes.MGACTIONSTATE_ACTIVE and iUnitType == iMagicalGirl) or (MagicalGirls[iMGKey].Status == GameInfoTypes.MGACTIONSTATE_WITCH and (iUnitType == iWitchType or iUnitType == iSeaWitchType)) then
				MagicalGirls[iMGKey].Status = GameInfoTypes.MGACTIONSTATE_DEAD
				
				--v19: Leaders respawn
				if MagicalGirls[iMGKey].IsLeader then
					local pPlayer = Players[iPlayer]
					local iNumTurns = math.ceil(GameDefines.LEADER_MG_RESPAWN_TURNS * GameInfo.GameSpeeds[PreGame.GetGameSpeed()].DealDuration / 30)
					if MapModData.gPMMMTraits[iPlayer] and MapModData.gPMMMTraits[iPlayer].LeaderMGRespawnTimeModifier then
						iNumTurns = math.ceil(iNumTurns * ((100 + MapModData.gPMMMTraits[iPlayer].LeaderMGRespawnTimeModifier) / 100))
					end
					MagicalGirls[iMGKey].RespawnTurn = Game:GetGameTurn() + iNumTurns
				end
			end
		end
	end
end


--Do Magical Girl upkeep stuff at beginning of turn.
--1. Automatically heal if hurt (normally 10% of current amount of damage rounded down, so for example if a girl has 20 HP, that means she has 80 damage and will recover 8 HP).
-- Minimum of 1 damage healed if not at full HP
--2. Corrupt Soul Gem. They automatically get a minor degree of corruption (1%) every turn, but receive a much higher Corruption if their Soul Gem heals them
-- (at the rate of 1% per HP healed, variable with Mood)
--3. If the Girl is in Critical, roll a chance to turn into a Witch.
--4. If the Girl is at 0%, immediately turn her into a Witch.
function MagicalGirlUpkeep(iPlayer)
	if iPlayer < iMaxCivsAndCS then
		local pPlayer = Players[iPlayer]
		local bIsHuman = pPlayer:IsHuman()
		local iTurn = Game:GetGameTurn()
		for pUnit in pPlayer:Units() do
			if pUnit:GetUnitClassType() == GameInfoTypes.UNITCLASS_PMMM_MAGICAL_GIRL then
				local iUnitID = pUnit:GetID()
				local iMGKey = GetMagicalGirlKey(iPlayer, iUnitID)
				
				if iMGKey then
					--Refresh certain bits of data.
					MagicalGirls[iMGKey].Promotions = {}
					MagicalGirls[iMGKey].Level = pUnit:GetLevel()
					MagicalGirls[iMGKey].XP = pUnit:GetExperience()
					MagicalGirls[iMGKey]["HP"] = pUnit:GetCurrHitPoints()
					MagicalGirls[iMGKey]["X"] = pUnit:GetX()
					MagicalGirls[iMGKey]["Y"] = pUnit:GetY()
					
					
					--v21: Grant a Like/Dislike, if the turn number is right for her and L/Ds have started being handed out
					if PMMM.LikesDislikesBegun then
						if MagicalGirls[iMGKey].NextLikeDislikeTurn and MagicalGirls[iMGKey].NextLikeDislikeTurn <= iTurn then
							ObtainNewLikeDislike(iPlayer, iMGKey, true)
							SetSpecificMGNextLikeDislikeTurn(iPlayer, iMGKey)
						elseif not MagicalGirls[iMGKey].NextLikeDislikeTurn and #MagicalGirls[iMGKey].LikesDislikes < GameDefines.MG_MAX_LIKES_DISLIKES then
							SetSpecificMGNextLikeDislikeTurn(iPlayer, iMGKey)
						end
					elseif iTurn >= GameDefines.MG_LIKE_DISLIKE_STARTING_TURN then
						PMMM.LikesDislikesBegun = true
						ObtainNewLikeDislike(iPlayer, iMGKey, true)
						SetSpecificMGNextLikeDislikeTurn(iPlayer, iMGKey)
					end
					
					--v21: Check if near home city
					if MagicalGirls[iMGKey].HomeCity then
						local pCity = Vice_DecompileCityID(MagicalGirls[iMGKey].HomeCity)
						if pCity then
							if Map.PlotDistance(pUnit:GetX(), pUnit:GetY(), pCity:GetX(), pCity:GetY()) <= 1 then
								MagicalGirls[iMGKey].HomeCityLastVisited = iTurn
							end
						end
					end


					--v21: Refresh mood. For speed, this call will not grab tooltips (only new MGs and Events.UnitSelectionChanged do that). Runs accumulators.
					RefreshMGMood(iMGKey, pPlayer, pUnit, false, true)
					
					--Refresh current promotions
					for row in GameInfo.UnitPromotions() do
						if pUnit:IsHasPromotion(row.ID) then
							MagicalGirls[iMGKey].Promotions[#MagicalGirls[iMGKey].Promotions + 1] = row.ID
						end
					end
					
					
					--Set Ideology if needed
					if PMMM.AnyoneHasIdeology and not MagicalGirls[iMGKey].IdeologicalBelief then LuaEvents.PMMMGetMGIdeologicalBelief(iPlayer, iMGKey) end


					--v23: Adjust Loyalty and Other Civs' Influence
					if MagicalGirls[iMGKey].IsLeader then
						MagicalGirls[iMGKey].Loyalty = GameDefines.MAXIMUM_MG_LOYALTY
					else
						--From Mood
						local iLoyaltyChange = GameInfo.MG_Moods[MagicalGirls[iMGKey].MoodLevel].LoyaltyChange
						
						--From Tourism
						iLoyaltyChange = iLoyaltyChange +  math.floor((pPlayer:GetTourism() + GetEmpireEntertainment(pPlayer)) / GameDefines.LOYALTY_TOURISM_ENTERTAINMENT_DIVISOR)

						--From LDs
						local LIKE_TYPE = 0
						local DISLIKE_TYPE = 1
						local LOVE_TYPE = 2
						local HATE_TYPE = 3

						local tLDFulfillment = {}
						MagicalGirls[iMGKey].LDLoyaltyChange  = 0 --for MagicalGirlInfoPanel
						--She'll never get influence for a Civ she dislikes or hates
						local tDislikedCivs = {}
						for k, v in pairs(MagicalGirls[iMGKey].LikesDislikes) do
							if v.Category == GameInfoTypes.MGLIKEDISLIKE_CIVILIZATION and (v.Type == DISLIKE_TYPE or v.Type == HATE_TYPE) then
								tDislikedCivs[v.Value] = true
							end
						end
						local iFromLDs = 0
						for k, v in pairs(MagicalGirls[iMGKey].LikesDislikes) do
							local iOurFulfillment = t_LikesDislikes[v.Category].FulfilledFunc(iPlayer, iMGKey, v.Type, v.Value)
							tLDFulfillment[k] = iOurFulfillment
							
							if iOurFulfillment ~= 0 then
								if v.Type == LIKE_TYPE or v.Type == DISLIKE_TYPE then
									iFromLDs = iFromLDs + math.ceil(iOurFulfillment * (GameDefines.MG_LD_LOYALTY_MULTIPLIER_LIKE_DISLIKE_X1000 / 1000))
								elseif v.Type == LOVE_TYPE or v.Type == HATE_TYPE then
									iFromLDs = iFromLDs + math.ceil(iOurFulfillment * (GameDefines.MG_LD_LOYALTY_MULTIPLIER_LOVE_HATE_X1000 / 1000))
								end
							end
						end
						--Ideology
						local iPlayerIdeology = pPlayer:GetLateGamePolicyTree()
						if iPlayerIdeology then
							local iOurFulfillment = tIdeologyLDTable.FulfilledFunc(iPlayer, iMGKey, k)
							iFromLDs = iFromLDs + math.ceil(iOurFulfillment * (GameDefines.MG_LD_LOYALTY_MULTIPLIER_IDEOLOGY_X1000 / 1000))
						end
						MagicalGirls[iMGKey].LDLoyaltyChange = iFromLDs
						iLoyaltyChange = iLoyaltyChange + iFromLDs

						--From other Civs
						if not MagicalGirls[iMGKey].Influence then MagicalGirls[iMGKey].Influence = {} end
						local iInfNeeded = GameDefines.MG_INFLUENCE_NEEDED_PER_LOYALTY_POINT_DEDUCTION
						for k, v in pairs(MagicalGirls[iMGKey].Influence) do
							if k ~= iPlayer then
								local pInfluencePlayer = Players[k]
								if pInfluencePlayer:IsAlive() then
									local iAmount = math.floor(v / iInfNeeded)
									iLoyaltyChange = iLoyaltyChange - iAmount
								end
							end
						end
						
						--AI Handicap Bonus
						if not pPlayer:IsHuman() then
							local iHandicap = Game:GetHandicapType() + 1 --Handicap types start at 0
							iLoyaltyChange = iLoyaltyChange + (iHandicap + GameDefines.AI_MG_LOYALTY_BONUS_PER_TURN)				
						end

						MagicalGirls[iMGKey].Loyalty = MagicalGirls[iMGKey].Loyalty + iLoyaltyChange

						--clamp
						MagicalGirls[iMGKey].Loyalty = math.min(MagicalGirls[iMGKey].Loyalty, GameDefines.MAXIMUM_MG_LOYALTY)
						
						--Adjust likes of Ideology based on Loyalty
						if MagicalGirls[iMGKey].IdeologicalBelief and iPlayerIdeology > -1 then
							if MagicalGirls[iMGKey].Loyalty > GameDefines.MG_IDEOLOGY_LOYALTY_AFFECT_THRESHOLD then
								if not MagicalGirls[iMGKey].IdeologicalBelief[iPlayerIdeology] then MagicalGirls[iMGKey].IdeologicalBelief[iPlayerIdeology] = 100 end
								MagicalGirls[iMGKey].IdeologicalBelief[iPlayerIdeology] = MagicalGirls[iMGKey].IdeologicalBelief[iPlayerIdeology] + GameDefines.MG_IDEOLOGY_LOYALTY_AFFECT_AMOUNT
							else
								if not MagicalGirls[iMGKey].IdeologicalBelief[iPlayerIdeology] then MagicalGirls[iMGKey].IdeologicalBelief[iPlayerIdeology] = 100 end
								MagicalGirls[iMGKey].IdeologicalBelief[iPlayerIdeology] = math.floor(MagicalGirls[iMGKey].IdeologicalBelief[iPlayerIdeology] - GameDefines.MG_IDEOLOGY_LOYALTY_AFFECT_AMOUNT)
							end
						end

						if MagicalGirls[iMGKey].Loyalty <= 0 then
							DoMagicalGirlDisappearFromMapAction(iMGKey, iPlayer, pUnit:GetID(), GameInfoTypes.MGACTIONSTATE_DEFECTING)
							break
						else
							--Adjust Influence
							--Influence increases or decreases by the following:
							--Cultural Influence
							--Fulfilled LDs
							--Vacations (that's handled in the vacation ReturnMapFunction though)
							local pTeam = Teams[pPlayer:GetTeam()]
							for i = 0, iMaxCivs - 1, 1 do
								if i ~= iPlayer and not tDislikedCivs[i] then
									if not MagicalGirls[iMGKey].Influence[i] then MagicalGirls[iMGKey].Influence[i] = 0 end
									local pLoop = Players[i]
									if pTeam:IsHasMet(pLoop:GetTeam()) then
										local iInfluenceChange = 0
										for k, v in pairs(MagicalGirls[iMGKey].LikesDislikes) do
											local iTheirFulfillment = t_LikesDislikes[v.Category].FulfilledFunc(i, iMGKey, v.Type, v.Value)
											if iTheirFulfillment <= tLDFulfillment[k] then
												if v.Type == LIKE_TYPE or v.Type == DISLIKE_TYPE then
													iInfluenceChange = iInfluenceChange - GameDefines.MG_INFLUENCE_MODIFIER_LIKE_DISLIKE
												elseif v.Type == LOVE_TYPE or v.Type == HATE_TYPE then
													iInfluenceChange = iInfluenceChange - GameDefines.MG_INFLUENCE_MODIFIER_LOVE_HATE
												end
											elseif t_LikesDislikes[v.Category].FulfilledFunc(i, iMGKey, v.Type, v.Value) >= 0 then
												if v.Type == LIKE_TYPE or v.Type == DISLIKE_TYPE then
													iInfluenceChange = iInfluenceChange + GameDefines.MG_INFLUENCE_MODIFIER_LIKE_DISLIKE
												elseif v.Type == LOVE_TYPE or v.Type == HATE_TYPE then
													iInfluenceChange = iInfluenceChange + GameDefines.MG_INFLUENCE_MODIFIER_LOVE_HATE
												end
											end
										end
										--Ideology
										if PMMM.AnyoneHasIdeology then
											local iOtherPlayerIdeology = pLoop:GetLateGamePolicyTree()
											if iOtherPlayerIdeology then
												local iHighestIdeology = - 1
												local iHighestIdeologyAmount = 0
												for k, v in pairs(MagicalGirls[iMGKey].IdeologicalBelief) do
													if v > iHighestIdeologyAmount then
														iHighestIdeology = k
														iHighestIdeologyAmount = v
													end
												end
												if iOtherPlayerIdeology == iHighestIdeology and iOtherPlayerIdeology ~= pPlayer:GetLateGamePolicyTree() then
													iInfluenceChange = iInfluenceChange + GameDefines.MG_INFLUENCE_MODIFIER_IDEOLOGY
												else
													iInfluenceChange = iInfluenceChange - GameDefines.MG_INFLUENCE_MODIFIER_IDEOLOGY
												end
											end
										end
										--Cultural Influence THEY have over US increases MG Influence.
										--Cultural Influence WE have over THEM decreases MG Influence.
										local iTheirInfluence = pLoop:GetInfluenceLevel(iPlayer);
										iInfluenceChange = iInfluenceChange + (iTheirInfluence * GameDefines.MG_INFLUENCE_FROM_CULTURAL_INFLUENCE)
										local iOurInfluence = pPlayer:GetInfluenceLevel(i);
										iInfluenceChange = iInfluenceChange - (iOurInfluence * GameDefines.MG_INFLUENCE_FROM_CULTURAL_INFLUENCE)

										MagicalGirls[iMGKey].Influence[i] = math.max(MagicalGirls[iMGKey].Influence[i] + iInfluenceChange, 0)
									end
								end
							end
						end
					end
					
					--Find out the corruption amount.
					if pUnit then
						local iTotalCorruption = iCorruptionPerTurnBase
						local iCurrentDamage = pUnit:GetDamage()
						local iHealAmount = 0
						if iCurrentDamage > 0 then
							iHealAmount = math.max(math.floor(iCurrentDamage / 10), 1)
						end
						iTotalCorruption = iTotalCorruption + (iHealAmount * iCorruptionPerHPHealedBase)

						--Summoned Witches double the corruption rate, and add 1 to the multiplier for every 2 tiles away from it she is
						if MagicalGirls[iMGKey].SummonedWitch then
							local iMultiplier;
							local _, iUnit = ReturnPlayerAndUnitIDsFromSpecialID(MagicalGirls[iMGKey].SummonedWitch)
							local pWitchUnit = Players[_]:GetUnitByID(iUnit)
							local iDistance = Map.PlotDistance(pWitchUnit:GetX(), pWitchUnit:GetY(), pUnit:GetX(), pUnit:GetY())
							iMultiplier = 2 + math.floor(iDistance / 2)
							iTotalCorruption = iTotalCorruption * iMultiplier	
						end

						--Adjust the amount based on Mood
						--As of v25r4, there is now a bare minimum 1% per turn corruption!
						iTotalCorruption = math.max(iTotalCorruption + GameInfo.MG_Moods[MagicalGirls[iMGKey].MoodLevel].SoulGemCorruptionMod, 1)

						--v27: Promotions can now affect this number too
						for k, v in pairs(MapModData.gPMMMSoulGemCorruptionPromotions) do
							if pUnit:IsHasPromotion(k) then
								iTotalCorruption = math.max(iTotalCorruption + v, 1)
							end
						end
						
						if iTotalCorruption > 0 then
							dprint("Total corruption this turn for " ..pUnit:GetNameNoDesc().. ": " ..iTotalCorruption)
							DoChangeCorruption(iTotalCorruption, iMGKey)
						end

						--Immediately become a Witch at 0 or less percent.
						if MagicalGirls[iMGKey].SoulGem <= 0 then
							if MapModData.gPMMMTraits[iPlayer] and (MapModData.gPMMMTraits[iPlayer].NoWitches == true or MapModData.gPMMMTraits[iPlayer].NoWitches == 1) then
								DoLawOfCyclesTakeaway(iMGKey)
							else
								TurnIntoWitch(iMGKey)
							end
						else
							SetSoulGemState(iMGKey)
							pUnit:ChangeDamage(-1 * iHealAmount)
							--AI logic to use Grief Seeds. Use one if the SG meter is at 50% or less.
							if not bIsHuman then
								if not PMMM.GriefSeeds[iPlayer] then PMMM.GriefSeeds[iPlayer] = 0 end
								if MagicalGirls[iMGKey].SoulGem <= 50 and PMMM.GriefSeeds[iPlayer] > 0 then
									DoConsumeGriefSeed(iMGKey, iPlayer)
								end
							end
						end
						--If she's in Critical, she might become a Witch!
						if (MapModData.gPMMMSoulGemStates[MagicalGirls[iMGKey].SoulGemState].CanBecomeWitch == 1 or MapModData.gPMMMSoulGemStates[MagicalGirls[iMGKey].SoulGemState].CanBecomeWitch == true) then
							local iRand = Game.Rand(100, "PMMM Roll to become Witch")
							--The chance starts at 10% and increases by 5% for every 1 percent her Soul Gem is below the MaxPercent.
							local iThreshold = 10 + ((MapModData.gPMMMSoulGemStates[MagicalGirls[iMGKey].SoulGemState].MaxPercent - MagicalGirls[iMGKey].SoulGem) * 5)
							if iRand <= iThreshold then
								if MapModData.gPMMMTraits[iPlayer] and (MapModData.gPMMMTraits[iPlayer].NoWitches == true or MapModData.gPMMMTraits[iPlayer].NoWitches == 1) then
									DoLawOfCyclesTakeaway(iMGKey)
								else
									TurnIntoWitch(iMGKey)
								end
							end
						end
					end
				end
			end
		end
		--City-States get free Grief Seeds every number of turns equal to the game's Deal Duration, since they aren't going out and hunting Witches
		if iPlayer >= iMaxCivs and iPlayer < iMaxCivsAndCS then
			local iTurn = Game.GetGameTurn()
			if iTurn >= iDealDuration then
				if (iTurn % iDealDuration) == 0 then
					if PMMM.GriefSeeds[iPlayer] then
						PMMM.GriefSeeds[iPlayer] = PMMM.GriefSeeds[iPlayer] + 1
					else
						PMMM.GriefSeeds[iPlayer] = 1
					end
				end
			end
		end
		
		--v19: Check if leaders can respawn
		local tRemove = {}
		for k, v in pairs(MagicalGirls) do
			if v.RespawnTurn then
				if v.Owner == iPlayer and pPlayer:IsAlive() and Game:GetGameTurn() >= v.RespawnTurn and pPlayer:GetCapitalCity() ~= nil then
					tMagicalGirlSpawnTable["ID"] = k
					tMagicalGirlSpawnTable["LeaderRespawn"] = true
					tRemove[k] = true
					v.SoulGem = 50
					local pUnit = pPlayer:InitUnit(iMagicalGirl, pPlayer:GetCapitalCity():GetX(), pPlayer:GetCapitalCity():GetY(), UNITAI_DEFENSE)
					v.RespawnTurn = nil
				end
			end
		end
	end
end



--Turn that bitch into a Witch!
function TurnIntoWitch(iMGKey, pGivenPlot)
	local pPlayer, pUnit = RetrieveMGPointers(iMGKey)
	
	--v19: Leaders respawn
	if MagicalGirls[iMGKey].IsLeader == true then
		local ID = pUnit:GetID()
		local iPlayer = pPlayer:GetID()
		local iX = pUnit:GetX()
		local iY = pUnit:GetX()
		pUnit:Kill(true)
		local iNumTurns = math.ceil(GameDefines.LEADER_MG_RESPAWN_TURNS * GameInfo.GameSpeeds[PreGame.GetGameSpeed()].DealDuration / 30)
		if MapModData.gPMMMTraits[iPlayer] and MapModData.gPMMMTraits[iPlayer].LeaderMGRespawnTimeModifier then
			iNumTurns = math.ceil(iNumTurns * ((100 + MapModData.gPMMMTraits[iPlayer].LeaderMGRespawnTimeModifier) / 100))
		end
		MagicalGirls[iMGKey].RespawnTurn = Game:GetGameTurn() + iNumTurns
		sText = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_LEADER_MG_BECAME_WITCH_TEXT", Locale.ConvertTextKey(MagicalGirls[iMGKey].Name))
		sTitle = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_LEADER_MG_BECAME_WITCH_TITLE")
		pPlayer:AddNotification(NotificationTypes.NOTIFICATION_UNIT_DIED, sText, sTitle, iX, iY, iMagicalGirl)
	else
		local pBarbPlayer = Players[iMaxCivsAndCS]
		--if pGivenPlot is true, that means another function gave it a plot to spawn on so use that
		local pPlot;
		if pGivenPlot then
			pPlot = pGivenPlot
		else
			pPlot = FindBestEnemySpawnPlot(pUnit:GetPlot())
		end
		local iX = pPlot:GetX()
		local iY = pPlot:GetY()
		--Adjust the table to match the new status as a Witch. Just because she's a Witch now doesn't mean her past Relationships aren't there to hurt her old friends!
		MagicalGirls[iMGKey].Owner= iMaxCivsAndCS
		MagicalGirls[iMGKey].Status = GameInfoTypes.MGACTIONSTATE_WITCH
		if pUnit then
			pUnit:Kill(true)
		end
		local iType;
		if pPlot:IsWater() then
			iType = iSeaWitchType
		else
			iType = iWitchType
		end
		pWitch = pBarbPlayer:InitUnit(iType, iX, iY, UNITAI_ATTACK)
		MagicalGirls[iMGKey].UnitID = pWitch:GetID()
		local sName =  Locale.ConvertTextKey(MagicalGirls[iMGKey].Name)..Locale.ConvertTextKey("TXT_KEY_PMMM_WITCH_NAME_APPEND")
		pWitch:SetName(sName)
		sText = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_MG_BECAME_WITCH_TEXT", Locale.ConvertTextKey(MagicalGirls[iMGKey].Name))
		sTitle = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_MG_BECAME_WITCH_TITLE")
		pPlayer:AddNotification(NotificationTypes.NOTIFICATION_UNIT_DIED, sText, sTitle, iX, iY, iMagicalGirl)
		local iCurrentEra = pPlayer:GetCurrentEra()
		--Witches made from MGs are stronger
		pWitch:SetBaseCombatStrength(math.floor(MapModData.gPMMMWitchEraStrengths[iCurrentEra] * 1.2))
		if PMMM.NumMGsTurnedToWitch[iPlayer] then
			PMMM.NumMGsTurnedToWitch[iPlayer] = PMMM.NumMGsTurnedToWitch[iPlayer] + 1
		else
			PMMM.NumMGsTurnedToWitch[iPlayer] = 1
		end
		
		--v21: All MGs within 2 tiles of her (whether they belong to the same owner or not) learn The Truth
		local iTurn = Game:GetGameTurn()
		local iPlotOwner = pPlot:GetOwner()
		for pAreaPlot in PlotAreaSpiralIterator(pPlot, 2) do
			for i = 0, pPlot:GetNumUnits() - 1 do
				local pUnit = pPlot:GetUnit(i)
				if pUnit:GetUnitClassType() == iMagicalGirlClass then
					local iOwner = pUnit:GetOwner()
					local pOwner = Players[iOwner]
					local iOtherMGKey = GetMagicalGirlKey(iOwner, pUnit:GetID())
					if iOtherMGKey and not MagicalGirls[iOtherMGKey].TruthDiscoveredTurn then
						MagicalGirls[iOtherMGKey].TruthDiscoveredTurn = iTurn
						local sTitle = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_REVEALED_TRUTH_TITLE")
						local sText = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_WITCH_TRANSFORMATION_REVEALED_TRUTH_TEXT", Locale.ConvertTextKey(MagicalGirls[iMGKey].Name), Locale.ConvertTextKey(MagicalGirls[iOtherMGKey].Name))
						pOwner:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, sText, sTitle, pUnit:GetX(), pUnit:GetY())
						
						--Major diplomatic penalty for "Witch-bombing," aka a tactic of dropping a despairing MG into someone else's territory to make them learn The Truth
						--Happens if done to a player's MG other than the player whose MG made the transformation WHILE in their territory.
						if iOwner == iPlotOwner then
							if not PMMM.WitchBombings[iPlayer] then PMMM.WitchBombings[iPlayer] = {} end
							if not PMMM.WitchBombings[iPlayer][iOwner] then
								PMMM.WitchBombings[iPlayer][iOwner] = 1
							else
								PMMM.WitchBombings[iPlayer][iOwner] = PMMM.WitchBombings[iPlayer][iOwner] + 1
							end
						end
					end
				end
			end
		end
	end
end

local iWitchBombingEvent = GameInfoTypes.DIPLOMODIFIER_PMMM_ALLOWED_WITCHOUT_IN_THEIR_TERRITORY

function DiploPenaltyForWitchBombing(iEvent, iFromPlayer, iToPlayer)
	if iEvent == iWitchBombingEvent then
		if PMMM.WitchBombings[iToPlayer] then
			if PMMM.WitchBombings[iToPlayer][iFromPlayer] then
				return PMMM.WitchBombings[iToPlayer][iFromPlayer] * GameDefines.WITCH_BOMBING_DIPLO_PENALTY
			end	
		end
	end
	return 0
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MISC
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Magical Girls and Witches cannot be deleted or gifted.
function PreventDeletePMMMUnits(iPlayer, iUnit, iCommand, iData1, iData2, iPlotX, iPlotY, bTestVisible)
	if iCommand == iCommandDelete or iCommand == iCommandGift then
		local pUnit = Players[iPlayer]:GetUnitByID(iUnit)
		local iUnitType = pUnit:GetUnitType()
		if iUnitType == iMagicalGirl or iUnitType == iWitchType or iUnitType == iSeaWitchType then
			return false
		end
	end
	return true
end



--If a GP spawns without a proper name, give it one from the Generic MGs table.
function GiveGPAName(iPlayer, iUnit, iUnitType, bMagicalGirl)
	if iPlayer < iMaxCivsAndCS then
		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iUnit)
		if (pUnit:IsGreatPerson() and not pUnit:HasName()) or bMagicalGirl == true then  --bMagicalGirl is used if this is called from the next function
			local tNameTable = {}
			local tReverseTable = {} --to lookup the name that gets chosen so it can be set as in-use
			for k, v in pairs(MapModData.gPMMMGenericMGNames) do
				if not PMMM.UsedGenericMGNames[k] then
					tNameTable[#tNameTable + 1] = v
					tReverseTable[v] = k
				end
			end
			if #tNameTable > 0 then
				local iChosenName = Game.Rand(#tNameTable, "Random GP Name Roll") + 1
				pUnit:SetName(tNameTable[iChosenName])
				local iTableKey = tReverseTable[tNameTable[iChosenName]]
				PMMM.UsedGenericMGNames[iTableKey] = true
			else --if all else fails, just give her the fallback text key. She needs some sort of entry in the Name field.
				pUnit:SetName("TXT_KEY_PMMM_FALLBACK_MAGICAL_GIRL_NAME")
			end
		end
	end
end



--Click Buttons for the Witch Hunt mission
function WitchHuntCustomMissionPossible(iPlayer, iUnit, iMission, iData1, iData2, _, _, iPlotX, iPlotY, bTestVisible)
	if iPlayer < iMaxCivs then
		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iUnit)
		local pPlot = pUnit:GetPlot()
		--Must be an MG and the mission checked must be Witch Hunt
		if pUnit:GetUnitType() == iMagicalGirl and iMission == iWitchHuntMission and PMMM.IsSpawningHiddenWitches then
			if not pUnit:IsEmbarked() and not pUnit:GetPlot():IsCity() then
				for k, v in pairs(PMMM.HiddenWitchCities) do
					local pCityPlot = ReturnPlotFromSpecialID(k)
					--Check if the distance between the city and the unit is higher than the maximum possible witch distance before we actually iterate over all of those plots
					if Map.PlotDistance(pPlot:GetX(), pPlot:GetY(), pCityPlot:GetX(), pCityPlot:GetY()) <= GameDefines.HIDDEN_WITCH_SPAWN_MAX_DISTANCE_FROM_CITY then
						local pCity = pCityPlot:GetPlotCity()
						if pCity then
						local iNumPlots = pCity:GetNumCityPlots();
							for iPlot = 0, iNumPlots - 1 do
								local pIndexPlot = pCity:GetCityIndexPlot(iPlot)
								if pIndexPlot == pPlot then
									return true
								end
							end
						end
					end
				end
			end
			return bTestVisible
		end
	end
	return false
end

function WitchHuntCustomMissionStart(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	if iMission == iWitchHuntMission then
		local iMGKey = GetMagicalGirlKey(iPlayer, iUnit)
		DoMagicalGirlDisappearFromMapAction(iMGKey, iPlayer, iUnit, GameInfoTypes.MGACTIONSTATE_WITCH_HUNT)
	end
	return 0
end

function WitchHuntCustomMissionCompleted(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	if iMission == iWitchHuntMission then
		return true
	end
	return false
end


--Sparring
function SparringCustomMissionPossible(iPlayer, iUnit, iMission, iData1, iData2, _, _, iPlotX, iPlotY, bTestVisible)
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnit)
	if iMission == iSparringMission and pUnit:GetUnitClassType() == iMagicalGirlClass and not pUnit:IsEmbarked() then
		if pUnit:GetDamage() == 0 then
			local iMGKey = GetMagicalGirlKey(iPlayer, iUnit)
			if (not MagicalGirls[iMGKey].SparringCooldown or Game:GetGameTurn() - MagicalGirls[iMGKey].SparringCooldown >= iSparCooldown) then
				for pAreaPlot in PlotAreaSpiralIterator(pUnit:GetPlot(), 1, false, false, false, true) do
					if pAreaPlot:IsCity() then
						local pCity = pAreaPlot:GetPlotCity()
						if pCity and pCity:GetOwner() == iPlayer and not pCity:IsRazing() and not PMMM.SparringCities[CompileCityID(pCity)] then
							return true
						end
					end
				end
				return bTestVisible
			else
				return bTestVisible
			end
		else
			return bTestVisible
		end
	end
	return false
end

function SparringCustomMissionStart(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	if iMission == iSparringMission then	
		DoSparring(iPlayer, Players[iPlayer]:GetUnitByID(iUnit), Map.GetPlot(-iData1, -iData2))
	end
	return 0
end

function SparringCustomMissionCompleted(iPlayer, iUnit, iMission, iData1, iData2, iFlags, iTurn)
	if iMission == iSparringMission then
		return true
	end
	return false
end

function DoSparring(iPlayer, pHeadUnit, pPlot)
	local pPlayer = Players[iPlayer]
	for i = 0, pPlot:GetNumUnits() - 1 do
		local pUnit = pPlot:GetUnit(i)
		if pUnit:GetUnitClassType() == iMagicalGirlClass and pUnit:GetOwner() == iPlayer then
			local iOwner = pUnit:GetOwner()

			for pAreaPlot in PlotAreaSpiralIterator(pUnit:GetPlot(), 1, false, false, false, true) do
				if pAreaPlot:IsCity() then
					local pCity = pAreaPlot:GetPlotCity()
					if pCity:GetOwner() == iPlayer then
						PMMM.SparringCities[CompileCityID(pCity)] = true
						break
					end
				end
			end

			local iThisID = pHeadUnit:GetID()
			local iThatID = pUnit:GetID()
			local iThisMGKey = GetMagicalGirlKey(iPlayer, iThisID)
			local iThatMGKey = GetMagicalGirlKey(iPlayer, iThatID)
			
			MagicalGirls[iThisMGKey].SparringPartner = iThatMGKey
			MagicalGirls[iThatMGKey].SparringPartner = iThisMGKey
			
			DoMagicalGirlDisappearFromMapAction(iThisMGKey, iPlayer, iThisID, GameInfoTypes.MGACTIONSTATE_SPARRING)
			DoMagicalGirlDisappearFromMapAction(iThatMGKey, iPlayer, iThatID, GameInfoTypes.MGACTIONSTATE_SPARRING)
		end
	end
end



--To Handle any "disappear from map" actions such as Witch Hunting.
function DoMagicalGirlDisappearFromMapAction(iMGKey, iPlayer, iUnit, iState)
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnit)
	--Save the MG's data such as its promotions, HP, and position
	MagicalGirls[iMGKey].Promotions = {}
	for row in GameInfo.UnitPromotions() do
		if pUnit:IsHasPromotion(row.ID) then
			MagicalGirls[iMGKey].Promotions[#MagicalGirls[iMGKey].Promotions + 1] = row.ID
		end
	end
	MagicalGirls[iMGKey].PositionX = pUnit:GetX()
	MagicalGirls[iMGKey].PositionY = pUnit:GetY()
	MagicalGirls[iMGKey].HP = pUnit:GetCurrHitPoints()
	MagicalGirls[iMGKey].XP = pUnit:GetExperience()
	MagicalGirls[iMGKey].Level = pUnit:GetLevel()
	MagicalGirls[iMGKey].Status = iState
	MagicalGirls[iMGKey].StatusTurns = GameInfo.MG_ActionStates[iState].Turns
	--UM's girls should unsummon their Witches
	if MagicalGirls[iMGKey].SummonedWitch then
		local pWitch = ReturnUnitFromSpecialID(MagicalGirls[iMGKey].SummonedWitch)
		DoUnsummonWitch(iPlayer, pWitch:GetID())
	end
	OnMGLeaveMap(iMGKey, iState)
	pUnit:Kill(true)
end

function DoActionStateTurnUpkeep(iPlayer)
	--This will loop twice due to issues with adjusting values of tables while looping through them.
	--SecondLoopKeys keeps which Keys to iterate over in the second loop instead of going through the whole table twice.
	local SecondLoopKeys = {}
	for k, v in pairs(MagicalGirls) do
		if v.StatusTurns then
			local iMGKey = k
			if MagicalGirls[iMGKey].Owner == iPlayer then
				MagicalGirls[iMGKey].StatusTurns = MagicalGirls[iMGKey].StatusTurns - 1
				SecondLoopKeys[#SecondLoopKeys + 1] = iMGKey
			end
		end
	end
	for k, v in pairs(SecondLoopKeys) do
		local iTurns = MagicalGirls[v].StatusTurns
		if iTurns <= 0 then
			local pPlayer = Players[iPlayer]
			OnMGReturnMap(v, MagicalGirls[v].Status)
			MagicalGirls[v].Status = GameInfoTypes.MGACTIONSTATE_ACTIVE
			tMagicalGirlSpawnTable.ID = v
			local bRelocate = Map.GetPlot(MagicalGirls[v].PositionX, MagicalGirls[v].PositionY):IsVisibleEnemyUnit(iPlayer)
			if not bRelocate then
				bRelocate = Map.GetPlot(MagicalGirls[v].PositionX, MagicalGirls[v].PositionY):IsVisibleOtherUnit(iPlayer)
			end
			local pRespawn = pPlayer:InitUnit(iMagicalGirl, MagicalGirls[v].PositionX, MagicalGirls[v].PositionY, UNITAI_ATTACK)
			if bRelocate then
				pRespawn:JumpToNearestValidPlot()
			end
			MagicalGirls[v].StatusTurns = nil
		end
	end
end


--The first is triggered when a MG leaves the map for Map Leave actions, and the second function when they come back.
--This looks through MapModData.gPMMMOnMGLeaveMapFunctions and MapModData.gPMMMOnMGReturnMapFunctions for the functions to use.
--This enables other users to add their own functions if they wish, by adding them into MapModData.

if not MapModData.gPMMMOnMGLeaveMapFunctions then
	MapModData.gPMMMOnMGLeaveMapFunctions = {}
end

function OnMGLeaveMap(iMGKey, iState)
	local actionState = GameInfo.MG_ActionStates[iState]
	if actionState.Turns > -1 then
		if MapModData.gPMMMOnMGLeaveMapFunctions[iState] then
			MapModData.gPMMMOnMGLeaveMapFunctions[iState](iMGKey)
			return true
		end
	end
end

if not MapModData.gPMMMOnMGReturnMapFunctions then
	MapModData.gPMMMOnMGReturnMapFunctions = {}
end

function OnMGReturnMap(iMGKey, iState)
	local actionState = GameInfo.MG_ActionStates[iState]
	if actionState.Turns > -1 then
		if MapModData.gPMMMOnMGReturnMapFunctions[iState] then
			MapModData.gPMMMOnMGReturnMapFunctions[iState](iMGKey)
			return true
		end
	end
end



local bCulturalMGSkinTones;

for row in GameInfo.WishForTheWorldOptions() do
	if row.Option == 'CulturalMGSkinTones' and row.Value ~= 0 then
		bCulturalMGSkinTones = true
	end
end

function RandomizeMagicalGirlPortrait(iKey, iOwner)
	dprint("RandomizeMagicalGirlPortrait called with MG Key #"..iKey.." and PlayerID "..iOwner)
	--Body/Skin
	local pPlayer = Players[iOwner]
	local iBodyType;
	local iNumBodyTypes = -1
	for row in GameInfo.MG_IconBodies() do
		iNumBodyTypes = iNumBodyTypes + 1
	end
	if iNumBodyTypes > -1 then
		iBodyType = Game.Rand(iNumBodyTypes, "MG Body Type Roll")
	end
	if iBodyType then
		local iColor = -1;
		if bCulturalMGSkinTones == true and not pPlayer:IsMinorCiv() then
			iColor = GameInfo.Civilizations[pPlayer:GetCivilizationType()].DefaultMagicalGirlColor
			print("MG's skin tone chosen by civilization type")
		end
		
		if iColor < 0 then
			local iNumColors = GameInfo.MG_IconBodies[iBodyType].NumColors
			if iNumColors > 0 then
				iColor = Game.Rand(iNumColors, "MG Body Color Roll")
			else
				iColor = 0
			end
		end
		MagicalGirls[iKey].BodyIcon = {GameInfo.MG_IconBodies[iBodyType].IconAtlas, iColor, GameInfo.MG_IconBodies[iBodyType].ID}

		print("Magical Girl #"..iKey.."'s body icon: "..GameInfo.MG_IconBodies[iBodyType].IconAtlas.." index #"..iColor)
	else
		MagicalGirls[iKey].OverrideIcon = MapModData.gPMMMDefaultMGOverrideIcon
		print("Error getting body type for MG, defaulting")
		return
	end

	--Outfit
	local iOutfitType;
	local iNumOutfitTypes = -1
	for row in GameInfo.MG_IconOutfits() do
		iNumOutfitTypes = iNumOutfitTypes + 1
	end
	if iNumOutfitTypes > -1 then
		iOutfitType = Game.Rand(iNumOutfitTypes, "MG Outfit Type Roll")
	end
	if iOutfitType then
		local iColor;
		local iNumColors = GameInfo.MG_IconOutfits[iOutfitType].NumColors
		if iNumColors > 0 then
			iColor = Game.Rand(iNumColors, "MG Outfit Color Roll")
		else
			iColor = 0
		end
		MagicalGirls[iKey].OutfitIcon = {GameInfo.MG_IconOutfits[iOutfitType].IconAtlas, iColor, GameInfo.MG_IconOutfits[iOutfitType].ID}
		print("Magical Girl #"..iKey.."'s outfit icon: "..GameInfo.MG_IconOutfits[iOutfitType].IconAtlas.." index #"..iColor)
	else
		MagicalGirls[iKey].OverrideIcon = MapModData.gPMMMDefaultMGOverrideIcon
		print("Error getting outfit type for MG, defaulting")
		return
	end

	--Face
	local iFaceType;
	local iNumFaceTypes = -1
	for row in GameInfo.MG_IconFaces() do
		iNumFaceTypes = iNumFaceTypes + 1
	end
	if iNumFaceTypes > -1 then
		iFaceType = Game.Rand(iNumFaceTypes, "MG Face Type Roll")
	end
	if iFaceType then
		local iColor;
		local iNumColors = GameInfo.MG_IconFaces[iFaceType].NumColors
		if iNumColors > 0 then
			iColor = Game.Rand(iNumColors, "MG Face Color Roll")
		else
			iColor = 0
		end
		MagicalGirls[iKey].FaceIcon = {GameInfo.MG_IconFaces[iFaceType].IconAtlas, iColor, GameInfo.MG_IconFaces[iFaceType].ID}
		print("Magical Girl #"..iKey.."'s face icon: "..GameInfo.MG_IconFaces[iFaceType].IconAtlas.." index #"..iColor)
	else
		MagicalGirls[iKey].OverrideIcon = MapModData.gPMMMDefaultMGOverrideIcon
		print("Error getting face type for MG, defaulting")
		return
	end

	--Hair
	local iHairType;
	local iNumHairTypes = -1
	for row in GameInfo.MG_IconHairs() do
		iNumHairTypes = iNumHairTypes + 1
	end
	if iNumHairTypes > -1 then
		iHairType = Game.Rand(iNumHairTypes, "MG Hair Type Roll")
	end
	if iHairType then
		local iColor;
		local iNumColors = GameInfo.MG_IconHairs[iHairType].NumColors
		if iNumColors > 0 then
			iColor = Game.Rand(iNumColors, "MG Hair Color Roll")
		else
			iColor = 0
		end
		MagicalGirls[iKey].HairIcon = {GameInfo.MG_IconHairs[iHairType].IconAtlas, iColor, GameInfo.MG_IconHairs[iHairType].ID}
		print("Magical Girl #"..iKey.."'s hair icon: "..GameInfo.MG_IconHairs[iHairType].IconAtlas.." index #"..iColor)
	else
		MagicalGirls[iKey].OverrideIcon = MapModData.gPMMMDefaultMGOverrideIcon
		print("Error getting hair type for MG, defaulting")
		return
	end
	
	--Accessories (10% chance of spawning with one of either type)
	
	local iFAType;
	local iHAType;
	--All accessories of a given type will be grouped together, even if they have different IDs in the database
	local NumFATypes = {}
	local NumHATypes = {}
	for row in GameInfo.MG_IconFaceAccessories() do
		for i = 0, row.NumAccessories - 1, 0 do 
			NumFATypes[#NumFATypes + 1] = {
				["ID"] = row.ID,
				["Color"] = i
			}
		end
	end
	for row in GameInfo.MG_IconHairAccessories() do
		for i = 0, row.NumAccessories - 1, 0 do 
			NumHATypes[#NumHATypes + 1] = {
				["ID"] = row.ID,
				["Color"] = i
			}
		end
	end
	
	if #NumFATypes > 0 and Game.Rand(99, "PMMM Face Accessory Spawn Roll") <= 9 then
		iFAType = Game.Rand(#NumFATypes, "MG Face Accessory Type Roll") + 1
	end
	
	if #NumHATypes > 0 and Game.Rand(99, "PMMM Hair Accessory Spawn Roll") <= 9 then
		iHAType = Game.Rand(#NumHATypes, "MG Hair Accessory Type Roll") + 1
	end
	
	if iFAType then
		local id = NumFATypes[iFAType].ID
		local color = NumFATypes[iFAType].Color
		MagicalGirls[iKey].FaceAccessory = {GameInfo.MG_IconFaceAccessories[id].IconAtlas, color, id}
		print("Magical Girl #"..iKey.."'s face accessory icon: "..GameInfo.MG_IconFaceAccessories[id].IconAtlas.." index #"..color)
	else
		MagicalGirls[iKey].FaceAccessory = {nil, nil, -1}
	end
	
	if iHAType then
		local id = NumHATypes[iHAType].ID
		local color = NumHATypes[iHAType].Color
		MagicalGirls[iKey].HairAccessory = {GameInfo.MG_IconHairAccessories[id].IconAtlas, color, id}
		print("Magical Girl #"..iKey.."'s hair accessory icon: "..GameInfo.MG_IconHairAccessories[id].IconAtlas.." index #"..color)
	else
		MagicalGirls[iKey].HairAccessory = {nil, nil, -1}
	end
end




function SoulGemCriticalNotification(iPlayer)
	if iPlayer < iMaxCivs then
		local pPlayer = Players[iPlayer]
		if pPlayer:IsHuman() then
			for k, v in pairs(MagicalGirls) do
				if v.SoulGemState == GameInfoTypes.PMMM_SGSTATE_CRITICAL and v.Owner == iPlayer and v.Status == GameInfoTypes.MGACTIONSTATE_ACTIVE then
					local _, pUnit = RetrieveMGPointers(k)
					if pUnit then
						local sText = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_SOUL_GEM_CRITICAL_TEXT", Locale.ConvertTextKey(v.Name))
						local sTitle = Locale.ConvertTextKey("TXT_KEY_PMMM_NOTIFICATION_SOUL_GEM_CRITICAL_TITLE", Locale.ConvertTextKey(v.Name))
						pPlayer:AddNotification(NotificationTypes.NOTIFICATION_GENERIC, sText, sTitle, pUnit:GetX(), pUnit:GetY())
					end
				end
			end
		end
	end
end
