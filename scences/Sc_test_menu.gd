extends Control



func _on_Button_pressed():
	get_tree().change_scene("res://scences/Control.tscn")


func _on_graphedit_pressed():
	get_tree().change_scene("res://scences/sc_graphedit_testl.tscn")
	