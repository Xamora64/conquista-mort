extends TextureButton

@export var backgroundMusic: AudioStreamPlayer
@export var gameOverMusic: AudioStreamOggVorbis


func _pressed()->void:
	get_tree().reload_current_scene()
