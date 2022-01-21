extends AudioStreamPlayer

func MenuMusicPlay(play):
	var audiostream: AudioStream = preload("res://assets/music/Deal with those Pieces.mp3")
	self.set_stream(audiostream)
	if play:
		self.play()
	else:
		self.stop()
