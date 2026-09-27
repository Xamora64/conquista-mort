class_name Map
extends Node3D

@onready var placeCreator = $MapEventsCreator
var conquis
var game_ui
const Link = Place.Link

@export var place_start: Place
@export var place_end: Place

@export var list_places: Array[Place] = []
@export var list_paths: Array[PathDraw] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	place_start = placeCreator.init_place(Vector3(7.03, 0, 5.66), true)
	place_end = placeCreator.init_place(Vector3(-6.41, 0, -3.41), true)
	place_start.start = true
	place_end.end = true
	
	list_places = placeCreator.init_places(6.8, 5, -6, -3, 148, 0, 0)
	list_places.append(place_start)
	list_places.append(place_end)
	list_paths = placeCreator.add_link_path_places(list_places)
	for place in list_places:
		place.input_event.connect(_on_input_event.bind(place))
	hide_place()
	hide_path()
		
	conquis = get_node("../Conquistador")
	game_ui = get_node("../GameUI")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (conquis != null):
		conquis.place_in.show()
		for link in conquis.place_in.links:
			link.place.show()
			if link.path_draw != null:
				if link == conquis.next_link:
					link.path_draw.line.set_default_color(Color.RED)
				link.path_draw.line.width = 1.5
	pass
	
func hide_place(except_places: Array[Place] = []):
	for place in list_places:
		if place in except_places:
			continue
			
		place.hide()
				
func hide_path(except_places: Array[Place] = []):
	for place in list_places:
		for link in place.links:
			if (link.path_draw != null and not link.taken):
				link.path_draw.line.width = 0
			elif (link.taken):
				link.path_draw.line.set_default_color(Color.DARK_GRAY)
		
	
signal click_on_place(place: Place)

func conquis_next_place(place_to: Place):
		var place_from: Place = conquis.place_in
		
		# get the link beetween
		var link: Link = null
		for l in place_to.links:
			if l.place == place_from:
				link = l
		for l in place_from.links:
			if l.place == place_to:
				link = l
		if (link != null):
			link.taken = true
		
		print(get_parent())
		conquis.historic_places.append(place_to)
		
		var list_possible_links: Array[Link] = possible_next_places(place_to)
		
		click_on_place.emit(place_to)
		
		print (list_possible_links.size())
		conquis.get_next_place(list_possible_links)
		
		if (conquis.food <= 0):
			conquis.troops = conquis.troops * 0.9
		else:
			conquis.food -= conquis.troops / 2
		
		hide_path()
		hide_place(conquis.historic_places)

func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int, place_to: Place) -> void:
	if (event.is_action_pressed("left click")):
		print("event selectioned: ", place_to.position.x, " ", place_to.position.y, " ", place_to.position.z)
		if (game_ui.guide):
			conquis_next_place(place_to)
		#print(conquis.historic_places)
	
# De Droite à Gauche x: 7.03 => -6.41
# De Bas à haut z: 5.66 => -3.41
# Jamais derrière (Bas - Droite)
# angle de 130 haut gauche
func possible_next_places(place: Place) -> Array[Link]:
	var next_places: Array[Link] = []
	var p_pos = place.position
	for link in place.links:
		var l_pos = link.place.position
		
		var to_place = Vector2(l_pos.x - p_pos.x, l_pos.z - p_pos.z)
		if (to_place == Vector2.ZERO):
			continue
		#Vector(-1, -1) => Haut gauche
		var ecart = abs(to_place.angle_to(Vector2(-1, -1)))
		if (ecart <= deg_to_rad(130 / 2.0)):
			next_places.append(link)
			
	# Need to Take one, je prend le plus en haut à gauche que possible 
	if (next_places.is_empty()):
		var best_link: Link = null
		for link in place.links:
			if (link.place in conquis.historic_places):
				continue
			if (best_link == null):
				best_link = link
				continue
			if (link != best_link):
				if (link.place.position.dot(Vector3(-1, 0, -1)) >
					best_link.place.position.dot(Vector3(-1, 0, -1))):
					best_link = link
		next_places.append(best_link)
			
	return next_places
