extends Area2D

signal update_tile_feature()

@onready var highlight : Sprite2D = $Highlight
@onready var placeable_icon : Sprite2D = $PlaceableIconIcon

@export var tile_feature : Placeable:
	set(value):
		tile_feature = value
		update_tile_feature.emit()

func _ready():
	BuildMode.turn_build_mode_off.connect(_on_build_mode_turn_build_mode_off)
	BuildMode.turn_build_mode_on.connect(_on_build_mode_turn_build_mode_on)

func _on_build_mode_turn_build_mode_off():
	highlight.visible = false

func _on_build_mode_turn_build_mode_on():
	if (tile_feature == null):
		highlight.visible = true
