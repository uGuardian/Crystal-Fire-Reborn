INSERT INTO Audio_Sounds
			(SoundID,									Filename,				LoadType)
VALUES		('SND_LEADER_MUSIC_FUNNY_VALENTINE_WAR',	'FunnyValentineWar',	'Streamed');

INSERT INTO Audio_2DSounds
			(ScriptID,									SoundID,
			SoundType,			MaxVolume,	MinVolume,	IsMusic)
VALUES		('AS2D_LEADER_MUSIC_FUNNY_VALENTINE_PEACE',	'SND_LEADER_MUSIC_WASHINGTON_PEACE',
			'GAME_MUSIC',		40,			40,			1),
			('AS2D_LEADER_MUSIC_FUNNY_VALENTINE_WAR',	'SND_LEADER_MUSIC_FUNNY_VALENTINE_WAR',
			'GAME_MUSIC',		50,			50,			1);
