class_name Map
extends Node3D

@onready var placeCreator = $MapEventsCreator

@export var place_start: Place
@export var place_end: Place

@export var list_places: Array[Place] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	place_start = placeCreator.init_place(Vector3(7.03, 0, 5.66), 0)
	place_end = placeCreator.init_place(Vector3(-6.41, 0, -3.41), 0)
	
	list_places = placeCreator.init_places(6.8, 5, -6, -3, 98, 0, 0)
	list_places.append(place_start)
	list_places.append(place_end)
	placeCreator.add_link_path_places(list_places)
	for place in list_places:
		place.input_event.connect(_on_input_event.bind(place))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
signal click_on_place(place: Place)

func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int, place: Place) -> void:
	if (event.is_action_pressed("left click")):
		print("event selectioned: ", position.x, " ", position.y, " ", position.z)
		possible_next_places(place)
	
# De Droite à Gauche x: 7.03 => -6.41
# De Bas à haut z: 5.66 => -3.41
# Jamais derrière (Bas - Droite)
func possible_next_places(place: Place) -> Array[Place]:
	var next_places: Array[Place] = []
	var p_pos = place.position
	for link in place.links:
		var l_pos = link.place.position
		if (l_pos.x < p_pos.x || 
			l_pos.z < p_pos.z):
			next_places.append(link.place)
	print(next_places.size())
	click_on_place.emit(place)
	return next_places
