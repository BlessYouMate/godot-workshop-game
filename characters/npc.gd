extends CharacterBody2D

@export var player_data: PlayerData

func _ready():
	$waiting.start()

func _on_waiting_timeout():
	if(!global.fifo.is_empty()):
		print(global.fifo[0])
		global.fifo[0].queue_free()
		array_shift(global.fifo)
		change_position(global.fifo)
		global.x_pos += 16
	player_data.inventory.money -= 3

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
			array[i].position.x += 16
