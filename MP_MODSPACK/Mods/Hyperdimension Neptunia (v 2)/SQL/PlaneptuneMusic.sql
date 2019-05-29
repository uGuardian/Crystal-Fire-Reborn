INSERT INTO Audio_Sounds
			(SoundID,									Filename,			LoadType)
VALUES		('SND_LEADER_MUSIC_VV_NEPTUNE_PEACE',		'VVNeptunePeace',	'Streamed'),
			('SND_LEADER_MUSIC_VV_NEPTUNE_WAR',			'VVNeptuneWar',		'Streamed');

INSERT INTO Audio_2DSounds
			(ScriptID,									SoundID,
			SoundType,			MaxVolume,	MinVolume,	IsMusic)
VALUES		('AS2D_LEADER_MUSIC_VV_NEPTUNE_PEACE',		'SND_LEADER_MUSIC_VV_NEPTUNE_PEACE',
			'GAME_MUSIC',		50,			50,			1),
			('AS2D_LEADER_MUSIC_VV_NEPTUNE_WAR',		'SND_LEADER_MUSIC_VV_NEPTUNE_WAR',
			'GAME_MUSIC',		50,			50,			1),
			('AS2D_LEADER_MUSIC_VV_PURPLE_HEART_PEACE','SND_LEADER_MUSIC_VV_NEPTUNE_PEACE',
			'GAME_MUSIC',		50,			50,			1),
			('AS2D_LEADER_MUSIC_VV_PURPLE_HEART_WAR',	'SND_LEADER_MUSIC_VV_NEPTUNE_WAR',
			'GAME_MUSIC',		50,			50,			1);


