extends AudioStreamPlayer

var waitingRoomLoaded = false


func WaitingRoomMusicPlay():
	waitingRoomLoaded = true
	var audiostream: AudioStream = preload("res://assets/music/entero1.mp3")
	self.set_stream(audiostream)
	self.volume_db = -3
	self.play()


func _process(_delta):
	if (waitingRoomLoaded):
		#print(self.playing) #Esto daba output overflow
		if (self.playing == false):
			var audiostream2: AudioStream = preload("res://assets/music/entero_loop1.mp3")
			self.set_stream(audiostream2)
			self.play()


func MenuMusicPlay(play):
	var audiostream: AudioStream = preload("res://assets/music/Deal with those Pieces.mp3")
	self.set_stream(audiostream)
	if play:
		self.play()
	else:
		self.stop()

