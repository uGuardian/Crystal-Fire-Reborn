-- VV_NoireMCIS
-- Author: Vice
--A tooltip handler for sukritact's MCIS support, so the player can get information about Noire's UA bonuses.
--------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------
-- DEFINES
----------------------------------------------------------------------------------------------------------------------------
include("IconSupport");

g_NoireTipControls = {}
TTManager:GetTypeControlTable("NoireUATooltip", g_NoireTipControls)

local iMaxCivsMinusOne = GameDefines.MAX_MAJOR_CIVS -1 

--Civ Identifiers
local iNoire = GameInfoTypes.LEADER_VV_NOIRE
local iBlackHeart = GameInfoTypes.LEADER_VV_BLACK_HEART
local iNoireU = GameInfoTypes.LEADER_VV_NOIRE_ULTRA
local iBlackHeartU = GameInfoTypes.LEADER_VV_BLACK_HEART_ULTRA

local tHDNoires = {
	[iNoire] = true,
	[iBlackHeart] = true
}

local tUDNoires = {
	[iNoireU] = true,
	[iBlackHeartU] = true
}

--Building Constants
local NOIRE_PRODBONUS = GameInfoTypes.BUILDING_VV_LASTATION_PRODUCTION_DUMMY
local NOIRE_SCIBONUS = GameInfoTypes.BUILDING_VV_LASTATION_SCIENCE_DUMMY
local NOIRE_NOFRIENDS = GameInfoTypes.BUILDING_VV_LASTATION_NOFRIEND_BONUS
local NOIRE_PRODBONUS_U = GameInfoTypes.BUILDING_VV_LASTATION_PRODUCTION_DUMMY_U
local NOIRE_SCIBONUS_U = GameInfoTypes.BUILDING_VV_LASTATION_SCIENCE_DUMMY_U
local NOIRE_NOFRIENDS_U = GameInfoTypes.BUILDING_VV_LASTATION_NOFRIEND_BONUS_U


----------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
----------------------------------------------------------------------------------------------------------------------------
function NoireCityInfoStackDataRefresh(tCityInfoAddins, tEventsToHook)
	table.insert(tCityInfoAddins, {["Key"] = "HDN_Noire", ["SortOrder"] = 1})
end

LuaEvents.CityInfoStackDataRefresh.Add(NoireCityInfoStackDataRefresh)
LuaEvents.RequestCityInfoStackDataRefresh()

