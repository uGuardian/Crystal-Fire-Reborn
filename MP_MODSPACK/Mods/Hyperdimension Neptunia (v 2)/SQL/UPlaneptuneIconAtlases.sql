INSERT INTO IconTextureAtlases 
			(Atlas, 								IconSize, 	Filename, 					IconsPerRow, 	IconsPerColumn)
VALUES		('CIV_COLOR_ATLAS_VV_PLANEPTUNE_PL', 	256, 		'VVPlutiaAtlas256.dds',		4, 				2),
			('CIV_COLOR_ATLAS_VV_PLANEPTUNE_PL', 	128, 		'VVPlutiaAtlas128.dds',		4, 				2),
			('CIV_COLOR_ATLAS_VV_PLANEPTUNE_PL', 	80, 		'VVPlutiaAtlas80.dds',		4, 				2),
			('CIV_COLOR_ATLAS_VV_PLANEPTUNE_PL', 	64, 		'VVPlutiaAtlas64.dds',		4, 				2),
			('CIV_COLOR_ATLAS_VV_PLANEPTUNE_PL', 	45, 		'VVPlutiaAtlas45.dds',		4, 				2),
			('CIV_COLOR_ATLAS_VV_PLANEPTUNE_PL', 	32, 		'VVPlutiaAtlas32.dds',		4, 				2),
			('CIV_ALPHA_ATLAS_VV_PLANEPTUNE_PL', 	128, 		'VVPlaneptuneAlpha128.dds',	1, 				1),
			('CIV_ALPHA_ATLAS_VV_PLANEPTUNE_PL', 	64, 		'VVPlaneptuneAlpha64.dds',	1, 				1),
			('CIV_ALPHA_ATLAS_VV_PLANEPTUNE_PL', 	48, 		'VVPlaneptuneAlpha48.dds',	1, 				1),
			('CIV_ALPHA_ATLAS_VV_PLANEPTUNE_PL', 	32, 		'VVPlaneptuneAlpha32.dds',	1, 				1),
			('CIV_ALPHA_ATLAS_VV_PLANEPTUNE_PL', 	24, 		'VVPlaneptuneAlpha24.dds',	1, 				1),
			('CIV_ALPHA_ATLAS_VV_PLANEPTUNE_PL', 	16, 		'VVPlaneptuneAlpha16.dds',	1, 				1),
			('RELIGION_ATLAS_VV_PLANEPTUNE_PL', 	128, 		'VVPlutiaReligion128.dds',	1, 				1),
			('RELIGION_ATLAS_VV_PLANEPTUNE_PL', 	80, 		'VVPlutiaReligion80.dds',	1, 				1),
			('RELIGION_ATLAS_VV_PLANEPTUNE_PL', 	64, 		'VVPlutiaReligion64.dds',	1, 				1),
			('RELIGION_ATLAS_VV_PLANEPTUNE_PL', 	48, 		'VVPlutiaReligion48.dds',	1, 				1),
			('RELIGION_ATLAS_VV_PLANEPTUNE_PL', 	32, 		'VVPlutiaReligion32.dds',	1, 				1),
			('RELIGION_ATLAS_VV_PLANEPTUNE_PL', 	24, 		'VVPlutiaReligion24.dds',	1, 				1),
			('RELIGION_ATLAS_VV_PLANEPTUNE_PL', 	16, 		'VVPlutiaReligion16.dds',	1, 				1),
			('UNIT_FLAG_ATLAS_PLANEPTUNE_PL',		32,			'VVPlutiaUnitFlagIcon.dds',	1, 				1);


INSERT INTO IconFontTextures
			(IconFontTexture,						IconFontTextureFile)
VALUES		('ICON_FONT_TEXTURE_VV_IRIS_HEART',		'VVIrisHeartReligionFont'),
			('ICON_FONT_TEXTURE_VV_CLIMAX',			'VVIrisHeartClimaxIcon'),
			('ICON_FONT_TEXTURE_VV_DOLL',			'VVPlutiaDollIcon');

INSERT INTO IconFontMapping
			(IconName,							IconFontTexture,						IconMapping)
VALUES		('ICON_VV_IRIS_HEART_RELIGION',		'ICON_FONT_TEXTURE_VV_IRIS_HEART',	1),
			('ICON_VV_IRIS_CLIMAX',				'ICON_FONT_TEXTURE_VV_CLIMAX',		1),
			('ICON_VV_PLUTIA_DOLL',				'ICON_FONT_TEXTURE_VV_DOLL',		1);