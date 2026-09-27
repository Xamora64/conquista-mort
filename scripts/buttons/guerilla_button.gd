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
	nextPopupWindow.popup()
	game_ui.current_popup=nextPopupWindow
	
func _populate_next_popup():
	var current_place:Place=get_node("../Conquistador").event_in
	descriptionLabel.set_text(current_place.reaction)
	
	
