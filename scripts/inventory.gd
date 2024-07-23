extends Node

signal current_item_changed(food)
signal inventory_slot_changed(slot, food)

# TODO change this to a dictionary
var inventory : Dictionary = {}

var current_hold_item : Food = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func is_currently_holding_item():
	return (current_hold_item != null)

func get_current_item():
	return current_hold_item

func set_current_item(food):
	current_hold_item = food
	# change this to emit a different signal if null?
	current_item_changed.emit(food)

func is_inventory_slot_filled(slot):
	return inventory.has(slot)

func get_inventory_slot(slot):
	return inventory[slot]

func fill_inventory_slot(slot, food):
	inventory[slot] = food
	inventory_slot_changed.emit(slot, food)

func empty_inventory_slot(slot):
	inventory.erase(slot)
	inventory_slot_changed.emit(slot, null)
