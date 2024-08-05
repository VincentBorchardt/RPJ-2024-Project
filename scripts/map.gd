extends Node

var all_tiles : Array
var open_tiles : Array = []
var blocked_tiles : Array = []
var bare_tiles : Array

# This is a float in the example code and I don't know why, particularly when we're doing stuff with ints in A*
var tile_size : Vector2i = Vector2i(64, 64)
var half_tile_size : Vector2i
# TODO I don't think Godot has Max/Min Int for some reason, this should work
# Also not sure if this is needed
var min_x : int = 9999999
var max_x : int = 0
var min_y : int = 9999999
var max_y : int = 0

var astar_grid = AStarGrid2D.new()
# TODO This needs to be hardcoded, I don't know if there's an algorithmic way
# Theoretically if the grid is too big it shouldn't matter since blank cells can't be traversed
# TileTestScene's Grid is 8 by 4
var grid_origin = Vector2i(0, 0)
var grid_size = Vector2i(8, 4)

func _ready():
	_initialize_tiles()
	_initialize_grid()
	BuildingList.open_tile.connect(_open_tile)
	BuildingList.block_tile.connect(_block_tile)
	WorkerList.update_worker_path.connect(_update_worker_path)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _initialize_tiles():
	half_tile_size = tile_size / 2
	all_tiles = get_tree().get_nodes_in_group("Tiles")
	bare_tiles = all_tiles.duplicate()
	for tile in all_tiles:
		_check_boundaries(tile)

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

func _initialize_grid():
	astar_grid.size = grid_size
	astar_grid.cell_size = tile_size
	astar_grid.offset = half_tile_size
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	var grid_rect = Rect2i(grid_origin, grid_size)
	astar_grid.fill_solid_region(grid_rect, true)
	astar_grid.update()

func _block_grid_point(position, bool=true):
	var grid_pos = Vector2i(position) / tile_size
	if astar_grid.is_in_boundsv(grid_pos):
		astar_grid.set_point_solid(grid_pos, bool)

func _open_tile(tile):
	print("tile opened")
	bare_tiles.erase(tile)
	open_tiles.append(tile)
	_block_grid_point(tile.position, false)

func _block_tile(tile):
	print("tile_blocked")
	bare_tiles.erase(tile)
	blocked_tiles.append(tile)
	_block_grid_point(tile.position, true)

func _update_worker_path(worker):
	print(open_tiles.map(translate_tile))
	var start = worker.start_tile.position / tile_size.x
	print(start)
	var end = worker.end_tile.position / tile_size.x
	print(end)
	var path = astar_grid.get_point_path(Vector2i(start), Vector2i(end))
	worker.path = path
	print(path)
	print(Array(path).map(func div(vec) : return vec / 64))

func translate_tile(tile):
	return tile.position / 64
