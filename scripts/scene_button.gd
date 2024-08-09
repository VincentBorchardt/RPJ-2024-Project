class_name SceneButton extends Button

signal pressed_with_scene(scene)

@export var attached_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _pressed():
	pressed_with_scene.emit(attached_scene)
