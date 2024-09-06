extends Interactable

@export var player_data: PlayerData



func interact(user: Node2D):
	if(player_data.inventory.hands_string == "empty"):
		return
	var dropped_item = player_data.player.hand_tscn.instantiate()
	self.add_child(dropped_item)
	dropped_item.position.x = 0
	dropped_item.position.y = -4
	player_data.inventory.hands_string = "empty"
	update_hand()

func stop_interaction(user: Node2D):
	pass


func update_hand():
	var none_texture = preload("res://Art/Assets/objects/none.png")
	player_data.player.player_hand.texture = none_texture
