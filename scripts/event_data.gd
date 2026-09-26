class_name EventData
extends Resource

const RESOURCES: Array = []

# {tribe_name}, {biome_name}
@export var text: String 
enum TYPES_TEXT { INTRO, INTRO_REACTION, CHOICE, EVENT_BIOME, ALL_DEAD}
@export var types_text: TYPES_TEXT # Obligatoire
@export var biome: BiomeData.TYPES_BIOMES # EVENEMENT BIOME: Swamp, Forest, Plain
@export var type_choice: String # CHOICE: a2, b1, ...
@export var aggression: int # INTRO_REACTION: -2, 2

# tribe_number; tribe_aggression; tribe_fortification
# randi_range(1, 3) =? [1, 2, 3]
# c'est une addition
@export var calcul_food: String # -(troops * 0.5)
@export var calcul_troops: String # troops - randi_range(3, 5)
@export var calcul_trust: String # -10
@export var calcul_wealth: String 

static func generate() -> EventData:
	var event_data = RESOURCES.pick_random()
	
	return event_data
