extends Sprite

var direction = Vector2(10,0)
var dot = load("res://scences/os/dot.tscn")
var dots = []

func _ready():
	pass

func _process(delta):
	var white_dot = dot.instance()
	var v_x = 0
	v_x = OS.get_screen_size().x/2
	
	position += direction 
	
	if position.x > v_x:
		position.x = 0
	
