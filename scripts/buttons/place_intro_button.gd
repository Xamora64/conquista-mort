extends TextureButton

@export var sound_player: AudioStreamPlayer
@export var is_player_choice_button: bool
@export var parentPopupWindow: PopupPanel
@export var nextPopupWindowReaction: PopupPanel
@export var nextPopupWindowPlayerChoice: PopupPanel

@export var tribe_aggression_text_rect:TextureRect
@export var tribe_description_label: Label 
@export var tribe_amount_label: Label
@export var aggressive_icon: Texture2D
@export var neutral_icon: Texture2D
@export var welcoming_icon: Texture2D

@export var biome_description_label: Label
@export var biome_illustration: TextureRect
@export var biome_event_popup: PopupPanel

@export var game_ui: Node

@export var snippets: Array[AudioStreamOggVorbis]	

func _pressed() -> void:
	sound_player.set_stream(snippets[randi_range(0, snippets.size()-1)])
	sound_player.play()
	parentPopupWindow.hide()
	var current_place:Place=game_ui.conquistador.place_in
	var event_data: EventData
	if current_place.tribe!=null:
		event_data=UIManager.get_tribe_intro(current_place)
		_show_choice_window(event_data, current_place)
		nextPopupWindowPlayerChoice.popup()
		game_ui.current_popup=nextPopupWindowPlayerChoice
	else:
		event_data=UIManager.get_biome_reaction_place_data(current_place)
		_show_biome_window(event_data, current_place)
		nextPopupWindowReaction.popup()
		game_ui.current_popup=nextPopupWindowReaction
	
func _show_choice_window(event_data: EventData, current_place: Place):
	tribe_amount_label.set_text(str(current_place.tribe.number))
	tribe_description_label.set_text(UIManager.fill_place_intro(event_data, current_place))
	match current_place.tribe.aggression:
		-2:
			tribe_aggression_text_rect.set_texture(aggressive_icon)
		-1:
			tribe_aggression_text_rect.set_texture(aggressive_icon)
		2:
			tribe_aggression_text_rect.set_texture(welcoming_icon)
		1:
			tribe_aggression_text_rect.set_texture(welcoming_icon)
		0:
			tribe_aggression_text_rect.set_texture(neutral_icon)
	
func _show_biome_window(event_data: EventData, current_place: Place):
	biome_description_label.set_text(UIManager.fill_place_intro(event_data, current_place))

	
	
