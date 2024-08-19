extends Node

signal turn_build_mode_off()
signal turn_build_mode_on()
signal selection_updated(placeable)

var currently_in_build_mode = false
var build_mode_selection : Placeable = null

func can_place():
	return currently_in_build_mode and (build_mode_selection != null)

func get_current_placeable():
	return build_mode_selection

func select_placeable(placeable):
	build_mode_selection = placeable
	selection_updated.emit(placeable)

func deselect_placeable():
	build_mode_selection = null
	selection_updated.emit(null)

func set_build_mode(turn_on):
	WorkerList.end_worker_mode()
	if turn_on:
		currently_in_build_mode = true
		turn_build_mode_on.emit()
	else:
		currently_in_build_mode = false
		deselect_placeable()
		turn_build_mode_off.emit()

func toggle_build_mode():
	if currently_in_build_mode:
		currently_in_build_mode = false
		deselect_placeable()
		turn_build_mode_off.emit()
	else:
		currently_in_build_mode = true
		turn_build_mode_on.emit()
