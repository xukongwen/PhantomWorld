extends Control

onready var new = get_node("Panel/VBoxContainer/HBoxContainer/new")
onready var open = get_node("Panel/VBoxContainer/HBoxContainer/open")
onready var save = get_node("Panel/VBoxContainer/HBoxContainer/save")
onready var save_as = get_node("Panel/VBoxContainer/HBoxContainer/save_as")
onready var back = get_node("Panel/VBoxContainer/HBoxContainer/back")
onready var text_edit = get_node("Panel/VBoxContainer/CenterContainer/TextEdit")
onready var save_as_file = get_node("Panel/VBoxContainer/HBoxContainer/save_as/save_as_file")
onready var open_file = get_node("Panel/VBoxContainer/HBoxContainer/open/open_file")

var app_name = "Phantom Text Editor"
const UNTITLE = 'untitled'
var current_name = UNTITLE

func _ready():
	pass

func update_title():
	OS.set_window_title(app_name + "-" + current_name)

func new_file():
	current_name = UNTITLE
	update_title()
	text_edit.text = ''
	
func _on_open_file_file_selected(path):
	var f = File.new()
	f.open(path,1)
	text_edit.text = f.get_as_text()
	f.close()
	current_name = path
	update_title()
	
	
# 储存修改
func save_file():
	var path = current_name
	if path == UNTITLE:
		save_as_file.popup()
		
	else:
		var f = File.new()
		f.open(path,2)
		f.store_string(text_edit.text)
		f.close()
		update_title()


func _on_save_as_file_file_selected(path):
	var f = File.new()
	f.open(path,2)
	f.store_string(text_edit.text)
	f.close()
	current_name = path
	update_title()


func _on_open_pressed():
	open_file.popup()


func _on_new_pressed():
	new_file()


func _on_save_as_pressed():
	save_as_file.popup()


func _on_save_pressed():
	save_file()


func _on_back_pressed():
	get_tree().change_scene("res://scences/Sc_test_menu.tscn")
	
