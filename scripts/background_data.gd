class_name BackgroundData
extends Resource

static var background_resources: Array[BackgroundData]

@export var background_path: String
enum TYPES_BACKGROUND {START, TRIBE, TRIBE_FORTIFIED, FRONT, GUERILLA, WINNING, LOSING}
@export var type: TYPES_BACKGROUND

# Return the list of valid resources
static func get_possible_background_resources(type_background: TYPES_BACKGROUND) -> Array[BackgroundData]:
	var list_possible_background: Array[BackgroundData] = []
	#print(background_resources.size())
	for background in background_resources:
		#print(background.type, " ", type_background, " ", background.type == type_background)
		if (background.type == type_background):
			list_possible_background.append(background)
	#print(list_possible_background.size())
	return list_possible_background
