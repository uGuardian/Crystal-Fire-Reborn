-- VV_PlutiaMCIS
-- Author: Vice
--A tooltip handler for sukritact's MCIS support, so the player can get information about Plutia's Daycare.
--------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------
-- DEFINES
----------------------------------------------------------------------------------------------------------------------------
include("IconSupport");

g_PlutiaTipControls = {}
TTManager:GetTypeControlTable("PlutiaUBTooltip", g_PlutiaTipControls)

local iMaxCivsMinusOne = GameDefines.MAX_MAJOR_CIVS -1 

--Building Constants
local DAYCARE 			= GameInfoTypes.BUILDING_VV_DAYCARE
local DAYCARE_DUMMY 	= GameInfoTypes.BUILDING_VV_DAYCARE_FOOD_DUMMY


----------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
----------------------------------------------------------------------------------------------------------------------------
--Taken from sukritact's Events & Decisions
function CompileCityID(pCity)
	local iOriginalOwner = pCity:GetOriginalOwner()
	local iTurnFounded = pCity:GetGameTurnFounded ()	--Used to Compile Unique City ID
	local iCityID = ("X" .. pCity:GetX() .. "Y" .. pCity:GetY() .. "P" .. iOriginalOwner .. "T" .. iTurnFounded)
	return iCityID
end


function PlutiaCityInfoStackDataRefresh(tCityInfoAddins, tEventsToHook)
	table.insert(tCityInfoAddins, {["Key"] = "HDN_Plutia", ["SortOrder"] = 1})
end

LuaEvents.CityInfoStackDataRefresh.Add(PlutiaCityInfoStackDataRefresh)
LuaEvents.RequestCityInfoStackDataRefresh()

function PlutiaCityInfoStackDirty(sKey, pInstance)
	if sKey ~= "HDN_Plutia" then return end
	local pCity = UI.GetHeadSelectedCity()
	if pCity and pCity:IsHasBuilding(DAYCARE) then
		local iPlayer = pCity:GetOwner()
		if iPlayer == Game:GetActivePlayer() then
			local pPlayer = Players[iPlayer]
			local pCapital = pPlayer:GetCapitalCity()
			local sString = Locale.ConvertTextKey("TXT_KEY_PLUTIA_MCIS_TEXT", pCity:GetNumRealBuilding(DAYCARE_DUMMY))

			local HDNMod = MapModData.HDNMod
			local sCity = CompileCityID(pCity)

			if HDNMod.PlutiaDaycare[sCity] then
				local tBuildings = {}
				--initialize every building found in the tDolls table to 0 buildings.
				for k, v in pairs(MapModData.gPlutiaDollDefs) do
					if v.Playtime and v.Playtime.Building then
						tBuildings[v.Playtime.Building] = 0
					end
				end
				--loop over every entry in HDNMod.PlutiaDaycare (each entry is made for every individual unit of population).
				--Add number of buildings based on the number of buildings each individual doll gives per pop.
				for k, v in pairs(HDNMod.PlutiaDaycare[sCity]) do
					for k2, v2 in pairs(v) do
						local doll = MapModData.gPlutiaDollDefs[v2]
						if doll and doll.Playtime then
							local pt = doll.Playtime
							if tBuildings[pt.Building] then
								tBuildings[pt.Building] = tBuildings[pt.Building] + (1 / pt.Pop)
							end
						end
					end
				end
				for k, v in pairs(tBuildings) do
					local val = math.floor(v)
					if val > 0 then
						sString = sString..Locale.ConvertTextKey(GameInfo.Buildings[k].Help).." x"..val.."[NEWLINE]"
					end
				end
			end

			--Small icon in the CityView itself
			IconHookup(4, 64, "CIV_COLOR_ATLAS_VV_PLANEPTUNE_PL", pInstance.IconImage)

			--Now we build the tooltip for the icon
			pInstance.IconFrame:SetToolTipType("PlutiaUBTooltip")
			g_PlutiaTipControls.Body:SetText(sString)
			g_PlutiaTipControls.Box:DoAutoSize()
			pInstance.IconFrame:SetHide(false)

		else
			pInstance.IconFrame:SetHide(true)
		end
	else
		pInstance.IconFrame:SetHide(true)
	end
end

LuaEvents.CityInfoStackDirty.Add(PlutiaCityInfoStackDirty)
----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------