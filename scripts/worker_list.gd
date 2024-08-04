extends Node

signal update_worker_info(worker)
signal update_worker_path(worker)

var workers : Dictionary = {}
var current_id = 1

var currently_in_worker_mode = false
var current_worker : Worker = null

# Called when the node enters the scene tree for the first time.
func _ready():
	BuildingList.set_grid_point.connect(_on_building_list_set_grid_point)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# TODO I need to make sure this creates unique workers, unlike the current problems with buildings
func create_worker():
	var new_worker = Worker.new()
	new_worker.id = current_id
	workers[1] = new_worker
	current_id += 1
	return new_worker

func start_worker_mode(worker):
	if not currently_in_worker_mode:
		currently_in_worker_mode = true
		current_worker = worker
		worker.reset()

func _on_building_list_set_grid_point(tile):
	print("starting set grid point")
	var start = current_worker.start_tile
	var end = current_worker.end_tile
	if start == null:
		current_worker.start_tile = tile
		update_worker_info.emit(current_worker)
	elif end == null:
		current_worker.end_tile = tile
		update_worker_info.emit(current_worker)
		update_worker_path.emit(current_worker)
		currently_in_worker_mode = false
		current_worker = null
