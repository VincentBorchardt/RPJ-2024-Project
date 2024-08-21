extends Control

signal submit_order
signal close_tiles

@export var available_food: Array[Food]
@export var available_placeables: Array[Placeable]
var unique_orders : Array

@onready var order_box = $OrderBox
@onready var food_box = $FoodScroll/FoodBox
@onready var placeable_box = $PlaceableScroll/PlaceableBox
@onready var message_area = $MessageArea
@onready var play_scene_popup = $PlayScenePopup

# Called when the node enters the scene tree for the first time.
func _ready():
	food_box.available_food = available_food
	placeable_box.available_placeables = available_placeables
	Inventory.clear_inventory()

func display_message(message):
	message_area.display_new_message(message)

func _on_order_queue_current_orders_changed(orders):
	order_box.change_orders(orders)

func _on_order_box_submit_order():
	submit_order.emit()


func _on_message_queue_send_special_message(message):
	display_message(message)

func _on_tile_popup_close_tiles():
	close_tiles.emit()


func _on_cookbook_button_pressed():
	play_scene_popup.show_cookbook(available_food, available_placeables, unique_orders)


func _on_order_queue_fail_level(num_orders, is_endless):
	play_scene_popup.show_fail_screen(num_orders, is_endless)


func _on_order_queue_share_unique_orders(orders):
	unique_orders = orders
