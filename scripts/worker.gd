class_name Worker extends Resource

var id : int

var start_tile : Tile
var end_tile : Tile
var path : PackedVector2Array
var current_item : Food

func reset():
	start_tile = null
	end_tile = null
	path = []
	current_item = null
