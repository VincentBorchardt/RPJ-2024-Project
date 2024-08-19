extends VBoxContainer

@onready var build_mode_toggle = $BuildModeToggle
@onready var buttons_box = $ButtonsBox
@onready var current_placeable = $CurrentPlaceable

@export var available_placeables : Array[Placeable]:
	set(array):
		available_placeables = array
		remove_buttons_children()
		update_placeable_buttons()

func _ready():
	BuildMode.turn_build_mode_off.connect(_on_build_mode_turn_build_mode_off)
	BuildMode.turn_build_mode_on.connect(_on_build_mode_turn_build_mode_on)
	BuildMode.selection_updated.connect(_on_build_mode_selection_updated)

func update_placeable_buttons():
	for placeable in available_placeables:
		var button = PlaceableButton.new()
		button.attached_placeable = placeable
		button.pressed_with_placeable.connect(_on_placeable_button_pressed)
		buttons_box.add_child(button)

func remove_buttons_children():
	for node in buttons_box.get_children():
		buttons_box.remove_child(node)
		node.queue_free()

func _on_placeable_button_pressed(placeable):
	BuildMode.select_placeable(placeable.duplicate())

func _on_build_mode_button_toggled(toggled_on):
	BuildMode.set_build_mode(toggled_on)

func _on_build_mode_turn_build_mode_off():
	build_mode_toggle.set_pressed_no_signal(false)
	buttons_box.visible = false

func _on_build_mode_turn_build_mode_on():
	build_mode_toggle.set_pressed_no_signal(true)
	buttons_box.visible = true

func _on_build_mode_selection_updated(placeable):
	if placeable == null:
		current_placeable.visible = false
	else:
		current_placeable.text = "Placing " + placeable.placeable_name
		current_placeable.visible = true
