class_name Placeable extends Resource

@export var placeable_name : String = "Default Placeable"
@export var price : int
@export var base_texture : Texture2D

# TODO A lot of shared logic between buildings and road should go here eventually

func activate_placeable(_tile):
	assert(false, "base placeable activate_placeable called")
	pass

func timer_complete():
	assert(false, "base placeable timer_complete called")
	pass
