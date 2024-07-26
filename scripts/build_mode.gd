extends Node

signal turn_build_mode_off()
signal turn_build_mode_on()

var currently_in_build_mode = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func toggle_build_mode():
	if currently_in_build_mode:
		currently_in_build_mode = false
		turn_build_mode_off.emit()
	else:
		currently_in_build_mode = true
		turn_build_mode_on.emit()
