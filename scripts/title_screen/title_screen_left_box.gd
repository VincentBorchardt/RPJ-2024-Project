extends VBoxContainer

signal show_options()

@onready var debug_box = $DebugBox
@onready var endless_button = $EndlessModeButton

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	endless_button.disabled = not GameManager.endless_enabled

func _on_debug_button_pressed():
	if not debug_box.visible:
		debug_box.visible = true
	else:
		debug_box.visible = false

func _on_options_button_pressed():
	show_options.emit()

func _on_scene_button_pressed(scene):
	get_tree().change_scene_to_packed(scene)


func _on_enable_endless_toggled(toggled_on):
	GameManager.endless_enabled = toggled_on
