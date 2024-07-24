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
	#create_timer(food.time_to_complete)

func array_contains_array (big, small):
	for element in small:
		if !big.has(element):
			return false
	return true

func create_timer(wait_time):
	print(wait_time)
	var timer := Timer.new()
	#timer.wait_time = wait_time
	timer.one_shot = true
	timer.connect("timeout", _on_timer_timeout)
	timer.start(wait_time)
	print("timer started")
	print(timer.time_left)
	timer.wait_time = wait_time
	print(timer.time_left)
	BuildingList.add_child(timer)

func _on_timer_timeout():
	print("timer ended")
	BuildingList.food_prepared.emit(current_creation, self)
