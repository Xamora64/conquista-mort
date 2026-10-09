class_name Player
extends Node3D

var center = Vector3.ZERO
var screen_size
@export var LIMIT_ZOOM = [1.0, 8.0]
# X1, X2; Z1, Z2
@export var LIMIT_ZONE = [Vector2(-15, 10), Vector2(-15, 10)]

const POSITION_MAIN_MENU = Vector3(-0.056, 7.058, 12.883)
const POSITION_STARTING = Vector3(5.202, 1.262, 7.038)

@onready var main: Node = get_parent()

func _ready() -> void:
	position = POSITION_MAIN_MENU
	screen_size = get_viewport().get_visible_rect().size

func start_game_camera() -> void:
	position = POSITION_STARTING

func _physics_process(delta: float) -> void:
	if (main.state_game == 1):
		camera_player_movement()
		camera_player_zoom()
	
	#if (Input.is_action_just_pressed("left click")):
		#print (get_mouse_world_position())

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
		$Camera3D.position.x = clamp($Camera3D.position.x, LIMIT_ZONE[0].x , LIMIT_ZONE[0].y)
		$Camera3D.position.z = clamp($Camera3D.position.z, LIMIT_ZONE[1].x , LIMIT_ZONE[1].y)
	elif (not dragging):
		center = Vector3.ZERO

func camera_player_zoom():
	if (Input.is_action_just_released("zoom-in")):
		$Camera3D.position.y -= 0.2
	elif (Input.is_action_just_released("zoom-out")):
		$Camera3D.position.y += 0.2
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
