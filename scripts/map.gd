extends Node3D

@onready var placeCreator = $MapEventsCreator

@export var place_start: Place
@export var place_end: Place

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	place_start = placeCreator.create_place(Vector3(7.03, 0, 5.66), 0)
	place_end = placeCreator.create_place(Vector3(-6.41, 0, -3.41), 0)
	placeCreator.create_places(6.8, 5, -6, -3, 80, 0, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
