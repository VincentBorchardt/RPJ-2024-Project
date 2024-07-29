extends Node

var cow : Food
var beef : Food
var bun : Food
var hamburger : Food

func _ready():
	cow = Food.new(
		"Cow", 1, 2, preload("res://assets/sprites/test/tile_0118.png"),
		[]
	)
	beef = Food.new(
		"Beef", 3, 5, preload("res://assets/sprites/test/tile_0104.png"),
		[cow]
	)
	bun = Food.new(
		"Bun", 5, 10, preload("res://assets/sprites/test/tile_0096.png"),
		[]
	)
	hamburger = Food.new(
		"Hamburger", 10, 5, preload("res://assets/sprites/test/tile_0108.png"),
		[beef, bun]
	)

