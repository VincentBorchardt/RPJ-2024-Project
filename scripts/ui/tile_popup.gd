extends CanvasLayer

signal close_tiles()

@onready var placeable_label = $TilePopupBox/PlaceableLabel
@onready var popup_timeout = $PopupTimeout

@onready var prep_box = $TilePopupBox/PrepBox
@onready var prep_items_label = $TilePopupBox/PrepBox/PrepItemsLabel
@onready var prep_progress_bar = $TilePopupBox/PrepBox/PrepProgressBar
@onready var prep_button = $TilePopupBox/PrepBox/PrepButton
@onready var storage_box = $TilePopupBox/StorageBox

var current_tile : Tile = null

func _ready():
	BuildingList.show_placeable_info.connect(_on_show_placeable_info)
	BuildingList.update_placeable_timer.connect(_on_update_placeable_timer)

func _process(delta):
	if current_tile != null:
		if current_tile.tile_feature is PrepBuilding:
			var building = current_tile.tile_feature
			var ingredients = building.current_ingredients
			_build_prep_box(ingredients, building, current_tile)

func close_popup():
	self.visible = false
	close_tiles.emit()
	popup_timeout.stop()

func _on_show_placeable_info(ingredients, building, tile):
	close_popup()
	current_tile = tile
	tile.highlight.visible = true
	self.offset = tile.global_position
	prep_box.visible = false
	storage_box.visible = false
	placeable_label.text = building.placeable_name
	if building is PrepBuilding:
		_show_prep_box(ingredients, building, tile)
	elif building is StorageBuilding:
		_show_storage_box(ingredients, building)
	# TODO other types of placeables, maybe even turning into a case with functions split out
	self.visible = true
	popup_timeout.start()

func _on_close_popup_pressed():
	close_popup()

func _on_popup_timeout_timeout():
	close_popup()

# PREP BOX STUFF

func _build_prep_box(ingredients, building, tile):
	if current_tile.tile_feature is PrepBuilding:
		var item_string = ""
		for food in ingredients:
			item_string += food.name + "\n"
		prep_items_label.text = item_string
		# TODO The way this is built it doesn't update until you click on the placeable again
		if building.currently_prepping:
			var percent_done = tile.get_timer_percent_done()
			prep_button.attached_placeable = building
			_update_active_prep_box(percent_done, building)
		else:
			prep_button.visible = false
			prep_progress_bar.visible = false
func _show_prep_box(ingredients, building, tile):
	_build_prep_box(ingredients, building, tile)
	prep_box.visible = true

func _update_active_prep_box(percent_done, building):
	#prep_button.attached_placeable = building
	prep_progress_bar.value = percent_done
	prep_button.icon = building.current_creation.base_texture
	if building.food_ready:
		prep_button.text = building.current_creation.name + " Complete"
		prep_button.disabled = false
	else:
		prep_button.text = building.current_creation.name + " Preparing"
		prep_button.disabled = true
	prep_button.visible = true
	prep_progress_bar.visible = true

func _on_update_placeable_timer(percent_done, tile):
	if current_tile == tile:
		assert((tile.tile_feature is PrepBuilding), "updating PrepBox on non-PrepBuilding")
		_update_active_prep_box(percent_done, tile.tile_feature)

func _on_prep_button_pressed(placeable):
	assert (placeable is PrepBuilding, "PrepButton pressed when not a PrepBuilding")
	placeable.finish()

# STORAGE BOX STUFF
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
