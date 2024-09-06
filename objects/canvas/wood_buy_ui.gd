extends CanvasLayer

@export var player_data: PlayerData

func _on_button_pressed():
	if(player_data.inventory.money >= 2):
		player_data.inventory.money -= 2
		global.wood += 1
	
	
func _process(delta):
	get_node("Control/amount_of_wood/Label").text = str(global.wood)
		
