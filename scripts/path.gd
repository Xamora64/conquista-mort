extends Node3D

@export var event_from: Event
@export var event_to: Event

func with_values(event_from: Event, event_to: Event):
	self.event_from = event_from
	self.event_to = event_to
	var position_from = event_from.position
	var position_to = event_to.position
	
	$Line2D.add_point(Vector2(position_from.x, position_from.z), Vector2(position_to.x, position_to.z))
	
	return self

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
