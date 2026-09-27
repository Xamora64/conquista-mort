extends Node

const TYPES_TEXT = EventData.TYPES_TEXT

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Load Event Data
	EventData.load_folder("res://resources/events/")
	$Conquistador.place_in = $Map.place_start
	
	var event: EventData = EventData.ask_possible_events(TYPES_TEXT.INTRO).pick_random()
	print(EventData.apply_text_info_event(event.text, $Conquistador.place_in.tribe, $Conquistador.place_in.biome))
	
	#Place Conquistador

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_map_click_on_place(place: Place) -> void:
	$Conquistador.place_in = place
