extends TextureButton

@export var sound_player: AudioStreamPlayer
@export var is_player_choice_button: bool
@export var parentPopupWindow: PopupPanel
@export var nextPopupWindow: PopupPanel
@export var descriptionLabel: Label
@export var game_ui: Node
@export var snippets: Array[AudioStreamOggVorbis]	

func _pressed() -> void:
	sound_player.set_stream(snippets[randi_range(0, snippets.size()-1)])
	sound_player.play()
	parentPopupWindow.hide()
	game_ui.guide=true
	var current_place:Place=game_ui.conquistador.place_in
<<<<<<< Updated upstream
	var event_data: EventData
	#var action_type=_determine_action_type(current_place.tribe, game_ui.conquistador)
	#event_data=UIManager.get_guide_result(current_place, action_type[0], action_type[1])
	var action_type=""
	#event_data=UIManager.get_guide_result(current_place, action_type)
	_show_result_window(event_data, current_place)
=======
	var action_type=_determine_action_type(current_place.tribe, game_ui.conquistador)
	var description=UIManager.get_guide_result(current_place, action_type.keys()[0], action_type.values()[0])
	#UIManager.calcul_consequence(event)
	_show_result_window(description)
>>>>>>> Stashed changes
	nextPopupWindow.popup()
	game_ui.current_popup=nextPopupWindow

func _show_result_window(description: String):
	descriptionLabel.set_text(description)
	
func _determine_action_type(tribe: Tribe, conquistador: Conquistador)-> Dictionary[String, EventData.TYPES_TEXT]:
	if tribe.number>= 1.5*conquistador.troops && tribe.aggression==-2:
		return {"b1":EventData.TYPES_TEXT.ALL_DEAD}
	if tribe.number>= 1.5*conquistador.troops && tribe.aggression==-2:
		return {"b1":EventData.TYPES_TEXT.CHOICE}
	if tribe.number>= 1.5*conquistador.troops && tribe.aggression>-2 && conquistador.place_in.tribe != null:
		return {"b2a":EventData.TYPES_TEXT.CHOICE}
	if tribe.number>= 1.5*conquistador.troops && tribe.aggression>-2 && conquistador.place_in.biome.type==EventData.TYPES_BIOMES.PLAIN:
		return {"b2b":EventData.TYPES_TEXT.CHOICE}
	if tribe.number>= 1.5*conquistador.troops && tribe.aggression>-2 && conquistador.place_in.biome.type==EventData.TYPES_BIOMES.SWAMP:
		return {"b2c":EventData.TYPES_TEXT.CHOICE}
	if tribe.number< 1.5*conquistador.troops && conquistador.trust>=30 && conquistador.place_in.biome.type==EventData.TYPES_BIOMES.SWAMP:
		return {"b2":EventData.TYPES_TEXT.CHOICE}
	if tribe.number< 1.5*conquistador.troops && conquistador.trust>=30 && conquistador.place_in.biome.type==EventData.TYPES_BIOMES.PLAIN:
		return {"b2":EventData.TYPES_TEXT.CHOICE}
	if tribe.number< 1.5*conquistador.troops && conquistador.trust<30:
		return {"b3":EventData.TYPES_TEXT.CHOICE}
	return {"":EventData.TYPES_TEXT.CHOICE}
