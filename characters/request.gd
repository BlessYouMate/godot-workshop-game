extends Node

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	print(rng.randi_range(0,3))

@export var request: String = global.items[rng.randi_range(0,3)]["Name"]


