
class_name Food extends Resource

var name : String = "Default Food"
var base_price : int = 0
var time_to_complete : int = 0
var base_texture : Texture2D
var components : Array = []

func _init(label, price, time, texture1, parts):
	print("making " + label)
	name = label
	base_price = price
	time_to_complete = time
	base_texture = texture1
	components = parts


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
