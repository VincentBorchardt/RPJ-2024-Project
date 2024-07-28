extends Node

signal prepare_food(food, building)
signal ingredient_list_changed(ingredients, building)
signal start_building_timer(wait_time, building)
signal food_prepared(food, building)
signal finish_creation(food, building)


var grill : Building

# Called when the node enters the scene tree for the first time.
func _ready():
	# TODO This should probably be a generic grill so multiple can be placed,
	# not sure how to do that
	grill = Building.new("Grill", [],
		[FoodList.hamburger], preload("res://assets/sprites/test/tile_0112.png"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
