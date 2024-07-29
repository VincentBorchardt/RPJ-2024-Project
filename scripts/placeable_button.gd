class_name PlaceableButton extends Button

signal pressed_with_placeable(placeable)

@export var attached_placeable: Placeable:
	set(value):
		attached_placeable = value
		if (value != null):
			text = value.placeable_name
			icon = value.base_texture

func _init(placeable):
	attached_placeable = placeable
	# TODO This shouldn't be needed, assuming set works
	#if (placeable != null):
		#text = placeable.placeable_name
		#icon = placeable.base_texture

func _pressed():
	pressed_with_placeable.emit(attached_placeable)
