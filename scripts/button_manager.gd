extends TextureButton

@export var sound_player: AudioStreamPlayer

func _pressed() -> void:
	sound_player.play()
