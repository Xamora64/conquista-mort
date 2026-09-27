extends TextureButton

@export var sound_player: AudioStreamPlayer
@export var is_player_choice_button: bool
@export var parentPopupWindow: PopupPanel
@export var nextPopupWindow: PopupPanel
@export var destination_button: TextureButton
@export var destination_label: Label
@export var flow_container: HFlowContainer
@export var game_ui: Node

@export var snippets: Array[AudioStreamOggVorbis]	

func _pressed() -> void:
	sound_player.set_stream(snippets[randi_range(0, snippets.size()-1)])
	sound_player.play()
	parentPopupWindow.hide()
	_populate_next_popup()
	nextPopupWindow.popup()
	game_ui.current_popup=nextPopupWindow

func _populate_next_popup():
	var current_place:Place=game_ui.conquistador.place_in
	
