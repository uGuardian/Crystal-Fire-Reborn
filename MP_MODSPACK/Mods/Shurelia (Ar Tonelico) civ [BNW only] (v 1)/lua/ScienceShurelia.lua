-- SciencePoints
-- Author: EricNgui
-- DateCreated: 11/11/2014 5:35:03 PM
--------------------------------------------------------------

print ("loaded")
include( "SaveUtils.lua" );MY_MOD_NAME = "SciencePoints";

local iPromotion = GameInfoTypes.PROMOTION_SCIENCE_POINTS
local iScientist = GameInfoTypes.SPECIALIST_SCIENTIST

function SciencePoints(iPlayer)
	local pPlayer = Players[iPlayer]
	
	--Define Target City for GP Adjustment
	local pTargetCity = GetTargetCity(pPlayer)
	local iMod = 100
	if pTargetCity ~= nil then
		iMod = iMod + (GetGreatPersonModifier(pPlayer, pTargetCity, iScientist))
	end
	
	for pUnit in pPlayer:Units() do
		if pUnit:IsHasPromotion(iPromotion) then
			
			--Movement Transfer
			local iMovement = pUnit:GetMoves()
			local pPlot = pUnit:GetPlot()
			local iNumUnits = pPlot:GetNumUnits()
			for iVal = 0,(iNumUnits - 1) do
				local pUnit = pPlot:GetUnit(iVal)
				if (pUnit:IsEmbarked()) and (pUnit:GetMoves() < iMovement) then
					pUnit:SetMoves(iMovement)
				end
			end
			
			--GP Point Adjustment
			if pTargetCity ~= nil then
				local iUnit = pUnit:GetID()
				local iOldXP = load(pPlayer, iUnit)
				local iXP = pUnit:GetExperience()
				save(pPlayer, iUnit, iXP)
				if iOldXP ~= nil then
					local iDelta = (iXP - iOldXP)*iMod
					if iDelta > 0 then
						pTargetCity:ChangeSpecialistGreatPersonProgressTimes100(iScientist, iDelta)
					end
				end
			end
		end
	end
end
GameEvents.PlayerDoTurn.Add(SciencePoints)

function UnitDestroyed(iPlayer, iUnit)
	local pPlayer = Players[iPlayer]
	local pUnit = pPlayer:GetUnitByID(iUnit)
	if pUnit == nil then
		save(pPlayer, iUnit, nil)
	end
end
Events.SerialEventUnitDestroyed.Add(UnitDestroyed)

function GetTargetCity(pPlayer)
	local pTargetCity = pPlayer:GetCapitalCity()
	if pTargetCity == nil then
		return
	end
	local iTargetProgress = pTargetCity:GetSpecialistGreatPersonProgress(iScientist)
	for pCity in pPlayer:Cities() do
		local iProgress = pCity:GetSpecialistGreatPersonProgress(iScientist)
		if iProgress > iTargetProgress then
			pTargetCity = pCity
			iTargetProgress = iProgress
		end
	end
	return pTargetCity
end

----------------------------------------------------------------        
-- The following is adapted from the CityView.lua
----------------------------------------------------------------    

