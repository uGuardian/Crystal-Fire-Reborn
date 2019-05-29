--Wish for the World Options SQL

--FEMINIZE PRODIGY NAMES
--Description:
--When set to "1", many Great Person names found in the base game will be "feminized" to fit the fact that they are going to be Magical Girls.
--Examples: Albert Einstein becomes Albertine Einstein. Henry Ford becomes Henrietta Ford.
--Set to "0" to turn off.
--Does not work with modded GP names, unless they add in name keys following the format "TXT_KEY_GREAT_PERSON_(NAME)_PMMM_FEMALEREPLACE" and add a reference to this mod.

UPDATE WishForTheWorldOptions
SET Value = 1
WHERE Option = 'FeminizeProdigyNames';


--ENABLE ALL CIVS
--Description:
--Enables all Civilizations added by the mod to both humans and AI players, including those which are unfinished.
--As of v.15, all Civilizations are open to human players, but The Pleiades Saints and Shirome are set to be blocked for AI use since they do not have leaderscreens or AI logic for their uniques.
--Set to "1" to turn on. You do so at your own risk. (Well, it probably won't break the game, but fighting against them will certainly be lacking something.)

UPDATE WishForTheWorldOptions
SET Value = 1
WHERE Option = 'EnableAllCivs';




--CULTURAL MG SKIN TONES
--Description:
--When a new Magical Girl spawns, her skin tone is determined by the Civilization from which she was spawned -- or, more specifically, its ArtDefineTag.

--Skin Tone 1 (White): ARTSTYLE_EUROPEAN, ARTSTYLE_ASIAN
--Skin Tone 2 (Tanned): ARTSTYLE_GRECO_ROMAN, ARTSTYLE_BARBARIAN
--Skin Tone 3 (Redder Tanned): ARTSTYLE_SOUTH_AMERICA, ARTSTYLE_POLYNESIAN
--Skin Tone 4 (Black): ARTSTYLE_MIDDLE_EAST

--Specific Civs have different properties:
--America, Brazil: Always randomized skin tones, due to their "immigrant nation" nature.
--Ultimate Madoka: Always randomized skin tones, due to her "lesbian heaven for all the world's Magical Girls" nature.
--Arabia, Persia: Uses Skin Tone 2 despite being ARTSTYLE_MIDDLE_EAST. Not exactly sure why these two are grouped along with the Songhai and Zulu, but hey.

--Set to "0" to turn off. If turned off, all MG skin colors will be randomized just like their hair, eye, and outfit colors.

UPDATE WishForTheWorldOptions
SET Value = 1
WHERE Option = 'CulturalMGSkinTones';



--CBP Barbarian Healing
-- **NO EFFECT WITHOUT USING THE COMMUNITY PATCH DLL**
--Description:
--Overrides the setting for the Community Patch's feature to allow Barbarians (i.e. Witches and Familiars) to heal over time.

--From CBP Files:
--0 = No Healing
--1 = 6HP out of camps, 12 in camps. (Default)
--2 = 10HP out of camps, 20 in camps. (Hard)

UPDATE WishForTheWorldOptions
SET Value = 0
WHERE Option = 'CBPWitchHealOverride';