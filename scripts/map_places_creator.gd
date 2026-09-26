extends Node

const place_scene: PackedScene = preload("res://scenes/place.tscn")
const path_scene: PackedScene = preload("res://scenes/path_draw.tscn")

var list_places: Array[Place] = []
var list_paths: Array[PathDraw] = []

func create_places(x1, z1, x2, z2, number_places, min_link, max_link) -> Array[Place]:
	for i in range(number_places):
		# Position
		var position: Vector3 = get_position_place(x1, z1, x2, z2, number_places)
		create_place(position, 1)
	
	get_all_links_places()
	# All Links
	for place in list_places:
		add_paths_place(place)
	return list_places
	
# additional_link to add one link if it's not the start or end
func create_place(position: Vector3, additional_link: int) -> Place:
	var limit_links: int = randi_range(Place.LINKS_LIMIT[0], Place.LINKS_LIMIT[1]) + additional_link
	var biome: BiomeData = BiomeData.generate()
	var tribe: Tribe = null
	if (biome.type != BiomeData.TYPES_BIOMES.SWAMP):
		tribe = Tribe.new().generate()
	
	var place: Place = place_scene.instantiate().with_values(position, biome, tribe, [] as Array[Place], limit_links)
	list_places.append(place)
	add_child(place)
	return place
	
func contains_path(place_from: Place, place_to: Place) -> bool:
	for path in list_paths:
		if ((path.place_from == place_from &&
			 path.place_to == place_to) || (
			 path.place_from == place_to &&
			 path.place_to == place_from
			)):
			return true
	return false
	
func get_position_place(x1, z1, x2, z2, number_places) -> Vector3:
		var position = Vector3.ZERO
		var nearest_place = INT32_MAX
		var max_itr = 1000
		var y = 0
		
		while (nearest_place == INT32_MAX && y <= max_itr):
			y += 1
			position = Vector3(randf_range(x1, x2),
								0,
								randf_range(z1, z2))
			if (list_places.is_empty()):
				break
			for place in list_places:
				var distance = place.position.distance_to(position)
				nearest_place = min(distance, nearest_place)
			if (nearest_place < Place.NEAREST_LIMIT):
				nearest_place = INT32_MAX
		if (y >= max_itr): # Send a error if nearest_place it's too close
			print('LIMIT REACH!')
		return position

class Nearest:
	var distance: int
	var place: Place

	func _init(distance: int, place: Place):
		self.distance = distance
		self.place = place

func get_all_links_places():
	
	var list_nearest: Array[Array] = []
	for place in list_places:
		var links: Array[Place] = []
		var nearest: Array[Nearest] = []
		for possible_link in list_places:
			if (possible_link == place):
				continue
			var distance = place.position.distance_to(possible_link.position)
			if (distance > 2.5):
				continue
			
			for i in range(place.links_limit):
				if (i >= nearest.size()):
					nearest.append(Nearest.new(distance, possible_link))
					break;
				elif (distance < nearest[i].distance):
					nearest[i] = Nearest.new(distance, possible_link)
					break;
		
		for near in nearest:
			links.append(near.place)
		#print(links.size())
		place.links = links
		

func add_paths_place(place: Place):
	for link in place.links:
		if (contains_path(place, link)):
			continue
		var path: PathDraw = path_scene.instantiate().with_values(place, link)
		add_child(path)
		list_paths.append(path)
