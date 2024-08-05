extends VBoxContainer

@onready var inventory_slot_0 = $InventorySlot0
@onready var inventory_slot_1 = $InventorySlot1
@onready var inventory_slot_2 = $InventorySlot2
@onready var inventory_slot_3 = $InventorySlot3
@onready var inventory_slot_4 = $InventorySlot4
@onready var current_item_label = $CurrentItemLabel
@onready var trash_button = $TrashButton

func _ready():
	Inventory.current_item_changed.connect(_on_inventory_current_item_changed)
	Inventory.inventory_slot_changed.connect(_on_inventory_inventory_slot_changed)

func _on_inventory_slot_0_pressed():
	Inventory.take_item_from_slot(0)

func _on_inventory_slot_1_pressed():
	Inventory.take_item_from_slot(1)

func _on_inventory_slot_2_pressed():
	Inventory.take_item_from_slot(2)

func _on_inventory_slot_3_pressed():
	Inventory.take_item_from_slot(3)

func _on_inventory_slot_4_pressed():
	Inventory.take_item_from_slot(4)

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
	var button = _select_slot_button(slot)
	if food != null:
		button.attached_food = food
		button.text = food.name
	else:
		button.text = "Empty"
		button.icon = null

func _select_slot_button(slot):
	match slot:
		0: 
			return inventory_slot_0
		1:
			return inventory_slot_1
		2:
			return inventory_slot_2
		3:
			return inventory_slot_3
		4:
			return inventory_slot_4
		_:
			assert(false, "unreachable in _select_slot_button")
			print("slot not connected")

func _on_trash_button_pressed():
	Inventory.trash_current_item()
