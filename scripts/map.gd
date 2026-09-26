class_name Map
extends Node3D

@onready var placeCreator = $MapEventsCreator

@export var place_start: Place
@export var place_end: Place

@export var list_places: Array[Place] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	place_start = placeCreator.create_place(Vector3(7.03, 0, 5.66), 0)
	place_end = placeCreator.create_place(Vector3(-6.41, 0, -3.41), 0)
	
	list_places = placeCreator.create_places(6.8, 5, -6, -3, 80, 0, 0)
	list_places.append(place_start)
	list_places.append(place_end)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
# De Droite à Gauche x: 7.03 => -6.41
# De Bas à haut z: 5.66 => -3.41
# Jamais derrière (Bas - Droite)
static func possible_next_places(place: Place) -> Array[Place]:
	var next_places: Array[Place] = []
	var p_pos = place.position
	for link in place.links:
		var l_pos = link.position
		if (l_pos.x < p_pos.x && 
			l_pos.z < p_pos.z):
			next_places.append(link)
	print(next_places)
	return next_places
