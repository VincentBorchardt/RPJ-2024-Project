extends Node2D

@onready var message_queue = $MessageQueue
@onready var cutscene_ui = $CutsceneUI

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_cutscene_ui_get_new_message():
	if not message_queue:
		await self.ready
	var message = message_queue.get_new_message()
	if message != null:
		cutscene_ui.display_new_message(message)
	else:
		# move to a new scene
		pass
