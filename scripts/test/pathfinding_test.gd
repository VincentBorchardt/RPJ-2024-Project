extends Node2D

@export var cell_size = Vector2i(64, 64)

var astar_grid = AStarGrid2D.new()
var grid_size
var start = Vector2i.ZERO
var end = Vector2i(5, 5)
@onready var line_2d = $Line2D

func _ready():
	initialize_grid()
	update_path()

func initialize_grid():
	grid_size = Vector2i(get_viewport_rect().size) / cell_size
	astar_grid.size = grid_size
	astar_grid.cell_size = cell_size
	astar_grid.offset = cell_size / 2
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar_grid.update()

func _draw():
	draw_grid()
	draw_rect(Rect2(start * cell_size, cell_size), Color.GREEN_YELLOW)
	draw_rect(Rect2(end * cell_size, cell_size), Color.ORANGE_RED)
	fill_walls()

func draw_grid():
	for x in grid_size.x + 1:
		draw_line(Vector2(x * cell_size.x, 0),
			Vector2(x * cell_size.x, grid_size.y * cell_size.y),
			Color.DARK_GRAY, 2.0)
	for y in grid_size.y + 1:
		draw_line(Vector2(0, y * cell_size.y),
			Vector2(grid_size.x * cell_size.x, y * cell_size.y),
			Color.DARK_GRAY, 2.0)

func update_path():
	# This is the function that actually gets a path, so you can have multiple points on one grid
	var path = astar_grid.get_point_path(start, end)
	line_2d.points = PackedVector2Array(path)
	print("new path found")
	print(path)
	

func fill_walls():
	for x in grid_size.x:
		for y in grid_size.y:
			if astar_grid.is_point_solid(Vector2i(x, y)):
				draw_rect(Rect2(x * cell_size.x, y * cell_size.y, cell_size.x, cell_size.y), Color.DARK_GRAY)

func _input(event):
	if event is InputEventMouseButton:
		# Add/remove wall
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var pos = Vector2i(event.position) / cell_size
			if astar_grid.is_in_boundsv(pos):
				astar_grid.set_point_solid(pos, not astar_grid.is_point_solid(pos))
			update_path()
			queue_redraw()