function NoireCityInfoStackDirty(sKey, pInstance)
	if sKey ~= "HDN_Noire" then return end
	local pCity = UI.GetHeadSelectedCity()
	if pCity then
		local iPlayer = pCity:GetOwner()
		if iPlayer == Game:GetActivePlayer() then
			local pPlayer = Players[iPlayer]
			local pCapital = pPlayer:GetCapitalCity()
			local bDisplay = false
			local sString = "[NEWLINE][NEWLINE]------------------------------------------[NEWLINE]"
			if pCapital then
				local iLeaderType = pPlayer:GetLeaderType()
				--First put Noire's bonuses from herself and her friends
				--Noire can actually have entries from this part AND from the "generic" half, if one Noire is friends with another
				if tHDNoires[iLeaderType] then
					local iProdBuildings = pCapital:GetNumRealBuilding(NOIRE_PRODBONUS)
					if iProdBuildings > 0 then
						bDisplay = true
						local iProd = GameInfo.Buildings[NOIRE_PRODBONUS].MilitaryProductionModifier
						sString = sString.."[NEWLINE][ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_NOIRE_MCIS_NOIRE_PRODUCTION", iProdBuildings * iProd)
					end

					iSciBuildings = pCapital:GetNumRealBuilding(NOIRE_SCIBONUS)
					if iSciBuildings > 0 then
						bDisplay = true
						local iSci;
						for row in GameInfo.Building_GlobalYieldModifiers("BuildingType = 'BUILDING_VV_LASTATION_SCIENCE_DUMMY'") do
							iSci = row.Yield
							break
						end
						sString = sString.."[NEWLINE][ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_NOIRE_MCIS_NOIRE_SCIENCE", iSciBuildings * iSci)
					else
						local pTeam = Teams[pPlayer:GetTeam()]
						local bMetEveryone = true
						for i = 0, iMaxCivsMinusOne, 1 do
							local pLoop = Players[i]
							if pLoop:IsAlive() and (pTeam:IsHasMet(pLoop:GetTeam()) == false or pTeam:IsAtWar(pLoop:GetTeam()) == true) then
								bMetEveryone = false
								break
							end
						end
						if bMetEveryone == true then
							bDisplay = true
							local iUnhappiness = GameInfo.Buildings[NOIRE_NOFRIENDS].UnhappinessModifier
							local iProd;
							for row in GameInfo.Building_GlobalYieldModifiers("BuildingType = 'BUILDING_VV_LASTATION_NOFRIEND_BONUS'") do
								iProd = row.Yield
								break
							end
							sString = sString.."[NEWLINE][ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_NOIRE_MCIS_NOIRE_NOFRIENDS", iProd, iUnhappiness)
						end
					end
				elseif tUDNoires[iLeaderType] then
					local iProdBuildings = pCapital:GetNumRealBuilding(NOIRE_PRODBONUS_U)
					if iProdBuildings > 0 then
						bDisplay = true
						local iProd = GameInfo.Buildings[NOIRE_PRODBONUS_U].BuildingProductionModifier
						sString = sString.."[NEWLINE][ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_NOIRE_MCIS_NOIRE_PRODUCTION", iProdBuildings * iProd)
					end

					iSciBuildings = pCapital:GetNumRealBuilding(NOIRE_SCIBONUS_U)
					if iSciBuildings > 0 then
						bDisplay = true
						local iSci;
						for row in GameInfo.Building_GlobalYieldModifiers("BuildingType = 'BUILDING_VV_LASTATION_SCIENCE_DUMMY_U'") do
							iSci = row.Yield
							break
						end
						sString = sString.."[NEWLINE][ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_NOIRE_MCIS_NOIRE_SCIENCE", iSciBuildings * iSci)
					else
						local pTeam = Teams[pPlayer:GetTeam()]
						local bMetEveryone = true
						for i = 0, iMaxCivsMinusOne, 1 do
							local pLoop = Players[i]
							if pLoop:IsAlive() and (pTeam:IsHasMet(pLoop:GetTeam()) == false or pTeam:IsAtWar(pLoop:GetTeam()) == true) then
								bMetEveryone = false
								break
							end
						end
						if bMetEveryone == true then
							bDisplay = true
							local iUnhappiness = GameInfo.Buildings[NOIRE_NOFRIENDS_U].UnhappinessModifier
							local iProd;
							for row in GameInfo.Building_GlobalYieldModifiers("BuildingType = 'BUILDING_VV_LASTATION_NOFRIEND_BONUS_U'") do
								iProd = row.Yield
								break
							end
							sString = sString.."[NEWLINE][ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_NOIRE_MCIS_NOIRE_NOFRIENDS", iProd, iUnhappiness)
						end
					end
				end
				--Generic: for showing Noire's friends what they're getting from her
				local bShowHD = (tHDNoires[iLeaderType] ~= true) and true or false
				local bShowUD =(tUDNoires[iLeaderType] ~= true) and true or false
				if bShowHD == true then
					local iProdBuildings = pCapital:GetNumRealBuilding(NOIRE_PRODBONUS)
					if iProdBuildings > 0 then
						bDisplay = true
						local iSP = -GameInfo.Buildings[NOIRE_PRODBONUS].PolicyCostModifier
						local iProd;
						for row in GameInfo.Building_GlobalYieldModifiers("BuildingType = 'BUILDING_VV_LASTATION_PRODUCTION_DUMMY'") do
							iProd = row.Yield
							break
						end
						sString = sString.."[NEWLINE][ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_NOIRE_MCIS_FRIEND_PRODUCTION", iProdBuildings * iProd, iProdBuildings * iSP)
					end
				end

				if bShowUD == true then
					local iProdBuildings = pCapital:GetNumRealBuilding(NOIRE_PRODBONUS_U)
					if iProdBuildings > 0 then
						bDisplay = true
						local iSP = -GameInfo.Buildings[NOIRE_PRODBONUS_U].PolicyCostModifier
						local iProd;
						for row in GameInfo.Building_GlobalYieldModifiers("BuildingType = 'BUILDING_VV_LASTATION_PRODUCTION_DUMMY_U'") do
							iProd = row.Yield
							break
						end
						sString = sString.."[NEWLINE][ICON_BULLET]"..Locale.ConvertTextKey("TXT_KEY_NOIRE_MCIS_FRIEND_PRODUCTION_U", iProdBuildings * iProd, iProdBuildings * iSP)
					end
				end

				if bDisplay == true then
					--Small icon in the CityView itself
					if tUDNoires[iLeaderType] then
						IconHookup(0, 64, "CIV_COLOR_ATLAS_VV_LASTATION_ULTRA", pInstance.IconImage)
					else
						IconHookup(0, 64, "CIV_COLOR_ATLAS_VV_LASTATION", pInstance.IconImage)
					end

					--Now we build the tooltip for the icon
					pInstance.IconFrame:SetToolTipType("NoireUATooltip")
					g_NoireTipControls.Body:SetText(sString)
					g_NoireTipControls.Box:DoAutoSize()
					pInstance.IconFrame:SetHide(false)
				else
					pInstance.IconFrame:SetHide(true)
				end

			else
				pInstance.IconFrame:SetHide(true)
			end
		else
			pInstance.IconFrame:SetHide(true)
		end
	end
end

LuaEvents.CityInfoStackDirty.Add(NoireCityInfoStackDirty)
----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------