extends Control

onready var screenSize = get_viewport().get_visible_rect().size

var defH = 1080
var defW = 1920

func _ready():
	#OS.set_window_maximized(true)
	#OS.get_screen_size()
	print(OS.get_screen_size())
	print(screenSize)
	$ColorRect.rect_size = OS.get_screen_size()
	$"8gua/8gua_roll".play("8_roll")

	
func _process(delta):
	pass

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			start()
			
func start():
	get_tree().change_scene("res://scences/Sc_test_menu.tscn")
	

