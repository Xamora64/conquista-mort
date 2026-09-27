extends CanvasLayer

@export var food_bar: TextureProgressBar
@export var trust_bar: TextureProgressBar
@export var troops_bar: TextureProgressBar
@export var wealth_bar: TextureProgressBar
@export var conquistador: Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	conquistador.food_changed.connect(_on_food_changed)
	conquistador.trust_changed.connect(_on_trust_changed)
	conquistador.wealth_changed.connect(_on_wealth_changed)
	conquistador.troops_changed.connect(_on_troops_changed)
	
	_on_food_changed(conquistador.food)
	_on_troops_changed(conquistador.troops)
	_on_trust_changed(conquistador.trust)
	_on_wealth_changed(conquistador.wealth)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_food_changed(value: int)-> void:
	food_bar.set_value_no_signal(clamp(value, 0, food_bar.max_value))
	_set_color(food_bar)

func _on_trust_changed(value: int)-> void:
	trust_bar.set_value(clamp(value, 0, trust_bar.max_value))
	_set_color(trust_bar)

func _on_troops_changed(value: int)-> void:
	troops_bar.set_value(clamp(value, 0, troops_bar.max_value))
	_set_color(troops_bar)

func _on_wealth_changed(value: int)-> void:
	wealth_bar.set_value(clamp(value, 0, wealth_bar.max_value))
	_set_color(wealth_bar)
	
func _set_color(bar: TextureProgressBar)->void:
	if bar.value>=0 && bar.value<=bar.max_value/4:
		bar.set_tint_progress(Color.RED)
	elif bar.value>bar.max_value/4 && bar.value<=bar.max_value/2:
		bar.set_tint_progress(Color.ORANGE)
	else:
		bar.set_tint_progress(Color.GREEN)
	
	
	
