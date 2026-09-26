class_name Event
extends Area3D

@export var biome: BiomeData
@export var indian: Indian

func with_values(biome: BiomeData, indian: Indian) -> Event:
	self.biome = biome
	self.indian = indian
	return self

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
