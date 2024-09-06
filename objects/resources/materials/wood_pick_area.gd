extends Interactable

@export var player_data : PlayerData

var wood_scene = preload("res://objects/resources/dropping/wood_dropped.tscn")

func _ready():
	$wood_buy_ui.visible = false
	$options.visible = false


func interact(user: Node2D):
	if(player_data.inventory.hands_string == "wood" or global.wood == 0):
		return
	if(player_data.inventory.hands_string == "empty"):
		player_data.inventory.hands_string = "wood"
		player_data.player.hand_tscn = wood_scene
	else:
		var dropped_item = player_data.player.hand_tscn.instantiate()
		player_data.player.get_parent().add_child(dropped_item)
		dropped_item.position.x = player_data.player.position.x
		dropped_item.position.y = player_data.player.position.y
		player_data.inventory.hands_string = "wood"
		player_data.player.hand_tscn = wood_scene
		# zmieniam na wood jak puste ale dodatkowo wywalem item z reki i daje na ziemie
	global.wood -= 1
	update_hand()
	
func buy(user: Node2D):
	$wood_buy_ui.visible = true
	
func stop_interaction(user: Node2D):
	pass
	
func update_hand():
	var wood_texture = preload("res://Art/Assets/objects/wood_pick.png")
	player_data.player.player_hand.texture = wood_texture


func _on_area_exited(area):
	$wood_buy_ui.visible = false
	$options.visible = false


func _on_area_entered(area):
	$options.visible = true
	
func _process(_delta):
	$wood_amount.text = "[" + str(global.wood) + "]"
