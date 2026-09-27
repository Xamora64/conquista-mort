extends TextureButton

@export var game_ui: Node

func _pressed() -> void:
	game_ui.current_popup.popup()
		
