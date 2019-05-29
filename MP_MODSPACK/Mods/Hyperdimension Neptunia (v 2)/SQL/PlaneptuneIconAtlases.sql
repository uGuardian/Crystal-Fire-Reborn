INSERT INTO IconTextureAtlases 
			(Atlas, 								IconSize, 	Filename, 					IconsPerRow, 	IconsPerColumn)
VALUES		('CIV_COLOR_ATLAS_VV_PLANEPTUNE', 	256, 		'VVNeptuneAtlas256.dds',		4, 				4),
			('CIV_COLOR_ATLAS_VV_PLANEPTUNE', 	128, 		'VVNeptuneAtlas128.dds',		4, 				4),
			('CIV_COLOR_ATLAS_VV_PLANEPTUNE', 	80, 		'VVNeptuneAtlas80.dds',			4, 				4),
			('CIV_COLOR_ATLAS_VV_PLANEPTUNE', 	64, 		'VVNeptuneAtlas64.dds',			4, 				4),
			('CIV_COLOR_ATLAS_VV_PLANEPTUNE', 	45, 		'VVNeptuneAtlas45.dds',			4, 				4),
			('CIV_COLOR_ATLAS_VV_PLANEPTUNE', 	32, 		'VVNeptuneAtlas32.dds',			4, 				4),
			('CIV_ALPHA_ATLAS_VV_PLANEPTUNE', 	128, 		'VVPlaneptuneAlpha128.dds',		1, 				1),
			('CIV_ALPHA_ATLAS_VV_PLANEPTUNE', 	64, 		'VVPlaneptuneAlpha64.dds',		1, 				1),
			('CIV_ALPHA_ATLAS_VV_PLANEPTUNE', 	48, 		'VVPlaneptuneAlpha48.dds',		1, 				1),
			('CIV_ALPHA_ATLAS_VV_PLANEPTUNE', 	32, 		'VVPlaneptuneAlpha32.dds',		1, 				1),
			('CIV_ALPHA_ATLAS_VV_PLANEPTUNE', 	24, 		'VVPlaneptuneAlpha24.dds',		1, 				1),
			('CIV_ALPHA_ATLAS_VV_PLANEPTUNE', 	16, 		'VVPlaneptuneAlpha16.dds',		1, 				1),
			('RELIGION_ATLAS_VV_PLANEPTUNE', 	128, 		'VVNeptuneReligion128.dds',		1, 				1),
			('RELIGION_ATLAS_VV_PLANEPTUNE', 	80, 		'VVNeptuneReligion80.dds',		1, 				1),
			('RELIGION_ATLAS_VV_PLANEPTUNE', 	64, 		'VVNeptuneReligion64.dds',		1, 				1),
			('RELIGION_ATLAS_VV_PLANEPTUNE', 	48, 		'VVNeptuneReligion48.dds',		1, 				1),
			('RELIGION_ATLAS_VV_PLANEPTUNE', 	32, 		'VVNeptuneReligion32.dds',		1, 				1),
			('RELIGION_ATLAS_VV_PLANEPTUNE', 	24, 		'VVNeptuneReligion24.dds',		1, 				1),
			('RELIGION_ATLAS_VV_PLANEPTUNE', 	16, 		'VVNeptuneReligion16.dds',		1, 				1),
			('UNIT_FLAG_ATLAS_PLANEPTUNE',		32,			'VVNeptuneUnitFlagIcon.dds',	1, 				1);


INSERT INTO IconFontTextures
			(IconFontTexture,						IconFontTextureFile)
VALUES		('ICON_FONT_TEXTURE_VV_PURPLE_HEART',	'VVNeptuneReligionFont'),
			('ICON_FONT_TEXTURE_VV_HISTY_ENERGY',	'VVNeptuneEnergyIcon'),
			('ICON_FONT_TEXTURE_VV_NEP_LUXURIES',	'VVNeptuneLuxuryFontIcons');

INSERT INTO IconFontMapping
			(IconName,							IconFontTexture,						IconMapping)
VALUES		('ICON_VV_PURPLE_HEART_RELIGION',	'ICON_FONT_TEXTURE_VV_PURPLE_HEART',	1),
			('ICON_VV_HISTY_ENERGY',			'ICON_FONT_TEXTURE_VV_HISTY_ENERGY',	1),
			('ICON_RES_VV_VANILLA',				'ICON_FONT_TEXTURE_VV_NEP_LUXURIES',	1),
			('ICON_RES_VV_CHOCOLATE',			'ICON_FONT_TEXTURE_VV_NEP_LUXURIES',	2),
			('ICON_RES_VV_STRAWBERRY',			'ICON_FONT_TEXTURE_VV_NEP_LUXURIES',	3),
			('ICON_RES_VV_BANANA',				'ICON_FONT_TEXTURE_VV_NEP_LUXURIES',	4),
			('ICON_RES_VV_CARAMEL',				'ICON_FONT_TEXTURE_VV_NEP_LUXURIES',	5),
			('ICON_RES_VV_BERRY',				'ICON_FONT_TEXTURE_VV_NEP_LUXURIES',	6),
			('ICON_RES_VV_MINT',				'ICON_FONT_TEXTURE_VV_NEP_LUXURIES',	7),
			('ICON_RES_VV_CAKE',				'ICON_FONT_TEXTURE_VV_NEP_LUXURIES',	8);