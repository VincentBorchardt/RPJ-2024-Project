extends Area2D

signal update_tile_feature()

@export var tile_feature : Placeable:
	set(value):
		tile_feature = value
		update_tile_feature.emit()
