extends Interactable

@export var player_data : PlayerData

var small_component_scene = preload("res://objects/resources/dropping/small_component_dropped.tscn")

func interact(user: Node2D):
	if(player_data.inventory.hands_string == "small_component"):
		return
	if(player_data.inventory.hands_string == "empty"):
		player_data.inventory.hands_string = "small_component"
		player_data.player.hand_tscn = small_component_scene
	else:
		var dropped_item = player_data.player.hand_tscn.instantiate()
		player_data.player.get_parent().add_child(dropped_item)
		dropped_item.position.x = player_data.player.position.x
		dropped_item.position.y = player_data.player.position.y
		player_data.inventory.hands_string = "small_component"
		player_data.player.hand_tscn = small_component_scene
	
	update_hand()
	self.queue_free()
		
	
func stop_interaction(user: Node2D):
	pass
	
func update_hand():
	var small_component_texture = preload("res://Art/Assets/objects/small_component.png")
	player_data.player.player_hand.texture = small_component_texture
