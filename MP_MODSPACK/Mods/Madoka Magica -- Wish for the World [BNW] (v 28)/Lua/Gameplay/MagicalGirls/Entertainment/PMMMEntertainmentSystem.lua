-- WFTW Entertainment System (or WES)
-- If it doesn't work, just blow into it
-- Author: Vice
-- DateCreated: 1/26/2015 5:56:18 PM
--------------------------------------------------------------

include( "IconSupport" );

----------------------------------------------------------------------------------------------------------------------------
--LOCAL TABLES
--Cache every type of building needed here for speed.
----------------------------------------------------------------------------------------------------------------------------

--All buildings which boost Entertainment
local tEntertainmentYieldBuildings = {}
local tEntertainmentModifierBuildings = {}
local tEntertainmentCitizenModifierBuildings = {}

--Note: these are specified for Wonders, so it will use Player:HasWonder() to check
local tEntertainmentSpecialistModifierBuildings = {}
local tEntertainmentConnectionModifierBuildings = {}


--Specialists which provide Entertainment
local tSpecialists = {}



--For Canbuilds
local tNeedsLakeBuildings = {}
local tMaxLandmassBuildings = {}

for row in GameInfo.Buildings() do
	if row.PMMMEntertainment ~= 0 then
		tEntertainmentYieldBuildings[row.ID] = row.PMMMEntertainment
	end
	if row.PMMMEntertainmentModifier ~= 0 then
		tEntertainmentModifierBuildings[row.ID] = row.PMMMEntertainmentModifier
	end
	if row.PMMMEntertainmentCitizenModifier ~= 0 then
		tEntertainmentCitizenModifierBuildings[row.ID] = row.PMMMEntertainmentCitizenModifier
	end
	if row.PMMMEntertainmentSpecialistModifier ~= 0 then
		tEntertainmentSpecialistModifierBuildings[row.ID] = row.PMMMEntertainmentSpecialistModifier
	end
	if row.PMMMEntertainmentConnectionModifier ~= 0 then
		tEntertainmentConnectionModifierBuildings[row.ID] = row.PMMMEntertainmentConnectionModifier
	end
	if row.PMMMRequiresAdjacentLake == 1 or row.PMMMRequiresAdjacentLake == true then
		tNeedsLakeBuildings[row.ID] = true
	end
	if row.PMMMMaxLandAreaSize > 0 then
		tMaxLandmassBuildings[row.ID] = row.PMMMMaxLandAreaSize
	end
end


for row in GameInfo.Specialists() do
	if row.PMMMEntertainment > 0 then
		tSpecialists[row.ID] = row.PMMMEntertainment
	end
end

----------------------------------------------------------------------------------------------------------------------------
--CANBUILDS
--For the Marina and the Island Resort, which both have build requirements not in the DLL.
----------------------------------------------------------------------------------------------------------------------------




function OnCityCanConstructLakeBuildings(iPlayer, iCity, iBuildingType)
	if tNeedsLakeBuildings[iBuildingType] then
		local pPlayer = Players[iPlayer]
		local pCity = pPlayer:GetCityByID(iCity)
		for pPlot in PlotAreaSpiralIterator(pCity:Plot(), 1) do
			if pPlot:IsLake() then
				return true
			end
		end
		return false
	end
	return true
end

function OnCityCanConstructLandmassBuildings(iPlayer, iCity, iBuildingType)
	if tMaxLandmassBuildings[iBuildingType] then
		local pPlayer = Players[iPlayer]
		local area = Map.GetArea(pPlayer:GetCityByID(iCity):Plot():GetArea())
		if area and area:GetNumTiles() <= tMaxLandmassBuildings[iBuildingType] then
			return true
		end
		return false
	end
	return true
end



----------------------------------------------------------------------------------------------------------------------------
--DATA GATHERING FUNCTIONS
----------------------------------------------------------------------------------------------------------------------------

function GetEmpireEntertainment(pPlayer)
	local iTotalEntertainment = 0
	for pCity in pPlayer:Cities() do
		iTotalEntertainment = iTotalEntertainment + (GetCityEntertainment(pCity))
	end
	return iTotalEntertainment
end

function GetNumVacationingMagicalGirls(pPlayer)
	local iPlayer = pPlayer:GetID()
	local iVacationers = 0
	for k, v in pairs(MapModData.PMMM.MagicalGirls) do
		if v.CurrentVacationLocation and v.CurrentVacationLocation == iPlayer then
			iVacationers = iVacationers + 1
		end 
	end
	return iVacationers
end

function GetCityEntertainment(pCity)
	--Flat Yield Buildings
	local iFlatYield = GetCityEntertainmentFromFlatYieldBuildings(pCity)

	--Specialists
	local iSpecialists = GetCityEntertainmentFromSpecialists(pCity)

	--Per-Citizen Buildings
	local iPerCitizen =  GetCityEntertainmentFromPerCitizenBuildings(pCity)

	--Per-Connection Buildings
	local iPerConnection = GetCityEntertainmentFromPerConnectionBuildings(pCity)

	--Modifier
	local iModifier =  GetCityEntertainmentModifierFromBuildings(pCity) / 100 + 1

	local iTotalEntertainment = math.floor((iFlatYield + iSpecialists + iPerCitizen + iPerConnection) * iModifier)

	return iTotalEntertainment, iFlatYield, iSpecialists, iPerCitizen, iPerConnection, iModifier
end


function GetCityEntertainmentFromFlatYieldBuildings(pCity)
	local iTotal = 0
	for iBuilding, iEntertainment in pairs(tEntertainmentYieldBuildings) do
		 if pCity:IsHasBuilding(iBuilding) then
			iTotal = iTotal + iEntertainment
		 end
	end
	return iTotal
