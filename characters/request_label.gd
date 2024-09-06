extends Label

func _ready():
	text = get_child(0).request
	position.x = -11
	position.y = -16
	
func _process(delta):
	position.x = -11
	position.y = -16
