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
	conquistador.event_in.display_event_popup.connect(_display_popup)

func _display_popup(current_event: Place):
	if current_event.tribe!=null:
		_setup_tribe_popup(current_event)
		tribe_event_popup.show()
	else:
		_setup_biome_popup(current_event)
		biome_event_popup.show()
		
func _setup_tribe_popup(current_event: Place):
	tribe_amount_label.set_text(str(current_event.tribe.number))
	#tribe_description_label.set_text(str(current_event.tribe.))
	match current_event.tribe.aggression:
		2:
			tribe_aggression_text_rect.set_texture(aggressive_icon)
		-2:
			tribe_aggression_text_rect.set_texture(welcoming_icon)
		_:
			tribe_aggression_text_rect.set_texture(neutral_icon)

func _setup_biome_popup(current_event: Place):
	current_event.biome.type
	
func _setup_destination_popup(current_event: Place):
	
	
	
	
