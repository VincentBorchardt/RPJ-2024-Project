extends Control

# TODO figure out if I want to separate UI signals here for what's still just a test

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_trash_button_pressed():
	Inventory.trash_current_item()


func _on_build_mode_button_pressed():
	BuildMode.toggle_build_mode()
