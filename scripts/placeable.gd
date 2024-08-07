class_name Placeable extends Resource

@export var placeable_name : String = "Default Placeable"
@export var price : int
@export var base_texture : Texture2D

# TODO A lot of shared logic between buildings and road should go here eventually

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func activate_placeable(tile):
	assert(false, "base placeable activate_placeable called")
	pass

func timer_complete():
	assert(false, "base placeable timer_complete called")
	pass
