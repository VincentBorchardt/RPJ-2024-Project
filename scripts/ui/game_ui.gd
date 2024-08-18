extends Control

signal submit_order
signal close_tiles

@export var available_food: Array[Food]
@export var available_placeables: Array[Placeable]

@onready var order_box = $OrderBox
@onready var food_box = $FoodBox
@onready var placeable_box = $PlaceableBox
@onready var message_area = $MessageArea

# Called when the node enters the scene tree for the first time.
func _ready():
	food_box.available_food = available_food
	placeable_box.available_placeables = available_placeables


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func display_message(message):
	message_area.display_new_message(message)

func _on_order_queue_current_orders_changed(orders):
	order_box.change_orders(orders)

func _on_order_box_submit_order():
	submit_order.emit()


func _on_message_queue_send_special_message(message):
	display_message(message)


func _on_order_queue_order_submitted(food):
	pass # Replace with function body.


func _on_tile_popup_close_tiles():
	close_tiles.emit()
