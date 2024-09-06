class_name Global
extends Node

var chair_img = preload("res://objects/canvas/sprites/chair.png")
var table_img = preload("res://objects/canvas/sprites/table.png")
var wardrobe_img = preload("res://objects/canvas/sprites/wardrobe.png")
var spoon_img = preload("res://objects/canvas/sprites/spoon.png")

var items = {
	0:{
		"Name" : "chair",
		"Des" : "it's a chair",
		"B_com" : 0,
		"M_com" : 2,
		"S_com" : 4,
		"image" : chair_img
	},
	1:{
		"Name" : "table",
		"Des" : "it's a table",
		"B_com" : 1,
		"M_com" : 3,
		"S_com" : 0,
		"image" : table_img
	},
	2:{
		"Name" : "wardrobe",
		"Des" : "it's a wardrobe",
		"B_com" : 1,
		"M_com" : 3,
		"S_com" : 4,
		"image" : wardrobe_img
	},
	3:{
		"Name" : "spoon",
		"Des" : "spoooon",
		"B_com" : 0,
		"M_com" : 0,
		"S_com" : 1,
		"image" : spoon_img
	}
}

# sceny
var chair_scene = preload("res://objects/resources/dropping/ready_products/chair_dropped.tscn")
var table_scene = preload("res://objects/resources/dropping/ready_products/table_dropped.tscn")
var wardrobe_scene = preload("res://objects/resources/dropping/ready_products/wardrobe_droppped.tscn")
var spoon_scene = preload("res://objects/resources/dropping/ready_products/spoon_dropped.tscn")

# npc
var fifo: Array
var x_pos = -20

# materialy
var wood = 10
