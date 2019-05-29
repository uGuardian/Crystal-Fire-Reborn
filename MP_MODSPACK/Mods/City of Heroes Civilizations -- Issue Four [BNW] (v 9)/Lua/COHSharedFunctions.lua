-- COHSharedFunctions
-- Author: Vicevirtuoso
-- DateCreated: 4/20/2014 10:42:29 PM
--------------------------------------------------------------

--Firetuner print functions disabled unless bDebug is set to true
bDebug = false

function dprint(...)
  if (bDebug) then
    print(string.format(...))
  end
end


--Cache traits on game load to make UA run faster
tTraits = {}

for i = 0, GameDefines.MAX_MAJOR_CIVS - 1, 1 do
	local pPlayer = Players[i]
	if pPlayer:IsEverAlive() then
		leaderType = GameInfo.Leaders[pPlayer:GetLeaderType()].Type
		traitType = GameInfo.Leader_Traits("LeaderType ='" .. leaderType .. "'")().TraitType
		tTraits[i] = GameInfo.Traits[traitType]
	end
end



--Dynamic City Names

function COHCityNamesDynamic(iPlotX, iPlotY, iOldPop, iNewPop)
	if iOldPop == 0 then
		local pPlot = Map.GetPlot(iPlotX, iPlotY)
		local pCity = pPlot:GetPlotCity()
		local pOwner = Players[pCity:GetOwner()]
		local tCityNames = {}
		if pOwner:GetCivilizationType() == GameInfoTypes.CIVILIZATION_PARAGON then
			--Statesman's dynamics:
			--City 6 is Independence Port if coastal, Independence City if otherwise
			--City 7 is Talos Island if on a landmass with 5 or fewer land tiles, Talos City if otherwise
			--City 10 is Peregrine Island if on a landmass with 5 or fewer land tiles, Peregrine if otherwise
			--City 12 is Striga Isle or Striga (same as previous two)
			--City 18 uses coastal metric for Kallisti Wharf or Kallisti City

			--Must loop through all cities of all players to ensure there aren't duplicate names!
			for iLoop, pLoop in pairs(Players) do
				for pLoopCity in pLoop:Cities() do
					local sKey = pLoopCity:GetNameKey()
					if string.find(sKey, "TXT_KEY_CITY_NAME_PARAGON_") then
						tCityNames[sKey] = true
					end
				end
			end

			--Now we loop through using numbers. We'll want to make sure that every city name in the list prior
			--to the ones in question are used by any combination of Civs in the game. i.e., before using
			--Independence Port/City, city names 1-5 should all be in use already.

			local iCityNameLoop = 1
			while iCityNameLoop < 15 do
				local sKey = "TXT_KEY_CITY_NAME_PARAGON_" ..tostring(iCityNameLoop)
				if tCityNames[sKey] then
					if iCityNameLoop == 6 then
						if not tCityNames["TXT_KEY_CITY_NAME_PARAGON_INDEPENDENCE_PORT_1"] and not tCityNames["TXT_KEY_CITY_NAME_PARAGON_INDEPENDENCE_PORT_2"] then
							if pCity:IsCoastal() then
								pCity:SetName("TXT_KEY_CITY_NAME_PARAGON_INDEPENDENCE_PORT_1")
							else
								pCity:SetName("TXT_KEY_CITY_NAME_PARAGON_INDEPENDENCE_PORT_2")
							end
						elseif not tCityNames["TXT_KEY_CITY_NAME_PARAGON_TALOS_ISLAND_1"] and not tCityNames["TXT_KEY_CITY_NAME_PARAGON_TALOS_ISLAND_1"] then
							local pArea = Map.GetArea(pPlot:GetArea())
							if pArea:GetNumTiles() <= 5 then
								pCity:SetName("TXT_KEY_CITY_NAME_PARAGON_TALOS_ISLAND_1")
							else
								pCity:SetName("TXT_KEY_CITY_NAME_PARAGON_TALOS_ISLAND_2")
							end
						end
					elseif iCityNameLoop == 8 then
						if not tCityNames["TXT_KEY_CITY_NAME_PARAGON_PEREGRINE_ISLAND_1"] and not tCityNames["TXT_KEY_CITY_NAME_PARAGON_PEREGRINE_ISLAND_2"] then
							local pArea = Map.GetArea(pPlot:GetArea())
							if pArea:GetNumTiles() <= 5 then
								pCity:SetName("TXT_KEY_CITY_NAME_PARAGON_PEREGRINE_ISLAND_1")
							else
								pCity:SetName("TXT_KEY_CITY_NAME_PARAGON_PEREGRINE_ISLAND_2")
							end
						end
					elseif iCityNameLoop == 9 then
						if not tCityNames["TXT_KEY_CITY_NAME_PARAGON_STRIGA_ISLE_1"] and not tCityNames["TXT_KEY_CITY_NAME_PARAGON_STRIGA_ISLE_2"] then
							local pArea = Map.GetArea(pPlot:GetArea())
							if pArea:GetNumTiles() <= 5 then
								pCity:SetName("TXT_KEY_CITY_NAME_PARAGON_STRIGA_ISLE_1")
							else
								pCity:SetName("TXT_KEY_CITY_NAME_PARAGON_STRIGA_ISLE_2")
							end
						end
					elseif iCityNameLoop == 14 then
						if not tCityNames["TXT_KEY_CITY_NAME_PARAGON_KALLISTI_1"] and not tCityNames["TXT_KEY_CITY_NAME_PARAGON_KALLISTI_2"] then
							if pCity:IsCoastal() then
								pCity:SetName("TXT_KEY_CITY_NAME_PARAGON_KALLISTI_1")
							else
								pCity:SetName("TXT_KEY_CITY_NAME_PARAGON_KALLISTI_2")
							end
						end
					end
					iCityNameLoop = iCityNameLoop + 1
				else
					break
				end
			end
		elseif pOwner:GetCivilizationType() == GameInfoTypes.CIVILIZATION_ARACHNOS then
			--Recluse's dynamics:
			--City 2 uses above island determination metric to name it either Mercy Island or Mercy
			--City 3 uses coastal metric for Port Oakes or Point Oakes
			--City 5 uses island metric for Sharkhead Isle or Sharkhead Valley
			--City 7 uses coastal metric for Bloody Bay or Bloody Bridge
			--City 15 uses island metric for Monster Island or Monster City

			--Must loop through all cities of all players to ensure there aren't duplicate names!
			for iLoop, pLoop in pairs(Players) do
				for pLoopCity in pLoop:Cities() do
					local sKey = pLoopCity:GetNameKey()
					if string.find(sKey, "TXT_KEY_CITY_NAME_ARACHNOS_") then
						tCityNames[sKey] = true
					end
				end
			end

			local iCityNameLoop = 1
			while iCityNameLoop < 12 do
				local sKey = "TXT_KEY_CITY_NAME_ARACHNOS_" ..tostring(iCityNameLoop)
				if tCityNames[sKey] then
					if iCityNameLoop == 2 then
						if not tCityNames["TXT_KEY_CITY_NAME_ARACHNOS_MERCY_1"] and not tCityNames["TXT_KEY_CITY_NAME_ARACHNOS_MERCY_2"] then
							local pArea = Map.GetArea(pPlot:GetArea())
							if pArea:GetNumTiles() <= 5 then
								pCity:SetName("TXT_KEY_CITY_NAME_ARACHNOS_MERCY_1")
							else
								pCity:SetName("TXT_KEY_CITY_NAME_ARACHNOS_MERCY_2")
							end
						elseif not tCityNames["TXT_KEY_CITY_NAME_ARACHNOS_PORT_OAKES_1"] and not tCityNames["TXT_KEY_CITY_NAME_ARACHNOS_PORT_OAKES_2"] then
							if pCity:IsCoastal() then
								pCity:SetName("TXT_KEY_CITY_NAME_ARACHNOS_PORT_OAKES_1")
							else
								pCity:SetName("TXT_KEY_CITY_NAME_ARACHNOS_PORT_OAKES_2")
							end
						end
					elseif iCityNameLoop == 3 then
						if not tCityNames["TXT_KEY_CITY_NAME_ARACHNOS_SHARKHEAD_1"] and not tCityNames["TXT_KEY_CITY_NAME_ARACHNOS_SHARKHEAD_2"] then
							local pArea = Map.GetArea(pPlot:GetArea())
							if pArea:GetNumTiles() <= 5 then
								pCity:SetName("TXT_KEY_CITY_NAME_ARACHNOS_SHARKHEAD_1")
							else
								pCity:SetName("TXT_KEY_CITY_NAME_ARACHNOS_SHARKHEAD_2")
							end
						end
					elseif iCityNameLoop == 4 then
						if not tCityNames["TXT_KEY_CITY_NAME_ARACHNOS_BLOODY_BAY_1"] and not tCityNames["TXT_KEY_CITY_NAME_ARACHNOS_BLOODY_BAY_2"] then
							local pArea = Map.GetArea(pPlot:GetArea())
							if pArea:GetNumTiles() <= 5 then
								pCity:SetName("TXT_KEY_CITY_NAME_ARACHNOS_BLOODY_BAY_1")
							else
								pCity:SetName("TXT_KEY_CITY_NAME_ARACHNOS_BLOODY_BAY_2")
							end
						end
					elseif iCityNameLoop == 11 then
						if not tCityNames["TXT_KEY_CITY_NAME_ARACHNOS_MONSTER_ISLAND_1"] and not tCityNames["TXT_KEY_CITY_NAME_ARACHNOS_MONSTER_ISLAND_2"] then
							local pArea = Map.GetArea(pPlot:GetArea())
							if pArea:GetNumTiles() <= 5 then
								pCity:SetName("TXT_KEY_CITY_NAME_ARACHNOS_MONSTER_ISLAND_1")
							else
								pCity:SetName("TXT_KEY_CITY_NAME_ARACHNOS_MONSTER_ISLAND_2")
							end
						end
					end
					iCityNameLoop = iCityNameLoop + 1
				else
					break
				end
			end
		elseif pOwner:GetCivilizationType() == GameInfoTypes.CIVILIZATION_PRAETORIA then
			--Cole's dynamics:
			--City 5 uses island metric for Keyes Island/Keyesopolis.
			--Automatically generates names with the format "Ward #x" after the city list is exhausted.
			for iLoop, pLoop in pairs(Players) do
				for pLoopCity in pLoop:Cities() do
					local sKey = pLoopCity:GetNameKey()
					local sName = pLoopCity:GetName()
					if string.find(sKey, "TXT_KEY_CITY_NAME_PRAETORIA_") or string.find(sName, "Ward #") then
						tCityNames[sKey] = true
					end
				end
			end

			local iCityNameLoop = 1
			local bGenerateNames;
			while iCityNameLoop < 8 do
				local sKey = "TXT_KEY_CITY_NAME_PRAETORIA_" ..tostring(iCityNameLoop)
				if tCityNames[sKey] then
					if iCityNameLoop == 6 then
						if not tCityNames["TXT_KEY_CITY_NAME_PRAETORIA_KEYES_1"] and not tCityNames["TXT_KEY_CITY_NAME_PRAETORIA_KEYES_2"] then
							local pArea = Map.GetArea(pPlot:GetArea())
							if pArea:GetNumTiles() <= 5 then
								pCity:SetName("TXT_KEY_CITY_NAME_PRAETORIA_KEYES_1")
							else
								pCity:SetName("TXT_KEY_CITY_NAME_PRAETORIA_KEYES_2")
							end
						end
					end
					if iCityNameLoop == 8 then
						bGenerateNames = true
					end
					iCityNameLoop = iCityNameLoop + 1
				else
					break
				end
			end

			if bGenerateNames then
				local iLoopNumber = 2 --starts at 2 since there is already a specified First Ward
				while bGenerateNames do
					local sName = Locale.ConvertTextKey("TXT_KEY_CITY_NAME_PRAETORIA_GENERATE", tostring(iLoopNumber))
					if not tCityNames[sName] then
						pCity:SetName(sName)
						break
					else
						iLoopNumber = iLoopNumber + 1
					end
				end
			end
		elseif pOwner:GetCivilizationType() == GameInfoTypes.CIVILIZATION_NEMESIS then
			--Nemesis currently has no dynamic naming
		elseif pOwner:GetCivilizationType() == GameInfoTypes.CIVILIZATION_RIKTI then
			--Hro'dtohz's dynamics:
			--Take the randomly-assigned name from the Hun-esque city name acquisition, and then "Riktify" it.
			--To Riktify a name, replace up to three vowels with apostrophes.
			if pCity:GetNameKey() ~= "TXT_KEY_CITY_NAME_RIKTI_1" then
				local sName = pCity:GetName()
				local _, iNumVowels = string.gsub(sName, "[aeiou]", "")  --doesn't count capital vowels
				local iVowelsToReplace = 1;
				if iNumVowels > 6 then
					iVowelsToReplace = 3
				elseif iNumVowels > 3 then
					iVowelsToReplace = 2
				end
				--In an attempt to prevent all of the apostrophes from being front loaded while also being too lazy to write a lot of
				--string.finds to get exact locations of them in the name, we'll only replace "i", "o", and "u" since "a" and "e" seem
				--to be the most common Rikti name vowels.
				sName = string.gsub(sName, "[iou]", "'", iVowelsToReplace)
				--get rid of adjacent apostrophes
				sName = string.gsub(sName, "''", "'")
				pCity:SetName(sName)
			end
		end
	end
end