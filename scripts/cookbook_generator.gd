extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func generate_full_food_cookbook():
	var food_paths = get_all_resource_paths("res://resources/food/", false)
	var food_array = []
	for entry in food_paths:
		var food = load(entry)
		food_array.append(food)
	var cookbook = generate_food_cookbook(food_array)
	return cookbook

func generate_food_cookbook(food_array):
	var cookbook = "Food Items: \n \n"
	for food in food_array:
		cookbook += str(food)
	return cookbook

func generate_full_building_cookbook():
	var building_paths = get_all_resource_paths("res://resources/placeable/", false)
	var building_array = []
	for entry in building_paths:
		var building = load(entry)
		building_array.append(building)
	var cookbook = generate_building_cookbook(building_array)
	return cookbook

func generate_building_cookbook(building_array):
	var cookbook = "Prep Buildings: \n \n"
	for building in building_array:
		if building is PrepBuilding:
			cookbook += str(building)
	return cookbook

## Returns an array of full file paths to all resources in the directory at the specified path.
## These file paths can be used to load the resources with load().
static func get_all_resource_paths(directory_path: String, include_subdirectories := true) -> Array[String]:
	if directory_path == "":
		return []
	var directory = DirAccess.open(directory_path)
	if directory == null:
		if not Engine.is_editor_hint():
			push_error("CRITICAL: The directory %s does not exist. Returning an empty array." % directory_path)
		return []
	var file_path_list: Array[String] = []
	for file in directory.get_files():
		if file.ends_with(".remap"):
			file = file.trim_suffix(".remap")
		elif file.ends_with(".import"):
			file = file.trim_suffix(".import")
		var full_name = directory_path + "/" + file
		if ResourceLoader.exists(full_name):
			file_path_list.append(full_name)
	if include_subdirectories:
		for subdirectory_name in directory.get_directories():
			var subdirectory_path = directory_path + "/" + subdirectory_name
			var subdirectory_file_path_list = get_all_resource_paths(subdirectory_path)
			file_path_list.append_array(subdirectory_file_path_list)
	return file_path_list
