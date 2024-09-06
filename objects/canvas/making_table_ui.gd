extends CanvasLayer

@export var table_storage : TableStorage
@export var player_data : PlayerData



var currentItem = 0
var select = 0

func _ready():
	switchItem(0)

func switchItem(select):
	for i in range(global.items.size()):
		if(select == i):
			currentItem = select
			print(global.items[currentItem])
			get_node("Control/Name").text = global.items[currentItem]["Name"]
			get_node("Control/des").text = global.items[currentItem]["Des"]
			get_node("Control/req/big/n_req").text = "/"+str(global.items[currentItem]["B_com"])
			get_node("Control/req/medium/n_req").text = "/"+str(global.items[currentItem]["M_com"])
			get_node("Control/req/small/n_req").text = "/"+str(global.items[currentItem]["S_com"])
			get_node("Control/image").texture = global.items[currentItem]["image"]
func _on_next_pressed():
	switchItem(currentItem+1)


func _on_pre_pressed():
	switchItem(currentItem-1)


func _on_make_pressed():
	if(player_data.player.is_crafting):
		return
	# sprawdzam czy w storage jest tyle co sie wyswietla
	if(table_storage.b_com >= global.items[currentItem]["B_com"] and 
	table_storage.m_com >= global.items[currentItem]["M_com"] and 
	table_storage.s_com >= global.items[currentItem]["S_com"]):
		print("moge robic")
		$crafting_time.start()
		self.visible = false
		
		
		player_data.player.velocity = Vector2(0,0)
		player_data.player.move_speed = 0
		player_data.player.is_crafting = true
	else:
		print("nie mam materialow")

func _on_crafting_timer_timeout():
	
	# jesli cos w reku to wywalam
	if(player_data.inventory.hands_string == "empty"):
		pass
	else:
		var dropped_item = player_data.player.hand_tscn.instantiate()
		player_data.player.get_parent().add_child(dropped_item)
		dropped_item.position.x = player_data.player.position.x
		dropped_item.position.y = player_data.player.position.y
	# zabieram ze storage tyle co jest current item
	table_storage.b_com -= global.items[currentItem]["B_com"]
	table_storage.m_com -= global.items[currentItem]["M_com"]
	table_storage.s_com -= global.items[currentItem]["S_com"]
	get_node("Control/req/big/n_in").text = str(table_storage.b_com)
	get_node("Control/req/medium/n_in").text = str(table_storage.m_com)
	get_node("Control/req/small/n_in").text = str(table_storage.s_com)
	# zmienic reke gracza na dany przedmiot
	# zmienic reke gracza/scene na dany przedmiot
	player_data.inventory.hands_string = global.items[currentItem]["Name"]
	update_hand_scene()
	update_hand()
	
	player_data.player.move_speed = 100
	player_data.player.is_crafting = false
	
	
func update_hand_scene():
	
	# zaladowanie zasobow w celu zmniejszeniu opoznien
	var chair_scene = preload("res://objects/resources/dropping/ready_products/chair_dropped.tscn")
	var table_scene = preload("res://objects/resources/dropping/ready_products/table_dropped.tscn")
	var wardrobe_scene = preload("res://objects/resources/dropping/ready_products/wardrobe_droppped.tscn")
	var spoon_scene = preload("res://objects/resources/dropping/ready_products/spoon_dropped.tscn")
	var item_to_make = global.items[currentItem]["Name"]
	if(item_to_make == "krzesło"):
		player_data.player.hand_tscn = chair_scene
	if(item_to_make == "stół"):
		player_data.player.hand_tscn = table_scene
	if(item_to_make == "wardrobe"):
		player_data.player.hand_tscn = wardrobe_scene
	if(item_to_make == "spoon"):
		player_data.player.hand_tscn = spoon_scene

func update_hand():
	var box_texture = preload("res://Art/Assets/objects/box.png")
	player_data.player.player_hand.texture = box_texture


func _on_exit_pressed():
	self.visible = false
