extends CanvasLayer

@onready var cookbook_food_label = $CookbookFoodLabel
@onready var cookbook_building_label = $CookbookBuildingLabel
@onready var fail_label = $FailLabel
@onready var close_button = $CloseButton
@onready var cookbook_generator = $CookbookGenerator

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func show_popup():
	self.visible = true
	get_tree().paused = true

func close_popup():
	get_tree().paused = false
	cookbook_food_label.visible = false
	cookbook_building_label.visible = false
	fail_label.visible = false
	self.visible = false

func show_cookbook(food_array, building_array):
	close_popup()
	cookbook_food_label.text = cookbook_generator.generate_food_cookbook(food_array)
	cookbook_building_label.text = cookbook_generator.generate_building_cookbook(building_array)
	cookbook_food_label.visible = true
	cookbook_building_label.visible = true
	show_popup()

func show_fail_screen(num_orders, is_endless):
	close_popup()
	var fail_text = "Oh no! You let too many orders stack up! \n \n"
	if not is_endless:
		fail_text += "The Pitmaster is going to replace you with a TAXXIE! \n \n"
	fail_text += "You completed " + str(num_orders) + " orders today!"
	fail_label.text = fail_text
	fail_label.visible = true
	close_button.visible = false
	show_popup()

func _on_close_button_pressed():
	close_popup()

func _on_exit_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/title_screen/title_screen.tscn")
