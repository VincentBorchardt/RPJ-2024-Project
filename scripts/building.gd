class_name Building extends Placeable

# TODO Why can't I type these arrays?
var food_available : Array = []
var food_preparable : Array = []
var current_creation : Food = null
var current_ingredients : Array = []

#@onready var building_timer = $BuildingTimer

func _init(label, buyable, makeable, picture):
	placeable_name = label
	food_available = buyable
	food_preparable = makeable
	base_texture = picture

func add_food(food):
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
	BuildingList.prepare_food.emit(food, self)
	# TODO I really don't like this, but I don't see another way to call a timer here
	# Not clear where I should put this timer, but the signal can be connected anywhere (Tile?)
	BuildingList.start_building_timer.emit(food.time_to_complete, self)

func array_contains_array (big, small):
	for element in small:
		if !big.has(element):
			return false
	return true

func create_timer(wait_time):
	print(wait_time)
	print("start")
	await get_tree().create_timer(wait_time)
	print("end")

func timer_complete():
	print("timer ended")
	BuildingList.food_prepared.emit(current_creation, self)

func finish():
	if (not Inventory.is_currently_holding_item()):
		Inventory.set_current_item(current_creation)
		BuildingList.finish_creation.emit(current_creation, self)
		current_creation = null
