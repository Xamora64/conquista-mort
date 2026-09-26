class_name Event
extends Area3D

const NEAREST_LIMIT = 0.5
const LINKS_LIMIT = Vector2(3, 4)

@export var biome: BiomeData
@export var indian: Indian
@export var links: Array[Event] = []
@export var links_limit: = 3

func with_values(position: Vector3, biome: BiomeData, indian: Indian, links: Array[Event], links_limit: int) -> Event:
	self.position = position
	self.biome = biome
	self.indian = indian
	self.links = links
	self.links_limit = links_limit
	return self

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if (event.is_action_pressed("left click")):
		print("event selectioned: ", position.x, " ", position.y, " ", position.z)
