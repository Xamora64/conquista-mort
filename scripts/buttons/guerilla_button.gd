extends TextureButton

@export var sound_player: AudioStreamPlayer
@export var is_player_choice_button: bool
@export var parentPopupWindow: PopupPanel
@export var nextPopupWindow: PopupPanel
@export var snippets: Array[AudioStreamOggVorbis]	
@export var descriptionLabel: Label
@export var game_ui: Node

func _pressed() -> void:
	sound_player.set_stream(snippets[randi_range(0, snippets.size()-1)])
	sound_player.play()
	parentPopupWindow.hide()
	var current_place:Place=game_ui.conquistador.place_in
	
	var wh =  _what_happend(current_place.tribe)
	var event_data = UIManager.get_tribe_choice(current_place, wh)
	#print(event_data.text)
	EventData.calcul_event(event_data, game_ui.conquistador)

	descriptionLabel.set_text(UIManager.fill_place_intro(event_data, current_place))
	nextPopupWindow.popup()
	game_ui.current_popup=nextPopupWindow
	
func _what_happend(tribe: Tribe) -> String:
	if (tribe.aggression == -2):
		return "a2a"
	elif (tribe.aggression == -1):
		return "a2b"
	else:
		return "a2c"
	
	
