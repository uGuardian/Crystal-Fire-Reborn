-- PMMMUBBootstrapper
-- Author: Vicevirtuoso
-- DateCreated: 6/12/2014 2:55:53 PM
--------------------------------------------------------------

--This file loads Unique Building scripts, but ONLY if a Civ with the building in question is in the game.
--UBs from other Civs was proven to be really unworkable, so we can safely assume that other Civs won't be using these UBs, unlike UUs or UIs.



local bIsSayaka;
local bIsMami;
local bIsKyouko;
local bIsNagisa;
local bIsUMadoka;
local bIsPleiades;

for iPlayer, pTrait in pairs(MapModData.gPMMMUniqueBuildings) do
	if not bIsSayaka then
		if MapModData.gPMMMUniqueBuildings[iPlayer] == GameInfoTypes.BUILDING_PMMM_STAGE_OF_OKTAVIA then
			print("Loading Sayaka's building script.")
			include('PMMMSayakaBuilding.lua');
			bIsSayaka = true;
		end
	end
	if not bIsMami then
		if MapModData.gPMMMUniqueBuildings[iPlayer] == GameInfoTypes.BUILDING_PMMM_TEAHOUSE then
			print("Loading Mami's building script.")
			include('PMMMMamiBuilding.lua');
			bIsMami = true;
		end
	end
	if not bIsKyouko then
		if MapModData.gPMMMUniqueBuildings[iPlayer] == GameInfoTypes.BUILDING_PMMM_SAKURA_CHURCH then
			print("Loading Kyouko's building script.")
			include('PMMMKyoukoBuilding.lua');
			bIsKyouko = true;
		end
	end
	if not bIsNagisa then
		if MapModData.gPMMMUniqueBuildings[iPlayer] == GameInfoTypes.BUILDING_PMMM_MAGICAL_DAIRY then
			print("Loading Nagisa's building script.")
			include('PMMMNagisaBuilding.lua');
			bIsNagisa = true;
		end
	end
	if not bIsUMadoka then
		if MapModData.gPMMMUniqueBuildings[iPlayer] == GameInfoTypes.BUILDING_PMMM_LUMINOUS_GARDEN then
			print("Loading Ultimate Madoka's building script.")
			include('PMMMUltimateMadokaBuilding.lua');
			bIsUMadoka = true;
		end
	end
end

function RunUBScripts(iPlayer)
	if iPlayer < iMaxCivs then
		if bIsKyouko then
			CheckSakuraChurch(iPlayer)
		end
		if bIsMami then
			CheckMamiFriendship(iPlayer)
		end
		if bIsSayaka then
			OktaviaGreatWorkHeal(iPlayer)
		end
		if bIsNagisa then
			NagisaCitiesBonusTrade(iPlayer)
		end
		if bIsUMadoka then
			LuminousRecoverSoulGem(iPlayer)
		end
	end
end