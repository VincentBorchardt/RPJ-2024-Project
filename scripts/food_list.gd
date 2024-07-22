extends Node

var beef : Food
var bun : Food
var hamburger : Food

var grill : Building

# Called when the node enters the scene tree for the first time.
func _ready():
	beef = Food.new(
		"Beef", 1, 5, preload("res://assets/sprites/test/tile_0104.png"),
		[], 5, preload("res://assets/sprites/test/tile_0106.png"))
	bun = Food.new(
		"Bun", -1, 5, preload("res://assets/sprites/test/tile_0096.png"),
		[], 3, preload("res://assets/sprites/test/tile_0097.png"))
	hamburger = Food.new(
		"Hamburger", 0, 5, preload("res://assets/sprites/test/tile_0108.png"),
		[beef, bun], 10, preload("res://assets/sprites/test/tile_0109.png"))
	grill = Building.new("Grill", [],
	[hamburger], preload("res://assets/sprites/test/tile_0112.png"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
