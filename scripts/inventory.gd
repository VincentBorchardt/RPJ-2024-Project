extends Node

var inventory : Array = []
var inventory_max_size : int = 5
var inventory_current_size : int = 0

var current_hold_item : Food = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func currently_holding_item():
	return (current_hold_item != null)
