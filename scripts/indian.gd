class_name Indian
extends Node

const LIMIT_NUMBER = Vector2(0, 3000)
const LIMIT_AGGRESSION = Vector2(-2, 2)

@export var number = 400
@export var aggression = 0
@export var fortification = false

func with_values(number: int, aggresion: int, fortification: bool) -> Indian:
	self.number = number
	self.aggression = aggression
	self.fortification = fortification
	return self

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
