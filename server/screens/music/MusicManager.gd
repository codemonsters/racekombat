extends AudioStreamPlayer

var waitingRoomLoaded = false


func WaitingRoomMusicPlay():
	self.stop()
	waitingRoomLoaded = true
	self.bus = "Muffled"
	
func UnmuffleMusic():
	self.bus = "Master"

func _process(_delta):
	if (waitingRoomLoaded):
		if (self.playing == false):
			var audiostream2: AudioStream = preload("res://assets/music/entero_loop1.mp3")
			self.set_stream(audiostream2)
			self.play()


func MenuMusicPlay():
	var audiostream: AudioStream = preload("res://assets/music/Deal with those Pieces.mp3")
	self.bus = "Master"
	self.pitch_scale = 1
	self.set_stream(audiostream)
	self.play()

