extends Control


onready var changeSceneTween = $ChangeSceneTween
onready var connectingTimer = $ConnectingTimer
onready var loading_img = $Loading
onready var message = $Message

var faded_in = false
var connection_attempts = 0
var join_attempted = false
var config: ConfigFile


func _ready():
	$ConfirmationDialog.get_cancel().connect("pressed", self, "download")
	$ConfirmationDialog.get_ok().connect("pressed", self, "close")
	
	# on startup, check if is first launch
	config = ConfigFile.new()
	var err = config.load("user://settings.cfg")
	if err == OK:
		var show_popup = config.get_value("startup", "show_popup", true)
		# show the popup if `show_popup` is true
	else:
		# couldn't load config file, show the popup
		$ConfirmationDialog.get_ok().text = "Play!"
		$ConfirmationDialog.get_cancel().text = "Download!"
		$ConfirmationDialog.popup()
	
	ProjectSettings.set("input_devices/pointing/ios/touch_delay", 0)

	if Client.disconnecting == true:
		message.display_message("Disconnected...", true, 2, 2)
	Client.disconnecting = false

	for child in self.get_children():
		if child.get('modulate') and child != $BackgroundTextureRect and child != message:
			child.set_modulate(Color(1,1,1,0))
			changeSceneTween.interpolate_property(child, 'modulate', 
			Color(1,1,1,0), Color(1,1,1,1), 0.5,
			Tween.TRANS_SINE, Tween.EASE_IN_OUT)

	changeSceneTween.start()


func _on_ConnectButton_pressed():
	UdpBroadcast.get_server_ip()
	connectingTimer.start()
	message.display_message("Connecting...", false)
	loading_img.start()
	$ConnectButton.hide()
	$CancelButton.show()


func _on_ConnectingTimer_timeout():
	if connection_attempts < 30:
		connection_attempts += 1
		
		if Client.connected:
			$CancelButton.hide()
			connection_attempts = 0
			connectingTimer.stop()
			message.display_message('Connected!')
			change_scene()

	else:
		message.display_message('No Server Found', true, 2, 2)
		connection_attempts = 0
		connectingTimer.stop()
		loading_img.stop()
		UdpBroadcast.stop_broadcast()
		$CancelButton.hide()		
		$ConnectButton.show()


func change_scene():
	for child in self.get_children():
		if child.get('modulate') and child != $BackgroundTextureRect:
			changeSceneTween.interpolate_property(child, 'modulate', 
			child.modulate, Color(1,1,1,0), 0.5,
			Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	changeSceneTween.start()

func _on_ChangeSceneTween_tween_all_completed():
	if faded_in:
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://GamePad/GamePad.tscn")
	faded_in = true


func _on_CancelButton_pressed():
	$CancelButton.hide()
	$ConnectButton.show()
	connection_attempts = 0
	connectingTimer.stop()
	loading_img.stop()
	UdpBroadcast.stop_broadcast()
	message.display_message("Cancelled...", true, 2, 2)

func download():
	 OS.shell_open("https://github.com/codemonsters/racekombat/releases") 

func close():
	config.set_value("startup", "show_popup", false)
	config.save("user://settings.cfg")
