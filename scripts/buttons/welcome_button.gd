extends TextureButton

@export var sound_player: AudioStreamPlayer
@export var is_player_choice_button: bool
@export var parentPopupWindow: PopupPanel
@export var nextPopupWindow: PopupPanel
@export var nextPopupWindowReaction: PopupPanel
@export var destination_reaction: Label
@export var destination_button: TextureButton
@export var destination_label: Label
@export var flow_container: HFlowContainer
@export var game_ui: Node

@export var snippets: Array[AudioStreamOggVorbis]	

func _pressed() -> void:
	sound_player.set_stream(snippets[randi_range(0, snippets.size()-1)])
	sound_player.play()
	parentPopupWindow.hide()
	
	game_ui.current_popup=nextPopupWindow
	var conquis = game_ui.conquistador
	var current_place:Place=conquis.place_in
	
	var wh = _what_happend(current_place.tribe, conquis)
	var event_data = UIManager.get_tribe_choice(current_place, wh)
	EventData.calcul_event(event_data, game_ui.conquistador)

	if (wh == "b2"):
		destination_label.set_text(UIManager.fill_place_intro(event_data, current_place))
		nextPopupWindow.popup()
		game_ui.current_popup=nextPopupWindow
	else:
		destination_reaction.set_text(UIManager.fill_place_intro(event_data, current_place))
		nextPopupWindow.popup()
		game_ui.current_popup=nextPopupWindowReaction
	
func _what_happend(tribe: Tribe, conquis: Conquistador) -> String:
	if (tribe.number * 1.5 > conquis.troops):
		if (tribe.aggression < 0):
			return "b1"
		else:
			return "b2"
	else:
		if (conquis.trust > 30):
			return "b2"
		else:
			return "b3"
