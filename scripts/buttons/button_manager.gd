extends TextureButton

@export var sound_player: AudioStreamPlayer
@export var is_player_choice_button: bool
@export var parentPopupWindow: PopupPanel


func _pressed() -> void:
	sound_player.play()
	if is_player_choice_button:
		parentPopupWindow.hide()
		
	
	
