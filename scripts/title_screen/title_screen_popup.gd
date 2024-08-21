extends CanvasLayer

@onready var credits_label = $CreditsLabel
@onready var licenses_label = $LicensesLabel
@onready var instructions_label = $InstructionsLabel
@onready var cookbook_food_label = $CookbookFoodLabel
@onready var cookbook_building_label = $CookbookBuildingLabel
@onready var options_box = $OptionsBox

@onready var cookbook_generator = $CookbookGenerator
var unique_orders


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func close_popup():
	credits_label.visible = false
	licenses_label.visible = false
	instructions_label.visible = false
	cookbook_food_label.visible = false
	cookbook_building_label.visible = false
	options_box.visible = false
	self.visible = false

func show_credits():
	close_popup()
	credits_label.visible = true
	self.visible = true

func show_licenses():
	close_popup()
	licenses_label.visible = true
	self.visible = true

func show_instructions():
	close_popup()
	instructions_label.visible = true
	self.visible = true

func show_cookbook():
	close_popup()
	cookbook_food_label.text = cookbook_generator.generate_full_food_cookbook()
	cookbook_building_label.text = cookbook_generator.generate_full_building_cookbook()
	cookbook_food_label.visible = true
	cookbook_building_label.visible = true
	self.visible = true

func show_options():
	close_popup()
	options_box.visible = true
	self.visible = true

func _on_money_button_toggled(toggled_on):
	GameManager.easy_money = toggled_on

func _on_timer_button_toggled(toggled_on):
	GameManager.easy_timers = toggled_on

func _on_close_button_pressed():
	close_popup()
