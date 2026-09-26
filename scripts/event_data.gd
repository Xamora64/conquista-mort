class_name EventData
extends Resource

const RESOURCES = [
	
]

@export var text: String 
@export var aggression: int # -2, 2
@export var intro: bool
@export var reaction: bool # reaction lié à l'aggresivité
@export var choice: bool
@export var biome: BiomeData.TYPES # Swamp, Forest, Plain
@export var type_choice: String # a2, b1, ...
@export var calcul: String

static func generate() -> EventData:
	var event_data = RESOURCES.pick_random()
	
	return event_data
