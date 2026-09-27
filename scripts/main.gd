extends Node

const TYPES_TEXT = EventData.TYPES_TEXT
const TYPES_BIOMES = BiomeData.TYPES_BIOMES

const place_scene: PackedScene = preload("res://scenes/place.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Load Event Data
	EventData.load_folder("res://resources/events/")
	$Conquistador.place_in = $Map.place_start
		
	#Place Conquistador

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_map_click_on_place(place: Place) -> void:
	$Conquistador.place_in = place
