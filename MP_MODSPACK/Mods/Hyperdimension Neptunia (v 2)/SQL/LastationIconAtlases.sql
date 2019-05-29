INSERT INTO IconTextureAtlases 
			(Atlas, 								IconSize, 	Filename, 						IconsPerRow, 	IconsPerColumn)
VALUES		('CIV_COLOR_ATLAS_VV_LASTATION', 		256, 		'VVNoireAtlas256.dds',			4, 				2),
			('CIV_COLOR_ATLAS_VV_LASTATION',		128, 		'VVNoireAtlas128.dds',			4, 				2),
			('CIV_COLOR_ATLAS_VV_LASTATION',		80, 		'VVNoireAtlas80.dds',			4, 				2),
			('CIV_COLOR_ATLAS_VV_LASTATION',		64, 		'VVNoireAtlas64.dds',			4, 				2),
			('CIV_COLOR_ATLAS_VV_LASTATION', 		45, 		'VVNoireAtlas45.dds',			4, 				2),
			('CIV_COLOR_ATLAS_VV_LASTATION',		32, 		'VVNoireAtlas32.dds',			4, 				2),
			('CIV_COLOR_ATLAS_VV_LASTATION_ULTRA', 	256, 		'VVNoireUDAtlas256.dds',		3, 				1),
			('CIV_COLOR_ATLAS_VV_LASTATION_ULTRA', 	128, 		'VVNoireUDAtlas128.dds',		3, 				1),
			('CIV_COLOR_ATLAS_VV_LASTATION_ULTRA', 	80, 		'VVNoireUDAtlas80.dds',			3, 				1),
			('CIV_COLOR_ATLAS_VV_LASTATION_ULTRA', 	64, 		'VVNoireUDAtlas64.dds',			3, 				1),
			('CIV_COLOR_ATLAS_VV_LASTATION_ULTRA', 	45, 		'VVNoireUDAtlas45.dds',			3, 				1),
			('CIV_COLOR_ATLAS_VV_LASTATION_ULTRA', 	32, 		'VVNoireUDAtlas32.dds',			3, 				1),
			('CIV_ALPHA_ATLAS_VV_LASTATION', 		128, 		'VVLastationAlpha128.dds',		1, 				1),
			('CIV_ALPHA_ATLAS_VV_LASTATION',		64, 		'VVLastationAlpha64.dds',		1, 				1),
			('CIV_ALPHA_ATLAS_VV_LASTATION', 		48, 		'VVLastationAlpha48.dds',		1, 				1),
			('CIV_ALPHA_ATLAS_VV_LASTATION',		32, 		'VVLastationAlpha32.dds',		1, 				1),
			('CIV_ALPHA_ATLAS_VV_LASTATION',		24, 		'VVLastationAlpha24.dds',		1, 				1),
			('CIV_ALPHA_ATLAS_VV_LASTATION',		16, 		'VVLastationAlpha16.dds',		1, 				1),
			('RELIGION_ATLAS_VV_LASTATION',			128, 		'VVBlackHeartReligion128.dds',	1, 				1),
			('RELIGION_ATLAS_VV_LASTATION',			80, 		'VVBlackHeartReligion80.dds',	1, 				1),
			('RELIGION_ATLAS_VV_LASTATION',			64, 		'VVBlackHeartReligion64.dds',	1, 				1),
			('RELIGION_ATLAS_VV_LASTATION',			48, 		'VVBlackHeartReligion48.dds',	1, 				1),
			('RELIGION_ATLAS_VV_LASTATION', 		32, 		'VVBlackHeartReligion32.dds',	1, 				1),
			('RELIGION_ATLAS_VV_LASTATION', 		24, 		'VVBlackHeartReligion24.dds',	1, 				1),
			('RELIGION_ATLAS_VV_LASTATION',			16, 		'VVBlackHeartReligion16.dds',	1, 				1),
			('UNIT_FLAG_ATLAS_ARMAS',				32, 		'VVNoireUnitFlag.dds',			1, 				1);


INSERT INTO IconFontTextures
			(IconFontTexture,						IconFontTextureFile)
VALUES		('ICON_FONT_TEXTURE_VV_BLACK_HEART',	'VVBlackHeartReligionFont');

INSERT INTO IconFontMapping
			(IconName,							IconFontTexture,					IconMapping)
VALUES		('ICON_VV_BLACK_HEART_RELIGION',	'ICON_FONT_TEXTURE_VV_BLACK_HEART',	1);