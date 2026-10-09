extends Control

var TYPES_TEXT = EventData.TYPES_TEXT
var TYPES_BIOMES = Biomes.TYPES_BIOMES
var TYPES_BACKGROUND = BackgroundData.TYPES_BACKGROUND

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

@onready var list_buttons: HBoxContainer = %ListButtons
@onready var choice_button: TextureColorButton = %ChoiceButton
@onready var choice_button_text: Label = %ButtonText

var tribe_buttons: Dictionary[String, TextureButton] = {
	"Attaque": null,
	"Fuir": null,
	"Accueillir": null,
	
	"Front": null,
	"Guerilla": null,
}

@onready var conquis: Conquistador = get_node("../../Conquistador")
var current_place: Place = null
var tribe: Tribe = null
signal event_finished

func _ready() -> void:
	load_background(TYPES_BACKGROUND.START)
	
	choice_button.hide()
	for button_key: String in tribe_buttons.keys():
		choice_button_text.set_text(button_key)
		tribe_buttons[button_key] = choice_button.duplicate()
		list_buttons.add_child(tribe_buttons[button_key])

func load_background(type: BackgroundData.TYPES_BACKGROUND) -> void:
	if not BackgroundData.background_resources.is_empty():
		background.texture = load(BackgroundData.get_possible_background_resources(type).pick_random().background_path)

# 0 = hide; 1 = intro; 2 = attack
func display_button(type: int):
	for button_key: String in tribe_buttons.keys():
		tribe_buttons[button_key].hide()
		if ((type == 2 && (button_key == "Front" || button_key == "Guerilla")) ||
			(type == 1 && button_key != "Front" && button_key != "Guerilla")):
			tribe_buttons[button_key].show()
	
func create_scene(place: Place, intro: EventData, intro_reaction: EventData) -> void:
	#print(event_text)
	current_place = place
	tribe = place.tribe
	tribe_head.texture = load(list_heads[tribe.aggression])
	event_text.set_text(
		# Intro
		EventData.apply_text_info_event(intro.text, tribe, place.biome)
		+ "\n" +
		# Reaction
		EventData.apply_text_info_event(intro_reaction.text, tribe, place.biome)
	)
	tribe_number.set_text("Population: " + str(tribe.number))
	
	if (tribe.fortification):
		load_background(TYPES_BACKGROUND.TRIBE_FORTIFIED)
	else:
		load_background(TYPES_BACKGROUND.TRIBE)
	
	background.show()
	$HBoxContainer/MarginContainer.show()
	
	display_button(1)

func switch_attack_scene():
	event_text.set_text("Quelle stratégie voulez-vous adopter face aux conquistadors ?")
	display_button(2)

func _on_toggle_ui_place_toggled(toggled_on: bool) -> void:
	if (toggled_on):
		background.hide()
		$HBoxContainer/MarginContainer.hide()
	else:
		background.show()
		$HBoxContainer/MarginContainer.show()

func front_manage() -> String:
	if (tribe.number * 2 > conquis.troops):
		if (tribe.aggression < 0):
			return "a1b"
		else:
			return "a1c"
	else:
		return "a1a"

func guerilla_manage() -> String:
		if (tribe.aggression == -2):
			return "a2a"
		elif (tribe.aggression == -1):
			return "a2b"
		else:
			return "a2c"

func welcome_manage():
	if (tribe.number * 2 > conquis.troops):
		if (tribe.aggression < 0):
			return "b1"
		else:
			return "b2"
	else:
		if (conquis.trust >= 30):
			return "b2"
		else:
			return "b3"

func flee_manage():
	return "c1"

func _on_choice_button_pressed_id(id: String) -> void:
	match(id):
		"Attaque":
			switch_attack_scene()
		"Fuir":
			result_event(flee_manage())
		"Accueillir":
			result_event(welcome_manage())
		"Front":
			result_event(front_manage())
		"Guerilla":
			result_event(guerilla_manage())

func result_event(choice_id: String):
	display_button(0)
	if (choice_id.begins_with("b2")): # Guider
		conquis.lead_by_tribe = true
	else:
		conquis.can_move = true
	
	display_button(0)
	
	var result: EventData = EventData.ask_possible_events(TYPES_TEXT.CHOICE, TYPES_BIOMES.NONE, choice_id).pick_random()
	EventData.calcul_event(result, conquis)
	event_text.set_text(EventData.apply_text_info_event(result.text, current_place.tribe, current_place.biome))
	
	# background Image
	if (choice_id == "a1a"):
		load_background(TYPES_BACKGROUND.LOSING)
	elif (choice_id == "a1b"):
		load_background([TYPES_BACKGROUND.WINNING, TYPES_BACKGROUND.FRONT].pick_random())
	elif (choice_id == "a1c"):
		load_background([TYPES_BACKGROUND.WINNING, TYPES_BACKGROUND.FRONT].pick_random())
	elif (choice_id == "a2a"):
		BackgroundData.get_background_resources("tribe_guerilla00")
	elif (choice_id.begins_with("a2")):
		load_background(TYPES_BACKGROUND.GUERILLA)
