extends VBoxContainer

signal submit_order()

# TODO does this box need a title?
@onready var current_orders = $CurrentOrders

func change_orders(orders):
	current_orders.text = ""
	for food in orders:
		var temp = current_orders.text
		current_orders.text = food.name + "\n" + temp

func _on_submit_button_pressed():
	submit_order.emit()
