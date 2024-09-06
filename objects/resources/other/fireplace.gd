extends Interactable


@export var player_data : PlayerData
func _ready():
	$Label.visible = false
	
func interact(user: Node2D):
	player_data.inventory.hands_string = "empty"
	update_hand()

func stop_interaction(user: Node2D):
	$Label.visible = false

func update_hand():
	var none_texture = preload("res://Art/Assets/objects/none.png")
	player_data.player.player_hand.texture = none_texture


func _on_area_entered(area):
	$Label.visible = true
