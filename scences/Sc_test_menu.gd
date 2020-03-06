extends Control



func _on_Button_pressed():
	get_tree().change_scene("res://scences/Control.tscn")


func _on_graphedit_pressed():
	get_tree().change_scene("res://scences/sc_graphedit_testl.tscn")
	


func _on_UI_test_pressed():
	get_tree().change_scene("res://scences/test/UI_test.tscn")


func _on_Time_test_pressed():
	get_tree().change_scene("res://text/time_test.tscn")
	
