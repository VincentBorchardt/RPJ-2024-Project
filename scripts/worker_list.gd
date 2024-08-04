class_name WorkerList extends Node

var workers : Dictionary = {}
var current_id = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


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
