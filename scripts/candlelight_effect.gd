extends SpotLight3D

var noise = FastNoiseLite.new()
var time_passed: float = 0.0

@export var min_energy: float = 7.5
@export var max_energy: float = 16.5
@export var noise_speed: float = 0.2

func _ready() -> void:
	noise.seed = randi()
	noise.frequency = 0.5

func _process(delta: float) -> void:
	time_passed += delta * noise_speed
	var noise_val = noise.get_noise_1d(time_passed)
	light_energy = lerp(min_energy, max_energy, noise_val)
