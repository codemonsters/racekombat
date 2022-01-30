extends AudioStreamPlayer

var waitingRoomLoaded = false

func WaitingRoomMusicPlay():
	waitingRoomLoaded = true
	var audiostream: AudioStream = preload("res://assets/music/entero1.wav")
	self.set_stream(audiostream)
	self.volume_db = -3
	self.play()

func _process(_delta):
	if (waitingRoomLoaded):
		#print(self.playing) #Esto daba output overflow
		if (self.playing == false):
			var audiostream2: AudioStream = preload("res://assets/music/entero_loop1.wav")
			self.set_stream(audiostream2)
			self.play()
			
