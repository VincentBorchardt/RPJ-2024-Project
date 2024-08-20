class_name OrderQueue extends Node

signal current_orders_changed(orders)
signal order_submitted(food)
signal start_ending_level()
signal end_level()

@export var upcoming_orders: Array[Food] = []
#@export var order_delay: int
@export var time_between_orders: int
@export var endless: bool = false

var current_orders: Array[Food] = []
var ending_level: bool = false
@onready var order_timer = $OrderTimer
@onready var end_level_timer = $EndLevelTimer

@onready var chicken_dessert = preload("res://resources/food/chicken_dessert.tres")

# Called when the node enters the scene tree for the first time.
func _ready():
	# randomize the array of upcoming orders?
	order_timer.wait_time = time_between_orders
	start_adding_orders()


# TODO this might need some special casing for story purposes, like making the final order important
# or making the tutorial work right
func _process(delta):
	if not ending_level:
		if current_orders.is_empty():
			if upcoming_orders.is_empty():
				end_level_function()
			else:
				add_current_order()

func end_level_function():
	start_ending_level.emit()
	ending_level = true
	end_level_timer.start(3)

func add_current_order():
	assert (upcoming_orders.is_empty() != true)
	var new_order = upcoming_orders.pop_front()
	current_orders.append(new_order)
	current_orders_changed.emit(current_orders)

func submit_order():
	if Inventory.is_currently_holding_item():
		var food = Inventory.take_current_item()
		if current_orders.has(food):
			# TODO add code if food isn't in there?
			# or accept that inventory trashes the item if you submit wrong?
			Inventory.sell_item(food)
			current_orders.erase(food)
			order_submitted.emit(food)
			# TODO probably a signal here to do UI stuff like the customer coming up?
			current_orders_changed.emit(current_orders)
			if food == chicken_dessert:
				end_level_function()

func start_adding_orders():
	order_timer.start()

func _on_end_level_timer_timeout():
	print("end level timer timeout")
	end_level.emit()

func _on_order_timer_timeout():
	#print("order timer trigger")
	if not upcoming_orders.is_empty():
		add_current_order()
