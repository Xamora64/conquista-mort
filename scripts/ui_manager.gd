extends Node

@export var conquistador: Node3D
@export var tribe_event_popup: PopupPanel
@export var tribe_aggression_text_rect:TextureRect
@export var tribe_description_label: Label 
@export var tribe_amount_label: Label
@export var aggressive_icon: Texture2D
@export var neutral_icon: Texture2D
@export var welcoming_icon: Texture2D
 
@export var biome_description_label: Label
@export var biome_illustration: TextureRect
@export var biome_event_popup: PopupPanel

@export var destination_choice_popup: PopupPanel
@export var destination_choices_container: HFlowContainer
@export var destination_description: Label

@export var simple_reaction_popup: PopupPanel
@export var reaction_illustration: TextureRect
@export var reaction_description: Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass#conquistador.event_in.display_event_popup.connect(_display_popup)

func _display_popup(current_place: Place):
	if current_place.tribe!=null:
		_setup_tribe_popup(current_place)
		tribe_event_popup.show()
	else:
		_setup_biome_popup(current_place)
		biome_event_popup.show()
		
func _setup_tribe_popup(current_place: Place):
	tribe_amount_label.set_text(str(current_place.tribe.number))
	#tribe_description_label.set_text(str(current_place.tribe.))
	match current_place.tribe.aggression:
		2:
			tribe_aggression_text_rect.set_texture(welcoming_icon)
		-2:
			tribe_aggression_text_rect.set_texture(aggressive_icon)
		_:
			tribe_aggression_text_rect.set_texture(neutral_icon)

func _setup_biome_popup(current_place: Place):
	current_place.biome.type
	
#func _setup_destination_popup(current_place: Place):
	
	
	
	
