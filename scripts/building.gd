class_name Building extends Resource

# TODO Why can't I type these arrays?
var name : String = "Default Building"
var food_available : Array = []
var food_preparable : Array = []
var base_texture : Texture2D

func _init(label, buyable, makeable, picture):
	name = label
	food_available = buyable
	food_preparable = makeable
	base_texture = picture

func check_prepare_food(ingredients):
	for food in food_preparable:
		if array_contains_array (ingredients, food.components):
			BuildingList.prepare_food.emit(food, self)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func array_contains_array (big, small):
	for element in small:
		if !big.has(element):
			return false
	return true
