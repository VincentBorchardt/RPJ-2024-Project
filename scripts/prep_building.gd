class_name PrepBuilding extends Placeable

@export var food_preparable : Array[Food] = []

var current_creation : Food = null
var current_ingredients : Array = []

var currently_prepping = false
var food_ready = false

func add_food(food):
	# TODO this should check if the added food actually can make any of the food
	# the building makes and reject if it can't?
	current_ingredients.append(food)
	BuildingList.ingredient_list_changed.emit(current_ingredients, self)
	check_prepare_food()

func check_prepare_food():
	for food in food_preparable:
		if array_contains_array (current_ingredients, food.components) and current_creation == null:
			prepare_food(food)

func prepare_food(food):
	for entry in food.components:
		current_ingredients.erase(entry)
	BuildingList.ingredient_list_changed.emit(current_ingredients, self)
	current_creation = food
	currently_prepping = true
	BuildingList.prepare_food.emit(food, self)
	# TODO I really don't like this, but I don't see another way to call a timer here
	# Not clear where I should put this timer, but the signal can be connected anywhere (Tile?)
	BuildingList.start_building_timer.emit(food.time_to_complete, self)

func array_contains_array (big, small):
	for element in small:
		if !big.has(element):
			return false
	return true

func timer_complete():
	food_ready = true
	BuildingList.food_prepared.emit(current_creation, self)

func finish():
	if (not Inventory.is_currently_holding_item()):
		Inventory.current_hold_item = current_creation
		BuildingList.finish_creation.emit(current_creation, self)
		current_creation = null
		currently_prepping = false
		food_ready = false

func activate_placeable(tile):
	if Inventory.is_currently_holding_item():
		var current = Inventory.take_current_item()
		add_food(current)
	else:
		BuildingList.show_ingredient_list.emit(current_ingredients, self)
