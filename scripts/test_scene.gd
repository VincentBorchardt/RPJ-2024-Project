extends Control

var current_item : Food = null
var inventory0 : Food = null
var inventory1 : Food = null
var grill_items : Array[Food] = []
var current_grill: Food = null
var field1 : Food = null
var field2 : Food = null

@onready var current_item_label = $InventoryContainer/CurrentItem
@onready var inventory0_button = $InventoryContainer/Inventory0
@onready var inventory1_button = $InventoryContainer/Inventory1
@onready var grill_item1 = $BuildingContainer/Item1
@onready var grill_item2 = $BuildingContainer/Item2
@onready var grill_place = $BuildingContainer/GrillPlaceButton
@onready var grill_results = $BuildingContainer/GrillResultsButton
@onready var grill_timer = $BuildingContainer/GrillTimer
@onready var field1_button = $FieldContainer/Field1
@onready var field2_button = $FieldContainer/Field2
@onready var field1_timer = $FieldContainer/Field1/Field1Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	BuildingList.prepare_food.connect(_on_signal_bus_prepare_food)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_current_item(food):
	print("setting current item")
	current_item = food
	current_item_label.text = food.name
	current_item_label.visible = true

func remove_current_item():
	print("removing current item")
	current_item = null
	current_item_label.visible = false

func plant_field1(food):
	field1 = food
	field1_button.text = food.name + " Growing"
	field1_button.visible = true
	field1_timer.start(food.time_to_complete)

func _on_bun_button_pressed():
	print("bun button pressed")
	if current_item == null:
		set_current_item(FoodList.bun)

func _on_inventory_0_pressed():
	if current_item != null and inventory0 == null:
		inventory0 = current_item
		inventory0_button.text = current_item.name
		remove_current_item()

func _on_beef_button_pressed():
	if field1 == null:
		plant_field1(FoodList.beef)

func _on_field_1_timer_timeout():
	field1_button.text = field1.name + " Complete"
	field1_button.disabled = false

func _on_field_1_pressed():
	if current_item == null:
		set_current_item(field1)
		field1_button.disabled = true
		field1_button.visible = false


func _on_grill_place_button_pressed():
	if current_item != null:
		grill_items.append(current_item)
		if not grill_item1.visible:
			grill_item1.text = current_item.name
			grill_item1.visible = true
		elif not grill_item2.visible:
			grill_item2.text = current_item.name
			grill_item2.visible = true
		remove_current_item()
		check_prepare_food(grill_items)

func check_prepare_food(ingredients):
	BuildingList.grill.check_prepare_food(ingredients)

func _on_signal_bus_prepare_food(food, building):
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
	if current_item == null:
		set_current_item(current_grill)
		current_grill = null
