extends Control

@export var available_food: Array[Food]
@export var available_placeables: Array[Placeable]

@onready var order_box = $OrderBox
@onready var food_box = $FoodBox
@onready var placeable_box = $PlaceableBox

# Called when the node enters the scene tree for the first time.
func _ready():
	food_box.available_food = available_food
	placeable_box.available_placeables = available_placeables


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_order_queue_current_orders_changed(orders):
	order_box.change_orders(orders)
