extends Control

@onready var speaker_label = $SpeakerLabel
@onready var message_label = $MessageLabel

var current_message : Message = null
#var previous_messages : Array[Message] = []


func display_new_message(message):
	# TODO decide if we care about previous messages here (probably not)
	#if current_message != null:
		#previous_messages.append(current_message)
	current_message = message
	speaker_label.text = message.speaker.person_name
	message_label.text = message.message
