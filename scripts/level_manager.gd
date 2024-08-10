extends Node2D

@export var next_level : PackedScene

@onready var order_queue = $OrderQueue

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_game_ui_submit_order():
	# TODO This should really be taking in an item from Inventory initially
	# That future-proofs it against workers submitting orders autonomously
	order_queue.submit_order()
