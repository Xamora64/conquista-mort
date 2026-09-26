class_name Path
extends Node3D

@export var event_from: Event
@export var event_to: Event

@onready var line: Line2D = $Line2D

func with_values(event_from: Event, event_to: Event):
	self.event_from = event_from
	self.event_to = event_to
	
	return self

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if not is_instance_valid(event_from) or not is_instance_valid(event_to):
		return
	var camera = get_viewport().get_camera_3d()
	line.points = PackedVector2Array([
		camera.unproject_position(event_from.global_position),
		camera.unproject_position(event_to.global_position),
	])
