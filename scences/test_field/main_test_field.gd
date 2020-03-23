extends Node2D



func _on_back_pressed():
	get_tree().change_scene("res://scences/Sc_test_menu.tscn")
	


func _on_quit_pressed():
	get_tree().quit()

func task_speak(task):
	print("ok")
	
	
