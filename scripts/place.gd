class_name Place
extends Area3D

const NEAREST_LIMIT = 0.5
const LINKS_LIMIT = Vector2(3, 4)

@export var biome: BiomeData
@export var tribe: Tribe
@export var links: Array[Place] = []
@export var links_limit: = 3

func with_values(position: Vector3, biome: BiomeData, tribe: Tribe, links: Array[Place], links_limit: int) -> Place:
	self.position = position
	self.biome = biome
	self.tribe = tribe
	self.links = links
	self.links_limit = links_limit
	return self

signal display_event_popup()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if (event.is_action_pressed("left click")):
		print("event selectioned: ", position.x, " ", position.y, " ", position.z)
