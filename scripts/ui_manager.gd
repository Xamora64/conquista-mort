extends Node

@export var conquistador: Node3D
@export var tribe_event_popup: PopupPanel
@export var biome_event_popup: PopupPanel
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	conquistador.event_in.display_event_popup.connect(_display_popup)

func _display_popup(current_event: Event):
	
	if current_event.indian!=null:
		tribe_event_popup.show()
	else:
		biome_event_popup.show()
		
