extends Node

@onready var popup = $TitleScreenPopup

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_title_screen_left_box_show_options():
	popup.show_options()


func _on_credits_button_pressed():
	popup.show_credits()


func _on_licenses_button_pressed():
	popup.show_licenses()
