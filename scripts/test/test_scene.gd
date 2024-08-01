extends Control

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

var grill = preload("res://resources/placeable/grill.tres")

func _ready():
	BuildingList.prepare_food.connect(_on_building_list_prepare_food)
	BuildingList.ingredient_list_changed.connect(_on_building_list_ingredient_list_changed)
	Inventory.current_item_changed.connect(_on_inventory_current_item_changed)
	Inventory.inventory_slot_changed.connect(_on_inventory_inventory_slot_changed)
	BuildingList.start_building_timer.connect(_on_building_list_start_building_timer)
	BuildingList.food_prepared.connect(_on_building_list_food_prepared)
	BuildingList.finish_creation.connect(_on_building_list_finish_creation)
	FieldList.start_planting.connect(_on_field_list_start_planting)
	FieldList.start_timer.connect(_on_field_list_start_timer)
	FieldList.field_ready.connect(_on_field_list_field_ready)
	FieldList.finish_harvest.connect(_on_field_list_finish_creation)

# FIELD STUFF
func _on_beef_button_pressed():
	FieldList.field1.plant_field(preload("res://resources/food/beef.tres"))

func _on_field_list_start_planting(food, field):
	field1_button.text = food.name + " Growing"
	field1_button.visible = true

func _on_field_list_start_timer(wait_time):
	field1_timer.start(wait_time)

func _on_field_1_timer_timeout():
	FieldList.field1.timer_complete()

func _on_field_list_field_ready(food, field):
	field1_button.text = food.name + " Complete"
	field1_button.disabled = false

func _on_field_1_pressed():
	FieldList.field1.harvest_field()

func _on_field_list_finish_creation(food, field):
	field1_button.disabled = true
	field1_button.visible = false

# GRILL STUFF
func _on_grill_place_button_pressed():
	if Inventory.is_currently_holding_item():
		var current = Inventory.take_current_item()
		grill.add_food(current)

func _on_building_list_ingredient_list_changed(ingredients, building):
	if (not ingredients.is_empty()):
		var item_string = ""
		for food in ingredients:
			item_string += food.name + "\n"
		grill_items.text = item_string
		grill_items.visible = true
	else:
		grill_items.text = ""
		grill_items.visible = false

func _on_building_list_prepare_food(food, building):
		print("making hamburger")
		grill_results.text = food.name + " Preparing"
		grill_results.visible = true

func _on_building_list_start_building_timer(wait_time, building):
	grill_timer.start(wait_time)

func _on_grill_timer_timeout():
	grill.timer_complete()

func _on_building_list_food_prepared(food, building):
	grill_results.text = food.name + " Complete"
	grill_results.disabled = false

func _on_grill_results_button_pressed():
	grill.finish()

func _on_building_list_finish_creation(food, building):
	grill_results.disabled = true
	grill_results.visible = false

# INVENTORY STUFF
func _on_bun_button_pressed():
	# TODO move these checks and similar ones into Inventory,
	# problem is that some like fields do other things
	print("bun button pressed")
	if not Inventory.is_currently_holding_item():
		Inventory.set_current_item(preload("res://resources/food/bun.tres"))

func _on_inventory_0_pressed():
	Inventory.take_item_from_slot(0)

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
