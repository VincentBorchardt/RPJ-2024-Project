extends Control

@export var next_scene : PackedScene

@onready var splash_timer = $SplashTimer
@onready var progress_bar = $ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var percent = (1 - (splash_timer.time_left / splash_timer.wait_time)) * 100
	progress_bar.value = percent


func _on_splash_timer_timeout():
	get_tree().change_scene_to_packed(next_scene)
