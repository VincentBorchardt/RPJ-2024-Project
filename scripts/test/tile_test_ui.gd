extends Control

# TODO figure out if I want to separate UI signals here for what's still just a test
@onready var build_buttons = $VBoxContainer2/BuildButtonBox
@onready var current_placeable_label = $VBoxContainer2/BuildButtonBox/CurrentPlaceable

# Called when the node enters the scene tree for the first time.
func _ready():
	BuildMode.turn_build_mode_off.connect(_on_build_mode_turn_build_mode_off)
	BuildMode.turn_build_mode_on.connect(_on_build_mode_turn_build_mode_on)
	BuildMode.selection_updated.connect(_on_build_mode_selection_updated)

func _on_trash_button_pressed():
	Inventory.trash_current_item()

func _on_build_mode_button_pressed():
	BuildMode.toggle_build_mode()

func _on_build_mode_turn_build_mode_off():
	build_buttons.visible = false

func _on_build_mode_turn_build_mode_on():
	build_buttons.visible = true

func _on_build_grill_button_pressed():
	BuildMode.select_placeable(BuildingList.grill)

func _on_build_field_button_pressed():
	BuildMode.select_placeable(FieldList.field1)

func _on_build_mode_selection_updated(placeable):
	if placeable == null:
		current_placeable_label.visible = false
	else:
		current_placeable_label.visible = true
		current_placeable_label.text = "Placing " + placeable.placeable_name
