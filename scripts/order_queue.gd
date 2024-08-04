class_name OrderQueue extends Node

signal current_orders_changed(orders)
signal end_level()

@export var upcoming_orders: Array[Food] = []
@export var endless: bool = false

var current_orders: Array[Food] = []
var ending_level: bool = false
@onready var order_timer = $OrderTimer
@onready var end_level_timer = $EndLevelTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	# randomize the array of upcoming orders
	pass # Replace with function body.


# TODO this might need some special casing for story purposes, like making the final order important
# or making the tutorial work right
func _process(delta):
	if not ending_level:
		if current_orders.is_empty():
			if upcoming_orders.is_empty():
				print("end level started")
				ending_level = true
				end_level_timer.start(3)
			else:
				add_current_order()

func add_current_order():
	assert (upcoming_orders.is_empty() != true)
	var new_order = upcoming_orders.pop_back()
	current_orders.append(new_order)
	current_orders_changed.emit(current_orders)

func submit_order():
	if Inventory.is_currently_holding_item():
		var food = Inventory.take_current_item()
		if current_orders.has(food):
			# TODO add code if food isn't in there?
			# or accept that inventory trashes the item if you submit wrong?
			current_orders.erase(food)
			current_orders_changed.emit(current_orders)


func _on_end_level_timer_timeout():
	print("end level timer timeout")
	end_level.emit()
