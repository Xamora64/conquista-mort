class_name BiomeData
extends Resource

# SWAMP = 20%, PLAIN = 40%, FOREST = 40%
const WEIGHT = [0.2, 0.4, 0.4, 0]
const RESOURCES = [
	"res://resources/biomes/swamp.tres",
	"res://resources/biomes/plain.tres",
	"res://resources/biomes/forest.tres",
]

enum TYPES_BIOMES { SWAMP = 0, PLAIN = 1, FOREST = 2, NONE = 3 }
const TYPES_BIOMES_TEXT: Dictionary[TYPES_BIOMES, String] = {
	TYPES_BIOMES.SWAMP: "marais",
	TYPES_BIOMES.PLAIN: "plaine",
	TYPES_BIOMES.FOREST: "fôret",
	TYPES_BIOMES.NONE: "none",
}
@export var type: TYPES_BIOMES = TYPES_BIOMES.NONE

static func create(type: TYPES_BIOMES) -> BiomeData:
	var biome = load(RESOURCES[type]).duplicate()
	return biome

static func generate() -> BiomeData:
	# Génération parmis les ressources à partir du poids de chaqu'unss
	var random_index = RandomNumberGenerator.new().rand_weighted(WEIGHT)
	var biome = load(RESOURCES[random_index]).duplicate()
	
	return biome
