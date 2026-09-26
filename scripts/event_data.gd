class_name EventData
extends Resource

static var event_resources: Array[EventData]

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
	var event_data = event_resources.pick_random()
	
	return event_data

static func load_folder(path: String):
	for file in ResourceLoader.list_directory(path):
		var new_path = path + file
		if (file.ends_with("/")):
			load_folder(new_path)
		else:
			event_resources.append(load(new_path).duplicate())

static func calcul_event(event: EventData):
	#event.calcul_food
	#event.calcul_troops
	#event.calcul_trust
	#event.calcul_wealth
	pass
