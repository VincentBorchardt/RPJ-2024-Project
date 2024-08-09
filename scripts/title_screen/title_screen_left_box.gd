extends VBoxContainer

signal show_options()

@onready var debug_box = $DebugBox

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_debug_button_pressed():
	if not debug_box.visible:
		debug_box.visible = true
	else:
		debug_box.visible = false

func _on_options_button_pressed():
	show_options.emit()

func _on_scene_button_pressed(scene):
	get_tree().change_scene_to_packed(scene)
