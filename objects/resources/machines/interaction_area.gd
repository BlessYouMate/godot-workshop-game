class_name TableInteraction
extends Interactable
@export var player_data : PlayerData
@export var table_storage : TableStorage

var in_area = 0

func add_com(user: Node2D):
	var hand = player_data.player.inventory.hands_string 
	if(hand == "empty" or hand == "wood" or hand == "plank" or hand == "shavings"):
		pass
	else:
		if(hand == "big_component"):
			table_storage.b_com += 1
			player_data.player.inventory.hands_string = "empty"
			update_hand()
			get_node("making_table_ui/Control/req/big/n_in").text = str(table_storage.b_com)
		if(hand == "medium_component"):
			table_storage.m_com += 1
			player_data.player.inventory.hands_string = "empty"
			update_hand()
			get_node("making_table_ui/Control/req/medium/n_in").text = str(table_storage.m_com)
		if(hand == "small_component"):
			table_storage.s_com += 1 
			player_data.player.inventory.hands_string = "empty"
			update_hand()
			get_node("making_table_ui/Control/req/small/n_in").text = str(table_storage.s_com)
			

var level = 0
func upgrade(user: Node2D):
	if(level == 0):
		if(player_data.inventory.money >= 5):
			player_data.inventory.money -= 5
			$making_table_ui/crafting_time.wait_time -= 1
			level = 1
			$upgrade_label.visible = true
			return
	if(level == 1):
		if(player_data.inventory.money >= 10):
			player_data.inventory.money -= 10
			$making_table_ui/crafting_time.wait_time -= 1
			level = 2
			$upgrade_label.visible = true
			return
	if(level == 2):
		if(player_data.inventory.money >= 15):
			player_data.inventory.money -= 15
			$making_table_ui/crafting_time.wait_time -= 1
			level = 3
			$upgrade_label.visible = true
			return
	
	
	
func interact(user: Node2D):
	$making_table_ui.visible = true
	
func stop_interaction(user: Node2D):
	pass
	
	
func update_hand():
	var none_texture = preload("res://Art/Assets/objects/none.png")
	player_data.player.player_hand.texture = none_texture

	
func _ready():
	$Label.visible = false
	$making_table_ui.visible = false
	$upgrade_label.visible = false
	
func _on_area_entered(area):
	$Label.visible = true
	in_area = 1
	
func _on_area_exited(area):
	$Label.visible = false
	$upgrade_label.visible = false
	in_area = 0

func _process(_delta):
	if(player_data.player.is_crafting and in_area):
		$crafting_label.visible = true
	else:
		$crafting_label.visible = false
