extends Node

signal turn_build_mode_off()
signal turn_build_mode_on()
signal selection_updated(placeable)

var currently_in_build_mode = false
var build_mode_selection : Placeable = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func can_place():
	return currently_in_build_mode and (build_mode_selection != null)

func get_current_placeable():
	return build_mode_selection

func select_placeable(placeable):
	build_mode_selection = placeable
	selection_updated.emit(placeable)

func toggle_build_mode():
	if currently_in_build_mode:
		currently_in_build_mode = false
		select_placeable(null)
		turn_build_mode_off.emit()
	else:
		currently_in_build_mode = true
		turn_build_mode_on.emit()
