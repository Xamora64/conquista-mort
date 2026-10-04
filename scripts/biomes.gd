class_name Biomes

# SWAMP = 20%, FOREST = 40%, PLAIN = 40%
const WEIGHT = [0.2, 0.4, 0.4]
enum TYPES_BIOMES { SWAMP = 0, FOREST = 1, PLAIN = 2, NONE = 3 }
const TYPES_BIOMES_TEXT: Dictionary[TYPES_BIOMES, String] = {
	TYPES_BIOMES.SWAMP: "marais",
	TYPES_BIOMES.PLAIN: "plaine",
	TYPES_BIOMES.FOREST: "fôret",
	TYPES_BIOMES.NONE: "none",
}
@export var type: TYPES_BIOMES = TYPES_BIOMES.NONE

static func generate() -> TYPES_BIOMES:
	# Génération parmis les ressources à partir du poids de chaqu'unss
	var random_index = RandomNumberGenerator.new().rand_weighted(WEIGHT)
	var biome = random_index as TYPES_BIOMES
	return biome
