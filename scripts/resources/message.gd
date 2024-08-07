class_name Message extends Resource

@export var speaker : Person
@export_multiline var message : String
@export var image_location : Location

enum Location {LEFT, RIGHT}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass