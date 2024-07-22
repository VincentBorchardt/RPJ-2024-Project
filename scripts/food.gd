
class_name Food extends Resource

var name : String = "Default Food"
var base_price : int = 0
var time_to_complete : int = 0
var base_texture : Texture2D
var components : Array = []
var prepared_price : int = 0
var prepared_texture : Texture2D

func _init(label, price1, time, texture1, parts, price2, texture2):
	print("making " + label)
	name = label
	base_price = price1
	time_to_complete = time
	base_texture = texture1
	components = parts
	prepared_price = price2
	prepared_texture = texture2


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
