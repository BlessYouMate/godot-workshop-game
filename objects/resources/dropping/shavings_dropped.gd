extends Interactable

@export var player_data : PlayerData

var shavings_scene = preload("res://objects/resources/dropping/shavings_dropped.tscn")

func interact(user: Node2D):
	if(player_data.inventory.hands_string == "shavings"):
		return
	if(player_data.inventory.hands_string == "empty"):
		player_data.inventory.hands_string = "shavings"
		player_data.player.hand_tscn = shavings_scene
	else:
		var dropped_item = player_data.player.hand_tscn.instantiate()
		player_data.player.get_parent().add_child(dropped_item)
		dropped_item.position.x = player_data.player.position.x
		dropped_item.position.y = player_data.player.position.y
		player_data.inventory.hands_string = "shavings"
		player_data.player.hand_tscn = shavings_scene
	update_hand()
	self.queue_free()
		
	
func stop_interaction(user: Node2D):
	pass
	
func update_hand():
	var shavings_texture = preload("res://Art/Assets/objects/shavings.png")
	player_data.player.player_hand.texture = shavings_texture
