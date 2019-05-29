INSERT INTO IconTextureAtlases 
			(Atlas, 								IconSize, 	Filename, 						IconsPerRow, 	IconsPerColumn)
VALUES		('CIV_COLOR_ATLAS_VV_PLANEPTUNE_NG', 	256, 		'VVNepgearAtlas256.dds',		5, 				1),
			('CIV_COLOR_ATLAS_VV_PLANEPTUNE_NG', 	128, 		'VVNepgearAtlas128.dds',		5, 				1),
			('CIV_COLOR_ATLAS_VV_PLANEPTUNE_NG', 	80, 		'VVNepgearAtlas80.dds',			5, 				1),
			('CIV_COLOR_ATLAS_VV_PLANEPTUNE_NG', 	64, 		'VVNepgearAtlas64.dds',			5, 				1),
			('CIV_COLOR_ATLAS_VV_PLANEPTUNE_NG', 	45, 		'VVNepgearAtlas45.dds',			5, 				1),
			('CIV_COLOR_ATLAS_VV_PLANEPTUNE_NG', 	32, 		'VVNepgearAtlas32.dds',			5, 				1),
			('CIV_ALPHA_ATLAS_VV_PLANEPTUNE_NG', 	128, 		'VVPlaneptuneAlpha128.dds',		1, 				1),
			('CIV_ALPHA_ATLAS_VV_PLANEPTUNE_NG', 	64, 		'VVPlaneptuneAlpha64.dds',		1, 				1),
			('CIV_ALPHA_ATLAS_VV_PLANEPTUNE_NG', 	48, 		'VVPlaneptuneAlpha48.dds',		1, 				1),
			('CIV_ALPHA_ATLAS_VV_PLANEPTUNE_NG', 	32, 		'VVPlaneptuneAlpha32.dds',		1, 				1),
			('CIV_ALPHA_ATLAS_VV_PLANEPTUNE_NG', 	24, 		'VVPlaneptuneAlpha24.dds',		1, 				1),
			('CIV_ALPHA_ATLAS_VV_PLANEPTUNE_NG', 	16, 		'VVPlaneptuneAlpha16.dds',		1, 				1),
			('RELIGION_ATLAS_VV_PLANEPTUNE_NG', 	128, 		'VVNepgearReligion128.dds',		1, 				1),
			('RELIGION_ATLAS_VV_PLANEPTUNE_NG', 	80, 		'VVNepgearReligion80.dds',		1, 				1),
			('RELIGION_ATLAS_VV_PLANEPTUNE_NG', 	64, 		'VVNepgearReligion64.dds',		1, 				1),
			('RELIGION_ATLAS_VV_PLANEPTUNE_NG', 	48, 		'VVNepgearReligion48.dds',		1, 				1),
			('RELIGION_ATLAS_VV_PLANEPTUNE_NG', 	32, 		'VVNepgearReligion32.dds',		1, 				1),
			('RELIGION_ATLAS_VV_PLANEPTUNE_NG', 	24, 		'VVNepgearReligion24.dds',		1, 				1),
			('RELIGION_ATLAS_VV_PLANEPTUNE_NG', 	16, 		'VVNepgearReligion16.dds',		1, 				1),
			('UNIT_FLAG_ATLAS_PLANEPTUNE_NG',		32,			'VVNepgearUnitFlagIcon.dds',	1, 				1);


INSERT INTO IconFontTextures
			(IconFontTexture,						IconFontTextureFile)
VALUES		('ICON_FONT_TEXTURE_VV_PURPLE_SISTER',	'VVNepgearReligionFont');

INSERT INTO IconFontMapping
			(IconName,							IconFontTexture,						IconMapping)
VALUES		('ICON_VV_PURPLE_SISTER_RELIGION',	'ICON_FONT_TEXTURE_VV_PURPLE_SISTER',	1);