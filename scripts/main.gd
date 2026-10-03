extends Node

const TYPES_TEXT = EventData.TYPES_TEXT
const TYPES_BIOMES = Biomes.TYPES_BIOMES

const place_scene: PackedScene = preload("res://scenes/place.tscn")

# 0 = Main Menu; 1 = In Game; 2 = 
@export var state_game: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Load Event Data
	LibResources.load_folder("res://resources/events/")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_map_click_on_place(place: Place) -> void:
	$Conquistador.place_in = place
	
func start_game():
	UIFade.transition()
	await UIFade.on_transition_finished
	
	state_game = 1
	$Conquistador.init($Map.place_start)
	
	$UIMainMenu.hide()
	$HUD.show()
	$Player.start_game_camera()
