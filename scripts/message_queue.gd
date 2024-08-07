extends Node

@export var messages : Array[Message]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_new_message():
	print("getting new message")
	return messages.pop_front()
