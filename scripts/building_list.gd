extends Node

signal prepare_food(food, building)
signal ingredient_list_changed(ingredients, building)
signal start_building_timer(wait_time, building)
signal food_prepared(food, building)
signal finish_creation(food, building)
signal show_ingredient_list(ingredients, building)

# TODO just threw this signal here, maybe should put all these back in a signal bus?

signal show_placeable_info(ingredients, building, tile)

var grill : PrepBuilding
var warehouse : StorageBuilding
var field : PrepBuilding

# Called when the node enters the scene tree for the first time.
func _ready():
	# TODO This should probably be a generic grill so multiple can be placed,
	# not sure if I need to do that or how to do that, check later
	grill = PrepBuilding.new("Grill", [FoodList.hamburger],
		preload("res://assets/sprites/test/tile_0112.png")
	)
	warehouse = StorageBuilding.new("Warehouse", [FoodList.bun],
		preload("res://assets/sprites/test/tile_0111.png"), true
	)
	field = PrepBuilding.new("Field", [FoodList.beef],
		preload("res://assets/sprites/test/tile_0109.png")
	)

