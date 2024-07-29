class_name FoodButton extends Button

var attached_food : Food

func _init(food):
	attached_food = food
	text = food.name
	icon = food.base_texture
