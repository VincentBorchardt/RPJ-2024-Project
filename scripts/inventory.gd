extends Node

signal current_item_changed(food)
signal inventory_slot_changed(slot, food)

var inventory : Dictionary = {}

var current_hold_item : Food = null

func is_currently_holding_item():
	return (current_hold_item != null)

func get_current_item():
	return current_hold_item

func take_current_item():
	assert(current_hold_item != null)
	var current = current_hold_item
	set_current_item(null)
	return current

# TODO turn this into a proper setter with the emit
func set_current_item(food):
	current_hold_item = food
	# change this to emit a different signal if null?
	current_item_changed.emit(food)

func is_inventory_slot_filled(slot):
	return inventory.has(slot)

func take_item_from_slot(slot):
	var item_to_be_current = null
	if is_inventory_slot_filled(slot):
		item_to_be_current = get_inventory_slot(slot)
		empty_inventory_slot(slot)
	if is_currently_holding_item():
		fill_inventory_slot(0, get_current_item())
	set_current_item(item_to_be_current)

func get_inventory_slot(slot):
	return inventory.get(slot)

func fill_inventory_slot(slot, food):
	inventory[slot] = food
	inventory_slot_changed.emit(slot, food)

func empty_inventory_slot(slot):
	inventory.erase(slot)
	inventory_slot_changed.emit(slot, null)

func trash_current_item():
	if is_currently_holding_item():
		set_current_item(null)
