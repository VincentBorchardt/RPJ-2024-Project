extends CanvasLayer

@onready var credits_label = $CreditsLabel
@onready var licenses_label = $LicensesLabel
@onready var options_box = $OptionsBox


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func close_popup():
	credits_label.visible = false
	licenses_label.visible = false
	options_box.visible = false
	self.visible = false

func show_options():
	close_popup()
	options_box.visible = true
	self.visible = true

func show_credits():
	close_popup()
	credits_label.visible = true
	self.visible = true

func show_licenses():
	close_popup()
	licenses_label.visible = true
	self.visible = true


func _on_money_button_toggled(toggled_on):
	pass # Replace with function body.


func _on_timer_button_toggled(toggled_on):
	pass # Replace with function body.


func _on_close_button_pressed():
	close_popup()
