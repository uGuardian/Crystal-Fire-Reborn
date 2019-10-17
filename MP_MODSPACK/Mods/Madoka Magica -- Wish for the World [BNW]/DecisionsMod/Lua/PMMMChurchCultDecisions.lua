-- PMMMReligiousDecisions
-- Author: Vicevirtuoso
-- DateCreated: 8/25/2014 2:02:10 PM
--------------------------------------------------------------

tReligiousGroups.RELIGION_CHURCH_OF_MADOKA = "RELIGIONGROUP_MADOKA"
tReligiousGroups.RELIGION_CULT_OF_HOMURA = "RELIGIONGROUP_MADOKA"

--Holy Book--------------------------------------------
tReligion_HolyBook.RELIGIONGROUP_MADOKA = "MADOKA"

for Religion in GameInfo.Religions() do
	local sReligion = Religion.Type
	local sReligionGroup = tReligiousGroups[sReligion]
	if tReligion_HolyBook[sReligionGroup] ~= nil then
		tReligion_HolyBook[sReligion] = tReligion_HolyBook[sReligionGroup]
	end
end



--Festival------------------------------------------------------------------------------------------------------------------
tReligionEvents_1.RELIGIONGROUP_MADOKA = {GameInfo.Yields.YIELD_FAITH.ID, GameInfo.Yields.YIELD_FOOD.ID, "MADOKA"}


for Religion in GameInfo.Religions() do
	local sReligion = Religion.Type
	local sReligionGroup = tReligiousGroups[sReligion]
	if tReligionEvents_1[sReligionGroup] ~= nil then
		tReligionEvents_1[sReligion] = tReligionEvents_1[sReligionGroup]
	end
end