extends VBoxContainer

signal submit_order()

# TODO does this box need a title?
@onready var current_orders = $CurrentOrders

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_order_queue_current_orders_changed(orders):
	current_orders.text = ""
	for food in orders:
		var temp = current_orders.text
		current_orders.text = food.name + "\n" + temp

func _on_submit_button_pressed():
	submit_order.emit()
