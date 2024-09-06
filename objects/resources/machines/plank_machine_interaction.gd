extends Interactable

@export var player_data : PlayerData

var plank_scene = preload("res://objects/resources/dropping/plank_dropped.tscn")

func interact(user: Node2D):
	if(player_data.inventory.hands_string != "wood"):
		return
	if(player_data.inventory.hands_string == "wood"):
		$crafting_time.start()
		$crafting_label.visible = true
		player_data.player.is_crafting = true
		player_data.player.velocity = Vector2(0,0)
		player_data.player.move_speed = 0
		
		player_data.inventory.hands_string = "plank"
		player_data.player.hand_tscn = plank_scene
		
		
		

func _on_crafting_time_timeout():
	update_hand()
	$crafting_label.visible = false
	player_data.player.move_speed = 100
	player_data.player.is_crafting = false
	
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
	
	
	
func stop_interaction(user: Node2D):
	pass
	
func update_hand():
	var plank_texture = preload("res://Art/Assets/objects/plank.png")
	player_data.player.player_hand.texture = plank_texture

	
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


