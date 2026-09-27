extends TextureButton

@export var sound_player: AudioStreamPlayer
@export var is_player_choice_button: bool
@export var parentPopupWindow: PopupPanel
@export var nextPopupWindow: PopupPanel
@export var reactionLabel: Label

@export var snippets: Array[AudioStreamOggVorbis]	

func _pressed() -> void:
	sound_player.set_stream(snippets[randi_range(0, snippets.size()-1)])
	sound_player.play()
	parentPopupWindow.hide()
	_populate_next_popup()
	nextPopupWindow.show()

func _populate_next_popup():
	var current_place:Place=get_node("../Conquistador").event_in
	reactionLabel.set_text(current_place.reaction)

	
	
