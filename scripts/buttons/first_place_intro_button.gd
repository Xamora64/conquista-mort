extends TextureButton

@export var sound_player: AudioStreamPlayer
@export var is_player_choice_button: bool
@export var parentPopupWindow: PopupPanel
@export var nextPopupWindow: PopupPanel
@export var descriptionLabel: Label
@export var game_ui: Node
@export var biome_description_label: Label

@export var snippets: Array[AudioStreamOggVorbis]	

func _pressed() -> void:
	sound_player.set_stream(snippets[randi_range(0, snippets.size()-1)])
	sound_player.play()
	parentPopupWindow.hide()
	nextPopupWindow.popup()
	game_ui.current_popup=nextPopupWindow
	var current_place:Place=game_ui.conquistador.place_in
	var event_data=UIManager.get_biome_reaction_place_data(current_place)
	_show_biome_window(event_data, current_place)
	nextPopupWindow.popup()
	game_ui.current_popup=nextPopupWindow
	
func _show_biome_window(event_data: EventData, current_place: Place):
	biome_description_label.set_text(UIManager.fill_place_intro(event_data, current_place))
