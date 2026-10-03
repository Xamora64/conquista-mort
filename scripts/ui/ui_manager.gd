extends Node

class_name UIManager


static func get_tribe_intro(place: Place)-> EventData:
	var	place_data: EventData = EventData.ask_possible_events(EventData.TYPES_TEXT.INTRO).pick_random()
	return place_data
	
static func get_guide_result(place: Place, choice: String, type: EventData.TYPES_TEXT)-> String:
	var	place_data: EventData = EventData.ask_possible_events(type, Biomes.TYPES_BIOMES.NONE, choice).pick_random()
	return EventData.apply_text_info_event(place_data.text, place.tribe, place.biome)

static func get_attack_result(place: Place, choice: String, type: EventData.TYPES_TEXT)-> String:
	var	place_data: EventData = EventData.ask_possible_events(type, Biomes.TYPES_BIOMES.NONE, choice).pick_random()
	return EventData.apply_text_info_event(place_data.text, place.tribe, place.biome)

static func get_tribe_reaction_place_data(place: Place)-> EventData:
	var tribe_reaction_data: EventData = EventData.ask_possible_events(EventData.TYPES_TEXT.INTRO_REACTION, 
		EventData.TYPES_BIOMES.NONE, "", place.tribe.aggression).pick_random()
	return tribe_reaction_data

static func get_biome_reaction_place_data(place: Place)-> EventData:
	var biome_reaction_data: EventData= EventData.ask_possible_events(EventData.TYPES_TEXT.EVENT_BIOME, place.biome.type).pick_random()
	return biome_reaction_data
	
# Choice a1, ...
static func get_tribe_choice(place: Place, choice: String)-> EventData:
	var	place_data: EventData = EventData.ask_possible_events(EventData.TYPES_TEXT.CHOICE, Biomes.TYPES_BIOMES.NONE, choice).pick_random()
	return place_data
	
static func fill_place_intro(place_data: EventData, place: Place)-> String:
	var intro_result: String=EventData.apply_text_info_event(place_data.text, place.tribe, place.biome)
	return intro_result
	
static func fill_place_reaction(place_data: EventData, place: Place)-> String:
	var reaction_result: String=EventData.apply_text_info_event(place_data.text, place.tribe, place.biome)
	return reaction_result
	
static func calcul_consequence(event_data: EventData, conquistador: Conquistador):
	EventData.calcul_event(event_data, conquistador)
