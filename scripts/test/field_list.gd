extends Node

signal start_planting(food, field)
signal start_timer(wait_time)
signal field_ready(food, field)
signal finish_harvest(food, field)

var field1: Field
var field_array: Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	field1 = Field.new("Field 1", preload("res://assets/sprites/test/tile_0109.png"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_to_field_array(field):
	field_array.append(field)
