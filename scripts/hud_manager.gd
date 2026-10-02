extends CanvasLayer

@onready var conquistadors_stat = get_node("ListConquistadorsStat/ConquistadorsStat")
@export var conquistador: Conquistador # Directement assigné dans le main

class Stat:
	var id: String = ""
	var icon: Resource = load("res://assets/textures/sliders/logoNourriture.png")
	var max_value: int = 0
	var container: HBoxContainer
	var conquistador_stat # Food, Troops, ...
	var conquistador_stat_signal: Signal
	
	func _init(id: String, icon_path: String, max_value: int, conquis_stat, conquis_stat_signal):
		self.id = id
		self.icon = load(icon_path)
		self.max_value = max_value
		self.conquistador_stat = conquis_stat
		self.conquistador_stat_signal = conquis_stat_signal

# onready pour que le conquistador soit bien init
@onready var stats: Array[Stat] = [
	Stat.new("food_stat", "res://assets/textures/sliders/logoNourriture.png", 3000, conquistador.food, conquistador.food_changed),
	Stat.new("troops_stat", "res://assets/textures/sliders/logoNbSoldats.png", 600, conquistador.troops, conquistador.troops_changed),
	Stat.new("trust_stat", "res://assets/textures/sliders/logoConfiance.png", 100, conquistador.trust, conquistador.trust_changed),
	Stat.new("wealth_stat", "res://assets/textures/sliders/logoRichesses.png", 100, conquistador.wealth, conquistador.wealth_changed),
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for stat in stats:
		stat.container = conquistadors_stat.duplicate()
		var icon: TextureRect = stat.container.get_node("IconStat")
		icon.texture = stat.icon
		var progress_bar: TextureProgressBar = stat.container.get_node("BarStat")
		progress_bar.max_value = stat.max_value

		#print(conquistadors_stat)
		$ListConquistadorsStat.add_child(stat.container)
		
		stat.conquistador_stat_signal.connect(_on_conquistadors_value_change)
		_on_conquistadors_value_change(stat.id, stat.conquistador_stat)

	conquistadors_stat.hide() # hide template

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_conquistadors_value_change(id:String, value: int)-> void:
	for stat in stats:
		if (stat.id == id):
			var progress_bar: TextureProgressBar = stat.container.get_node("BarStat")
			progress_bar.set_value(clamp(value, 0, stat.max_value))
			var new_color: Color = Color.RED.lerp(Color.GREEN, progress_bar.get_value() / stat.max_value)
			progress_bar.set_tint_progress(new_color)
