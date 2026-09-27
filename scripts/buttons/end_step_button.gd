extends TextureButton

@export var sound_player: AudioStreamPlayer
@export var is_player_choice_button: bool
@export var parentPopupWindow: PopupPanel
@export var nextPopupWindowIntro: PopupPanel
@export var nextPopupWindowBiome: PopupPanel
@export var descriptionLabel: Label
@export var game_ui: Node
@export var snippets: Array[AudioStreamOggVorbis]

func _pressed() -> void:
	sound_player.set_stream(snippets[randi_range(0, snippets.size() - 1)])
	sound_player.play()
	parentPopupWindow.hide()
	_populate_next_popup()
	
func _populate_next_popup():
	
	var next_place: Place = game_ui.conquistador.next_link.place
	game_ui.map.conquis_next_place(next_place)
	if (next_place.tribe != null):
		nextPopupWindowIntro.popup()
		game_ui.current_popup = nextPopupWindowIntro
	else:
		nextPopupWindowBiome.popup()
		game_ui.current_popup = nextPopupWindowBiome
		#game_ui.current_popup = 
	#var current_place:Place=game_ui.conquistador.place_in
	#descriptionLabel.set_text(current_place.reaction)

	
	
