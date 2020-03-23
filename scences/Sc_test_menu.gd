extends Control

var defH = 1080
var defW = 1920

onready var screenSize = get_viewport().get_visible_rect().size

func _ready():
	
	$GraphEdit.get_zoom_hbox().visible = false
	
	var newH = screenSize.y
	
	var scale = newH / defH

	var options = get_node("GraphEdit/HBoxContainer/VBoxContainer/UI_test") #Get the buttons to resize

	options.set_scale(scale * options.get_scale()) #Scale to new resolution
	


func _on_Button_pressed():
	get_tree().change_scene("res://scences/Control.tscn")



func _on_UI_test_pressed():
	get_tree().change_scene("res://scences/text_edit/text_main.tscn")


func _on_Time_test_pressed():
	get_tree().change_scene("res://text/time_test.tscn")
	

func _on_quit_pressed():
	get_tree().quit()


func _on_State_test_pressed():
	get_tree().change_scene("res://scences/test_field/state_test1D.tscn")
	


func _on_World_test_pressed():
	get_tree().change_scene("res://3d/world_test_1.tscn")
	
