extends Node

@export var sound_player: AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sound_player.seek(randf() * sound_player.stream.get_length())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
