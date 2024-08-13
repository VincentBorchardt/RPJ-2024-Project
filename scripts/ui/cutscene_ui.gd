extends Control

signal get_new_message()

@onready var cutscene_message_area = $CutsceneMessageArea
@onready var left_image = $LeftImage
@onready var right_image = $RightImage

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_cutscene_message_area_get_new_message():
	get_new_message.emit()

func display_new_message(message):
	var picture
	if message.alt_picture != null:
		picture = message.alt_picture
	else:
		picture = message.speaker.full_picture
	if message.image_location == Message.Location.LEFT:
		left_image.texture = picture
	elif message.image_location == Message.Location.RIGHT:
		right_image.texture = picture
	cutscene_message_area.display_new_message(message)
