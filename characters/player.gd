class_name Player
extends CharacterBody2D

@export var move_speed : float = 100
@export var player_data : PlayerData # to co moze byc przekazane do innych obiektow
@export var inventory : Inventory
@export var hand_tscn: PackedScene # przedmiot w rece (jako scena)
@export var is_crafting = false

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var player_hand = $Hand/item

var input_direction : Vector2 = Vector2.ZERO


func _ready(): # przygotowanie animacji na start
	animation_tree.set("parameters/conditions/idle", true)
	var new_texture = preload("res://Art/Assets/objects/none.png")
	player_hand.texture = new_texture
	animation_tree.active = true
	call_deferred("_update_player_data")
		
func _physics_process(delta):
	#ruch
	if(!is_crafting):
		input_direction = Input.get_vector("left", "right", "up", "down").normalized()

		if input_direction:
			velocity = input_direction * move_speed * delta
		else:
			velocity = Vector2.ZERO	
	update_animation_parameters()
	move_and_collide(velocity)
	
	
## to jest fukcnak kto zmienia animcje 
func update_animation_parameters(): # zmiana animacji wzgledem kierunku
	if(velocity == Vector2.ZERO):
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/is_moving"] = false
	else:
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/is_moving"] = true

	animation_tree["parameters/idle/blend_position"] =  input_direction
	animation_tree["parameters/walk/blend_position"] =  input_direction	
	
	if(input_direction.y == -1):
		player_hand.z_index = -1
	else:
		player_hand.z_index = 0
	
func _update_player_data():
	player_data.player = self
	player_data.inventory = inventory

func _input(event : InputEvent):
	if(event.is_action_pressed("drop")):
		if(player_data.inventory.hands_string == "empty"):
			return
		else:
			var dropped_item = player_data.player.hand_tscn.instantiate()
			player_data.player.get_parent().add_child(dropped_item)
			dropped_item.position.x = player_data.player.position.x
			dropped_item.position.y = player_data.player.position.y
			player_data.inventory.hands_string = "empty"
			player_data.player.hand_tscn = null
			update_hand()
			return
	#if(player_data.inventory.hands_string == "empty"):
		#player_data.inventory.hands_string = "plank"
		#player_data.player.hand_tscn = plank_scene
	#else:
		#var dropped_item = player_data.player.hand_tscn.instantiate()
		#player_data.player.get_parent().add_child(dropped_item)
		#dropped_item.position.x = player_data.player.position.x
		#dropped_item.position.y = player_data.player.position.y
		#player_data.inventory.hands_string = "plank"
		#player_data.player.hand_tscn = plank_scene
	
	
	
func update_hand():
	var texture = preload("res://Art/Assets/objects/none.png")
	$Hand/item.texture = texture
