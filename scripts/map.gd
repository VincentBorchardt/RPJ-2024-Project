extends Node

var all_tiles : Array
var road_tiles : Array
var blocked_tiles : Array
var open_tiles : Array

# This is a float in the example code and I don't know why, particularly when we're doing stuff with ints in A*
var tile_size : int = 64
var half_tile_size
# TODO I don't think Godot has Max/Min Int for some reason, this should work
var min_x : int = 9999999
var max_x : int = 0
var min_y : int = 9999999
var max_y : int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	half_tile_size = tile_size / 2
	all_tiles = get_tree().get_nodes_in_group("Tiles")
	open_tiles = all_tiles.duplicate()
	for tile in all_tiles:
		_check_boundaries(tile)
	print(min_x)
	print(min_y)
	print(max_x)
	print(max_y)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _check_boundaries(tile):
	var pos = tile.position
	if pos.x < min_x:
		min_x = pos.x
	elif pos.x > max_x:
		max_x = pos.x
	if pos.y < min_y:
		min_y = pos.y
	elif pos.y > max_y:
		max_y = pos.y
