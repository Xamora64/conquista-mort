extends Node3D

var center = Vector3.ZERO
var screen_size
@export var LIMIT_ZOOM = [1.0, 12.0]

func _ready() -> void:
	$Camera3D.position.y = 2.0
	screen_size = get_viewport().get_visible_rect().size

func _physics_process(delta: float) -> void:
	camera_player_movement()
	camera_player_zoom()
	
	if (Input.is_action_just_pressed("left click")):
		print (get_mouse_world_position())

func camera_player_movement():
	# Obtenir la position de la souris par rapport aux mondes
	var mouse_pos_world = get_mouse_world_position()
	
	var dragging = Input.is_action_pressed("left click")
	
	if (dragging && center == Vector3.ZERO):
		center = mouse_pos_world
	elif (dragging):
		var distance_center_mouse = center - mouse_pos_world
		$Camera3D.position.x += distance_center_mouse.x
		$Camera3D.position.z += distance_center_mouse.z
	elif (not dragging):
		center = Vector3.ZERO

func camera_player_zoom():
	if (Input.is_action_just_released("zoom-in")):
		$Camera3D.position.y -= 0.1
	elif (Input.is_action_just_released("zoom-out")):
		$Camera3D.position.y += 0.1
	# Mettre une limite au zomm de la caméra
	$Camera3D.position.y = clamp($Camera3D.position.y, LIMIT_ZOOM[0], LIMIT_ZOOM[1])
	
func get_mouse_world_position():
	var mouse_pos = get_viewport().get_mouse_position()
	
	# Récupération de la position de la souris par rapport aux mondes
	# En tirant un raycast
	var camera = get_viewport().get_camera_3d()
	var from = camera.project_ray_origin(mouse_pos)
	var dir = camera.project_ray_normal(mouse_pos)
	return Plane(Vector3.UP, 0).intersects_ray(from, dir)
