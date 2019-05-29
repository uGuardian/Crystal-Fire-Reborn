-- CIATraitScript
-- Author: Vice
-- DateCreated: 3/30/2015 11:36:36 AM
--------------------------------------------------------------

print("Crashing this script...WITH NO SURVIVORS!")

local iMaxCivs = GameDefines.MAX_MAJOR_CIVS
local iHothead = GameInfoTypes.PROMOTION_VV_HOTHEAD
local iHotheadDummy = GameInfoTypes.BUILDING_VV_HOTHEAD_DUMMY_BUILDING
local iAgentSea = GameInfoTypes.BUILDING_VV_CIA_AGENT_SEA


--I don't think any leader's roman numerals go past 20, so
local tRomanNumerals = {
	["I"] = true,
	["II"] = true,
	["III"] = true,
	["IV"] = true,
	["V"] = true,
	["VI"] = true,
	["VII"] = true,
	["VIII"] = true,
	["IX"] = true,
	["X"] = true,
	["XI"] = true,
	["XII"] = true,
	["XIII"] = true,
	["XIV"] = true,
	["XV"] = true,
	["XVI"] = true,
	["XVII"] = true,
	["XVIII"] = true,
	["XIX"] = true,
	["XX"] = true
}


function DrLeaderImCIA()
	local sLeaderName = Locale.ConvertTextKey(GameInfo.Leaders[Players[Game:GetActivePlayer()]:GetLeaderType()].Description)
	for k, v in pairs(tRomanNumerals) do
		if string.find(sLeaderName, k) then
			sLeaderName = string.gsub(sLeaderName, " "..k, "")
		end
	end
	if string.find(sLeaderName, '%s') then
		local sReverse = string.reverse(sLeaderName)
		local iPos = string.find(sReverse, '%s')
		sReverse = string.sub(sReverse, 0, iPos)
		sLeaderName = string.reverse(sReverse)
	end	
	local sNewString = Locale.ConvertTextKey("TXT_KEY_LEADER_VV_BILL_WILSON_LUA_GREETING", sLeaderName)
	sNewString = "\""..sNewString.."\""
	for _ in DB.Query("UPDATE Language_en_US SET Text = " ..sNewString .." WHERE Tag='TXT_KEY_LEADER_VV_BILL_WILSON_FIRSTGREETING_1'") do print("Successfully changed leader greeting text.") end
	Locale.SetCurrentLanguage( Locale.GetCurrentLanguage().Type )
end

Events.SequenceGameInitComplete.Add(DrLeaderImCIA);



function GetHotheadsOuttaHere(iPlayer)
	if iPlayer < iMaxCivs then
		local pPlayer = Players[iPlayer]
		local tHotheads = {}
		for pUnit in pPlayer:Units() do
			if pUnit:IsHasPromotion(iHothead) then
				tHotheads[#tHotheads + 1] = pUnit
			end
		end
		local pCapital = pPlayer:GetCapitalCity()
		if pCapital then
			pCapital:SetNumRealBuilding(iHotheadDummy, #tHotheads)
			local sText = Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_HOTHEAD_TEXT")
			local sTitle = Locale.ConvertTextKey("TXT_KEY_NOTIFICATION_HOTHEAD_TITLE")
			local bAnyHotheadsOuttaHere = false
			while pPlayer:GetExcessHappiness() < 0 and #tHotheads > 0 do
				pPlayer:AddNotification(NotificationTypes.NOTIFICATION_UNIT_DIED, sText, sTitle, tHotheads[1]:GetX(), tHotheads[1]:GetY(), tHotheads[1]:GetUnitType())
				tHotheads[1]:Kill(true)
				table.remove(tHotheads, 1)
				pCapital:SetNumRealBuilding(iHotheadDummy, #tHotheads)
				bAnyHotheadsOuttaHere = true
			end
			if iPlayer == Game:GetActivePlayer() and bAnyHotheadsOuttaHere == true then
				Events.AudioPlay2DSound("AS2D_DELETE_VV_HOTHEAD")
			end
		end
	end
end


GameEvents.PlayerDoTurn.Add(GetHotheadsOuttaHere)
GameEvents.CityTrained.Add(GetHotheadsOuttaHere)


function GrabYourPrize(iPlayer, iUnit, iPromotion)
	if iPlayer < iMaxCivs then
		local pPlayer = Players[iPlayer]
		local pUnit = pPlayer:GetUnitByID(iUnit)
		if pUnit:GetDomainType() == GameInfoTypes.DOMAIN_AIR then
			local pPlot = pUnit:GetPlot()
			local pCity = pPlot:GetPlotCity()
			if pCity and pCity:IsHasBuilding(iAgentSea) then
				pCity:ChangeSpecialistGreatPersonProgressTimes100(GameInfoTypes.SPECIALIST_SCIENTIST, 200)
			end
		end
	end
end

GameEvents.UnitPromoted.Add(GrabYourPrize)