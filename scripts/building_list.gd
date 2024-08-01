extends Node

signal prepare_food(food, building)
signal ingredient_list_changed(ingredients, building)
signal start_building_timer(wait_time, building)
signal food_prepared(food, building)
signal finish_creation(food, building)
signal show_ingredient_list(ingredients, building)

# TODO just threw this signal here, maybe should put all these back in a signal bus?

signal show_placeable_info(ingredients, building, tile)
signal open_tile(tile)
signal block_tile(tile)

func _ready():
	pass

