class_name Tile extends Area2D

signal update_tile_feature()

@onready var highlight : Sprite2D = $Highlight
@onready var placeable_icon : Sprite2D = $PlaceableIcon
@onready var placeable_timer : Timer = $PlaceableTimer

@export var tile_feature : Placeable:
	set(value):
		tile_feature = value
		update_tile_feature.emit()

func _ready():
	add_to_group("Tiles")
	BuildMode.turn_build_mode_off.connect(_on_build_mode_turn_build_mode_off)
	BuildMode.turn_build_mode_on.connect(_on_build_mode_turn_build_mode_on)
	BuildingList.start_building_timer.connect(_on_placeable_list_start_timer)
	BuildingList.show_ingredient_list.connect(_on_building_list_show_ingredient_list)
	FieldList.start_timer.connect(_on_placeable_list_start_timer)

func _process(delta):
	if placeable_timer.time_left > 0:
		BuildingList.update_placeable_timer.emit(get_timer_percent_done(), self)

func get_timer_percent_done():
	return (1 - (placeable_timer.time_left / placeable_timer.wait_time)) * 100

func set_placeable(placeable):
	tile_feature = placeable
	highlight.visible = false
	if placeable is Road:
		BuildingList.open_tile.emit(self)
	else:
		BuildingList.open_tile.emit(self)

func _on_build_mode_turn_build_mode_off():
	highlight.visible = false

func _on_build_mode_turn_build_mode_on():
	if (tile_feature == null):
		highlight.visible = true

func _on_input_event(viewport, event, shape_idx):
	# TODO this is getting very messy, doing multiple things
	if event is InputEventMouseButton and event.pressed:
		if BuildMode.can_place() and tile_feature == null:
			var placeable = BuildMode.get_current_placeable()
			if Inventory.can_afford_item(placeable):
				set_placeable(placeable)
				Inventory.current_currency -= placeable.price
				BuildMode.deselect_placeable()
		elif WorkerList.currently_in_worker_mode and tile_feature != null:
			if not (tile_feature is Road):
				print("emitting grid point")
				BuildingList.set_grid_point.emit(self)
		elif (not BuildMode.currently_in_build_mode) and tile_feature != null:
			tile_feature.activate_placeable(self)

func _on_update_tile_feature():
	placeable_icon.texture = tile_feature.base_texture

func _on_placeable_list_start_timer(wait_time, building):
	if(tile_feature == building):
		placeable_timer.start(wait_time)

func _on_placeable_timer_timeout():
	tile_feature.timer_complete()
	BuildingList.update_placeable_timer.emit(get_timer_percent_done(), self)

func _on_building_list_show_ingredient_list(ingredients, building):
	if building == tile_feature:
		# TODO turn the highlight off whenever we close the placeable info
		highlight.visible = true
		BuildingList.show_placeable_info.emit(ingredients, building, self)
