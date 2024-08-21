class_name PlaceableButton extends Button

signal pressed_with_placeable(placeable)

@export var attached_placeable: Placeable:
	set(value):
		attached_placeable = value
		if (value != null):
			if icon == null:
				icon = value.base_texture
			if text == "":
				text = "Build " + value.placeable_name + ": Cost=" + str(value.price)

func _pressed():
	pressed_with_placeable.emit(attached_placeable)
