class_name Place
extends Area3D

const NEAREST_LIMIT = 0.6
const LINKS_LIMIT = Vector2(4, 5)
@export var biome: BiomeData = null

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
	var color: Color = Color.WHITE
	if (biome.type == BiomeData.TYPES_BIOMES.PLAIN):
		color = Color.YELLOW
	elif (biome.type == BiomeData.TYPES_BIOMES.FOREST):
		color = Color.DARK_GREEN
	elif (biome.type == BiomeData.TYPES_BIOMES.SWAMP):
		color = Color.RED
	
	# Permet de définir un material par sphere
	var mat = $CSGSphere3D.material.duplicate()
	mat.albedo_color = color
	$CSGSphere3D.material_override = mat
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
