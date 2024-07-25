class_name Field extends Placeable

var current_creation = null

func plant_field(food):
	if current_creation == null:
		current_creation = food
		FieldList.start_planting.emit(current_creation, self)
		FieldList.start_timer.emit(current_creation.time_to_complete)

func timer_complete():
	FieldList.field_ready.emit(current_creation, self)

func harvest_field():
	if (not Inventory.is_currently_holding_item()):
		Inventory.set_current_item(current_creation)
		FieldList.finish_harvest.emit(current_creation, self)
		current_creation = null
