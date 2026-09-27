class_name Tribe
extends Node

const LIMIT_NUMBER = Vector2(0, 3000)
const LIMIT_AGGRESSION = Vector2(-2, 2)

const NAME_TRIBE = [
	"Ozita",
	"Mucoço",
	"Anhaica",
	"Apalachee",
	"Anhaica",
	"Cofitachequi",
	"Achalaque",
	"Cosa",
	"Cofaqui",
	"Ocute",
	"Hymachi",
	"Cofitachequi",
	"Talimeco",
	"Guasuli",
	"Chiaha",
	"Coste",
	"Toqua",
	"Coosa",
	"Talimachusi",
	"Etowah",
	"Ulibahali",
	"Talisi",
	"Tascaluza",
	"Atahachi",
	"Mavila",
	"Chicaza",
	"Alibamo",
	"Quizquiz",
	"Quigate",
	"Utiangüe",
	"Quigaltam",
	"Guachoya",
	"Soacatino",
	"Guasco",
	"Naquiscoza",
	"Aminoya",
	"Anilco"
]

@export var tribe_name = "Tribe Test"
@export var number = 400
@export var aggression = 0
@export var fortification = false

func with_values(number: int, aggression: int, fortification: bool) -> Tribe:
	self.number = number
	self.aggression = aggression
	self.fortification = fortification
	return self

# random
func generate() -> Tribe:
	self.number = randi_range(LIMIT_NUMBER[0], LIMIT_NUMBER[1])
	self.aggression = randi_range(LIMIT_AGGRESSION[0], LIMIT_AGGRESSION[1])
	self.fortification = randi() % 2 == 0
	return self


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
