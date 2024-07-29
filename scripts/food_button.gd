class_name FoodButton extends Button

signal pressed_with_food(food)

@export var attached_food : Food = null:
	set(food):
		attached_food = food
		text = food.name
		icon = food.base_texture

func _init(food):
	attached_food = food
	text = food.name
	icon = food.base_texture

func _pressed():
	pressed_with_food.emit(attached_food)
