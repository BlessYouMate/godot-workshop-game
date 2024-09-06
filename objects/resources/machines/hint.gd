extends Sprite2D

var p_to_b = preload("res://Art/Assets/hints/plank-Bcomponent.png")
var b_to_m = preload("res://Art/Assets/hints/B-M.png")
var m_to_s = preload("res://Art/Assets/hints/M-S.png")
var s_to_s = preload("res://Art/Assets/hints/S-S.png")

var textures = [p_to_b, b_to_m, m_to_s, s_to_s]
var i = 0

func _on_timer_timeout():
	i += 1
	if(i==4):
		i = 0
	self.texture = textures[i]
