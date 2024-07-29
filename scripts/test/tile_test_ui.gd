extends Control

# TODO figure out if I want to separate UI signals here for what's still just a test
@onready var build_buttons = $VBoxContainer2/BuildButtonBox
@onready var current_placeable_label = $VBoxContainer2/BuildButtonBox/CurrentPlaceable

@onready var placeable_box = $PlaceableBox
@onready var prep_box = $PlaceableBox/PrepBox
@onready var prep_label = $PlaceableBox/PrepBox/PrepLabel
@onready var prep_button = $PlaceableBox/PrepBox/Button
@onready var storage_box = $PlaceableBox/StorageBox

# TODO subclass Button to add a Food field?

# Called when the node enters the scene tree for the first time.
func _ready():
	BuildMode.turn_build_mode_off.connect(_on_build_mode_turn_build_mode_off)
	BuildMode.turn_build_mode_on.connect(_on_build_mode_turn_build_mode_on)
	BuildMode.selection_updated.connect(_on_build_mode_selection_updated)
	BuildingList.show_placeable_info.connect(_on_show_placeable_info)

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

func _on_build_warehouse_button_pressed():
	BuildMode.select_placeable(BuildingList.warehouse)

func _on_build_mode_selection_updated(placeable):
	if placeable == null:
		current_placeable_label.visible = false
	else:
		current_placeable_label.visible = true
		current_placeable_label.text = "Placing " + placeable.placeable_name

func _on_show_placeable_info(ingredients, building, tile):
	prep_box.visible = false
	storage_box.visible = false
	if building is PrepBuilding:
		var item_string = building.placeable_name + "\n"
		for food in ingredients:
			item_string += food.name + "\n"
		prep_label.text = item_string
		prep_box.visible = true
	elif building is StorageBuilding:
		# TODO put a label for the type of building that won't get eaten up by removing children
		# either create a label node each time or make a box just for the buttons to clear/populate
		for node in storage_box.get_children():
			storage_box.remove_child(node)
			node.queue_free()
		for food in ingredients:
			var button = FoodButton.new(food)
			button.pressed_with_food.connect(_on_food_button_pressed)
			storage_box.add_child(button)
		storage_box.visible = true
	# TODO other types of placeables, maybe even turning into a case with functions split out
	placeable_box.visible = true

func _on_food_button_pressed(food):
	# TODO this initial design doesn't account for non-producers
	if not Inventory.is_currently_holding_item():
		Inventory.set_current_item(food)
