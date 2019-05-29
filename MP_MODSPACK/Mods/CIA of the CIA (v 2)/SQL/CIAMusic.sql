INSERT INTO Audio_Sounds
			(SoundID,									Filename,				LoadType)
VALUES		('SND_LEADER_MUSIC_VV_BILL_WILSON_PEACE',	'VVCIAPeace',			'Streamed'),
			('SND_LEADER_MUSIC_VV_BILL_WILSON_WAR',		'VVCIAWar',				'Streamed'),
			('SND_SELECT_VV_HOTHEAD',					'CIAHotheadSelect',		'DynamicResident'),
			('SND_DELETE_VV_HOTHEAD',					'CIAHotheadOuttaHere',	'DynamicResident');

INSERT INTO Audio_2DSounds
			(ScriptID,									SoundID,
			SoundType,			MaxVolume,	MinVolume,	IsMusic)
VALUES		('AS2D_LEADER_MUSIC_VV_BILL_WILSON_PEACE',			'SND_LEADER_MUSIC_VV_BILL_WILSON_PEACE',
			'GAME_MUSIC',		50,			50,			1),
			('AS2D_LEADER_MUSIC_VV_BILL_WILSON_WAR',			'SND_LEADER_MUSIC_VV_BILL_WILSON_WAR',
			'GAME_MUSIC',		50,			50,			1),
			('AS2D_SELECT_VV_HOTHEAD',					'SND_SELECT_VV_HOTHEAD',
			'GAME_SFX',			100,		100,			0),
			('AS2D_DELETE_VV_HOTHEAD',					'SND_DELETE_VV_HOTHEAD',
			'GAME_SFX',			100,			100,			0);


