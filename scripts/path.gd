class_name PathDraw
extends Node3D

@export var place_from: Place
@export var place_to: Place

@onready var line: Line2D = $Line2D

func with_values(place_from: Place, place_to: Place):
	self.place_from = place_from
	self.place_to = place_to
	
	return self

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if not is_instance_valid(place_from) or not is_instance_valid(place_to):
		return
	var camera = get_viewport().get_camera_3d()
	line.points = PackedVector2Array([
		camera.unproject_position(place_from.global_position),
		camera.unproject_position(place_to.global_position),
	])
