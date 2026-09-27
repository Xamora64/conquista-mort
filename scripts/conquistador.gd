class_name Conquistador
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
		food = clamp(value, LIMIT_FOOD[0], LIMIT_TROOPS[1])
		food_changed.emit(value)
		
@export var troops = 600:
	set(value):
		troops = clamp(value, LIMIT_TROOPS[0], LIMIT_TROOPS[1])
		troops_changed.emit(value)
		
@export var trust = 70:
	set(value):
		trust = clamp(value, LIMIT_TRUST[0], LIMIT_TRUST[1])
		trust_changed.emit(value)
		
@export var wealth = 0:
	set(value):
		wealth = clamp(wealth, LIMIT_WEALTH[0], LIMIT_WEALTH[1])
		wealth_changed.emit(value)

# L'évenement où ils se trouve
var place_in: Place:
	set(value):
		place_in = value
		#place_in.display_event_popup.emit(value)

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
func _physics_process(delta: float) -> void:
	if place_in != null:
		show()
		position = place_in.position
		position.y += 0.5
	else:
		hide()
