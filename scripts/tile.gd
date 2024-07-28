extends Area2D

signal update_tile_feature()

@onready var highlight : Sprite2D = $Highlight
@onready var placeable_icon : Sprite2D = $PlaceableIcon

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

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		if BuildMode.can_place() and tile_feature == null:
			var placeable = BuildMode.get_current_placeable()
			tile_feature = placeable
			highlight.visible = false
			BuildMode.select_placeable(null)
		elif (not BuildMode.currently_in_build_mode) and tile_feature != null:
			tile_feature.activate_placeable(self)

func _on_update_tile_feature():
	print("tile feature updated")
	placeable_icon.texture = tile_feature.base_texture
