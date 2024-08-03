extends Control

signal submit_order()
# TODO figure out if I want to separate UI signals here for what's still just a test

@onready var inventory_slot_0 = $InventoryBox/InventorySlot0
@onready var inventory_slot_1 = $InventoryBox/InventorySlot1
@onready var inventory_slot_2 = $InventoryBox/InventorySlot2
@onready var current_item_label = $InventoryBox/CurrentItemLabel
@onready var trash_button = $InventoryBox/TrashButton

@onready var current_orders = $OrderQueueBox/CurrentOrders

@onready var build_buttons = $BuildBox/BuildButtonBox
@onready var current_placeable_label = $BuildBox/BuildButtonBox/CurrentPlaceable

@onready var placeable_box = $PlaceableBox
@onready var prep_box = $PlaceableBox/PrepBox
@onready var prep_label = $PlaceableBox/PrepBox/PrepLabel
@onready var storage_box = $PlaceableBox/StorageBox
@onready var prep_button = $PlaceableBox/PrepBox/PrepButton


func _ready():
	Inventory.current_item_changed.connect(_on_inventory_current_item_changed)
	Inventory.inventory_slot_changed.connect(_on_inventory_inventory_slot_changed)
	
	BuildMode.turn_build_mode_off.connect(_on_build_mode_turn_build_mode_off)
	BuildMode.turn_build_mode_on.connect(_on_build_mode_turn_build_mode_on)
	BuildMode.selection_updated.connect(_on_build_mode_selection_updated)
	BuildingList.show_placeable_info.connect(_on_show_placeable_info)

# FOOD BOX STUFF
func _on_food_button_pressed(food):
	# TODO this initial design doesn't account for non-producers
	if not Inventory.is_currently_holding_item():
		Inventory.set_current_item(food)

# INVENTORY BOX STUFF
func _on_inventory_slot_0_pressed():
	Inventory.take_item_from_slot(0)

func _on_inventory_slot_1_pressed():
	Inventory.take_item_from_slot(1)

func _on_inventory_slot_2_pressed():
	Inventory.take_item_from_slot(2)

func _on_inventory_current_item_changed(food):
	if (food != null):
		print("setting current item")
		current_item_label.text = "Current Item: " + food.name
		current_item_label.visible = true
		trash_button.visible = true
	else:
		print("removing current item")
		current_item_label.visible = false
		trash_button.visible = false

func _on_inventory_inventory_slot_changed(slot, food):
	var button
	match slot:
		0: 
			button = inventory_slot_0
		1:
			button = inventory_slot_1
		2:
			button = inventory_slot_2
		_:
			print("slot not connected")
	if button != null:
		if food != null:
			button.attached_food = food
			button.text = food.name
		else:
			button.text = "Empty"
			button.icon = null

func _on_trash_button_pressed():
	Inventory.trash_current_item()

# ORDER QUEUE STUFF
func _on_order_queue_current_orders_changed(orders):
	current_orders.text = ""
	for food in orders:
		current_orders.text += food.name + "\n"

func _on_submit_button_pressed():
	submit_order.emit()

# BUILD BOX STUFF
func _on_build_mode_button_pressed():
	BuildMode.toggle_build_mode()

func _on_build_mode_turn_build_mode_off():
	build_buttons.visible = false

func _on_build_mode_turn_build_mode_on():
	build_buttons.visible = true

func _on_build_button_pressed(placeable):
	print("build button pressed")
	print(placeable.placeable_name)
	BuildMode.select_placeable(placeable)

func _on_build_mode_selection_updated(placeable):
	if placeable == null:
		current_placeable_label.visible = false
	else:
		current_placeable_label.visible = true
		current_placeable_label.text = "Placing " + placeable.placeable_name

# PLACEABLE BOX STUFF
func _on_show_placeable_info(ingredients, building, tile):
	# TODO This function is a mess, clean it up in the final UI
	prep_box.visible = false
	storage_box.visible = false
	if building is PrepBuilding:
		var item_string = building.placeable_name + "\n"
		for food in ingredients:
			item_string += food.name + "\n"
		prep_label.text = item_string
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
	elif building is StorageBuilding:
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
	# TODO other types of placeables, maybe even turning into a case with functions split out
	placeable_box.visible = true

func _on_placeable_button_pressed(placeable):
	if placeable is PrepBuilding:
		placeable.finish()
