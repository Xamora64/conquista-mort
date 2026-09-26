class_name BiomeData
extends Resource

const RESOURCES = [
	"res://resources/swamp.tres",
	"res://resources/plain.tres",
	"res://resources/forest.tres",
]

# SWAMP = 20%, PLAIN = 40%, FOREST = 40%
const WEIGHT = [0.2, 0.4, 0.4]
enum TYPES { SWAMP, PLAIN, FOREST }
@export var type = TYPES.PLAIN

# Les effets sur les conquistador
@export var negative = false

# Tout les évents possible dans ce biome
@export var events = Array()

static func generate() -> BiomeData:
	
	# Génération parmis les ressources à partir du poids de chaqu'un
	var random_index = RandomNumberGenerator.new().rand_weighted(WEIGHT)
	var biome = load(RESOURCES[random_index]).duplicate()
	
	return biome
