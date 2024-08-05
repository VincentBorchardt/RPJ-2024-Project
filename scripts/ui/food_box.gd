extends VBoxContainer

@export var available_food : Array[Food]:
	set(array):
		available_food = array
		#remove_children()
		update_food_buttons()

func _ready():
	# TODO if we change the setup so food is assigned post-ready,
	# this likely needs to be moved into a setter (along with clearing children)
	update_food_buttons()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

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
	if not Inventory.is_currently_holding_item():
		Inventory.set_current_item(food)
