class_name PlaceableButton extends Button

signal pressed_with_placeable(placeable)

@export var attached_placeable: Placeable:
	set(value):
		attached_placeable = value
		if (value != null):
			text = value.placeable_name
			icon = value.base_texture

func _pressed():
	pressed_with_placeable.emit(attached_placeable)
