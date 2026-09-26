extends Node3D

const LIMIT_FOOD = Vector2(0, 3000)
const LIMIT_TROOPS = Vector2(0, 600)
const LIMIT_TRUST = Vector2(0, 100)
const LIMIT_WEALTH = Vector2(0, 100)

signal food_changed(value)
signal trust_changed(value)
signal troops_changed(value)
signal wealth_changed(value)

@export var food = 1800:
	set(value):
		food_changed.emit(value)
		
@export var troops = 600:
	set(value):
		troops_changed.emit(value)
		
@export var trust = 70:
	set(value):
		trust_changed.emit(value)
		
@export var wealth = 0:
	set(value):
		wealth_changed.emit(value)
		
var event_in # L'évenement où ils se trouve

func with_values(food: int, troops: int, trust: int, wealth: int):
	self.food = food
	self.troops = troops
	self.trust = trust
	self.wealth = wealth
	return self

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
