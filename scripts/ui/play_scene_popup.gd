extends CanvasLayer

@onready var cookbook_food_label = $CookbookFoodLabel
@onready var cookbook_building_label = $CookbookBuildingLabel
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
	self.visible = false

func show_cookbook(food_array, building_array):
	close_popup()
	cookbook_food_label.text = cookbook_generator.generate_food_cookbook(food_array)
	cookbook_building_label.text = cookbook_generator.generate_building_cookbook(building_array)
	cookbook_food_label.visible = true
	cookbook_building_label.visible = true
	show_popup()

func _on_close_button_pressed():
	close_popup()
