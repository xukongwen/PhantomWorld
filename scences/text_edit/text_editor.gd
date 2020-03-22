extends Control

onready var text_edit = get_node("Panel/VBoxContainer/CenterContainer/TextEdit")
onready var save_as_file = get_node("save_as_file")
onready var open_file = get_node("open_file")
onready var pop_menu = get_node("text_menu")

var app_name = "Phantom Text Editor"
const UNTITLE = 'untitled'
var current_name = UNTITLE
var IsMouseInTexteditoer = false

func _ready():
	pop_menu.connect("id_pressed",self,"_on_item_pressed")
	
	
func _input(event):
	if IsMouseInTexteditoer and \
	event is InputEventMouseButton \
	and event.button_index == BUTTON_RIGHT \
	and event.pressed:
		pop_menu.popup()
		pop_menu.rect_position = event.position
		
func _on_item_pressed(id):
	if pop_menu.get_item_text(id) == "新建":
		new_file()
		
	if pop_menu.get_item_text(id) == "打开":
		open_file.popup()
		
	elif pop_menu.get_item_text(id) == "储存":
		save_file()
		
	elif pop_menu.get_item_text(id) == "另存":
		save_as_file.popup()
		
	elif pop_menu.get_item_text(id) == "返回":
		get_tree().change_scene("res://scences/Sc_test_menu.tscn")
		

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


func _on_CenterContainer_mouse_entered():
	IsMouseInTexteditoer = true

func _on_CenterContainer_mouse_exited():
	IsMouseInTexteditoer = false
