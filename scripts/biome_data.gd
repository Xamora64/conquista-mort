class_name BiomeData
extends Resource

const RESOURCES = [
	"res://resources/biomes/swamp.tres",
	"res://resources/biomes/plain.tres",
	"res://resources/biomes/forest.tres",
]

# SWAMP = 20%, PLAIN = 40%, FOREST = 40%
const WEIGHT = [0.2, 0.4, 0.4]
enum TYPES { SWAMP, PLAIN, FOREST }
@export var type: TYPES = TYPES.PLAIN

# Les effets sur les conquistador
@export var negative = false

# Tout les évents possible dans ce biome
@export var events = Array()

static func generate() -> BiomeData:
	
	# Génération parmis les ressources à partir du poids de chaqu'un
	var random_index = RandomNumberGenerator.new().rand_weighted(WEIGHT)
	var biome = load(RESOURCES[random_index]).duplicate()
	
	return biome
