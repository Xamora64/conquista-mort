class_name Place
extends Area3D

const NEAREST_LIMIT = 0.6
const LINKS_LIMIT = Vector2(4, 5)
@export var biome: BiomeData = null

@export var node3d_plain_tribe: Node3D
@export var node3d_plain: Node3D
@export var node3d_forest_tribe: Node3D
@export var node3d_forest: Node3D
@export var node3d_swamp: Node3D
@export var node3d_fortification: Node3D
var current: Node3D = node3d_plain
#var array_node3d: Array[Node3D] = [
	#node3d_plain_tribe,
	#node3d_plain,
	#node3d_forest_tribu,
	#node3d_swamp,
	#node3d_fortification
#]

@export var tribe: Tribe = null
@export var links_limit: = 3
@export var start: bool = false
@export var end: bool = false

var links: Array[Link] = []

class Link:
	var place: Place
	var path_draw: PathDraw
	var distance: int
	var taken: bool = false
	
	func _init(place: Place, path_draw: PathDraw = null, distance: int = 0) -> void:
		self.place = place
		self.path_draw = path_draw
		self.distance = distance

func with_values(position: Vector3, biome: BiomeData, tribe: Tribe, links: Array[Link], links_limit: int) -> Place:
	self.position = position
	self.biome = biome
	self.tribe = tribe
	self.links = links
	self.links_limit = links_limit
	return self

signal display_event_popup()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current = node3d_plain
	if (tribe != null):
		if (tribe.fortification):
			current = node3d_fortification
		elif (biome.type == biome.TYPES_BIOMES.PLAIN):
			current = node3d_plain_tribe
		elif (biome.type == biome.TYPES_BIOMES.FOREST):
			current = node3d_forest_tribe
	else:
		if (biome.type == biome.TYPES_BIOMES.PLAIN):
			current = node3d_plain
		elif (biome.type == biome.TYPES_BIOMES.FOREST):
			current = node3d_forest
		elif (biome.type == biome.TYPES_BIOMES.SWAMP):
			current = node3d_swamp
	if (current != null):
		current.set_visible(true)
		current.rotate_y(randf_range(0, 360))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
