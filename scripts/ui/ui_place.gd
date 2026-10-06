extends Control

@onready var background: TextureRect = $BackgroundImage

@onready var event_text: Label = %eventText

@onready var tribe_number: Label = %tribeNumber
@onready var tribe_head: TextureRect = %tribeHead
var list_heads = {
	-2: "res://assets/textures/teteIndiens/tribeHead-2.png",
	-1: "res://assets/textures/teteIndiens/tribeHead-1.png",
	0: "res://assets/textures/teteIndiens/tribeHead0.png",
	1: "res://assets/textures/teteIndiens/tribeHead1.png",
	2: "res://assets/textures/teteIndiens/tribeHead2.png",
}

@onready var list_buttons = %ListButtons
@onready var choice_button = %ChoiceButton
@onready var choice_button_text = %ButtonText

func _ready() -> void:
	if (BackgroundData.background_resources.is_empty()):
		return
	background.texture = load(BackgroundData.get_possible_background_resources(BackgroundData.TYPES_BACKGROUND.START).pick_random())

func _process(delta: float) -> void:
	pass
	
func create_scene(tribe: Tribe, event: EventData) -> void:
	print(event_text)
	tribe_head.texture = load(list_heads[tribe.aggression])
	event_text.set_text(event.text)
	tribe_number.set_text("Nombre Indien: " + str(tribe.number))
	

func _on_toggle_ui_place_toggled(toggled_on: bool) -> void:
	if (toggled_on):
		background.hide()
		$HBoxContainer/MarginContainer.hide()
	else:
		background.show()
		$HBoxContainer/MarginContainer.show()
