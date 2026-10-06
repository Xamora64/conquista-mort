class_name Main
extends Node

const TYPES_TEXT = EventData.TYPES_TEXT
const TYPES_BIOMES = Biomes.TYPES_BIOMES

const place_scene: PackedScene = preload("res://scenes/place.tscn")

# 0 = Main Menu; 1 = In Game; 2 = 
@export var state_game: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Load Event Data
	EventData.event_resources.assign(LibResources.load_folder("res://resources/events/"))
	BackgroundData.background_resources.assign(LibResources.load_folder("res://resources/backgrounds/"))

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

func going_in_place(place_to: Place):
	
	var place_from: Place = $Conquistador.place_in
	#Animation
	$Conquistador.place_to = place_to
	$Conquistador.moving = true
	await($Conquistador.finish_moving)
	print($Conquistador.moving)
	
	if (place_to.tribe != null):
		tribe_place(place_to)
	else:
		biome_place(place_to)

func tribe_place(place: Place):
	var tribe: Tribe = place.tribe
	var event_data: EventData = EventData.ask_possible_events(TYPES_TEXT.INTRO, TYPES_BIOMES.NONE, "", 0).pick_random()
	# Set value in UIGame
	$UIGame/UIPlaceTribe.create_scene(tribe, event_data)
	
	# Player zoom in the event + Fade
	# When Black screen => UI GAME show
	# Black screen fade out
	$UIGame.show()

	
func biome_place(place: Place):
	var event_data: EventData = EventData.ask_possible_events(TYPES_TEXT.EVENT_BIOME, place.biome).pick_random()
