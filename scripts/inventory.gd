extends Node

signal current_item_changed(food)

# TODO change this to a dictionary
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

func get_current_item():
	return current_hold_item

func set_current_item(food):
	current_hold_item = food
	# change this to emit a different signal if null?
	current_item_changed.emit(food)
