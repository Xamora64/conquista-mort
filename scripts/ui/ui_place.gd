extends Control

@onready var background = $MarginContainer/VBoxContainer/BackgroundImage

@onready var tribe_number = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/tribeNumber
@onready var tribe_head = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/tribeHead
var list_heads = {
	0: "",
}

@onready var list_buttons = $MarginContainer/VBoxContainer/MarginContainer/ListButtons
@onready var choice_button = $MarginContainer/VBoxContainer/MarginContainer/ListButtons/ChoiceButton
@onready var choice_button_text = $MarginContainer/VBoxContainer/MarginContainer/ListButtons/ChoiceButton/MarginContainer/ButtonText

func _ready() -> void:
	if (BackgroundData.background_resources.is_empty()):
		return
	background.texture = load(BackgroundData.get_possible_background_resources(BackgroundData.TYPES_BACKGROUND.START).pick_random())

func _process(delta: float) -> void:
	pass
	
#func create_scene(tribe: Tribe, event: EventData) -> void:
	#match(tribe.aggression):
		#0:
			#tribe_head.texture = load()
