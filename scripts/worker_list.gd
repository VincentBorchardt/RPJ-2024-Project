extends Node

signal update_worker_info(worker)
signal update_worker_path(worker)
signal turn_worker_mode_off()
signal turn_worker_mode_on()

var workers : Dictionary = {}
var current_id = 1

var currently_in_worker_mode = false
var current_worker : Worker = null

# Called when the node enters the scene tree for the first time.
func _ready():
	BuildingList.set_grid_point.connect(_on_building_list_set_grid_point)

func create_worker():
	var new_worker = Worker.new()
	new_worker.id = current_id
	workers[1] = new_worker
	current_id += 1
	return new_worker

func end_worker_mode():
	currently_in_worker_mode = false
	current_worker = null
	turn_worker_mode_off.emit()

func start_worker_mode(worker):
	BuildMode.set_build_mode(false)
	if not currently_in_worker_mode:
		currently_in_worker_mode = true
		current_worker = worker
		worker.reset()
		turn_worker_mode_on.emit()

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
		end_worker_mode()
