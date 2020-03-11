extends Control


func _ready():
	$"8gua/8gua_roll".play("8_roll")

	
func _process(delta):
	pass

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
	