end

function GetCityEntertainmentFromSpecialists(pCity)
	local iTotal = 0
	local iBonus = 0
	local pPlayer = Players[pCity:GetOwner()]
	--first determine Bonus from buildings
	for iBuilding, iEntertainment in pairs(tEntertainmentSpecialistModifierBuildings) do
		if pPlayer:HasWonder(iBuilding) then
			iBonus = iBonus + iEntertainment
		end
	end

	--Now determine the number of specialists
	for iSpecialist, iEntertainment in pairs(tSpecialists) do
		iTotal = iTotal + (pCity:GetSpecialistCount(iSpecialist) * (iEntertainment + iBonus))
	end
	return iTotal
end

function GetCityEntertainmentFromPerCitizenBuildings(pCity)
	local iTotal = 0
	local iNumCitizens = pCity:GetPopulation()
	for iBuilding, iEntertainment in pairs(tEntertainmentCitizenModifierBuildings) do
		 if pCity:IsHasBuilding(iBuilding) then
			iTotal = iTotal + math.floor(iNumCitizens * (iEntertainment / 100))
		 end
	end
	return iTotal
end

function GetCityEntertainmentFromPerConnectionBuildings(pCity)
	local iTotal = 0
	local pPlayer = Players[pCity:GetOwner()]
	if pCity:IsCapital() or pPlayer:IsCapitalConnectedToCity(pCity) then
		for iBuilding, iEntertainment in pairs(tEntertainmentConnectionModifierBuildings) do
			 if pPlayer:HasWonder(iBuilding) then
				iTotal = iTotal + iEntertainment
			 end
		end
	end
	return iTotal
end

function GetCityEntertainmentModifierFromBuildings(pCity)
	local iTotal = 0
	for iBuilding, iEntertainment in pairs(tEntertainmentModifierBuildings) do
		 if pCity:IsHasBuilding(iBuilding) then
			iTotal = iTotal + iEntertainment
		 end
	end
	return iTotal
end


function GetCityEntertainmentTooltip(iTotalEntertainment, iFlatYield, iSpecialists, iPerCitizen, iPerConnection, iModifier)
	local iTotalMoodPerEnt = GameInfo.MG_MoodModifiers["MGMOODMOD_VACATION"].Value
	local sTooltip = Locale.ConvertTextKey("TXT_KEY_PMMM_CITYVIEW_ENTERTAINMENT_TOOLTIP", iTotalEntertainment, iTotalMoodPerEnt)
	local bLined = false
	local function SetFirstLine()
		if bLined == false then
			sTooltip = sTooltip.."[NEWLINE]--------------------------------------------[NEWLINE][NEWLINE]"
			bLined = true
		end
	end
	if iFlatYield and iFlatYield ~= 0 then
		SetFirstLine()
		sTooltip = sTooltip..Locale.ConvertTextKey("TXT_KEY_PMMM_CITYVIEW_ENTERTAINMENT_TOOLTIP_FLAT", iFlatYield)
	end
	if iSpecialists and iSpecialists ~= 0 then
		SetFirstLine()
		sTooltip = sTooltip..Locale.ConvertTextKey("TXT_KEY_PMMM_CITYVIEW_ENTERTAINMENT_TOOLTIP_SPECIALISTS", iSpecialists)
	end
	if iPerCitizen and iPerCitizen ~= 0 then
		SetFirstLine()
		sTooltip = sTooltip..Locale.ConvertTextKey("TXT_KEY_PMMM_CITYVIEW_ENTERTAINMENT_TOOLTIP_CITIZENS", iPerCitizen)
	end
	if iPerConnection and iPerConnection ~= 0 then
		SetFirstLine()
		sTooltip = sTooltip..Locale.ConvertTextKey("TXT_KEY_PMMM_CITYVIEW_ENTERTAINMENT_TOOLTIP_CONNECTIONS", iPerConnection)
	end
	if iModifier and iModifier ~= 0 then
		SetFirstLine()
		iModifier = iModifier - 1
		iModifier = iModifier * 100
		if iModifier ~= 0 then
			sTooltip = sTooltip..Locale.ConvertTextKey("TXT_KEY_PMMM_CITYVIEW_ENTERTAINMENT_TOOLTIP_MODIFIER", iModifier)
		end
	end

	return sTooltip
end



--[[	***************************************************************************************************************************
													MODULAR CITY INFO STACK
		***************************************************************************************************************************	]]
		
		
function EntertainmentCityInfoStackDataRefresh(tCityInfoAddins, tEventsToHook)
	table.insert(tCityInfoAddins, {["Key"] = "PMMM_Entertainment", ["SortOrder"] = 3})
	table.insert(tEventsToHook, Events.SerialEventCityInfoDirty)
end

function EntertainmentCityInfoStackDirty(sKey, pInstance)
	if sKey ~= "PMMM_Entertainment" then return end
	local pPlayer = Players[Game:GetActivePlayer()]
	local pCity = UI.GetHeadSelectedCity()
	if pCity then
		local iTotalEntertainment, iFlatYield, iSpecialists, iPerCitizen, iPerConnection, iModifier = GetCityEntertainment(pCity)
		IconHookup(0, 64, "SPECIALIST_ATLAS_PMMM", pInstance.IconImage)
		pInstance.IconImage:SetToolTipString(GetCityEntertainmentTooltip(iTotalEntertainment, iFlatYield, iSpecialists, iPerCitizen, iPerConnection, iModifier))
	end
end