class_name EventData
extends Resource

static var event_resources: Array[EventData]
const TYPES_BIOMES = BiomeData.TYPES_BIOMES
const TYPES_BIOMES_TEXT = BiomeData.TYPES_BIOMES_TEXT

# {tribe_name}, {biome_name}
@export var text: String 
enum TYPES_TEXT { INTRO, INTRO_REACTION, CHOICE, EVENT_BIOME, ALL_DEAD}
@export var types_text: TYPES_TEXT # Obligatoire
@export var biome: TYPES_BIOMES = TYPES_BIOMES.NONE# EVENEMENT BIOME: Swamp, Forest, Plain
@export var type_choice: String  = ""# CHOICE: a2, b1, ...
@export var aggression: int = 0# INTRO_REACTION: -2, 2

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

static func load_folder(path: String) -> Array[EventData]:
	for file in ResourceLoader.list_directory(path):
		var new_path = path + file
		if (file.ends_with("/")):
			load_folder(new_path)
		else:
			event_resources.append(load(new_path).duplicate())
	return event_resources

# Return the list of valid resources
static func ask_possible_events(type_text: TYPES_TEXT,
							  biome: TYPES_BIOMES = TYPES_BIOMES.NONE, 
							  type_choice: String = "", 
							  aggression: int = 0) -> Array[EventData]:
	var list_possible_events: Array[EventData] = []
	for event in event_resources:
		if (event.types_text == type_text &&
			event.biome == biome &&
			event.type_choice == type_choice &&
			event.aggression == aggression
		):
			list_possible_events.append(event)
	#print(list_possible_events.size())
	return list_possible_events

# {tribe_name}, {biome_name}
static func apply_text_info_event(text_event: String, tribe: Tribe = null, biome: BiomeData = null) -> String:
	var replace: Dictionary[String, String] = {}
	if (tribe != null):
		replace["tribe_name"] = tribe.tribe_name
	replace["biome_name"] = TYPES_BIOMES_TEXT[biome.type]
	return text_event.format(replace)

static var expression = Expression.new()

# replace food, troops, trust, wealth
static func calcul_event(event: EventData, conquis: Conquistador):
	var to_replace = {
		"food": conquis.food,
		"troops": conquis.troops,
		"trust": conquis.trust,
		"wealth": conquis.wealth
	}
	print(event.calcul_food)
	if (not event.calcul_food.is_empty()):
		if expression.parse(event.calcul_food, to_replace.keys()) != OK: 
			print("ERROR CALCUL FOOD")
			return
		conquis.food += expression.execute(to_replace.values())
	if (not event.calcul_troops.is_empty()):
		if expression.parse(event.calcul_troops, to_replace.keys()) != OK: 
			print("ERROR CALCUL TROOPS")
			return
		conquis.troops += expression.execute(to_replace.values())
	if (not event.calcul_trust.is_empty()):
		if expression.parse(event.calcul_trust, to_replace.keys()) != OK: 
			print("ERROR CALCUL TRUST")
			return
		conquis.trust = expression.execute(to_replace.values())
	if (not event.calcul_wealth.is_empty()):
		if expression.parse(event.calcul_wealth, to_replace.keys()) != OK: 
			print("ERROR CALCUL WEALTH")
			return
		conquis.wealth = expression.execute(to_replace.values())
