extends Interactable
# 1

@export var player_data: PlayerData

func interact(user: Node2D):
	if (player_data.inventory.hands_string == "empty"):
		print("pusta reka")
		if(get_parent().items_on_shelf[2]["is_occupied"] == 1):
			print("zajete")
			# aktualizacja gracza
			player_data.inventory.hands_string = get_parent().items_on_shelf[2]["hand_desc"]
			player_data.player.hand_tscn = get_parent().items_on_shelf[2]["scene"]
			# aktualizacja szafki
			get_parent().items_on_shelf[2]["is_occupied"] = 0
			get_parent().items_on_shelf[2]["hand_desc"] = "empty"
			get_parent().items_on_shelf[2]["scene"] = PackedScene
			get_child(1).queue_free()
			update_hand()
			return
		else:
			print("wolne")
			return
	else:
		print("pelna reka")
		if(player_data.inventory.hands_string == get_parent().items_on_shelf[2]["hand_desc"]):
			print("taki sam item")
			return
		else:
			print("inny item")
			# zapis stanu gracza do przekazania do szafki
			var hands_string_tmp = player_data.inventory.hands_string
			var hands_tscn_tmp = player_data.player.hand_tscn
			# aktualizacja gracza
			player_data.inventory.hands_string = get_parent().items_on_shelf[2]["hand_desc"]
			player_data.player.hand_tscn = get_parent().items_on_shelf[2]["scene"]
			# aktualizacja szafki
			if(get_parent().items_on_shelf[2]["is_occupied"] == 1):
				get_child(1).queue_free()
			get_parent().items_on_shelf[2]["hand_desc"] = hands_string_tmp
			get_parent().items_on_shelf[2]["scene"] = hands_tscn_tmp
			var item = hands_tscn_tmp.instantiate()
			self.add_child(item)
			item.position.x = 0
			item.position.y = -4
			get_parent().items_on_shelf[2]["is_occupied"] = 1
			update_hand()
			return

func stop_interaction(user: Node2D):
	pass

func update_hand():
	# zaladowac KAZDA teksture i w zaleznosci od reki dac teksture
	if(player_data.inventory.hands_string == "empty"):
		var texture = preload("res://Art/Assets/objects/none.png")
		player_data.player.player_hand.texture = texture
	if(player_data.inventory.hands_string == "big_component"):
		var texture = preload("res://Art/Assets/objects/big_component.png")
		player_data.player.player_hand.texture = texture
	if(player_data.inventory.hands_string == "medium_component"):
		var texture = preload("res://Art/Assets/objects/medium_component.png")
		player_data.player.player_hand.texture = texture
	if(player_data.inventory.hands_string == "plank"):
		var texture = preload("res://Art/Assets/objects/plank.png")
		player_data.player.player_hand.texture = texture
	if(player_data.inventory.hands_string == "shavings"):
		var texture = preload("res://Art/Assets/objects/shavings.png")
		player_data.player.player_hand.texture = texture
	if(player_data.inventory.hands_string == "small_component"):
		var texture = preload("res://Art/Assets/objects/small_component.png")
		player_data.player.player_hand.texture = texture
	if(player_data.inventory.hands_string == "wood"):
		var texture = preload("res://Art/Assets/objects/wood_pick.png")
		player_data.player.player_hand.texture = texture
	if(player_data.inventory.hands_string == "chair" or player_data.inventory.hands_string == "spoon"
	or player_data.inventory.hands_string == "table" or player_data.inventory.hands_string == "wardrobe"):
		var texture = preload("res://Art/Assets/objects/box.png")
		player_data.player.player_hand.texture = texture
