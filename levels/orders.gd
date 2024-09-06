class_name Orders
extends Interactable

@export var player_data : PlayerData

@export var x: int = 1

func _ready():
	$Label.visible = false

func interact(user: Node2D):
	if(!global.fifo.is_empty()):
		if(player_data.inventory.hands_string == global.fifo[0].get_child(2).get_child(0).request):
			print(global.fifo[0])
			global.fifo[0].queue_free()
			array_shift(global.fifo)
			change_position(global.fifo)
			global.x_pos += 15
			player_data.inventory.money += 15
			player_data.inventory.exp += 10
			player_data.inventory.hands_string = "empty"
			update_hand()
		else:
			print("nie to zamowienie")
		
	
	
func stop_interaction(user: Node2D):
	$Label.visible = false



func array_shift(array: Array):
	if(!array.is_empty()):
		for i in array.size():
			if(i == array.size()-1):
				array.pop_at(i)
			else:
				array[i] = array[i+1]
			
func change_position(array: Array):
	if(!array.is_empty()):
		for i in array.size():
			array[i].position.x += 15
			
			
func update_hand():
	var none_texture = preload("res://Art/Assets/objects/none.png")
	player_data.player.player_hand.texture = none_texture


func _on_area_entered(area):
	$Label.visible = true
