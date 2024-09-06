class_name NpcSpawner
extends Node

@export var npc_tscn: PackedScene

func _ready():
	$Spawn.start()
	
func _on_spawn_timeout():
	var new_npc = npc_tscn.instantiate()
	print(new_npc)
	if(global.fifo.is_empty()):		
		new_npc.position.x = -20
		new_npc.position.y = 0
		global.x_pos = -20
	else:
		global.x_pos -= 16
		new_npc.position.x = global.x_pos
		new_npc.position.y = 0
	global.fifo.push_back(new_npc)
	get_parent().add_child(new_npc)
	# dodawanie czasu zamowienia
	
