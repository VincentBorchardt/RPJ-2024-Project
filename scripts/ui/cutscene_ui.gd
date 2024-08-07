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
	if message.image_location == Message.Location.LEFT:
		left_image.texture = message.speaker.full_picture
	elif message.image_location == Message.Location.RIGHT:
		right_image.texture = message.speaker.full_picture
	cutscene_message_area.display_new_message(message)
