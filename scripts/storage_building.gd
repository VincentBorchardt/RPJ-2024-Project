class_name StorageBuilding extends Placeable

@export var food_stored : Array[Food] = []
# this is true if it makes stuff, false if it just stores stuff
# non-producers are a decent way off though
@export var producer = true

#func _init(label, stored, picture, is_producer):
	#placeable_name = label
	#food_stored = stored
	#base_texture = picture
	#producer = is_producer

func activate_placeable(tile):
	if not Inventory.is_currently_holding_item():
		BuildingList.show_ingredient_list.emit(food_stored, self)
