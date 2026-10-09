extends Button

func _on_mouse_entered() -> void:
	self.remove_theme_constant_override("outline_size")

func _on_mouse_exited() -> void:
	self.add_theme_constant_override("outline_size", 0)

func _on_button_down() -> void:
	self.add_theme_color_override("font_outline_color", Color.DARK_GRAY)

func _on_button_up() -> void:
	self.remove_theme_color_override("font_outline_color")
