extends Control

signal get_new_message()

@onready var speaker_label = $SpeakerLabel
@onready var cutscene_message = $CutsceneMessage
var current_message : Message
var previous_messages : Array[Message] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	get_new_message.emit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func display_new_message(message):
	if current_message != null:
		previous_messages.append(current_message)
	current_message = message
	speaker_label.text = message.speaker.person_name
	cutscene_message.text = message.message

func _on_advance_text_button_pressed():
	get_new_message.emit()
