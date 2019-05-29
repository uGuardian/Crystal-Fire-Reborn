INSERT INTO IconTextureAtlases 
			(Atlas, 						IconSize, 	Filename, 						IconsPerRow, 	IconsPerColumn)
VALUES		('CIV_COLOR_ATLAS_CLOCHE', 	256, 		'Art/ClocheAtlas256.dds',			4, 				4),
			('CIV_COLOR_ATLAS_CLOCHE', 	128, 		'Art/ClocheAtlas128.dds',			4, 				4),
			('CIV_COLOR_ATLAS_CLOCHE', 	80, 		'Art/ClocheAtlas80.dds',			4, 				4),
			('CIV_COLOR_ATLAS_CLOCHE', 	64, 		'Art/ClocheAtlas64.dds',			4, 				4),
			('CIV_COLOR_ATLAS_CLOCHE', 	45, 		'Art/ClocheAtlas45.dds',			4, 				4),
			('CIV_COLOR_ATLAS_CLOCHE', 	32, 		'Art/ClocheAtlas32.dds',			4, 				4),
			('CLOCHE_CIV_ALPHA_ATLAS', 	128, 		'Art/ClocheAlpha128.dds',			1, 				1),
			('CLOCHE_CIV_ALPHA_ATLAS', 	64, 		'Art/ClocheAlpha64.dds',			1, 				1),
			('CLOCHE_CIV_ALPHA_ATLAS', 	48, 		'Art/ClocheAlpha48.dds',			1, 				1),
			('CLOCHE_CIV_ALPHA_ATLAS', 	32, 		'Art/ClocheAlpha32.dds',			1, 				1),
			('CLOCHE_CIV_ALPHA_ATLAS', 	24, 		'Art/ClocheAlpha24.dds',			1, 				1),
			('CLOCHE_CIV_ALPHA_ATLAS', 	16, 		'Art/ClocheAlpha16.dds',			1, 				1),
			('RELIGION_ATLAS_CLOCHE_AQUA', 	128, 		'Art/ClocheAlpha128.dds',	1, 				1),
			('RELIGION_ATLAS_CLOCHE_AQUA', 	80, 		'Art/ClocheAlpha80.dds',	1, 				1),
			('RELIGION_ATLAS_CLOCHE_AQUA', 	64, 		'Art/ClocheAlpha64.dds',	1, 				1),
			('RELIGION_ATLAS_CLOCHE_AQUA', 	48, 		'Art/ClocheAlpha48.dds',	1, 				1),
			('RELIGION_ATLAS_CLOCHE_AQUA', 	32, 		'Art/ClocheAlpha32.dds',	1, 				1),
			('RELIGION_ATLAS_CLOCHE_AQUA', 	24, 		'Art/ClocheAlpha24.dds',	1, 				1),
			('CLOCHE_FLAG_ATLAS', 	        32, 		'ART/ClocheFlag.dds',	    1, 				1),
			('RELIGION_ATLAS_CLOCHE_AQUA', 	16, 		'Art/ClocheAlpha16.dds',	1, 				1);


INSERT INTO IconFontTextures
			(IconFontTexture,						IconFontTextureFile)
VALUES		('ICON_FONT_TEXTURE_CLOCHE_AQUA',	'Art/ClocheAquaReligionFont');

INSERT INTO IconFontMapping
			(IconName,							IconFontTexture,					IconMapping)
VALUES		('ICON_CLOCHE_AQUA_RELIGION',	'ICON_FONT_TEXTURE_CLOCHE_AQUA',	1);
