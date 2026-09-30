class_name Conquistador
extends Node3D

const Link = Place.Link

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
		food = clamp(value, LIMIT_FOOD[0], LIMIT_FOOD[1])
		food_changed.emit("food_stat", value)
		
@export var troops = 600:
	set(value):
		troops = clamp(value, LIMIT_TROOPS[0], LIMIT_TROOPS[1])
		troops_changed.emit("troops_stat", value)
		
@export var trust = 70:
	set(value):
		trust = clamp(value, LIMIT_TRUST[0], LIMIT_TRUST[1])
		trust_changed.emit("trust_stat", value)
		
@export var wealth = 0:
	set(value):
		wealth = clamp(wealth, LIMIT_WEALTH[0], LIMIT_WEALTH[1])
		wealth_changed.emit("wealth_stat", value)
		
var historic_places: Array[Place] = []

# L'évenement où ils se trouve
@export var place_in: Place:
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
		
var next_link: Link = null

# To find the best next place for conquistador
# Ils ont principalement priviligié les tribus avec le plus grand nombre
# Si ils ont très faible - de 10% de la troupe, ils vont évite les tribus nombreuse/aggressif/Fortifié
# Ils évite au maximun les marais
# Si possible aller vers la haut gauche
func get_next_place(list_possible_links: Array[Link]) -> Link:
	var list_links = place_in.links
	var best_link: Link = null
	for link in list_links:
		if not link in list_possible_links:
			continue
		# pas de compaire avec le même, ou le lieu où ils sont déjà
		if link == best_link or link.place in historic_places:
			continue
		if best_link == null:
			best_link = link
			continue
			
		var best_place = best_link.place

		var place = link.place
		if (place.tribe != null && best_place.tribe == null):
			best_link = link
		elif (place.tribe != null): # Les deux ont une tribu
			if (place.tribe.number > best_place.tribe.number):
				best_link = link
		elif (place.tribe == null): # Aucune tribu en vu
			if (place.biome.type > best_place.biome.type): # Plaine > forest > marais
				best_link = link
	next_link = best_link
	return best_link
