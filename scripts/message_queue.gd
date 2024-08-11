extends Node

@export var starting_message : Message
@export var ending_message : Message
@export var messages : Array[Message]
@export var randomize_messages : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_new_message():
	print("getting new message")
	return messages.pop_front()

func get_first_message():
	return starting_message

func get_ending_message():
	return ending_message
