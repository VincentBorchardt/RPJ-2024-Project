extends CanvasLayer

@onready var placeable_label = $TilePopupBox/PlaceableLabel

@onready var prep_box = $TilePopupBox/PrepBox
@onready var prep_items_label = $TilePopupBox/PrepBox/PrepItemsLabel
@onready var prep_button = $TilePopupBox/PrepBox/PrepButton
@onready var storage_box = $TilePopupBox/StorageBox

var current_tile : Tile = null

# Called when the node enters the scene tree for the first time.
func _ready():
	BuildingList.show_placeable_info.connect(_on_show_placeable_info)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func close_popup():
	self.visible = false

func _on_show_placeable_info(ingredients, building, tile):
	current_tile = tile
	# TODO Position code
	# TODO If necessary, make the popup go the other way, checking position
	prep_box.visible = false
	storage_box.visible = false
	placeable_label.text = building.placeable_name
	if building is PrepBuilding:
		_show_prep_box(ingredients, building)
	elif building is StorageBuilding:
		_show_storage_box(ingredients, building)
	# TODO other types of placeables, maybe even turning into a case with functions split out
	self.visible = true

func _show_prep_box(ingredients, building):
	var item_string = ""
	for food in ingredients:
		item_string += food.name + "\n"
	prep_items_label.text = item_string
	# TODO The way this is built it doesn't update until you click on the placeable again
	if building.currently_prepping:
		prep_button.attached_placeable = building
		if building.food_ready:
			prep_button.text = building.current_creation.name + " Complete"
			prep_button.disabled = false
		else:
			prep_button.text = building.current_creation.name + " Preparing"
			prep_button.disabled = true
		prep_button.visible = true
	else:
		prep_button.visible = false
	prep_box.visible = true

func _show_storage_box(ingredients, building):
	# TODO put a label for the type of building that won't get eaten up by removing children
	# either create a label node each time or make a box just for the buttons to clear/populate
	for node in storage_box.get_children():
		storage_box.remove_child(node)
		node.queue_free()
	for food in ingredients:
		var button = FoodButton.new()
		button.attached_food = food
		button.pressed_with_food.connect(_on_food_button_pressed)
		storage_box.add_child(button)
	storage_box.visible = true

func _on_food_button_pressed(food):
	Inventory.attempt_to_purchase_item(food)


func _on_prep_button_pressed(placeable):
	assert (placeable is PrepBuilding, "PrepButton pressed when not a PrepBuilding")
	placeable.finish()


func _on_close_popup_pressed():
	close_popup()
