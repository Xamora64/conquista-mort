class_name LibResources
extends Node

#Take a path and create instance of the resource's Array
static func load_folder(path: String) -> Array[Resource]:
	var resources: Array = [] 
	for file in ResourceLoader.list_directory(path):
		var new_path = path + file
		if (file.ends_with("/")):
			resources.append_array(load_folder(new_path))
		else:
			resources.append(load(new_path).duplicate())
	return resources
