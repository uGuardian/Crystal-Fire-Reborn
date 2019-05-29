INSERT INTO DecisionsAddin_Support
			(FileName)
VALUES		('PMMMKyoukoDecisions.lua');

INSERT INTO IconFontTextures
			(IconFontTexture,								IconFontTextureFile)
VALUES		('ICON_FONT_TEXTURE_RESOURCE_DECISIONS_ROCKY',	'DecisionsKyoukoRockyIcon');

INSERT INTO IconFontMapping
			(IconName,				IconFontTexture,								IconMapping)
VALUES		('ICON_RES_PMMM_ROCKY',	'ICON_FONT_TEXTURE_RESOURCE_DECISIONS_ROCKY',	1);

INSERT INTO IconTextureAtlases 
			(Atlas, 							IconSize, 	Filename, 							IconsPerRow, 	IconsPerColumn)
VALUES		('RESOURCE_ATLAS_DECISIONS_ROCKY',	256,		'DecisionsKyoukoRocky256.dds',		1,				1);

INSERT INTO Resources 
			(Type,							Description,						Civilopedia, 									ResourceClassType, 		Happiness,  AITradeModifier, 	ResourceUsage,	AIObjective,	'Unique', 	IconString, 				PortraitIndex, 	IconAtlas)
VALUES		('RESOURCE_DECISIONS_ROCKY',	'TXT_KEY_RESOURCE_DECISIONS_ROCKY',	'TXT_KEY_CIV5_RESOURCE_DECISIONS_ROCKY_TEXT',	'RESOURCECLASS_LUXURY',	4,			10,					2, 				0, 				2, 			'[ICON_RES_PMMM_ROCKY]',	0, 				'RESOURCE_ATLAS_DECISIONS_ROCKY');

INSERT INTO BuildingClasses 	
			(Type, 						 		 			DefaultBuilding, 							Description, 										MaxPlayerInstances)
VALUES		('BUILDINGCLASS_DECISIONS_KYOUKO_DEVELOP_ROCKY','BUILDING_DECISIONS_KYOUKO_DEVELOP_ROCKY', 	'TXT_KEY_DECISIONS_BUILDING_KYOUKO_DEVELOP_ROCKY',	1);

INSERT INTO Buildings 	
			(Type, 						 					BuildingClass, 									Description,										Civilopedia,													Help,													Strategy,			Cost,	PrereqTech, 	ConquestProb,	IconAtlas, 		PortraitIndex)
VALUES		('BUILDING_DECISIONS_KYOUKO_DEVELOP_ROCKY', 	'BUILDINGCLASS_DECISIONS_KYOUKO_DEVELOP_ROCKY',	'TXT_KEY_DECISIONS_BUILDING_KYOUKO_DEVELOP_ROCKY',	'TXT_KEY_DECISIONS_BUILDING_KYOUKO_DEVELOP_ROCKY_CIVILOPEDIA',	'TXT_KEY_DECISIONS_BUILDING_KYOUKO_DEVELOP_ROCKY_HELP',	null,				-1,  	null,			100,			'BW_ATLAS_1',	0);

INSERT INTO Building_ResourceQuantity
			(BuildingType, 									ResourceType,				Quantity)
VALUES		('BUILDING_DECISIONS_KYOUKO_DEVELOP_ROCKY', 	'RESOURCE_DECISIONS_ROCKY',	3);

INSERT INTO Building_YieldChanges
			(BuildingType,									YieldType,			Yield)
VALUES		('BUILDING_DECISIONS_KYOUKO_DEVELOP_ROCKY', 	'YIELD_FOOD',		2);