extends Control

@onready var speaker_label = $SpeakerLabel
@onready var message_label = $MessageLabel

var current_message : Message = null
#var previous_messages : Array[Message] = []


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func display_new_message(message):
	# TODO decide if we care about previous messages here (probably not)
	#if current_message != null:
		#previous_messages.append(current_message)
	current_message = message
	speaker_label.text = message.speaker.person_name
	message_label.text = message.message
