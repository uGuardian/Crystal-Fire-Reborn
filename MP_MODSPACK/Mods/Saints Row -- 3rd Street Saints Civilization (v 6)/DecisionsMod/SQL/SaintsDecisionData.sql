INSERT INTO DecisionsAddin_Support		
			(FileName)
VALUES		('SaintsDecisions.lua');

INSERT INTO IconFontTextures
			(IconFontTexture,										IconFontTextureFile)
VALUES		('ICON_FONT_TEXTURE_RESOURCE_DECISIONS_SAINTS_FLOW',	'SaintsFlowFontIcon');

INSERT INTO IconFontMapping
			(IconName,					IconFontTexture,									IconMapping)
VALUES		('ICON_RES_SAINTS_FLOW',	'ICON_FONT_TEXTURE_RESOURCE_DECISIONS_SAINTS_FLOW',	1);

INSERT INTO IconTextureAtlases 
			(Atlas, 									IconSize, 	Filename, 					IconsPerRow, 	IconsPerColumn)
VALUES		('RESOURCE_ATLAS_DECISIONS_SAINTS_FLOW',	256,		'SaintsFlow256.dds',		1,				1),
			('RESOURCE_ATLAS_DECISIONS_SAINTS_FLOW',	128,		'SaintsFlow128.dds',		1,				1),
			('RESOURCE_ATLAS_DECISIONS_SAINTS_FLOW',	80,			'SaintsFlow80.dds',			1,				1),
			('RESOURCE_ATLAS_DECISIONS_SAINTS_FLOW',	64,			'SaintsFlow64.dds',			1,				1),
			('RESOURCE_ATLAS_DECISIONS_SAINTS_FLOW',	45,			'SaintsFlow45.dds',			1,				1),
			('RESOURCE_ATLAS_DECISIONS_SAINTS_FLOW',	32,			'SaintsFlow32.dds',			1,				1);


INSERT INTO Resources 
			(Type,								Description,								Civilopedia, 										ResourceClassType, 		Happiness,  AITradeModifier, 	ResourceUsage,	AIObjective,	'Unique', 	IconString, 				PortraitIndex, 	IconAtlas)
VALUES		('RESOURCE_DECISIONS_SAINTS_FLOW',	'TXT_KEY_RESOURCE_DECISIONS_SAINTS_FLOW',	'TXT_KEY_CIV5_RESOURCE_DECISIONS_SAINTS_FLOW_TEXT',	'RESOURCECLASS_LUXURY',	4,			10,					2, 				0, 				2, 			'[ICON_RES_SAINTS_FLOW]',	0, 				'RESOURCE_ATLAS_DECISIONS_SAINTS_FLOW');


INSERT INTO BuildingClasses 	
			(Type, 						 		 			DefaultBuilding, 							Description)
VALUES		('BUILDINGCLASS_DECISIONS_SRTT_SAINTS_FLOW','BUILDING_DECISIONS_SRTT_SAINTS_FLOW', 	'TXT_KEY_DECISIONS_BUILDING_SRTT_SAINTS_FLOW');

INSERT INTO Buildings 	
			(Type, 						 				BuildingClass, 								Description,									Civilopedia,												Help,												Strategy,			Cost,	PrereqTech, 	ConquestProb,	IconAtlas, 								PortraitIndex)
VALUES		('BUILDING_DECISIONS_SRTT_SAINTS_FLOW', 	'BUILDINGCLASS_DECISIONS_SRTT_SAINTS_FLOW',	'TXT_KEY_DECISIONS_BUILDING_SRTT_SAINTS_FLOW',	'TXT_KEY_DECISIONS_BUILDING_SRTT_SAINTS_FLOW_CIVILOPEDIA',	'TXT_KEY_DECISIONS_BUILDING_SRTT_SAINTS_FLOW_HELP',	null,				-1,  	null,			100,			'RESOURCE_ATLAS_DECISIONS_SAINTS_FLOW',	0);

UPDATE Buildings
SET Cost = (SELECT Cost FROM Buildings WHERE Type = 'BUILDING_FACTORY')
WHERE Type = 'BUILDING_DECISIONS_SRTT_SAINTS_FLOW';


INSERT INTO Building_ResourceQuantity
			(BuildingType, 								ResourceType,					Quantity)
VALUES		('BUILDING_DECISIONS_SRTT_SAINTS_FLOW', 	'RESOURCE_DECISIONS_SAINTS_FLOW',	1);

INSERT INTO Building_YieldChanges
			(BuildingType,								YieldType,			Yield)
VALUES		('BUILDING_DECISIONS_SRTT_SAINTS_FLOW', 	'YIELD_GOLD',		2);