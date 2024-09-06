extends CanvasLayer

@export var player_data : PlayerData = preload("res://data/player_1_data.tres")

func _process(_delta):
	$Control/money/money_label.text = str(player_data.inventory.money)
	$Control/exp/exp_label.text = str(player_data.inventory.exp)	
