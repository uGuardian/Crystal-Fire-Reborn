INSERT INTO EventsAddin_Support		
			(FileName)
VALUES		('LancerEvents.lua');


INSERT INTO BuildingClasses 	
			(Type, 						 		 			DefaultBuilding, 							Description)
VALUES		('BUILDINGCLASS_DECISIONS_LANCER_LOATHLY_LADY','BUILDING_DECISIONS_LANCER_LOATHLY_LADY', 	'TXT_KEY_BUILDING_DECISIONS_LANCER_LOATHLY_LADY');


INSERT INTO Buildings 	
			(Type, 						 				BuildingClass, 									Description,										Civilopedia,
			Help,													Strategy,			Cost,	PrereqTech, 	ConquestProb,	IconAtlas, 				PortraitIndex,
			EnhancedYieldTech,		TechEnhancedTourism,	Happiness)
VALUES		('BUILDING_DECISIONS_LANCER_LOATHLY_LADY', 	'BUILDINGCLASS_DECISIONS_LANCER_LOATHLY_LADY',	'TXT_KEY_BUILDING_DECISIONS_LANCER_LOATHLY_LADY',	'TXT_KEY_BUILDING_DECISIONS_LANCER_LOATHLY_LADY_CIVILOPEDIA',
			'TXT_KEY_BUILDING_DECISIONS_LANCER_LOATHLY_LADY_HELP',	null,				-1,  	null,			100,			'EXPANSION_BW_ATLAS_1',	2,
			'TECH_AGRICULTURE',		2,						2);


INSERT INTO Building_YieldChanges
			(BuildingType,								YieldType,			Yield)
VALUES		('BUILDING_DECISIONS_LANCER_LOATHLY_LADY',	'YIELD_CULTURE',	2);
