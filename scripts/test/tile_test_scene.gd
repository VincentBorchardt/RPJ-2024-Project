extends Node2D

@onready var order_queue = $OrderQueue

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_tile_test_ui_submit_order():
	order_queue.submit_order()
