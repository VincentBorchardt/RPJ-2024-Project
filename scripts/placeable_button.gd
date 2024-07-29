extends Button

signal pressed_with_placeable(placeable)

@export var attached_placeable: Placeable = null:
	set(value):
		attached_placeable = value
		text = value.name
		icon = value.base_texture

func _init(placeable):
	attached_placeable = placeable
	text = placeable.name
	icon = placeable.base_texture

func _pressed():
	pressed_with_placeable.emit(attached_placeable)