function GetGreatPersonModifier(pPlayer, pTargetCity, iType)
	-- Generic GP mods
	local iPlayerMod = pPlayer:GetGreatPeopleRateModifier()
	local iPolicyMod = pPlayer:GetPolicyGreatPeopleRateModifier()
	local iWorldCongressMod = 0
	local pWorldCongress = nil
	if (Game.GetNumActiveLeagues() > 0) then
		pWorldCongress = Game.GetActiveLeague()
	end
	local iCityMod = pTargetCity:GetGreatPeopleRateModifier()
	local iGoldenAgeMod = 0
	local bGoldenAge = (pPlayer:GetGoldenAgeTurns() > 0)
	
	-- GP mods by type	
	if (iType == GameInfo.Specialists.SPECIALIST_WRITER.ID) then
		--print("is " .. GameInfo.Specialists[iType].Description)
		iPlayerMod = iPlayerMod + pPlayer:GetGreatWriterRateModifier()
		iPolicyMod = iPolicyMod + pPlayer:GetPolicyGreatWriterRateModifier()
		if (pWorldCongress ~= nil and pWorldCongress:GetArtsyGreatPersonRateModifier() ~= 0) then
		iWorldCongressMod = iWorldCongressMod + pWorldCongress:GetArtsyGreatPersonRateModifier()
		end
		if (bGoldenAge and pPlayer:GetGoldenAgeGreatWriterRateModifier() > 0) then
		iGoldenAgeMod = iGoldenAgeMod + pPlayer:GetGoldenAgeGreatWriterRateModifier()
		end
	elseif (iType == GameInfo.Specialists.SPECIALIST_ARTIST.ID) then
		--print("is " .. GameInfo.Specialists[iType].Description)
		iPlayerMod = iPlayerMod + pPlayer:GetGreatArtistRateModifier()
		iPolicyMod = iPolicyMod + pPlayer:GetPolicyGreatArtistRateModifier()
		if (pWorldCongress ~= nil and pWorldCongress:GetArtsyGreatPersonRateModifier() ~= 0) then
		iWorldCongressMod = iWorldCongressMod + pWorldCongress:GetArtsyGreatPersonRateModifier()
		end
		if (bGoldenAge and pPlayer:GetGoldenAgeGreatArtistRateModifier() > 0) then
		iGoldenAgeMod = iGoldenAgeMod + pPlayer:GetGoldenAgeGreatArtistRateModifier()
		end
	elseif (iType == GameInfo.Specialists.SPECIALIST_MUSICIAN.ID) then
		--print("is " .. GameInfo.Specialists[iType].Description)
		iPlayerMod = iPlayerMod + pPlayer:GetGreatMusicianRateModifier()
		iPolicyMod = iPolicyMod + pPlayer:GetPolicyGreatMusicianRateModifier()
		if (pWorldCongress ~= nil and pWorldCongress:GetArtsyGreatPersonRateModifier() ~= 0) then
		iWorldCongressMod = iWorldCongressMod + pWorldCongress:GetArtsyGreatPersonRateModifier()
		end
		if (bGoldenAge and pPlayer:GetGoldenAgeGreatMusicianRateModifier() > 0) then
		iGoldenAgeMod = iGoldenAgeMod + pPlayer:GetGoldenAgeGreatMusicianRateModifier()
		end
	elseif (iType == GameInfo.Specialists.SPECIALIST_SCIENTIST.ID) then
		--print("is " .. GameInfo.Specialists[iType].Description)
		iPlayerMod = iPlayerMod + pPlayer:GetGreatScientistRateModifier()
		iPolicyMod = iPolicyMod + pPlayer:GetPolicyGreatScientistRateModifier()
		if (pWorldCongress ~= nil and pWorldCongress:GetScienceyGreatPersonRateModifier() ~= 0) then
		iWorldCongressMod = iWorldCongressMod + pWorldCongress:GetScienceyGreatPersonRateModifier()
		end
	elseif (iType == GameInfo.Specialists.SPECIALIST_MERCHANT.ID) then
		--print("is " .. GameInfo.Specialists[iType].Description)
		iPlayerMod = iPlayerMod + pPlayer:GetGreatMerchantRateModifier()
		iPolicyMod = iPolicyMod + pPlayer:GetPolicyGreatMerchantRateModifier()
		if (pWorldCongress ~= nil and pWorldCongress:GetScienceyGreatPersonRateModifier() ~= 0) then
		iWorldCongressMod = iWorldCongressMod + pWorldCongress:GetScienceyGreatPersonRateModifier()
		end
	elseif (iType == GameInfo.Specialists.SPECIALIST_ENGINEER.ID) then
		--print("is " .. GameInfo.Specialists[iType].Description)
		iPlayerMod = iPlayerMod + pPlayer:GetGreatEngineerRateModifier()
		iPolicyMod = iPolicyMod + pPlayer:GetPolicyGreatEngineerRateModifier()
		if (pWorldCongress ~= nil and pWorldCongress:GetScienceyGreatPersonRateModifier() ~= 0) then
		iWorldCongressMod = iWorldCongressMod + pWorldCongress:GetScienceyGreatPersonRateModifier()
		end
	end
			
	-- Player mod actually includes policy mod and World Congress mod, so separate them for tooltip
	iPlayerMod = iPlayerMod - iPolicyMod - iWorldCongressMod		
	--print(iPlayerMod, iPolicyMod, iWorldCongressMod, iCityMod, iGoldenAgeMod)
	local iMod = iPlayerMod + iPolicyMod + iWorldCongressMod + iCityMod + iGoldenAgeMod
	--print(iMod)
	return iMod
end