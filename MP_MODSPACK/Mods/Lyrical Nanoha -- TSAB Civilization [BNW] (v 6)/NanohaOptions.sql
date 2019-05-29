CREATE TABLE NanohaModOptions
			(Option,		Value);

INSERT INTO NanohaModOptions
			(Option,	Value)
VALUES		('NANOHAOPTION_ALTART',	0),
			('NANOHAOPTION_REVERTPORTUGAL',	0);

-----------------------------------------------------------------------------------------------------------------------------------------------
--OPTION 1: ALTERNATE ART
--Set this to "1" to change Nanoha's icons to her loli version.
-----------------------------------------------------------------------------------------------------------------------------------------------
UPDATE NanohaModOptions
SET Value = 0
WHERE Option = 'NANOHAOPTION_ALTART';


-----------------------------------------------------------------------------------------------------------------------------------------------
--OPTION 2: PORTUGAL COLORS
--Set this to "1" to return Portugal to their normal colors. (Will be quite hard to distinguish between Portugal and the TSAB!)
-----------------------------------------------------------------------------------------------------------------------------------------------
UPDATE NanohaModOptions
SET Value = 0
WHERE Option = 'NANOHAOPTION_REVERTPORTUGAL';


-----------------------------------------------------------------------------------------------------------------------------------------------
UPDATE Civilizations
SET MapImage = 'NanohaSelectImage.dds', DawnOfManImage = 'DOM_Nanoha.dds'
WHERE Type = 'CIVILIZATION_TSAB' AND EXISTS (SELECT * FROM NanohaModOptions WHERE Option = 'NANOHAOPTION_ALTART' AND Value = 1);

UPDATE Leaders
SET ArtDefineTag = 'NanohaScene.xml', IconAtlas = 'CIV_COLOR_ATLAS_TSAB', PortraitIndex = 1
WHERE Type = 'LEADER_NANOHA' AND EXISTS (SELECT * FROM NanohaModOptions WHERE Option = 'NANOHAOPTION_ALTART' AND Value = 1);


UPDATE Colors
SET Red = 0.99, Blue = 0, Green = 0
WHERE Type = 'COLOR_PLAYER_PORTUGAL_ICON' AND EXISTS (SELECT * FROM NanohaModOptions WHERE Option = 'NANOHAOPTION_REVERTPORTUGAL' AND Value = 0);

UPDATE Colors
SET Red = 0.20, Blue = 0.05, Green = 0.73
WHERE Type = 'COLOR_PLAYER_PORTUGAL_BACKGROUND' AND EXISTS (SELECT * FROM NanohaModOptions WHERE Option = 'NANOHAOPTION_REVERTPORTUGAL' AND Value = 0);


UPDATE Civilizations
SET PortraitIndex = 0, IconAtlas = 'CIV_COLOR_ATLAS_PORTUGAL_REPLACE'
WHERE Type = 'CIVILIZATION_PORTUGAL' AND EXISTS (SELECT * FROM NanohaModOptions WHERE Option = 'NANOHAOPTION_REVERTPORTUGAL' AND Value = 0);