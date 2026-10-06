class_name ToggleColorButton
extends TextureButton

@export var normal_color := Color.WHITE
@export var hover_color := Color(1.15, 1.15, 1.15)
@export var pressed_color := Color(0.6, 0.6, 0.6)
@export var hover_pressed_color := Color(0.7, 0.7, 0.7)
@export var disabled_color := Color(0.5, 0.5, 0.5, 0.6)

func _ready() -> void:
	for sig in [mouse_entered, mouse_exited, toggled, button_down, button_up]:
		sig.connect(update_color)
	update_color()

func update_color() -> void:
	match get_draw_mode():
		DRAW_NORMAL:
			self_modulate = normal_color
		DRAW_HOVER:
			self_modulate = hover_color
		DRAW_PRESSED:
			self_modulate = pressed_color
		DRAW_HOVER_PRESSED:
			self_modulate = hover_pressed_color
		DRAW_DISABLED:
			self_modulate = disabled_color
