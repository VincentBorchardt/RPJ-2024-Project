
class_name Food extends Resource

@export var name : String = "Default Food"
@export var price : int = 0
@export var time_to_complete : int = 0
@export var base_texture : Texture2D
@export var components : Array[Food] = []

#func _init(label, price, time, texture1, parts):
	#print("making " + label)
	#name = label
	#base_price = price
	#time_to_complete = time
	#base_texture = texture1
	#components = parts

func _to_string():
	var string = ""
	string += name + "\n"
	string += "  Price = " + str(price) + "\n"
	if time_to_complete > 0:
		string += "  Time to Complete = " + str(time_to_complete) + " sec. \n"
	if not components.is_empty():
		string += "  Components: "
		for food in components:
			string += food.name + ", "
		string += "\n"
	return string
