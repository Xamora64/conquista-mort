class_name BiomeData
extends Resource

const RESOURCES = [
	"res://resources/biomes/swamp.tres",
	"res://resources/biomes/plain.tres",
	"res://resources/biomes/forest.tres",
]

# SWAMP = 20%, PLAIN = 40%, FOREST = 40%
const WEIGHT = [0.2, 0.4, 0.4]
enum TYPES_BIOMES { SWAMP, PLAIN, FOREST, NONE }
@export var type: TYPES_BIOMES = TYPES_BIOMES.NONE

static func generate() -> BiomeData:
	
	# Génération parmis les ressources à partir du poids de chaqu'un
	var random_index = RandomNumberGenerator.new().rand_weighted(WEIGHT)
	var biome = load(RESOURCES[random_index]).duplicate()
	
	return biome
