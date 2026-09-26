extends Node3D

@export var event_scene: PackedScene
@export var indian_scene: PackedScene
@export var path_scene: PackedScene

@export var list_events: Array[Event] = []
@export var list_paths: Array[Path] = []

@export var event_start: Event
@export var event_end: Event

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	event_start = create_event(Vector3(3.5, 0, 0.5), 0)
	event_end = create_event(Vector3(-1.5, 0, -2.5), 0)
	create_events(3, 0, -1, -2, 20, 0, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func create_events(x1, z1, x2, z2, number_events, min_link, max_link):
	for i in range(number_events):
		
		# Position
		var position: Vector3 = get_position_event(x1, z1, x2, z2, number_events)
		create_event(position, 1)
		
	#for 
	
	get_all_links_events()
	# All Links
	for event in list_events:
		add_paths_event(event)
		
# additional_link to add one link if it's not the start or end
func create_event(position: Vector3, additional_link: int) -> Event:
	var limit_links: int = randi_range(Event.LINKS_LIMIT[0], Event.LINKS_LIMIT[1]) + additional_link
	var biome: BiomeData = BiomeData.generate()
	var indian: Indian = null
	if (biome.type != BiomeData.TYPES.SWAMP):
		indian = indian_scene.instantiate().generate()
	
	var event: Event = event_scene.instantiate().with_values(position, biome, indian, [] as Array[Event], limit_links)
	list_events.append(event)
	add_child(event)
	return event
	
func contains_path(event_from: Event, event_to: Event) -> bool:
	for path in list_paths:
		if ((path.event_from == event_from &&
			 path.event_to == event_to) || (
			 path.event_from == event_to &&
			 path.event_to == event_from
			)):
			return true
	return false
	
func get_position_event(x1, z1, x2, z2, number_events) -> Vector3:
		var position = Vector3.ZERO
		var nearest_event = INT32_MAX
		var max_itr = 1000
		var y = 0
		
		while (nearest_event == INT32_MAX && y <= max_itr):
			y += 1
			position = Vector3(randf_range(x1, x2),
								0,
								randf_range(z1, z2))
			if (list_events.is_empty()):
				break
			for event in list_events:
				var distance = event.position.distance_to(position)
				nearest_event = min(distance, nearest_event)
			if (nearest_event < Event.NEAREST_LIMIT):
				nearest_event = INT32_MAX
		if (y >= max_itr): # Send a error if nearest_event it's too close
			print('LIMIT REACH!')
		return position

class Nearest:
	var distance: int
	var event: Event

	func _init(distance: int, event: Event):
		self.distance = distance
		self.event = event

func get_all_links_events():
	
	var list_nearest: Array[Array] = []
	for event in list_events:
		var links: Array[Event] = []
		var nearest: Array[Nearest] = []
		for possible_link in list_events:
			if (possible_link == event):
				continue
			var distance = event.position.distance_to(possible_link.position)
			if (distance > 2):
				continue
			
			for i in range(event.links_limit):
				if (i >= nearest.size()):
					nearest.append(Nearest.new(distance, possible_link))
					break;
				elif (distance < nearest[i].distance):
					nearest[i] = Nearest.new(distance, possible_link)
					break;
		
		for near in nearest:
			links.append(near.event)
		print(links.size())
		event.links = links
		

func add_paths_event(event: Event):
	for link in event.links:
		if (contains_path(event, link)):
			continue
		var path: Path = path_scene.instantiate().with_values(event, link)
		add_child(path)
		list_paths.append(path)
