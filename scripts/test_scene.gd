extends Control

var inventory1 : Food = null
var current_grill: Food = null
var field1 : Food = null
var field2 : Food = null

# in the final UI these will all be in different scripts,
# probably corresponding to their containers
@onready var current_item_label = $InventoryContainer/CurrentItem
@onready var inventory0_button = $InventoryContainer/Inventory0
@onready var inventory1_button = $InventoryContainer/Inventory1
@onready var grill_items = $BuildingContainer/GrillItems
@onready var grill_place = $BuildingContainer/GrillPlaceButton
@onready var grill_results = $BuildingContainer/GrillResultsButton
@onready var grill_timer = $BuildingContainer/GrillTimer
@onready var field1_button = $FieldContainer/Field1
@onready var field2_button = $FieldContainer/Field2
@onready var field1_timer = $FieldContainer/Field1/Field1Timer


func _ready():
	BuildingList.prepare_food.connect(_on_building_list_prepare_food)
	BuildingList.ingredient_list_changed.connect(on_building_list_ingredient_list_changed)
	Inventory.current_item_changed.connect(_on_inventory_current_item_changed)
	Inventory.inventory_slot_changed.connect(_on_inventory_inventory_slot_changed)

func plant_field1(food):
	field1 = food
	field1_button.text = food.name + " Growing"
	field1_button.visible = true
	field1_timer.start(food.time_to_complete)

func _on_bun_button_pressed():
	# TODO move these checks and similar ones into Inventory,
	# problem is that some like fields do other things
	print("bun button pressed")
	if not Inventory.is_currently_holding_item():
		Inventory.set_current_item(FoodList.bun)

func _on_inventory_0_pressed():
	Inventory.take_item_from_slot(0)

func _on_beef_button_pressed():
	if field1 == null:
		plant_field1(FoodList.beef)

func _on_field_1_timer_timeout():
	field1_button.text = field1.name + " Complete"
	field1_button.disabled = false

func _on_field_1_pressed():
	if (not Inventory.is_currently_holding_item()):
		Inventory.set_current_item(field1)
		field1_button.disabled = true
		field1_button.visible = false

func _on_grill_place_button_pressed():
	if Inventory.is_currently_holding_item():
		var current = Inventory.get_current_item()
		BuildingList.grill.add_food(current)
		Inventory.set_current_item(null)

func _on_building_list_prepare_food(food, building):
	if current_grill == null:
		print("making hamburger")
		# remove items from ingredients, and the corresponding labels
		grill_results.text = food.name + " Preparing"
		grill_results.visible = true
		current_grill = food
		grill_timer.start(food.time_to_complete)

func _on_grill_timer_timeout():
	grill_results.text = current_grill.name + " Complete"
	grill_results.disabled = false

func _on_grill_results_button_pressed():
	if (not Inventory.is_currently_holding_item()):
		Inventory.set_current_item(current_grill)
		current_grill = null

func _on_inventory_current_item_changed(food):
	if (food != null):
		print("setting current item")
		current_item_label.text = food.name
		current_item_label.visible = true
	else:
		print("removing current item")
		current_item_label.visible = false

func _on_inventory_inventory_slot_changed(slot, food):
	var name
	if food != null:
		name = food.name
	else:
		name = "Empty"
	match slot:
		0: 
			inventory0_button.text = name
		_:
			print("slot not connected")

func on_building_list_ingredient_list_changed(ingredients, building):
	if (not ingredients.is_empty()):
		var item_string = ""
		for food in ingredients:
			item_string += food.name + "\n"
		grill_items.text = item_string
		grill_items.visible = true
	else:
		grill_items.text = ""
		grill_items.visible = false
