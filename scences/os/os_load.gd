extends Control



func _ready():
	$logo_play.play("logo_move")
	

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			start()
	# 如果按左键
#	if event is InputEventMouseButton:
#		if event.button_index == BUTTON_LEFT and event.pressed:
#				start()
			
func start():
	print("hi,world!")
	get_tree().change_scene("res://scences/Control.tscn")
	

