extends Node2D

@export var next_level : PackedScene

@onready var order_queue = $OrderQueue
@onready var message_queue = $MessageQueue
@onready var game_ui = $GameUI

# Called when the node enters the scene tree for the first time.
func _ready():
	var message = message_queue.get_first_message()
	game_ui.display_message(message)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_game_ui_submit_order():
	# TODO This should really be taking in an item from Inventory initially
	# That future-proofs it against workers submitting orders autonomously
	order_queue.submit_order()
