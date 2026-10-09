class_name Place
extends Area3D

const NEAREST_LIMIT = 0.6
const LINKS_LIMIT = Vector2(4, 5)
@export var biome: Biomes.TYPES_BIOMES = Biomes.TYPES_BIOMES.NONE

@export var node3d_plain_tribe: Node3D
@export var node3d_plain: Node3D
@export var node3d_forest_tribe: Node3D
@export var node3d_forest: Node3D
@export var node3d_swamp: Node3D
@export var node3d_fortification: Node3D
var current: Node3D = node3d_plain

@export var tribe: Tribe = null
@export var links_limit: = 3
@export var start: bool = false
@export var end: bool = false

var is_focus: bool = false
@export var focus_material: Material
@export var hover_material: Material

var conquis: Conquistador

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

func with_values(position: Vector3, biome: Biomes.TYPES_BIOMES, tribe: Tribe, links: Array[Link], links_limit: int) -> Place:
	self.position = position
	self.biome = biome
	self.tribe = tribe
	self.links = links
	self.links_limit = links_limit
	return self

signal display_event_popup()

func _ready() -> void:
	current = node3d_plain
	if (tribe != null):
		if (tribe.fortification):
			current = node3d_fortification
		elif (biome == Biomes.TYPES_BIOMES.PLAIN):
			current = node3d_plain_tribe
		elif (biome == Biomes.TYPES_BIOMES.FOREST):
			current = node3d_forest_tribe
	else:
		if (biome == Biomes.TYPES_BIOMES.PLAIN):
			current = node3d_plain
		elif (biome == Biomes.TYPES_BIOMES.FOREST):
			current = node3d_forest
		elif (biome == Biomes.TYPES_BIOMES.SWAMP):
			current = node3d_swamp
	if (current != null):
		current.set_visible(true)
		current.rotate_y(randf_range(0, 360))

func apply_border():
	for mesh in find_children("*", "MeshInstance3D", true, false):
		mesh.material_overlay = focus_material

func remove_material():
	is_focus = false
	for mesh in find_children("*", "MeshInstance3D", true, false):
		mesh.material_overlay = null

func _on_mouse_entered() -> void:
	if (is_focus):
		current.scale += Vector3(0.025, 0.025, 0.025)
		for mesh in current.find_children("*", "MeshInstance3D", true, false):
			mesh.material_overlay = hover_material

func _on_mouse_exited() -> void:
	if (is_focus):
		current.scale -= Vector3(0.025, 0.025, 0.025)
		apply_border()
	else:
		remove_material()
