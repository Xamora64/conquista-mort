extends TextureButton

signal choice_button_pressed(id: String)

func _on_pressed() -> void:
	print(get_children()[0].get_children()[0])
