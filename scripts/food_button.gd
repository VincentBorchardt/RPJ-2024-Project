class_name FoodButton extends Button

signal pressed_with_food(food)

@export var attached_food : Food = null:
	set(food):
		attached_food = food
		if food != null:
			if text == "":
				text = food.name + ": Cost = " + str(food.price)
			if icon == null:
				icon = food.base_texture

func _pressed():
	pressed_with_food.emit(attached_food)
