extends Node

# TODO figure out if this would be better as an component of each scene rather than an autoload

signal current_item_changed(food)
signal inventory_slot_changed(slot, food)
signal currency_changed(currency_count)

var starting_currency : int = 100

var inventory : Dictionary = {}

var current_hold_item : Food = null:
	set(food):
		current_hold_item = food
		current_item_changed.emit(food)

var current_currency : int = 0:
	set(value):
		assert(value >= 0)
		current_currency = value
		currency_changed.emit(value)

func _ready():
	clear_inventory()
	print(current_currency)

func is_currently_holding_item():
	return (current_hold_item != null)

func can_afford_item(item):
	if (item is Food) or (item is Placeable):
		return item.price <= current_currency
	else:
		assert(false, "unreachable in can_afford_item")
		print("default in can_afford_item")

func get_current_item():
	return current_hold_item

func take_current_item():
	assert(current_hold_item != null)
	var current = current_hold_item
	current_hold_item = null
	return current

func attempt_to_purchase_item(food):
	if (not is_currently_holding_item()) and can_afford_item(food):
		current_hold_item = food
		current_currency -= food.price

func sell_item(food):
	current_currency += food.price

#func set_current_item(food):
	#current_hold_item = food
	#current_item_changed.emit(food)

func is_inventory_slot_filled(slot):
	return inventory.has(slot)

func take_item_from_slot(slot):
	var item_to_be_current = null
	if is_inventory_slot_filled(slot):
		item_to_be_current = get_inventory_slot(slot)
		empty_inventory_slot(slot)
	if is_currently_holding_item():
		fill_inventory_slot(slot, get_current_item())
	current_hold_item = item_to_be_current

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
		current_hold_item = null

func reset_currency():
	current_currency = starting_currency

func clear_inventory():
	inventory.clear()
	trash_current_item()
	reset_currency()
