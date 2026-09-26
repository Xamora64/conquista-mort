extends Node3D

@export var event_scene: PackedScene
@export var indian_scene: PackedScene
@export var path_scene: PackedScene
@export var list_events: Array[Event] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_events(3, 0, -1, -2, 10, 0, 0)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func create_events(x1, z1, x2, z2, number_events, min_link, max_link):
	for i in range(number_events):
		
		# Position
		var position = get_position_event(x1, z1, x2, z2, number_events)
		
		# Biome
		var biome: BiomeData = BiomeData.generate()
		
		# Indian in the event
		var indian: Indian = null
		if (biome.type != BiomeData.TYPES.SWAMP):
			indian = indian_scene.instantiate().generate()
		
		var event: Event = event_scene.instantiate().with_values(position, biome, indian, [] as Array[Event])
		list_events.append(event)
		add_child(event)
		
	# All Links
	for event in list_events:
		event.links = get_links_events(event)
		#for link in event.links:
			#var path: = 
		
	
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

func get_links_events(event: Event) -> Array[Event]:
	var links: Array[Event] = []
	var nearest: Array[Nearest] = []
	var limit_links: int = randi_range(Event.LINKS_LIMIT[0], Event.LINKS_LIMIT[1])
	for possible_link in list_events:
		var distance = event.position.distance_to(possible_link.position)
		
		for i in range(limit_links):
			if (i >= nearest.size()):
				nearest.append(Nearest.new(distance, possible_link))
				break;
			elif (distance < nearest[i].distance):
				nearest.insert(i, Nearest.new(distance, possible_link))
				break;
	
	for near in nearest:
		links.append(near.event)
	#print(links.size())
	
	return links
