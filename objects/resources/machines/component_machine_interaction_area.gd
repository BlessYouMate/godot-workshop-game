extends Interactable

@export var player_data : PlayerData



func interact(user: Node2D):
	if(player_data.player.is_crafting):
		return
	if(player_data.inventory.hands_string != "plank" and player_data.inventory.hands_string != "big_component"
	 and player_data.inventory.hands_string != "medium_component" and player_data.inventory.hands_string != "small_component"):
		return
		
	player_data.player.velocity = Vector2(0,0)
	player_data.player.move_speed = 0
	$crafting_label.visible = true
	player_data.player.is_crafting = true
	$crafting_time.start()
	
	if(player_data.inventory.hands_string == "plank"):
		player_data.inventory.hands_string = "big_component"
		var big_component_scene = preload("res://objects/resources/dropping/big_component_dropped.tscn")
		player_data.player.hand_tscn = big_component_scene
	elif(player_data.inventory.hands_string == "big_component"):
		player_data.inventory.hands_string = "medium_component"
		var medium_component_scene = preload("res://objects/resources/dropping/medium_component_dropped.tscn")
		player_data.player.hand_tscn = medium_component_scene
	elif(player_data.inventory.hands_string == "medium_component"):
		player_data.inventory.hands_string = "small_component"
		var small_component_scene = preload("res://objects/resources/dropping/small_component_dropped.tscn")
		player_data.player.hand_tscn = small_component_scene
	elif(player_data.inventory.hands_string == "small_component"):
		player_data.inventory.hands_string = "shavings"
		var shavings_scene = preload("res://objects/resources/dropping/shavings_dropped.tscn")
		player_data.player.hand_tscn = shavings_scene
	
	
	
func stop_interaction(user: Node2D):
	pass
	
func update_hand():
	if(player_data.inventory.hands_string == "big_component"):
		var big_component_texture = preload("res://Art/Assets/objects/big_component.png")
		player_data.player.player_hand.texture = big_component_texture
	elif(player_data.inventory.hands_string == "medium_component"):
		var medium_component_texture = preload("res://Art/Assets/objects/medium_component.png")
		player_data.player.player_hand.texture = medium_component_texture
	elif(player_data.inventory.hands_string == "small_component"):
		var small_component_texture = preload("res://Art/Assets/objects/small_component.png")
		player_data.player.player_hand.texture = small_component_texture
	elif(player_data.inventory.hands_string == "shavings"):
		var shavings_texture = preload("res://Art/Assets/objects/shavings.png")
		player_data.player.player_hand.texture = shavings_texture
var level = 0
func upgrade(user: Node2D):
	if(level == 0):
		if(player_data.inventory.money >= 5):
			player_data.inventory.money -= 5
			$crafting_time.wait_time -= 1
			level = 1
			$upgrade_label.visible = true
			return
	if(level == 1):
		if(player_data.inventory.money >= 10):
			player_data.inventory.money -= 10
			$crafting_time.wait_time -= 1
			level = 2
			$upgrade_label.visible = true
			return
	if(level == 2):
		if(player_data.inventory.money >= 15):
			player_data.inventory.money -= 15
			$crafting_time.wait_time -= 1
			level = 3
			$upgrade_label.visible = true
			return
	
	
	
func _ready():
	$Label.visible = false
	$crafting_label.visible = false
	$Label2.visible = false
	$upgrade_label.visible = false
	
func _on_area_entered(area):
	$Label.visible = true
	$Label2.visible = true
func _on_area_exited(area):
	$Label.visible = false
	$Label2.visible = false
	$upgrade_label.visible = false


func _on_crafting_time_timeout():
	update_hand()
	$crafting_label.visible = false
	player_data.player.move_speed = 100
	player_data.player.is_crafting = false
