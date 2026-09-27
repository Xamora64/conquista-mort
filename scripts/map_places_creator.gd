extends Node

const place_scene: PackedScene = preload("res://scenes/place.tscn")
const path_scene: PackedScene = preload("res://scenes/path_draw.tscn")

var list_paths: Array[PathDraw] = []
const Link = Place.Link

func add_link_path_places(list_places: Array[Place]):
	get_links_places(list_places)
	# All Links
	for place in list_places:
		add_paths_place(place)
		add_child(place)

func init_places(x1, z1, x2, z2, number_places, min_link, max_link) -> Array[Place]:
	var list_places: Array[Place] = []
	for i in range(number_places):
		# Position
		var position: Vector3 = get_position_place(x1, z1, x2, z2, number_places, list_places)
		list_places.append(init_place(position, 1))
	
	return list_places
	
# additional_link to add one link if it's not the start or end
func init_place(position: Vector3, additional_link: int) -> Place:
	var limit_links: int = randi_range(Place.LINKS_LIMIT[0], Place.LINKS_LIMIT[1]) + additional_link
	var biome: BiomeData = BiomeData.generate()
	var tribe: Tribe = null
	if (biome.type != BiomeData.TYPES_BIOMES.SWAMP):
		tribe = Tribe.new().generate()
	
	var place: Place = place_scene.instantiate().with_values(position, biome, tribe, [] as Array[Link], limit_links)
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
	
func get_position_place(x1, z1, x2, z2, number_places, list_places) -> Vector3:
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

func get_links_places(list_places: Array[Place]):
	
	for place in list_places:
		var links: Array[Link] = []
		var nearest: Array[Link] = []
		for possible_link in list_places:
			if (possible_link == place):
				continue
			var distance = place.position.distance_to(possible_link.position)
			if (distance > 2.5):
				continue
			
			for i in range(place.links_limit):
				if (i >= nearest.size()):
					nearest.append(Link.new(possible_link, null, distance))
					break;
				elif (distance < nearest[i].distance):
					nearest[i] = Link.new(possible_link, null, distance)
					break;
		
		for near in nearest:
			links.append(near)
		#print(links.size())
		place.links = links
		

func add_paths_place(place: Place):
	#print(place.links.size())
	for link in place.links:
		if (contains_path(place, link.place)):
			continue
		var path: PathDraw = path_scene.instantiate().with_values(place, link.place)
		link.path_draw = path
		add_child(path)
		list_paths.append(path)
