extends Node2D

var Mouse_p

func _process(delta):
	Mouse_p = get_local_mouse_position()
	rotation += Mouse_p.angle()*0.1
