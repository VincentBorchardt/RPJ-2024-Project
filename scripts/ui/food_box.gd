extends VBoxContainer

@export var available_food : Array[Food]:
	set(array):
		available_food = array
		remove_children()
		update_food_buttons()


func update_food_buttons():
	for food in available_food:
		var button = FoodButton.new()
		button.attached_food = food
		button.pressed_with_food.connect(_on_food_button_pressed)
		add_child(button)

func remove_children():
	for node in get_children():
		remove_child(node)
		node.queue_free()

func _on_food_button_pressed(food):
	Inventory.attempt_to_purchase_item(food)
